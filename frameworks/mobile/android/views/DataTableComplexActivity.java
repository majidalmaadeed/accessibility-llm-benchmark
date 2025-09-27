package com.accessibilityapp;

import android.app.Activity;
import android.os.Bundle;
import android.view.View;
import android.widget.*;
import android.widget.AdapterView.OnItemClickListener;
import android.widget.AdapterView.OnItemSelectedListener;
import android.widget.CompoundButton.OnCheckedChangeListener;
import android.graphics.Color;
import android.graphics.Typeface;
import android.text.TextWatcher;
import android.text.Editable;
import android.view.LayoutInflater;
import android.view.ViewGroup;
import android.widget.LinearLayout;
import java.util.*;
import java.text.SimpleDateFormat;
import java.util.Date;

public class DataTableComplexActivity extends Activity {
    
    private ListView dataTable;
    private EditText searchInput;
    private Spinner sortSpinner;
    private Spinner filterSpinner;
    private CheckBox selectAllCheckbox;
    private Button exportButton;
    private Button deleteButton;
    private TextView resultCount;
    private LinearLayout paginationContainer;
    private ProgressBar loadingIndicator;
    
    private List<Employee> allEmployees;
    private List<Employee> filteredEmployees;
    private EmployeeAdapter adapter;
    private Set<Integer> selectedItems;
    private String currentSort = "name";
    private String currentFilter = "all";
    private int currentPage = 1;
    private int itemsPerPage = 10;
    
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_data_table_complex);
        
        initializeViews();
        setupData();
        setupListeners();
        updateDisplay();
    }
    
    private void initializeViews() {
        dataTable = findViewById(R.id.dataTable);
        searchInput = findViewById(R.id.searchInput);
        sortSpinner = findViewById(R.id.sortSpinner);
        filterSpinner = findViewById(R.id.filterSpinner);
        selectAllCheckbox = findViewById(R.id.selectAllCheckbox);
        exportButton = findViewById(R.id.exportButton);
        deleteButton = findViewById(R.id.deleteButton);
        resultCount = findViewById(R.id.resultCount);
        paginationContainer = findViewById(R.id.paginationContainer);
        loadingIndicator = findViewById(R.id.loadingIndicator);
        
        selectedItems = new HashSet<>();
        
        // Setup spinners
        setupSortSpinner();
        setupFilterSpinner();
    }
    
    private void setupSortSpinner() {
        String[] sortOptions = {"Name", "Department", "Salary", "Hire Date"};
        ArrayAdapter<String> sortAdapter = new ArrayAdapter<>(this, 
            android.R.layout.simple_spinner_item, sortOptions);
        sortAdapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
        sortSpinner.setAdapter(sortAdapter);
    }
    
    private void setupFilterSpinner() {
        String[] filterOptions = {"All Departments", "Engineering", "Marketing", "Sales", "HR"};
        ArrayAdapter<String> filterAdapter = new ArrayAdapter<>(this, 
            android.R.layout.simple_spinner_item, filterOptions);
        filterAdapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
        filterSpinner.setAdapter(filterAdapter);
    }
    
    private void setupData() {
        allEmployees = new ArrayList<>();
        allEmployees.add(new Employee(1, "John Smith", "Engineering", 75000, "2023-01-15", "Senior Developer"));
        allEmployees.add(new Employee(2, "Sarah Johnson", "Marketing", 65000, "2023-02-20", "Marketing Manager"));
        allEmployees.add(new Employee(3, "Mike Chen", "Engineering", 80000, "2022-11-10", "Lead Developer"));
        allEmployees.add(new Employee(4, "Emily Davis", "Sales", 70000, "2023-03-05", "Sales Director"));
        allEmployees.add(new Employee(5, "David Wilson", "HR", 60000, "2023-01-30", "HR Specialist"));
        allEmployees.add(new Employee(6, "Lisa Brown", "Engineering", 72000, "2022-12-15", "Software Engineer"));
        allEmployees.add(new Employee(7, "Tom Anderson", "Marketing", 68000, "2023-04-10", "Content Manager"));
        allEmployees.add(new Employee(8, "Anna Garcia", "Sales", 75000, "2022-10-25", "Account Manager"));
        allEmployees.add(new Employee(9, "Chris Lee", "Engineering", 85000, "2022-09-12", "Principal Engineer"));
        allEmployees.add(new Employee(10, "Maria Rodriguez", "HR", 62000, "2023-02-28", "Recruiter"));
        
        filteredEmployees = new ArrayList<>(allEmployees);
        adapter = new EmployeeAdapter(this, filteredEmployees);
        dataTable.setAdapter(adapter);
    }
    
    private void setupListeners() {
        searchInput.addTextChangedListener(new TextWatcher() {
            @Override
            public void beforeTextChanged(CharSequence s, int start, int count, int after) {}
            
            @Override
            public void onTextChanged(CharSequence s, int start, int before, int count) {
                filterData();
            }
            
            @Override
            public void afterTextChanged(Editable s) {}
        });
        
        sortSpinner.setOnItemSelectedListener(new OnItemSelectedListener() {
            @Override
            public void onItemSelected(AdapterView<?> parent, View view, int position, long id) {
                String[] sortValues = {"name", "department", "salary", "hireDate"};
                currentSort = sortValues[position];
                sortData();
            }
            
            @Override
            public void onNothingSelected(AdapterView<?> parent) {}
        });
        
        filterSpinner.setOnItemSelectedListener(new OnItemSelectedListener() {
            @Override
            public void onItemSelected(AdapterView<?> parent, View view, int position, long id) {
                String[] filterValues = {"all", "Engineering", "Marketing", "Sales", "HR"};
                currentFilter = filterValues[position];
                filterData();
            }
            
            @Override
            public void onNothingSelected(AdapterView<?> parent) {}
        });
        
        selectAllCheckbox.setOnCheckedChangeListener(new OnCheckedChangeListener() {
            @Override
            public void onCheckedChanged(CompoundButton buttonView, boolean isChecked) {
                if (isChecked) {
                    selectedItems.clear();
                    for (int i = 0; i < filteredEmployees.size(); i++) {
                        selectedItems.add(filteredEmployees.get(i).getId());
                    }
                } else {
                    selectedItems.clear();
                }
                adapter.notifyDataSetChanged();
                updateActionButtons();
            }
        });
        
        exportButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                exportSelectedData();
            }
        });
        
        deleteButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                deleteSelectedData();
            }
        });
    }
    
    private void filterData() {
        String query = searchInput.getText().toString().toLowerCase();
        filteredEmployees.clear();
        
        for (Employee employee : allEmployees) {
            boolean matchesSearch = employee.getName().toLowerCase().contains(query) ||
                                  employee.getDepartment().toLowerCase().contains(query) ||
                                  employee.getPosition().toLowerCase().contains(query);
            
            boolean matchesFilter = currentFilter.equals("all") || 
                                  employee.getDepartment().equals(currentFilter);
            
            if (matchesSearch && matchesFilter) {
                filteredEmployees.add(employee);
            }
        }
        
        sortData();
    }
    
    private void sortData() {
        Collections.sort(filteredEmployees, new Comparator<Employee>() {
            @Override
            public int compare(Employee a, Employee b) {
                switch (currentSort) {
                    case "name":
                        return a.getName().compareTo(b.getName());
                    case "department":
                        return a.getDepartment().compareTo(b.getDepartment());
                    case "salary":
                        return Integer.compare(b.getSalary(), a.getSalary());
                    case "hireDate":
                        return b.getHireDate().compareTo(a.getHireDate());
                    default:
                        return 0;
                }
            }
        });
        
        updateDisplay();
    }
    
    private void updateDisplay() {
        adapter.notifyDataSetChanged();
        updatePagination();
        updateResultCount();
        updateActionButtons();
    }
    
    private void updatePagination() {
        paginationContainer.removeAllViews();
        
        int totalPages = (int) Math.ceil((double) filteredEmployees.size() / itemsPerPage);
        
        if (totalPages <= 1) return;
        
        // Previous button
        Button prevButton = new Button(this);
        prevButton.setText("Previous");
        prevButton.setEnabled(currentPage > 1);
        prevButton.setOnClickListener(v -> {
            if (currentPage > 1) {
                currentPage--;
                updateDisplay();
            }
        });
        paginationContainer.addView(prevButton);
        
        // Page numbers
        for (int i = 1; i <= totalPages; i++) {
            Button pageButton = new Button(this);
            pageButton.setText(String.valueOf(i));
            pageButton.setEnabled(i != currentPage);
            if (i == currentPage) {
                pageButton.setBackgroundColor(Color.BLUE);
                pageButton.setTextColor(Color.WHITE);
            }
            pageButton.setOnClickListener(v -> {
                currentPage = i;
                updateDisplay();
            });
            paginationContainer.addView(pageButton);
        }
        
        // Next button
        Button nextButton = new Button(this);
        nextButton.setText("Next");
        nextButton.setEnabled(currentPage < totalPages);
        nextButton.setOnClickListener(v -> {
            if (currentPage < totalPages) {
                currentPage++;
                updateDisplay();
            }
        });
        paginationContainer.addView(nextButton);
    }
    
    private void updateResultCount() {
        resultCount.setText("Showing " + filteredEmployees.size() + " of " + allEmployees.size() + " employees");
    }
    
    private void updateActionButtons() {
        boolean hasSelection = !selectedItems.isEmpty();
        exportButton.setEnabled(hasSelection);
        deleteButton.setEnabled(hasSelection);
    }
    
    private void exportSelectedData() {
        // Simulate export functionality
        Toast.makeText(this, "Exporting " + selectedItems.size() + " selected employees", Toast.LENGTH_SHORT).show();
    }
    
    private void deleteSelectedData() {
        // Simulate delete functionality
        Toast.makeText(this, "Deleting " + selectedItems.size() + " selected employees", Toast.LENGTH_SHORT).show();
    }
    
    public void toggleItemSelection(int employeeId) {
        if (selectedItems.contains(employeeId)) {
            selectedItems.remove(employeeId);
        } else {
            selectedItems.add(employeeId);
        }
        adapter.notifyDataSetChanged();
        updateActionButtons();
    }
    
    public boolean isItemSelected(int employeeId) {
        return selectedItems.contains(employeeId);
    }
    
    // Employee data class
    public static class Employee {
        private int id;
        private String name;
        private String department;
        private int salary;
        private String hireDate;
        private String position;
        
        public Employee(int id, String name, String department, int salary, String hireDate, String position) {
            this.id = id;
            this.name = name;
            this.department = department;
            this.salary = salary;
            this.hireDate = hireDate;
            this.position = position;
        }
        
        // Getters
        public int getId() { return id; }
        public String getName() { return name; }
        public String getDepartment() { return department; }
        public int getSalary() { return salary; }
        public String getHireDate() { return hireDate; }
        public String getPosition() { return position; }
    }
    
    // Custom adapter for the ListView
    private class EmployeeAdapter extends BaseAdapter {
        private Activity context;
        private List<Employee> employees;
        
        public EmployeeAdapter(Activity context, List<Employee> employees) {
            this.context = context;
            this.employees = employees;
        }
        
        @Override
        public int getCount() {
            return employees.size();
        }
        
        @Override
        public Object getItem(int position) {
            return employees.get(position);
        }
        
        @Override
        public long getItemId(int position) {
            return employees.get(position).getId();
        }
        
        @Override
        public View getView(int position, View convertView, ViewGroup parent) {
            if (convertView == null) {
                LayoutInflater inflater = context.getLayoutInflater();
                convertView = inflater.inflate(R.layout.item_employee, null);
            }
            
            Employee employee = employees.get(position);
            
            CheckBox selectCheckbox = convertView.findViewById(R.id.selectCheckbox);
            TextView nameText = convertView.findViewById(R.id.nameText);
            TextView departmentText = convertView.findViewById(R.id.departmentText);
            TextView salaryText = convertView.findViewById(R.id.salaryText);
            TextView hireDateText = convertView.findViewById(R.id.hireDateText);
            TextView positionText = convertView.findViewById(R.id.positionText);
            
            selectCheckbox.setChecked(isItemSelected(employee.getId()));
            selectCheckbox.setOnCheckedChangeListener((buttonView, isChecked) -> {
                toggleItemSelection(employee.getId());
            });
            
            nameText.setText(employee.getName());
            departmentText.setText(employee.getDepartment());
            salaryText.setText("$" + String.format("%,d", employee.getSalary()));
            hireDateText.setText(employee.getHireDate());
            positionText.setText(employee.getPosition());
            
            return convertView;
        }
    }
}

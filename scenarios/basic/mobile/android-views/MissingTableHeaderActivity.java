package com.example.accessibilityscenarios;

import android.app.Activity;
import android.os.Bundle;
import android.view.View;
import android.widget.LinearLayout;
import android.widget.ScrollView;
import android.widget.TextView;

public class MissingTableHeaderActivity extends Activity {
    
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        
        // Create main layout
        ScrollView scrollView = new ScrollView(this);
        LinearLayout mainLayout = new LinearLayout(this);
        mainLayout.setOrientation(LinearLayout.VERTICAL);
        mainLayout.setPadding(32, 32, 32, 32);
        mainLayout.setBackgroundColor(0xFFF5F5F5);
        
        // Header
        LinearLayout headerLayout = createHeader();
        mainLayout.addView(headerLayout);
        
        // Data Table - Missing proper headers
        LinearLayout tableLayout = createDataTable();
        mainLayout.addView(tableLayout);
        
        scrollView.addView(mainLayout);
        setContentView(scrollView);
    }
    
    private LinearLayout createHeader() {
        LinearLayout headerLayout = new LinearLayout(this);
        headerLayout.setOrientation(LinearLayout.VERTICAL);
        headerLayout.setBackgroundColor(0xFF2196F3);
        headerLayout.setPadding(32, 32, 32, 32);
        
        TextView titleText = new TextView(this);
        titleText.setText("Employee Directory");
        titleText.setTextSize(24);
        titleText.setTextColor(0xFFFFFFFF);
        titleText.setTypeface(null, android.graphics.Typeface.BOLD);
        
        TextView subtitleText = new TextView(this);
        subtitleText.setText("Company employee information");
        subtitleText.setTextSize(16);
        subtitleText.setTextColor(0xE6FFFFFF);
        
        headerLayout.addView(titleText);
        headerLayout.addView(subtitleText);
        
        return headerLayout;
    }
    
    private LinearLayout createDataTable() {
        LinearLayout tableLayout = new LinearLayout(this);
        tableLayout.setOrientation(LinearLayout.VERTICAL);
        tableLayout.setBackgroundColor(0xFFFFFFFF);
        tableLayout.setPadding(16, 16, 16, 16);
        
        TextView tableTitle = new TextView(this);
        tableTitle.setText("Employee Data");
        tableTitle.setTextSize(18);
        tableTitle.setTypeface(null, android.graphics.Typeface.BOLD);
        tableTitle.setPadding(0, 0, 0, 16);
        
        tableLayout.addView(tableTitle);
        
        // Table Header - Using regular Text instead of proper table headers
        LinearLayout headerRow = new LinearLayout(this);
        headerRow.setOrientation(LinearLayout.HORIZONTAL);
        headerRow.setBackgroundColor(0xFFE3F2FD);
        headerRow.setPadding(12, 12, 12, 12);
        
        // MISSING: Should use proper table header elements
        TextView nameHeader = new TextView(this);
        nameHeader.setText("Name");
        nameHeader.setTextSize(14);
        nameHeader.setTypeface(null, android.graphics.Typeface.BOLD);
        nameHeader.setTextColor(0xFF1976D2);
        
        TextView deptHeader = new TextView(this);
        deptHeader.setText("Department");
        deptHeader.setTextSize(14);
        deptHeader.setTypeface(null, android.graphics.Typeface.BOLD);
        deptHeader.setTextColor(0xFF1976D2);
        
        TextView posHeader = new TextView(this);
        posHeader.setText("Position");
        posHeader.setTextSize(14);
        posHeader.setTypeface(null, android.graphics.Typeface.BOLD);
        posHeader.setTextColor(0xFF1976D2);
        
        TextView salHeader = new TextView(this);
        salHeader.setText("Salary");
        salHeader.setTextSize(14);
        salHeader.setTypeface(null, android.graphics.Typeface.BOLD);
        salHeader.setTextColor(0xFF1976D2);
        
        LinearLayout.LayoutParams headerParams = new LinearLayout.LayoutParams(0, 
            LinearLayout.LayoutParams.WRAP_CONTENT, 1.0f);
        headerRow.addView(nameHeader, headerParams);
        headerRow.addView(deptHeader, headerParams);
        headerRow.addView(posHeader, headerParams);
        headerRow.addView(salHeader, headerParams);
        
        tableLayout.addView(headerRow);
        
        // Table Rows
        String[][] employees = {
            {"John Smith", "Engineering", "Senior Developer", "$85,000"},
            {"Sarah Johnson", "Marketing", "Marketing Manager", "$72,000"},
            {"Mike Chen", "Engineering", "DevOps Engineer", "$78,000"},
            {"Emily Davis", "HR", "HR Specialist", "$65,000"},
            {"David Wilson", "Sales", "Sales Director", "$95,000"}
        };
        
        for (String[] employee : employees) {
            LinearLayout employeeRow = createEmployeeRow(employee[0], employee[1], employee[2], employee[3]);
            tableLayout.addView(employeeRow);
        }
        
        return tableLayout;
    }
    
    private LinearLayout createEmployeeRow(String name, String department, String position, String salary) {
        LinearLayout rowLayout = new LinearLayout(this);
        rowLayout.setOrientation(LinearLayout.HORIZONTAL);
        rowLayout.setBackgroundColor(0xFFFFFFFF);
        rowLayout.setPadding(12, 12, 12, 12);
        
        // Employee Name
        LinearLayout nameLayout = new LinearLayout(this);
        nameLayout.setOrientation(LinearLayout.VERTICAL);
        
        TextView nameText = new TextView(this);
        nameText.setText(name);
        nameText.setTextSize(14);
        nameText.setTypeface(null, android.graphics.Typeface.BOLD);
        
        TextView idText = new TextView(this);
        idText.setText("ID: 12345");
        idText.setTextSize(12);
        idText.setTextColor(0xFF666666);
        
        nameLayout.addView(nameText);
        nameLayout.addView(idText);
        
        // Department
        TextView deptText = new TextView(this);
        deptText.setText(department);
        deptText.setTextSize(14);
        deptText.setTextColor(0xFF666666);
        deptText.setGravity(android.view.Gravity.CENTER);
        
        // Position
        TextView posText = new TextView(this);
        posText.setText(position);
        posText.setTextSize(14);
        posText.setTextColor(0xFF666666);
        posText.setGravity(android.view.Gravity.CENTER);
        
        // Salary
        TextView salText = new TextView(this);
        salText.setText(salary);
        salText.setTextSize(14);
        salText.setTypeface(null, android.graphics.Typeface.BOLD);
        salText.setTextColor(0xFF4CAF50);
        salText.setGravity(android.view.Gravity.END);
        
        LinearLayout.LayoutParams nameParams = new LinearLayout.LayoutParams(0, 
            LinearLayout.LayoutParams.WRAP_CONTENT, 1.0f);
        rowLayout.addView(nameLayout, nameParams);
        
        LinearLayout.LayoutParams deptParams = new LinearLayout.LayoutParams(0, 
            LinearLayout.LayoutParams.WRAP_CONTENT, 1.0f);
        rowLayout.addView(deptText, deptParams);
        
        LinearLayout.LayoutParams posParams = new LinearLayout.LayoutParams(0, 
            LinearLayout.LayoutParams.WRAP_CONTENT, 1.0f);
        rowLayout.addView(posText, posParams);
        
        LinearLayout.LayoutParams salParams = new LinearLayout.LayoutParams(0, 
            LinearLayout.LayoutParams.WRAP_CONTENT, 1.0f);
        rowLayout.addView(salText, salParams);
        
        return rowLayout;
    }
}

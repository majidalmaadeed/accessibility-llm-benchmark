package com.example.accessibility;

import android.os.Bundle;
import android.view.View;
import android.view.ViewGroup;
import android.widget.*;
import androidx.appcompat.app.AppCompatActivity;
import androidx.recyclerview.widget.GridLayoutManager;
import androidx.recyclerview.widget.RecyclerView;
import java.util.*;

public class CustomDropdownNavigationActivity extends AppCompatActivity {
    
    private boolean isOpen = false;
    private String selectedValue = "all";
    private String selectedText = "All Categories";
    private int currentIndex = 0;
    
    private List<Option> options;
    private Map<String, List<Product>> products;
    
    private Button dropdownButton;
    private ListView dropdownList;
    private RecyclerView resultsRecyclerView;
    private ProductAdapter productAdapter;
    
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_custom_dropdown_navigation);
        
        initializeData();
        setupViews();
        updateResults();
    }
    
    private void initializeData() {
        options = Arrays.asList(
            new Option("all", "All Categories"),
            new Option("electronics", "Electronics"),
            new Option("clothing", "Clothing"),
            new Option("books", "Books"),
            new Option("home", "Home & Garden")
        );
        
        products = new HashMap<>();
        products.put("all", Arrays.asList(
            new Product("iPhone 15", "Electronics"),
            new Product("MacBook Pro", "Electronics"),
            new Product("Cotton T-Shirt", "Clothing"),
            new Product("JavaScript Guide", "Books"),
            new Product("Garden Tools", "Home & Garden")
        ));
        products.put("electronics", Arrays.asList(
            new Product("iPhone 15", "Electronics"),
            new Product("MacBook Pro", "Electronics")
        ));
        products.put("clothing", Arrays.asList(
            new Product("Cotton T-Shirt", "Clothing")
        ));
        products.put("books", Arrays.asList(
            new Product("JavaScript Guide", "Books")
        ));
        products.put("home", Arrays.asList(
            new Product("Garden Tools", "Home & Garden")
        ));
    }
    
    private void setupViews() {
        dropdownButton = findViewById(R.id.dropdown_button);
        dropdownList = findViewById(R.id.dropdown_list);
        resultsRecyclerView = findViewById(R.id.results_recycler_view);
        
        // Setup dropdown button
        dropdownButton.setText(selectedText);
        dropdownButton.setOnClickListener(v -> toggleDropdown());
        
        // Setup dropdown list
        ArrayAdapter<Option> adapter = new ArrayAdapter<Option>(this, android.R.layout.simple_list_item_1, options) {
            @Override
            public View getView(int position, View convertView, ViewGroup parent) {
                View view = super.getView(position, convertView, parent);
                TextView textView = (TextView) view;
                
                Option option = options.get(position);
                textView.setText(option.getText());
                
                if (selectedValue.equals(option.getValue())) {
                    view.setBackgroundColor(getResources().getColor(android.R.color.holo_blue_bright));
                    textView.setTextColor(getResources().getColor(android.R.color.white));
                } else {
                    view.setBackgroundColor(getResources().getColor(android.R.color.transparent));
                    textView.setTextColor(getResources().getColor(android.R.color.black));
                }
                
                return view;
            }
        };
        
        dropdownList.setAdapter(adapter);
        dropdownList.setOnItemClickListener((parent, view, position, id) -> {
            Option option = options.get(position);
            selectOption(option.getValue(), option.getText(), position);
        });
        
        // Setup results recycler view
        resultsRecyclerView.setLayoutManager(new GridLayoutManager(this, 2));
        productAdapter = new ProductAdapter();
        resultsRecyclerView.setAdapter(productAdapter);
        
        // Initially hide dropdown
        dropdownList.setVisibility(View.GONE);
    }
    
    
    private void toggleDropdown() {
        isOpen = !isOpen;
        dropdownList.setVisibility(isOpen ? View.VISIBLE : View.GONE);
        
        if (isOpen) {
            dropdownButton.setBackgroundColor(getResources().getColor(android.R.color.holo_blue_light));
        } else {
            dropdownButton.setBackgroundColor(getResources().getColor(android.R.color.white));
        }
    }
    
    private void selectOption(String value, String text, int index) {
        selectedValue = value;
        selectedText = text;
        currentIndex = index;
        
        dropdownButton.setText(selectedText);
        
        toggleDropdown();
        updateResults();
        
    }
    
    private void updateResults() {
        List<Product> filteredProducts = products.get(selectedValue);
        if (filteredProducts != null) {
            productAdapter.updateProducts(filteredProducts);
        }
    }
    
    // Product Adapter
    private class ProductAdapter extends RecyclerView.Adapter<ProductAdapter.ProductViewHolder> {
        private List<Product> products = new ArrayList<>();
        
        public void updateProducts(List<Product> newProducts) {
            this.products = newProducts;
            notifyDataSetChanged();
        }
        
        @Override
        public ProductViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
            View view = getLayoutInflater().inflate(R.layout.item_product, parent, false);
            return new ProductViewHolder(view);
        }
        
        @Override
        public void onBindViewHolder(ProductViewHolder holder, int position) {
            Product product = products.get(position);
            holder.bind(product);
        }
        
        @Override
        public int getItemCount() {
            return products.size();
        }
        
        class ProductViewHolder extends RecyclerView.ViewHolder {
            private TextView nameTextView;
            private TextView categoryTextView;
            
            public ProductViewHolder(View itemView) {
                super(itemView);
                nameTextView = itemView.findViewById(R.id.product_name);
                categoryTextView = itemView.findViewById(R.id.product_category);
            }
            
            public void bind(Product product) {
                nameTextView.setText(product.getName());
                categoryTextView.setText(product.getCategory());
                
            }
        }
    }
    
    // Data classes
    public static class Option {
        private String value;
        private String text;
        
        public Option(String value, String text) {
            this.value = value;
            this.text = text;
        }
        
        public String getValue() { return value; }
        public String getText() { return text; }
        
        @Override
        public String toString() {
            return text;
        }
    }
    
    public static class Product {
        private String name;
        private String category;
        
        public Product(String name, String category) {
            this.name = name;
            this.category = category;
        }
        
        public String getName() { return name; }
        public String getCategory() { return category; }
    }
}
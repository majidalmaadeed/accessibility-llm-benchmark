package com.example.accessibilitybenchmark;

import android.app.AlertDialog;
import android.content.Context;
import android.os.Bundle;
import android.text.TextUtils;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.*;
import androidx.appcompat.app.AppCompatActivity;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;
import java.util.ArrayList;
import java.util.List;

public class ComplexSearchInterface extends AppCompatActivity {
    
    private SearchView searchView;
    private RecyclerView filtersRecyclerView;
    private Spinner sortSpinner;
    private Spinner viewModeSpinner;
    private RecyclerView resultsRecyclerView;
    private ProgressBar loadingIndicator;
    private TextView emptyStateText;
    private Button clearFiltersButton;
    
    private List<SearchResult> searchResults = new ArrayList<>();
    private List<SearchResult> allResults = new ArrayList<>();
    private List<Filter> filters = new ArrayList<>();
    private List<String> selectedFilters = new ArrayList<>();
    private String currentSort = "relevance";
    private String currentViewMode = "list";
    private String selectedCategory = "All";
    private boolean isLoading = false;
    
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_complex_search);
        
        initializeViews();
        setupFilters();
        setupSpinners();
        loadSampleData();
    }
    
    private void initializeViews() {
        searchView = findViewById(R.id.searchView);
        filtersRecyclerView = findViewById(R.id.filtersRecyclerView);
        sortSpinner = findViewById(R.id.sortSpinner);
        viewModeSpinner = findViewById(R.id.viewModeSpinner);
        resultsRecyclerView = findViewById(R.id.resultsRecyclerView);
        loadingIndicator = findViewById(R.id.loadingIndicator);
        emptyStateText = findViewById(R.id.emptyStateText);
        clearFiltersButton = findViewById(R.id.clearFiltersButton);
        
        // Setup RecyclerViews
        filtersRecyclerView.setLayoutManager(new LinearLayoutManager(this, LinearLayoutManager.HORIZONTAL, false));
        resultsRecyclerView.setLayoutManager(new LinearLayoutManager(this));
        
        // Setup search
        searchView.setOnQueryTextListener(new SearchView.OnQueryTextListener() {
            @Override
            public boolean onQueryTextSubmit(String query) {
                performSearch(query);
                return true;
            }
            
            @Override
            public boolean onQueryTextChange(String newText) {
                performSearch(newText);
                return true;
            }
        });
        
        clearFiltersButton.setOnClickListener(v -> clearAllFilters());
    }
    
    private void setupFilters() {
        filters.add(new Filter("recent", "Recent", "date"));
        filters.add(new Filter("large", "Large Files", "size"));
        filters.add(new Filter("images", "Images Only", "type"));
        filters.add(new Filter("videos", "Videos Only", "type"));
        filters.add(new Filter("documents", "Documents Only", "type"));
        filters.add(new Filter("free", "Free", "price"));
        filters.add(new Filter("premium", "Premium", "price"));
        
        FilterAdapter filterAdapter = new FilterAdapter(filters, this::onFilterToggle);
        filtersRecyclerView.setAdapter(filterAdapter);
    }
    
    private void setupSpinners() {
        // Sort spinner
        String[] sortOptions = {"relevance", "date", "name", "size", "type", "rating"};
        ArrayAdapter<String> sortAdapter = new ArrayAdapter<>(this, android.R.layout.simple_spinner_item, sortOptions);
        sortAdapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
        sortSpinner.setAdapter(sortAdapter);
        
        sortSpinner.setOnItemSelectedListener(new AdapterView.OnItemSelectedListener() {
            @Override
            public void onItemSelected(AdapterView<?> parent, View view, int position, long id) {
                currentSort = sortOptions[position];
                performSearch(searchView.getQuery().toString());
            }
            
            @Override
            public void onNothingSelected(AdapterView<?> parent) {}
        });
        
        // View mode spinner
        String[] viewModes = {"list", "grid", "compact"};
        ArrayAdapter<String> viewModeAdapter = new ArrayAdapter<>(this, android.R.layout.simple_spinner_item, viewModes);
        viewModeAdapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
        viewModeSpinner.setAdapter(viewModeAdapter);
        
        viewModeSpinner.setOnItemSelectedListener(new AdapterView.OnItemSelectedListener() {
            @Override
            public void onItemSelected(AdapterView<?> parent, View view, int position, long id) {
                currentViewMode = viewModes[position];
                // In a real implementation, this would change the view mode
            }
            
            @Override
            public void onNothingSelected(AdapterView<?> parent) {}
        });
    }
    
    private void loadSampleData() {
        allResults.add(new SearchResult(
            "1",
            "React Native Development Guide",
            "Comprehensive guide to building mobile apps with React Native",
            "document",
            "Documents",
            "2.5 MB",
            2.5,
            "2024-01-15",
            4.8,
            0.0,
            "📄",
            "https://example.com/react-native-guide"
        ));
        
        allResults.add(new SearchResult(
            "2",
            "Mobile UI Design Patterns",
            "Best practices for mobile user interface design",
            "image",
            "Images",
            "1.2 MB",
            1.2,
            "2024-01-14",
            4.6,
            29.99,
            "🖼️",
            "https://example.com/ui-patterns"
        ));
        
        allResults.add(new SearchResult(
            "3",
            "JavaScript Tutorial Series",
            "Complete JavaScript tutorial for beginners",
            "video",
            "Videos",
            "150 MB",
            150.0,
            "2024-01-13",
            4.9,
            49.99,
            "🎥",
            "https://example.com/js-tutorial"
        ));
        
        allResults.add(new SearchResult(
            "4",
            "Web Development News",
            "Latest news and updates in web development",
            "news",
            "News",
            "500 KB",
            0.5,
            "2024-01-12",
            4.3,
            0.0,
            "📰",
            "https://example.com/web-news"
        ));
        
        allResults.add(new SearchResult(
            "5",
            "E-commerce Product Catalog",
            "Complete product catalog for online store",
            "product",
            "Products",
            "5.8 MB",
            5.8,
            "2024-01-11",
            4.5,
            99.99,
            "🛍️",
            "https://example.com/product-catalog"
        ));
        
        searchResults = new ArrayList<>(allResults);
        updateResults();
    }
    
    private void performSearch(String query) {
        if (TextUtils.isEmpty(query.trim())) {
            searchResults = new ArrayList<>(allResults);
        } else {
            searchResults = new ArrayList<>();
            for (SearchResult result : allResults) {
                if (result.getTitle().toLowerCase().contains(query.toLowerCase()) ||
                    result.getDescription().toLowerCase().contains(query.toLowerCase()) ||
                    result.getCategory().toLowerCase().contains(query.toLowerCase())) {
                    searchResults.add(result);
                }
            }
        }
        
        applyFilters();
        updateResults();
    }
    
    private void applyFilters() {
        List<SearchResult> filteredResults = new ArrayList<>(searchResults);
        
        // Apply category filter
        if (!selectedCategory.equals("All")) {
            filteredResults.removeIf(result -> !result.getCategory().equals(selectedCategory));
        }
        
        // Apply selected filters
        for (String filterId : selectedFilters) {
            switch (filterId) {
                case "free":
                    filteredResults.removeIf(result -> result.getPrice() > 0);
                    break;
                case "premium":
                    filteredResults.removeIf(result -> result.getPrice() == 0);
                    break;
                case "large":
                    filteredResults.removeIf(result -> result.getSizeValue() <= 1.0);
                    break;
                case "images":
                    filteredResults.removeIf(result -> !result.getType().equals("image"));
                    break;
                case "videos":
                    filteredResults.removeIf(result -> !result.getType().equals("video"));
                    break;
                case "documents":
                    filteredResults.removeIf(result -> !result.getType().equals("document"));
                    break;
            }
        }
        
        searchResults = filteredResults;
    }
    
    private void onFilterToggle(String filterId) {
        if (selectedFilters.contains(filterId)) {
            selectedFilters.remove(filterId);
        } else {
            selectedFilters.add(filterId);
        }
        applyFilters();
        updateResults();
    }
    
    private void clearAllFilters() {
        selectedFilters.clear();
        selectedCategory = "All";
        searchView.setQuery("", false);
        searchResults = new ArrayList<>(allResults);
        updateResults();
    }
    
    private void updateResults() {
        if (searchResults.isEmpty()) {
            resultsRecyclerView.setVisibility(View.GONE);
            emptyStateText.setVisibility(View.VISIBLE);
            emptyStateText.setText("No results found\nTry adjusting your search terms or filters");
        } else {
            resultsRecyclerView.setVisibility(View.VISIBLE);
            emptyStateText.setVisibility(View.GONE);
            
            SearchResultAdapter adapter = new SearchResultAdapter(searchResults, this::onResultClick);
            resultsRecyclerView.setAdapter(adapter);
        }
    }
    
    private void onResultClick(SearchResult result) {
        AlertDialog.Builder builder = new AlertDialog.Builder(this);
        builder.setTitle(result.getTitle());
        
        StringBuilder message = new StringBuilder();
        message.append(result.getDescription()).append("\n\n");
        message.append("Type: ").append(result.getType()).append("\n");
        message.append("Category: ").append(result.getCategory()).append("\n");
        message.append("Size: ").append(result.getSize()).append("\n");
        message.append("Date: ").append(result.getDate()).append("\n");
        message.append("Rating: ").append(String.format("%.1f/5", result.getRating())).append("\n");
        message.append("Price: ").append(result.getPrice() > 0 ? 
            String.format("$%.2f", result.getPrice()) : "Free");
        
        builder.setMessage(message.toString());
        builder.setPositiveButton("Close", null);
        builder.setNegativeButton("Open", (dialog, which) -> {
            // Handle open action
        });
        builder.show();
    }
    
    // Filter Adapter
    private static class FilterAdapter extends RecyclerView.Adapter<FilterAdapter.ViewHolder> {
        private List<Filter> filters;
        private OnFilterClickListener listener;
        
        public interface OnFilterClickListener {
            void onFilterClick(String filterId);
        }
        
        public FilterAdapter(List<Filter> filters, OnFilterClickListener listener) {
            this.filters = filters;
            this.listener = listener;
        }
        
        @Override
        public ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
            View view = LayoutInflater.from(parent.getContext()).inflate(R.layout.item_filter_chip, parent, false);
            return new ViewHolder(view);
        }
        
        @Override
        public void onBindViewHolder(ViewHolder holder, int position) {
            Filter filter = filters.get(position);
            holder.bind(filter, listener);
        }
        
        @Override
        public int getItemCount() {
            return filters.size();
        }
        
        static class ViewHolder extends RecyclerView.ViewHolder {
            private Button filterButton;
            
            public ViewHolder(View itemView) {
                super(itemView);
                filterButton = itemView.findViewById(R.id.filterButton);
            }
            
            public void bind(Filter filter, OnFilterClickListener listener) {
                filterButton.setText(filter.getName());
                filterButton.setOnClickListener(v -> listener.onFilterClick(filter.getId()));
            }
        }
    }
    
    // Search Result Adapter
    private static class SearchResultAdapter extends RecyclerView.Adapter<SearchResultAdapter.ViewHolder> {
        private List<SearchResult> results;
        private OnResultClickListener listener;
        
        public interface OnResultClickListener {
            void onResultClick(SearchResult result);
        }
        
        public SearchResultAdapter(List<SearchResult> results, OnResultClickListener listener) {
            this.results = results;
            this.listener = listener;
        }
        
        @Override
        public ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
            View view = LayoutInflater.from(parent.getContext()).inflate(R.layout.item_search_result, parent, false);
            return new ViewHolder(view);
        }
        
        @Override
        public void onBindViewHolder(ViewHolder holder, int position) {
            SearchResult result = results.get(position);
            holder.bind(result, listener);
        }
        
        @Override
        public int getItemCount() {
            return results.size();
        }
        
        static class ViewHolder extends RecyclerView.ViewHolder {
            private TextView iconText;
            private TextView titleText;
            private TextView descriptionText;
            private TextView metadataText;
            private TextView priceText;
            
            public ViewHolder(View itemView) {
                super(itemView);
                iconText = itemView.findViewById(R.id.iconText);
                titleText = itemView.findViewById(R.id.titleText);
                descriptionText = itemView.findViewById(R.id.descriptionText);
                metadataText = itemView.findViewById(R.id.metadataText);
                priceText = itemView.findViewById(R.id.priceText);
            }
            
            public void bind(SearchResult result, OnResultClickListener listener) {
                iconText.setText(result.getImage());
                titleText.setText(result.getTitle());
                descriptionText.setText(result.getDescription());
                
                String metadata = result.getCategory() + " • " + result.getDate() + 
                                " • ⭐ " + String.format("%.1f", result.getRating()) + 
                                " • " + result.getSize();
                metadataText.setText(metadata);
                
                if (result.getPrice() > 0) {
                    priceText.setText("$" + String.format("%.2f", result.getPrice()));
                    priceText.setVisibility(View.VISIBLE);
                } else {
                    priceText.setText("Free");
                    priceText.setVisibility(View.VISIBLE);
                }
                
                itemView.setOnClickListener(v -> listener.onResultClick(result));
            }
        }
    }
    
    // Data classes
    public static class Filter {
        private String id;
        private String name;
        private String type;
        
        public Filter(String id, String name, String type) {
            this.id = id;
            this.name = name;
            this.type = type;
        }
        
        public String getId() { return id; }
        public String getName() { return name; }
        public String getType() { return type; }
    }
    
    public static class SearchResult {
        private String id;
        private String title;
        private String description;
        private String type;
        private String category;
        private String size;
        private double sizeValue;
        private String date;
        private double rating;
        private double price;
        private String image;
        private String url;
        
        public SearchResult(String id, String title, String description, String type, String category, 
                          String size, double sizeValue, String date, double rating, double price, 
                          String image, String url) {
            this.id = id;
            this.title = title;
            this.description = description;
            this.type = type;
            this.category = category;
            this.size = size;
            this.sizeValue = sizeValue;
            this.date = date;
            this.rating = rating;
            this.price = price;
            this.image = image;
            this.url = url;
        }
        
        // Getters
        public String getId() { return id; }
        public String getTitle() { return title; }
        public String getDescription() { return description; }
        public String getType() { return type; }
        public String getCategory() { return category; }
        public String getSize() { return size; }
        public double getSizeValue() { return sizeValue; }
        public String getDate() { return date; }
        public double getRating() { return rating; }
        public double getPrice() { return price; }
        public String getImage() { return image; }
        public String getUrl() { return url; }
    }
}

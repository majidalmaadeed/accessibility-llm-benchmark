package com.example.accessibility;

import android.content.Context;
import android.os.Handler;
import android.os.Looper;
import android.text.Editable;
import android.text.TextWatcher;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.*;
import androidx.appcompat.app.AppCompatActivity;
import android.os.Bundle;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;
import java.util.ArrayList;
import java.util.List;

public class SearchWithSilentUpdatesActivity extends AppCompatActivity {
    
    private EditText searchEditText;
    private RecyclerView suggestionsRecyclerView;
    private Button searchButton;
    private TextView resultsCountTextView;
    private RecyclerView resultsRecyclerView;
    private ProgressBar loadingProgressBar;
    private TextView loadingTextView;
    private TextView noResultsTextView;
    private TextView emptyStateTextView;
    
    private SuggestionsAdapter suggestionsAdapter;
    private ResultsAdapter resultsAdapter;
    private List<SearchResult> suggestions = new ArrayList<>();
    private List<SearchResult> results = new ArrayList<>();
    private boolean isLoading = false;
    private boolean showSuggestions = false;
    
    private final List<SearchResult> mockData = new ArrayList<SearchResult>() {{
        add(new SearchResult(1, "React Development Guide", "Books", "John Doe"));
        add(new SearchResult(2, "Vue.js Tutorial", "Books", "Jane Smith"));
        add(new SearchResult(3, "Angular Framework", "Books", "Bob Johnson"));
        add(new SearchResult(4, "JavaScript Fundamentals", "Books", "Alice Brown"));
        add(new SearchResult(5, "React Components", "Tutorials", "Charlie Wilson"));
        add(new SearchResult(6, "Vue Components", "Tutorials", "Diana Lee"));
        add(new SearchResult(7, "Angular Services", "Tutorials", "Eve Davis"));
        add(new SearchResult(8, "JavaScript ES6", "Tutorials", "Frank Miller"));
    }};
    
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_search_with_silent_updates);
        
        initializeViews();
        setupRecyclerViews();
        setupListeners();
        setupAccessibility();
    }
    
    private void initializeViews() {
        searchEditText = findViewById(R.id.searchEditText);
        suggestionsRecyclerView = findViewById(R.id.suggestionsRecyclerView);
        searchButton = findViewById(R.id.searchButton);
        resultsCountTextView = findViewById(R.id.resultsCountTextView);
        resultsRecyclerView = findViewById(R.id.resultsRecyclerView);
        loadingProgressBar = findViewById(R.id.loadingProgressBar);
        loadingTextView = findViewById(R.id.loadingTextView);
        noResultsTextView = findViewById(R.id.noResultsTextView);
        emptyStateTextView = findViewById(R.id.emptyStateTextView);
        
        // Initially hide suggestions
        suggestionsRecyclerView.setVisibility(View.GONE);
        loadingProgressBar.setVisibility(View.GONE);
        loadingTextView.setVisibility(View.GONE);
        noResultsTextView.setVisibility(View.GONE);
        resultsCountTextView.setVisibility(View.GONE);
        resultsRecyclerView.setVisibility(View.GONE);
    }
    
    private void setupRecyclerViews() {
        suggestionsAdapter = new SuggestionsAdapter(this, suggestions);
        suggestionsRecyclerView.setLayoutManager(new LinearLayoutManager(this));
        suggestionsRecyclerView.setAdapter(suggestionsAdapter);
        
        resultsAdapter = new ResultsAdapter(this, results);
        resultsRecyclerView.setLayoutManager(new LinearLayoutManager(this));
        resultsRecyclerView.setAdapter(resultsAdapter);
    }
    
    private void setupListeners() {
        searchEditText.addTextChangedListener(new TextWatcher() {
            @Override
            public void beforeTextChanged(CharSequence s, int start, int count, int after) {}
            
            @Override
            public void onTextChanged(CharSequence s, int start, int before, int count) {
                handleSearchInput(s.toString());
            }
            
            @Override
            public void afterTextChanged(Editable s) {}
        });
        
        searchButton.setOnClickListener(v -> performSearch());
        
        suggestionsAdapter.setOnItemClickListener(suggestion -> {
            searchEditText.setText(suggestion.getTitle());
            hideSuggestions();
            performSearch();
        });
    }
    
    private void setupAccessibility() {
        // MISSING: Proper accessibility setup
        // Should set up ARIA attributes, live regions, and keyboard navigation
    }
    
    private void handleSearchInput(String query) {
        if (query.length() > 1) {
            List<SearchResult> filtered = new ArrayList<>();
            for (SearchResult item : mockData) {
                if (item.getTitle().toLowerCase().contains(query.toLowerCase()) ||
                    item.getCategory().toLowerCase().contains(query.toLowerCase()) ||
                    item.getAuthor().toLowerCase().contains(query.toLowerCase())) {
                    filtered.add(item);
                }
            }
            
            suggestions.clear();
            suggestions.addAll(filtered.subList(0, Math.min(5, filtered.size())));
            showSuggestions = true;
            updateSuggestions();
        } else {
            suggestions.clear();
            showSuggestions = false;
            hideSuggestions();
        }
        
        searchButton.setEnabled(!query.trim().isEmpty() && !isLoading);
    }
    
    private void updateSuggestions() {
        if (suggestions.size() > 0) {
            suggestionsRecyclerView.setVisibility(View.VISIBLE);
            suggestionsAdapter.notifyDataSetChanged();
        } else {
            hideSuggestions();
        }
    }
    
    private void hideSuggestions() {
        suggestionsRecyclerView.setVisibility(View.GONE);
    }
    
    private void performSearch() {
        if (isLoading) return;
        
        String query = searchEditText.getText().toString().trim();
        if (query.isEmpty()) return;
        
        isLoading = true;
        searchButton.setEnabled(false);
        searchButton.setText("Searching...");
        
        // Hide all result states
        loadingProgressBar.setVisibility(View.VISIBLE);
        loadingTextView.setVisibility(View.VISIBLE);
        resultsCountTextView.setVisibility(View.GONE);
        resultsRecyclerView.setVisibility(View.GONE);
        noResultsTextView.setVisibility(View.GONE);
        emptyStateTextView.setVisibility(View.GONE);
        hideSuggestions();
        
        // Simulate API call
        new Handler(Looper.getMainLooper()).postDelayed(() -> {
            List<SearchResult> filtered = new ArrayList<>();
            for (SearchResult item : mockData) {
                if (item.getTitle().toLowerCase().contains(query.toLowerCase()) ||
                    item.getCategory().toLowerCase().contains(query.toLowerCase()) ||
                    item.getAuthor().toLowerCase().contains(query.toLowerCase())) {
                    filtered.add(item);
                }
            }
            
            results.clear();
            results.addAll(filtered);
            isLoading = false;
            searchButton.setEnabled(true);
            searchButton.setText("Search");
            loadingProgressBar.setVisibility(View.GONE);
            loadingTextView.setVisibility(View.GONE);
            
            if (results.size() > 0) {
                resultsCountTextView.setText("Found " + results.size() + " result" + (results.size() == 1 ? "" : "s"));
                resultsCountTextView.setVisibility(View.VISIBLE);
                resultsAdapter.notifyDataSetChanged();
                resultsRecyclerView.setVisibility(View.VISIBLE);
                
                // MISSING: Screen reader announcement of results
                // Should announce "Found X results"
            } else {
                noResultsTextView.setText("No results found for \"" + query + "\"");
                noResultsTextView.setVisibility(View.VISIBLE);
                
                // MISSING: Screen reader announcement of no results
                // Should announce "No results found"
            }
        }, 1000);
    }
    
    // MARK: - Adapters
    private static class SuggestionsAdapter extends RecyclerView.Adapter<SuggestionsAdapter.ViewHolder> {
        private Context context;
        private List<SearchResult> suggestions;
        private OnItemClickListener listener;
        
        public interface OnItemClickListener {
            void onItemClick(SearchResult suggestion);
        }
        
        public SuggestionsAdapter(Context context, List<SearchResult> suggestions) {
            this.context = context;
            this.suggestions = suggestions;
        }
        
        public void setOnItemClickListener(OnItemClickListener listener) {
            this.listener = listener;
        }
        
        @Override
        public ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
            View view = LayoutInflater.from(context).inflate(R.layout.item_suggestion, parent, false);
            return new ViewHolder(view);
        }
        
        @Override
        public void onBindViewHolder(ViewHolder holder, int position) {
            SearchResult suggestion = suggestions.get(position);
            holder.titleTextView.setText(suggestion.getTitle());
            holder.metaTextView.setText(suggestion.getCategory() + " • " + suggestion.getAuthor());
            
            holder.itemView.setOnClickListener(v -> {
                if (listener != null) {
                    listener.onItemClick(suggestion);
                }
            });
        }
        
        @Override
        public int getItemCount() {
            return suggestions.size();
        }
        
        static class ViewHolder extends RecyclerView.ViewHolder {
            TextView titleTextView;
            TextView metaTextView;
            
            ViewHolder(View itemView) {
                super(itemView);
                titleTextView = itemView.findViewById(R.id.titleTextView);
                metaTextView = itemView.findViewById(R.id.metaTextView);
            }
        }
    }
    
    private static class ResultsAdapter extends RecyclerView.Adapter<ResultsAdapter.ViewHolder> {
        private Context context;
        private List<SearchResult> results;
        
        public ResultsAdapter(Context context, List<SearchResult> results) {
            this.context = context;
            this.results = results;
        }
        
        @Override
        public ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
            View view = LayoutInflater.from(context).inflate(R.layout.item_result, parent, false);
            return new ViewHolder(view);
        }
        
        @Override
        public void onBindViewHolder(ViewHolder holder, int position) {
            SearchResult result = results.get(position);
            holder.titleTextView.setText(result.getTitle());
            holder.categoryTextView.setText("Category: " + result.getCategory());
            holder.authorTextView.setText("Author: " + result.getAuthor());
        }
        
        @Override
        public int getItemCount() {
            return results.size();
        }
        
        static class ViewHolder extends RecyclerView.ViewHolder {
            TextView titleTextView;
            TextView categoryTextView;
            TextView authorTextView;
            
            ViewHolder(View itemView) {
                super(itemView);
                titleTextView = itemView.findViewById(R.id.titleTextView);
                categoryTextView = itemView.findViewById(R.id.categoryTextView);
                authorTextView = itemView.findViewById(R.id.authorTextView);
            }
        }
    }
    
    // MARK: - Data Model
    public static class SearchResult {
        private int id;
        private String title;
        private String category;
        private String author;
        
        public SearchResult(int id, String title, String category, String author) {
            this.id = id;
            this.title = title;
            this.category = category;
            this.author = author;
        }
        
        public int getId() { return id; }
        public String getTitle() { return title; }
        public String getCategory() { return category; }
        public String getAuthor() { return author; }
    }
}
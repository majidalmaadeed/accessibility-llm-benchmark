package com.example.accessibilitybenchmark;

import android.app.AlertDialog;
import android.content.Context;
import android.graphics.Color;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.*;
import androidx.appcompat.app.AppCompatActivity;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;
import java.util.ArrayList;
import java.util.List;

public class InteractiveMap extends AppCompatActivity {
    
    private SearchView searchView;
    private Spinner mapTypeSpinner;
    private FrameLayout mapContainer;
    private TextView mapPlaceholder;
    private RecyclerView searchResultsRecyclerView;
    private ProgressBar loadingIndicator;
    private Button layersButton;
    private Button bookmarksButton;
    private Button controlsButton;
    
    private List<MapLocation> allLocations = new ArrayList<>();
    private List<MapLocation> searchResults = new ArrayList<>();
    private List<MapLocation> bookmarks = new ArrayList<>();
    private String currentMapType = "standard";
    private boolean showUserLocation = true;
    private boolean showMapControls = true;
    private boolean trafficEnabled = false;
    private boolean transitEnabled = false;
    private boolean bikeLanesEnabled = false;
    
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_interactive_map);
        
        initializeViews();
        setupMapTypeSpinner();
        loadSampleData();
        setupMapMarkers();
    }
    
    private void initializeViews() {
        searchView = findViewById(R.id.searchView);
        mapTypeSpinner = findViewById(R.id.mapTypeSpinner);
        mapContainer = findViewById(R.id.mapContainer);
        mapPlaceholder = findViewById(R.id.mapPlaceholder);
        searchResultsRecyclerView = findViewById(R.id.searchResultsRecyclerView);
        loadingIndicator = findViewById(R.id.loadingIndicator);
        layersButton = findViewById(R.id.layersButton);
        bookmarksButton = findViewById(R.id.bookmarksButton);
        controlsButton = findViewById(R.id.controlsButton);
        
        // Setup RecyclerView
        searchResultsRecyclerView.setLayoutManager(new LinearLayoutManager(this));
        searchResultsRecyclerView.setVisibility(View.GONE);
        
        // Setup search
        searchView.setOnQueryTextListener(new SearchView.OnQueryTextListener() {
            @Override
            public boolean onQueryTextSubmit(String query) {
                performSearch(query);
                return true;
            }
            
            @Override
            public boolean onQueryTextChange(String newText) {
                if (newText.isEmpty()) {
                    searchResultsRecyclerView.setVisibility(View.GONE);
                } else {
                    performSearch(newText);
                }
                return true;
            }
        });
        
        // Setup buttons
        layersButton.setOnClickListener(v -> showLayersDialog());
        bookmarksButton.setOnClickListener(v -> showBookmarksDialog());
        controlsButton.setOnClickListener(v -> toggleMapControls());
    }
    
    private void setupMapTypeSpinner() {
        String[] mapTypes = {"Standard", "Satellite", "Hybrid", "Terrain"};
        ArrayAdapter<String> adapter = new ArrayAdapter<>(this, android.R.layout.simple_spinner_item, mapTypes);
        adapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
        mapTypeSpinner.setAdapter(adapter);
        
        mapTypeSpinner.setOnItemSelectedListener(new AdapterView.OnItemSelectedListener() {
            @Override
            public void onItemSelected(AdapterView<?> parent, View view, int position, long id) {
                currentMapType = mapTypes[position].toLowerCase();
                updateMapPlaceholder();
            }
            
            @Override
            public void onNothingSelected(AdapterView<?> parent) {}
        });
    }
    
    private void loadSampleData() {
        allLocations.add(new MapLocation(
            "1",
            "Golden Gate Bridge",
            "Golden Gate Bridge, San Francisco, CA",
            37.8199,
            -122.4783,
            "landmark",
            4.8,
            "Famous suspension bridge spanning the Golden Gate strait.",
            "Tourist Attraction",
            0.0,
            "24/7",
            "(415) 921-5858"
        ));
        
        allLocations.add(new MapLocation(
            "2",
            "Fisherman's Wharf",
            "Pier 39, San Francisco, CA",
            37.8087,
            -122.4098,
            "attraction",
            4.2,
            "Popular tourist destination with shops, restaurants, and sea lions.",
            "Shopping & Dining",
            0.0,
            "9:00 AM - 10:00 PM",
            "(415) 705-5500"
        ));
        
        allLocations.add(new MapLocation(
            "3",
            "Alcatraz Island",
            "Alcatraz Island, San Francisco, CA",
            37.8270,
            -122.4230,
            "landmark",
            4.6,
            "Former federal prison, now a popular tourist attraction.",
            "Historical Site",
            45.0,
            "9:00 AM - 6:30 PM",
            "(415) 561-4926"
        ));
        
        allLocations.add(new MapLocation(
            "4",
            "Lombard Street",
            "Lombard St, San Francisco, CA",
            37.8021,
            -122.4187,
            "landmark",
            4.3,
            "Famous steep, winding street with eight hairpin turns.",
            "Tourist Attraction",
            0.0,
            "24/7",
            "N/A"
        ));
        
        allLocations.add(new MapLocation(
            "5",
            "Union Square",
            "Union Square, San Francisco, CA",
            37.7880,
            -122.4074,
            "shopping",
            4.1,
            "Major shopping and entertainment district in downtown San Francisco.",
            "Shopping District",
            0.0,
            "10:00 AM - 9:00 PM",
            "N/A"
        ));
    }
    
    private void setupMapMarkers() {
        // Add markers to map container
        for (MapLocation location : allLocations) {
            addMapMarker(location);
        }
        
        // Add user location marker
        if (showUserLocation) {
            addUserLocationMarker();
        }
        
        updateMapPlaceholder();
    }
    
    private void addMapMarker(MapLocation location) {
        Button marker = new Button(this);
        marker.setText("📍");
        marker.setTextSize(16);
        marker.setBackgroundColor(Color.TRANSPARENT);
        marker.setPadding(0, 0, 0, 0);
        
        // Position marker (simplified positioning)
        FrameLayout.LayoutParams params = new FrameLayout.LayoutParams(60, 60);
        params.leftMargin = getMarkerX(location.getLng());
        params.topMargin = getMarkerY(location.getLat());
        marker.setLayoutParams(params);
        
        marker.setOnClickListener(v -> showLocationDetails(location));
        mapContainer.addView(marker);
    }
    
    private void addUserLocationMarker() {
        Button userMarker = new Button(this);
        userMarker.setText("👤");
        userMarker.setTextSize(12);
        userMarker.setBackgroundColor(Color.BLUE);
        userMarker.setTextColor(Color.WHITE);
        
        FrameLayout.LayoutParams params = new FrameLayout.LayoutParams(40, 40);
        params.leftMargin = 200;
        params.topMargin = 200;
        userMarker.setLayoutParams(params);
        
        mapContainer.addView(userMarker);
    }
    
    private int getMarkerX(double lng) {
        // Simplified positioning for demo
        return (int) ((lng + 122.5) * 100);
    }
    
    private int getMarkerY(double lat) {
        // Simplified positioning for demo
        return (int) ((37.8 - lat) * 100);
    }
    
    private void updateMapPlaceholder() {
        String mapTypeText = currentMapType.substring(0, 1).toUpperCase() + currentMapType.substring(1);
        mapPlaceholder.setText("🗺️ " + mapTypeText + " Map\n37.7749, -122.4194\nZoom: 10");
    }
    
    private void performSearch(String query) {
        if (query.trim().isEmpty()) {
            searchResultsRecyclerView.setVisibility(View.GONE);
            return;
        }
        
        searchResults.clear();
        for (MapLocation location : allLocations) {
            if (location.getName().toLowerCase().contains(query.toLowerCase()) ||
                location.getAddress().toLowerCase().contains(query.toLowerCase()) ||
                location.getCategory().toLowerCase().contains(query.toLowerCase())) {
                searchResults.add(location);
            }
        }
        
        if (!searchResults.isEmpty()) {
            SearchResultAdapter adapter = new SearchResultAdapter(searchResults, this::onLocationSelected);
            searchResultsRecyclerView.setAdapter(adapter);
            searchResultsRecyclerView.setVisibility(View.VISIBLE);
        } else {
            searchResultsRecyclerView.setVisibility(View.GONE);
        }
    }
    
    private void onLocationSelected(MapLocation location) {
        searchResultsRecyclerView.setVisibility(View.GONE);
        showLocationDetails(location);
    }
    
    private void showLocationDetails(MapLocation location) {
        AlertDialog.Builder builder = new AlertDialog.Builder(this);
        builder.setTitle(location.getName());
        
        StringBuilder message = new StringBuilder();
        message.append(location.getDescription()).append("\n\n");
        message.append("Type: ").append(location.getType()).append("\n");
        message.append("Rating: ").append(String.format("%.1f/5", location.getRating())).append("\n");
        message.append("Price: ").append(location.getPrice() > 0 ? 
            String.format("$%.0f", location.getPrice()) : "Free").append("\n");
        message.append("Hours: ").append(location.getHours()).append("\n");
        if (!location.getPhone().equals("N/A")) {
            message.append("Phone: ").append(location.getPhone());
        }
        
        builder.setMessage(message.toString());
        builder.setPositiveButton("Close", null);
        builder.setNegativeButton("Get Directions", (dialog, which) -> {
            showDirections(location);
        });
        builder.setNeutralButton("Bookmark", (dialog, which) -> {
            bookmarkLocation(location);
        });
        builder.show();
    }
    
    private void showDirections(MapLocation location) {
        AlertDialog.Builder builder = new AlertDialog.Builder(this);
        builder.setTitle("Directions");
        builder.setMessage("Turn-by-turn directions to " + location.getName() + " would be displayed here.");
        builder.setPositiveButton("OK", null);
        builder.show();
    }
    
    private void bookmarkLocation(MapLocation location) {
        if (!bookmarks.contains(location)) {
            bookmarks.add(location);
            Toast.makeText(this, "Location bookmarked", Toast.LENGTH_SHORT).show();
        } else {
            Toast.makeText(this, "Location already bookmarked", Toast.LENGTH_SHORT).show();
        }
    }
    
    private void showLayersDialog() {
        AlertDialog.Builder builder = new AlertDialog.Builder(this);
        builder.setTitle("Map Layers");
        
        View dialogView = LayoutInflater.from(this).inflate(R.layout.dialog_layers, null);
        
        CheckBox trafficCheckBox = dialogView.findViewById(R.id.trafficCheckBox);
        CheckBox transitCheckBox = dialogView.findViewById(R.id.transitCheckBox);
        CheckBox bikeLanesCheckBox = dialogView.findViewById(R.id.bikeLanesCheckBox);
        CheckBox userLocationCheckBox = dialogView.findViewById(R.id.userLocationCheckBox);
        
        trafficCheckBox.setChecked(trafficEnabled);
        transitCheckBox.setChecked(transitEnabled);
        bikeLanesCheckBox.setChecked(bikeLanesEnabled);
        userLocationCheckBox.setChecked(showUserLocation);
        
        builder.setView(dialogView);
        builder.setPositiveButton("Apply", (dialog, which) -> {
            trafficEnabled = trafficCheckBox.isChecked();
            transitEnabled = transitCheckBox.isChecked();
            bikeLanesEnabled = bikeLanesCheckBox.isChecked();
            showUserLocation = userLocationCheckBox.isChecked();
            
            // Update map based on layer settings
            updateMapLayers();
        });
        builder.setNegativeButton("Cancel", null);
        builder.show();
    }
    
    private void showBookmarksDialog() {
        if (bookmarks.isEmpty()) {
            AlertDialog.Builder builder = new AlertDialog.Builder(this);
            builder.setTitle("Bookmarks");
            builder.setMessage("No bookmarks yet.\nBookmark locations to see them here.");
            builder.setPositiveButton("OK", null);
            builder.show();
        } else {
            AlertDialog.Builder builder = new AlertDialog.Builder(this);
            builder.setTitle("Bookmarks");
            
            String[] bookmarkNames = new String[bookmarks.size()];
            for (int i = 0; i < bookmarks.size(); i++) {
                bookmarkNames[i] = bookmarks.get(i).getName();
            }
            
            builder.setItems(bookmarkNames, (dialog, which) -> {
                showLocationDetails(bookmarks.get(which));
            });
            builder.setNegativeButton("Cancel", null);
            builder.show();
        }
    }
    
    private void toggleMapControls() {
        showMapControls = !showMapControls;
        // In a real implementation, this would show/hide map controls
        Toast.makeText(this, "Map controls " + (showMapControls ? "enabled" : "disabled"), Toast.LENGTH_SHORT).show();
    }
    
    private void updateMapLayers() {
        // In a real implementation, this would update the map layers
        Toast.makeText(this, "Map layers updated", Toast.LENGTH_SHORT).show();
    }
    
    // Search Result Adapter
    private static class SearchResultAdapter extends RecyclerView.Adapter<SearchResultAdapter.ViewHolder> {
        private List<MapLocation> results;
        private OnLocationClickListener listener;
        
        public interface OnLocationClickListener {
            void onLocationClick(MapLocation location);
        }
        
        public SearchResultAdapter(List<MapLocation> results, OnLocationClickListener listener) {
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
            MapLocation location = results.get(position);
            holder.bind(location, listener);
        }
        
        @Override
        public int getItemCount() {
            return results.size();
        }
        
        static class ViewHolder extends RecyclerView.ViewHolder {
            private TextView nameText;
            private TextView addressText;
            
            public ViewHolder(View itemView) {
                super(itemView);
                nameText = itemView.findViewById(R.id.nameText);
                addressText = itemView.findViewById(R.id.addressText);
            }
            
            public void bind(MapLocation location, OnLocationClickListener listener) {
                nameText.setText(location.getName());
                addressText.setText(location.getAddress());
                itemView.setOnClickListener(v -> listener.onLocationClick(location));
            }
        }
    }
    
    // Data class
    public static class MapLocation {
        private String id;
        private String name;
        private String address;
        private double lat;
        private double lng;
        private String type;
        private double rating;
        private String description;
        private String category;
        private double price;
        private String hours;
        private String phone;
        
        public MapLocation(String id, String name, String address, double lat, double lng, String type, 
                          double rating, String description, String category, double price, String hours, String phone) {
            this.id = id;
            this.name = name;
            this.address = address;
            this.lat = lat;
            this.lng = lng;
            this.type = type;
            this.rating = rating;
            this.description = description;
            this.category = category;
            this.price = price;
            this.hours = hours;
            this.phone = phone;
        }
        
        // Getters
        public String getId() { return id; }
        public String getName() { return name; }
        public String getAddress() { return address; }
        public double getLat() { return lat; }
        public double getLng() { return lng; }
        public String getType() { return type; }
        public double getRating() { return rating; }
        public String getDescription() { return description; }
        public String getCategory() { return category; }
        public double getPrice() { return price; }
        public String getHours() { return hours; }
        public String getPhone() { return phone; }
    }
}

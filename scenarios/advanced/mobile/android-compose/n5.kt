package com.example.UIComponents

import androidx.compose.foundation.background
import androidx.compose.foundation.border
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.LazyRow
import androidx.compose.foundation.lazy.items
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.*
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.dp

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun InteractiveMap() {
    var searchQuery by remember { mutableStateOf("") }
    var searchResults by remember { mutableStateOf<List<MapLocation>>(emptyList()) }
    var isLoading by remember { mutableStateOf(false) }
    var mapType by remember { mutableStateOf(MapType.STANDARD) }
    var showUserLocation by remember { mutableStateOf(true) }
    var showMapControls by remember { mutableStateOf(true) }
    var trafficEnabled by remember { mutableStateOf(false) }
    var transitEnabled by remember { mutableStateOf(false) }
    var bikeLanesEnabled by remember { mutableStateOf(false) }
    var showSearchResults by remember { mutableStateOf(false) }
    var showLocationDetails by remember { mutableStateOf(false) }
    var showLayers by remember { mutableStateOf(false) }
    var showBookmarks by remember { mutableStateOf(false) }
    var selectedLocation by remember { mutableStateOf<MapLocation?>(null) }
    var bookmarks by remember { mutableStateOf<List<MapLocation>>(emptyList()) }

    val sampleLocations = listOf(
        MapLocation(
            id = "1",
            name = "Golden Gate Bridge",
            address = "Golden Gate Bridge, San Francisco, CA",
            lat = 37.8199,
            lng = -122.4783,
            type = "landmark",
            rating = 4.8,
            description = "Famous suspension bridge spanning the Golden Gate strait.",
            category = "Tourist Attraction",
            price = 0.0,
            hours = "24/7",
            phone = "(415) 921-5858"
        ),
        MapLocation(
            id = "2",
            name = "Fisherman's Wharf",
            address = "Pier 39, San Francisco, CA",
            lat = 37.8087,
            lng = -122.4098,
            type = "attraction",
            rating = 4.2,
            description = "Popular tourist destination with shops, restaurants, and sea lions.",
            category = "Shopping & Dining",
            price = 0.0,
            hours = "9:00 AM - 10:00 PM",
            phone = "(415) 705-5500"
        ),
        MapLocation(
            id = "3",
            name = "Alcatraz Island",
            address = "Alcatraz Island, San Francisco, CA",
            lat = 37.8270,
            lng = -122.4230,
            type = "landmark",
            rating = 4.6,
            description = "Former federal prison, now a popular tourist attraction.",
            category = "Historical Site",
            price = 45.0,
            hours = "9:00 AM - 6:30 PM",
            phone = "(415) 561-4926"
        )
    )

    Scaffold(
        topBar = {
            TopAppBar(
                title = { Text("Interactive Map") }
            )
        }
    ) { paddingValues ->
        Column(
            modifier = Modifier
                .fillMaxSize()
                .padding(paddingValues)
        ) {
            // Search Bar
            SearchBar(
                query = searchQuery,
                onQueryChange = { searchQuery = it },
                onSearch = {
                    performSearch(searchQuery, sampleLocations) { results ->
                        searchResults = results
                        if (results.isNotEmpty()) {
                            showSearchResults = true
                        }
                    }
                }
            )

            // Map Type Selector
            MapTypeSelector(
                selectedType = mapType,
                onTypeChange = { mapType = it }
            )

            // Map Area
            MapArea(
                mapType = mapType,
                showUserLocation = showUserLocation,
                showMapControls = showMapControls,
                locations = sampleLocations,
                onLocationClick = { location ->
                    selectedLocation = location
                    showLocationDetails = true
                },
                onZoomIn = { /* Handle zoom in */ },
                onZoomOut = { /* Handle zoom out */ },
                onCenterMap = { /* Handle center map */ }
            )

            // Bottom Controls
            BottomControls(
                onLayersClick = { showLayers = true },
                onBookmarksClick = { showBookmarks = true },
                onControlsClick = { showMapControls = !showMapControls }
            )
        }
    }

    // Search Results Dialog
    if (showSearchResults) {
        SearchResultsDialog(
            results = searchResults,
            onDismiss = { showSearchResults = false },
            onLocationSelected = { location ->
                selectedLocation = location
                showSearchResults = false
                showLocationDetails = true
            }
        )
    }

    // Location Details Dialog
    if (showLocationDetails && selectedLocation != null) {
        LocationDetailsDialog(
            location = selectedLocation!!,
            onDismiss = { showLocationDetails = false },
            onBookmark = { location ->
                bookmarks = bookmarks + location
                showLocationDetails = false
            }
        )
    }

    // Layers Dialog
    if (showLayers) {
        LayersDialog(
            trafficEnabled = trafficEnabled,
            transitEnabled = transitEnabled,
            bikeLanesEnabled = bikeLanesEnabled,
            showUserLocation = showUserLocation,
            onTrafficChange = { trafficEnabled = it },
            onTransitChange = { transitEnabled = it },
            onBikeLanesChange = { bikeLanesEnabled = it },
            onUserLocationChange = { showUserLocation = it },
            onDismiss = { showLayers = false }
        )
    }

    // Bookmarks Dialog
    if (showBookmarks) {
        BookmarksDialog(
            bookmarks = bookmarks,
            onDismiss = { showBookmarks = false },
            onBookmarkSelected = { location ->
                selectedLocation = location
                showBookmarks = false
                showLocationDetails = true
            }
        )
    }
}

@Composable
fun SearchBar(
    query: String,
    onQueryChange: (String) -> Unit,
    onSearch: () -> Unit
) {
    OutlinedTextField(
        value = query,
        onValueChange = onQueryChange,
        placeholder = { Text("Search for places...") },
        leadingIcon = {
            Icon(Icons.Default.Search, contentDescription = null)
        },
        trailingIcon = {
            if (query.isNotEmpty()) {
                IconButton(onClick = { onQueryChange("") }) {
                    Icon(Icons.Default.Clear, contentDescription = null)
                }
            }
        },
        modifier = Modifier
            .fillMaxWidth()
            .padding(16.dp),
        singleLine = true,
        onDone = { onSearch() }
    )
}

@Composable
fun MapTypeSelector(
    selectedType: MapType,
    onTypeChange: (MapType) -> Unit
) {
    LazyRow(
        modifier = Modifier
            .fillMaxWidth()
            .padding(horizontal = 16.dp),
        horizontalArrangement = Arrangement.spacedBy(8.dp)
    ) {
        items(MapType.values()) { type ->
            FilterChip(
                onClick = { onTypeChange(type) },
                label = { Text(type.name.capitalize()) },
                selected = selectedType == type
            )
        }
    }
}

@Composable
fun MapArea(
    mapType: MapType,
    showUserLocation: Boolean,
    showMapControls: Boolean,
    locations: List<MapLocation>,
    onLocationClick: (MapLocation) -> Unit,
    onZoomIn: () -> Unit,
    onZoomOut: () -> Unit,
    onCenterMap: () -> Unit
) {
    Box(
        modifier = Modifier
            .fillMaxWidth()
            .height(400.dp)
            .padding(16.dp)
    ) {
        >
            MapMarker(
                location = location,
                onClick = { onLocationClick(location) },
                modifier = Modifier.align(Alignment.TopStart)
            )
        }

        // User Location Marker
        if (showUserLocation) {
            UserLocationMarker(
                modifier = Modifier.align(Alignment.TopStart)
            )
        }

        // Map Controls
        if (showMapControls) {
            MapControls(
                onZoomIn = onZoomIn,
                onZoomOut = onZoomOut,
                onCenterMap = onCenterMap,
                modifier = Modifier.align(Alignment.BottomEnd)
            )
        }
    }
}

@Composable
fun MapMarker(
    location: MapLocation,
    onClick: () -> Unit,
    modifier: Modifier = Modifier
) {
    Box(
        modifier = modifier
            .offset(
                x = getMarkerX(location.lng).dp,
                y = getMarkerY(location.lat).dp
            )
            .clickable { onClick() }
    ) {
        Icon(
            Icons.Default.Place,
            contentDescription = null,
            modifier = Modifier
                .size(32.dp)
                .background(
                    MaterialTheme.colorScheme.surface,
                    CircleShape
                )
                .padding(4.dp),
            tint = getMarkerColor(location.type)
        )
    }
}

@Composable
fun UserLocationMarker(
    modifier: Modifier = Modifier
) {
    Box(
        modifier = modifier
            .offset(x = 200.dp, y = 200.dp)
    ) {
        Icon(
            Icons.Default.Person,
            contentDescription = null,
            modifier = Modifier
                .size(24.dp)
                .background(
                    MaterialTheme.colorScheme.primary,
                    CircleShape
                )
                .padding(4.dp),
            tint = MaterialTheme.colorScheme.onPrimary
        )
    }
}

@Composable
fun MapControls(
    onZoomIn: () -> Unit,
    onZoomOut: () -> Unit,
    onCenterMap: () -> Unit,
    modifier: Modifier = Modifier
) {
    Column(
        modifier = modifier.padding(16.dp),
        verticalArrangement = Arrangement.spacedBy(8.dp)
    ) {
        FloatingActionButton(
            onClick = onZoomIn,
            modifier = Modifier.size(40.dp),
            containerColor = MaterialTheme.colorScheme.surface
        ) {
            Icon(Icons.Default.Add, contentDescription = null)
        }
        FloatingActionButton(
            onClick = onZoomOut,
            modifier = Modifier.size(40.dp),
            containerColor = MaterialTheme.colorScheme.surface
        ) {
            Icon(Icons.Default.Remove, contentDescription = null)
        }
        FloatingActionButton(
            onClick = onCenterMap,
            modifier = Modifier.size(40.dp),
            containerColor = MaterialTheme.colorScheme.surface
        ) {
            Icon(Icons.Default.MyLocation, contentDescription = null)
        }
    }
}

@Composable
fun BottomControls(
    onLayersClick: () -> Unit,
    onBookmarksClick: () -> Unit,
    onControlsClick: () -> Unit
) {
    Row(
        modifier = Modifier
            .fillMaxWidth()
            .background(MaterialTheme.colorScheme.surface)
            .border(1.dp, MaterialTheme.colorScheme.outline)
            .padding(16.dp),
        horizontalArrangement = Arrangement.SpaceEvenly
    ) {
        ControlButton(
            icon = Icons.Default.Layers,
            text = "Layers",
            onClick = onLayersClick
        )
        ControlButton(
            icon = Icons.Default.Bookmark,
            text = "Bookmarks",
            onClick = onBookmarksClick
        )
        ControlButton(
            icon = Icons.Default.Settings,
            text = "Controls",
            onClick = onControlsClick
        )
    }
}

@Composable
fun ControlButton(
    icon: androidx.compose.ui.graphics.vector.ImageVector,
    text: String,
    onClick: () -> Unit
) {
    Column(
        horizontalAlignment = Alignment.CenterHorizontally,
        modifier = Modifier.clickable { onClick() }
    ) {
        Icon(
            imageVector = icon,
            contentDescription = null,
            modifier = Modifier.size(24.dp)
        )
        Text(
            text = text,
            style = MaterialTheme.typography.labelSmall
        )
    }
}

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun SearchResultsDialog(
    results: List<MapLocation>,
    onDismiss: () -> Unit,
    onLocationSelected: (MapLocation) -> Unit
) {
    AlertDialog(
        onDismissRequest = onDismiss,
        title = { Text("Search Results") },
        text = {
            LazyColumn {
                items(results) { location ->
                    LocationItem(
                        location = location,
                        onClick = { onLocationSelected(location) }
                    )
                }
            }
        },
        confirmButton = {
            TextButton(onClick = onDismiss) {
                Text("Done")
            }
        }
    )
}

@Composable
fun LocationItem(
    location: MapLocation,
    onClick: () -> Unit
) {
    Row(
        modifier = Modifier
            .fillMaxWidth()
            .clickable { onClick() }
            .padding(vertical = 8.dp),
        verticalAlignment = Alignment.CenterVertically
    ) {
        Icon(
            Icons.Default.LocationOn,
            contentDescription = null,
            tint = MaterialTheme.colorScheme.primary
        )
        Spacer(modifier = Modifier.width(12.dp))
        Column {
            Text(
                text = location.name,
                style = MaterialTheme.typography.titleMedium,
                fontWeight = FontWeight.SemiBold
            )
            Text(
                text = location.address,
                style = MaterialTheme.typography.bodyMedium,
                color = MaterialTheme.colorScheme.onSurfaceVariant
            )
        }
    }
}

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun LocationDetailsDialog(
    location: MapLocation,
    onDismiss: () -> Unit,
    onBookmark: (MapLocation) -> Unit
) {
    AlertDialog(
        onDismissRequest = onDismiss,
        title = { Text(location.name) },
        text = {
            Column {
                Text(
                    text = location.address,
                    style = MaterialTheme.typography.bodyMedium,
                    color = MaterialTheme.colorScheme.onSurfaceVariant
                )
                Spacer(modifier = Modifier.height(8.dp))
                Row {
                    Icon(Icons.Default.Star, contentDescription = null, modifier = Modifier.size(16.dp))
                    Spacer(modifier = Modifier.width(4.dp))
                    Text("${String.format("%.1f", location.rating)}")
                }
                Spacer(modifier = Modifier.height(16.dp))
                Text(
                    text = "Description",
                    style = MaterialTheme.typography.titleMedium,
                    fontWeight = FontWeight.SemiBold
                )
                Text(location.description)
                Spacer(modifier = Modifier.height(16.dp))
                Text(
                    text = "Details",
                    style = MaterialTheme.typography.titleMedium,
                    fontWeight = FontWeight.SemiBold
                )
                DetailRow("Category", location.category)
                DetailRow("Hours", location.hours)
                if (location.price > 0) {
                    DetailRow("Price", "$${String.format("%.0f", location.price)}")
                }
                if (location.phone != "N/A") {
                    DetailRow("Phone", location.phone)
                }
            }
        },
        confirmButton = {
            TextButton(onClick = { onBookmark(location) }) {
                Text("Bookmark")
            }
        },
        dismissButton = {
            TextButton(onClick = onDismiss) {
                Text("Close")
            }
        }
    )
}

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun LayersDialog(
    trafficEnabled: Boolean,
    transitEnabled: Boolean,
    bikeLanesEnabled: Boolean,
    showUserLocation: Boolean,
    onTrafficChange: (Boolean) -> Unit,
    onTransitChange: (Boolean) -> Unit,
    onBikeLanesChange: (Boolean) -> Unit,
    onUserLocationChange: (Boolean) -> Unit,
    onDismiss: () -> Unit
) {
    AlertDialog(
        onDismissRequest = onDismiss,
        title = { Text("Map Layers") },
        text = {
            Column {
                Text(
                    text = "Map Layers",
                    style = MaterialTheme.typography.titleMedium,
                    fontWeight = FontWeight.SemiBold
                )
                Spacer(modifier = Modifier.height(16.dp))
                Row(
                    modifier = Modifier.fillMaxWidth(),
                    horizontalArrangement = Arrangement.SpaceBetween
                ) {
                    Text("Traffic")
                    Switch(
                        checked = trafficEnabled,
                        onCheckedChange = onTrafficChange
                    )
                }
                Row(
                    modifier = Modifier.fillMaxWidth(),
                    horizontalArrangement = Arrangement.SpaceBetween
                ) {
                    Text("Transit")
                    Switch(
                        checked = transitEnabled,
                        onCheckedChange = onTransitChange
                    )
                }
                Row(
                    modifier = Modifier.fillMaxWidth(),
                    horizontalArrangement = Arrangement.SpaceBetween
                ) {
                    Text("Bike Lanes")
                    Switch(
                        checked = bikeLanesEnabled,
                        onCheckedChange = onBikeLanesChange
                    )
                }
                Row(
                    modifier = Modifier.fillMaxWidth(),
                    horizontalArrangement = Arrangement.SpaceBetween
                ) {
                    Text("User Location")
                    Switch(
                        checked = showUserLocation,
                        onCheckedChange = onUserLocationChange
                    )
                }
            }
        },
        confirmButton = {
            TextButton(onClick = onDismiss) {
                Text("Done")
            }
        }
    )
}

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun BookmarksDialog(
    bookmarks: List<MapLocation>,
    onDismiss: () -> Unit,
    onBookmarkSelected: (MapLocation) -> Unit
) {
    AlertDialog(
        onDismissRequest = onDismiss,
        title = { Text("Bookmarks") },
        text = {
            if (bookmarks.isEmpty()) {
                Column(
                    horizontalAlignment = Alignment.CenterHorizontally,
                    modifier = Modifier.padding(32.dp)
                ) {
                    Icon(
                        Icons.Default.Bookmark,
                        contentDescription = null,
                        modifier = Modifier.size(48.dp),
                        tint = MaterialTheme.colorScheme.onSurfaceVariant
                    )
                    Spacer(modifier = Modifier.height(16.dp))
                    Text(
                        text = "No bookmarks yet",
                        style = MaterialTheme.typography.headlineSmall
                    )
                    Text(
                        text = "Bookmark locations to see them here",
                        style = MaterialTheme.typography.bodyMedium,
                        color = MaterialTheme.colorScheme.onSurfaceVariant
                    )
                }
            } else {
                LazyColumn {
                    items(bookmarks) { bookmark ->
                        LocationItem(
                            location = bookmark,
                            onClick = { onBookmarkSelected(bookmark) }
                        )
                    }
                }
            }
        },
        confirmButton = {
            TextButton(onClick = onDismiss) {
                Text("Done")
            }
        }
    )
}

@Composable
fun DetailRow(title: String, value: String) {
    Row(
        modifier = Modifier.fillMaxWidth(),
        horizontalArrangement = Arrangement.SpaceBetween
    ) {
        Text(
            text = title,
            style = MaterialTheme.typography.bodyMedium,
            color = MaterialTheme.colorScheme.onSurfaceVariant
        )
        Text(
            text = value,
            style = MaterialTheme.typography.bodyMedium,
            fontWeight = FontWeight.Medium
        )
    }
}

// Helper functions
fun performSearch(
    query: String,
    locations: List<MapLocation>,
    onResults: (List<MapLocation>) -> Unit
) {
    if (query.isEmpty()) {
        onResults(emptyList())
        return
    }

    val results = locations.filter { location ->
        location.name.contains(query, ignoreCase = true) ||
        location.address.contains(query, ignoreCase = true) ||
        location.category.contains(query, ignoreCase = true)
    }

    onResults(results)
}

fun getMarkerX(lng: Double): Float {
    val normalizedLng = (lng + 122.5) / 0.5
    return (normalizedLng * 100).toFloat()
}

fun getMarkerY(lat: Double): Float {
    val normalizedLat = (37.8 - lat) / 0.5
    return (normalizedLat * 100).toFloat()
}

fun getMarkerColor(type: String): Color {
    return when (type) {
        "landmark" -> Color.Red
        "attraction" -> Color.Cyan
        "shopping" -> Color.Blue
        "restaurant" -> Color.Green
        "hotel" -> Color.Yellow
        else -> Color.Magenta
    }
}

// Data classes
enum class MapType {
    STANDARD, SATELLITE, HYBRID, TERRAIN
}

data class MapLocation(
    val id: String,
    val name: String,
    val address: String,
    val lat: Double,
    val lng: Double,
    val type: String,
    val rating: Double,
    val description: String,
    val category: String,
    val price: Double,
    val hours: String,
    val phone: String
)

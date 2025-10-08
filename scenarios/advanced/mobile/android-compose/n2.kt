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
fun ComplexSearchInterface() {
    var searchQuery by remember { mutableStateOf("") }
    var searchResults by remember { mutableStateOf<List<SearchResult>>(emptyList()) }
    var isLoading by remember { mutableStateOf(false) }
    var selectedFilters by remember { mutableStateOf(setOf<String>()) }
    var sortOption by remember { mutableStateOf("relevance") }
    var viewMode by remember { mutableStateOf(ViewMode.LIST) }
    var selectedCategory by remember { mutableStateOf("All") }
    var showAdvancedFilters by remember { mutableStateOf(false) }
    var showResultDetails by remember { mutableStateOf(false) }
    var selectedResult by remember { mutableStateOf<SearchResult?>(null) }

    val filters = listOf(
        Filter("recent", "Recent", "date"),
        Filter("large", "Large Files", "size"),
        Filter("images", "Images Only", "type"),
        Filter("videos", "Videos Only", "type"),
        Filter("documents", "Documents Only", "type"),
        Filter("free", "Free", "price"),
        Filter("premium", "Premium", "price")
    )

    val categories = listOf("All", "Documents", "Images", "Videos", "Audio", "Web Pages", "News", "Products", "People", "Locations")

    val sampleResults = listOf(
        SearchResult(
            id = "1",
            title = "React Native Development Guide",
            description = "Comprehensive guide to building mobile apps with React Native",
            type = "document",
            category = "Documents",
            size = "2.5 MB",
            sizeValue = 2.5,
            date = "2024-01-15",
            rating = 4.8,
            price = 0.0,
            image = "📄",
            url = "https://example.com/react-native-guide"
        ),
        SearchResult(
            id = "2",
            title = "Mobile UI Design Patterns",
            description = "Best practices for mobile user interface design",
            type = "image",
            category = "Images",
            size = "1.2 MB",
            sizeValue = 1.2,
            date = "2024-01-14",
            rating = 4.6,
            price = 29.99,
            image = "🖼️",
            url = "https://example.com/ui-patterns"
        ),
        SearchResult(
            id = "3",
            title = "JavaScript Tutorial Series",
            description = "Complete JavaScript tutorial for beginners",
            type = "video",
            category = "Videos",
            size = "150 MB",
            sizeValue = 150.0,
            date = "2024-01-13",
            rating = 4.9,
            price = 49.99,
            image = "🎥",
            url = "https://example.com/js-tutorial"
        )
    )

    Scaffold(
        topBar = {
            TopAppBar(
                title = { Text("Search") }
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
                onSearch = { performSearch(searchQuery, selectedFilters, selectedCategory, sampleResults) { results ->
                    searchResults = results
                } }
            )

            // Filters
            FiltersSection(
                filters = filters,
                selectedFilters = selectedFilters,
                onFilterToggle = { filterId ->
                    selectedFilters = if (selectedFilters.contains(filterId)) {
                        selectedFilters - filterId
                    } else {
                        selectedFilters + filterId
                    }
                    performSearch(searchQuery, selectedFilters, selectedCategory, sampleResults) { results ->
                        searchResults = results
                    }
                },
                onAdvancedFiltersClick = { showAdvancedFilters = true }
            )

            // Sort and View
            SortAndViewSection(
                sortOption = sortOption,
                onSortChange = { sortOption = it },
                viewMode = viewMode,
                onViewModeChange = { viewMode = it }
            )

            // Results
            ResultsSection(
                searchResults = searchResults,
                isLoading = isLoading,
                searchQuery = searchQuery,
                onResultClick = { result ->
                    selectedResult = result
                    showResultDetails = true
                },
                onClearFilters = {
                    selectedFilters = emptySet()
                    selectedCategory = "All"
                    searchQuery = ""
                    searchResults = emptyList()
                }
            )
        }
    }

    // Advanced Filters Dialog
    if (showAdvancedFilters) {
        AdvancedFiltersDialog(
            selectedCategory = selectedCategory,
            onCategoryChange = { selectedCategory = it },
            onApply = {
                performSearch(searchQuery, selectedFilters, selectedCategory, sampleResults) { results ->
                    searchResults = results
                }
                showAdvancedFilters = false
            },
            onDismiss = { showAdvancedFilters = false }
        )
    }

    // Result Details Dialog
    if (showResultDetails && selectedResult != null) {
        ResultDetailsDialog(
            result = selectedResult!!,
            onDismiss = { showResultDetails = false }
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
        placeholder = { Text("Search for anything...") },
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
fun FiltersSection(
    filters: List<Filter>,
    selectedFilters: Set<String>,
    onFilterToggle: (String) -> Unit,
    onAdvancedFiltersClick: () -> Unit
) {
    LazyRow(
        modifier = Modifier
            .fillMaxWidth()
            .padding(horizontal = 16.dp),
        horizontalArrangement = Arrangement.spacedBy(8.dp)
    ) {
        item {
            FilterChip(
                onClick = onAdvancedFiltersClick,
                label = { 
                    Row(verticalAlignment = Alignment.CenterVertically) {
                        Text("Filters")
                        if (selectedFilters.isNotEmpty()) {
                            Spacer(modifier = Modifier.width(4.dp))
                            Box(
                                modifier = Modifier
                                    .size(16.dp)
                                    .background(MaterialTheme.colorScheme.error, CircleShape),
                                contentAlignment = Alignment.Center
                            ) {
                                Text(
                                    text = "${selectedFilters.size}",
                                    color = MaterialTheme.colorScheme.onError,
                                    style = MaterialTheme.typography.labelSmall
                                )
                            }
                        }
                    }
                },
                selected = false
            )
        }
        items(filters) { filter ->
            FilterChip(
                onClick = { onFilterToggle(filter.id) },
                label = { Text(filter.name) },
                selected = selectedFilters.contains(filter.id)
            )
        }
    }
}

@Composable
fun SortAndViewSection(
    sortOption: String,
    onSortChange: (String) -> Unit,
    viewMode: ViewMode,
    onViewModeChange: (ViewMode) -> Unit
) {
    Row(
        modifier = Modifier
            .fillMaxWidth()
            .padding(16.dp),
        horizontalArrangement = Arrangement.SpaceBetween,
        verticalAlignment = Alignment.CenterVertically
    ) {
        Row(verticalAlignment = Alignment.CenterVertically) {
            Text(
                text = "Sort by:",
                style = MaterialTheme.typography.labelMedium,
                color = MaterialTheme.colorScheme.onSurfaceVariant
            )
            Spacer(modifier = Modifier.width(8.dp))
            var expanded by remember { mutableStateOf(false) }
            Box {
                TextButton(onClick = { expanded = true }) {
                    Text(sortOption.capitalize())
                    Icon(Icons.Default.ArrowDropDown, contentDescription = null)
                }
                DropdownMenu(
                    expanded = expanded,
                    onDismissRequest = { expanded = false }
                ) {
                    listOf("relevance", "date", "name", "size", "type", "rating").forEach { option ->
                        DropdownMenuItem(
                            text = { Text(option.capitalize()) },
                            onClick = {
                                onSortChange(option)
                                expanded = false
                            }
                        )
                    }
                }
            }
        }

        Row {
            ViewMode.values().forEach { mode ->
                IconButton(
                    onClick = { onViewModeChange(mode) },
                    modifier = Modifier.background(
                        if (viewMode == mode) MaterialTheme.colorScheme.primary.copy(alpha = 0.1f) else Color.Transparent,
                        RoundedCornerShape(6.dp)
                    )
                ) {
                    Icon(
                        imageVector = when (mode) {
                            ViewMode.LIST -> Icons.Default.List
                            ViewMode.GRID -> Icons.Default.GridView
                            ViewMode.COMPACT -> Icons.Default.ViewList
                        },
                        contentDescription = null,
                        tint = if (viewMode == mode) MaterialTheme.colorScheme.primary else MaterialTheme.colorScheme.onSurface
                    )
                }
            }
        }
    }
}

@Composable
fun ResultsSection(
    searchResults: List<SearchResult>,
    isLoading: Boolean,
    searchQuery: String,
    onResultClick: (SearchResult) -> Unit,
    onClearFilters: () -> Unit
) {
    when {
        isLoading -> {
            Box(
                modifier = Modifier.fillMaxSize(),
                contentAlignment = Alignment.Center
            ) {
                Column(horizontalAlignment = Alignment.CenterHorizontally) {
                    CircularProgressIndicator()
                    Spacer(modifier = Modifier.height(16.dp))
                    Text("Searching...")
                }
            }
        }
        searchResults.isEmpty() && searchQuery.isNotEmpty() -> {
            EmptyStateView(
                title = "No results found",
                message = "Try adjusting your search terms or filters",
                actionText = "Clear all filters",
                onActionClick = onClearFilters
            )
        }
        searchResults.isEmpty() -> {
            EmptyStateView(
                title = "Search for anything",
                message = "Enter a search term to find documents, images, videos, and more"
            )
        }
        else -> {
            LazyColumn(
                modifier = Modifier.fillMaxSize(),
                contentPadding = PaddingValues(16.dp),
                verticalArrangement = Arrangement.spacedBy(8.dp)
            ) {
                items(searchResults) { result ->
                    SearchResultCard(
                        result = result,
                        onClick = { onResultClick(result) }
                    )
                }
            }
        }
    }
}

@Composable
fun EmptyStateView(
    title: String,
    message: String,
    actionText: String? = null,
    onActionClick: (() -> Unit)? = null
) {
    Box(
        modifier = Modifier.fillMaxSize(),
        contentAlignment = Alignment.Center
    ) {
        Column(
            horizontalAlignment = Alignment.CenterHorizontally,
            modifier = Modifier.padding(32.dp)
        ) {
            Icon(
                Icons.Default.Search,
                contentDescription = null,
                modifier = Modifier.size(64.dp),
                tint = MaterialTheme.colorScheme.onSurfaceVariant
            )
            Spacer(modifier = Modifier.height(16.dp))
            Text(
                text = title,
                style = MaterialTheme.typography.headlineSmall,
                textAlign = TextAlign.Center
            )
            Spacer(modifier = Modifier.height(8.dp))
            Text(
                text = message,
                style = MaterialTheme.typography.bodyMedium,
                color = MaterialTheme.colorScheme.onSurfaceVariant,
                textAlign = TextAlign.Center
            )
            if (actionText != null && onActionClick != null) {
                Spacer(modifier = Modifier.height(24.dp))
                TextButton(onClick = onActionClick) {
                    Text(actionText)
                }
            }
        }
    }
}

@Composable
fun SearchResultCard(
    result: SearchResult,
    onClick: () -> Unit
) {
    Card(
        modifier = Modifier
            .fillMaxWidth()
            .clickable { onClick() },
        elevation = CardDefaults.cardElevation(defaultElevation = 2.dp)
    ) {
        Row(
            modifier = Modifier
                .fillMaxWidth()
                .padding(16.dp),
            verticalAlignment = Alignment.Top
        ) {
            > 0) {
                    Spacer(modifier = Modifier.height(4.dp))
                    Text(
                        text = "$${String.format("%.2f", result.price)}",
                        style = MaterialTheme.typography.titleMedium,
                        color = MaterialTheme.colorScheme.primary,
                        fontWeight = FontWeight.SemiBold
                    )
                }
            }

            Icon(
                Icons.Default.ChevronRight,
                contentDescription = null,
                tint = MaterialTheme.colorScheme.onSurfaceVariant
            )
        }
    }
}

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun AdvancedFiltersDialog(
    selectedCategory: String,
    onCategoryChange: (String) -> Unit,
    onApply: () -> Unit,
    onDismiss: () -> Unit
) {
    val categories = listOf("All", "Documents", "Images", "Videos", "Audio", "Web Pages", "News", "Products", "People", "Locations")

    AlertDialog(
        onDismissRequest = onDismiss,
        title = { Text("Filters") },
        text = {
            Column {
                Text(
                    text = "Category",
                    style = MaterialTheme.typography.titleMedium,
                    fontWeight = FontWeight.SemiBold
                )
                Spacer(modifier = Modifier.height(8.dp))
                var expanded by remember { mutableStateOf(false) }
                Box {
                    OutlinedTextField(
                        value = selectedCategory,
                        onValueChange = { },
                        readOnly = true,
                        trailingIcon = {
                            Icon(Icons.Default.ArrowDropDown, contentDescription = null)
                        },
                        modifier = Modifier
                            .fillMaxWidth()
                            .clickable { expanded = true }
                    )
                    DropdownMenu(
                        expanded = expanded,
                        onDismissRequest = { expanded = false }
                    ) {
                        categories.forEach { category ->
                            DropdownMenuItem(
                                text = { Text(category) },
                                onClick = {
                                    onCategoryChange(category)
                                    expanded = false
                                }
                            )
                        }
                    }
                }
            }
        },
        confirmButton = {
            TextButton(onClick = onApply) {
                Text("Apply")
            }
        },
        dismissButton = {
            TextButton(onClick = onDismiss) {
                Text("Cancel")
            }
        }
    )
}

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun ResultDetailsDialog(
    result: SearchResult,
    onDismiss: () -> Unit
) {
    AlertDialog(
        onDismissRequest = onDismiss,
        title = { Text(result.title) },
        text = {
            Column {
                Text(
                    text = result.description,
                    style = MaterialTheme.typography.bodyMedium
                )
                Spacer(modifier = Modifier.height(16.dp))
                Text(
                    text = "Details",
                    style = MaterialTheme.typography.titleMedium,
                    fontWeight = FontWeight.SemiBold
                )
                Spacer(modifier = Modifier.height(8.dp))
                DetailRow("Type", result.type.capitalize())
                DetailRow("Category", result.category)
                DetailRow("Size", result.size)
                DetailRow("Date", result.date)
                DetailRow("Rating", "${String.format("%.1f", result.rating)}/5")
                DetailRow("Price", if (result.price > 0) "$${String.format("%.2f", result.price)}" else "Free")
            }
        },
        confirmButton = {
            TextButton(onClick = onDismiss) {
                Text("Close")
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

// Helper function
fun performSearch(
    query: String,
    selectedFilters: Set<String>,
    selectedCategory: String,
    sampleResults: List<SearchResult>,
    onResults: (List<SearchResult>) -> Unit
) {
    // Simulate search logic
    var filteredResults = sampleResults

    // Apply search query filter
    if (query.isNotEmpty()) {
        filteredResults = filteredResults.filter { result ->
            result.title.contains(query, ignoreCase = true) ||
            result.description.contains(query, ignoreCase = true)
        }
    }

    // Apply category filter
    if (selectedCategory != "All") {
        filteredResults = filteredResults.filter { it.category == selectedCategory }
    }

    // Apply selected filters
    selectedFilters.forEach { filterId ->
        when (filterId) {
            "free" -> filteredResults = filteredResults.filter { it.price == 0.0 }
            "premium" -> filteredResults = filteredResults.filter { it.price > 0.0 }
            "large" -> filteredResults = filteredResults.filter { it.sizeValue > 1.0 }
            "images" -> filteredResults = filteredResults.filter { it.type == "image" }
            "videos" -> filteredResults = filteredResults.filter { it.type == "video" }
            "documents" -> filteredResults = filteredResults.filter { it.type == "document" }
        }
    }

    onResults(filteredResults)
}

// Data classes
data class Filter(
    val id: String,
    val name: String,
    val type: String
)

data class SearchResult(
    val id: String,
    val title: String,
    val description: String,
    val type: String,
    val category: String,
    val size: String,
    val sizeValue: Double,
    val date: String,
    val rating: Double,
    val price: Double,
    val image: String,
    val url: String
)

enum class ViewMode {
    LIST, GRID, COMPACT
}

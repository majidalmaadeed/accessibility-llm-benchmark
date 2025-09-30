import androidx.compose.foundation.background
import androidx.compose.foundation.border
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Search
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.input.ImeAction
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
data class SearchResult(
    val id: Int,
    val title: String,
    val category: String,
    val author: String
)
@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun SearchWithSilentUpdates() {
    val mockData = listOf(
        SearchResult(1, "React Development Guide", "Books", "John Doe"),
        SearchResult(2, "Vue.js Tutorial", "Books", "Jane Smith"),
        SearchResult(3, "Angular Framework", "Books", "Bob Johnson"),
        SearchResult(4, "JavaScript Fundamentals", "Books", "Alice Brown"),
        SearchResult(5, "React Components", "Tutorials", "Charlie Wilson"),
        SearchResult(6, "Vue Components", "Tutorials", "Diana Lee"),
        SearchResult(7, "Angular Services", "Tutorials", "Eve Davis"),
        SearchResult(8, "JavaScript ES6", "Tutorials", "Frank Miller")
    )
    val handleInput = { newQuery: String ->
        query = newQuery
        if (newQuery.length > 1) {
            val filtered = mockData.filter { item ->
                item.title.contains(newQuery, ignoreCase = true) ||
                item.category.contains(newQuery, ignoreCase = true) ||
                item.author.contains(newQuery, ignoreCase = true)
            }
            suggestions = filtered.take(5)
            showSuggestions = true
            activeSuggestionIndex = -1
        } else {
            suggestions = emptyList()
            showSuggestions = false
            activeSuggestionIndex = -1
        }
    }
    val handleSearch = {
        isLoading = true
        // Simulate API call
        androidx.compose.runtime.LaunchedEffect(Unit) {
            kotlinx.coroutines.delay(1000)
            val filtered = mockData.filter { item ->
                item.title.contains(query, ignoreCase = true) ||
                item.category.contains(query, ignoreCase = true) ||
                item.author.contains(query, ignoreCase = true)
            }
            results = filtered
            isLoading = false
            showSuggestions = false
            activeSuggestionIndex = -1
        }
    }
    val handleSuggestionClick = { suggestion: SearchResult ->
        query = suggestion.title
        showSuggestions = false
        activeSuggestionIndex = -1
        handleSearch()
    }
    Column(
        modifier = Modifier
            .fillMaxSize()
            .background(Color(0xFFF5F5F5))
            .padding(20.dp),
        verticalArrangement = Arrangement.spacedBy(20.dp)
    ) {
        Card(
            modifier = Modifier.fillMaxWidth(),
            colors = CardDefaults.cardColors(containerColor = Color.White),
            elevation = CardDefaults.cardElevation(defaultElevation = 4.dp)
        ) {
            Column(
                modifier = Modifier.padding(30.dp),
                verticalArrangement = Arrangement.spacedBy(20.dp)
            ) {
                Text(
                    text = "Search Interface",
                    fontSize = 24.sp,
                    fontWeight = FontWeight.Bold,
                    color = Color(0xFF333333)
                )
                Text(
                    fontSize = 16.sp,
                    color = Color(0xFF666666)
                )
                // Search Input Section
                Column(
                    verticalArrangement = Arrangement.spacedBy(8.dp)
                ) {
                    Text(
                        text = "Search for content:",
                        fontSize = 18.sp,
                        fontWeight = FontWeight.Bold,
                        color = Color(0xFF333333)
                    )
                    Box {
                        OutlinedTextField(
                            value = query,
                            onValueChange = handleInput,
                            placeholder = { Text("Type to search...") },
                            leadingIcon = {
                                Icon(
                                    imageVector = Icons.Default.Search,
                                    contentDescription = "Search icon"
                                )
                            },
                            modifier = Modifier
                                .fillMaxWidth()
                                    contentDescription = "Search input field"
                                },
                                onSearch = { handleSearch() }
                            )
                        )
                        if (showSuggestions && suggestions.isNotEmpty()) {
                            Card(
                                modifier = Modifier
                                    .fillMaxWidth()
                                    .offset(y = 60.dp),
                                colors = CardDefaults.cardColors(containerColor = Color.White),
                                elevation = CardDefaults.cardElevation(defaultElevation = 8.dp),
                                shape = RoundedCornerShape(bottomStart = 8.dp, bottomEnd = 8.dp)
                            ) {
                                Column {
                                    suggestions.forEachIndexed { index, suggestion ->
                                        Row(
                                            modifier = Modifier
                                                .fillMaxWidth()
                                                .clickable { handleSuggestionClick(suggestion) }
                                                .padding(12.dp)
                                                .background(
                                                    if (index == activeSuggestionIndex) Color(0xFFF8F9FA) else Color.Transparent
                                                )
                                                    contentDescription = "${suggestion.title}, ${suggestion.category}, ${suggestion.author}"
                                                },
                                            verticalAlignment = Alignment.CenterVertically
                                        ) {
                                            Column(
                                                modifier = Modifier.weight(1f)
                                            ) {
                                                Text(
                                                    text = suggestion.title,
                                                    fontSize = 16.sp,
                                                    fontWeight = FontWeight.SemiBold,
                                                    color = Color(0xFF333333)
                                                )
                                                Text(
                                                    text = "${suggestion.category} • ${suggestion.author}",
                                                    fontSize = 12.sp,
                                                    color = Color(0xFF666666)
                                                )
                                            }
                                        }
                                        if (index < suggestions.size - 1) {
                                            Divider(
                                                color = Color(0xFFEEEEEE),
                                                thickness = 1.dp
                                            )
                                        }
                                    }
                                }
                            }
                        }
                    }
                    Button(
                        onClick = handleSearch,
                        enabled = !isLoading && query.trim().isNotEmpty(),
                        modifier = Modifier
                            .fillMaxWidth()
                            .height(48.dp),
                        colors = ButtonDefaults.buttonColors(
                            containerColor = if (isLoading) Color(0xFF6C757D) else Color(0xFF007BFF)
                        )
                    ) {
                        if (isLoading) {
                            CircularProgressIndicator(
                                modifier = Modifier.size(20.dp),
                                color = Color.White,
                                strokeWidth = 2.dp
                            )
                            Spacer(modifier = Modifier.width(8.dp))
                        }
                        Text(
                            text = if (isLoading) "Searching..." else "Search",
                            fontSize = 16.sp,
                            color = Color.White
                        )
                    }
                }
                Column(
                    verticalArrangement = Arrangement.spacedBy(16.dp)
                ) {
                    Text(
                        text = "Search Results",
                        fontSize = 20.sp,
                        fontWeight = FontWeight.Bold,
                        color = Color(0xFF333333)
                    )
                    when {
                        isLoading -> {
                            Column(
                                modifier = Modifier.fillMaxWidth(),
                                horizontalAlignment = Alignment.CenterHorizontally,
                                verticalArrangement = Arrangement.spacedBy(16.dp)
                            ) {
                                CircularProgressIndicator()
                                Text(
                                    text = "Searching...",
                                    fontSize = 16.sp,
                                    color = Color(0xFF666666)
                                )
                            }
                        }
                        results.isNotEmpty() -> {
                            Column(
                                verticalArrangement = Arrangement.spacedBy(12.dp)
                            ) {
                                Text(
                                    text = "Found ${results.size} result${if (results.size != 1) "s" else ""}",
                                    fontSize = 14.sp,
                                    color = Color(0xFF666666)
                                )
                                LazyColumn(
                                    verticalArrangement = Arrangement.spacedBy(12.dp),
                                    modifier = Modifier.height(300.dp)
                                ) {
                                    items(results) { result ->
                                        Card(
                                            modifier = Modifier.fillMaxWidth(),
                                            colors = CardDefaults.cardColors(containerColor = Color(0xFFF8F9FA)),
                                            elevation = CardDefaults.cardElevation(defaultElevation = 2.dp),
                                            shape = RoundedCornerShape(8.dp)
                                        ) {
                                            Column(
                                                modifier = Modifier.padding(16.dp),
                                                verticalArrangement = Arrangement.spacedBy(8.dp)
                                            ) {
                                                Text(
                                                    text = result.title,
                                                    fontSize = 16.sp,
                                                    fontWeight = FontWeight.SemiBold,
                                                    color = Color(0xFF333333)
                                                )
                                                Text(
                                                    text = "Category: ${result.category}",
                                                    fontSize = 12.sp,
                                                    color = Color(0xFF666666)
                                                )
                                                Text(
                                                    text = "Author: ${result.author}",
                                                    fontSize = 12.sp,
                                                    color = Color(0xFF666666)
                                                )
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        query.isNotEmpty() -> {
                            Column(
                                modifier = Modifier.fillMaxWidth(),
                                horizontalAlignment = Alignment.CenterHorizontally
                            ) {
                                Text(
                                    text = "No results found for \"$query\"",
                                    fontSize = 16.sp,
                                    color = Color(0xFF666666),
                                    textAlign = TextAlign.Center
                                )
                            }
                        }
                        else -> {
                            Column(
                                modifier = Modifier.fillMaxWidth(),
                                horizontalAlignment = Alignment.CenterHorizontally
                            ) {
                                Text(
                                    text = "Enter a search term to find content",
                                    fontSize = 16.sp,
                                    color = Color(0xFF666666),
                                    textAlign = TextAlign.Center
                                )
                            }
                        }
                    }
                }
            }
        }
        Card(
            modifier = Modifier.fillMaxWidth(),
            colors = CardDefaults.cardColors(containerColor = Color(0xFFE9ECEF)),
            shape = RoundedCornerShape(8.dp)
        ) {
            Column(
                modifier = Modifier.padding(20.dp),
                verticalArrangement = Arrangement.spacedBy(12.dp)
            ) {
                Text(
                }
                Text(
                    text = "How to Fix:",
                    fontSize = 18.sp,
                    fontWeight = FontWeight.Bold,
                    color = Color(0xFF333333)
                )
                Column(
                    verticalArrangement = Arrangement.spacedBy(8.dp)
                ) {
                }
            }
        }
    }
}
@Composable
    Row(
        verticalAlignment = Alignment.Top,
        horizontalArrangement = Arrangement.spacedBy(8.dp)
    ) {
        Text(
            text = "•",
            fontWeight = FontWeight.Bold,
            color = Color(0xFF333333)
        )
        Text(
            text = text,
            fontSize = 14.sp,
            color = Color(0xFF333333)
        )
    }
}
@Composable
private fun fixItem(text: String) {
    Row(
        verticalAlignment = Alignment.Top,
        horizontalArrangement = Arrangement.spacedBy(8.dp)
    ) {
        Text(
            text = "•",
            fontWeight = FontWeight.Bold,
            color = Color(0xFF333333)
        )
        Text(
            text = text,
            fontSize = 14.sp,
            color = Color(0xFF333333)
        )
    }
}
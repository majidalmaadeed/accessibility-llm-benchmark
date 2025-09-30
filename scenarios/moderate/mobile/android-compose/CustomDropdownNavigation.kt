import androidx.compose.foundation.background
import androidx.compose.foundation.border
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.grid.GridCells
import androidx.compose.foundation.lazy.grid.LazyVerticalGrid
import androidx.compose.foundation.lazy.grid.items
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.ArrowDropDown
import androidx.compose.material.icons.filled.ArrowDropUp
import androidx.compose.material.icons.filled.Check
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
data class Product(
    val name: String,
    val category: String
)
data class Option(
    val value: String,
    val text: String
)
@OptIn(ExperimentalMaterial3Api::class)
@Composable
    val options = listOf(
        Option("all", "All Categories"),
        Option("electronics", "Electronics"),
        Option("clothing", "Clothing"),
        Option("books", "Books"),
        Option("home", "Home & Garden")
    )
    val products = mapOf(
        "all" to listOf(
            Product("iPhone 15", "Electronics"),
            Product("MacBook Pro", "Electronics"),
            Product("Cotton T-Shirt", "Clothing"),
            Product("JavaScript Guide", "Books"),
            Product("Garden Tools", "Home & Garden")
        ),
        "electronics" to listOf(
            Product("iPhone 15", "Electronics"),
            Product("MacBook Pro", "Electronics")
        ),
        "clothing" to listOf(
            Product("Cotton T-Shirt", "Clothing")
        ),
        "books" to listOf(
            Product("JavaScript Guide", "Books")
        ),
        "home" to listOf(
            Product("Garden Tools", "Home & Garden")
        )
    )
    val filteredProducts = products[selectedValue] ?: emptyList()
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
                    text = "Product Filter",
                    fontSize = 24.sp,
                    fontWeight = FontWeight.Bold,
                    color = Color(0xFF333333)
                )
                Text(
                    fontSize = 16.sp,
                    color = Color(0xFF666666)
                )
                Column(
                    verticalArrangement = Arrangement.spacedBy(8.dp)
                ) {
                    Text(
                        text = "Filter by Category:",
                        fontSize = 18.sp,
                        fontWeight = FontWeight.Bold,
                        color = Color(0xFF333333)
                    )
                    // Custom Dropdown Implementation
                    Box {
                        Button(
                            onClick = { isOpen = !isOpen },
                            modifier = Modifier
                                .fillMaxWidth(0.5f)
                                .height(44.dp)
                                    contentDescription = "Category filter, $selectedText, double tap to open dropdown"
                                },
                            colors = ButtonDefaults.buttonColors(
                                containerColor = Color(0xFFF8F9FA)
                            ),
                            shape = RoundedCornerShape(8.dp),
                            border = androidx.compose.foundation.BorderStroke(
                                2.dp,
                                if (isOpen) Color(0xFF007BFF) else Color(0xFFDDDDDD)
                            )
                        ) {
                            Row(
                                modifier = Modifier.fillMaxWidth(),
                                horizontalArrangement = Arrangement.SpaceBetween,
                                verticalAlignment = Alignment.CenterVertically
                            ) {
                                Text(
                                    text = selectedText,
                                    color = Color(0xFF333333),
                                    fontSize = 16.sp
                                )
                                Icon(
                                    imageVector = if (isOpen) Icons.Default.ArrowDropUp else Icons.Default.ArrowDropDown,
                                    contentDescription = if (isOpen) "Close dropdown" else "Open dropdown",
                                    tint = Color(0xFF666666)
                                )
                            }
                        }
                        // Dropdown Options
                        if (isOpen) {
                            Card(
                                modifier = Modifier
                                    .fillMaxWidth(0.5f)
                                    .offset(y = 44.dp),
                                colors = CardDefaults.cardColors(containerColor = Color.White),
                                elevation = CardDefaults.cardElevation(defaultElevation = 8.dp),
                                shape = RoundedCornerShape(bottomStart = 8.dp, bottomEnd = 8.dp)
                            ) {
                                Column {
                                    options.forEachIndexed { index, option ->
                                        Row(
                                            modifier = Modifier
                                                .fillMaxWidth()
                                                .clickable {
                                                    selectOption(
                                                        value = option.value,
                                                        text = option.text,
                                                        index = index,
                                                        selectedValue = { selectedValue = it },
                                                        selectedText = { selectedText = it },
                                                        currentIndex = { currentIndex = it },
                                                        isOpen = { isOpen = it }
                                                    )
                                                }
                                                .padding(12.dp)
                                                .background(
                                                    if (selectedValue == option.value) Color(0xFF007BFF) else Color.Transparent
                                                )
                                                    contentDescription = option.text
                                                    if (selectedValue == option.value) {
                                                        selected()
                                                    }
                                                },
                                            horizontalArrangement = Arrangement.SpaceBetween,
                                            verticalAlignment = Alignment.CenterVertically
                                        ) {
                                            Text(
                                                text = option.text,
                                                color = if (selectedValue == option.value) Color.White else Color(0xFF333333),
                                                fontSize = 16.sp
                                            )
                                            if (selectedValue == option.value) {
                                                Icon(
                                                    imageVector = Icons.Default.Check,
                                                    contentDescription = "Selected",
                                                    tint = Color.White
                                                )
                                            }
                                        }
                                        if (index < options.size - 1) {
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
                }
                Column(
                    verticalArrangement = Arrangement.spacedBy(16.dp)
                ) {
                    Text(
                        text = "Filtered Results",
                        fontSize = 20.sp,
                        fontWeight = FontWeight.Bold,
                        color = Color(0xFF333333)
                    )
                    LazyVerticalGrid(
                        columns = GridCells.Adaptive(200.dp),
                        horizontalArrangement = Arrangement.spacedBy(16.dp),
                        verticalArrangement = Arrangement.spacedBy(16.dp),
                        modifier = Modifier.height(200.dp)
                    ) {
                        items(filteredProducts) { product ->
                            Card(
                                modifier = Modifier.fillMaxWidth(),
                                colors = CardDefaults.cardColors(containerColor = Color.White),
                                elevation = CardDefaults.cardElevation(defaultElevation = 2.dp),
                                shape = RoundedCornerShape(8.dp)
                            ) {
                                Column(
                                    modifier = Modifier.padding(20.dp),
                                    horizontalAlignment = Alignment.CenterHorizontally,
                                    verticalArrangement = Arrangement.spacedBy(8.dp)
                                ) {
                                    Text(
                                        text = product.name,
                                        fontSize = 16.sp,
                                        fontWeight = FontWeight.SemiBold,
                                        color = Color(0xFF333333),
                                        textAlign = TextAlign.Center
                                    )
                                    Text(
                                        text = product.category,
                                        fontSize = 12.sp,
                                        color = Color(0xFF666666),
                                        textAlign = TextAlign.Center
                                    )
                                }
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
                    fixItem("Handle Escape key to close dropdown")
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
private fun selectOption(
    value: String,
    text: String,
    index: Int,
    selectedValue: (String) -> Unit,
    selectedText: (String) -> Unit,
    currentIndex: (Int) -> Unit,
    isOpen: (Boolean) -> Unit
) {
    selectedValue(value)
    selectedText(text)
    currentIndex(index)
    isOpen(false)
}
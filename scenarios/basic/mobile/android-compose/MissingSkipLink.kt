package com.example.accessibilityscenarios

import androidx.compose.foundation.background
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
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
import androidx.compose.ui.unit.sp

@Composable
fun MissingSkipLinkScreen() {
    val navigationItems = listOf(
        NavItem("Home", Icons.Default.Home),
        NavItem("Products", Icons.Default.ShoppingBag),
        NavItem("Services", Icons.Default.Build),
        NavItem("About", Icons.Default.Info),
        NavItem("Contact", Icons.Default.ContactMail)
    )
    
    val products = listOf(
        Product(
            id = 1,
            name = "Wireless Headphones",
            price = "$99.99",
            description = "High-quality wireless headphones with noise cancellation"
        ),
        Product(
            id = 2,
            name = "Smart Watch",
            price = "$299.99",
            description = "Advanced fitness tracking and health monitoring"
        ),
        Product(
            id = 3,
            name = "Bluetooth Speaker",
            price = "$79.99",
            description = "Portable speaker with excellent sound quality"
        )
    )
    
    Column(
        modifier = Modifier
            .fillMaxSize()
            .background(Color(0xFFF5F5F5))
    ) {
        // Header with Navigation - MISSING SKIP LINK
        Card(
            modifier = Modifier
                .fillMaxWidth()
                .padding(16.dp),
            colors = CardDefaults.cardColors(containerColor = Color(0xFF1976D2))
        ) {
            Column(
                modifier = Modifier.padding(16.dp)
            ) {
                Text(
                    text = "Electronics Store",
                    fontSize = 24.sp,
                    fontWeight = FontWeight.Bold,
                    color = Color.White
                )
                Text(
                    text = "Your one-stop shop for tech products",
                    fontSize = 16.sp,
                    color = Color.White.copy(alpha = 0.9f)
                )
            }
        }
        
        // Navigation Menu - MISSING SKIP LINK
        Card(
            modifier = Modifier
                .fillMaxWidth()
                .padding(horizontal = 16.dp, vertical = 8.dp)
        ) {
            Row(
                modifier = Modifier
                    .fillMaxWidth()
                    .padding(16.dp),
                horizontalArrangement = Arrangement.SpaceEvenly
            ) {
                navigationItems.forEach { item ->
                    Column(
                        horizontalAlignment = Alignment.CenterHorizontally
                    ) {
                        IconButton(
                            onClick = { }
                        ) {
                            Icon(
                                imageVector = item.icon,
                                contentDescription = item.label,
                                tint = Color(0xFF1976D2),
                                modifier = Modifier.size(24.dp)
                            )
                        }
                        Text(
                            text = item.label,
                            fontSize = 12.sp,
                            color = Color(0xFF1976D2)
                        )
                    }
                }
            }
        }
        
        // Main Content
        LazyColumn(
            modifier = Modifier
                .fillMaxSize()
                .padding(horizontal = 16.dp),
            verticalArrangement = Arrangement.spacedBy(16.dp)
        ) {
            // Hero Section
            item {
                Card(
                    modifier = Modifier.fillMaxWidth(),
                    colors = CardDefaults.cardColors(containerColor = Color.White),
                    elevation = CardDefaults.cardElevation(defaultElevation = 4.dp)
                ) {
                    Column(
                        modifier = Modifier.padding(20.dp)
                    ) {
                        Text(
                            text = "Featured Products",
                            fontSize = 20.sp,
                            fontWeight = FontWeight.Bold,
                            color = Color(0xFF1976D2),
                            modifier = Modifier.padding(bottom = 12.dp)
                        )
                        Text(
                            text = "Discover our latest collection of cutting-edge technology products designed to enhance your digital lifestyle.",
                            fontSize = 16.sp,
                            color = Color.Gray,
                            lineHeight = 24.sp
                        )
                    }
                }
            }
            
            // Products List
            items(products) { product ->
                ProductCard(product = product)
            }
            
            // Footer
            item {
                Card(
                    modifier = Modifier.fillMaxWidth(),
                    colors = CardDefaults.cardColors(containerColor = Color(0xFF424242))
                ) {
                    Column(
                        modifier = Modifier.padding(20.dp)
                    ) {
                        Text(
                            text = "Contact Information",
                            fontSize = 18.sp,
                            fontWeight = FontWeight.Bold,
                            color = Color.White,
                            modifier = Modifier.padding(bottom = 12.dp)
                        )
                        Text(
                            text = "Email: info@electronicsstore.com",
                            fontSize = 14.sp,
                            color = Color.White.copy(alpha = 0.8f),
                            modifier = Modifier.padding(bottom = 4.dp)
                        )
                        Text(
                            text = "Phone: (555) 123-4567",
                            fontSize = 14.sp,
                            color = Color.White.copy(alpha = 0.8f),
                            modifier = Modifier.padding(bottom = 4.dp)
                        )
                        Text(
                            text = "Address: 123 Tech Street, Digital City, DC 12345",
                            fontSize = 14.sp,
                            color = Color.White.copy(alpha = 0.8f)
                        )
                    }
                }
            }
        }
    }
}

@Composable
fun ProductCard(product: Product) {
    Card(
        modifier = Modifier
            .fillMaxWidth()
            .clip(RoundedCornerShape(12.dp)),
        colors = CardDefaults.cardColors(containerColor = Color.White),
        elevation = CardDefaults.cardElevation(defaultElevation = 2.dp)
    ) {
        Row(
            modifier = Modifier
                .fillMaxWidth()
                .padding(16.dp),
            verticalAlignment = Alignment.CenterVertically
        ) {
            // Product Image
            Box(
                modifier = Modifier
                    .size(80.dp)
                    .background(Color(0xFFE0E0E0), RoundedCornerShape(8.dp)),
                contentAlignment = Alignment.Center
            ) {
                Icon(
                    imageVector = Icons.Default.Image,
                    contentDescription = "Product image of ${product.name}",
                    tint = Color.Gray,
                    modifier = Modifier.size(32.dp)
                )
            }
            
            Spacer(modifier = Modifier.width(16.dp))
            
            // Product Info
            Column(
                modifier = Modifier.weight(1f)
            ) {
                Text(
                    text = product.name,
                    fontSize = 18.sp,
                    fontWeight = FontWeight.Medium,
                    color = Color(0xFF1976D2)
                )
                Text(
                    text = product.description,
                    fontSize = 14.sp,
                    color = Color.Gray,
                    lineHeight = 20.sp,
                    modifier = Modifier.padding(vertical = 4.dp)
                )
                Text(
                    text = product.price,
                    fontSize = 16.sp,
                    fontWeight = FontWeight.Bold,
                    color = Color(0xFF4CAF50)
                )
            }
            
            // Action Button
            Button(
                onClick = { },
                colors = ButtonDefaults.buttonColors(containerColor = Color(0xFF1976D2))
            ) {
                Text("View Details")
            }
        }
    }
}

data class NavItem(
    val label: String,
    val icon: androidx.compose.ui.graphics.vector.ImageVector
)

data class Product(
    val id: Int,
    val name: String,
    val price: String,
    val description: String
)

package com.example.uicomponents

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
fun DecorativeImageWithAltTextScreen() {
    val products = listOf(
        Product(
            id = 1,
            name = "Premium Headphones",
            price = "$199.99",
            description = "High-quality wireless headphones with noise cancellation",
            rating = 4.8f,
            reviews = 324
        ),
        Product(
            id = 2,
            name = "Smart Watch",
            price = "$299.99",
            description = "Advanced fitness tracking and health monitoring",
            rating = 4.6f,
            reviews = 156
        ),
        Product(
            id = 3,
            name = "Bluetooth Speaker",
            price = "$89.99",
            description = "Portable speaker with excellent sound quality",
            rating = 4.4f,
            reviews = 89
        )
    )
    
    Column(
        modifier = Modifier
            .fillMaxSize()
            .background(Color(0xFFF5F5F5))
            .padding(16.dp)
    ) {
        // Header
        Card(
            modifier = Modifier
                .fillMaxWidth()
                .padding(bottom = 16.dp),
            colors = CardDefaults.cardColors(containerColor = Color(0xFF4CAF50))
        ) {
            Column(
                modifier = Modifier.padding(20.dp)
            ) {
                Text(
                    text = "Product Catalog",
                    fontSize = 24.sp,
                    fontWeight = FontWeight.Bold,
                    color = Color.White
                )
                Text(
                    text = "Discover our latest products",
                    fontSize = 16.sp,
                    color = Color.White.copy(alpha = 0.9f)
                )
            }
        }
        
        // Products List
        LazyColumn(
            verticalArrangement = Arrangement.spacedBy(16.dp)
        ) {
            items(products) { product ->
                ProductCard(product = product)
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
        elevation = CardDefaults.cardElevation(defaultElevation = 4.dp)
    ) {
        Column(
            modifier = Modifier.padding(16.dp)
        ) {
            // Product Image with Decorative Border
            Box(
                modifier = Modifier
                    .fillMaxWidth()
                    .height(200.dp)
                    .background(Color(0xFFE0E0E0), RoundedCornerShape(8.dp)),
                contentAlignment = Alignment.Center
            ) {
                // Main product image placeholder
                Icon(
                    imageVector = Icons.Default.Image,
                    contentDescription = "Product image of ${product.name}",
                    tint = Color.Gray,
                    modifier = Modifier.size(64.dp)
                )
                
                // Decorative border images - UNNECESSARY DESCRIPTIVE ALT TEXT
                Box(
                    modifier = Modifier
                        .fillMaxSize()
                        .background(Color.Transparent)
                ) {
                    // Decorative corner ornament - top left
                    Icon(
                        imageVector = Icons.Default.Star,
                        contentDescription = "Decorative star ornament in the top left corner of the product image border", // UNNECESSARY: Too descriptive for decorative element
                        tint = Color(0xFFFFC107).copy(alpha = 0.3f),
                        modifier = Modifier
                            .size(16.dp)
                            .align(Alignment.TopStart)
                            .padding(8.dp)
                    )
                    
                    // Decorative corner ornament - top right
                    Icon(
                        imageVector = Icons.Default.Star,
                        contentDescription = "Decorative star ornament in the top right corner of the product image border", // UNNECESSARY: Too descriptive for decorative element
                        tint = Color(0xFFFFC107).copy(alpha = 0.3f),
                        modifier = Modifier
                            .size(16.dp)
                            .align(Alignment.TopEnd)
                            .padding(8.dp)
                    )
                    
                    // Decorative corner ornament - bottom left
                    Icon(
                        imageVector = Icons.Default.Star,
                        contentDescription = "Decorative star ornament in the bottom left corner of the product image border", // UNNECESSARY: Too descriptive for decorative element
                        tint = Color(0xFFFFC107).copy(alpha = 0.3f),
                        modifier = Modifier
                            .size(16.dp)
                            .align(Alignment.BottomStart)
                            .padding(8.dp)
                    )
                    
                    // Decorative corner ornament - bottom right
                    Icon(
                        imageVector = Icons.Default.Star,
                        contentDescription = "Decorative star ornament in the bottom right corner of the product image border", // UNNECESSARY: Too descriptive for decorative element
                        tint = Color(0xFFFFC107).copy(alpha = 0.3f),
                        modifier = Modifier
                            .size(16.dp)
                            .align(Alignment.BottomEnd)
                            .padding(8.dp)
                    )
                }
            }
            
            Spacer(modifier = Modifier.height(12.dp))
            
            // Product Info
            Text(
                text = product.name,
                fontSize = 18.sp,
                fontWeight = FontWeight.Bold,
                modifier = Modifier.padding(bottom = 4.dp)
            )
            
            Text(
                text = product.description,
                fontSize = 14.sp,
                color = Color.Gray,
                lineHeight = 20.sp,
                modifier = Modifier.padding(bottom = 8.dp)
            )
            
            // Rating
            Row(
                verticalAlignment = Alignment.CenterVertically,
                modifier = Modifier.padding(bottom = 12.dp)
            ) {
                repeat(5) { index ->
                    Icon(
                        imageVector = if (index < product.rating.toInt()) Icons.Default.Star else Icons.Default.StarBorder,
                        contentDescription = null,
                        tint = Color(0xFFFFC107),
                        modifier = Modifier.size(16.dp)
                    )
                }
                Spacer(modifier = Modifier.width(4.dp))
                Text(
                    text = "${product.rating} (${product.reviews} reviews)",
                    fontSize = 14.sp,
                    color = Color.Gray
                )
            }
            
            // Price and Action
            Row(
                modifier = Modifier.fillMaxWidth(),
                horizontalArrangement = Arrangement.SpaceBetween,
                verticalAlignment = Alignment.CenterVertically
            ) {
                Text(
                    text = product.price,
                    fontSize = 20.sp,
                    fontWeight = FontWeight.Bold,
                    color = Color(0xFF4CAF50)
                )
                
                Button(
                    onClick = { },
                    colors = ButtonDefaults.buttonColors(containerColor = Color(0xFF4CAF50))
                ) {
                    Icon(
                        imageVector = Icons.Default.ShoppingCart,
                        contentDescription = null,
                        modifier = Modifier.size(18.dp)
                    )
                    Spacer(modifier = Modifier.width(4.dp))
                    Text("Add to Cart")
                }
            }
        }
    }
}

data class Product(
    val id: Int,
    val name: String,
    val price: String,
    val description: String,
    val rating: Float,
    val reviews: Int
)

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
fun AutoPlayingBackgroundVideoScreen() {
    var isVideoPlaying by remember { mutableStateOf(true) }
    var videoTime by remember { mutableStateOf(0) }
    
    // Simulate video playing
    LaunchedEffect(Unit) {
        while (isVideoPlaying) {
            kotlinx.coroutines.delay(1000)
            videoTime++
        }
    }
    
    val features = listOf(
        Feature(
            title = "Advanced Analytics",
            description = "Get detailed insights into your business performance with our comprehensive analytics dashboard.",
            icon = Icons.Default.Analytics
        ),
        Feature(
            title = "Real-time Collaboration",
            description = "Work together with your team in real-time using our collaborative tools and features.",
            icon = Icons.Default.Group
        ),
        Feature(
            title = "Secure Cloud Storage",
            description = "Store your data securely in the cloud with enterprise-grade encryption and backup.",
            icon = Icons.Default.Cloud
        ),
        Feature(
            title = "Mobile Optimization",
            description = "Access your data and tools from anywhere with our mobile-optimized interface.",
            icon = Icons.Default.PhoneAndroid
        )
    )
    
    Box(
        modifier = Modifier.fillMaxSize()
    ) {
        // Background Video - AUTOPLAYING WITHOUT USER CONTROL
        Box(
            modifier = Modifier
                .fillMaxSize()
                .background(Color(0xFF1A1A1A))
        ) {
            // Simulated video background
            Box(
                modifier = Modifier
                    .fillMaxSize()
                    .background(
                        Color(0xFF2D2D2D),
                        RoundedCornerShape(0.dp)
                    ),
                contentAlignment = Alignment.Center
            ) {
                // Video placeholder with play indicator
                Column(
                    horizontalAlignment = Alignment.CenterHorizontally
                ) {
                    Icon(
                        imageVector = Icons.Default.PlayArrow,
                        contentDescription = null,
                        tint = Color.White.copy(alpha = 0.7f),
                        modifier = Modifier.size(48.dp)
                    )
                    Text(
                        text = "Background Video Playing",
                        color = Color.White.copy(alpha = 0.7f),
                        fontSize = 16.sp
                    )
                    Text(
                        text = "Time: ${videoTime}s",
                        color = Color.White.copy(alpha = 0.5f),
                        fontSize = 12.sp
                    )
                }
            }
            
            // Video overlay for content readability
            Box(
                modifier = Modifier
                    .fillMaxSize()
                    .background(Color.Black.copy(alpha = 0.4f))
            )
        }
        
        // Main Content
        Column(
            modifier = Modifier
                .fillMaxSize()
                .padding(16.dp)
        ) {
            // Header
            Card(
                modifier = Modifier
                    .fillMaxWidth()
                    .padding(bottom = 16.dp),
                colors = CardDefaults.cardColors(containerColor = Color.White.copy(alpha = 0.95f)),
                elevation = CardDefaults.cardElevation(defaultElevation = 8.dp)
            ) {
                Column(
                    modifier = Modifier.padding(20.dp)
                ) {
                    Text(
                        text = "Welcome to Our Platform",
                        fontSize = 28.sp,
                        fontWeight = FontWeight.Bold,
                        color = Color(0xFF1976D2)
                    )
                    Text(
                        text = "Experience the future of business management",
                        fontSize = 18.sp,
                        color = Color.Gray
                    )
                }
            }
            
            // Features Section
            Card(
                modifier = Modifier.fillMaxWidth(),
                colors = CardDefaults.cardColors(containerColor = Color.White.copy(alpha = 0.95f)),
                elevation = CardDefaults.cardElevation(defaultElevation = 8.dp)
            ) {
                Column(
                    modifier = Modifier.padding(20.dp)
                ) {
                    Text(
                        text = "Key Features",
                        fontSize = 24.sp,
                        fontWeight = FontWeight.Bold,
                        color = Color(0xFF1976D2),
                        modifier = Modifier.padding(bottom = 16.dp)
                    )
                    
                    LazyColumn(
                        verticalArrangement = Arrangement.spacedBy(16.dp)
                    ) {
                        items(features) { feature ->
                            FeatureCard(feature = feature)
                        }
                    }
                }
            }
        }
        
        // Video Controls - Hidden by default, no way to stop autoplay
        Box(
            modifier = Modifier
                .align(Alignment.BottomEnd)
                .padding(16.dp)
        ) {
            Card(
                colors = CardDefaults.cardColors(containerColor = Color.Black.copy(alpha = 0.7f)),
                elevation = CardDefaults.cardElevation(defaultElevation = 4.dp)
            ) {
                Row(
                    modifier = Modifier.padding(8.dp),
                    verticalAlignment = Alignment.CenterVertically
                ) {
                    IconButton(
                        onClick = { isVideoPlaying = !isVideoPlaying }
                    ) {
                        Icon(
                            imageVector = if (isVideoPlaying) Icons.Default.Pause else Icons.Default.PlayArrow,
                            contentDescription = if (isVideoPlaying) "Pause video" else "Play video",
                            tint = Color.White,
                            modifier = Modifier.size(20.dp)
                        )
                    }
                    
                    Text(
                        text = if (isVideoPlaying) "Pause" else "Play",
                        color = Color.White,
                        fontSize = 12.sp
                    )
                }
            }
        }
    }
}

@Composable
fun FeatureCard(feature: Feature) {
    Row(
        modifier = Modifier.fillMaxWidth(),
        verticalAlignment = Alignment.CenterVertically
    ) {
        Icon(
            imageVector = feature.icon,
            contentDescription = null,
            tint = Color(0xFF1976D2),
            modifier = Modifier.size(32.dp)
        )
        
        Spacer(modifier = Modifier.width(16.dp))
        
        Column(
            modifier = Modifier.weight(1f)
        ) {
            Text(
                text = feature.title,
                fontSize = 18.sp,
                fontWeight = FontWeight.Medium,
                color = Color(0xFF1976D2)
            )
            Text(
                text = feature.description,
                fontSize = 14.sp,
                color = Color.Gray,
                lineHeight = 20.sp
            )
        }
    }
}

data class Feature(
    val title: String,
    val description: String,
    val icon: androidx.compose.ui.graphics.vector.ImageVector
)

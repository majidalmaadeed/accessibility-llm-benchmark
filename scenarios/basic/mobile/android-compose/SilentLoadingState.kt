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
fun SilentLoadingStateScreen() {
    var isLoading by remember { mutableStateOf(false) }
    var data by remember { mutableStateOf<List<DataItem>>(emptyList()) }
    
    val loadData = {
        isLoading = true
        // Simulate API call
        kotlinx.coroutines.GlobalScope.launch {
            kotlinx.coroutines.delay(2000)
            data = listOf(
                DataItem(1, "Project Alpha", "In Progress", "2024-01-15"),
                DataItem(2, "Project Beta", "Completed", "2024-01-10"),
                DataItem(3, "Project Gamma", "Planning", "2024-01-20"),
                DataItem(4, "Project Delta", "In Progress", "2024-01-12")
            )
            isLoading = false
        }
    }
    
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
            colors = CardDefaults.cardColors(containerColor = Color(0xFF2196F3))
        ) {
            Column(
                modifier = Modifier.padding(20.dp)
            ) {
                Text(
                    text = "Project Dashboard",
                    fontSize = 24.sp,
                    fontWeight = FontWeight.Bold,
                    color = Color.White
                )
                Text(
                    text = "Track your project progress",
                    fontSize = 16.sp,
                    color = Color.White.copy(alpha = 0.9f)
                )
            }
        }
        
        // Action Buttons
        Card(
            modifier = Modifier
                .fillMaxWidth()
                .padding(bottom = 16.dp)
        ) {
            Row(
                modifier = Modifier
                    .fillMaxWidth()
                    .padding(16.dp),
                horizontalArrangement = Arrangement.spacedBy(12.dp)
            ) {
                Button(
                    onClick = loadData,
                    modifier = Modifier.weight(1f),
                    colors = ButtonDefaults.buttonColors(containerColor = Color(0xFF4CAF50))
                ) {
                    Icon(
                        imageVector = Icons.Default.Refresh,
                        contentDescription = null,
                        modifier = Modifier.size(18.dp)
                    )
                    Spacer(modifier = Modifier.width(4.dp))
                    Text("Load Data")
                }
                
                Button(
                    onClick = { data = emptyList() },
                    modifier = Modifier.weight(1f),
                    colors = ButtonDefaults.buttonColors(containerColor = Color(0xFFE53E3E))
                ) {
                    Icon(
                        imageVector = Icons.Default.Clear,
                        contentDescription = null,
                        modifier = Modifier.size(18.dp)
                    )
                    Spacer(modifier = Modifier.width(4.dp))
                    Text("Clear Data")
                }
            }
        }
        
        // Content Area
        Card(
            modifier = Modifier.fillMaxWidth()
        ) {
            Column(
                modifier = Modifier.padding(16.dp)
            ) {
                Text(
                    text = "Project List",
                    fontSize = 18.sp,
                    fontWeight = FontWeight.Bold,
                    color = Color(0xFF1976D2),
                    modifier = Modifier.padding(bottom = 16.dp)
                )
                
                if (isLoading) {
                    // Loading State - SILENT (No screen reader announcement)
                    Box(
                        modifier = Modifier
                            .fillMaxWidth()
                            .height(200.dp),
                        contentAlignment = Alignment.Center
                    ) {
                        Column(
                            horizontalAlignment = Alignment.CenterHorizontally
                        ) {
                            CircularProgressIndicator(
                                modifier = Modifier.size(48.dp),
                                color = Color(0xFF2196F3)
                            )
                            Spacer(modifier = Modifier.height(16.dp))
                            Text(
                                text = "Loading projects...",
                                fontSize = 16.sp,
                                color = Color.Gray
                            )
                            // MISSING: No screen reader announcement for loading state
                        }
                    }
                } else if (data.isEmpty()) {
                    // Empty State
                    Box(
                        modifier = Modifier
                            .fillMaxWidth()
                            .height(200.dp),
                        contentAlignment = Alignment.Center
                    ) {
                        Column(
                            horizontalAlignment = Alignment.CenterHorizontally
                        ) {
                            Icon(
                                imageVector = Icons.Default.FolderOpen,
                                contentDescription = null,
                                tint = Color.Gray,
                                modifier = Modifier.size(48.dp)
                            )
                            Spacer(modifier = Modifier.height(16.dp))
                            Text(
                                text = "No projects found",
                                fontSize = 16.sp,
                                color = Color.Gray
                            )
                            Text(
                                text = "Click 'Load Data' to fetch projects",
                                fontSize = 14.sp,
                                color = Color.Gray
                            )
                        }
                    }
                } else {
                    // Data List
                    LazyColumn(
                        verticalArrangement = Arrangement.spacedBy(8.dp)
                    ) {
                        items(data) { item ->
                            DataItemCard(item = item)
                        }
                    }
                }
            }
        }
    }
}

@Composable
fun DataItemCard(item: DataItem) {
    Card(
        modifier = Modifier
            .fillMaxWidth()
            .clip(RoundedCornerShape(8.dp)),
        colors = CardDefaults.cardColors(containerColor = Color.White),
        elevation = CardDefaults.cardElevation(defaultElevation = 2.dp)
    ) {
        Row(
            modifier = Modifier
                .fillMaxWidth()
                .padding(16.dp),
            verticalAlignment = Alignment.CenterVertically
        ) {
            // Status Icon
            Icon(
                imageVector = when (item.status) {
                    "Completed" -> Icons.Default.CheckCircle
                    "In Progress" -> Icons.Default.Schedule
                    "Planning" -> Icons.Default.Edit
                    else -> Icons.Default.Info
                },
                contentDescription = null,
                tint = when (item.status) {
                    "Completed" -> Color(0xFF4CAF50)
                    "In Progress" -> Color(0xFFFF9800)
                    "Planning" -> Color(0xFF2196F3)
                    else -> Color.Gray
                },
                modifier = Modifier.size(24.dp)
            )
            
            Spacer(modifier = Modifier.width(12.dp))
            
            // Item Info
            Column(
                modifier = Modifier.weight(1f)
            ) {
                Text(
                    text = item.name,
                    fontSize = 16.sp,
                    fontWeight = FontWeight.Medium,
                    color = Color(0xFF1976D2)
                )
                Text(
                    text = "Status: ${item.status}",
                    fontSize = 14.sp,
                    color = Color.Gray
                )
                Text(
                    text = "Updated: ${item.lastUpdated}",
                    fontSize = 12.sp,
                    color = Color.Gray
                )
            }
        }
    }
}

data class DataItem(
    val id: Int,
    val name: String,
    val status: String,
    val lastUpdated: String
)

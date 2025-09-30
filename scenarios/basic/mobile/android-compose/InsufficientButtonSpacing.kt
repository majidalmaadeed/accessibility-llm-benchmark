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
fun InsufficientButtonSpacingScreen() {
    val tasks = listOf(
        Task(
            id = 1,
            title = "Review Project Proposal",
            description = "Review the Q1 project proposal and provide feedback",
            priority = "High",
            dueDate = "2024-01-20"
        ),
        Task(
            id = 2,
            title = "Update Documentation",
            description = "Update API documentation for the new features",
            priority = "Medium",
            dueDate = "2024-01-22"
        ),
        Task(
            id = 3,
            title = "Team Meeting",
            description = "Weekly team standup meeting",
            priority = "Low",
            dueDate = "2024-01-18"
        ),
        Task(
            id = 4,
            title = "Code Review",
            description = "Review pull requests from the development team",
            priority = "High",
            dueDate = "2024-01-19"
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
            colors = CardDefaults.cardColors(containerColor = Color(0xFF2196F3))
        ) {
            Column(
                modifier = Modifier.padding(20.dp)
            ) {
                Text(
                    text = "Task Manager",
                    fontSize = 24.sp,
                    fontWeight = FontWeight.Bold,
                    color = Color.White
                )
                Text(
                    text = "Manage your daily tasks efficiently",
                    fontSize = 16.sp,
                    color = Color.White.copy(alpha = 0.9f)
                )
            }
        }
        
        // Tasks List
        LazyColumn(
            verticalArrangement = Arrangement.spacedBy(12.dp)
        ) {
            items(tasks) { task ->
                TaskCard(task = task)
            }
        }
    }
}

@Composable
fun TaskCard(task: Task) {
    Card(
        modifier = Modifier
            .fillMaxWidth()
            .clip(RoundedCornerShape(12.dp)),
        colors = CardDefaults.cardColors(containerColor = Color.White),
        elevation = CardDefaults.cardElevation(defaultElevation = 2.dp)
    ) {
        Column(
            modifier = Modifier.padding(16.dp)
        ) {
            // Task Header
            Row(
                modifier = Modifier
                    .fillMaxWidth()
                    .padding(bottom = 8.dp),
                horizontalArrangement = Arrangement.SpaceBetween,
                verticalAlignment = Alignment.CenterVertically
            ) {
                Text(
                    text = task.title,
                    fontSize = 18.sp,
                    fontWeight = FontWeight.Medium,
                    modifier = Modifier.weight(1f)
                )
                
                // Priority Badge
                Text(
                    text = task.priority,
                    fontSize = 12.sp,
                    color = when (task.priority) {
                        "High" -> Color(0xFFE53E3E)
                        "Medium" -> Color(0xFFFF9800)
                        "Low" -> Color(0xFF4CAF50)
                        else -> Color.Gray
                    },
                    modifier = Modifier
                        .background(
                            when (task.priority) {
                                "High" -> Color(0xFFE53E3E).copy(alpha = 0.1f)
                                "Medium" -> Color(0xFFFF9800).copy(alpha = 0.1f)
                                "Low" -> Color(0xFF4CAF50).copy(alpha = 0.1f)
                                else -> Color.Gray.copy(alpha = 0.1f)
                            },
                            RoundedCornerShape(4.dp)
                        )
                        .padding(horizontal = 8.dp, vertical = 4.dp)
                )
            }
            
            // Task Description
            Text(
                text = task.description,
                fontSize = 14.sp,
                color = Color.Gray,
                lineHeight = 20.sp,
                modifier = Modifier.padding(bottom = 8.dp)
            )
            
            // Due Date
            Row(
                verticalAlignment = Alignment.CenterVertically,
                modifier = Modifier.padding(bottom = 12.dp)
            ) {
                Icon(
                    imageVector = Icons.Default.Schedule,
                    contentDescription = null,
                    tint = Color.Gray,
                    modifier = Modifier.size(16.dp)
                )
                Spacer(modifier = Modifier.width(4.dp))
                Text(
                    text = "Due: ${task.dueDate}",
                    fontSize = 12.sp,
                    color = Color.Gray
                )
            }
            
            // Action Buttons - INSUFFICIENT SPACING
            Row(
                modifier = Modifier.fillMaxWidth(),
                horizontalArrangement = Arrangement.spacedBy(2.dp) // TOO SMALL: Only 2dp spacing instead of minimum 44dp
            ) {
                Button(
                    onClick = { },
                    modifier = Modifier.weight(1f),
                    colors = ButtonDefaults.buttonColors(containerColor = Color(0xFF4CAF50))
                ) {
                    Icon(
                        imageVector = Icons.Default.Check,
                        contentDescription = null,
                        modifier = Modifier.size(16.dp)
                    )
                    Spacer(modifier = Modifier.width(4.dp))
                    Text("Complete")
                }
                
                OutlinedButton(
                    onClick = { },
                    modifier = Modifier.weight(1f)
                ) {
                    Icon(
                        imageVector = Icons.Default.Edit,
                        contentDescription = null,
                        modifier = Modifier.size(16.dp)
                    )
                    Spacer(modifier = Modifier.width(4.dp))
                    Text("Edit")
                }
                
                OutlinedButton(
                    onClick = { },
                    modifier = Modifier.weight(1f)
                ) {
                    Icon(
                        imageVector = Icons.Default.Share,
                        contentDescription = null,
                        modifier = Modifier.size(16.dp)
                    )
                    Spacer(modifier = Modifier.width(4.dp))
                    Text("Share")
                }
                
                OutlinedButton(
                    onClick = { },
                    modifier = Modifier.weight(1f)
                ) {
                    Icon(
                        imageVector = Icons.Default.Delete,
                        contentDescription = null,
                        modifier = Modifier.size(16.dp)
                    )
                    Spacer(modifier = Modifier.width(4.dp))
                    Text("Delete")
                }
            }
        }
    }
}

data class Task(
    val id: Int,
    val title: String,
    val description: String,
    val priority: String,
    val dueDate: String
)

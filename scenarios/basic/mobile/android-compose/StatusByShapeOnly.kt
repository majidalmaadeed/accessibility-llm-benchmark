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
fun StatusByShapeOnlyScreen() {
    val documents = listOf(
        Document(
            id = 1,
            title = "Project Proposal.docx",
            status = DocumentStatus.APPROVED,
            lastModified = "2024-01-15",
            size = "2.4 MB"
        ),
        Document(
            id = 2,
            title = "Budget Report.xlsx",
            status = DocumentStatus.PENDING,
            lastModified = "2024-01-14",
            size = "1.8 MB"
        ),
        Document(
            id = 3,
            title = "Meeting Notes.pdf",
            status = DocumentStatus.REJECTED,
            lastModified = "2024-01-13",
            size = "856 KB"
        ),
        Document(
            id = 4,
            title = "Contract Template.docx",
            status = DocumentStatus.APPROVED,
            lastModified = "2024-01-12",
            size = "3.2 MB"
        ),
        Document(
            id = 5,
            title = "Invoice #12345.pdf",
            status = DocumentStatus.PENDING,
            lastModified = "2024-01-11",
            size = "1.1 MB"
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
                    text = "Document Management",
                    fontSize = 24.sp,
                    fontWeight = FontWeight.Bold,
                    color = Color.White
                )
                Text(
                    text = "Track document approval status",
                    fontSize = 16.sp,
                    color = Color.White.copy(alpha = 0.9f)
                )
            }
        }
        
        // Legend - Missing text descriptions
        Card(
            modifier = Modifier
                .fillMaxWidth()
                .padding(bottom = 16.dp)
        ) {
            Column(
                modifier = Modifier.padding(16.dp)
            ) {
                Text(
                    text = "Status Legend",
                    fontSize = 16.sp,
                    fontWeight = FontWeight.Bold,
                    modifier = Modifier.padding(bottom = 12.dp)
                )
                
                Row(
                    modifier = Modifier.fillMaxWidth(),
                    horizontalArrangement = Arrangement.SpaceEvenly
                ) {
                    // STATUS BY SHAPE ONLY - No text descriptions
                    Column(
                        horizontalAlignment = Alignment.CenterHorizontally
                    ) {
                        Box(
                            modifier = Modifier
                                .size(24.dp)
                                .background(Color(0xFF4CAF50), RoundedCornerShape(12.dp)), // Circle = Approved
                            contentAlignment = Alignment.Center
                        ) {
                            Icon(
                                imageVector = Icons.Default.Check,
                                contentDescription = null, // MISSING: No accessible description
                                tint = Color.White,
                                modifier = Modifier.size(16.dp)
                            )
                        }
                        Text(
                            text = "Approved", // MISSING: Should be programmatically associated
                            fontSize = 12.sp,
                            color = Color.Gray
                        )
                    }
                    
                    Column(
                        horizontalAlignment = Alignment.CenterHorizontally
                    ) {
                        Box(
                            modifier = Modifier
                                .size(24.dp)
                                .background(Color(0xFFFF9800), RoundedCornerShape(4.dp)), // Square = Pending
                            contentAlignment = Alignment.Center
                        ) {
                            Icon(
                                imageVector = Icons.Default.Schedule,
                                contentDescription = null, // MISSING: No accessible description
                                tint = Color.White,
                                modifier = Modifier.size(16.dp)
                            )
                        }
                        Text(
                            text = "Pending", // MISSING: Should be programmatically associated
                            fontSize = 12.sp,
                            color = Color.Gray
                        )
                    }
                    
                    Column(
                        horizontalAlignment = Alignment.CenterHorizontally
                    ) {
                        Box(
                            modifier = Modifier
                                .size(24.dp)
                                .background(Color(0xFFE53E3E), RoundedCornerShape(4.dp)), // Square = Rejected
                            contentAlignment = Alignment.Center
                        ) {
                            Icon(
                                imageVector = Icons.Default.Close,
                                contentDescription = null, // MISSING: No accessible description
                                tint = Color.White,
                                modifier = Modifier.size(16.dp)
                            )
                        }
                        Text(
                            text = "Rejected", // MISSING: Should be programmatically associated
                            fontSize = 12.sp,
                            color = Color.Gray
                        )
                    }
                }
            }
        }
        
        // Documents List
        LazyColumn(
            verticalArrangement = Arrangement.spacedBy(8.dp)
        ) {
            items(documents) { document ->
                DocumentCard(document = document)
            }
        }
    }
}

@Composable
fun DocumentCard(document: Document) {
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
            // Document Icon
            Icon(
                imageVector = Icons.Default.Description,
                contentDescription = null,
                tint = Color(0xFF1976D2),
                modifier = Modifier.size(24.dp)
            )
            
            Spacer(modifier = Modifier.width(12.dp))
            
            // Document Info
            Column(
                modifier = Modifier.weight(1f)
            ) {
                Text(
                    text = document.title,
                    fontSize = 16.sp,
                    fontWeight = FontWeight.Medium
                )
                Text(
                    text = "${document.lastModified} • ${document.size}",
                    fontSize = 12.sp,
                    color = Color.Gray
                )
            }
            
            // Status Indicator - STATUS BY SHAPE ONLY
            when (document.status) {
                DocumentStatus.APPROVED -> {
                    Box(
                        modifier = Modifier
                            .size(24.dp)
                            .background(Color(0xFF4CAF50), RoundedCornerShape(12.dp)), // Circle shape
                        contentAlignment = Alignment.Center
                    ) {
                        Icon(
                            imageVector = Icons.Default.Check,
                            contentDescription = null, // MISSING: No accessible description for status
                            tint = Color.White,
                            modifier = Modifier.size(16.dp)
                        )
                    }
                }
                DocumentStatus.PENDING -> {
                    Box(
                        modifier = Modifier
                            .size(24.dp)
                            .background(Color(0xFFFF9800), RoundedCornerShape(4.dp)), // Square shape
                        contentAlignment = Alignment.Center
                    ) {
                        Icon(
                            imageVector = Icons.Default.Schedule,
                            contentDescription = null, // MISSING: No accessible description for status
                            tint = Color.White,
                            modifier = Modifier.size(16.dp)
                        )
                    }
                }
                DocumentStatus.REJECTED -> {
                    Box(
                        modifier = Modifier
                            .size(24.dp)
                            .background(Color(0xFFE53E3E), RoundedCornerShape(4.dp)), // Square shape
                        contentAlignment = Alignment.Center
                    ) {
                        Icon(
                            imageVector = Icons.Default.Close,
                            contentDescription = null, // MISSING: No accessible description for status
                            tint = Color.White,
                            modifier = Modifier.size(16.dp)
                        )
                    }
                }
            }
        }
    }
}

enum class DocumentStatus {
    APPROVED,
    PENDING,
    REJECTED
}

data class Document(
    val id: Int,
    val title: String,
    val status: DocumentStatus,
    val lastModified: String,
    val size: String
)

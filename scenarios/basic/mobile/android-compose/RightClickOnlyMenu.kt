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
fun RightClickOnlyMenuScreen() {
    val files = listOf(
        FileItem(
            id = 1,
            name = "Project Proposal.docx",
            type = "Document",
            size = "2.4 MB",
            date = "2024-01-15"
        ),
        FileItem(
            id = 2,
            name = "Budget Report.xlsx",
            type = "Spreadsheet",
            size = "1.8 MB",
            date = "2024-01-14"
        ),
        FileItem(
            id = 3,
            name = "Meeting Notes.pdf",
            type = "Document",
            size = "856 KB",
            date = "2024-01-13"
        ),
        FileItem(
            id = 4,
            name = "Contract Template.docx",
            type = "Document",
            size = "3.2 MB",
            date = "2024-01-12"
        ),
        FileItem(
            id = 5,
            name = "Invoice #12345.pdf",
            type = "Document",
            size = "1.1 MB",
            date = "2024-01-11"
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
                    text = "File Manager",
                    fontSize = 24.sp,
                    fontWeight = FontWeight.Bold,
                    color = Color.White
                )
                Text(
                    text = "Manage your files and documents",
                    fontSize = 16.sp,
                    color = Color.White.copy(alpha = 0.9f)
                )
            }
        }
        
        // Toolbar
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
                    onClick = { },
                    modifier = Modifier.weight(1f),
                    colors = ButtonDefaults.buttonColors(containerColor = Color(0xFF4CAF50))
                ) {
                    Icon(
                        imageVector = Icons.Default.Add,
                        contentDescription = null,
                        modifier = Modifier.size(18.dp)
                    )
                    Spacer(modifier = Modifier.width(4.dp))
                    Text("New File")
                }
                
                Button(
                    onClick = { },
                    modifier = Modifier.weight(1f),
                    colors = ButtonDefaults.buttonColors(containerColor = Color(0xFF2196F3))
                ) {
                    Icon(
                        imageVector = Icons.Default.Upload,
                        contentDescription = null,
                        modifier = Modifier.size(18.dp)
                    )
                    Spacer(modifier = Modifier.width(4.dp))
                    Text("Upload")
                }
                
                Button(
                    onClick = { },
                    modifier = Modifier.weight(1f),
                    colors = ButtonDefaults.buttonColors(containerColor = Color(0xFFFF9800))
                ) {
                    Icon(
                        imageVector = Icons.Default.Download,
                        contentDescription = null,
                        modifier = Modifier.size(18.dp)
                    )
                    Spacer(modifier = Modifier.width(4.dp))
                    Text("Download")
                }
            }
        }
        
        // Files List
        Card(
            modifier = Modifier.fillMaxWidth()
        ) {
            Column(
                modifier = Modifier.padding(16.dp)
            ) {
                Text(
                    text = "Files",
                    fontSize = 18.sp,
                    fontWeight = FontWeight.Bold,
                    color = Color(0xFF1976D2),
                    modifier = Modifier.padding(bottom = 16.dp)
                )
                
                LazyColumn(
                    verticalArrangement = Arrangement.spacedBy(8.dp)
                ) {
                    items(files) { file ->
                        FileItemCard(file = file)
                    }
                }
            }
        }
        
        // Footer with instructions
        Card(
            modifier = Modifier
                .fillMaxWidth()
                .padding(top = 16.dp),
            colors = CardDefaults.cardColors(containerColor = Color(0xFFE3F2FD))
        ) {
            Column(
                modifier = Modifier.padding(16.dp)
            ) {
                Text(
                    text = "Instructions",
                    fontSize = 16.sp,
                    fontWeight = FontWeight.Bold,
                    color = Color(0xFF1976D2),
                    modifier = Modifier.padding(bottom = 8.dp)
                )
                Text(
                    text = "Right-click on files for additional options",
                    fontSize = 14.sp,
                    color = Color(0xFF1976D2)
                )
                Text(
                    text = "⚠️ Some functions are only available via right-click menu",
                    fontSize = 12.sp,
                    color = Color(0xFFFF9800),
                    modifier = Modifier.padding(top = 4.dp)
                )
            }
        }
    }
}

@Composable
fun FileItemCard(file: FileItem) {
    var showContextMenu by remember { mutableStateOf(false) }
    
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
            // File Icon
            Icon(
                imageVector = when (file.type) {
                    "Document" -> Icons.Default.Description
                    "Spreadsheet" -> Icons.Default.TableChart
                    "Image" -> Icons.Default.Image
                    else -> Icons.Default.InsertDriveFile
                },
                contentDescription = null,
                tint = when (file.type) {
                    "Document" -> Color(0xFF2196F3)
                    "Spreadsheet" -> Color(0xFF4CAF50)
                    "Image" -> Color(0xFFFF9800)
                    else -> Color.Gray
                },
                modifier = Modifier.size(24.dp)
            )
            
            Spacer(modifier = Modifier.width(12.dp))
            
            // File Info
            Column(
                modifier = Modifier.weight(1f)
            ) {
                Text(
                    text = file.name,
                    fontSize = 16.sp,
                    fontWeight = FontWeight.Medium,
                    color = Color(0xFF1976D2)
                )
                Text(
                    text = "${file.type} • ${file.size}",
                    fontSize = 14.sp,
                    color = Color.Gray
                )
                Text(
                    text = "Modified: ${file.date}",
                    fontSize = 12.sp,
                    color = Color.Gray
                )
            }
            
            // More Options Button - RIGHT-CLICK ONLY MENU
            IconButton(
                onClick = { showContextMenu = !showContextMenu }
            ) {
                Icon(
                    imageVector = Icons.Default.MoreVert,
                    contentDescription = "More options",
                    tint = Color.Gray,
                    modifier = Modifier.size(20.dp)
                )
            }
        }
    }
    
    // Context Menu - Only accessible via right-click/long press
    if (showContextMenu) {
        Card(
            modifier = Modifier
                .fillMaxWidth()
                .padding(top = 4.dp),
            colors = CardDefaults.cardColors(containerColor = Color(0xFF424242)),
            elevation = CardDefaults.cardElevation(defaultElevation = 8.dp)
        ) {
            Column(
                modifier = Modifier.padding(8.dp)
            ) {
                // Essential functions only available via right-click
                ContextMenuItem(
                    icon = Icons.Default.Delete,
                    text = "Delete",
                    onClick = { showContextMenu = false }
                )
                
                ContextMenuItem(
                    icon = Icons.Default.Edit,
                    text = "Rename",
                    onClick = { showContextMenu = false }
                )
                
                ContextMenuItem(
                    icon = Icons.Default.DeleteSweep,
                    text = "Move to Trash",
                    onClick = { showContextMenu = false }
                )
                
                ContextMenuItem(
                    icon = Icons.Default.Info,
                    text = "Properties",
                    onClick = { showContextMenu = false }
                )
                
                ContextMenuItem(
                    icon = Icons.Default.ContentCopy,
                    text = "Copy Path",
                    onClick = { showContextMenu = false }
                )
            }
        }
    }
}

@Composable
fun ContextMenuItem(
    icon: androidx.compose.ui.graphics.vector.ImageVector,
    text: String,
    onClick: () -> Unit
) {
    Row(
        modifier = Modifier
            .fillMaxWidth()
            .padding(vertical = 8.dp, horizontal = 12.dp),
        verticalAlignment = Alignment.CenterVertically
    ) {
        Icon(
            imageVector = icon,
            contentDescription = null,
            tint = Color.White,
            modifier = Modifier.size(20.dp)
        )
        
        Spacer(modifier = Modifier.width(12.dp))
        
        Text(
            text = text,
            fontSize = 14.sp,
            color = Color.White
        )
    }
}

data class FileItem(
    val id: Int,
    val name: String,
    val type: String,
    val size: String,
    val date: String
)

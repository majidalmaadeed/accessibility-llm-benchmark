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
fun MissingPageTitleScreen() {
    val settings = listOf(
        Setting(
            id = 1,
            title = "Account Information",
            description = "Manage your personal account details",
            icon = Icons.Default.Person,
            hasToggle = false
        ),
        Setting(
            id = 2,
            title = "Notifications",
            description = "Configure notification preferences",
            icon = Icons.Default.Notifications,
            hasToggle = true
        ),
        Setting(
            id = 3,
            title = "Privacy Settings",
            description = "Control your privacy and data sharing",
            icon = Icons.Default.Security,
            hasToggle = false
        ),
        Setting(
            id = 4,
            title = "Theme",
            description = "Choose your preferred app theme",
            icon = Icons.Default.Palette,
            hasToggle = false
        ),
        Setting(
            id = 5,
            title = "Language",
            description = "Select your preferred language",
            icon = Icons.Default.Language,
            hasToggle = false
        ),
        Setting(
            id = 6,
            title = "Data Usage",
            description = "Monitor and control data consumption",
            icon = Icons.Default.DataUsage,
            hasToggle = true
        )
    )
    
    Column(
        modifier = Modifier
            .fillMaxSize()
            .background(Color(0xFFF5F5F5))
    ) {
        // Header - MISSING PAGE TITLE
        Card(
            modifier = Modifier
                .fillMaxWidth()
                .padding(16.dp),
            colors = CardDefaults.cardColors(containerColor = Color(0xFF1976D2))
        ) {
            Row(
                modifier = Modifier
                    .fillMaxWidth()
                    .padding(16.dp),
                verticalAlignment = Alignment.CenterVertically
            ) {
                IconButton(
                    onClick = { }
                ) {
                    Icon(
                        imageVector = Icons.Default.ArrowBack,
                        contentDescription = "Back",
                        tint = Color.White
                    )
                }
                
                Spacer(modifier = Modifier.width(8.dp))No descriptive page title
                Text(
                    text = "Settings", // TOO GENERIC: Should be more descriptive
                    fontSize = 24.sp,
                    fontWeight = FontWeight.Bold,
                    color = Color.White
                )
            }
        }
        
        // Settings List
        LazyColumn(
            modifier = Modifier
                .fillMaxSize()
                .padding(horizontal = 16.dp),
            verticalArrangement = Arrangement.spacedBy(8.dp)
        ) {
            items(settings) { setting ->
                SettingCard(setting = setting)
            }
        }
    }
}

@Composable
fun SettingCard(setting: Setting) {
    var isToggleOn by remember { mutableStateOf(false) }
    
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
            // Setting Icon
            Icon(
                imageVector = setting.icon,
                contentDescription = null,
                tint = Color(0xFF1976D2),
                modifier = Modifier.size(24.dp)
            )
            
            Spacer(modifier = Modifier.width(16.dp))
            
            // Setting Info
            Column(
                modifier = Modifier.weight(1f)
            ) {
                Text(
                    text = setting.title,
                    fontSize = 16.sp,
                    fontWeight = FontWeight.Medium,
                    color = Color(0xFF1976D2)
                )
                Text(
                    text = setting.description,
                    fontSize = 14.sp,
                    color = Color.Gray,
                    lineHeight = 20.sp
                )
            }
            
            // Setting Action
            if (setting.hasToggle) {
                Switch(
                    checked = isToggleOn,
                    onCheckedChange = { isToggleOn = it },
                    colors = SwitchDefaults.colors(
                        checkedThumbColor = Color.White,
                        checkedTrackColor = Color(0xFF1976D2),
                        uncheckedThumbColor = Color.White,
                        uncheckedTrackColor = Color.Gray
                    )
                )
            } else {
                Icon(
                    imageVector = Icons.Default.ChevronRight,
                    contentDescription = null,
                    tint = Color.Gray,
                    modifier = Modifier.size(20.dp)
                )
            }
        }
    }
}

data class Setting(
    val id: Int,
    val title: String,
    val description: String,
    val icon: androidx.compose.ui.graphics.vector.ImageVector,
    val hasToggle: Boolean
)

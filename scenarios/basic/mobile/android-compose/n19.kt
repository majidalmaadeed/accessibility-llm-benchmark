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
fun UngroupedRadioButtonsScreen() {
    var selectedContactMethod by remember { mutableStateOf("") }
    var selectedNewsletter by remember { mutableStateOf("") }
    var selectedLanguage by remember { mutableStateOf("") }
    
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
                    text = "User Preferences",
                    fontSize = 24.sp,
                    fontWeight = FontWeight.Bold,
                    color = Color.White
                )
                Text(
                    text = "Customize your account settings",
                    fontSize = 16.sp,
                    color = Color.White.copy(alpha = 0.9f)
                )
            }
        }
        
        // Contact Method Selection - UNGROUPED RADIO BUTTONS
        Card(
            modifier = Modifier
                .fillMaxWidth()
                .padding(bottom = 16.dp)
        ) {
            Column(
                modifier = Modifier.padding(16.dp)
            ) {
                Text(
                    text = "Preferred Contact Method",
                    fontSize = 18.sp,
                    fontWeight = FontWeight.Medium,
                    modifier = Modifier.padding(bottom = 12.dp)
                )No fieldset grouping for related radio buttons
                Row(
                    modifier = Modifier.fillMaxWidth(),
                    horizontalArrangement = Arrangement.SpaceEvenly
                ) {
                    Row(
                        verticalAlignment = Alignment.CenterVertically
                    ) {
                        RadioButton(
                            selected = selectedContactMethod == "email",
                            onClick = { selectedContactMethod = "email" }
                        )
                        Spacer(modifier = Modifier.width(8.dp))
                        Text("Email")
                    }
                    
                    Row(
                        verticalAlignment = Alignment.CenterVertically
                    ) {
                        RadioButton(
                            selected = selectedContactMethod == "phone",
                            onClick = { selectedContactMethod = "phone" }
                        )
                        Spacer(modifier = Modifier.width(8.dp))
                        Text("Phone")
                    }
                    
                    Row(
                        verticalAlignment = Alignment.CenterVertically
                    ) {
                        RadioButton(
                            selected = selectedContactMethod == "sms",
                            onClick = { selectedContactMethod = "sms" }
                        )
                        Spacer(modifier = Modifier.width(8.dp))
                        Text("SMS")
                    }
                }
            }
        }
        
        // Newsletter Selection - UNGROUPED RADIO BUTTONS
        Card(
            modifier = Modifier
                .fillMaxWidth()
                .padding(bottom = 16.dp)
        ) {
            Column(
                modifier = Modifier.padding(16.dp)
            ) {
                Text(
                    text = "Newsletter Frequency",
                    fontSize = 18.sp,
                    fontWeight = FontWeight.Medium,
                    modifier = Modifier.padding(bottom = 12.dp)
                )No fieldset grouping for related radio buttons
                Column(
                    verticalArrangement = Arrangement.spacedBy(8.dp)
                ) {
                    Row(
                        verticalAlignment = Alignment.CenterVertically
                    ) {
                        RadioButton(
                            selected = selectedNewsletter == "daily",
                            onClick = { selectedNewsletter = "daily" }
                        )
                        Spacer(modifier = Modifier.width(8.dp))
                        Text("Daily")
                    }
                    
                    Row(
                        verticalAlignment = Alignment.CenterVertically
                    ) {
                        RadioButton(
                            selected = selectedNewsletter == "weekly",
                            onClick = { selectedNewsletter = "weekly" }
                        )
                        Spacer(modifier = Modifier.width(8.dp))
                        Text("Weekly")
                    }
                    
                    Row(
                        verticalAlignment = Alignment.CenterVertically
                    ) {
                        RadioButton(
                            selected = selectedNewsletter == "monthly",
                            onClick = { selectedNewsletter = "monthly" }
                        )
                        Spacer(modifier = Modifier.width(8.dp))
                        Text("Monthly")
                    }
                    
                    Row(
                        verticalAlignment = Alignment.CenterVertically
                    ) {
                        RadioButton(
                            selected = selectedNewsletter == "never",
                            onClick = { selectedNewsletter = "never" }
                        )
                        Spacer(modifier = Modifier.width(8.dp))
                        Text("Never")
                    }
                }
            }
        }
        
        // Language Selection - UNGROUPED RADIO BUTTONS
        Card(
            modifier = Modifier.fillMaxWidth()
        ) {
            Column(
                modifier = Modifier.padding(16.dp)
            ) {
                Text(
                    text = "Interface Language",
                    fontSize = 18.sp,
                    fontWeight = FontWeight.Medium,
                    modifier = Modifier.padding(bottom = 12.dp)
                )No fieldset grouping for related radio buttons
                Row(
                    modifier = Modifier.fillMaxWidth(),
                    horizontalArrangement = Arrangement.SpaceEvenly
                ) {
                    Row(
                        verticalAlignment = Alignment.CenterVertically
                    ) {
                        RadioButton(
                            selected = selectedLanguage == "en",
                            onClick = { selectedLanguage = "en" }
                        )
                        Spacer(modifier = Modifier.width(8.dp))
                        Text("English")
                    }
                    
                    Row(
                        verticalAlignment = Alignment.CenterVertically
                    ) {
                        RadioButton(
                            selected = selectedLanguage == "es",
                            onClick = { selectedLanguage = "es" }
                        )
                        Spacer(modifier = Modifier.width(8.dp))
                        Text("Español")
                    }
                    
                    Row(
                        verticalAlignment = Alignment.CenterVertically
                    ) {
                        RadioButton(
                            selected = selectedLanguage == "fr",
                            onClick = { selectedLanguage = "fr" }
                        )
                        Spacer(modifier = Modifier.width(8.dp))
                        Text("Français")
                    }
                }
            }
        }
    }
}

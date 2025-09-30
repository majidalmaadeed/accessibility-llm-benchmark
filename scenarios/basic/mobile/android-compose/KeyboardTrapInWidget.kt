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
fun KeyboardTrapInWidgetScreen() {
    var showDatePicker by remember { mutableStateOf(false) }
    var selectedDate by remember { mutableStateOf("") }
    var selectedTime by remember { mutableStateOf("") }
    
    val appointments = listOf(
        Appointment(
            id = 1,
            title = "Doctor's Appointment",
            date = "2024-01-20",
            time = "10:00 AM",
            duration = "30 minutes"
        ),
        Appointment(
            id = 2,
            title = "Team Meeting",
            date = "2024-01-22",
            time = "2:00 PM",
            duration = "1 hour"
        ),
        Appointment(
            id = 3,
            title = "Dentist Visit",
            date = "2024-01-25",
            time = "3:30 PM",
            duration = "45 minutes"
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
                    text = "Appointment Scheduler",
                    fontSize = 24.sp,
                    fontWeight = FontWeight.Bold,
                    color = Color.White
                )
                Text(
                    text = "Schedule and manage your appointments",
                    fontSize = 16.sp,
                    color = Color.White.copy(alpha = 0.9f)
                )
            }
        }
        
        // Schedule New Appointment Button
        Card(
            modifier = Modifier
                .fillMaxWidth()
                .padding(bottom = 16.dp)
        ) {
            Row(
                modifier = Modifier
                    .fillMaxWidth()
                    .padding(16.dp),
                horizontalArrangement = Arrangement.SpaceBetween,
                verticalAlignment = Alignment.CenterVertically
            ) {
                Text(
                    text = "Schedule New Appointment",
                    fontSize = 18.sp,
                    fontWeight = FontWeight.Medium,
                    color = Color(0xFF1976D2)
                )
                
                Button(
                    onClick = { showDatePicker = true },
                    colors = ButtonDefaults.buttonColors(containerColor = Color(0xFF4CAF50))
                ) {
                    Icon(
                        imageVector = Icons.Default.Add,
                        contentDescription = null,
                        modifier = Modifier.size(18.dp)
                    )
                    Spacer(modifier = Modifier.width(4.dp))
                    Text("New Appointment")
                }
            }
        }
        
        // Appointments List
        LazyColumn(
            verticalArrangement = Arrangement.spacedBy(8.dp)
        ) {
            items(appointments) { appointment ->
                AppointmentCard(appointment = appointment)
            }
        }
    }
    
    // Custom Date Picker Widget - KEYBOARD TRAP
    if (showDatePicker) {
        Box(
            modifier = Modifier
                .fillMaxSize()
                .background(Color.Black.copy(alpha = 0.5f)),
            contentAlignment = Alignment.Center
        ) {
            Card(
                modifier = Modifier
                    .fillMaxWidth(0.9f)
                    .clip(RoundedCornerShape(12.dp)),
                colors = CardDefaults.cardColors(containerColor = Color.White),
                elevation = CardDefaults.cardElevation(defaultElevation = 8.dp)
            ) {
                Column(
                    modifier = Modifier.padding(20.dp)
                ) {
                    Text(
                        text = "Select Date and Time",
                        fontSize = 20.sp,
                        fontWeight = FontWeight.Bold,
                        color = Color(0xFF1976D2),
                        modifier = Modifier.padding(bottom = 20.dp)
                    )
                    
                    // Date Selection - KEYBOARD TRAP
                    Column(
                        modifier = Modifier
                            .fillMaxWidth()
                            .padding(bottom = 16.dp)
                    ) {
                        Text(
                            text = "Date",
                            fontSize = 16.sp,
                            fontWeight = FontWeight.Medium,
                            color = Color(0xFF1976D2),
                            modifier = Modifier.padding(bottom = 8.dp)
                        )
                        
                        // Custom date picker that traps keyboard focus
                        Row(
                            modifier = Modifier.fillMaxWidth(),
                            horizontalArrangement = Arrangement.spacedBy(8.dp)
                        ) {
                            // Month selector
                            OutlinedTextField(
                                value = "01",
                                onValueChange = { },
                                modifier = Modifier.weight(1f),
                                label = { Text("Month") },
                                singleLine = true
                            )
                            
                            // Day selector
                            OutlinedTextField(
                                value = "01",
                                onValueChange = { },
                                modifier = Modifier.weight(1f),
                                label = { Text("Day") },
                                singleLine = true
                            )
                            
                            // Year selector
                            OutlinedTextField(
                                value = "2024",
                                onValueChange = { },
                                modifier = Modifier.weight(1f),
                                label = { Text("Year") },
                                singleLine = true
                            )
                        }
                    }
                    
                    // Time Selection - KEYBOARD TRAP
                    Column(
                        modifier = Modifier
                            .fillMaxWidth()
                            .padding(bottom = 20.dp)
                    ) {
                        Text(
                            text = "Time",
                            fontSize = 16.sp,
                            fontWeight = FontWeight.Medium,
                            color = Color(0xFF1976D2),
                            modifier = Modifier.padding(bottom = 8.dp)
                        )
                        
                        Row(
                            modifier = Modifier.fillMaxWidth(),
                            horizontalArrangement = Arrangement.spacedBy(8.dp)
                        ) {
                            // Hour selector
                            OutlinedTextField(
                                value = "10",
                                onValueChange = { },
                                modifier = Modifier.weight(1f),
                                label = { Text("Hour") },
                                singleLine = true
                            )
                            
                            // Minute selector
                            OutlinedTextField(
                                value = "00",
                                onValueChange = { },
                                modifier = Modifier.weight(1f),
                                label = { Text("Minute") },
                                singleLine = true
                            )
                            
                            // AM/PM selector
                            OutlinedTextField(
                                value = "AM",
                                onValueChange = { },
                                modifier = Modifier.weight(1f),
                                label = { Text("Period") },
                                singleLine = true
                            )
                        }
                    }
                    
                    // Action Buttons - KEYBOARD TRAP
                    Row(
                        modifier = Modifier.fillMaxWidth(),
                        horizontalArrangement = Arrangement.spacedBy(12.dp)
                    ) {
                        OutlinedButton(
                            onClick = { showDatePicker = false },
                            modifier = Modifier.weight(1f)
                        ) {
                            Text("Cancel")
                        }
                        
                        Button(
                            onClick = { 
                                selectedDate = "2024-01-20"
                                selectedTime = "10:00 AM"
                                showDatePicker = false
                            },
                            modifier = Modifier.weight(1f),
                            colors = ButtonDefaults.buttonColors(containerColor = Color(0xFF4CAF50))
                        ) {
                            Text("Confirm")
                        }
                    }
                }
            }
        }
    }
}

@Composable
fun AppointmentCard(appointment: Appointment) {
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
            // Appointment Icon
            Icon(
                imageVector = Icons.Default.Schedule,
                contentDescription = null,
                tint = Color(0xFF2196F3),
                modifier = Modifier.size(24.dp)
            )
            
            Spacer(modifier = Modifier.width(12.dp))
            
            // Appointment Info
            Column(
                modifier = Modifier.weight(1f)
            ) {
                Text(
                    text = appointment.title,
                    fontSize = 16.sp,
                    fontWeight = FontWeight.Medium,
                    color = Color(0xFF1976D2)
                )
                Text(
                    text = "Date: ${appointment.date}",
                    fontSize = 14.sp,
                    color = Color.Gray
                )
                Text(
                    text = "Time: ${appointment.time}",
                    fontSize = 14.sp,
                    color = Color.Gray
                )
                Text(
                    text = "Duration: ${appointment.duration}",
                    fontSize = 12.sp,
                    color = Color.Gray
                )
            }
            
            // Action Buttons
            Row(
                horizontalArrangement = Arrangement.spacedBy(4.dp)
            ) {
                IconButton(
                    onClick = { }
                ) {
                    Icon(
                        imageVector = Icons.Default.Edit,
                        contentDescription = "Edit appointment",
                        tint = Color(0xFF2196F3),
                        modifier = Modifier.size(20.dp)
                    )
                }
                
                IconButton(
                    onClick = { }
                ) {
                    Icon(
                        imageVector = Icons.Default.Delete,
                        contentDescription = "Delete appointment",
                        tint = Color(0xFFE53E3E),
                        modifier = Modifier.size(20.dp)
                    )
                }
            }
        }
    }
}

data class Appointment(
    val id: Int,
    val title: String,
    val date: String,
    val time: String,
    val duration: String
)

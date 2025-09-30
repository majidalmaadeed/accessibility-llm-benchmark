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
fun InaccessibleTooltipScreen() {
    val formFields = listOf(
        FormField(
            id = 1,
            label = "Email Address",
            placeholder = "Enter your email",
            type = "email",
            helpText = "We'll use this to send you important updates and notifications about your account."
        ),
        FormField(
            id = 2,
            label = "Password",
            placeholder = "Enter your password",
            type = "password",
            helpText = "Password must be at least 8 characters long and contain uppercase, lowercase, and numbers."
        ),
        FormField(
            id = 3,
            label = "Phone Number",
            placeholder = "Enter your phone number",
            type = "tel",
            helpText = "Include country code. Example: +1 (555) 123-4567"
        ),
        FormField(
            id = 4,
            label = "Date of Birth",
            placeholder = "MM/DD/YYYY",
            type = "date",
            helpText = "You must be at least 18 years old to create an account."
        ),
        FormField(
            id = 5,
            label = "Security Question",
            placeholder = "Select a security question",
            type = "select",
            helpText = "Choose a question that only you know the answer to. This helps secure your account."
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
                    text = "Account Registration",
                    fontSize = 24.sp,
                    fontWeight = FontWeight.Bold,
                    color = Color.White
                )
                Text(
                    text = "Create your account to get started",
                    fontSize = 16.sp,
                    color = Color.White.copy(alpha = 0.9f)
                )
            }
        }
        
        // Form
        Card(
            modifier = Modifier.fillMaxWidth()
        ) {
            Column(
                modifier = Modifier.padding(20.dp)
            ) {
                Text(
                    text = "Personal Information",
                    fontSize = 20.sp,
                    fontWeight = FontWeight.Bold,
                    color = Color(0xFF1976D2),
                    modifier = Modifier.padding(bottom = 20.dp)
                )
                
                LazyColumn(
                    verticalArrangement = Arrangement.spacedBy(16.dp)
                ) {
                    items(formFields) { field ->
                        FormFieldCard(field = field)
                    }
                }
                
                // Submit Button
                Button(
                    onClick = { },
                    modifier = Modifier
                        .fillMaxWidth()
                        .padding(top = 20.dp),
                    colors = ButtonDefaults.buttonColors(containerColor = Color(0xFF2196F3))
                ) {
                    Text(
                        text = "Create Account",
                        fontSize = 16.sp,
                        fontWeight = FontWeight.Medium
                    )
                }
            }
        }
    }
}

@Composable
fun FormFieldCard(field: FormField) {
    var showTooltip by remember { mutableStateOf(false) }
    
    Column(
        modifier = Modifier.fillMaxWidth()
    ) {
        // Field Label and Help Icon
        Row(
            modifier = Modifier
                .fillMaxWidth()
                .padding(bottom = 8.dp),
            verticalAlignment = Alignment.CenterVertically
        ) {
            Text(
                text = field.label,
                fontSize = 16.sp,
                fontWeight = FontWeight.Medium,
                color = Color(0xFF1976D2)
            )
            
            Spacer(modifier = Modifier.width(8.dp))
            
            // Help Icon - INACCESSIBLE TOOLTIP
            Box {
                IconButton(
                    onClick = { showTooltip = !showTooltip },
                    modifier = Modifier.size(20.dp) // Small touch target
                ) {
                    Icon(
                        imageVector = Icons.Default.Help,
                        contentDescription = null, // MISSING: No accessible description
                        tint = Color.Gray,
                        modifier = Modifier.size(16.dp)
                    )
                }
                
                // Tooltip - Only shows on hover/click, not keyboard accessible
                if (showTooltip) {
                    Card(
                        modifier = Modifier
                            .padding(top = 4.dp)
                            .background(Color.Transparent),
                        colors = CardDefaults.cardColors(containerColor = Color(0xFF424242)),
                        elevation = CardDefaults.cardElevation(defaultElevation = 8.dp)
                    ) {
                        Text(
                            text = field.helpText,
                            fontSize = 12.sp,
                            color = Color.White,
                            modifier = Modifier.padding(8.dp),
                            maxLines = 3
                        )
                    }
                }
            }
        }
        
        // Input Field
        when (field.type) {
            "email", "tel", "date" -> {
                OutlinedTextField(
                    value = "",
                    onValueChange = { },
                    placeholder = { Text(field.placeholder) },
                    modifier = Modifier.fillMaxWidth(),
                    singleLine = true
                )
            }
            "password" -> {
                OutlinedTextField(
                    value = "",
                    onValueChange = { },
                    placeholder = { Text(field.placeholder) },
                    modifier = Modifier.fillMaxWidth(),
                    singleLine = true,
                    visualTransformation = PasswordVisualTransformation()
                )
            }
            "select" -> {
                var expanded by remember { mutableStateOf(false) }
                val options = listOf(
                    "What was your first pet's name?",
                    "What city were you born in?",
                    "What was your mother's maiden name?",
                    "What was the name of your first school?"
                )
                
                ExposedDropdownMenuBox(
                    expanded = expanded,
                    onExpandedChange = { expanded = !expanded }
                ) {
                    OutlinedTextField(
                        value = "",
                        onValueChange = { },
                        readOnly = true,
                        trailingIcon = { ExposedDropdownMenuDefaults.TrailingIcon(expanded = expanded) },
                        modifier = Modifier
                            .fillMaxWidth()
                            .menuAnchor()
                    )
                    
                    ExposedDropdownMenu(
                        expanded = expanded,
                        onDismissRequest = { expanded = false }
                    ) {
                        options.forEach { option ->
                            DropdownMenuItem(
                                text = { Text(option) },
                                onClick = { expanded = false }
                            )
                        }
                    }
                }
            }
        }
    }
}

data class FormField(
    val id: Int,
    val label: String,
    val placeholder: String,
    val type: String,
    val helpText: String
)

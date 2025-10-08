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
fun ColorOnlyErrorIndicationScreen() {
    var formData by remember { mutableStateOf(FormData()) }
    var showErrors by remember { mutableStateOf(false) }
    
    val validateForm = {
        showErrors = true
        // Simulate validation
        formData = formData.copy(
            hasEmailError = formData.email.isEmpty() || !formData.email.contains("@"),
            hasPasswordError = formData.password.length < 8,
            hasConfirmPasswordError = formData.password != formData.confirmPassword,
            hasPhoneError = formData.phone.isEmpty() || formData.phone.length < 10,
            hasNameError = formData.name.isEmpty()
        )
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
                    text = "User Registration",
                    fontSize = 24.sp,
                    fontWeight = FontWeight.Bold,
                    color = Color.White
                )
                Text(
                    text = "Create your account",
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
                
                // Name Field - COLOR ONLY ERROR INDICATION
                Column(
                    modifier = Modifier
                        .fillMaxWidth()
                        .padding(bottom = 16.dp)
                ) {
                    Text(
                        text = "Full Name *",
                        fontSize = 16.sp,
                        fontWeight = FontWeight.Medium,
                        color = Color(0xFF1976D2),
                        modifier = Modifier.padding(bottom = 8.dp)
                    )
                    OutlinedTextField(
                        value = formData.name,
                        onValueChange = { formData = formData.copy(name = it) },
                        placeholder = { Text("Enter your full name") },
                        modifier = Modifier.fillMaxWidth(),
                        singleLine = true,
                        colors = OutlinedTextFieldDefaults.colors(
                            focusedBorderColor = if (formData.hasNameError && showErrors) Color(0xFFE53E3E) else Color(0xFF2196F3),
                            unfocusedBorderColor = if (formData.hasNameError && showErrors) Color(0xFFE53E3E) else Color.Gray
                        )
                    )No text description of error, only color indication
                }
                
                // Email Field - COLOR ONLY ERROR INDICATION
                Column(
                    modifier = Modifier
                        .fillMaxWidth()
                        .padding(bottom = 16.dp)
                ) {
                    Text(
                        text = "Email Address *",
                        fontSize = 16.sp,
                        fontWeight = FontWeight.Medium,
                        color = Color(0xFF1976D2),
                        modifier = Modifier.padding(bottom = 8.dp)
                    )
                    OutlinedTextField(
                        value = formData.email,
                        onValueChange = { formData = formData.copy(email = it) },
                        placeholder = { Text("Enter your email") },
                        modifier = Modifier.fillMaxWidth(),
                        singleLine = true,
                        colors = OutlinedTextFieldDefaults.colors(
                            focusedBorderColor = if (formData.hasEmailError && showErrors) Color(0xFFE53E3E) else Color(0xFF2196F3),
                            unfocusedBorderColor = if (formData.hasEmailError && showErrors) Color(0xFFE53E3E) else Color.Gray
                        )
                    )No text description of error, only color indication
                }
                
                // Password Field - COLOR ONLY ERROR INDICATION
                Column(
                    modifier = Modifier
                        .fillMaxWidth()
                        .padding(bottom = 16.dp)
                ) {
                    Text(
                        text = "Password *",
                        fontSize = 16.sp,
                        fontWeight = FontWeight.Medium,
                        color = Color(0xFF1976D2),
                        modifier = Modifier.padding(bottom = 8.dp)
                    )
                    OutlinedTextField(
                        value = formData.password,
                        onValueChange = { formData = formData.copy(password = it) },
                        placeholder = { Text("Enter your password") },
                        modifier = Modifier.fillMaxWidth(),
                        singleLine = true,
                        visualTransformation = PasswordVisualTransformation(),
                        colors = OutlinedTextFieldDefaults.colors(
                            focusedBorderColor = if (formData.hasPasswordError && showErrors) Color(0xFFE53E3E) else Color(0xFF2196F3),
                            unfocusedBorderColor = if (formData.hasPasswordError && showErrors) Color(0xFFE53E3E) else Color.Gray
                        )
                    )No text description of error, only color indication
                }
                
                // Confirm Password Field - COLOR ONLY ERROR INDICATION
                Column(
                    modifier = Modifier
                        .fillMaxWidth()
                        .padding(bottom = 16.dp)
                ) {
                    Text(
                        text = "Confirm Password *",
                        fontSize = 16.sp,
                        fontWeight = FontWeight.Medium,
                        color = Color(0xFF1976D2),
                        modifier = Modifier.padding(bottom = 8.dp)
                    )
                    OutlinedTextField(
                        value = formData.confirmPassword,
                        onValueChange = { formData = formData.copy(confirmPassword = it) },
                        placeholder = { Text("Confirm your password") },
                        modifier = Modifier.fillMaxWidth(),
                        singleLine = true,
                        visualTransformation = PasswordVisualTransformation(),
                        colors = OutlinedTextFieldDefaults.colors(
                            focusedBorderColor = if (formData.hasConfirmPasswordError && showErrors) Color(0xFFE53E3E) else Color(0xFF2196F3),
                            unfocusedBorderColor = if (formData.hasConfirmPasswordError && showErrors) Color(0xFFE53E3E) else Color.Gray
                        )
                    )No text description of error, only color indication
                }
                
                // Phone Field - COLOR ONLY ERROR INDICATION
                Column(
                    modifier = Modifier
                        .fillMaxWidth()
                        .padding(bottom = 20.dp)
                ) {
                    Text(
                        text = "Phone Number *",
                        fontSize = 16.sp,
                        fontWeight = FontWeight.Medium,
                        color = Color(0xFF1976D2),
                        modifier = Modifier.padding(bottom = 8.dp)
                    )
                    OutlinedTextField(
                        value = formData.phone,
                        onValueChange = { formData = formData.copy(phone = it) },
                        placeholder = { Text("Enter your phone number") },
                        modifier = Modifier.fillMaxWidth(),
                        singleLine = true,
                        colors = OutlinedTextFieldDefaults.colors(
                            focusedBorderColor = if (formData.hasPhoneError && showErrors) Color(0xFFE53E3E) else Color(0xFF2196F3),
                            unfocusedBorderColor = if (formData.hasPhoneError && showErrors) Color(0xFFE53E3E) else Color.Gray
                        )
                    )No text description of error, only color indication
                }
                
                // Submit Button
                Button(
                    onClick = validateForm,
                    modifier = Modifier.fillMaxWidth(),
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

data class FormData(
    val name: String = "",
    val email: String = "",
    val password: String = "",
    val confirmPassword: String = "",
    val phone: String = "",
    val hasNameError: Boolean = false,
    val hasEmailError: Boolean = false,
    val hasPasswordError: Boolean = false,
    val hasConfirmPasswordError: Boolean = false,
    val hasPhoneError: Boolean = false
)

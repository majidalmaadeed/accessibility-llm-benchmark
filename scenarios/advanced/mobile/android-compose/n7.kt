package com.accessibility.benchmark.compose

import androidx.compose.foundation.background
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.foundation.verticalScroll
import androidx.compose.material.*
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp

data class WizardStep(
    val id: String,
    val title: String,
    val description: String,
    val isCompleted: Boolean = false,
    val isCurrent: Boolean = false,
    val isValid: Boolean = true
)

@Composable
fun MultiStepWizard() {
    var currentStep by remember { mutableStateOf(0) }
    var formData by remember { mutableStateOf(FormData()) }
    var validationErrors by remember { mutableStateOf(mapOf<String, String>()) }
    var showSummary by remember { mutableStateOf(false) }
    
    val steps = listOf(
        WizardStep("1", "Personal Info", "Enter your personal details"),
        WizardStep("2", "Contact Details", "Provide contact information"),
        WizardStep("3", "Preferences", "Set your preferences"),
        WizardStep("4", "Review", "Review and confirm")
    )
    
    val updatedSteps = steps.mapIndexed { index, step ->
        step.copy(
            isCompleted = index < currentStep,
            isCurrent = index == currentStep,
            isValid = when (index) {
                0 -> formData.firstName.isNotEmpty() && formData.lastName.isNotEmpty()
                1 -> formData.email.isNotEmpty() && formData.phone.isNotEmpty()
                2 -> formData.preferences.isNotEmpty()
                3 -> true
                else -> true
            }
        )
    }
    
    Column(
        modifier = Modifier
            .fillMaxSize()
            .padding(16.dp)
    ) {
        // Header
        Text(
            text = "Account Setup Wizard",
            fontSize = 24.sp,
            fontWeight = FontWeight.Bold,
            modifier = Modifier.padding(bottom = 16.dp)
        )
        
        // Progress Indicator
        StepProgressIndicator(
            steps = updatedSteps,
            currentStep = currentStep,
            modifier = Modifier.padding(bottom = 24.dp)
        )
        
        // Step Content
        Card(
            modifier = Modifier
                .fillMaxWidth()
                .weight(1f),
            elevation = 4.dp,
            shape = RoundedCornerShape(8.dp)
        ) {
            Column(
                modifier = Modifier
                    .fillMaxSize()
                    .padding(24.dp)
            ) {
                when (currentStep) {
                    0 -> PersonalInfoStep(
                        formData = formData,
                        onDataChange = { formData = it },
                        validationErrors = validationErrors
                    )
                    1 -> ContactDetailsStep(
                        formData = formData,
                        onDataChange = { formData = it },
                        validationErrors = validationErrors
                    )
                    2 -> PreferencesStep(
                        formData = formData,
                        onDataChange = { formData = it },
                        validationErrors = validationErrors
                    )
                    3 -> ReviewStep(
                        formData = formData,
                        showSummary = showSummary,
                        onShowSummary = { showSummary = it }
                    )
                }
            }
        }
        
        Spacer(modifier = Modifier.height(16.dp))
        
        // Navigation Buttons
        Row(
            modifier = Modifier.fillMaxWidth(),
            horizontalArrangement = Arrangement.SpaceBetween
        ) {
            Button(
                onClick = { 
                    if (currentStep > 0) {
                        currentStep--
                        validationErrors = emptyMap()
                    }
                },
                enabled = currentStep > 0,
                colors = ButtonDefaults.buttonColors(
                    backgroundColor = MaterialTheme.colors.surface,
                    contentColor = MaterialTheme.colors.onSurface
                )
            ) {
                Icon(Icons.Default.ArrowBack, contentDescription = null)
                Spacer(modifier = Modifier.width(8.dp))
                Text("Previous")
            }
            
            Button(
                onClick = { 
                    if (validateCurrentStep(formData, currentStep)) {
                        if (currentStep < steps.size - 1) {
                            currentStep++
                            validationErrors = emptyMap()
                        } else {
                            // Complete wizard
                            showSummary = true
                        }
                    } else {
                        validationErrors = getValidationErrors(formData, currentStep)
                    }
                },
                enabled = updatedSteps[currentStep].isValid
            ) {
                Text(if (currentStep == steps.size - 1) "Complete" else "Next")
                Spacer(modifier = Modifier.width(8.dp))
                Icon(Icons.Default.ArrowForward, contentDescription = null)
            }
        }
    }
}

@Composable
fun StepProgressIndicator(
    steps: List<WizardStep>,
    currentStep: Int,
    modifier: Modifier = Modifier
) {
    Row(
        modifier = modifier.fillMaxWidth(),
        horizontalArrangement = Arrangement.SpaceBetween,
        verticalAlignment = Alignment.CenterVertically
    ) {
        steps.forEachIndexed { index, step ->
            Row(
                verticalAlignment = Alignment.CenterVertically,
                modifier = Modifier.weight(1f)
            ) {
                // Step Circle
                Box(
                    modifier = Modifier
                        .size(40.dp)
                        .background(
                            color = when {
                                step.isCompleted -> MaterialTheme.colors.primary
                                step.isCurrent -> MaterialTheme.colors.primary.copy(alpha = 0.3f)
                                else -> MaterialTheme.colors.surface
                            },
                            shape = CircleShape
                        ),
                    contentAlignment = Alignment.Center
                ) {
                    if (step.isCompleted) {
                        Icon(
                            Icons.Default.Check,
                            contentDescription = null,
                            tint = Color.White,
                            modifier = Modifier.size(20.dp)
                        )
                    } else {
                        Text(
                            text = step.id,
                            color = if (step.isCurrent) MaterialTheme.colors.primary else MaterialTheme.colors.onSurface,
                            fontWeight = FontWeight.Bold
                        )
                    }
                }
                
                // Step Info
                Column(
                    modifier = Modifier.padding(start = 8.dp)
                ) {
                    Text(
                        text = step.title,
                        fontWeight = if (step.isCurrent) FontWeight.Bold else FontWeight.Normal,
                        color = if (step.isCurrent) MaterialTheme.colors.primary else MaterialTheme.colors.onSurface
                    )
                    Text(
                        text = step.description,
                        fontSize = 12.sp,
                        color = MaterialTheme.colors.onSurface.copy(alpha = 0.6f)
                    )
                }
                
                // Connector Line
                if (index < steps.size - 1) {
                    Box(
                        modifier = Modifier
                            .weight(1f)
                            .height(2.dp)
                            .background(
                                color = if (step.isCompleted) MaterialTheme.colors.primary else MaterialTheme.colors.surface
                            )
                    )
                }
            }
        }
    }
}

@Composable
fun PersonalInfoStep(
    formData: FormData,
    onDataChange: (FormData) -> Unit,
    validationErrors: Map<String, String>
) {
    Column(
        modifier = Modifier.verticalScroll(rememberScrollState())
    ) {
        Text(
            text = "Personal Information",
            fontSize = 20.sp,
            fontWeight = FontWeight.Bold,
            modifier = Modifier.padding(bottom = 16.dp)
        )
        
        OutlinedTextField(
            value = formData.firstName,
            onValueChange = { onDataChange(formData.copy(firstName = it)) },
            label = { Text("First Name") },
            modifier = Modifier
                .fillMaxWidth()
                .padding(bottom = 16.dp),
            isError = validationErrors.containsKey("firstName")
        )
        
        if (validationErrors.containsKey("firstName")) {
            Text(
                text = validationErrors["firstName"] ?: "",
                color = MaterialTheme.colors.error,
                fontSize = 12.sp,
                modifier = Modifier.padding(bottom = 16.dp)
            )
        }
        
        OutlinedTextField(
            value = formData.lastName,
            onValueChange = { onDataChange(formData.copy(lastName = it)) },
            label = { Text("Last Name") },
            modifier = Modifier
                .fillMaxWidth()
                .padding(bottom = 16.dp),
            isError = validationErrors.containsKey("lastName")
        )
        
        if (validationErrors.containsKey("lastName")) {
            Text(
                text = validationErrors["lastName"] ?: "",
                color = MaterialTheme.colors.error,
                fontSize = 12.sp,
                modifier = Modifier.padding(bottom = 16.dp)
            )
        }
        
        OutlinedTextField(
            value = formData.dateOfBirth,
            onValueChange = { onDataChange(formData.copy(dateOfBirth = it)) },
            label = { Text("Date of Birth") },
            modifier = Modifier
                .fillMaxWidth()
                .padding(bottom = 16.dp),
            trailingIcon = { Icon(Icons.Default.DateRange, contentDescription = null) }
        )
        
        Row(
            modifier = Modifier.fillMaxWidth(),
            horizontalArrangement = Arrangement.spacedBy(16.dp)
        ) {
            OutlinedTextField(
                value = formData.gender,
                onValueChange = { onDataChange(formData.copy(gender = it)) },
                label = { Text("Gender") },
                modifier = Modifier.weight(1f),
                trailingIcon = { Icon(Icons.Default.ArrowDropDown, contentDescription = null) }
            )
            
            OutlinedTextField(
                value = formData.nationality,
                onValueChange = { onDataChange(formData.copy(nationality = it)) },
                label = { Text("Nationality") },
                modifier = Modifier.weight(1f),
                trailingIcon = { Icon(Icons.Default.ArrowDropDown, contentDescription = null) }
            )
        }
    }
}

@Composable
fun ContactDetailsStep(
    formData: FormData,
    onDataChange: (FormData) -> Unit,
    validationErrors: Map<String, String>
) {
    Column(
        modifier = Modifier.verticalScroll(rememberScrollState())
    ) {
        Text(
            text = "Contact Details",
            fontSize = 20.sp,
            fontWeight = FontWeight.Bold,
            modifier = Modifier.padding(bottom = 16.dp)
        )
        
        OutlinedTextField(
            value = formData.email,
            onValueChange = { onDataChange(formData.copy(email = it)) },
            label = { Text("Email Address") },
            modifier = Modifier
                .fillMaxWidth()
                .padding(bottom = 16.dp),
            isError = validationErrors.containsKey("email"),
            trailingIcon = { Icon(Icons.Default.Email, contentDescription = null) }
        )
        
        if (validationErrors.containsKey("email")) {
            Text(
                text = validationErrors["email"] ?: "",
                color = MaterialTheme.colors.error,
                fontSize = 12.sp,
                modifier = Modifier.padding(bottom = 16.dp)
            )
        }
        
        OutlinedTextField(
            value = formData.phone,
            onValueChange = { onDataChange(formData.copy(phone = it)) },
            label = { Text("Phone Number") },
            modifier = Modifier
                .fillMaxWidth()
                .padding(bottom = 16.dp),
            isError = validationErrors.containsKey("phone"),
            trailingIcon = { Icon(Icons.Default.Phone, contentDescription = null) }
        )
        
        if (validationErrors.containsKey("phone")) {
            Text(
                text = validationErrors["phone"] ?: "",
                color = MaterialTheme.colors.error,
                fontSize = 12.sp,
                modifier = Modifier.padding(bottom = 16.dp)
            )
        }
        
        OutlinedTextField(
            value = formData.address,
            onValueChange = { onDataChange(formData.copy(address = it)) },
            label = { Text("Address") },
            modifier = Modifier
                .fillMaxWidth()
                .padding(bottom = 16.dp),
            maxLines = 3
        )
        
        Row(
            modifier = Modifier.fillMaxWidth(),
            horizontalArrangement = Arrangement.spacedBy(16.dp)
        ) {
            OutlinedTextField(
                value = formData.city,
                onValueChange = { onDataChange(formData.copy(city = it)) },
                label = { Text("City") },
                modifier = Modifier.weight(1f)
            )
            
            OutlinedTextField(
                value = formData.zipCode,
                onValueChange = { onDataChange(formData.copy(zipCode = it)) },
                label = { Text("ZIP Code") },
                modifier = Modifier.weight(1f)
            )
        }
    }
}

@Composable
fun PreferencesStep(
    formData: FormData,
    onDataChange: (FormData) -> Unit,
    validationErrors: Map<String, String>
) {
    Column(
        modifier = Modifier.verticalScroll(rememberScrollState())
    ) {
        Text(
            text = "Preferences",
            fontSize = 20.sp,
            fontWeight = FontWeight.Bold,
            modifier = Modifier.padding(bottom = 16.dp)
        )
        
        Text(
            text = "Communication Preferences",
            fontSize = 16.sp,
            fontWeight = FontWeight.Medium,
            modifier = Modifier.padding(bottom = 8.dp)
        )
        
        Row(
            modifier = Modifier.fillMaxWidth(),
            horizontalArrangement = Arrangement.SpaceBetween
        ) {
            Text("Email Notifications")
            Switch(
                checked = formData.emailNotifications,
                onCheckedChange = { onDataChange(formData.copy(emailNotifications = it)) }
            )
        }
        
        Row(
            modifier = Modifier.fillMaxWidth(),
            horizontalArrangement = Arrangement.SpaceBetween
        ) {
            Text("SMS Notifications")
            Switch(
                checked = formData.smsNotifications,
                onCheckedChange = { onDataChange(formData.copy(smsNotifications = it)) }
            )
        }
        
        Row(
            modifier = Modifier.fillMaxWidth(),
            horizontalArrangement = Arrangement.SpaceBetween
        ) {
            Text("Push Notifications")
            Switch(
                checked = formData.pushNotifications,
                onCheckedChange = { onDataChange(formData.copy(pushNotifications = it)) }
            )
        }
        
        Spacer(modifier = Modifier.height(16.dp))
        
        Text(
            text = "Privacy Settings",
            fontSize = 16.sp,
            fontWeight = FontWeight.Medium,
            modifier = Modifier.padding(bottom = 8.dp)
        )
        
        Row(
            modifier = Modifier.fillMaxWidth(),
            horizontalArrangement = Arrangement.SpaceBetween
        ) {
            Text("Public Profile")
            Switch(
                checked = formData.publicProfile,
                onCheckedChange = { onDataChange(formData.copy(publicProfile = it)) }
            )
        }
        
        Row(
            modifier = Modifier.fillMaxWidth(),
            horizontalArrangement = Arrangement.SpaceBetween
        ) {
            Text("Data Sharing")
            Switch(
                checked = formData.dataSharing,
                onCheckedChange = { onDataChange(formData.copy(dataSharing = it)) }
            )
        }
        
        Spacer(modifier = Modifier.height(16.dp))
        
        OutlinedTextField(
            value = formData.preferences,
            onValueChange = { onDataChange(formData.copy(preferences = it)) },
            label = { Text("Additional Preferences") },
            modifier = Modifier
                .fillMaxWidth()
                .padding(bottom = 16.dp),
            maxLines = 3,
            isError = validationErrors.containsKey("preferences")
        )
        
        if (validationErrors.containsKey("preferences")) {
            Text(
                text = validationErrors["preferences"] ?: "",
                color = MaterialTheme.colors.error,
                fontSize = 12.sp
            )
        }
    }
}

@Composable
fun ReviewStep(
    formData: FormData,
    showSummary: Boolean,
    onShowSummary: (Boolean) -> Unit
) {
    Column(
        modifier = Modifier.verticalScroll(rememberScrollState())
    ) {
        Text(
            text = "Review & Confirm",
            fontSize = 20.sp,
            fontWeight = FontWeight.Bold,
            modifier = Modifier.padding(bottom = 16.dp)
        )
        
        Card(
            modifier = Modifier.fillMaxWidth(),
            elevation = 2.dp
        ) {
            Column(
                modifier = Modifier.padding(16.dp)
            ) {
                Text(
                    text = "Personal Information",
                    fontWeight = FontWeight.Bold,
                    modifier = Modifier.padding(bottom = 8.dp)
                )
                Text("Name: ${formData.firstName} ${formData.lastName}")
                Text("Date of Birth: ${formData.dateOfBirth}")
                Text("Gender: ${formData.gender}")
                Text("Nationality: ${formData.nationality}")
                
                Spacer(modifier = Modifier.height(16.dp))
                
                Text(
                    text = "Contact Details",
                    fontWeight = FontWeight.Bold,
                    modifier = Modifier.padding(bottom = 8.dp)
                )
                Text("Email: ${formData.email}")
                Text("Phone: ${formData.phone}")
                Text("Address: ${formData.address}")
                Text("City: ${formData.city}, ${formData.zipCode}")
                
                Spacer(modifier = Modifier.height(16.dp))
                
                Text(
                    text = "Preferences",
                    fontWeight = FontWeight.Bold,
                    modifier = Modifier.padding(bottom = 8.dp)
                )
                Text("Email Notifications: ${if (formData.emailNotifications) "Enabled" else "Disabled"}")
                Text("SMS Notifications: ${if (formData.smsNotifications) "Enabled" else "Disabled"}")
                Text("Push Notifications: ${if (formData.pushNotifications) "Enabled" else "Disabled"}")
                Text("Public Profile: ${if (formData.publicProfile) "Yes" else "No"}")
                Text("Data Sharing: ${if (formData.dataSharing) "Yes" else "No"}")
                
                if (formData.preferences.isNotEmpty()) {
                    Text("Additional Preferences: ${formData.preferences}")
                }
            }
        }
        
        Spacer(modifier = Modifier.height(16.dp))
        
        Row(
            modifier = Modifier.fillMaxWidth(),
            horizontalArrangement = Arrangement.SpaceBetween,
            verticalAlignment = Alignment.CenterVertically
        ) {
            Text("I agree to the terms and conditions")
            Checkbox(
                checked = showSummary,
                onCheckedChange = onShowSummary
            )
        }
    }
}

data class FormData(
    val firstName: String = "",
    val lastName: String = "",
    val dateOfBirth: String = "",
    val gender: String = "",
    val nationality: String = "",
    val email: String = "",
    val phone: String = "",
    val address: String = "",
    val city: String = "",
    val zipCode: String = "",
    val emailNotifications: Boolean = true,
    val smsNotifications: Boolean = false,
    val pushNotifications: Boolean = true,
    val publicProfile: Boolean = false,
    val dataSharing: Boolean = false,
    val preferences: String = ""
)

fun validateCurrentStep(formData: FormData, step: Int): Boolean {
    return when (step) {
        0 -> formData.firstName.isNotEmpty() && formData.lastName.isNotEmpty()
        1 -> formData.email.isNotEmpty() && formData.phone.isNotEmpty()
        2 -> formData.preferences.isNotEmpty()
        3 -> true
        else -> true
    }
}

fun getValidationErrors(formData: FormData, step: Int): Map<String, String> {
    val errors = mutableMapOf<String, String>()
    
    when (step) {
        0 -> {
            if (formData.firstName.isEmpty()) errors["firstName"] = "First name is required"
            if (formData.lastName.isEmpty()) errors["lastName"] = "Last name is required"
        }
        1 -> {
            if (formData.email.isEmpty()) errors["email"] = "Email is required"
            if (formData.phone.isEmpty()) errors["phone"] = "Phone number is required"
        }
        2 -> {
            if (formData.preferences.isEmpty()) errors["preferences"] = "Please provide your preferences"
        }
    }
    
    return errors
}

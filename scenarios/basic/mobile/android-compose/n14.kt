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
fun MissingTableHeaderScreen() {
    val employees = listOf(
        Employee(
            id = 1,
            name = "John Smith",
            department = "Engineering",
            position = "Senior Developer",
            salary = "$85,000",
            startDate = "2020-03-15"
        ),
        Employee(
            id = 2,
            name = "Sarah Johnson",
            department = "Marketing",
            position = "Marketing Manager",
            salary = "$72,000",
            startDate = "2019-07-22"
        ),
        Employee(
            id = 3,
            name = "Mike Chen",
            department = "Engineering",
            position = "DevOps Engineer",
            salary = "$78,000",
            startDate = "2021-01-10"
        ),
        Employee(
            id = 4,
            name = "Emily Davis",
            department = "HR",
            position = "HR Specialist",
            salary = "$65,000",
            startDate = "2020-11-05"
        ),
        Employee(
            id = 5,
            name = "David Wilson",
            department = "Sales",
            position = "Sales Director",
            salary = "$95,000",
            startDate = "2018-09-12"
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
                    text = "Employee Directory",
                    fontSize = 24.sp,
                    fontWeight = FontWeight.Bold,
                    color = Color.White
                )
                Text(
                    text = "Company employee information",
                    fontSize = 16.sp,
                    color = Color.White.copy(alpha = 0.9f)
                )
            }
        }
        
        // Data Table - Missing proper headers
        Card(
            modifier = Modifier.fillMaxWidth()
        ) {
            Column(
                modifier = Modifier.padding(16.dp)
            ) {
                Text(
                    text = "Employee Data",
                    fontSize = 18.sp,
                    fontWeight = FontWeight.Bold,
                    modifier = Modifier.padding(bottom = 16.dp)
                )
                
                // Table Header - Using regular Text instead of proper table headers
                Row(
                    modifier = Modifier
                        .fillMaxWidth()
                        .background(Color(0xFFE3F2FD))
                        .padding(12.dp),
                    horizontalArrangement = Arrangement.SpaceBetween
                ) {nts
                    Text(
                        text = "Name",
                        fontSize = 14.sp,
                        fontWeight = FontWeight.Medium,
                        color = Color(0xFF1976D2)
                    )
                    Text(
                        text = "Department",
                        fontSize = 14.sp,
                        fontWeight = FontWeight.Medium,
                        color = Color(0xFF1976D2)
                    )
                    Text(
                        text = "Position",
                        fontSize = 14.sp,
                        fontWeight = FontWeight.Medium,
                        color = Color(0xFF1976D2)
                    )
                    Text(
                        text = "Salary",
                        fontSize = 14.sp,
                        fontWeight = FontWeight.Medium,
                        color = Color(0xFF1976D2)
                    )
                }
                
                // Table Rows
                LazyColumn(
                    verticalArrangement = Arrangement.spacedBy(1.dp)
                ) {
                    items(employees) { employee ->
                        EmployeeRow(employee = employee)
                    }
                }
            }
        }
    }
}

@Composable
fun EmployeeRow(employee: Employee) {
    Row(
        modifier = Modifier
            .fillMaxWidth()
            .background(Color.White)
            .padding(12.dp),
        horizontalArrangement = Arrangement.SpaceBetween,
        verticalAlignment = Alignment.CenterVertically
    ) {
        // Employee Name
        Column(
            modifier = Modifier.weight(1f)
        ) {
            Text(
                text = employee.name,
                fontSize = 14.sp,
                fontWeight = FontWeight.Medium
            )
            Text(
                text = "ID: ${employee.id}",
                fontSize = 12.sp,
                color = Color.Gray
            )
        }
        
        // Department
        Text(
            text = employee.department,
            fontSize = 14.sp,
            color = Color.Gray,
            modifier = Modifier.weight(1f),
            textAlign = TextAlign.Center
        )
        
        // Position
        Text(
            text = employee.position,
            fontSize = 14.sp,
            color = Color.Gray,
            modifier = Modifier.weight(1f),
            textAlign = TextAlign.Center
        )
        
        // Salary
        Text(
            text = employee.salary,
            fontSize = 14.sp,
            fontWeight = FontWeight.Medium,
            color = Color(0xFF4CAF50),
            modifier = Modifier.weight(1f),
            textAlign = TextAlign.End
        )
    }
}

data class Employee(
    val id: Int,
    val name: String,
    val department: String,
    val position: String,
    val salary: String,
    val startDate: String
)

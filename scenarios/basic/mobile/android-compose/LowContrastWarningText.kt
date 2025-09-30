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
fun LowContrastWarningTextScreen() {
    var sessionTimeLeft by remember { mutableStateOf(15) }
    var isSessionActive by remember { mutableStateOf(true) }
    
    LaunchedEffect(Unit) {
        while (isSessionActive && sessionTimeLeft > 0) {
            kotlinx.coroutines.delay(1000)
            sessionTimeLeft--
        }
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
                    text = "Secure Banking Portal",
                    fontSize = 24.sp,
                    fontWeight = FontWeight.Bold,
                    color = Color.White
                )
                Text(
                    text = "Manage your accounts safely",
                    fontSize = 16.sp,
                    color = Color.White.copy(alpha = 0.9f)
                )
            }
        }
        
        // Session Warning - LOW CONTRAST
        if (sessionTimeLeft <= 5) {
            Card(
                modifier = Modifier
                    .fillMaxWidth()
                    .padding(bottom = 16.dp),
                colors = CardDefaults.cardColors(containerColor = Color(0xFFF8F8F8)), // Very light background
                elevation = CardDefaults.cardElevation(defaultElevation = 2.dp)
            ) {
                Row(
                    modifier = Modifier
                        .fillMaxWidth()
                        .padding(16.dp),
                    verticalAlignment = Alignment.CenterVertically
                ) {
                    Icon(
                        imageVector = Icons.Default.Warning,
                        contentDescription = null,
                        tint = Color(0xFFCCCCCC), // Very light gray - LOW CONTRAST
                        modifier = Modifier.size(24.dp)
                    )
                    
                    Spacer(modifier = Modifier.width(12.dp))
                    
                    Text(
                        text = "Your session will expire in $sessionTimeLeft seconds. Please save your work and refresh the page to continue.",
                        fontSize = 14.sp,
                        color = Color(0xFFCCCCCC), // Very light gray - LOW CONTRAST
                        modifier = Modifier.weight(1f)
                    )
                }
            }
        }
        
        // Account Overview
        Card(
            modifier = Modifier
                .fillMaxWidth()
                .padding(bottom = 16.dp)
        ) {
            Column(
                modifier = Modifier.padding(20.dp)
            ) {
                Text(
                    text = "Account Overview",
                    fontSize = 20.sp,
                    fontWeight = FontWeight.Bold,
                    modifier = Modifier.padding(bottom = 16.dp)
                )
                
                val accounts = listOf(
                    AccountInfo("Checking Account", "$12,450.00", "****1234"),
                    AccountInfo("Savings Account", "$45,230.00", "****5678"),
                    AccountInfo("Credit Card", "-$2,340.00", "****9012")
                )
                
                accounts.forEach { account ->
                    AccountCard(account = account)
                    Spacer(modifier = Modifier.height(12.dp))
                }
            }
        }
        
        // Quick Actions
        Card(
            modifier = Modifier.fillMaxWidth()
        ) {
            Column(
                modifier = Modifier.padding(20.dp)
            ) {
                Text(
                    text = "Quick Actions",
                    fontSize = 20.sp,
                    fontWeight = FontWeight.Bold,
                    modifier = Modifier.padding(bottom = 16.dp)
                )
                
                Row(
                    modifier = Modifier.fillMaxWidth(),
                    horizontalArrangement = Arrangement.spacedBy(12.dp)
                ) {
                    QuickActionButton(
                        title = "Transfer",
                        icon = Icons.Default.SwapHoriz,
                        onClick = { }
                    )
                    
                    QuickActionButton(
                        title = "Pay Bills",
                        icon = Icons.Default.Receipt,
                        onClick = { }
                    )
                    
                    QuickActionButton(
                        title = "Deposit",
                        icon = Icons.Default.Add,
                        onClick = { }
                    )
                }
            }
        }
    }
}

@Composable
fun AccountCard(account: AccountInfo) {
    Card(
        modifier = Modifier
            .fillMaxWidth()
            .clip(RoundedCornerShape(8.dp)),
        colors = CardDefaults.cardColors(containerColor = Color(0xFFF8F9FA)),
        elevation = CardDefaults.cardElevation(defaultElevation = 2.dp)
    ) {
        Row(
            modifier = Modifier
                .fillMaxWidth()
                .padding(16.dp),
            verticalAlignment = Alignment.CenterVertically
        ) {
            Icon(
                imageVector = Icons.Default.AccountBalance,
                contentDescription = null,
                tint = Color(0xFF2196F3),
                modifier = Modifier.size(24.dp)
            )
            
            Spacer(modifier = Modifier.width(12.dp))
            
            Column(
                modifier = Modifier.weight(1f)
            ) {
                Text(
                    text = account.name,
                    fontSize = 16.sp,
                    fontWeight = FontWeight.Medium
                )
                Text(
                    text = account.accountNumber,
                    fontSize = 14.sp,
                    color = Color.Gray
                )
            }
            
            Text(
                text = account.balance,
                fontSize = 18.sp,
                fontWeight = FontWeight.Bold,
                color = if (account.balance.startsWith("-")) Color(0xFFE53E3E) else Color(0xFF38A169)
            )
        }
    }
}

@Composable
fun QuickActionButton(
    title: String,
    icon: androidx.compose.ui.graphics.vector.ImageVector,
    onClick: () -> Unit
) {
    Button(
        onClick = onClick,
        modifier = Modifier
            .weight(1f)
            .height(80.dp),
        colors = ButtonDefaults.buttonColors(containerColor = Color(0xFF2196F3))
    ) {
        Column(
            horizontalAlignment = Alignment.CenterHorizontally
        ) {
            Icon(
                imageVector = icon,
                contentDescription = null,
                modifier = Modifier.size(24.dp)
            )
            Spacer(modifier = Modifier.height(4.dp))
            Text(
                text = title,
                fontSize = 12.sp
            )
        }
    }
}

data class AccountInfo(
    val name: String,
    val balance: String,
    val accountNumber: String
)

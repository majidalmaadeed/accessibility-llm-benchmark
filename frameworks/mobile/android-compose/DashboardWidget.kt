package com.accessibility.benchmark.compose

import androidx.compose.foundation.background
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyRow
import androidx.compose.foundation.lazy.items
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material.*
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.vector.ImageVector
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp

data class ChartData(
    val label: String,
    val value: Float,
    val color: Color
)

data class MetricCard(
    val title: String,
    val value: String,
    val change: String,
    val changeType: ChangeType,
    val icon: ImageVector
)

enum class ChangeType {
    POSITIVE, NEGATIVE, NEUTRAL
}

@Composable
fun DashboardWidget() {
    var selectedTimeRange by remember { mutableStateOf("7D") }
    var selectedMetric by remember { mutableStateOf("Revenue") }
    var showFilters by remember { mutableStateOf(false) }
    var exportFormat by remember { mutableStateOf("PDF") }
    
    val timeRanges = listOf("1D", "7D", "30D", "90D", "1Y")
    val metrics = listOf("Revenue", "Users", "Orders", "Conversion")
    val exportFormats = listOf("PDF", "CSV", "Excel", "PNG")
    
    val sampleMetrics = remember {
        listOf(
            MetricCard("Total Revenue", "$125,430", "+12.5%", ChangeType.POSITIVE, Icons.Default.AttachMoney),
            MetricCard("Active Users", "8,432", "+8.2%", ChangeType.POSITIVE, Icons.Default.People),
            MetricCard("Orders", "1,234", "-2.1%", ChangeType.NEGATIVE, Icons.Default.ShoppingCart),
            MetricCard("Conversion", "3.2%", "+0.5%", ChangeType.POSITIVE, Icons.Default.TrendingUp)
        )
    }
    
    val chartData = remember {
        listOf(
            ChartData("Jan", 45f, Color.Blue),
            ChartData("Feb", 52f, Color.Blue),
            ChartData("Mar", 48f, Color.Blue),
            ChartData("Apr", 61f, Color.Blue),
            ChartData("May", 55f, Color.Blue),
            ChartData("Jun", 67f, Color.Blue)
        )
    }
    
    Column(
        modifier = Modifier
            .fillMaxSize()
            .padding(16.dp)
    ) {
        // Header
        Row(
            modifier = Modifier.fillMaxWidth(),
            horizontalArrangement = Arrangement.SpaceBetween,
            verticalAlignment = Alignment.CenterVertically
        ) {
            Text(
                text = "Dashboard",
                fontSize = 24.sp,
                fontWeight = FontWeight.Bold
            )
            
            Row {
                IconButton(onClick = { showFilters = !showFilters }) {
                    Icon(Icons.Default.FilterList, contentDescription = null)
                }
                IconButton(onClick = { /* Export functionality */ }) {
                    Icon(Icons.Default.FileDownload, contentDescription = null)
                }
                IconButton(onClick = { /* Refresh data */ }) {
                    Icon(Icons.Default.Refresh, contentDescription = null)
                }
            }
        }
        
        Spacer(modifier = Modifier.height(16.dp))
        
        // Time Range Selector
        LazyRow(
            horizontalArrangement = Arrangement.spacedBy(8.dp),
            modifier = Modifier.padding(bottom = 16.dp)
        ) {
            items(timeRanges) { range ->
                FilterChip(
                    onClick = { selectedTimeRange = range },
                    label = { Text(range) },
                    selected = selectedTimeRange == range
                )
            }
        }
        
        // Metric Cards
        LazyRow(
            horizontalArrangement = Arrangement.spacedBy(16.dp),
            modifier = Modifier.padding(bottom = 24.dp)
        ) {
            items(sampleMetrics) { metric ->
                MetricCard(metric = metric)
            }
        }
        
        // Chart Section
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
                    .padding(16.dp)
            ) {
                Row(
                    modifier = Modifier.fillMaxWidth(),
                    horizontalArrangement = Arrangement.SpaceBetween,
                    verticalAlignment = Alignment.CenterVertically
                ) {
                    Text(
                        text = "$selectedMetric Trend",
                        fontSize = 18.sp,
                        fontWeight = FontWeight.Bold
                    )
                    
                    Row {
                        IconButton(onClick = { /* Chart settings */ }) {
                            Icon(Icons.Default.Settings, contentDescription = null)
                        }
                        IconButton(onClick = { /* Fullscreen chart */ }) {
                            Icon(Icons.Default.Fullscreen, contentDescription = null)
                        }
                    }
                }
                
                Spacer(modifier = Modifier.height(16.dp))
                
                // Simple Bar Chart
                SimpleBarChart(
                    data = chartData,
                    modifier = Modifier
                        .fillMaxWidth()
                        .height(200.dp)
                )
                
                Spacer(modifier = Modifier.height(16.dp))
                
                // Chart Legend
                Row(
                    modifier = Modifier.fillMaxWidth(),
                    horizontalArrangement = Arrangement.SpaceEvenly
                ) {
                    LegendItem("Revenue", Color.Blue)
                    LegendItem("Users", Color.Green)
                    LegendItem("Orders", Color.Orange)
                }
            }
        }
        
        Spacer(modifier = Modifier.height(16.dp))
        
        // Quick Actions
        Row(
            modifier = Modifier.fillMaxWidth(),
            horizontalArrangement = Arrangement.spacedBy(8.dp)
        ) {
            Button(
                onClick = { /* Generate report */ },
                modifier = Modifier.weight(1f)
            ) {
                Icon(Icons.Default.Assessment, contentDescription = null)
                Spacer(modifier = Modifier.width(8.dp))
                Text("Generate Report")
            }
            
            Button(
                onClick = { /* Share dashboard */ },
                modifier = Modifier.weight(1f)
            ) {
                Icon(Icons.Default.Share, contentDescription = null)
                Spacer(modifier = Modifier.width(8.dp))
                Text("Share")
            }
        }
    }
}

@Composable
fun MetricCard(metric: MetricCard) {
    Card(
        modifier = Modifier.width(200.dp),
        elevation = 2.dp,
        shape = RoundedCornerShape(8.dp)
    ) {
        Column(
            modifier = Modifier.padding(16.dp)
        ) {
            Row(
                modifier = Modifier.fillMaxWidth(),
                horizontalArrangement = Arrangement.SpaceBetween,
                verticalAlignment = Alignment.CenterVertically
            ) {
                Text(
                    text = metric.title,
                    fontSize = 14.sp,
                    color = MaterialTheme.colors.onSurface.copy(alpha = 0.6f)
                )
                Icon(
                    imageVector = metric.icon,
                    contentDescription = null,
                    tint = MaterialTheme.colors.primary
                )
            }
            
            Spacer(modifier = Modifier.height(8.dp))
            
            Text(
                text = metric.value,
                fontSize = 24.sp,
                fontWeight = FontWeight.Bold
            )
            
            Spacer(modifier = Modifier.height(4.dp))
            
            Row(
                verticalAlignment = Alignment.CenterVertically
            ) {
                Icon(
                    imageVector = when (metric.changeType) {
                        ChangeType.POSITIVE -> Icons.Default.TrendingUp
                        ChangeType.NEGATIVE -> Icons.Default.TrendingDown
                        ChangeType.NEUTRAL -> Icons.Default.TrendingFlat
                    },
                    contentDescription = null,
                    tint = when (metric.changeType) {
                        ChangeType.POSITIVE -> Color.Green
                        ChangeType.NEGATIVE -> Color.Red
                        ChangeType.NEUTRAL -> Color.Gray
                    },
                    modifier = Modifier.size(16.dp)
                )
                Spacer(modifier = Modifier.width(4.dp))
                Text(
                    text = metric.change,
                    fontSize = 12.sp,
                    color = when (metric.changeType) {
                        ChangeType.POSITIVE -> Color.Green
                        ChangeType.NEGATIVE -> Color.Red
                        ChangeType.NEUTRAL -> Color.Gray
                    }
                )
            }
        }
    }
}

@Composable
fun SimpleBarChart(
    data: List<ChartData>,
    modifier: Modifier = Modifier
) {
    val maxValue = data.maxOfOrNull { it.value } ?: 1f
    
    Row(
        modifier = modifier,
        horizontalArrangement = Arrangement.SpaceEvenly,
        verticalAlignment = Alignment.Bottom
    ) {
        data.forEach { item ->
            Column(
                horizontalAlignment = Alignment.CenterHorizontally
            ) {
                Box(
                    modifier = Modifier
                        .width(30.dp)
                        .height((item.value / maxValue * 150).dp)
                        .background(
                            color = item.color,
                            shape = RoundedCornerShape(4.dp)
                        )
                )
                Spacer(modifier = Modifier.height(8.dp))
                Text(
                    text = item.label,
                    fontSize = 12.sp
                )
            }
        }
    }
}

@Composable
fun LegendItem(label: String, color: Color) {
    Row(
        verticalAlignment = Alignment.CenterVertically
    ) {
        Box(
            modifier = Modifier
                .size(12.dp)
                .background(color, shape = RoundedCornerShape(2.dp))
        )
        Spacer(modifier = Modifier.width(4.dp))
        Text(
            text = label,
            fontSize = 12.sp
        )
    }
}

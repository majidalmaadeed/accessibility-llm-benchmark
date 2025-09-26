package com.accessibility.benchmark.compose

import androidx.compose.foundation.background
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.foundation.lazy.rememberLazyListState
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material.*
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp

data class TableRow(
    val id: String,
    val name: String,
    val email: String,
    val department: String,
    val salary: Double,
    val status: String,
    val joinDate: String,
    val isSelected: Boolean = false
)

@Composable
fun DataTableComplex() {
    var searchQuery by remember { mutableStateOf("") }
    var selectedDepartment by remember { mutableStateOf("All") }
    var sortColumn by remember { mutableStateOf("name") }
    var sortAscending by remember { mutableStateOf(true) }
    var currentPage by remember { mutableStateOf(1) }
    var showFilters by remember { mutableStateOf(false) }
    var selectedRows by remember { mutableStateOf(setOf<String>()) }
    var showBulkActions by remember { mutableStateOf(false) }
    
    val departments = listOf("All", "Engineering", "Marketing", "Sales", "HR", "Finance")
    val itemsPerPage = 10
    
    val sampleData = remember {
        listOf(
            TableRow("1", "John Doe", "john@example.com", "Engineering", 75000.0, "Active", "2023-01-15"),
            TableRow("2", "Jane Smith", "jane@example.com", "Marketing", 65000.0, "Active", "2023-02-20"),
            TableRow("3", "Mike Johnson", "mike@example.com", "Sales", 70000.0, "Inactive", "2023-03-10"),
            TableRow("4", "Sarah Wilson", "sarah@example.com", "HR", 60000.0, "Active", "2023-04-05"),
            TableRow("5", "David Brown", "david@example.com", "Finance", 80000.0, "Active", "2023-05-12"),
            TableRow("6", "Lisa Davis", "lisa@example.com", "Engineering", 72000.0, "Active", "2023-06-18"),
            TableRow("7", "Tom Miller", "tom@example.com", "Marketing", 68000.0, "Inactive", "2023-07-22"),
            TableRow("8", "Amy Garcia", "amy@example.com", "Sales", 69000.0, "Active", "2023-08-30"),
            TableRow("9", "Chris Lee", "chris@example.com", "HR", 62000.0, "Active", "2023-09-14"),
            TableRow("10", "Emma Taylor", "emma@example.com", "Finance", 78000.0, "Active", "2023-10-08")
        )
    }
    
    val filteredData = remember(sampleData, searchQuery, selectedDepartment) {
        sampleData.filter { row ->
            val matchesSearch = row.name.contains(searchQuery, ignoreCase = true) ||
                    row.email.contains(searchQuery, ignoreCase = true)
            val matchesDepartment = selectedDepartment == "All" || row.department == selectedDepartment
            matchesSearch && matchesDepartment
        }
    }
    
    val sortedData = remember(filteredData, sortColumn, sortAscending) {
        filteredData.sortedWith { a, b ->
            val comparison = when (sortColumn) {
                "name" -> a.name.compareTo(b.name)
                "email" -> a.email.compareTo(b.email)
                "department" -> a.department.compareTo(b.department)
                "salary" -> a.salary.compareTo(b.salary)
                "status" -> a.status.compareTo(b.status)
                "joinDate" -> a.joinDate.compareTo(b.joinDate)
                else -> 0
            }
            if (sortAscending) comparison else -comparison
        }
    }
    
    val totalPages = (sortedData.size + itemsPerPage - 1) / itemsPerPage
    val startIndex = (currentPage - 1) * itemsPerPage
    val endIndex = minOf(startIndex + itemsPerPage, sortedData.size)
    val pageData = sortedData.subList(startIndex, endIndex)
    
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
                text = "Employee Data Table",
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
            }
        }
        
        Spacer(modifier = Modifier.height(16.dp))
        
        // Search and Filter Bar
        Row(
            modifier = Modifier.fillMaxWidth(),
            horizontalArrangement = Arrangement.spacedBy(8.dp)
        ) {
            OutlinedTextField(
                value = searchQuery,
                onValueChange = { searchQuery = it },
                modifier = Modifier.weight(1f),
                placeholder = { Text("Search employees...") },
                leadingIcon = { Icon(Icons.Default.Search, contentDescription = null) }
            )
            
            DropdownMenu(
                expanded = showFilters,
                onDismissRequest = { showFilters = false }
            ) {
                departments.forEach { dept ->
                    DropdownMenuItem(onClick = {
                        selectedDepartment = dept
                        showFilters = false
                    }) {
                        Text(dept)
                    }
                }
            }
            
            Button(
                onClick = { showFilters = true },
                modifier = Modifier.padding(horizontal = 8.dp)
            ) {
                Text("Filter")
                Icon(Icons.Default.ArrowDropDown, contentDescription = null)
            }
        }
        
        Spacer(modifier = Modifier.height(16.dp))
        
        // Bulk Actions
        if (selectedRows.isNotEmpty()) {
            Card(
                modifier = Modifier.fillMaxWidth(),
                backgroundColor = MaterialTheme.colors.primary.copy(alpha = 0.1f)
            ) {
                Row(
                    modifier = Modifier
                        .fillMaxWidth()
                        .padding(16.dp),
                    horizontalArrangement = Arrangement.SpaceBetween,
                    verticalAlignment = Alignment.CenterVertically
                ) {
                    Text(
                        text = "${selectedRows.size} items selected",
                        fontWeight = FontWeight.Medium
                    )
                    
                    Row {
                        Button(onClick = { /* Bulk edit */ }) {
                            Text("Edit")
                        }
                        Spacer(modifier = Modifier.width(8.dp))
                        Button(onClick = { /* Bulk delete */ }) {
                            Text("Delete")
                        }
                        Spacer(modifier = Modifier.width(8.dp))
                        Button(onClick = { /* Bulk export */ }) {
                            Text("Export")
                        }
                    }
                }
            }
            
            Spacer(modifier = Modifier.height(8.dp))
        }
        
        // Table Header
        Card(
            modifier = Modifier.fillMaxWidth(),
            elevation = 2.dp
        ) {
            Row(
                modifier = Modifier
                    .fillMaxWidth()
                    .background(MaterialTheme.colors.primary.copy(alpha = 0.1f))
                    .padding(16.dp),
                horizontalArrangement = Arrangement.SpaceBetween
            ) {
                Row(
                    modifier = Modifier.weight(0.1f),
                    verticalAlignment = Alignment.CenterVertically
                ) {
                    Checkbox(
                        checked = selectedRows.size == pageData.size && pageData.isNotEmpty(),
                        onCheckedChange = { checked ->
                            if (checked) {
                                selectedRows = pageData.map { it.id }.toSet()
                            } else {
                                selectedRows = emptySet()
                            }
                        }
                    )
                }
                
                TableHeaderCell(
                    text = "Name",
                    weight = 0.2f,
                    sortColumn = sortColumn,
                    currentSort = sortColumn,
                    sortAscending = sortAscending,
                    onSort = { sortColumn = "name"; sortAscending = !sortAscending }
                )
                
                TableHeaderCell(
                    text = "Email",
                    weight = 0.25f,
                    sortColumn = sortColumn,
                    currentSort = sortColumn,
                    sortAscending = sortAscending,
                    onSort = { sortColumn = "email"; sortAscending = !sortAscending }
                )
                
                TableHeaderCell(
                    text = "Department",
                    weight = 0.15f,
                    sortColumn = sortColumn,
                    currentSort = sortColumn,
                    sortAscending = sortAscending,
                    onSort = { sortColumn = "department"; sortAscending = !sortAscending }
                )
                
                TableHeaderCell(
                    text = "Salary",
                    weight = 0.1f,
                    sortColumn = sortColumn,
                    currentSort = sortColumn,
                    sortAscending = sortAscending,
                    onSort = { sortColumn = "salary"; sortAscending = !sortAscending }
                )
                
                TableHeaderCell(
                    text = "Status",
                    weight = 0.1f,
                    sortColumn = sortColumn,
                    currentSort = sortColumn,
                    sortAscending = sortAscending,
                    onSort = { sortColumn = "status"; sortAscending = !sortAscending }
                )
                
                TableHeaderCell(
                    text = "Actions",
                    weight = 0.1f,
                    sortColumn = sortColumn,
                    currentSort = sortColumn,
                    sortAscending = sortAscending,
                    onSort = { /* No sort for actions */ }
                )
            }
        }
        
        Spacer(modifier = Modifier.height(8.dp))
        
        // Table Body
        LazyColumn(
            modifier = Modifier.fillMaxWidth(),
            verticalArrangement = Arrangement.spacedBy(4.dp)
        ) {
            items(pageData) { row ->
                TableRowItem(
                    row = row,
                    isSelected = selectedRows.contains(row.id),
                    onSelectionChange = { selected ->
                        if (selected) {
                            selectedRows = selectedRows + row.id
                        } else {
                            selectedRows = selectedRows - row.id
                        }
                    },
                    onEdit = { /* Edit row */ },
                    onDelete = { /* Delete row */ },
                    onView = { /* View details */ }
                )
            }
        }
        
        Spacer(modifier = Modifier.height(16.dp))
        
        // Pagination
        Row(
            modifier = Modifier.fillMaxWidth(),
            horizontalArrangement = Arrangement.SpaceBetween,
            verticalAlignment = Alignment.CenterVertically
        ) {
            Text(
                text = "Showing ${startIndex + 1}-${endIndex} of ${sortedData.size} results",
                fontSize = 14.sp,
                color = MaterialTheme.colors.onSurface.copy(alpha = 0.6f)
            )
            
            Row(
                horizontalArrangement = Arrangement.spacedBy(8.dp),
                verticalAlignment = Alignment.CenterVertically
            ) {
                Button(
                    onClick = { currentPage = maxOf(1, currentPage - 1) },
                    enabled = currentPage > 1
                ) {
                    Text("Previous")
                }
                
                Text(
                    text = "Page $currentPage of $totalPages",
                    fontSize = 14.sp
                )
                
                Button(
                    onClick = { currentPage = minOf(totalPages, currentPage + 1) },
                    enabled = currentPage < totalPages
                ) {
                    Text("Next")
                }
            }
        }
    }
}

@Composable
fun TableHeaderCell(
    text: String,
    weight: Float,
    sortColumn: String,
    currentSort: String,
    sortAscending: Boolean,
    onSort: () -> Unit
) {
    Row(
        modifier = Modifier
            .weight(weight)
            .clickable { onSort() },
        verticalAlignment = Alignment.CenterVertically
    ) {
        Text(
            text = text,
            fontWeight = FontWeight.Bold,
            fontSize = 14.sp
        )
        
        if (sortColumn == currentSort) {
            Icon(
                imageVector = if (sortAscending) Icons.Default.ArrowUpward else Icons.Default.ArrowDownward,
                contentDescription = null,
                modifier = Modifier.size(16.dp)
            )
        }
    }
}

@Composable
fun TableRowItem(
    row: TableRow,
    isSelected: Boolean,
    onSelectionChange: (Boolean) -> Unit,
    onEdit: () -> Unit,
    onDelete: () -> Unit,
    onView: () -> Unit
) {
    Card(
        modifier = Modifier.fillMaxWidth(),
        elevation = 1.dp,
        backgroundColor = if (isSelected) MaterialTheme.colors.primary.copy(alpha = 0.1f) else MaterialTheme.colors.surface
    ) {
        Row(
            modifier = Modifier
                .fillMaxWidth()
                .padding(16.dp),
            horizontalArrangement = Arrangement.SpaceBetween,
            verticalAlignment = Alignment.CenterVertically
        ) {
            Row(
                modifier = Modifier.weight(0.1f),
                verticalAlignment = Alignment.CenterVertically
            ) {
                Checkbox(
                    checked = isSelected,
                    onCheckedChange = onSelectionChange
                )
            }
            
            Text(
                text = row.name,
                modifier = Modifier.weight(0.2f),
                fontSize = 14.sp
            )
            
            Text(
                text = row.email,
                modifier = Modifier.weight(0.25f),
                fontSize = 14.sp,
                color = MaterialTheme.colors.primary
            )
            
            Text(
                text = row.department,
                modifier = Modifier.weight(0.15f),
                fontSize = 14.sp
            )
            
            Text(
                text = "$${String.format("%.0f", row.salary)}",
                modifier = Modifier.weight(0.1f),
                fontSize = 14.sp,
                textAlign = TextAlign.End
            )
            
            Text(
                text = row.status,
                modifier = Modifier.weight(0.1f),
                fontSize = 14.sp,
                color = if (row.status == "Active") Color.Green else Color.Red
            )
            
            Row(
                modifier = Modifier.weight(0.1f),
                horizontalArrangement = Arrangement.spacedBy(4.dp)
            ) {
                IconButton(onClick = onView) {
                    Icon(Icons.Default.Visibility, contentDescription = null, modifier = Modifier.size(16.dp))
                }
                IconButton(onClick = onEdit) {
                    Icon(Icons.Default.Edit, contentDescription = null, modifier = Modifier.size(16.dp))
                }
                IconButton(onClick = onDelete) {
                    Icon(Icons.Default.Delete, contentDescription = null, modifier = Modifier.size(16.dp))
                }
            }
        }
    }
}

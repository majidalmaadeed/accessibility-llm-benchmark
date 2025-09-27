import 'package:flutter/material.dart';

class DataTableComplex extends StatefulWidget {
  const DataTableComplex({Key? key}) : super(key: key);

  @override
  State<DataTableComplex> createState() => _DataTableComplexState();
}

class _DataTableComplexState extends State<DataTableComplex> {
  String searchQuery = '';
  String sortColumn = 'name';
  bool sortAscending = true;
  Set<String> selectedRows = {};
  int currentPage = 1;
  bool showFilters = false;
  String departmentFilter = 'All';
  String statusFilter = 'All';
  int itemsPerPage = 10;
  bool isLoading = false;

  final List<String> departments = ['All', 'Engineering', 'Marketing', 'Sales', 'HR', 'Finance'];
  final List<String> statuses = ['All', 'Active', 'Inactive', 'Pending', 'Terminated'];

  final List<Map<String, dynamic>> sampleData = [
    {
      'id': '1',
      'name': 'John Doe',
      'email': 'john@example.com',
      'department': 'Engineering',
      'salary': 75000.0,
      'status': 'Active',
      'joinDate': '2023-01-15',
    },
    {
      'id': '2',
      'name': 'Jane Smith',
      'email': 'jane@example.com',
      'department': 'Marketing',
      'salary': 65000.0,
      'status': 'Active',
      'joinDate': '2023-02-20',
    },
    {
      'id': '3',
      'name': 'Mike Johnson',
      'email': 'mike@example.com',
      'department': 'Sales',
      'salary': 70000.0,
      'status': 'Inactive',
      'joinDate': '2023-03-10',
    },
    {
      'id': '4',
      'name': 'Sarah Wilson',
      'email': 'sarah@example.com',
      'department': 'HR',
      'salary': 60000.0,
      'status': 'Active',
      'joinDate': '2023-04-05',
    },
    {
      'id': '5',
      'name': 'David Brown',
      'email': 'david@example.com',
      'department': 'Finance',
      'salary': 80000.0,
      'status': 'Active',
      'joinDate': '2023-05-12',
    },
    {
      'id': '6',
      'name': 'Lisa Davis',
      'email': 'lisa@example.com',
      'department': 'Engineering',
      'salary': 72000.0,
      'status': 'Active',
      'joinDate': '2023-06-18',
    },
    {
      'id': '7',
      'name': 'Tom Miller',
      'email': 'tom@example.com',
      'department': 'Marketing',
      'salary': 68000.0,
      'status': 'Inactive',
      'joinDate': '2023-07-22',
    },
    {
      'id': '8',
      'name': 'Amy Garcia',
      'email': 'amy@example.com',
      'department': 'Sales',
      'salary': 69000.0,
      'status': 'Active',
      'joinDate': '2023-08-30',
    },
    {
      'id': '9',
      'name': 'Chris Lee',
      'email': 'chris@example.com',
      'department': 'HR',
      'salary': 62000.0,
      'status': 'Active',
      'joinDate': '2023-09-14',
    },
    {
      'id': '10',
      'name': 'Emma Taylor',
      'email': 'emma@example.com',
      'department': 'Finance',
      'salary': 78000.0,
      'status': 'Active',
      'joinDate': '2023-10-08',
    },
  ];

  List<Map<String, dynamic>> get filteredData {
    return sampleData.where((row) {
      final matchesSearch = row['name'].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                           row['email'].toString().toLowerCase().contains(searchQuery.toLowerCase());
      final matchesDepartment = departmentFilter == 'All' || row['department'] == departmentFilter;
      final matchesStatus = statusFilter == 'All' || row['status'] == statusFilter;
      return matchesSearch && matchesDepartment && matchesStatus;
    }).toList();
  }

  List<Map<String, dynamic>> get sortedData {
    final filtered = filteredData;
    filtered.sort((a, b) {
      dynamic aValue = a[sortColumn];
      dynamic bValue = b[sortColumn];
      
      if (aValue is String && bValue is String) {
        return sortAscending ? aValue.compareTo(bValue) : bValue.compareTo(aValue);
      } else if (aValue is num && bValue is num) {
        return sortAscending ? aValue.compareTo(bValue) : bValue.compareTo(aValue);
      }
      return 0;
    });
    return filtered;
  }

  int get totalPages => (sortedData.length / itemsPerPage).ceil();
  int get startIndex => (currentPage - 1) * itemsPerPage;
  int get endIndex => (startIndex + itemsPerPage).clamp(0, sortedData.length);
  List<Map<String, dynamic>> get pageData => sortedData.sublist(startIndex, endIndex);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Employee Data Table'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () => setState(() => showFilters = !showFilters),
          ),
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: () => _exportData('CSV'),
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadData,
          ),
        ],
      ),
      body: Column(
        children: [
          _buildSearchBar(),
          if (showFilters) _buildFilters(),
          if (selectedRows.isNotEmpty) _buildBulkActions(),
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : sortedData.isEmpty
                    ? _buildEmptyState()
                    : _buildDataTable(),
          ),
          _buildPagination(),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Search employees...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
              onChanged: (value) => setState(() => searchQuery = value),
            ),
          ),
          const SizedBox(width: 12),
          ElevatedButton.icon(
            onPressed: () => setState(() => showFilters = !showFilters),
            icon: const Icon(Icons.filter_list),
            label: const Text('Filter'),
          ),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Filters', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              TextButton(
                onPressed: _clearFilters,
                child: const Text('Clear All'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Department', style: TextStyle(fontWeight: FontWeight.w500)),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<String>(
                      value: departmentFilter,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      ),
                      items: departments.map((dept) => DropdownMenuItem(
                        value: dept,
                        child: Text(dept),
                      )).toList(),
                      onChanged: (value) => setState(() => departmentFilter = value!),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Status', style: TextStyle(fontWeight: FontWeight.w500)),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<String>(
                      value: statusFilter,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      ),
                      items: statuses.map((status) => DropdownMenuItem(
                        value: status,
                        child: Text(status),
                      )).toList(),
                      onChanged: (value) => setState(() => statusFilter = value!),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBulkActions() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.blue[50],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '${selectedRows.length} item${selectedRows.length != 1 ? 's' : ''} selected',
            style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.blue),
          ),
          Row(
            children: [
              TextButton(
                onPressed: () => _handleBulkAction('Edit'),
                child: const Text('Edit'),
              ),
              const SizedBox(width: 8),
              TextButton(
                onPressed: () => _handleBulkAction('Delete'),
                child: const Text('Delete', style: TextStyle(color: Colors.red)),
              ),
              const SizedBox(width: 8),
              TextButton(
                onPressed: () => _handleBulkAction('Export'),
                child: const Text('Export'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDataTable() {
    return Card(
      margin: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: [
            DataColumn(
              label: Checkbox(
                value: selectedRows.length == pageData.length && pageData.isNotEmpty,
                onChanged: _handleSelectAll,
              ),
            ),
            DataColumn(
              label: _buildSortableHeader('Name', 'name'),
              onSort: (columnIndex, ascending) => _handleSort('name'),
            ),
            DataColumn(
              label: _buildSortableHeader('Email', 'email'),
              onSort: (columnIndex, ascending) => _handleSort('email'),
            ),
            DataColumn(
              label: _buildSortableHeader('Department', 'department'),
              onSort: (columnIndex, ascending) => _handleSort('department'),
            ),
            DataColumn(
              label: _buildSortableHeader('Salary', 'salary'),
              onSort: (columnIndex, ascending) => _handleSort('salary'),
            ),
            DataColumn(
              label: _buildSortableHeader('Status', 'status'),
              onSort: (columnIndex, ascending) => _handleSort('status'),
            ),
            const DataColumn(label: Text('Actions')),
          ],
          rows: pageData.map((row) => DataRow(
            selected: selectedRows.contains(row['id']),
            onSelectChanged: (selected) => _handleSelectRow(row['id']),
            cells: [
              DataCell(Checkbox(
                value: selectedRows.contains(row['id']),
                onChanged: (selected) => _handleSelectRow(row['id']),
              )),
              DataCell(Text(row['name'])),
              DataCell(Text(row['email'], style: const TextStyle(color: Colors.blue))),
              DataCell(Text(row['department'])),
              DataCell(Text('\$${row['salary'].toStringAsFixed(0)}')),
              DataCell(
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: row['status'] == 'Active' ? Colors.green : Colors.red,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    row['status'],
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ),
              DataCell(Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.visibility, size: 16),
                    onPressed: () => _handleRowAction('view', row['id']),
                  ),
                  IconButton(
                    icon: const Icon(Icons.edit, size: 16),
                    onPressed: () => _handleRowAction('edit', row['id']),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, size: 16, color: Colors.red),
                    onPressed: () => _handleRowAction('delete', row['id']),
                  ),
                ],
              )),
            ],
          )).toList(),
        ),
      ),
    );
  }

  Widget _buildSortableHeader(String title, String column) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        if (sortColumn == column)
          Icon(
            sortAscending ? Icons.arrow_upward : Icons.arrow_downward,
            size: 16,
          )
        else
          const Icon(Icons.arrow_upward, size: 16, color: Colors.grey),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.table_chart, size: 64, color: Colors.grey[400]),
          const SizedBox(height: 16),
          const Text(
            'No data found',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'Try adjusting your search or filter criteria',
            style: TextStyle(color: Colors.grey[600]),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _clearFilters,
            child: const Text('Clear all filters'),
          ),
        ],
      ),
    );
  }

  Widget _buildPagination() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Showing ${startIndex + 1}-${endIndex} of ${sortedData.length} results',
            style: TextStyle(color: Colors.grey[600]),
          ),
          Row(
            children: [
              IconButton(
                onPressed: currentPage > 1 ? () => setState(() => currentPage--) : null,
                icon: const Icon(Icons.chevron_left),
              ),
              Text('Page $currentPage of $totalPages'),
              IconButton(
                onPressed: currentPage < totalPages ? () => setState(() => currentPage++) : null,
                icon: const Icon(Icons.chevron_right),
              ),
              const SizedBox(width: 16),
              DropdownButton<int>(
                value: itemsPerPage,
                items: [5, 10, 25, 50, 100].map((value) => DropdownMenuItem(
                  value: value,
                  child: Text('$value per page'),
                )).toList(),
                onChanged: (value) => setState(() {
                  itemsPerPage = value!;
                  currentPage = 1;
                }),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _handleSort(String column) {
    setState(() {
      if (sortColumn == column) {
        sortAscending = !sortAscending;
      } else {
        sortColumn = column;
        sortAscending = true;
      }
    });
  }

  void _handleSelectAll(bool? selected) {
    setState(() {
      if (selected == true) {
        selectedRows = pageData.map((row) => row['id'] as String).toSet();
      } else {
        selectedRows.clear();
      }
    });
  }

  void _handleSelectRow(String id) {
    setState(() {
      if (selectedRows.contains(id)) {
        selectedRows.remove(id);
      } else {
        selectedRows.add(id);
      }
    });
  }

  void _handleBulkAction(String action) {
    if (selectedRows.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select items to perform bulk actions')),
      );
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Bulk action: $action on ${selectedRows.length} selected rows')),
    );
  }

  void _handleRowAction(String action, String id) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Row action: $action on row $id')),
    );
  }

  void _exportData(String format) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Exporting data as $format')),
    );
  }

  void _clearFilters() {
    setState(() {
      searchQuery = '';
      departmentFilter = 'All';
      statusFilter = 'All';
      currentPage = 1;
    });
  }

  void _loadData() {
    setState(() {
      isLoading = true;
    });
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        isLoading = false;
      });
    });
  }
}

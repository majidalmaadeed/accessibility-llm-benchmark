import 'package:flutter/material.dart';

class MissingTableHeader extends StatefulWidget {
  const MissingTableHeader({Key? key}) : super(key: key);

  @override
  State<MissingTableHeader> createState() => _MissingTableHeaderState();
}

class _MissingTableHeaderState extends State<MissingTableHeader> {
  String sortBy = 'name';
  bool ascending = true;
  String searchQuery = '';

  final List<Map<String, dynamic>> employees = [
    {
      'id': 1,
      'name': 'John Smith',
      'department': 'Engineering',
      'position': 'Senior Developer',
      'salary': 95000,
      'startDate': '2022-01-15',
      'status': 'Active',
      'email': 'john.smith@company.com',
      'phone': '+1 (555) 123-4567',
    },
    {
      'id': 2,
      'name': 'Sarah Johnson',
      'department': 'Marketing',
      'position': 'Marketing Manager',
      'salary': 78000,
      'startDate': '2021-08-22',
      'status': 'Active',
      'email': 'sarah.johnson@company.com',
      'phone': '+1 (555) 234-5678',
    },
    {
      'id': 3,
      'name': 'Mike Chen',
      'department': 'Sales',
      'position': 'Sales Director',
      'salary': 120000,
      'startDate': '2020-03-10',
      'status': 'Active',
      'email': 'mike.chen@company.com',
      'phone': '+1 (555) 345-6789',
    },
    {
      'id': 4,
      'name': 'Emily Davis',
      'department': 'HR',
      'position': 'HR Specialist',
      'salary': 65000,
      'startDate': '2023-02-01',
      'status': 'Active',
      'email': 'emily.davis@company.com',
      'phone': '+1 (555) 456-7890',
    },
    {
      'id': 5,
      'name': 'David Wilson',
      'department': 'Finance',
      'position': 'Financial Analyst',
      'salary': 72000,
      'startDate': '2022-11-05',
      'status': 'On Leave',
      'email': 'david.wilson@company.com',
      'phone': '+1 (555) 567-8901',
    },
    {
      'id': 6,
      'name': 'Lisa Brown',
      'department': 'Engineering',
      'position': 'Junior Developer',
      'salary': 55000,
      'startDate': '2023-06-12',
      'status': 'Active',
      'email': 'lisa.brown@company.com',
      'phone': '+1 (555) 678-9012',
    },
  ];

  List<Map<String, dynamic>> get filteredEmployees {
    var filtered = employees.where((employee) {
      final query = searchQuery.toLowerCase();
      return employee['name'].toLowerCase().contains(query) ||
             employee['department'].toLowerCase().contains(query) ||
             employee['position'].toLowerCase().contains(query) ||
             employee['email'].toLowerCase().contains(query);
    }).toList();

    filtered.sort((a, b) {
      final aValue = a[sortBy];
      final bValue = b[sortBy];
      
      if (aValue is String && bValue is String) {
        return ascending ? aValue.compareTo(bValue) : bValue.compareTo(aValue);
      } else if (aValue is num && bValue is num) {
        return ascending ? aValue.compareTo(bValue) : bValue.compareTo(aValue);
      }
      return 0;
    });

    return filtered;
  }

  void _sortTable(String column) {
    setState(() {
      if (sortBy == column) {
        ascending = !ascending;
      } else {
        sortBy = column;
        ascending = true;
      }
    });
  }

  String _formatCurrency(int amount) {
    return '\$${amount.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    )}';
  }

  String _formatDate(String dateString) {
    final date = DateTime.parse(dateString);
    return '${date.month}/${date.day}/${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Employee Directory'),
        backgroundColor: Colors.blue[700],
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // Add employee functionality
            },
          ),
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: () {
              // Export functionality
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Search and Filter Bar
          Container(
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
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        searchQuery = value;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 16),
                DropdownButton<String>(
                  value: sortBy,
                  items: const [
                    DropdownMenuItem(value: 'name', child: Text('Name')),
                    DropdownMenuItem(value: 'department', child: Text('Department')),
                    DropdownMenuItem(value: 'position', child: Text('Position')),
                    DropdownMenuItem(value: 'salary', child: Text('Salary')),
                    DropdownMenuItem(value: 'startDate', child: Text('Start Date')),
                    DropdownMenuItem(value: 'status', child: Text('Status')),
                  ],
                  onChanged: (value) {
                    _sortTable(value!);
                  },
                ),
              ],
            ),
          ),
          
          // Data Table
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columnSpacing: 20,
                headingRowColor: MaterialStateProperty.all(Colors.blue[50]),
                columns: [ng DataColumn instead of proper table headers
                  DataColumn(
                    label: const Text('Name'),
                    onSort: (columnIndex, ascending) => _sortTable('name'),
                  ),
                  DataColumn(
                    label: const Text('Department'),
                    onSort: (columnIndex, ascending) => _sortTable('department'),
                  ),
                  DataColumn(
                    label: const Text('Position'),
                    onSort: (columnIndex, ascending) => _sortTable('position'),
                  ),
                  DataColumn(
                    label: const Text('Salary'),
                    onSort: (columnIndex, ascending) => _sortTable('salary'),
                  ),
                  DataColumn(
                    label: const Text('Start Date'),
                    onSort: (columnIndex, ascending) => _sortTable('startDate'),
                  ),
                  DataColumn(
                    label: const Text('Status'),
                    onSort: (columnIndex, ascending) => _sortTable('status'),
                  ),
                  DataColumn(
                    label: const Text('Email'),
                    onSort: (columnIndex, ascending) => _sortTable('email'),
                  ),
                  DataColumn(
                    label: const Text('Phone'),
                    onSort: (columnIndex, ascending) => _sortTable('phone'),
                  ),
                  const DataColumn(
                    label: Text('Actions'),
                  ),
                ],
                rows: filteredEmployees.map((employee) {
                  return DataRow(
                    cells: [
                      DataCell(
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 16,
                              backgroundColor: Colors.blue[100],
                              child: Text(
                                employee['name'].split(' ').map((n) => n[0]).join(''),
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue[700],
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(employee['name']),
                          ],
                        ),
                      ),
                      DataCell(Text(employee['department'])),
                      DataCell(Text(employee['position'])),
                      DataCell(Text(_formatCurrency(employee['salary']))),
                      DataCell(Text(_formatDate(employee['startDate']))),
                      DataCell(
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: employee['status'] == 'Active' 
                                ? Colors.green[100] 
                                : Colors.orange[100],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            employee['status'],
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: employee['status'] == 'Active' 
                                  ? Colors.green[700] 
                                  : Colors.orange[700],
                            ),
                          ),
                        ),
                      ),
                      DataCell(Text(employee['email'])),
                      DataCell(Text(employee['phone'])),
                      DataCell(
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit, size: 16),
                              onPressed: () {
                                // Edit functionality
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, size: 16),
                              onPressed: () {
                                // Delete functionality
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
          
          // Summary Footer
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total Employees: ${filteredEmployees.length}',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      'Sort by: $sortBy',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Icon(
                      ascending ? Icons.arrow_upward : Icons.arrow_downward,
                      size: 16,
                      color: Colors.grey[600],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

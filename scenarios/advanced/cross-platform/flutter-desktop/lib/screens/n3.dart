import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../models/data_item.dart';
import '../widgets/data_table_widget.dart';

class DataTableScreen extends StatefulWidget {
  const DataTableScreen({super.key});

  @override
  State<DataTableScreen> createState() => _DataTableScreenState();
}

class _DataTableScreenState extends State<DataTableScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedCategory = 'All';
  String _selectedStatus = 'All';
  int _minValue = 0;
  int _maxValue = 10000;
  bool _activeOnly = false;
  
  List<DataItem> _dataItems = [];
  List<DataItem> _filteredItems = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    _dataItems = List.generate(50, (index) => DataItem(
      id: index + 1,
      name: 'Item ${index + 1}',
      category: ['Electronics', 'Clothing', 'Books', 'Home', 'Sports'][index % 5],
      status: ['Active', 'Inactive', 'Pending', 'Completed'][index % 4],
      value: 100 + (index * 20),
      date: DateTime.now().subtract(Duration(days: index)).toString().split(' ')[0],
      active: index % 3 == 0 ? 'No' : 'Yes',
    ));
    _applyFilters();
  }

  void _applyFilters() {
    setState(() {
      _filteredItems = _dataItems.where((item) {
        bool matchesSearch = _searchController.text.isEmpty ||
            item.name.toLowerCase().contains(_searchController.text.toLowerCase()) ||
            item.category.toLowerCase().contains(_searchController.text.toLowerCase()) ||
            item.status.toLowerCase().contains(_searchController.text.toLowerCase());
        
        bool matchesCategory = _selectedCategory == 'All' || item.category == _selectedCategory;
        bool matchesStatus = _selectedStatus == 'All' || item.status == _selectedStatus;
        bool matchesValue = item.value >= _minValue && item.value <= _maxValue;
        bool matchesActive = !_activeOnly || item.active == 'Yes';
        
        return matchesSearch && matchesCategory && matchesStatus && matchesValue && matchesActive;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Table Complex'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Search and Filters
          Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 5,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Search and Filters',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        decoration: const InputDecoration(
                          hintText: 'Search all columns...',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.search),
                        ),
                        onChanged: (value) => _applyFilters(),
                      ),
                    ),
                    const SizedBox(width: 10),
                    DropdownButton<String>(
                      value: _selectedCategory,
                      items: ['All', 'Electronics', 'Clothing', 'Books', 'Home', 'Sports']
                          .map((category) => DropdownMenuItem(
                                value: category,
                                child: Text(category),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedCategory = value!;
                        });
                        _applyFilters();
                      },
                    ),
                    const SizedBox(width: 10),
                    DropdownButton<String>(
                      value: _selectedStatus,
                      items: ['All', 'Active', 'Inactive', 'Pending', 'Completed']
                          .map((status) => DropdownMenuItem(
                                value: status,
                                child: Text(status),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedStatus = value!;
                        });
                        _applyFilters();
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: const InputDecoration(
                          labelText: 'Min Value',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          _minValue = int.tryParse(value) ?? 0;
                          _applyFilters();
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        decoration: const InputDecoration(
                          labelText: 'Max Value',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          _maxValue = int.tryParse(value) ?? 10000;
                          _applyFilters();
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    Checkbox(
                      value: _activeOnly,
                      onChanged: (value) {
                        setState(() {
                          _activeOnly = value ?? false;
                        });
                        _applyFilters();
                      },
                    ),
                    const Text('Active Only'),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: _applyFilters,
                      child: const Text('Apply Filters'),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: _resetFilters,
                      child: const Text('Reset'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Table Controls
          Container(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                ElevatedButton(
                  onPressed: _addRow,
                  child: const Text('Add Row'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _removeSelected,
                  child: const Text('Remove Selected'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _clearAll,
                  child: const Text('Clear All'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _exportData,
                  child: const Text('Export'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _importData,
                  child: const Text('Import'),
                ),
                const Spacer(),
                Text(
                  'Rows: ${_filteredItems.length}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          
          // Data Table
          Expanded(
            child: DataTableWidget(
              dataItems: _filteredItems,
              onItemSelected: (item) {
                // Handle item selection
              },
            ),
          ),
        ],
      ),
    );
  }

  void _addRow() {
    setState(() {
      _dataItems.add(DataItem(
        id: _dataItems.length + 1,
        name: 'New Item',
        category: 'Electronics',
        status: 'Active',
        value: 100,
        date: DateTime.now().toString().split(' ')[0],
        active: 'Yes',
      ));
    });
    _applyFilters();
  }

  void _removeSelected() {
    // Remove selected items logic would be implemented here
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Remove selected items')),
    );
  }

  void _clearAll() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear All'),
        content: const Text('Are you sure you want to clear all data?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _dataItems.clear();
                _filteredItems.clear();
              });
              Navigator.pop(context);
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }

  void _exportData() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Exporting data...')),
    );
  }

  void _importData() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Importing data...')),
    );
  }

  void _resetFilters() {
    setState(() {
      _searchController.clear();
      _selectedCategory = 'All';
      _selectedStatus = 'All';
      _minValue = 0;
      _maxValue = 10000;
      _activeOnly = false;
    });
    _applyFilters();
  }
}

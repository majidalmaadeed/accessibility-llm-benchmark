import 'package:flutter/material.dart';

class SearchInterfaceScreen extends StatefulWidget {
  const SearchInterfaceScreen({super.key});

  @override
  State<SearchInterfaceScreen> createState() => _SearchInterfaceScreenState();
}

class _SearchInterfaceScreenState extends State<SearchInterfaceScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedCategory = 'All';
  String _selectedType = 'All';
  final List<SearchResult> _searchResults = [
    SearchResult(title: 'Result 1', category: 'Documents'),
    SearchResult(title: 'Result 2', category: 'Images'),
    SearchResult(title: 'Result 3', category: 'Videos'),
    SearchResult(title: 'Result 4', category: 'Audio'),
    SearchResult(title: 'Result 5', category: 'Documents'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Complex Search Interface'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Search Bar
          Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                TextField(
                  controller: _searchController,
                  decoration: const InputDecoration(
                    hintText: 'Search for anything...',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.search),
                  ),
                  onChanged: (value) => _performSearch(),
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: _selectedCategory,
                        decoration: const InputDecoration(
                          labelText: 'Category',
                          border: OutlineInputBorder(),
                        ),
                        items: ['All', 'Documents', 'Images', 'Videos', 'Audio']
                            .map((category) => DropdownMenuItem(
                                  value: category,
                                  child: Text(category),
                                ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedCategory = value!;
                          });
                          _performSearch();
                        },
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: _selectedType,
                        decoration: const InputDecoration(
                          labelText: 'Type',
                          border: OutlineInputBorder(),
                        ),
                        items: ['All', 'Recent', 'Popular', 'Featured']
                            .map((type) => DropdownMenuItem(
                                  value: type,
                                  child: Text(type),
                                ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedType = value!;
                          });
                          _performSearch();
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Search Results
          Expanded(
            child: ListView.builder(
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                final result = _searchResults[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: ListTile(
                    leading: const Icon(Icons.search),
                    title: Text(result.title),
                    subtitle: Text(result.category),
                    trailing: IconButton(
                      onPressed: () => _viewResult(result),
                      icon: const Icon(Icons.visibility),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _performSearch() {
    // Search logic would be implemented here
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Searching...')),
    );
  }

  void _viewResult(SearchResult result) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Viewing ${result.title}')),
    );
  }
}

class SearchResult {
  final String title;
  final String category;

  SearchResult({
    required this.title,
    required this.category,
  });
}

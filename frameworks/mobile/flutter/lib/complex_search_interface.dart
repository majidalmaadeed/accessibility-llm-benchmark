import 'package:flutter/material.dart';

class ComplexSearchInterface extends StatefulWidget {
  const ComplexSearchInterface({Key? key}) : super(key: key);

  @override
  State<ComplexSearchInterface> createState() => _ComplexSearchInterfaceState();
}

class _ComplexSearchInterfaceState extends State<ComplexSearchInterface> {
  String searchQuery = '';
  List<Map<String, dynamic>> searchResults = [];
  bool isLoading = false;
  Set<String> selectedFilters = {};
  String sortOption = 'relevance';
  int currentPage = 1;
  int totalPages = 1;
  bool showFilters = false;
  List<String> searchHistory = [];
  bool showHistory = false;
  Map<String, dynamic>? selectedResult;
  String viewMode = 'list'; // list, grid, compact
  String selectedCategory = 'All';
  RangeValues priceRange = const RangeValues(0, 1000);
  DateTimeRange? dateRange;
  bool showAdvancedFilters = false;

  final List<String> categories = [
    'All', 'Documents', 'Images', 'Videos', 'Audio', 'Web Pages',
    'News', 'Products', 'People', 'Locations'
  ];

  final List<Map<String, dynamic>> sortOptions = [
    {'value': 'relevance', 'label': 'Relevance'},
    {'value': 'date', 'label': 'Date'},
    {'value': 'name', 'label': 'Name'},
    {'value': 'size', 'label': 'Size'},
    {'value': 'type', 'label': 'Type'},
    {'value': 'rating', 'label': 'Rating'},
  ];

  final List<Map<String, dynamic>> viewModes = [
    {'value': 'list', 'label': 'List', 'icon': Icons.list},
    {'value': 'grid', 'label': 'Grid', 'icon': Icons.grid_view},
    {'value': 'compact', 'label': 'Compact', 'icon': Icons.view_list},
  ];

  final List<Map<String, dynamic>> filters = [
    {'id': 'recent', 'name': 'Recent', 'type': 'date'},
    {'id': 'large', 'name': 'Large Files', 'type': 'size'},
    {'id': 'images', 'name': 'Images Only', 'type': 'type'},
    {'id': 'videos', 'name': 'Videos Only', 'type': 'type'},
    {'id': 'documents', 'name': 'Documents Only', 'type': 'type'},
    {'id': 'free', 'name': 'Free', 'type': 'price'},
    {'id': 'premium', 'name': 'Premium', 'type': 'price'},
  ];

  final List<Map<String, dynamic>> sampleResults = [
    {
      'id': '1',
      'title': 'React Native Development Guide',
      'description': 'Comprehensive guide to building mobile apps with React Native',
      'type': 'document',
      'category': 'Documents',
      'size': '2.5 MB',
      'date': '2024-01-15',
      'rating': 4.8,
      'price': 0,
      'image': '📄',
      'url': 'https://example.com/react-native-guide',
    },
    {
      'id': '2',
      'title': 'Mobile UI Design Patterns',
      'description': 'Best practices for mobile user interface design',
      'type': 'image',
      'category': 'Images',
      'size': '1.2 MB',
      'date': '2024-01-14',
      'rating': 4.6,
      'price': 29.99,
      'image': '🖼️',
      'url': 'https://example.com/ui-patterns',
    },
    {
      'id': '3',
      'title': 'JavaScript Tutorial Series',
      'description': 'Complete JavaScript tutorial for beginners',
      'type': 'video',
      'category': 'Videos',
      'size': '150 MB',
      'date': '2024-01-13',
      'rating': 4.9,
      'price': 49.99,
      'image': '🎥',
      'url': 'https://example.com/js-tutorial',
    },
    {
      'id': '4',
      'title': 'Web Development News',
      'description': 'Latest news and updates in web development',
      'type': 'news',
      'category': 'News',
      'size': '500 KB',
      'date': '2024-01-12',
      'rating': 4.3,
      'price': 0,
      'image': '📰',
      'url': 'https://example.com/web-news',
    },
    {
      'id': '5',
      'title': 'E-commerce Product Catalog',
      'description': 'Complete product catalog for online store',
      'type': 'product',
      'category': 'Products',
      'size': '5.8 MB',
      'date': '2024-01-11',
      'rating': 4.5,
      'price': 99.99,
      'image': '🛍️',
      'url': 'https://example.com/product-catalog',
    },
  ];

  @override
  void initState() {
    super.initState();
    if (searchQuery.isNotEmpty) {
      performSearch();
    }
  }

  void performSearch() async {
    setState(() {
      isLoading = true;
    });

    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));

    List<Map<String, dynamic>> filteredResults = List.from(sampleResults);

    // Apply search query filter
    if (searchQuery.trim().isNotEmpty) {
      filteredResults = filteredResults.where((result) =>
          result['title'].toLowerCase().contains(searchQuery.toLowerCase()) ||
          result['description'].toLowerCase().contains(searchQuery.toLowerCase())
      ).toList();
    }

    // Apply category filter
    if (selectedCategory != 'All') {
      filteredResults = filteredResults.where((result) =>
          result['category'] == selectedCategory
      ).toList();
    }

    // Apply price range filter
    filteredResults = filteredResults.where((result) {
      final price = result['price'] as double;
      return price >= priceRange.start && price <= priceRange.end;
    }).toList();

    // Apply selected filters
    for (String filterId in selectedFilters) {
      final filter = filters.firstWhere((f) => f['id'] == filterId);
      switch (filter['type']) {
        case 'type':
          filteredResults = filteredResults.where((result) =>
              result['type'] == filterId.substring(0, filterId.length - 1)
          ).toList();
          break;
        case 'price':
          if (filterId == 'free') {
            filteredResults = filteredResults.where((result) => result['price'] == 0).toList();
          } else if (filterId == 'premium') {
            filteredResults = filteredResults.where((result) => result['price'] > 0).toList();
          }
          break;
        case 'size':
          if (filterId == 'large') {
            filteredResults = filteredResults.where((result) {
              final sizeStr = result['size'] as String;
              final size = double.tryParse(sizeStr.replaceAll(' MB', '')) ?? 0;
              return size > 1;
            }).toList();
          }
          break;
        case 'date':
          if (filterId == 'recent') {
            final recentDate = DateTime.now().subtract(const Duration(days: 7));
            filteredResults = filteredResults.where((result) {
              final resultDate = DateTime.parse(result['date']);
              return resultDate.isAfter(recentDate);
            }).toList();
          }
          break;
      }
    }

    // Apply sorting
    filteredResults.sort((a, b) {
      switch (sortOption) {
        case 'date':
          return DateTime.parse(b['date']).compareTo(DateTime.parse(a['date']));
        case 'name':
          return a['title'].compareTo(b['title']);
        case 'size':
          final aSize = double.tryParse(a['size'].toString().replaceAll(' MB', '')) ?? 0;
          final bSize = double.tryParse(b['size'].toString().replaceAll(' MB', '')) ?? 0;
          return bSize.compareTo(aSize);
        case 'type':
          return a['type'].compareTo(b['type']);
        case 'rating':
          return b['rating'].compareTo(a['rating']);
        default:
          return 0; // relevance - keep original order
      }
    });

    setState(() {
      searchResults = filteredResults;
      totalPages = (filteredResults.length / 10).ceil();
      currentPage = 1;
      isLoading = false;
    });
  }

  void handleSearch() {
    if (searchQuery.trim().isNotEmpty) {
      // Add to search history
      if (!searchHistory.contains(searchQuery)) {
        setState(() {
          searchHistory.insert(0, searchQuery);
          if (searchHistory.length > 10) {
            searchHistory = searchHistory.take(10).toList();
          }
        });
      }
      performSearch();
    }
  }

  void handleFilterToggle(String filterId) {
    setState(() {
      if (selectedFilters.contains(filterId)) {
        selectedFilters.remove(filterId);
      } else {
        selectedFilters.add(filterId);
      }
    });
  }

  void clearFilters() {
    setState(() {
      selectedFilters.clear();
      selectedCategory = 'All';
      priceRange = const RangeValues(0, 1000);
      dateRange = null;
    });
  }

  void handleResultPress(Map<String, dynamic> result) {
    setState(() {
      selectedResult = result;
    });
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(result['title']),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(result['description']),
            const SizedBox(height: 8),
            Text('Type: ${result['type']}'),
            Text('Size: ${result['size']}'),
            Text('Date: ${result['date']}'),
            Text('Rating: ${result['rating']}/5'),
            Text('Price: \$${result['price']}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // Handle open action
            },
            child: const Text('Open'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Search'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: Column(
        children: [
          _buildSearchBar(),
          _buildFilters(),
          _buildSortAndView(),
          Expanded(
            child: _buildResults(),
          ),
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
                hintText: 'Search for anything...',
                prefixIcon: Icon(Icons.search),
                suffixIcon: Icon(Icons.clear),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => setState(() => searchQuery = value),
              onSubmitted: (_) => handleSearch(),
            ),
          ),
          const SizedBox(width: 12),
          ElevatedButton(
            onPressed: handleSearch,
            child: const Text('Search'),
          ),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      color: Colors.white,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: FilterChip(
                label: const Text('Filters'),
                selected: showFilters,
                onSelected: (selected) => setState(() => showFilters = selected),
                avatar: const Icon(Icons.filter_list, size: 16),
                selectedColor: Colors.blue[100],
                checkmarkColor: Colors.blue,
              ),
            ),
            ...filters.map((filter) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: FilterChip(
                label: Text(filter['name']),
                selected: selectedFilters.contains(filter['id']),
                onSelected: (selected) => handleFilterToggle(filter['id']),
                selectedColor: Colors.blue[100],
                checkmarkColor: Colors.blue,
              ),
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildSortAndView() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                const Text('Sort by: '),
                DropdownButton<String>(
                  value: sortOption,
                  onChanged: (value) => setState(() => sortOption = value!),
                  items: sortOptions.map((option) => DropdownMenuItem(
                    value: option['value'],
                    child: Text(option['label']),
                  )).toList(),
                ),
              ],
            ),
          ),
          Row(
            children: viewModes.map((mode) => IconButton(
              icon: Icon(
                mode['icon'],
                color: viewMode == mode['value'] ? Colors.blue : Colors.grey,
              ),
              onPressed: () => setState(() => viewMode = mode['value']),
            )).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildResults() {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (searchResults.isEmpty && searchQuery.trim().isNotEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search, size: 64, color: Colors.grey[400]),
            const SizedBox(height: 16),
            const Text(
              'No results found',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Try adjusting your search terms or filters',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: clearFilters,
              child: const Text('Clear all filters'),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: searchResults.length,
      itemBuilder: (context, index) => _buildResultItem(searchResults[index]),
    );
  }

  Widget _buildResultItem(Map<String, dynamic> item) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.grey[200],
          child: Text(
            item['image'],
            style: const TextStyle(fontSize: 24),
          ),
        ),
        title: Text(
          item['title'],
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(item['description']),
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(Icons.folder, size: 12, color: Colors.grey[600]),
                const SizedBox(width: 4),
                Text(item['category'], style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                const SizedBox(width: 16),
                Icon(Icons.access_time, size: 12, color: Colors.grey[600]),
                const SizedBox(width: 4),
                Text(item['date'], style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                const SizedBox(width: 16),
                Icon(Icons.star, size: 12, color: Colors.amber),
                const SizedBox(width: 4),
                Text(item['rating'].toString(), style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                const SizedBox(width: 16),
                Icon(Icons.description, size: 12, color: Colors.grey[600]),
                const SizedBox(width: 4),
                Text(item['size'], style: TextStyle(color: Colors.grey[600], fontSize: 12)),
              ],
            ),
            if (item['price'] > 0) ...[
              const SizedBox(height: 4),
              Text(
                '\$${item['price']}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ],
          ],
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => handleResultPress(item),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Search'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: Column(
        children: [
          _buildSearchBar(),
          _buildFilters(),
          _buildSortAndView(),
          Expanded(
            child: _buildResults(),
          ),
        ],
      ),
      bottomSheet: showFilters ? _buildAdvancedFilters() : null,
    );
  }

  Widget _buildAdvancedFilters() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey, width: 0.5)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Filters',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    TextButton(
                      onPressed: clearFilters,
                      child: const Text('Clear All'),
                    ),
                    IconButton(
                      onPressed: () => setState(() => showFilters = false),
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildFilterSection('Category', _buildCategoryFilters()),
                  const SizedBox(height: 24),
                  _buildFilterSection('Price Range', _buildPriceRangeFilter()),
                  const SizedBox(height: 24),
                  _buildFilterSection('Date Range', _buildDateRangeFilter()),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: Colors.grey, width: 0.5)),
            ),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  setState(() => showFilters = false);
                  performSearch();
                },
                child: const Text('Apply Filters'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterSection(String title, Widget content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        content,
      ],
    );
  }

  Widget _buildCategoryFilters() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: categories.map((category) => FilterChip(
        label: Text(category),
        selected: selectedCategory == category,
        onSelected: (selected) => setState(() => selectedCategory = category),
        selectedColor: Colors.blue[100],
        checkmarkColor: Colors.blue,
      )).toList(),
    );
  }

  Widget _buildPriceRangeFilter() {
    return Column(
      children: [
        RangeSlider(
          values: priceRange,
          min: 0,
          max: 1000,
          divisions: 20,
          labels: RangeLabels(
            '\$${priceRange.start.round()}',
            '\$${priceRange.end.round()}',
          ),
          onChanged: (values) => setState(() => priceRange = values),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('\$${priceRange.start.round()}'),
            Text('\$${priceRange.end.round()}'),
          ],
        ),
      ],
    );
  }

  Widget _buildDateRangeFilter() {
    return Column(
      children: [
        ListTile(
          title: const Text('Start Date'),
          subtitle: Text(dateRange?.start.toString().split(' ')[0] ?? 'Select start date'),
          trailing: const Icon(Icons.calendar_today),
          onTap: () async {
            final date = await showDatePicker(
              context: context,
              initialDate: dateRange?.start ?? DateTime.now(),
              firstDate: DateTime(2020),
              lastDate: DateTime.now(),
            );
            if (date != null) {
              setState(() {
                dateRange = DateTimeRange(
                  start: date,
                  end: dateRange?.end ?? date.add(const Duration(days: 1)),
                );
              });
            }
          },
        ),
        ListTile(
          title: const Text('End Date'),
          subtitle: Text(dateRange?.end.toString().split(' ')[0] ?? 'Select end date'),
          trailing: const Icon(Icons.calendar_today),
          onTap: () async {
            final date = await showDatePicker(
              context: context,
              initialDate: dateRange?.end ?? DateTime.now(),
              firstDate: dateRange?.start ?? DateTime(2020),
              lastDate: DateTime.now(),
            );
            if (date != null) {
              setState(() {
                dateRange = DateTimeRange(
                  start: dateRange?.start ?? date.subtract(const Duration(days: 1)),
                  end: date,
                );
              });
            }
          },
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

class SearchWithSilentUpdates extends StatefulWidget {
  const SearchWithSilentUpdates({Key? key}) : super(key: key);

  @override
  State<SearchWithSilentUpdates> createState() => _SearchWithSilentUpdatesState();
}

class _SearchWithSilentUpdatesState extends State<SearchWithSilentUpdates> {
  final TextEditingController _searchController = TextEditingController();
  List<SearchResult> _suggestions = [];
  List<SearchResult> _results = [];
  bool _isLoading = false;
  bool _showSuggestions = false;
  int _activeSuggestionIndex = -1;

  final List<SearchResult> _mockData = [
    SearchResult(id: 1, title: 'React Development Guide', category: 'Books', author: 'John Doe'),
    SearchResult(id: 2, title: 'Vue.js Tutorial', category: 'Books', author: 'Jane Smith'),
    SearchResult(id: 3, title: 'Angular Framework', category: 'Books', author: 'Bob Johnson'),
    SearchResult(id: 4, title: 'JavaScript Fundamentals', category: 'Books', author: 'Alice Brown'),
    SearchResult(id: 5, title: 'React Components', category: 'Tutorials', author: 'Charlie Wilson'),
    SearchResult(id: 6, title: 'Vue Components', category: 'Tutorials', author: 'Diana Lee'),
    SearchResult(id: 7, title: 'Angular Services', category: 'Tutorials', author: 'Eve Davis'),
    SearchResult(id: 8, title: 'JavaScript ES6', category: 'Tutorials', author: 'Frank Miller'),
  ];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_handleInput);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _handleInput() {
    final query = _searchController.text;
    if (query.length > 1) {
      final filtered = _mockData.where((item) =>
          item.title.toLowerCase().contains(query.toLowerCase()) ||
          item.category.toLowerCase().contains(query.toLowerCase()) ||
          item.author.toLowerCase().contains(query.toLowerCase())).toList();
      
      setState(() {
        _suggestions = filtered.take(5).toList();
        _showSuggestions = true;
        _activeSuggestionIndex = -1;
      });
    } else {
      setState(() {
        _suggestions = [];
        _showSuggestions = false;
        _activeSuggestionIndex = -1;
      });
    }
  }

  void _handleSearch() async {
    setState(() {
      _isLoading = true;
    });

    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));
    
    final query = _searchController.text;
    final filtered = _mockData.where((item) =>
        item.title.toLowerCase().contains(query.toLowerCase()) ||
        item.category.toLowerCase().contains(query.toLowerCase()) ||
        item.author.toLowerCase().contains(query.toLowerCase())).toList();
    
    setState(() {
      _results = filtered;
      _isLoading = false;
      _showSuggestions = false;
      _activeSuggestionIndex = -1;
    });
    
    // MISSING: Screen reader announcement of results
    // Should announce "Found X results" or "No results found"
  }

  void _handleSuggestionClick(SearchResult suggestion) {
    _searchController.text = suggestion.title;
    setState(() {
      _showSuggestions = false;
      _activeSuggestionIndex = -1;
    });
    _handleSearch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Main Content Card
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Search Interface',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF333333),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Violation: Search input + suggestions dropdown + results area without announcements.',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: const Color(0xFF666666),
                      ),
                    ),
                    const SizedBox(height: 30),
                    
                    // Search Input Section
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Search for content:',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF333333),
                          ),
                        ),
                        const SizedBox(height: 8),
                        
                        Stack(
                          children: [
                            TextField(
                              controller: _searchController,
                              decoration: const InputDecoration(
                                hintText: 'Type to search...',
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.search),
                              ),
                              onSubmitted: (_) => _handleSearch(),
                              textInputAction: TextInputAction.search,
                            ),
                            
                            // Suggestions Dropdown - MISSING ARIA ATTRIBUTES
                            if (_showSuggestions && _suggestions.isNotEmpty)
                              Positioned(
                                top: 60,
                                left: 0,
                                right: 0,
                                child: Card(
                                  elevation: 8,
                                  child: Column(
                                    children: _suggestions.asMap().entries.map((entry) {
                                      final index = entry.key;
                                      final suggestion = entry.value;
                                      return InkWell(
                                        onTap: () => _handleSuggestionClick(suggestion),
                                        child: Container(
                                          width: double.infinity,
                                          padding: const EdgeInsets.all(12),
                                          decoration: BoxDecoration(
                                            color: index == _activeSuggestionIndex 
                                                ? const Color(0xFFF8F9FA) 
                                                : Colors.transparent,
                                          ),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                suggestion.title,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0xFF333333),
                                                ),
                                              ),
                                              Text(
                                                '${suggestion.category} • ${suggestion.author}',
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                  color: Color(0xFF666666),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                          ],
                        ),
                        
                        const SizedBox(height: 20),
                        
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _isLoading || _searchController.text.trim().isEmpty 
                                ? null 
                                : _handleSearch,
                            child: _isLoading
                                ? const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                        ),
                                      ),
                                      SizedBox(width: 8),
                                      Text('Searching...'),
                                    ],
                                  )
                                : const Text('Search'),
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 30),
                    
                    // Results Section - MISSING LIVE REGION
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Search Results',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF333333),
                          ),
                        ),
                        const SizedBox(height: 16),
                        
                        if (_isLoading)
                          const Center(
                            child: Column(
                              children: [
                                CircularProgressIndicator(),
                                SizedBox(height: 16),
                                Text(
                                  'Searching...',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Color(0xFF666666),
                                  ),
                                ),
                              ],
                            ),
                          )
                        else if (_results.isNotEmpty)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Found ${_results.length} result${_results.length == 1 ? '' : 's'}',
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF666666),
                                ),
                              ),
                              const SizedBox(height: 16),
                              SizedBox(
                                height: 300,
                                child: ListView.builder(
                                  itemCount: _results.length,
                                  itemBuilder: (context, index) {
                                    final result = _results[index];
                                    return Card(
                                      margin: const EdgeInsets.only(bottom: 12),
                                      child: Padding(
                                        padding: const EdgeInsets.all(16),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              result.title,
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                                color: Color(0xFF333333),
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            Text(
                                              'Category: ${result.category}',
                                              style: const TextStyle(
                                                fontSize: 12,
                                                color: Color(0xFF666666),
                                              ),
                                            ),
                                            Text(
                                              'Author: ${result.author}',
                                              style: const TextStyle(
                                                fontSize: 12,
                                                color: Color(0xFF666666),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          )
                        else if (_searchController.text.isNotEmpty)
                          const Center(
                            child: Text(
                              'No results found',
                              style: TextStyle(
                                fontSize: 16,
                                color: Color(0xFF666666),
                              ),
                            ),
                          )
                        else
                          const Center(
                            child: Text(
                              'Enter a search term to find content',
                              style: TextStyle(
                                fontSize: 16,
                                color: Color(0xFF666666),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Accessibility Information Card
            Card(
              color: const Color(0xFFE9ECEF),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Accessibility Issues:',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF333333),
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('• Missing live region: No announcements when search results change'),
                        Text('• Incomplete ARIA attributes: Suggestions lack proper aria-activedescendant'),
                        Text('• No keyboard navigation: Arrow keys don\'t navigate through suggestions'),
                        Text('• Missing announcements: Screen readers don\'t announce result count changes'),
                        Text('• No loading state announcement: Loading state not announced to screen readers'),
                        Text('• Missing suggestion selection: No aria-selected state management'),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'How to Fix:',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF333333),
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('• Add aria-live="polite" region for result announcements'),
                        Text('• Implement aria-activedescendant for suggestion navigation'),
                        Text('• Add arrow key navigation (Up/Down) through suggestions'),
                        Text('• Announce result count changes ("Found X results")'),
                        Text('• Add loading state announcements'),
                        Text('• Implement proper aria-selected state management'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchResult {
  final int id;
  final String title;
  final String category;
  final String author;

  SearchResult({
    required this.id,
    required this.title,
    required this.category,
    required this.author,
  });
}
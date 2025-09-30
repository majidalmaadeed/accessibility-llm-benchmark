import 'package:flutter/material.dart';

class GenericLinkText extends StatefulWidget {
  const GenericLinkText({Key? key}) : super(key: key);

  @override
  State<GenericLinkText> createState() => _GenericLinkTextState();
}

class _GenericLinkTextState extends State<GenericLinkText> {
  int selectedCategory = 0;
  final List<String> categories = ['All', 'Technology', 'Design', 'Business', 'Science'];

  final List<Map<String, dynamic>> articles = [
    {
      'id': 1,
      'title': 'Understanding Flutter Performance Optimization',
      'excerpt': 'Learn how to optimize your Flutter applications for better performance and user experience.',
      'category': 'Technology',
      'readTime': '5 min read',
      'author': 'John Smith',
      'date': '2024-01-15',
      'image': 'https://via.placeholder.com/300x200',
      'url': 'https://example.com/flutter-performance',
    },
    {
      'id': 2,
      'title': 'Mobile UI/UX Design Best Practices',
      'excerpt': 'Essential design principles for creating intuitive and accessible mobile interfaces.',
      'category': 'Design',
      'readTime': '7 min read',
      'author': 'Sarah Johnson',
      'date': '2024-01-12',
      'image': 'https://via.placeholder.com/300x200',
      'url': 'https://example.com/mobile-ui-design',
    },
    {
      'id': 3,
      'title': 'Cross-Platform Development Strategies',
      'excerpt': 'Compare different approaches to building apps that work across multiple platforms.',
      'category': 'Technology',
      'readTime': '10 min read',
      'author': 'Mike Chen',
      'date': '2024-01-10',
      'image': 'https://via.placeholder.com/300x200',
      'url': 'https://example.com/cross-platform-strategies',
    },
    {
      'id': 4,
      'title': 'State Management in Modern React',
      'excerpt': 'Explore different state management solutions for complex React applications.',
      'category': 'Technology',
      'readTime': '8 min read',
      'author': 'Emily Davis',
      'date': '2024-01-08',
      'image': 'https://via.placeholder.com/300x200',
      'url': 'https://example.com/react-state-management',
    },
    {
      'id': 5,
      'title': 'Building Scalable React Native Applications',
      'excerpt': 'Discover the key principles and patterns for creating maintainable and scalable React Native applications.',
      'category': 'Technology',
      'readTime': '12 min read',
      'author': 'Alex Thompson',
      'date': '2024-01-20',
      'image': 'https://via.placeholder.com/300x200',
      'url': 'https://example.com/scalable-react-native',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Tech Blog'),
        backgroundColor: Colors.blue[700],
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Featured Article
          _buildFeaturedArticle(),
          
          // Category Filter
          Container(
            height: 50,
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final isSelected = selectedCategory == index;
                return Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: FilterChip(
                    label: Text(categories[index]),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        selectedCategory = index;
                      });
                    },
                    backgroundColor: Colors.white,
                    selectedColor: Colors.blue[100],
                    checkmarkColor: Colors.blue[700],
                  ),
                );
              },
            ),
          ),
          
          // Articles List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: articles.length,
              itemBuilder: (context, index) {
                return _buildArticleCard(articles[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturedArticle() {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Featured Image
          Container(
            width: double.infinity,
            height: 200,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              image: DecorationImage(
                image: NetworkImage('https://via.placeholder.com/400x200'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          
          // Featured Content
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.blue[100],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    'Featured',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ),
                
                const SizedBox(height: 12),
                
                const Text(
                  'Building Scalable React Native Applications',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                
                const SizedBox(height: 8),
                
                const Text(
                  'Discover the key principles and patterns for creating maintainable and scalable React Native applications that can grow with your business needs.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                    height: 1.5,
                  ),
                ),
                
                const SizedBox(height: 16),
                
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 16,
                      backgroundColor: Colors.blue,
                      child: Text(
                        'AT',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'Alex Thompson',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      'January 20, 2024',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      '12 min read',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 20),
                
                // GENERIC LINK TEXT - "Read more" without context
                GestureDetector(
                  onTap: () {
                    // Navigate to full article
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.blue[700],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      'Read more', // GENERIC LINK TEXT - No context about destination
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildArticleCard(Map<String, dynamic> article) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Article Image
          Container(
            width: 120,
            height: 100,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
              image: DecorationImage(
                image: NetworkImage('https://via.placeholder.com/120x100'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          
          // Article Content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Category and Read Time
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.blue[100],
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          article['category'],
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[700],
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        article['readTime'],
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 8),
                  
                  // Article Title
                  Text(
                    article['title'],
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  
                  const SizedBox(height: 4),
                  
                  // Article Excerpt
                  Text(
                    article['excerpt'],
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                      height: 1.4,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  
                  const SizedBox(height: 8),
                  
                  // Author and Date
                  Row(
                    children: [
                      Text(
                        'By ${article['author']}',
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '•',
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        article['date'],
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 12),
                  
                  // Action Buttons
                  Row(
                    children: [
                      // GENERIC LINK TEXT - "Read more" without context
                      GestureDetector(
                        onTap: () {
                          // Navigate to full article
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.blue[700],
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Text(
                            'Read more', // GENERIC LINK TEXT - No context about destination
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      
                      const SizedBox(width: 8),
                      
                      // Share Button
                      GestureDetector(
                        onTap: () {
                          // Share functionality
                        },
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Icon(
                            Icons.share,
                            size: 16,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

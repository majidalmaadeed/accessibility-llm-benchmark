import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News Website',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: NewsPage(),
    );
  }
}

class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text('Daily News'),
        backgroundColor: Colors.blue[700],
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Breaking News Banner
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.red[600]!, Colors.red[800]!],
                ),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.red.withOpacity(0.3),
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.warning,
                    color: Colors.white,
                    size: 28,
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'BREAKING NEWS',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Major breakthrough in renewable energy technology announced today',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.9),
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: 30),
            
            // Main Article
            Container(
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 5,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Revolutionary Solar Panel Technology Promises 50% Efficiency Increase',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                  SizedBox(height: 16),
                  
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 16,
                        backgroundColor: Colors.blue[700],
                        child: Text(
                          'J',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'John Smith',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[800],
                            ),
                          ),
                          Text(
                            'Technology Reporter • 2 hours ago',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  
                  SizedBox(height: 20),
                  
                  Container(
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.image,
                        size: 50,
                        color: Colors.grey[400],
                      ),
                    ),
                  ),
                  
                  SizedBox(height: 20),
                  
                  Text(
                    'Scientists at the National Renewable Energy Laboratory have announced a groundbreaking development in solar panel technology that could revolutionize the clean energy industry.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[700],
                      height: 1.6,
                    ),
                  ),
                  
                  SizedBox(height: 16),
                  
                  Text(
                    'The new photovoltaic cells utilize advanced perovskite materials combined with traditional silicon, achieving an unprecedented efficiency rate of 45.2% under standard testing conditions. This represents a significant improvement over current commercial panels, which typically achieve 20-22% efficiency.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[700],
                      height: 1.6,
                    ),
                  ),
                  
                  SizedBox(height: 16),
                  
                  Text(
                    'Dr. Sarah Chen, lead researcher on the project, explained that the breakthrough came from optimizing the light absorption properties of the hybrid material. "We\'ve been able to capture a much broader spectrum of sunlight while minimizing energy loss through heat generation," she said.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[700],
                      height: 1.6,
                    ),
                  ),
                  
                  SizedBox(height: 20),
                  
                  // GENERIC LINK TEXT - "Read more" link without context about destination
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Read more',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.blue[700],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: 30),
            
            // Related Articles
            Text(
              'Related Articles',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
            SizedBox(height: 20),
            
            _buildArticleCard(
              'Wind Energy Reaches New Milestone in Europe',
              'European countries have collectively generated 50% of their electricity from wind power for the first time in history.',
              '2 hours ago',
              'Energy',
            ),
            
            _buildArticleCard(
              'Electric Vehicle Sales Surge 40% This Quarter',
              'Global electric vehicle sales continue to grow rapidly as more consumers embrace sustainable transportation.',
              '4 hours ago',
              'Transportation',
            ),
            
            _buildArticleCard(
              'New Battery Technology Extends Range by 300%',
              'Researchers develop lithium-sulfur batteries that could make electric vehicles more practical for long-distance travel.',
              '6 hours ago',
              'Technology',
            ),
            
            SizedBox(height: 30),
            
            // Category Links
            Container(
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 5,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Browse by Category',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                  SizedBox(height: 20),
                  
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      _buildCategoryChip('Technology', Colors.blue),
                      _buildCategoryChip('Science', Colors.green),
                      _buildCategoryChip('Environment', Colors.teal),
                      _buildCategoryChip('Health', Colors.red),
                      _buildCategoryChip('Business', Colors.orange),
                      _buildCategoryChip('Politics', Colors.purple),
                      _buildCategoryChip('Sports', Colors.indigo),
                      _buildCategoryChip('Entertainment', Colors.pink),
                    ],
                  ),
                ],
              ),
            ),
            
            SizedBox(height: 30),
            
            // Newsletter Signup
            Container(
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.blue[600]!, Colors.blue[800]!],
                ),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.3),
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.email,
                    color: Colors.white,
                    size: 40,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Stay Updated',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Get the latest news delivered to your inbox',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Enter your email address',
                            hintStyle: TextStyle(color: Colors.grey[400]),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 12),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.blue[700],
                          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text('Subscribe'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            SizedBox(height: 30),
            
            // Footer Links
            Container(
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'News',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 12),
                            // GENERIC LINK TEXT - "Read more" link without context about destination
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                'Read more',
                                style: TextStyle(color: Colors.grey[300]),
                              ),
                            ),
                            // GENERIC LINK TEXT - "Read more" link without context about destination
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                'Read more',
                                style: TextStyle(color: Colors.grey[300]),
                              ),
                            ),
                            // GENERIC LINK TEXT - "Read more" link without context about destination
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                'Read more',
                                style: TextStyle(color: Colors.grey[300]),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Categories',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 12),
                            // GENERIC LINK TEXT - "Read more" link without context about destination
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                'Read more',
                                style: TextStyle(color: Colors.grey[300]),
                              ),
                            ),
                            // GENERIC LINK TEXT - "Read more" link without context about destination
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                'Read more',
                                style: TextStyle(color: Colors.grey[300]),
                              ),
                            ),
                            // GENERIC LINK TEXT - "Read more" link without context about destination
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                'Read more',
                                style: TextStyle(color: Colors.grey[300]),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'About',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 12),
                            // GENERIC LINK TEXT - "Read more" link without context about destination
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                'Read more',
                                style: TextStyle(color: Colors.grey[300]),
                              ),
                            ),
                            // GENERIC LINK TEXT - "Read more" link without context about destination
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                'Read more',
                                style: TextStyle(color: Colors.grey[300]),
                              ),
                            ),
                            // GENERIC LINK TEXT - "Read more" link without context about destination
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                'Read more',
                                style: TextStyle(color: Colors.grey[300]),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildArticleCard(String title, String summary, String time, String category) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.blue[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  category,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[700],
                  ),
                ),
              ),
              Spacer(),
              Text(
                time,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
          
          SizedBox(height: 12),
          
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
          
          SizedBox(height: 8),
          
          Text(
            summary,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
              height: 1.4,
            ),
          ),
          
          SizedBox(height: 12),
          
          // GENERIC LINK TEXT - "Read more" link without context about destination
          TextButton(
            onPressed: () {},
            child: Text(
              'Read more',
              style: TextStyle(
                fontSize: 14,
                color: Colors.blue[700],
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildCategoryChip(String category, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.3), width: 1),
      ),
      child: Text(
        category,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
    );
  }
}


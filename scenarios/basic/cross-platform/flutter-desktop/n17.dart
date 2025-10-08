import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Social Media App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SocialMediaFeedPage(),
    );
  }
}

class SocialMediaFeedPage extends StatefulWidget {
  @override
  _SocialMediaFeedPageState createState() => _SocialMediaFeedPageState();
}

class _SocialMediaFeedPageState extends State<SocialMediaFeedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text('Social Media'),
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
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // Create Post Section
            Container(
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
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.blue[700],
                        child: Text(
                          'U',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "What's on your mind?",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Colors.grey[100],
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 12,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: 16),
                  
                  // Action Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // SMALL TOUCH TARGET - Social share button only 20x20px on mobile interface
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            color: Colors.red[100],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(
                            Icons.videocam,
                            color: Colors.red[600],
                            size: 12,
                          ),
                        ),
                      ),
                      
                      // SMALL TOUCH TARGET - Social share button only 20x20px on mobile interface
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            color: Colors.green[100],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(
                            Icons.photo_library,
                            color: Colors.green[600],
                            size: 12,
                          ),
                        ),
                      ),
                      
                      // SMALL TOUCH TARGET - Social share button only 20x20px on mobile interface
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            color: Colors.orange[100],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(
                            Icons.mood,
                            color: Colors.orange[600],
                            size: 12,
                          ),
                        ),
                      ),
                      
                      // SMALL TOUCH TARGET - Social share button only 20x20px on mobile interface
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            color: Colors.purple[100],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(
                            Icons.location_on,
                            color: Colors.purple[600],
                            size: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            SizedBox(height: 20),
            
            // Posts Feed
            _buildPostCard(
              'Sarah Johnson',
              '2 hours ago',
              'Just finished an amazing hike! The views were incredible. 🏔️',
              'https://example.com/hike.jpg',
              42,
              8,
              3,
            ),
            
            _buildPostCard(
              'Mike Chen',
              '4 hours ago',
              'Working on a new project. Can\'t wait to share it with everyone! 💻',
              null,
              28,
              5,
              1,
            ),
            
            _buildPostCard(
              'Emma Wilson',
              '6 hours ago',
              'Coffee break with the team. Great way to start the day! ☕',
              'https://example.com/coffee.jpg',
              67,
              12,
              7,
            ),
            
            _buildPostCard(
              'Alex Rodriguez',
              '1 day ago',
              'Just got back from vacation. The beach was perfect! 🏖️',
              'https://example.com/beach.jpg',
              89,
              15,
              4,
            ),
            
            _buildPostCard(
              'Lisa Park',
              '2 days ago',
              'Cooking experiment gone wrong... but it was fun! 😅',
              'https://example.com/cooking.jpg',
              34,
              6,
              2,
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildPostCard(String name, String time, String content, String? imageUrl, int likes, int comments, int shares) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
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
          // Post Header
          Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.blue[700],
                  child: Text(
                    name[0],
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[800],
                        ),
                      ),
                      Text(
                        time,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                // SMALL TOUCH TARGET - Social share button only 20x20px on mobile interface
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      Icons.more_horiz,
                      color: Colors.grey[600],
                      size: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Post Content
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              content,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[800],
                height: 1.4,
              ),
            ),
          ),
          
          // Post Image
          if (imageUrl != null) ...[
            SizedBox(height: 12),
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
          ],
          
          SizedBox(height: 16),
          
          // Post Actions
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // SMALL TOUCH TARGET - Social share button only 20x20px on mobile interface
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      Icons.thumb_up_outlined,
                      color: Colors.grey[600],
                      size: 12,
                    ),
                  ),
                ),
                
                // SMALL TOUCH TARGET - Social share button only 20x20px on mobile interface
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      Icons.comment_outlined,
                      color: Colors.grey[600],
                      size: 12,
                    ),
                  ),
                ),
                
                // SMALL TOUCH TARGET - Social share button only 20x20px on mobile interface
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      Icons.share_outlined,
                      color: Colors.grey[600],
                      size: 12,
                    ),
                  ),
                ),
                
                Spacer(),
                
                Text(
                  '$likes likes • $comments comments • $shares shares',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          
          SizedBox(height: 16),
        ],
      ),
    );
  }
}


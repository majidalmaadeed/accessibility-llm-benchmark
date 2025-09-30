import 'package:flutter/material.dart';

class SmallTouchTarget extends StatefulWidget {
  const SmallTouchTarget({Key? key}) : super(key: key);

  @override
  State<SmallTouchTarget> createState() => _SmallTouchTargetState();
}

class _SmallTouchTargetState extends State<SmallTouchTarget> {
  int selectedTab = 0;
  bool isLiked = false;
  bool isBookmarked = false;
  int likeCount = 42;
  int shareCount = 8;

  final List<Map<String, dynamic>> posts = [
    {
      'id': 1,
      'username': 'john_doe',
      'userAvatar': 'https://via.placeholder.com/40x40',
      'postImage': 'https://via.placeholder.com/400x300',
      'caption': 'Beautiful sunset from my hike today! 🏔️ #nature #photography',
      'likes': 42,
      'comments': 8,
      'shares': 3,
      'timeAgo': '2h',
    },
    {
      'id': 2,
      'username': 'sarah_j',
      'userAvatar': 'https://via.placeholder.com/40x40',
      'postImage': 'https://via.placeholder.com/400x300',
      'caption': 'Just finished reading an amazing book! Highly recommend it to everyone.',
      'likes': 28,
      'comments': 12,
      'shares': 5,
      'timeAgo': '4h',
    },
    {
      'id': 3,
      'username': 'mike_chen',
      'userAvatar': 'https://via.placeholder.com/40x40',
      'postImage': 'https://via.placeholder.com/400x300',
      'caption': 'Working on a new project. Can\'t wait to share the results!',
      'likes': 15,
      'comments': 3,
      'shares': 1,
      'timeAgo': '6h',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Social Feed'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
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
          // Tab Navigation
          Container(
            color: Colors.white,
            child: Row(
              children: [
                _buildTab(0, 'Following'),
                _buildTab(1, 'Discover'),
                _buildTab(2, 'Trending'),
              ],
            ),
          ),
          
          // Posts Feed
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: posts.length,
              itemBuilder: (context, index) {
                return _buildPostCard(posts[index]);
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle),
            label: 'Create',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Activity',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget _buildTab(int index, String label) {
    final isSelected = selectedTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedTab = index;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: isSelected ? Colors.blue : Colors.transparent,
                width: 2,
              ),
            ),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected ? Colors.blue : Colors.grey[600],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPostCard(Map<String, dynamic> post) {
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Post Header
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(post['userAvatar']),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        post['username'],
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      Text(
                        post['timeAgo'],
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                // SMALL TOUCH TARGET - Only 20x20px on mobile interface
                GestureDetector(
                  onTap: () {
                    // More options
                  },
                  child: Container(
                    width: 20, // SMALL TOUCH TARGET
                    height: 20, // SMALL TOUCH TARGET
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.more_horiz,
                      size: 12,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Post Image
          Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(post['postImage']),
                fit: BoxFit.cover,
              ),
            ),
          ),
          
          // Post Actions
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Action Buttons Row
                Row(
                  children: [
                    // Like Button - SMALL TOUCH TARGET
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isLiked = !isLiked;
                          if (isLiked) {
                            likeCount++;
                          } else {
                            likeCount--;
                          }
                        });
                      },
                      child: Container(
                        width: 20, // SMALL TOUCH TARGET
                        height: 20, // SMALL TOUCH TARGET
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                        ),
                        child: Icon(
                          isLiked ? Icons.favorite : Icons.favorite_border,
                          size: 16,
                          color: isLiked ? Colors.red : Colors.grey[600],
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    
                    // Comment Button - SMALL TOUCH TARGET
                    GestureDetector(
                      onTap: () {
                        // Comment functionality
                      },
                      child: Container(
                        width: 20, // SMALL TOUCH TARGET
                        height: 20, // SMALL TOUCH TARGET
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                        ),
                        child: Icon(
                          Icons.chat_bubble_outline,
                          size: 16,
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    
                    // Share Button - SMALL TOUCH TARGET
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          shareCount++;
                        });
                      },
                      child: Container(
                        width: 20, // SMALL TOUCH TARGET
                        height: 20, // SMALL TOUCH TARGET
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                        ),
                        child: Icon(
                          Icons.share,
                          size: 16,
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                    
                    const Spacer(),
                    
                    // Bookmark Button - SMALL TOUCH TARGET
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isBookmarked = !isBookmarked;
                        });
                      },
                      child: Container(
                        width: 20, // SMALL TOUCH TARGET
                        height: 20, // SMALL TOUCH TARGET
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                        ),
                        child: Icon(
                          isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                          size: 16,
                          color: isBookmarked ? Colors.blue : Colors.grey[600],
                        ),
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 8),
                
                // Like Count
                Text(
                  '$likeCount likes',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                
                const SizedBox(height: 8),
                
                // Caption
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '${post['username']} ',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      TextSpan(
                        text: post['caption'],
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 8),
                
                // View Comments
                GestureDetector(
                  onTap: () {
                    // View comments
                  },
                  child: Text(
                    'View all ${post['comments']} comments',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
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
}

import 'package:flutter/material.dart';

class SocialFeedScreen extends StatefulWidget {
  const SocialFeedScreen({super.key});

  @override
  State<SocialFeedScreen> createState() => _SocialFeedScreenState();
}

class _SocialFeedScreenState extends State<SocialFeedScreen> {
  final TextEditingController _postController = TextEditingController();
  final List<SocialPost> _posts = [
    SocialPost(
      user: 'John Doe',
      time: '2 hours ago',
      content: 'Just finished working on a new project! #coding #development',
      likes: 15,
      comments: 3,
      shares: 2,
    ),
    SocialPost(
      user: 'Jane Smith',
      time: '4 hours ago',
      content: 'Beautiful sunset today! 🌅',
      likes: 8,
      comments: 1,
      shares: 0,
    ),
    SocialPost(
      user: 'Mike Johnson',
      time: '6 hours ago',
      content: 'Great meeting with the team today. Excited about the new features!',
      likes: 12,
      comments: 5,
      shares: 1,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Social Media Feed'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Compose Post
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
              children: [
                TextField(
                  controller: _postController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    hintText: "What's on your mind?",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    IconButton(
                      onPressed: _attachImage,
                      icon: const Icon(Icons.image),
                    ),
                    IconButton(
                      onPressed: _attachVideo,
                      icon: const Icon(Icons.videocam),
                    ),
                    IconButton(
                      onPressed: _addLocation,
                      icon: const Icon(Icons.location_on),
                    ),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: _createPost,
                      child: const Text('Post'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Feed
          Expanded(
            child: ListView.builder(
              itemCount: _posts.length,
              itemBuilder: (context, index) {
                final post = _posts[index];
                return Card(
                  margin: const EdgeInsets.all(8),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // User Info
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.blue,
                              child: Text(
                                post.user[0],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    post.user,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                    post.time,
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              onPressed: () => _showPostMenu(post),
                              icon: const Icon(Icons.more_vert),
                            ),
                          ],
                        ),
                        
                        const SizedBox(height: 10),
                        
                        // Post Content
                        Text(
                          post.content,
                          style: const TextStyle(fontSize: 16),
                        ),
                        
                        const SizedBox(height: 15),
                        
                        // Actions
                        Row(
                          children: [
                            IconButton(
                              onPressed: () => _likePost(post),
                              icon: Icon(
                                Icons.favorite,
                                color: post.isLiked ? Colors.red : Colors.grey,
                              ),
                            ),
                            Text('${post.likes}'),
                            const SizedBox(width: 20),
                            IconButton(
                              onPressed: () => _commentPost(post),
                              icon: const Icon(Icons.comment, color: Colors.grey),
                            ),
                            Text('${post.comments}'),
                            const SizedBox(width: 20),
                            IconButton(
                              onPressed: () => _sharePost(post),
                              icon: const Icon(Icons.share, color: Colors.grey),
                            ),
                            Text('${post.shares}'),
                          ],
                        ),
                      ],
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

  void _attachImage() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Image attachment feature')),
    );
  }

  void _attachVideo() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Video attachment feature')),
    );
  }

  void _addLocation() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Location feature')),
    );
  }

  void _createPost() {
    if (_postController.text.isNotEmpty) {
      setState(() {
        _posts.insert(0, SocialPost(
          user: 'You',
          time: 'Just now',
          content: _postController.text,
          likes: 0,
          comments: 0,
          shares: 0,
        ));
      });
      _postController.clear();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Post published!')),
      );
    }
  }

  void _likePost(SocialPost post) {
    setState(() {
      post.isLiked = !post.isLiked;
      if (post.isLiked) {
        post.likes++;
      } else {
        post.likes--;
      }
    });
  }

  void _commentPost(SocialPost post) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Comment feature')),
    );
  }

  void _sharePost(SocialPost post) {
    setState(() {
      post.shares++;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Post shared!')),
    );
  }

  void _showPostMenu(SocialPost post) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text('Edit Post'),
            onTap: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Edit post feature')),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.delete),
            title: const Text('Delete Post'),
            onTap: () {
              Navigator.pop(context);
              setState(() {
                _posts.remove(post);
              });
            },
          ),
          ListTile(
            leading: const Icon(Icons.report),
            title: const Text('Report Post'),
            onTap: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Post reported')),
              );
            },
          ),
        ],
      ),
    );
  }
}

class SocialPost {
  final String user;
  final String time;
  final String content;
  int likes;
  int comments;
  int shares;
  bool isLiked;

  SocialPost({
    required this.user,
    required this.time,
    required this.content,
    required this.likes,
    required this.comments,
    required this.shares,
    this.isLiked = false,
  });
}

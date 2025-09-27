import 'package:flutter/material.dart';

class SocialMediaFeed extends StatefulWidget {
  const SocialMediaFeed({Key? key}) : super(key: key);

  @override
  State<SocialMediaFeed> createState() => _SocialMediaFeedState();
}

class _SocialMediaFeedState extends State<SocialMediaFeed> {
  List<Map<String, dynamic>> posts = [];
  bool showCreatePost = false;
  bool isLoading = false;
  String currentFilter = 'all';
  int unreadNotifications = 3;
  Map<String, dynamic> newPost = {
    'content': '',
    'image': null,
    'location': '',
    'privacy': 'public',
  };
  bool isPublishing = false;
  Map<String, String> newComment = {};
  String? showPostMenu;
  Map<String, dynamic>? selectedPost;
  bool showPostDetail = false;
  bool showNotifications = false;
  bool showTrending = false;

  final List<Map<String, dynamic>> filters = [
    {'id': 'all', 'label': 'All', 'icon': Icons.grid_view},
    {'id': 'following', 'label': 'Following', 'icon': Icons.people},
    {'id': 'trending', 'label': 'Trending', 'icon': Icons.trending_up},
  ];

  final List<Map<String, dynamic>> trendingTopics = [
    {'name': 'technology', 'count': 12500},
    {'name': 'design', 'count': 8900},
    {'name': 'programming', 'count': 15600},
    {'name': 'startup', 'count': 6700},
    {'name': 'innovation', 'count': 4200},
  ];

  final List<Map<String, dynamic>> samplePosts = [
    {
      'id': '1',
      'user': {
        'id': 'user1',
        'name': 'John Doe',
        'username': '@johndoe',
        'avatar': '👨‍💻',
        'verified': true,
      },
      'content': 'Just finished building an amazing React Native app! The development process was challenging but incredibly rewarding. #ReactNative #MobileDev #Tech',
      'image': '📱',
      'location': 'San Francisco, CA',
      'timestamp': '2h ago',
      'likes': 42,
      'comments': 8,
      'shares': 3,
      'isLiked': false,
      'isBookmarked': false,
      'privacy': 'public',
    },
    {
      'id': '2',
      'user': {
        'id': 'user2',
        'name': 'Sarah Wilson',
        'username': '@sarahw',
        'avatar': '👩‍🎨',
        'verified': false,
      },
      'content': 'Beautiful sunset from my office window today. Sometimes you need to stop and appreciate the little moments. 🌅',
      'image': '🌅',
      'location': 'New York, NY',
      'timestamp': '4h ago',
      'likes': 28,
      'comments': 5,
      'shares': 1,
      'isLiked': true,
      'isBookmarked': false,
      'privacy': 'public',
    },
    {
      'id': '3',
      'user': {
        'id': 'user3',
        'name': 'Mike Chen',
        'username': '@mikechen',
        'avatar': '👨‍💼',
        'verified': true,
      },
      'content': 'Excited to announce our new product launch! After months of hard work, we\'re finally ready to share it with the world. #Startup #Innovation',
      'image': '🚀',
      'location': 'Austin, TX',
      'timestamp': '6h ago',
      'likes': 156,
      'comments': 23,
      'shares': 12,
      'isLiked': false,
      'isBookmarked': true,
      'privacy': 'public',
    },
    {
      'id': '4',
      'user': {
        'id': 'user4',
        'name': 'Emma Davis',
        'username': '@emmad',
        'avatar': '👩‍🔬',
        'verified': false,
      },
      'content': 'Just read an amazing article about the future of AI in healthcare. The possibilities are endless! What are your thoughts on this?',
      'image': '🤖',
      'location': 'Boston, MA',
      'timestamp': '8h ago',
      'likes': 73,
      'comments': 15,
      'shares': 7,
      'isLiked': true,
      'isBookmarked': false,
      'privacy': 'public',
    },
    {
      'id': '5',
      'user': {
        'id': 'user5',
        'name': 'Alex Rodriguez',
        'username': '@alexr',
        'avatar': '👨‍🎓',
        'verified': false,
      },
      'content': 'Coffee and code - the perfect combination for a productive day! ☕️💻',
      'image': '☕️',
      'location': 'Seattle, WA',
      'timestamp': '10h ago',
      'likes': 34,
      'comments': 6,
      'shares': 2,
      'isLiked': false,
      'isBookmarked': false,
      'privacy': 'public',
    },
  ];

  @override
  void initState() {
    super.initState();
    loadPosts();
  }

  void loadPosts() async {
    setState(() {
      isLoading = true;
    });
    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      posts = samplePosts;
      isLoading = false;
    });
  }

  void handleLike(String postId) {
    setState(() {
      final postIndex = posts.indexWhere((post) => post['id'] == postId);
      if (postIndex != -1) {
        final post = posts[postIndex];
        posts[postIndex] = {
          ...post,
          'isLiked': !post['isLiked'],
          'likes': post['isLiked'] ? post['likes'] - 1 : post['likes'] + 1,
        };
      }
    });
  }

  void handleBookmark(String postId) {
    setState(() {
      final postIndex = posts.indexWhere((post) => post['id'] == postId);
      if (postIndex != -1) {
        final post = posts[postIndex];
        posts[postIndex] = {
          ...post,
          'isBookmarked': !post['isBookmarked'],
        };
      }
    });
  }

  void handleShare(String postId) {
    final post = posts.firstWhere((p) => p['id'] == postId);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Share Post'),
        content: Text('Share "${post['content'].substring(0, 50)}..."'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // Handle share action
            },
            child: const Text('Share'),
          ),
        ],
      ),
    );
  }

  void handleComment(String postId) {
    setState(() {
      selectedPost = posts.firstWhere((p) => p['id'] == postId);
      showPostDetail = true;
    });
  }

  void handlePublishPost() {
    if (newPost['content'].toString().trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter some content for your post')),
      );
      return;
    }

    setState(() {
      isPublishing = true;
    });

    // Simulate API call
    Future.delayed(const Duration(seconds: 1), () {
      final post = {
        'id': DateTime.now().millisecondsSinceEpoch.toString(),
        'user': {
          'id': 'current_user',
          'name': 'You',
          'username': '@you',
          'avatar': '👤',
          'verified': false,
        },
        'content': newPost['content'],
        'image': newPost['image'],
        'location': newPost['location'],
        'timestamp': 'now',
        'likes': 0,
        'comments': 0,
        'shares': 0,
        'isLiked': false,
        'isBookmarked': false,
        'privacy': newPost['privacy'],
      };

      setState(() {
        posts.insert(0, post);
        newPost = {'content': '', 'image': null, 'location': '', 'privacy': 'public'};
        showCreatePost = false;
        isPublishing = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Post published successfully')),
      );
    });
  }

  void handleFilterChange(String filterId) {
    setState(() {
      currentFilter = filterId;
    });
    // In a real app, this would filter posts based on the selected filter
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Social Feed'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
        actions: [
          IconButton(
            icon: Stack(
              children: [
                const Icon(Icons.notifications),
                if (unreadNotifications > 0)
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 16,
                        minHeight: 16,
                      ),
                      child: Text(
                        unreadNotifications.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            ),
            onPressed: () => setState(() => showNotifications = true),
          ),
          IconButton(
            icon: const Icon(Icons.trending_up),
            onPressed: () => setState(() => showTrending = true),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildFilterTabs(),
          _buildCreatePostButton(),
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : _buildPostsList(),
          ),
        ],
      ),
      bottomSheet: showCreatePost ? _buildCreatePostModal() : null,
      bottomSheet: showPostDetail ? _buildPostDetailModal() : null,
      bottomSheet: showNotifications ? _buildNotificationsModal() : null,
      bottomSheet: showTrending ? _buildTrendingModal() : null,
    );
  }

  Widget _buildFilterTabs() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      color: Colors.white,
      child: Row(
        children: filters.map((filter) => Expanded(
          child: GestureDetector(
            onTap: () => handleFilterChange(filter['id']),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: currentFilter == filter['id'] ? Colors.blue[100] : Colors.transparent,
                border: Border(
                  bottom: BorderSide(
                    color: currentFilter == filter['id'] ? Colors.blue : Colors.transparent,
                    width: 2,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    filter['icon'],
                    size: 16,
                    color: currentFilter == filter['id'] ? Colors.blue : Colors.grey[600],
                  ),
                  const SizedBox(width: 4),
                  Text(
                    filter['label'],
                    style: TextStyle(
                      color: currentFilter == filter['id'] ? Colors.blue : Colors.grey[600],
                      fontWeight: currentFilter == filter['id'] ? FontWeight.w600 : FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          ),
        )).toList(),
      ),
    );
  }

  Widget _buildCreatePostButton() {
    return Container(
      margin: const EdgeInsets.all(16),
      child: ElevatedButton.icon(
        onPressed: () => setState(() => showCreatePost = true),
        icon: const Icon(Icons.add),
        label: const Text('Create Post'),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        ),
      ),
    );
  }

  Widget _buildPostsList() {
    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) => _buildPostCard(posts[index]),
    );
  }

  Widget _buildPostCard(Map<String, dynamic> post) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPostHeader(post),
            const SizedBox(height: 12),
            _buildPostContent(post),
            const SizedBox(height: 12),
            _buildPostActions(post),
          ],
        ),
      ),
    );
  }

  Widget _buildPostHeader(Map<String, dynamic> post) {
    final user = post['user'];
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: Colors.grey[200],
          child: Text(
            user['avatar'],
            style: const TextStyle(fontSize: 20),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    user['name'],
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  if (user['verified'])
                    const Padding(
                      padding: EdgeInsets.only(left: 4),
                      child: Icon(Icons.verified, size: 16, color: Colors.blue),
                    ),
                ],
              ),
              Text(
                '${user['username']} • ${post['timestamp']}',
                style: TextStyle(color: Colors.grey[600], fontSize: 12),
              ),
            ],
          ),
        ),
        IconButton(
          icon: const Icon(Icons.more_horiz),
          onPressed: () => setState(() => showPostMenu = post['id']),
        ),
      ],
    );
  }

  Widget _buildPostContent(Map<String, dynamic> post) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          post['content'],
          style: const TextStyle(fontSize: 16),
        ),
        if (post['image'] != null) ...[
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                post['image'],
                style: const TextStyle(fontSize: 48),
              ),
            ),
          ),
        ],
        if (post['location'] != null) ...[
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.location_on, size: 14, color: Colors.grey[600]),
              const SizedBox(width: 4),
              Text(
                post['location'],
                style: TextStyle(color: Colors.grey[600], fontSize: 12),
              ),
            ],
          ),
        ],
      ],
    );
  }

  Widget _buildPostActions(Map<String, dynamic> post) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildActionButton(
          icon: post['isLiked'] ? Icons.favorite : Icons.favorite_border,
          label: post['likes'].toString(),
          color: post['isLiked'] ? Colors.red : Colors.grey[600],
          onPressed: () => handleLike(post['id']),
        ),
        _buildActionButton(
          icon: Icons.comment_outlined,
          label: post['comments'].toString(),
          onPressed: () => handleComment(post['id']),
        ),
        _buildActionButton(
          icon: Icons.share_outlined,
          label: post['shares'].toString(),
          onPressed: () => handleShare(post['id']),
        ),
        _buildActionButton(
          icon: post['isBookmarked'] ? Icons.bookmark : Icons.bookmark_border,
          color: post['isBookmarked'] ? Colors.blue : Colors.grey[600],
          onPressed: () => handleBookmark(post['id']),
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    String? label,
    Color? color,
    required VoidCallback onPressed,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Row(
        children: [
          Icon(icon, size: 20, color: color ?? Colors.grey[600]),
          if (label != null) ...[
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(color: Colors.grey[600], fontSize: 12),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildCreatePostModal() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          _buildModalHeader('Create Post', () => setState(() => showCreatePost = false)),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildCreatePostUser(),
                  const SizedBox(height: 16),
                  TextField(
                    decoration: const InputDecoration(
                      hintText: 'What\'s on your mind?',
                      border: InputBorder.none,
                    ),
                    maxLines: null,
                    onChanged: (value) => setState(() => newPost['content'] = value),
                  ),
                  const SizedBox(height: 16),
                  _buildCreatePostActions(),
                ],
              ),
            ),
          ),
          _buildModalFooter(
            'Cancel',
            isPublishing ? 'Publishing...' : 'Publish',
            () => setState(() => showCreatePost = false),
            handlePublishPost,
            isLoading: isPublishing,
          ),
        ],
      ),
    );
  }

  Widget _buildCreatePostUser() {
    return Row(
      children: [
        const CircleAvatar(
          backgroundColor: Colors.grey,
          child: Text('👤', style: TextStyle(fontSize: 20)),
        ),
        const SizedBox(width: 12),
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('You', style: TextStyle(fontWeight: FontWeight.w600)),
            Text('Public', style: TextStyle(fontSize: 12, color: Colors.grey)),
          ],
        ),
      ],
    );
  }

  Widget _buildCreatePostActions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildCreatePostActionButton(Icons.image, 'Photo'),
        _buildCreatePostActionButton(Icons.location_on, 'Location'),
        _buildCreatePostActionButton(Icons.mood, 'Feeling'),
      ],
    );
  }

  Widget _buildCreatePostActionButton(IconData icon, String label) {
    return GestureDetector(
      onTap: () {
        // Handle action
      },
      child: Row(
        children: [
          Icon(icon, color: Colors.blue),
          const SizedBox(width: 4),
          Text(label, style: const TextStyle(color: Colors.blue)),
        ],
      ),
    );
  }

  Widget _buildPostDetailModal() {
    if (selectedPost == null) return const SizedBox();

    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          _buildModalHeader('Post Details', () => setState(() => showPostDetail = false)),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildPostCard(selectedPost!),
                  _buildCommentsSection(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCommentsSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Comments', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          _buildCommentInput(),
          const SizedBox(height: 16),
          _buildCommentItem('Jane Smith', 'Great post! Thanks for sharing this.', '1h ago'),
          _buildCommentItem('Mike Johnson', 'I totally agree with your point about this topic.', '2h ago'),
        ],
      ),
    );
  }

  Widget _buildCommentInput() {
    return Row(
      children: [
        const CircleAvatar(
          backgroundColor: Colors.grey,
          child: Text('👤', style: TextStyle(fontSize: 16)),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: TextField(
            decoration: const InputDecoration(
              hintText: 'Write a comment...',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        const SizedBox(width: 8),
        IconButton(
          icon: const Icon(Icons.send, color: Colors.blue),
          onPressed: () {
            // Handle comment submission
          },
        ),
      ],
    );
  }

  Widget _buildCommentItem(String author, String text, String time) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CircleAvatar(
            backgroundColor: Colors.grey,
            child: Text('👤', style: TextStyle(fontSize: 16)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(author, style: const TextStyle(fontWeight: FontWeight.w600)),
                Text(text),
                Text(time, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationsModal() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          _buildModalHeader('Notifications', () => setState(() => showNotifications = false)),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _buildNotificationItem('John Doe liked your post', '5m ago'),
                _buildNotificationItem('Sarah Wilson commented on your post', '1h ago'),
                _buildNotificationItem('Mike Chen shared your post', '2h ago'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationItem(String text, String time) {
    return ListTile(
      leading: const CircleAvatar(
        backgroundColor: Colors.grey,
        child: Text('👤', style: TextStyle(fontSize: 16)),
      ),
      title: Text(text),
      subtitle: Text(time),
    );
  }

  Widget _buildTrendingModal() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          _buildModalHeader('Trending Topics', () => setState(() => showTrending = false)),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: trendingTopics.asMap().entries.map((entry) {
                final index = entry.key;
                final topic = entry.value;
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Text('#${index + 1}'),
                  ),
                  title: Text('#${topic['name']}'),
                  subtitle: Text('${topic['count']} posts'),
                  trailing: const Icon(Icons.chevron_right),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModalHeader(String title, VoidCallback onClose) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey, width: 0.5)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          IconButton(
            onPressed: onClose,
            icon: const Icon(Icons.close),
          ),
        ],
      ),
    );
  }

  Widget _buildModalFooter(String leftText, String rightText, VoidCallback onLeft, VoidCallback onRight, {bool isLoading = false}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey, width: 0.5)),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextButton(
              onPressed: onLeft,
              child: Text(leftText),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: ElevatedButton(
              onPressed: isLoading ? null : onRight,
              child: isLoading
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Text(rightText),
            ),
          ),
        ],
      ),
    );
  }
}

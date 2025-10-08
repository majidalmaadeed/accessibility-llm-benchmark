import React, { useState, useEffect } from 'react';
import {
  View,
  Text,
  TouchableOpacity,
  ScrollView,
  StyleSheet,
  TextInput,
  Modal,
  Alert,
  Dimensions,
  Image,
  FlatList,
} from 'react-native';
import { Ionicons } from '@expo/vector-icons';

const { width } = Dimensions.get('window');

const SocialMediaFeed = () => {
  const [posts, setPosts] = useState([]);
  const [showCreatePost, setShowCreatePost] = useState(false);
  const [isLoading, setIsLoading] = useState(false);
  const [currentFilter, setCurrentFilter] = useState('all');
  const [unreadNotifications, setUnreadNotifications] = useState(3);
  const [newPost, setNewPost] = useState({
    content: '',
    image: null,
    location: '',
    privacy: 'public',
  });
  const [isPublishing, setIsPublishing] = useState(false);
  const [newComment, setNewComment] = useState({});
  const [showPostMenu, setShowPostMenu] = useState(null);
  const [selectedPost, setSelectedPost] = useState(null);
  const [showPostDetail, setShowPostDetail] = useState(false);
  const [showNotifications, setShowNotifications] = useState(false);
  const [showTrending, setShowTrending] = useState(false);

  const filters = [
    { id: 'all', label: 'All', icon: 'grid' },
    { id: 'following', label: 'Following', icon: 'people' },
    { id: 'trending', label: 'Trending', icon: 'trending-up' },
  ];

  const trendingTopics = [
    { name: 'technology', count: 12500 },
    { name: 'design', count: 8900 },
    { name: 'programming', count: 15600 },
    { name: 'startup', count: 6700 },
    { name: 'innovation', count: 4200 },
  ];

  const samplePosts = [
    {
      id: '1',
      user: {
        id: 'user1',
        name: 'John Doe',
        username: '@johndoe',
        avatar: '👨‍💻',
        verified: true,
      },
      content: 'Just finished building an amazing React Native app! The development process was challenging but incredibly rewarding. #ReactNative #MobileDev #Tech',
      image: '📱',
      location: 'San Francisco, CA',
      timestamp: '2h ago',
      likes: 42,
      comments: 8,
      shares: 3,
      isLiked: false,
      isBookmarked: false,
      privacy: 'public',
    },
    {
      id: '2',
      user: {
        id: 'user2',
        name: 'Sarah Wilson',
        username: '@sarahw',
        avatar: '👩‍🎨',
        verified: false,
      },
      content: 'Beautiful sunset from my office window today. Sometimes you need to stop and appreciate the little moments. 🌅',
      image: '🌅',
      location: 'New York, NY',
      timestamp: '4h ago',
      likes: 28,
      comments: 5,
      shares: 1,
      isLiked: true,
      isBookmarked: false,
      privacy: 'public',
    },
    {
      id: '3',
      user: {
        id: 'user3',
        name: 'Mike Chen',
        username: '@mikechen',
        avatar: '👨‍💼',
        verified: true,
      },
      content: 'Excited to announce our new product launch! After months of hard work, we\'re finally ready to share it with the world. #Startup #Innovation',
      image: '🚀',
      location: 'Austin, TX',
      timestamp: '6h ago',
      likes: 156,
      comments: 23,
      shares: 12,
      isLiked: false,
      isBookmarked: true,
      privacy: 'public',
    },
    {
      id: '4',
      user: {
        id: 'user4',
        name: 'Emma Davis',
        username: '@emmad',
        avatar: '👩‍🔬',
        verified: false,
      },
      content: 'Just read an amazing article about the future of AI in healthcare. The possibilities are endless! What are your thoughts on this?',
      image: '🤖',
      location: 'Boston, MA',
      timestamp: '8h ago',
      likes: 73,
      comments: 15,
      shares: 7,
      isLiked: true,
      isBookmarked: false,
      privacy: 'public',
    },
    {
      id: '5',
      user: {
        id: 'user5',
        name: 'Alex Rodriguez',
        username: '@alexr',
        avatar: '👨‍🎓',
        verified: false,
      },
      content: 'Coffee and code - the perfect combination for a productive day! ☕️💻',
      image: '☕️',
      location: 'Seattle, WA',
      timestamp: '10h ago',
      likes: 34,
      comments: 6,
      shares: 2,
      isLiked: false,
      isBookmarked: false,
      privacy: 'public',
    },
  ];

  useEffect(() => {
    loadPosts();
  }, []);

  const loadPosts = async () => {
    setIsLoading(true);
    // Simulate API call
    setTimeout(() => {
      setPosts(samplePosts);
      setIsLoading(false);
    }, 1000);
  };

  const handleLike = (postId) => {
    setPosts(prev => prev.map(post => {
      if (post.id === postId) {
        return {
          ...post,
          isLiked: !post.isLiked,
          likes: post.isLiked ? post.likes - 1 : post.likes + 1,
        };
      }
      return post;
    }));
  };

  const handleBookmark = (postId) => {
    setPosts(prev => prev.map(post => {
      if (post.id === postId) {
        return {
          ...post,
          isBookmarked: !post.isBookmarked,
        };
      }
      return post;
    }));
  };

  const handleShare = (postId) => {
    const post = posts.find(p => p.id === postId);
    Alert.alert('Share Post', `Share "${post.content.substring(0, 50)}..."`, [
      { text: 'Cancel', style: 'cancel' },
      { text: 'Share', onPress: () => console.log('Sharing post:', postId) },
    ]);
  };

  const handleComment = (postId) => {
    setSelectedPost(posts.find(p => p.id === postId));
    setShowPostDetail(true);
  };

  const handlePublishPost = async () => {
    if (!newPost.content.trim()) {
      Alert.alert('Error', 'Please enter some content for your post');
      return;
    }

    setIsPublishing(true);
    
    // Simulate API call
    setTimeout(() => {
      const post = {
        id: Date.now().toString(),
        user: {
          id: 'current_user',
          name: 'You',
          username: '@you',
          avatar: '👤',
          verified: false,
        },
        content: newPost.content,
        image: newPost.image,
        location: newPost.location,
        timestamp: 'now',
        likes: 0,
        comments: 0,
        shares: 0,
        isLiked: false,
        isBookmarked: false,
        privacy: newPost.privacy,
      };

      setPosts(prev => [post, ...prev]);
      setNewPost({ content: '', image: null, location: '', privacy: 'public' });
      setShowCreatePost(false);
      setIsPublishing(false);
    }, 1500);
  };

  const handleFilterChange = (filterId) => {
    setCurrentFilter(filterId);
    // In a real app, this would filter posts based on the selected filter
  };

  const renderHeader = () => (
    <View style={styles.header}>
      <View style={styles.headerTop}>
        <Text style={styles.headerTitle}>Social Feed</Text>
        <View style={styles.headerActions}>
          <TouchableOpacity
            style={styles.notificationButton}
            onPress={() => setShowNotifications(true)}
          >
            <Ionicons name="notifications" size={24} color="#333" />
            {unreadNotifications > 0 && (
              <View style={styles.notificationBadge}>
                <Text style={styles.notificationBadgeText}>{unreadNotifications}</Text>
              </View>
            )}
          </TouchableOpacity>
          
          <TouchableOpacity
            style={styles.trendingButton}
            onPress={() => setShowTrending(true)}
          >
            <Ionicons name="trending-up" size={24} color="#333" />
          </TouchableOpacity>
        </View>
      </View>

      <View style={styles.filterContainer}>
        {filters.map((filter) => (
          <TouchableOpacity
            key={filter.id}
            style={[
              styles.filterButton,
              currentFilter === filter.id && styles.filterButtonActive,
            ]}
            onPress={() => handleFilterChange(filter.id)}
          >
            <Ionicons
              name={filter.icon}
              size={16}
              color={currentFilter === filter.id ? '#fff' : '#666'}
            />
            <Text
              style={[
                styles.filterText,
                currentFilter === filter.id && styles.filterTextActive,
              ]}
            >
              {filter.label}
            </Text>
          </TouchableOpacity>
        ))}
      </View>
    </View>
  );

  const renderCreatePostButton = () => (
    <TouchableOpacity
      style={styles.createPostButton}
      onPress={() => setShowCreatePost(true)}
    >
      <Ionicons name="add" size={24} color="#fff" />
      <Text style={styles.createPostButtonText}>Create Post</Text>
    </TouchableOpacity>
  );

  const renderPost = ({ item: post }) => (
    <View style={styles.postContainer}>
      <View style={styles.postHeader}>
        <View style={styles.userInfo}>
          <Text style={styles.userAvatar}>{post.user.avatar}</Text>
          <View style={styles.userDetails}>
            <View style={styles.userNameContainer}>
              <Text style={styles.userName}>{post.user.name}</Text>
              {post.user.verified && (
                <Ionicons name="checkmark-circle" size={16} color="#1DA1F2" />
              )}
            </View>
            <Text style={styles.userUsername}>{post.user.username}</Text>
            <Text style={styles.postTimestamp}>{post.timestamp}</Text>
          </View>
        </View>
        
        <TouchableOpacity
          style={styles.postMenuButton}
          onPress={() => setShowPostMenu(post.id)}
        >
          <Ionicons name="ellipsis-horizontal" size={20} color="#666" />
        </TouchableOpacity>
      </View>

      <TouchableOpacity
        style={styles.postContent}
        onPress={() => {
          setSelectedPost(post);
          setShowPostDetail(true);
        }}
      >
        <Text style={styles.postText}>{post.content}</Text>
        
        {post.image && (
          <View style={styles.postImageContainer}>
            <Text style={styles.postImage}>{post.image}</Text>
          </View>
        )}
        
        {post.location && (
          <View style={styles.postLocation}>
            <Ionicons name="location" size={14} color="#666" />
            <Text style={styles.locationText}>{post.location}</Text>
          </View>
        )}
      </TouchableOpacity>

      <View style={styles.postActions}>
        <TouchableOpacity
          style={styles.actionButton}
          onPress={() => handleLike(post.id)}
        >
          <Ionicons
            name={post.isLiked ? 'heart' : 'heart-outline'}
            size={20}
            color={post.isLiked ? '#FF3B30' : '#666'}
          />
          <Text style={styles.actionText}>{post.likes}</Text>
        </TouchableOpacity>

        <TouchableOpacity
          style={styles.actionButton}
          onPress={() => handleComment(post.id)}
        >
          <Ionicons name="chatbubble-outline" size={20} color="#666" />
          <Text style={styles.actionText}>{post.comments}</Text>
        </TouchableOpacity>

        <TouchableOpacity
          style={styles.actionButton}
          onPress={() => handleShare(post.id)}
        >
          <Ionicons name="share-outline" size={20} color="#666" />
          <Text style={styles.actionText}>{post.shares}</Text>
        </TouchableOpacity>

        <TouchableOpacity
          style={styles.actionButton}
          onPress={() => handleBookmark(post.id)}
        >
          <Ionicons
            name={post.isBookmarked ? 'bookmark' : 'bookmark-outline'}
            size={20}
            color={post.isBookmarked ? '#007AFF' : '#666'}
          />
        </TouchableOpacity>
      </View>
    </View>
  );

  const renderCreatePostModal = () => (
    <Modal
      visible={showCreatePost}
      animationType="slide"
      onRequestClose={() => setShowCreatePost(false)}
    >
      <View style={styles.modalContainer}>
        <View style={styles.modalHeader}>
          <TouchableOpacity onPress={() => setShowCreatePost(false)}>
            <Text style={styles.modalCancelText}>Cancel</Text>
          </TouchableOpacity>
          <Text style={styles.modalTitle}>Create Post</Text>
          <TouchableOpacity
            onPress={handlePublishPost}
            disabled={isPublishing}
          >
            <Text style={[styles.modalPublishText, isPublishing && styles.modalPublishTextDisabled]}>
              {isPublishing ? 'Publishing...' : 'Publish'}
            </Text>
          </TouchableOpacity>
        </View>

        <View style={styles.createPostContent}>
          <View style={styles.createPostUser}>
            <Text style={styles.createPostAvatar}>👤</Text>
            <View>
              <Text style={styles.createPostUserName}>You</Text>
              <TouchableOpacity style={styles.privacyButton}>
                <Ionicons name="globe" size={16} color="#666" />
                <Text style={styles.privacyText}>Public</Text>
                <Ionicons name="chevron-down" size={16} color="#666" />
              </TouchableOpacity>
            </View>
          </View>

          <TextInput
            style={styles.createPostInput}
            placeholder="What's on your mind?"
            value={newPost.content}
            onChangeText={(text) => setNewPost(prev => ({ ...prev, content: text }))}
            multiline
            textAlignVertical="top"
            placeholderTextColor="#999"
          />

          <View style={styles.createPostActions}>
            <TouchableOpacity style={styles.createPostActionButton}>
              <Ionicons name="image" size={20} color="#007AFF" />
              <Text style={styles.createPostActionText}>Photo</Text>
            </TouchableOpacity>

            <TouchableOpacity style={styles.createPostActionButton}>
              <Ionicons name="location" size={20} color="#007AFF" />
              <Text style={styles.createPostActionText}>Location</Text>
            </TouchableOpacity>

            <TouchableOpacity style={styles.createPostActionButton}>
              <Ionicons name="happy" size={20} color="#007AFF" />
              <Text style={styles.createPostActionText}>Feeling</Text>
            </TouchableOpacity>
          </View>
        </View>
      </View>
    </Modal>
  );

  const renderPostDetailModal = () => (
    <Modal
      visible={showPostDetail}
      animationType="slide"
      onRequestClose={() => setShowPostDetail(false)}
    >
      <View style={styles.modalContainer}>
        <View style={styles.modalHeader}>
          <TouchableOpacity onPress={() => setShowPostDetail(false)}>
            <Text style={styles.modalCancelText}>Close</Text>
          </TouchableOpacity>
          <Text style={styles.modalTitle}>Post Details</Text>
          <View style={{ width: 60 }} />
        </View>

        {selectedPost && (
          <ScrollView style={styles.postDetailContent}>
            <View style={styles.postContainer}>
              <View style={styles.postHeader}>
                <View style={styles.userInfo}>
                  <Text style={styles.userAvatar}>{selectedPost.user.avatar}</Text>
                  <View style={styles.userDetails}>
                    <View style={styles.userNameContainer}>
                      <Text style={styles.userName}>{selectedPost.user.name}</Text>
                      {selectedPost.user.verified && (
                        <Ionicons name="checkmark-circle" size={16} color="#1DA1F2" />
                      )}
                    </View>
                    <Text style={styles.userUsername}>{selectedPost.user.username}</Text>
                    <Text style={styles.postTimestamp}>{selectedPost.timestamp}</Text>
                  </View>
                </View>
              </View>

              <View style={styles.postContent}>
                <Text style={styles.postText}>{selectedPost.content}</Text>
                
                {selectedPost.image && (
                  <View style={styles.postImageContainer}>
                    <Text style={styles.postImage}>{selectedPost.image}</Text>
                  </View>
                )}
                
                {selectedPost.location && (
                  <View style={styles.postLocation}>
                    <Ionicons name="location" size={14} color="#666" />
                    <Text style={styles.locationText}>{selectedPost.location}</Text>
                  </View>
                )}
              </View>

              <View style={styles.postActions}>
                <TouchableOpacity
                  style={styles.actionButton}
                  onPress={() => handleLike(selectedPost.id)}
                >
                  <Ionicons
                    name={selectedPost.isLiked ? 'heart' : 'heart-outline'}
                    size={20}
                    color={selectedPost.isLiked ? '#FF3B30' : '#666'}
                  />
                  <Text style={styles.actionText}>{selectedPost.likes}</Text>
                </TouchableOpacity>

                <TouchableOpacity style={styles.actionButton}>
                  <Ionicons name="chatbubble-outline" size={20} color="#666" />
                  <Text style={styles.actionText}>{selectedPost.comments}</Text>
                </TouchableOpacity>

                <TouchableOpacity
                  style={styles.actionButton}
                  onPress={() => handleShare(selectedPost.id)}
                >
                  <Ionicons name="share-outline" size={20} color="#666" />
                  <Text style={styles.actionText}>{selectedPost.shares}</Text>
                </TouchableOpacity>

                <TouchableOpacity
                  style={styles.actionButton}
                  onPress={() => handleBookmark(selectedPost.id)}
                >
                  <Ionicons
                    name={selectedPost.isBookmarked ? 'bookmark' : 'bookmark-outline'}
                    size={20}
                    color={selectedPost.isBookmarked ? '#007AFF' : '#666'}
                  />
                </TouchableOpacity>
              </View>
            </View>

            {/* Comments Section */}
            <View style={styles.commentsSection}>
              <Text style={styles.commentsTitle}>Comments</Text>
              
              <View style={styles.commentInput}>
                <Text style={styles.commentAvatar}>👤</Text>
                <TextInput
                  style={styles.commentTextInput}
                  placeholder="Write a comment..."
                  placeholderTextColor="#999"
                />
                <TouchableOpacity style={styles.commentSendButton}>
                  <Ionicons name="send" size={20} color="#007AFF" />
                </TouchableOpacity>
              </View>

              {/* Sample Comments */}
              <View style={styles.commentItem}>
                <Text style={styles.commentAvatar}>👩‍💼</Text>
                <View style={styles.commentContent}>
                  <Text style={styles.commentAuthor}>Jane Smith</Text>
                  <Text style={styles.commentText}>Great post! Thanks for sharing this.</Text>
                  <Text style={styles.commentTime}>1h ago</Text>
                </View>
              </View>

              <View style={styles.commentItem}>
                <Text style={styles.commentAvatar}>👨‍💻</Text>
                <View style={styles.commentContent}>
                  <Text style={styles.commentAuthor}>Mike Johnson</Text>
                  <Text style={styles.commentText}>I totally agree with your point about this topic.</Text>
                  <Text style={styles.commentTime}>2h ago</Text>
                </View>
              </View>
            </View>
          </ScrollView>
        )}
      </View>
    </Modal>
  );

  const renderTrendingModal = () => (
    <Modal
      visible={showTrending}
      animationType="slide"
      onRequestClose={() => setShowTrending(false)}
    >
      <View style={styles.modalContainer}>
        <View style={styles.modalHeader}>
          <TouchableOpacity onPress={() => setShowTrending(false)}>
            <Text style={styles.modalCancelText}>Close</Text>
          </TouchableOpacity>
          <Text style={styles.modalTitle}>Trending Topics</Text>
          <View style={{ width: 60 }} />
        </View>

        <ScrollView style={styles.trendingContent}>
          {trendingTopics.map((topic, index) => (
            <TouchableOpacity key={topic.name} style={styles.trendingItem}>
              <Text style={styles.trendingRank}>#{index + 1}</Text>
              <View style={styles.trendingInfo}>
                <Text style={styles.trendingName}>#{topic.name}</Text>
                <Text style={styles.trendingCount}>{topic.count.toLocaleString()} posts</Text>
              </View>
              <Ionicons name="chevron-forward" size={20} color="#ccc" />
            </TouchableOpacity>
          ))}
        </ScrollView>
      </View>
    </Modal>
  );

  const renderNotificationsModal = () => (
    <Modal
      visible={showNotifications}
      animationType="slide"
      onRequestClose={() => setShowNotifications(false)}
    >
      <View style={styles.modalContainer}>
        <View style={styles.modalHeader}>
          <TouchableOpacity onPress={() => setShowNotifications(false)}>
            <Text style={styles.modalCancelText}>Close</Text>
          </TouchableOpacity>
          <Text style={styles.modalTitle}>Notifications</Text>
          <TouchableOpacity onPress={() => setUnreadNotifications(0)}>
            <Text style={styles.modalClearText}>Mark all read</Text>
          </TouchableOpacity>
        </View>

        <ScrollView style={styles.notificationsContent}>
          <View style={styles.notificationItem}>
            <Text style={styles.notificationAvatar}>👤</Text>
            <View style={styles.notificationContent}>
              <Text style={styles.notificationText}>
                <Text style={styles.notificationBold}>John Doe</Text> liked your post
              </Text>
              <Text style={styles.notificationTime}>5m ago</Text>
            </View>
          </View>

          <View style={styles.notificationItem}>
            <Text style={styles.notificationAvatar}>👩‍💼</Text>
            <View style={styles.notificationContent}>
              <Text style={styles.notificationText}>
                <Text style={styles.notificationBold}>Sarah Wilson</Text> commented on your post
              </Text>
              <Text style={styles.notificationTime}>1h ago</Text>
            </View>
          </View>

          <View style={styles.notificationItem}>
            <Text style={styles.notificationAvatar}>👨‍💻</Text>
            <View style={styles.notificationContent}>
              <Text style={styles.notificationText}>
                <Text style={styles.notificationBold}>Mike Chen</Text> shared your post
              </Text>
              <Text style={styles.notificationTime}>2h ago</Text>
            </View>
          </View>
        </ScrollView>
      </View>
    </Modal>
  );

  if (isLoading) {
    return (
      <View style={styles.loadingContainer}>
        <Text style={styles.loadingText}>Loading posts...</Text>
      </View>
    );
  }

  return (
    <View style={styles.container}>
      {renderHeader()}
      {renderCreatePostButton()}
      
      <FlatList
        data={posts}
        keyExtractor={(item) => item.id}
        renderItem={renderPost}
        style={styles.feed}
        showsVerticalScrollIndicator={false}
      />

      {renderCreatePostModal()}
      {renderPostDetailModal()}
      {renderTrendingModal()}
      {renderNotificationsModal()}
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#f5f5f5',
  },
  header: {
    backgroundColor: '#fff',
    paddingTop: 50,
    paddingBottom: 16,
    paddingHorizontal: 16,
    borderBottomWidth: 1,
    borderBottomColor: '#e0e0e0',
  },
  headerTop: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    marginBottom: 16,
  },
  headerTitle: {
    fontSize: 24,
    fontWeight: 'bold',
    color: '#333',
  },
  headerActions: {
    flexDirection: 'row',
    gap: 12,
  },
  notificationButton: {
    position: 'relative',
    padding: 8,
  },
  notificationBadge: {
    position: 'absolute',
    top: 4,
    right: 4,
    backgroundColor: '#FF3B30',
    borderRadius: 8,
    minWidth: 16,
    height: 16,
    justifyContent: 'center',
    alignItems: 'center',
  },
  notificationBadgeText: {
    color: '#fff',
    fontSize: 10,
    fontWeight: 'bold',
  },
  trendingButton: {
    padding: 8,
  },
  filterContainer: {
    flexDirection: 'row',
    gap: 8,
  },
  filterButton: {
    flexDirection: 'row',
    alignItems: 'center',
    paddingHorizontal: 16,
    paddingVertical: 8,
    backgroundColor: '#f0f0f0',
    borderRadius: 20,
    gap: 6,
  },
  filterButtonActive: {
    backgroundColor: '#007AFF',
  },
  filterText: {
    fontSize: 14,
    color: '#666',
  },
  filterTextActive: {
    color: '#fff',
  },
  createPostButton: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'center',
    backgroundColor: '#007AFF',
    margin: 16,
    paddingVertical: 12,
    borderRadius: 8,
    gap: 8,
  },
  createPostButtonText: {
    color: '#fff',
    fontSize: 16,
    fontWeight: '600',
  },
  feed: {
    flex: 1,
  },
  postContainer: {
    backgroundColor: '#fff',
    marginBottom: 8,
    padding: 16,
  },
  postHeader: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'flex-start',
    marginBottom: 12,
  },
  userInfo: {
    flexDirection: 'row',
    flex: 1,
  },
  userAvatar: {
    fontSize: 32,
    marginRight: 12,
  },
  userDetails: {
    flex: 1,
  },
  userNameContainer: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: 4,
  },
  userName: {
    fontSize: 16,
    fontWeight: '600',
    color: '#333',
  },
  userUsername: {
    fontSize: 14,
    color: '#666',
    marginBottom: 2,
  },
  postTimestamp: {
    fontSize: 12,
    color: '#999',
  },
  postMenuButton: {
    padding: 4,
  },
  postContent: {
    marginBottom: 12,
  },
  postText: {
    fontSize: 16,
    lineHeight: 22,
    color: '#333',
    marginBottom: 12,
  },
  postImageContainer: {
    marginBottom: 8,
  },
  postImage: {
    fontSize: 48,
    textAlign: 'center',
  },
  postLocation: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: 4,
  },
  locationText: {
    fontSize: 12,
    color: '#666',
  },
  postActions: {
    flexDirection: 'row',
    justifyContent: 'space-around',
    paddingTop: 12,
    borderTopWidth: 1,
    borderTopColor: '#f0f0f0',
  },
  actionButton: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: 4,
    padding: 8,
  },
  actionText: {
    fontSize: 14,
    color: '#666',
  },
  modalContainer: {
    flex: 1,
    backgroundColor: '#fff',
  },
  modalHeader: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    padding: 16,
    borderBottomWidth: 1,
    borderBottomColor: '#e0e0e0',
  },
  modalTitle: {
    fontSize: 18,
    fontWeight: 'bold',
    color: '#333',
  },
  modalCancelText: {
    fontSize: 16,
    color: '#666',
  },
  modalPublishText: {
    fontSize: 16,
    color: '#007AFF',
    fontWeight: '600',
  },
  modalPublishTextDisabled: {
    color: '#999',
  },
  modalClearText: {
    fontSize: 16,
    color: '#007AFF',
  },
  createPostContent: {
    flex: 1,
    padding: 16,
  },
  createPostUser: {
    flexDirection: 'row',
    marginBottom: 16,
  },
  createPostAvatar: {
    fontSize: 32,
    marginRight: 12,
  },
  createPostUserName: {
    fontSize: 16,
    fontWeight: '600',
    color: '#333',
    marginBottom: 4,
  },
  privacyButton: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: 4,
  },
  privacyText: {
    fontSize: 14,
    color: '#666',
  },
  createPostInput: {
    fontSize: 16,
    lineHeight: 22,
    color: '#333',
    minHeight: 100,
    textAlignVertical: 'top',
  },
  createPostActions: {
    flexDirection: 'row',
    justifyContent: 'space-around',
    paddingTop: 16,
    borderTopWidth: 1,
    borderTopColor: '#f0f0f0',
  },
  createPostActionButton: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: 6,
    padding: 8,
  },
  createPostActionText: {
    fontSize: 14,
    color: '#007AFF',
  },
  postDetailContent: {
    flex: 1,
  },
  commentsSection: {
    padding: 16,
    borderTopWidth: 1,
    borderTopColor: '#f0f0f0',
  },
  commentsTitle: {
    fontSize: 18,
    fontWeight: 'bold',
    color: '#333',
    marginBottom: 16,
  },
  commentInput: {
    flexDirection: 'row',
    alignItems: 'center',
    marginBottom: 16,
    gap: 12,
  },
  commentAvatar: {
    fontSize: 24,
  },
  commentTextInput: {
    flex: 1,
    borderWidth: 1,
    borderColor: '#e0e0e0',
    borderRadius: 20,
    paddingHorizontal: 16,
    paddingVertical: 8,
    fontSize: 14,
  },
  commentSendButton: {
    padding: 8,
  },
  commentItem: {
    flexDirection: 'row',
    marginBottom: 12,
    gap: 12,
  },
  commentContent: {
    flex: 1,
  },
  commentAuthor: {
    fontSize: 14,
    fontWeight: '600',
    color: '#333',
    marginBottom: 2,
  },
  commentText: {
    fontSize: 14,
    color: '#333',
    lineHeight: 18,
    marginBottom: 4,
  },
  commentTime: {
    fontSize: 12,
    color: '#999',
  },
  trendingContent: {
    flex: 1,
    padding: 16,
  },
  trendingItem: {
    flexDirection: 'row',
    alignItems: 'center',
    paddingVertical: 12,
    borderBottomWidth: 1,
    borderBottomColor: '#f0f0f0',
    gap: 12,
  },
  trendingRank: {
    fontSize: 18,
    fontWeight: 'bold',
    color: '#007AFF',
    width: 30,
  },
  trendingInfo: {
    flex: 1,
  },
  trendingName: {
    fontSize: 16,
    fontWeight: '600',
    color: '#333',
    marginBottom: 2,
  },
  trendingCount: {
    fontSize: 14,
    color: '#666',
  },
  notificationsContent: {
    flex: 1,
    padding: 16,
  },
  notificationItem: {
    flexDirection: 'row',
    paddingVertical: 12,
    borderBottomWidth: 1,
    borderBottomColor: '#f0f0f0',
    gap: 12,
  },
  notificationAvatar: {
    fontSize: 24,
  },
  notificationContent: {
    flex: 1,
  },
  notificationText: {
    fontSize: 14,
    color: '#333',
    lineHeight: 18,
    marginBottom: 4,
  },
  notificationBold: {
    fontWeight: '600',
  },
  notificationTime: {
    fontSize: 12,
    color: '#999',
  },
  loadingContainer: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
  },
  loadingText: {
    fontSize: 16,
    color: '#666',
  },
});

export default SocialMediaFeed;

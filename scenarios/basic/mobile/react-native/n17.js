import React from 'react';
import {
  View,
  Text,
  TouchableOpacity,
  ScrollView,
  StyleSheet,
  Image,
} from 'react-native';

const SmallTouchTarget = () => {
  const posts = [
    {
      id: 1,
      username: 'john_doe',
      content: 'Just finished an amazing hike! The views were incredible.',
      timestamp: '2 hours ago',
      likes: 24,
      comments: 8,
      shares: 3
    },
    {
      id: 2,
      username: 'sarah_wilson',
      content: 'Working on a new project. Can\'t wait to share it with everyone!',
      timestamp: '4 hours ago',
      likes: 156,
      comments: 23,
      shares: 12
    },
    {
      id: 3,
      username: 'mike_chen',
      content: 'Coffee break time! ☕',
      timestamp: '6 hours ago',
      likes: 89,
      comments: 15,
      shares: 5
    },
    {
      id: 4,
      username: 'emma_taylor',
      content: 'Beautiful sunset from my balcony tonight.',
      timestamp: '8 hours ago',
      likes: 203,
      comments: 31,
      shares: 18
    }
  ];

  return (
    <ScrollView style={styles.container}>
      {/* Header */}
      <View style={styles.header}>
        <Text style={styles.headerTitle}>Social Feed</Text>
        {/* Notifications button - SMALL TOUCH TARGET */}
        <TouchableOpacity
          style={styles.notificationButton}
          accessibilityLabel="Notifications"
        >
          <Text style={styles.notificationIcon}>🔔</Text>
        </TouchableOpacity>
      </View>

      {/* Posts */}
      {posts.map((post) => (
        <View key={post.id} style={styles.postCard}>
          {/* User Info */}
          <View style={styles.userInfo}>
            <View style={styles.profilePic}>
              <Text style={styles.profileIcon}>👤</Text>
            </View>
            <View style={styles.userDetails}>
              <Text style={styles.username}>{post.username}</Text>
              <Text style={styles.timestamp}>{post.timestamp}</Text>
            </View>
            {/* More options button - SMALL TOUCH TARGET */}
            <TouchableOpacity
              style={styles.moreButton}
              accessibilityLabel="More options"
            >
              <Text style={styles.moreIcon}>⋯</Text>
            </TouchableOpacity>
          </View>

          {/* Post Content */}
          <Text style={styles.postContent}>{post.content}</Text>

          {/* Action Buttons - SMALL TOUCH TARGETS */}
          <View style={styles.actionsContainer}>
            {/* Like Button - SMALL TOUCH TARGET */}
            <TouchableOpacity
              style={styles.actionButton}
              accessibilityLabel="Like"
            >
              <Text style={styles.actionIcon}>👍</Text>
              <Text style={styles.actionCount}>{post.likes}</Text>
            </TouchableOpacity>

            {/* Comment Button - SMALL TOUCH TARGET */}
            <TouchableOpacity
              style={styles.actionButton}
              accessibilityLabel="Comment"
            >
              <Text style={styles.actionIcon}>💬</Text>
              <Text style={styles.actionCount}>{post.comments}</Text>
            </TouchableOpacity>

            {/* Share Button - SMALL TOUCH TARGET */}
            <TouchableOpacity
              style={styles.actionButton}
              accessibilityLabel="Share"
            >
              <Text style={styles.actionIcon}>📤</Text>
              <Text style={styles.actionCount}>{post.shares}</Text>
            </TouchableOpacity>
          </View>
        </View>
      ))}
    </ScrollView>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#F5F5F5',
  },
  header: {
    flexDirection: 'row',
    backgroundColor: '#1976D2',
    padding: 16,
    alignItems: 'center',
    justifyContent: 'space-between',
  },
  headerTitle: {
    fontSize: 24,
    fontWeight: 'bold',
    color: '#FFFFFF',
  },
  notificationButton: {
    width: 20, // TOO SMALL: Only 20dp touch target
    height: 20, // TOO SMALL: Only 20dp touch target
    justifyContent: 'center',
    alignItems: 'center',
  },
  notificationIcon: {
    fontSize: 16,
    color: '#FFFFFF',
  },
  postCard: {
    backgroundColor: '#FFFFFF',
    margin: 16,
    padding: 16,
    borderRadius: 12,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.1,
    shadowRadius: 4,
    elevation: 2,
  },
  userInfo: {
    flexDirection: 'row',
    alignItems: 'center',
    marginBottom: 12,
  },
  profilePic: {
    width: 40,
    height: 40,
    borderRadius: 20,
    backgroundColor: '#E0E0E0',
    justifyContent: 'center',
    alignItems: 'center',
    marginRight: 12,
  },
  profileIcon: {
    fontSize: 20,
    color: '#666666',
  },
  userDetails: {
    flex: 1,
  },
  username: {
    fontSize: 16,
    fontWeight: '600',
    marginBottom: 2,
  },
  timestamp: {
    fontSize: 14,
    color: '#666666',
  },
  moreButton: {
    width: 20, // TOO SMALL: Only 20dp touch target
    height: 20, // TOO SMALL: Only 20dp touch target
    justifyContent: 'center',
    alignItems: 'center',
  },
  moreIcon: {
    fontSize: 16,
    color: '#666666',
  },
  postContent: {
    fontSize: 16,
    lineHeight: 24,
    marginBottom: 16,
  },
  actionsContainer: {
    flexDirection: 'row',
    justifyContent: 'space-between',
  },
  actionButton: {
    flexDirection: 'row',
    alignItems: 'center',
    paddingVertical: 8,
    paddingHorizontal: 12,
    minWidth: 24, // TOO SMALL: Only 24dp touch target
    minHeight: 24, // TOO SMALL: Only 24dp touch target
  },
  actionIcon: {
    fontSize: 18,
    marginRight: 4,
  },
  actionCount: {
    fontSize: 14,
    color: '#666666',
  },
});

export default SmallTouchTarget;

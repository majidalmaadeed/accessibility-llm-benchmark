<template>
  <div class="social-media-feed">
    <div class="feed-header">
      <h1>Social Media Feed</h1>
      <div class="header-actions">
        <button @click="showNotifications = !showNotifications" class="notification-btn">
          🔔
          <span v-if="unreadNotifications > 0" class="notification-badge">{{ unreadNotifications }}</span>
        </button>
        <button @click="showUserMenu = !showUserMenu" class="user-menu-btn">
          <img :src="currentUser.avatar" :alt="currentUser.name" class="user-avatar" />
        </button>
      </div>
    </div>

    <div class="feed-container">
      <div class="feed-sidebar">
        <div class="user-profile">
          <img :src="currentUser.avatar" :alt="currentUser.name" class="profile-avatar" />
          <h3>{{ currentUser.name }}</h3>
          <p>{{ currentUser.bio }}</p>
          <div class="profile-stats">
            <div class="stat">
              <span class="stat-number">{{ currentUser.followers }}</span>
              <span class="stat-label">Followers</span>
            </div>
            <div class="stat">
              <span class="stat-number">{{ currentUser.following }}</span>
              <span class="stat-label">Following</span>
            </div>
          </div>
        </div>

        <div class="trending-section">
          <h4>Trending</h4>
          <div class="trending-list">
            <div v-for="trend in trendingTopics" :key="trend.id" class="trending-item">
              <span class="trending-tag">#{{ trend.tag }}</span>
              <span class="trending-count">{{ trend.posts }} posts</span>
            </div>
          </div>
        </div>
      </div>

      <div class="feed-main">
        <div class="create-post">
          <div class="post-input-container">
            <img :src="currentUser.avatar" :alt="currentUser.name" class="input-avatar" />
            <textarea
              v-model="newPostContent"
              placeholder="What's on your mind?"
              class="post-input"
              rows="3"
            ></textarea>
          </div>
          <div class="post-actions">
            <button @click="showMediaUpload = !showMediaUpload" class="media-btn">
              📷 Add Photo/Video
            </button>
            <button @click="showEmojiPicker = !showEmojiPicker" class="emoji-btn">
              😊 Emoji
            </button>
            <button @click="handlePostSubmit" :disabled="!newPostContent.trim()" class="post-btn">
              Post
            </button>
          </div>
        </div>

        <div v-if="showMediaUpload" class="media-upload-panel">
          <div class="upload-options">
            <button class="upload-option">📷 Camera</button>
            <button class="upload-option">📁 Gallery</button>
            <button class="upload-option">🎥 Video</button>
          </div>
        </div>

        <div v-if="showEmojiPicker" class="emoji-picker">
          <div class="emoji-grid">
            <button
              v-for="emoji in emojis"
              :key="emoji"
              @click="addEmoji(emoji)"
              class="emoji-btn"
            >
              {{ emoji }}
            </button>
          </div>
        </div>

        <div class="posts-container">
          <div v-if="isLoading" class="loading-posts">
            <div class="loading-spinner"></div>
            <span>Loading posts...</span>
          </div>

          <div v-else class="posts-list">
            <div
              v-for="post in paginatedPosts"
              :key="post.id"
              class="post-card"
            >
              <div class="post-header">
                <div class="post-author">
                  <img :src="post.author.avatar" :alt="post.author.name" class="author-avatar" />
                  <div class="author-info">
                    <h4>{{ post.author.name }}</h4>
                    <span class="post-time">{{ formatTime(post.timestamp) }}</span>
                  </div>
                </div>
                <button @click="showPostMenu(post.id)" class="post-menu-btn">⋯</button>
              </div>

              <div class="post-content">
                <p>{{ post.content }}</p>
                <div v-if="post.media" class="post-media">
                  <img :src="post.media.url" :alt="post.media.alt" class="post-image" />
                </div>
              </div>

              <div class="post-stats">
                <span v-if="post.likes > 0" class="like-count">{{ post.likes }} likes</span>
                <span v-if="post.comments > 0" class="comment-count">{{ post.comments }} comments</span>
                <span v-if="post.shares > 0" class="share-count">{{ post.shares }} shares</span>
              </div>

              <div class="post-actions">
                <button
                  @click="toggleLike(post.id)"
                  :class="`action-btn like-btn ${post.isLiked ? 'liked' : ''}`"
                >
                  {{ post.isLiked ? '❤️' : '🤍' }} Like
                </button>
                <button @click="showComments(post.id)" class="action-btn comment-btn">
                  💬 Comment
                </button>
                <button @click="sharePost(post.id)" class="action-btn share-btn">
                  🔄 Share
                </button>
                <button @click="savePost(post.id)" class="action-btn save-btn">
                  {{ post.isSaved ? '🔖' : '🔖' }} Save
                </button>
              </div>

              <div v-if="post.showComments" class="comments-section">
                <div class="comment-input">
                  <img :src="currentUser.avatar" :alt="currentUser.name" class="comment-avatar" />
                  <input
                    type="text"
                    v-model="post.newComment"
                    placeholder="Write a comment..."
                    class="comment-input-field"
                    @keyup.enter="addComment(post.id)"
                  />
                  <button @click="addComment(post.id)" class="comment-submit">Post</button>
                </div>
                
                <div class="comments-list">
                  <div
                    v-for="comment in post.comments"
                    :key="comment.id"
                    class="comment-item"
                  >
                    <img :src="comment.author.avatar" :alt="comment.author.name" class="comment-avatar" />
                    <div class="comment-content">
                      <div class="comment-header">
                        <span class="comment-author">{{ comment.author.name }}</span>
                        <span class="comment-time">{{ formatTime(comment.timestamp) }}</span>
                      </div>
                      <p class="comment-text">{{ comment.text }}</p>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>

          <div v-if="hasMorePosts" class="load-more">
            <button @click="loadMorePosts" :disabled="isLoadingMore" class="load-more-btn">
              {{ isLoadingMore ? 'Loading...' : 'Load More Posts' }}
            </button>
          </div>
        </div>
      </div>
    </div>

    <!-- Notifications Panel -->
    <div v-if="showNotifications" class="notifications-panel">
      <div class="notifications-header">
        <h3>Notifications</h3>
        <button @click="markAllAsRead" class="mark-read-btn">Mark all as read</button>
      </div>
      <div class="notifications-list">
        <div
          v-for="notification in notifications"
          :key="notification.id"
          :class="`notification-item ${notification.isRead ? 'read' : 'unread'}`"
        >
          <img :src="notification.user.avatar" :alt="notification.user.name" class="notification-avatar" />
          <div class="notification-content">
            <p>{{ notification.message }}</p>
            <span class="notification-time">{{ formatTime(notification.timestamp) }}</span>
          </div>
        </div>
      </div>
    </div>

    <!-- User Menu -->
    <div v-if="showUserMenu" class="user-menu-panel">
      <div class="menu-item" @click="showProfile">👤 Profile</div>
      <div class="menu-item" @click="showSettings">⚙️ Settings</div>
      <div class="menu-item" @click="showHelp">❓ Help</div>
      <div class="menu-item" @click="logout">🚪 Logout</div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'SocialMediaFeed',
  data() {
    return {
      currentUser: {
        name: 'John Doe',
        avatar: 'https://via.placeholder.com/40x40/4caf50/fff?text=JD',
        bio: 'Software Developer & Coffee Enthusiast',
        followers: 1250,
        following: 340
      },
      newPostContent: '',
      showMediaUpload: false,
      showEmojiPicker: false,
      showNotifications: false,
      showUserMenu: false,
      isLoading: false,
      isLoadingMore: false,
      hasMorePosts: true,
      currentPage: 1,
      postsPerPage: 5,
      unreadNotifications: 3,
      posts: [
        {
          id: 1,
          author: {
            name: 'Sarah Wilson',
            avatar: 'https://via.placeholder.com/40x40/2196f3/fff?text=SW'
          },
          content: 'Just finished an amazing hike in the mountains! The view was absolutely breathtaking. Nature never fails to amaze me. #hiking #nature #mountains',
          timestamp: new Date(Date.now() - 2 * 60 * 60 * 1000),
          likes: 24,
          comments: 8,
          shares: 3,
          isLiked: false,
          isSaved: false,
          showComments: false,
          newComment: '',
          media: {
            url: 'https://via.placeholder.com/500x300/4caf50/fff?text=Mountain+View',
            alt: 'Mountain view from hiking trail'
          },
          comments: [
            {
              id: 1,
              author: {
                name: 'Mike Johnson',
                avatar: 'https://via.placeholder.com/30x30/ff9800/fff?text=MJ'
              },
              text: 'Wow, that looks incredible! Where is this?',
              timestamp: new Date(Date.now() - 1 * 60 * 60 * 1000)
            },
            {
              id: 2,
              author: {
                name: 'Emma Davis',
                avatar: 'https://via.placeholder.com/30x30/9c27b0/fff?text=ED'
              },
              text: 'I need to go there! The colors are amazing.',
              timestamp: new Date(Date.now() - 30 * 60 * 1000)
            }
          ]
        },
        {
          id: 2,
          author: {
            name: 'Alex Chen',
            avatar: 'https://via.placeholder.com/40x40/f44336/fff?text=AC'
          },
          content: 'Working on a new project and feeling inspired! Sometimes the best ideas come at 2 AM. Who else is a night owl? 🦉 #coding #inspiration #nightowl',
          timestamp: new Date(Date.now() - 4 * 60 * 60 * 1000),
          likes: 18,
          comments: 5,
          shares: 2,
          isLiked: true,
          isSaved: false,
          showComments: false,
          newComment: '',
          media: null,
          comments: []
        },
        {
          id: 3,
          author: {
            name: 'Lisa Rodriguez',
            avatar: 'https://via.placeholder.com/40x40/8bc34a/fff?text=LR'
          },
          content: 'Coffee and code - the perfect combination for a productive day! ☕️ What\'s your favorite coding beverage?',
          timestamp: new Date(Date.now() - 6 * 60 * 60 * 1000),
          likes: 31,
          comments: 12,
          shares: 4,
          isLiked: false,
          isSaved: true,
          showComments: false,
          newComment: '',
          media: {
            url: 'https://via.placeholder.com/500x300/8bc34a/fff?text=Coffee+&+Code',
            alt: 'Coffee cup next to laptop'
          },
          comments: [
            {
              id: 3,
              author: {
                name: 'David Kim',
                avatar: 'https://via.placeholder.com/30x30/607d8b/fff?text=DK'
              },
              text: 'Tea for me! Green tea keeps me focused.',
              timestamp: new Date(Date.now() - 5 * 60 * 60 * 1000)
            }
          ]
        }
      ],
      notifications: [
        {
          id: 1,
          user: {
            name: 'Sarah Wilson',
            avatar: 'https://via.placeholder.com/30x30/2196f3/fff?text=SW'
          },
          message: 'liked your post',
          timestamp: new Date(Date.now() - 30 * 60 * 1000),
          isRead: false
        },
        {
          id: 2,
          user: {
            name: 'Mike Johnson',
            avatar: 'https://via.placeholder.com/30x30/ff9800/fff?text=MJ'
          },
          message: 'commented on your photo',
          timestamp: new Date(Date.now() - 2 * 60 * 60 * 1000),
          isRead: false
        },
        {
          id: 3,
          user: {
            name: 'Emma Davis',
            avatar: 'https://via.placeholder.com/30x30/9c27b0/fff?text=ED'
          },
          message: 'started following you',
          timestamp: new Date(Date.now() - 4 * 60 * 60 * 1000),
          isRead: true
        }
      ],
      trendingTopics: [
        { id: 1, tag: 'coding', posts: 1250 },
        { id: 2, tag: 'nature', posts: 890 },
        { id: 3, tag: 'coffee', posts: 650 },
        { id: 4, tag: 'hiking', posts: 420 },
        { id: 5, tag: 'inspiration', posts: 380 }
      ],
      emojis: ['😀', '😂', '😍', '🤔', '👍', '👏', '🎉', '🔥', '💯', '❤️', '😊', '😎', '🤩', '😢', '😡', '🤯']
    }
  },
  computed: {
    paginatedPosts() {
      const startIndex = (this.currentPage - 1) * this.postsPerPage;
      return this.posts.slice(0, startIndex + this.postsPerPage);
    }
  },
  methods: {
    handlePostSubmit() {
      if (!this.newPostContent.trim()) return;

      const newPost = {
        id: Date.now(),
        author: this.currentUser,
        content: this.newPostContent,
        timestamp: new Date(),
        likes: 0,
        comments: 0,
        shares: 0,
        isLiked: false,
        isSaved: false,
        showComments: false,
        newComment: '',
        media: null,
        comments: []
      };

      this.posts.unshift(newPost);
      this.newPostContent = '';
    },
    toggleLike(postId) {
      const post = this.posts.find(p => p.id === postId);
      if (post) {
        post.isLiked = !post.isLiked;
        post.likes += post.isLiked ? 1 : -1;
      }
    },
    showComments(postId) {
      const post = this.posts.find(p => p.id === postId);
      if (post) {
        post.showComments = !post.showComments;
      }
    },
    addComment(postId) {
      const post = this.posts.find(p => p.id === postId);
      if (post && post.newComment.trim()) {
        const newComment = {
          id: Date.now(),
          author: this.currentUser,
          text: post.newComment,
          timestamp: new Date()
        };
        post.comments.push(newComment);
        post.comments++;
        post.newComment = '';
      }
    },
    sharePost(postId) {
      const post = this.posts.find(p => p.id === postId);
      if (post) {
        post.shares++;
        console.log('Sharing post:', post.content);
      }
    },
    savePost(postId) {
      const post = this.posts.find(p => p.id === postId);
      if (post) {
        post.isSaved = !post.isSaved;
        console.log('Post saved:', post.isSaved);
      }
    },
    showPostMenu(postId) {
      console.log('Show menu for post:', postId);
    },
    addEmoji(emoji) {
      this.newPostContent += emoji;
      this.showEmojiPicker = false;
    },
    loadMorePosts() {
      this.isLoadingMore = true;
      setTimeout(() => {
        this.currentPage++;
        this.isLoadingMore = false;
        if (this.currentPage * this.postsPerPage >= this.posts.length) {
          this.hasMorePosts = false;
        }
      }, 1000);
    },
    markAllAsRead() {
      this.notifications.forEach(notification => {
        notification.isRead = true;
      });
      this.unreadNotifications = 0;
    },
    formatTime(timestamp) {
      const now = new Date();
      const diff = now - timestamp;
      const minutes = Math.floor(diff / (1000 * 60));
      const hours = Math.floor(diff / (1000 * 60 * 60));
      const days = Math.floor(diff / (1000 * 60 * 60 * 24));

      if (minutes < 60) {
        return `${minutes}m ago`;
      } else if (hours < 24) {
        return `${hours}h ago`;
      } else {
        return `${days}d ago`;
      }
    },
    showProfile() {
      console.log('Show profile');
      this.showUserMenu = false;
    },
    showSettings() {
      console.log('Show settings');
      this.showUserMenu = false;
    },
    showHelp() {
      console.log('Show help');
      this.showUserMenu = false;
    },
    logout() {
      console.log('Logout');
      this.showUserMenu = false;
    }
  }
}
</script>

<style scoped>
.social-media-feed {
  max-width: 1200px;
  margin: 0 auto;
  padding: 20px;
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
}

.feed-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 25px;
  padding-bottom: 15px;
  border-bottom: 2px solid #e0e0e0;
}

.feed-header h1 {
  margin: 0;
  color: #333;
  font-size: 28px;
}

.header-actions {
  display: flex;
  align-items: center;
  gap: 15px;
}

.notification-btn {
  position: relative;
  background: none;
  border: none;
  font-size: 24px;
  cursor: pointer;
  padding: 8px;
  border-radius: 50%;
  transition: background-color 0.3s ease;
}

.notification-btn:hover {
  background: #f5f5f5;
}

.notification-badge {
  position: absolute;
  top: 0;
  right: 0;
  background: #f44336;
  color: white;
  border-radius: 50%;
  width: 20px;
  height: 20px;
  font-size: 12px;
  display: flex;
  align-items: center;
  justify-content: center;
  font-weight: bold;
}

.user-menu-btn {
  background: none;
  border: none;
  cursor: pointer;
  padding: 4px;
  border-radius: 50%;
  transition: background-color 0.3s ease;
}

.user-menu-btn:hover {
  background: #f5f5f5;
}

.user-avatar {
  width: 40px;
  height: 40px;
  border-radius: 50%;
  object-fit: cover;
}

.feed-container {
  display: grid;
  grid-template-columns: 300px 1fr;
  gap: 25px;
}

.feed-sidebar {
  background: #f8f9fa;
  border-radius: 8px;
  padding: 20px;
  height: fit-content;
}

.user-profile {
  text-align: center;
  margin-bottom: 25px;
  padding-bottom: 20px;
  border-bottom: 1px solid #e0e0e0;
}

.profile-avatar {
  width: 80px;
  height: 80px;
  border-radius: 50%;
  object-fit: cover;
  margin-bottom: 15px;
}

.user-profile h3 {
  margin: 0 0 8px 0;
  color: #333;
  font-size: 18px;
}

.user-profile p {
  margin: 0 0 15px 0;
  color: #666;
  font-size: 14px;
  line-height: 1.4;
}

.profile-stats {
  display: flex;
  justify-content: space-around;
}

.stat {
  text-align: center;
}

.stat-number {
  display: block;
  font-size: 18px;
  font-weight: 600;
  color: #333;
}

.stat-label {
  font-size: 12px;
  color: #666;
  text-transform: uppercase;
  letter-spacing: 0.5px;
}

.trending-section h4 {
  margin: 0 0 15px 0;
  color: #333;
  font-size: 16px;
  font-weight: 600;
}

.trending-list {
  display: flex;
  flex-direction: column;
  gap: 8px;
}

.trending-item {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 8px 12px;
  background: white;
  border-radius: 6px;
  border: 1px solid #e0e0e0;
}

.trending-tag {
  color: #4caf50;
  font-weight: 600;
  font-size: 14px;
}

.trending-count {
  font-size: 12px;
  color: #666;
}

.feed-main {
  background: white;
  border-radius: 8px;
  box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
  overflow: hidden;
}

.create-post {
  padding: 20px;
  border-bottom: 1px solid #e0e0e0;
}

.post-input-container {
  display: flex;
  gap: 12px;
  margin-bottom: 15px;
}

.input-avatar {
  width: 40px;
  height: 40px;
  border-radius: 50%;
  object-fit: cover;
}

.post-input {
  flex: 1;
  border: none;
  outline: none;
  resize: none;
  font-size: 16px;
  line-height: 1.4;
  color: #333;
  font-family: inherit;
}

.post-input::placeholder {
  color: #999;
}

.post-actions {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.media-btn,
.emoji-btn {
  background: none;
  border: none;
  color: #666;
  cursor: pointer;
  padding: 8px 12px;
  border-radius: 6px;
  font-size: 14px;
  transition: background-color 0.3s ease;
}

.media-btn:hover,
.emoji-btn:hover {
  background: #f5f5f5;
}

.post-btn {
  padding: 8px 20px;
  background: #4caf50;
  color: white;
  border: none;
  border-radius: 6px;
  cursor: pointer;
  font-size: 14px;
  font-weight: 600;
  transition: background-color 0.3s ease;
}

.post-btn:hover:not(:disabled) {
  background: #45a049;
}

.post-btn:disabled {
  background: #ccc;
  cursor: not-allowed;
}

.media-upload-panel,
.emoji-picker {
  padding: 15px 20px;
  background: #f8f9fa;
  border-bottom: 1px solid #e0e0e0;
}

.upload-options {
  display: flex;
  gap: 10px;
}

.upload-option {
  padding: 8px 16px;
  background: white;
  border: 1px solid #ddd;
  border-radius: 6px;
  cursor: pointer;
  font-size: 14px;
  color: #333;
  transition: all 0.3s ease;
}

.upload-option:hover {
  background: #4caf50;
  color: white;
  border-color: #4caf50;
}

.emoji-grid {
  display: grid;
  grid-template-columns: repeat(8, 1fr);
  gap: 8px;
}

.emoji-btn {
  background: white;
  border: 1px solid #e0e0e0;
  border-radius: 4px;
  cursor: pointer;
  font-size: 18px;
  padding: 8px;
  transition: all 0.3s ease;
}

.emoji-btn:hover {
  background: #f5f5f5;
  transform: scale(1.1);
}

.posts-container {
  max-height: 600px;
  overflow-y: auto;
}

.loading-posts {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  padding: 40px;
  color: #666;
}

.loading-spinner {
  width: 30px;
  height: 30px;
  border: 3px solid rgba(76, 175, 80, 0.3);
  border-top: 3px solid #4caf50;
  border-radius: 50%;
  animation: spin 1s linear infinite;
  margin-bottom: 15px;
}

@keyframes spin {
  0% { transform: rotate(0deg); }
  100% { transform: rotate(360deg); }
}

.posts-list {
  display: flex;
  flex-direction: column;
}

.post-card {
  padding: 20px;
  border-bottom: 1px solid #e0e0e0;
}

.post-card:last-child {
  border-bottom: none;
}

.post-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 15px;
}

.post-author {
  display: flex;
  align-items: center;
  gap: 12px;
}

.author-avatar {
  width: 40px;
  height: 40px;
  border-radius: 50%;
  object-fit: cover;
}

.author-info h4 {
  margin: 0 0 2px 0;
  color: #333;
  font-size: 16px;
  font-weight: 600;
}

.post-time {
  font-size: 12px;
  color: #666;
}

.post-menu-btn {
  background: none;
  border: none;
  font-size: 20px;
  cursor: pointer;
  color: #666;
  padding: 4px;
  border-radius: 50%;
  transition: background-color 0.3s ease;
}

.post-menu-btn:hover {
  background: #f5f5f5;
}

.post-content {
  margin-bottom: 15px;
}

.post-content p {
  margin: 0 0 15px 0;
  color: #333;
  line-height: 1.5;
  font-size: 15px;
}

.post-media {
  margin-top: 15px;
}

.post-image {
  width: 100%;
  max-width: 500px;
  border-radius: 8px;
  object-fit: cover;
}

.post-stats {
  display: flex;
  gap: 15px;
  margin-bottom: 10px;
  font-size: 12px;
  color: #666;
}

.post-actions {
  display: flex;
  gap: 20px;
  padding-top: 10px;
  border-top: 1px solid #f0f0f0;
}

.action-btn {
  background: none;
  border: none;
  cursor: pointer;
  font-size: 14px;
  color: #666;
  padding: 8px 12px;
  border-radius: 6px;
  transition: all 0.3s ease;
  display: flex;
  align-items: center;
  gap: 5px;
}

.action-btn:hover {
  background: #f5f5f5;
}

.like-btn.liked {
  color: #f44336;
}

.comments-section {
  margin-top: 15px;
  padding-top: 15px;
  border-top: 1px solid #f0f0f0;
}

.comment-input {
  display: flex;
  align-items: center;
  gap: 10px;
  margin-bottom: 15px;
}

.comment-avatar {
  width: 30px;
  height: 30px;
  border-radius: 50%;
  object-fit: cover;
}

.comment-input-field {
  flex: 1;
  padding: 8px 12px;
  border: 1px solid #e0e0e0;
  border-radius: 20px;
  outline: none;
  font-size: 14px;
}

.comment-input-field:focus {
  border-color: #4caf50;
}

.comment-submit {
  padding: 8px 16px;
  background: #4caf50;
  color: white;
  border: none;
  border-radius: 20px;
  cursor: pointer;
  font-size: 14px;
  font-weight: 600;
  transition: background-color 0.3s ease;
}

.comment-submit:hover {
  background: #45a049;
}

.comments-list {
  display: flex;
  flex-direction: column;
  gap: 10px;
}

.comment-item {
  display: flex;
  gap: 10px;
}

.comment-content {
  flex: 1;
}

.comment-header {
  display: flex;
  align-items: center;
  gap: 8px;
  margin-bottom: 4px;
}

.comment-author {
  font-size: 14px;
  font-weight: 600;
  color: #333;
}

.comment-time {
  font-size: 12px;
  color: #666;
}

.comment-text {
  margin: 0;
  font-size: 14px;
  color: #333;
  line-height: 1.4;
}

.load-more {
  padding: 20px;
  text-align: center;
  border-top: 1px solid #e0e0e0;
}

.load-more-btn {
  padding: 10px 20px;
  background: #4caf50;
  color: white;
  border: none;
  border-radius: 6px;
  cursor: pointer;
  font-size: 14px;
  font-weight: 600;
  transition: background-color 0.3s ease;
}

.load-more-btn:hover:not(:disabled) {
  background: #45a049;
}

.load-more-btn:disabled {
  background: #ccc;
  cursor: not-allowed;
}

.notifications-panel {
  position: fixed;
  top: 80px;
  right: 20px;
  background: white;
  border: 1px solid #e0e0e0;
  border-radius: 8px;
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.2);
  z-index: 1000;
  width: 350px;
  max-height: 400px;
  overflow: hidden;
}

.notifications-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 15px 20px;
  background: #f8f9fa;
  border-bottom: 1px solid #e0e0e0;
}

.notifications-header h3 {
  margin: 0;
  color: #333;
  font-size: 16px;
}

.mark-read-btn {
  background: none;
  border: none;
  color: #4caf50;
  cursor: pointer;
  font-size: 12px;
  font-weight: 600;
  text-transform: uppercase;
  letter-spacing: 0.5px;
}

.notifications-list {
  max-height: 300px;
  overflow-y: auto;
}

.notification-item {
  display: flex;
  gap: 12px;
  padding: 15px 20px;
  border-bottom: 1px solid #f0f0f0;
  transition: background-color 0.3s ease;
}

.notification-item:hover {
  background: #f8f9fa;
}

.notification-item.unread {
  background: #e3f2fd;
}

.notification-avatar {
  width: 30px;
  height: 30px;
  border-radius: 50%;
  object-fit: cover;
}

.notification-content {
  flex: 1;
}

.notification-content p {
  margin: 0 0 4px 0;
  font-size: 14px;
  color: #333;
}

.notification-time {
  font-size: 12px;
  color: #666;
}

.user-menu-panel {
  position: fixed;
  top: 80px;
  right: 20px;
  background: white;
  border: 1px solid #e0e0e0;
  border-radius: 8px;
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.2);
  z-index: 1000;
  min-width: 200px;
  overflow: hidden;
}

.menu-item {
  padding: 12px 20px;
  cursor: pointer;
  font-size: 14px;
  color: #333;
  transition: background-color 0.3s ease;
  border-bottom: 1px solid #f0f0f0;
}

.menu-item:hover {
  background: #f8f9fa;
}

.menu-item:last-child {
  border-bottom: none;
}

@media (max-width: 968px) {
  .feed-container {
    grid-template-columns: 1fr;
    gap: 20px;
  }
  
  .feed-sidebar {
    order: 2;
  }
  
  .feed-main {
    order: 1;
  }
}

@media (max-width: 768px) {
  .social-media-feed {
    padding: 15px;
  }
  
  .feed-header {
    flex-direction: column;
    gap: 15px;
    align-items: stretch;
  }
  
  .header-actions {
    justify-content: center;
  }
  
  .feed-sidebar {
    padding: 15px;
  }
  
  .user-profile {
    margin-bottom: 20px;
    padding-bottom: 15px;
  }
  
  .profile-avatar {
    width: 60px;
    height: 60px;
  }
  
  .user-profile h3 {
    font-size: 16px;
  }
  
  .user-profile p {
    font-size: 13px;
  }
  
  .stat-number {
    font-size: 16px;
  }
  
  .stat-label {
    font-size: 11px;
  }
  
  .create-post {
    padding: 15px;
  }
  
  .post-input-container {
    gap: 10px;
  }
  
  .input-avatar {
    width: 35px;
    height: 35px;
  }
  
  .post-input {
    font-size: 15px;
  }
  
  .post-actions {
    flex-wrap: wrap;
    gap: 10px;
  }
  
  .media-btn,
  .emoji-btn {
    padding: 6px 10px;
    font-size: 13px;
  }
  
  .post-btn {
    padding: 6px 16px;
    font-size: 13px;
  }
  
  .upload-options {
    flex-wrap: wrap;
    gap: 8px;
  }
  
  .upload-option {
    padding: 6px 12px;
    font-size: 13px;
  }
  
  .emoji-grid {
    grid-template-columns: repeat(6, 1fr);
    gap: 6px;
  }
  
  .emoji-btn {
    font-size: 16px;
    padding: 6px;
  }
  
  .post-card {
    padding: 15px;
  }
  
  .author-avatar {
    width: 35px;
    height: 35px;
  }
  
  .author-info h4 {
    font-size: 15px;
  }
  
  .post-time {
    font-size: 11px;
  }
  
  .post-content p {
    font-size: 14px;
  }
  
  .post-stats {
    gap: 12px;
    font-size: 11px;
  }
  
  .post-actions {
    gap: 15px;
  }
  
  .action-btn {
    font-size: 13px;
    padding: 6px 10px;
  }
  
  .comment-avatar {
    width: 25px;
    height: 25px;
  }
  
  .comment-input-field {
    font-size: 13px;
    padding: 6px 10px;
  }
  
  .comment-submit {
    padding: 6px 12px;
    font-size: 13px;
  }
  
  .comment-author {
    font-size: 13px;
  }
  
  .comment-time {
    font-size: 11px;
  }
  
  .comment-text {
    font-size: 13px;
  }
  
  .notifications-panel,
  .user-menu-panel {
    right: 10px;
    width: 300px;
  }
  
  .notifications-header {
    padding: 12px 15px;
  }
  
  .notifications-header h3 {
    font-size: 15px;
  }
  
  .notification-item {
    padding: 12px 15px;
  }
  
  .notification-avatar {
    width: 25px;
    height: 25px;
  }
  
  .notification-content p {
    font-size: 13px;
  }
  
  .notification-time {
    font-size: 11px;
  }
  
  .menu-item {
    padding: 10px 15px;
    font-size: 13px;
  }
}

@media (max-width: 480px) {
  .social-media-feed {
    padding: 10px;
  }
  
  .feed-header h1 {
    font-size: 24px;
  }
  
  .feed-sidebar {
    padding: 12px;
  }
  
  .user-profile {
    margin-bottom: 15px;
    padding-bottom: 12px;
  }
  
  .profile-avatar {
    width: 50px;
    height: 50px;
  }
  
  .user-profile h3 {
    font-size: 15px;
  }
  
  .user-profile p {
    font-size: 12px;
  }
  
  .stat-number {
    font-size: 14px;
  }
  
  .stat-label {
    font-size: 10px;
  }
  
  .trending-section h4 {
    font-size: 14px;
  }
  
  .trending-item {
    padding: 6px 10px;
  }
  
  .trending-tag {
    font-size: 13px;
  }
  
  .trending-count {
    font-size: 11px;
  }
  
  .create-post {
    padding: 12px;
  }
  
  .post-input-container {
    gap: 8px;
  }
  
  .input-avatar {
    width: 30px;
    height: 30px;
  }
  
  .post-input {
    font-size: 14px;
  }
  
  .post-actions {
    flex-direction: column;
    gap: 8px;
    align-items: stretch;
  }
  
  .media-btn,
  .emoji-btn {
    padding: 8px 12px;
    font-size: 12px;
    text-align: center;
  }
  
  .post-btn {
    padding: 8px 16px;
    font-size: 12px;
  }
  
  .upload-options {
    flex-direction: column;
    gap: 6px;
  }
  
  .upload-option {
    padding: 8px 12px;
    font-size: 12px;
    text-align: center;
  }
  
  .emoji-grid {
    grid-template-columns: repeat(5, 1fr);
    gap: 4px;
  }
  
  .emoji-btn {
    font-size: 14px;
    padding: 4px;
  }
  
  .post-card {
    padding: 12px;
  }
  
  .author-avatar {
    width: 30px;
    height: 30px;
  }
  
  .author-info h4 {
    font-size: 14px;
  }
  
  .post-time {
    font-size: 10px;
  }
  
  .post-content p {
    font-size: 13px;
  }
  
  .post-stats {
    gap: 10px;
    font-size: 10px;
  }
  
  .post-actions {
    gap: 12px;
    flex-wrap: wrap;
  }
  
  .action-btn {
    font-size: 12px;
    padding: 4px 8px;
    flex: 1;
    justify-content: center;
  }
  
  .comment-avatar {
    width: 20px;
    height: 20px;
  }
  
  .comment-input-field {
    font-size: 12px;
    padding: 4px 8px;
  }
  
  .comment-submit {
    padding: 4px 10px;
    font-size: 12px;
  }
  
  .comment-author {
    font-size: 12px;
  }
  
  .comment-time {
    font-size: 10px;
  }
  
  .comment-text {
    font-size: 12px;
  }
  
  .notifications-panel,
  .user-menu-panel {
    right: 5px;
    width: 280px;
  }
  
  .notifications-header {
    padding: 10px 12px;
  }
  
  .notifications-header h3 {
    font-size: 14px;
  }
  
  .mark-read-btn {
    font-size: 11px;
  }
  
  .notification-item {
    padding: 10px 12px;
  }
  
  .notification-avatar {
    width: 20px;
    height: 20px;
  }
  
  .notification-content p {
    font-size: 12px;
  }
  
  .notification-time {
    font-size: 10px;
  }
  
  .menu-item {
    padding: 8px 12px;
    font-size: 12px;
  }
}
</style>

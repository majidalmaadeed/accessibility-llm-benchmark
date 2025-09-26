import React, { useState, useEffect, useRef } from 'react';
import './SocialMediaFeed.css';

const SocialMediaFeed = () => {
  const [posts, setPosts] = useState([
    {
      id: 1,
      user: {
        name: 'Sarah Johnson',
        username: '@sarahj',
        avatar: 'https://via.placeholder.com/40x40/4caf50/fff?text=SJ',
        verified: true
      },
      content: 'Just finished an amazing hike in the mountains! The view was absolutely breathtaking. Nature never fails to amaze me. 🏔️ #hiking #nature #adventure',
      image: 'https://via.placeholder.com/500x300/8bc34a/fff?text=Mountain+View',
      timestamp: new Date(Date.now() - 2 * 60 * 60 * 1000), // 2 hours ago
      likes: 42,
      comments: 8,
      shares: 3,
      isLiked: false,
      isBookmarked: false
    },
    {
      id: 2,
      user: {
        name: 'Tech News Daily',
        username: '@technews',
        avatar: 'https://via.placeholder.com/40x40/2196f3/fff?text=TN',
        verified: true
      },
      content: 'Breaking: New AI breakthrough in natural language processing could revolutionize how we interact with computers. The implications are enormous for accessibility and user experience.',
      image: null,
      timestamp: new Date(Date.now() - 4 * 60 * 60 * 1000), // 4 hours ago
      likes: 156,
      comments: 23,
      shares: 45,
      isLiked: false,
      isBookmarked: false
    },
    {
      id: 3,
      user: {
        name: 'Mike Chen',
        username: '@mikechen',
        avatar: 'https://via.placeholder.com/40x40/ff9800/fff?text=MC',
        verified: false
      },
      content: 'Working on a new project that I\'m really excited about. Can\'t wait to share more details soon! 💻 #coding #webdev #excited',
      image: 'https://via.placeholder.com/500x300/9c27b0/fff?text=Code+Editor',
      timestamp: new Date(Date.now() - 6 * 60 * 60 * 1000), // 6 hours ago
      likes: 28,
      comments: 5,
      shares: 2,
      isLiked: true,
      isBookmarked: true
    }
  ]);

  const [newPost, setNewPost] = useState('');
  const [showCompose, setShowCompose] = useState(false);
  const [notifications, setNotifications] = useState([]);
  const [showNotifications, setShowNotifications] = useState(false);
  const [showUserMenu, setShowUserMenu] = useState(false);
  const [infiniteScrollLoading, setInfiniteScrollLoading] = useState(false);
  const [hasMorePosts, setHasMorePosts] = useState(true);
  const feedRef = useRef(null);
  const [showCommentModal, setShowCommentModal] = useState(null);

  const currentUser = {
    name: 'John Doe',
    username: '@johndoe',
    avatar: 'https://via.placeholder.com/40x40/4caf50/fff?text=JD'
  };

  useEffect(() => {
    // Simulate infinite scroll
    const handleScroll = () => {
      if (feedRef.current) {
        const { scrollTop, scrollHeight, clientHeight } = feedRef.current;
        if (scrollTop + clientHeight >= scrollHeight - 100 && hasMorePosts && !infiniteScrollLoading) {
          loadMorePosts();
        }
      }
    };

    const feedElement = feedRef.current;
    if (feedElement) {
      feedElement.addEventListener('scroll', handleScroll);
      return () => feedElement.removeEventListener('scroll', handleScroll);
    }
  }, [hasMorePosts, infiniteScrollLoading]);

  const loadMorePosts = () => {
    setInfiniteScrollLoading(true);
    
    // Simulate API call
    setTimeout(() => {
      const newPosts = Array.from({ length: 3 }, (_, index) => ({
        id: posts.length + index + 1,
        user: {
          name: `User ${posts.length + index + 1}`,
          username: `@user${posts.length + index + 1}`,
          avatar: `https://via.placeholder.com/40x40/${['4caf50', '2196f3', 'ff9800', '9c27b0'][index % 4]}/fff?text=U${posts.length + index + 1}`,
          verified: Math.random() > 0.7
        },
        content: `This is a dynamically loaded post #${posts.length + index + 1}. The infinite scroll is working perfectly!`,
        image: Math.random() > 0.5 ? `https://via.placeholder.com/500x300/${['8bc34a', 'f44336', '00bcd4', 'ff5722'][index % 4]}/fff?text=Post+${posts.length + index + 1}` : null,
        timestamp: new Date(Date.now() - (posts.length + index + 1) * 60 * 60 * 1000),
        likes: Math.floor(Math.random() * 100),
        comments: Math.floor(Math.random() * 20),
        shares: Math.floor(Math.random() * 10),
        isLiked: false,
        isBookmarked: false
      }));
      
      setPosts(prev => [...prev, ...newPosts]);
      setInfiniteScrollLoading(false);
      
      // Simulate reaching end of feed
      if (posts.length > 20) {
        setHasMorePosts(false);
      }
    }, 1000);
  };

  const handleLike = (postId) => {
    setPosts(prev => prev.map(post => {
      if (post.id === postId) {
        const newLiked = !post.isLiked;
        return {
          ...post,
          isLiked: newLiked,
          likes: newLiked ? post.likes + 1 : post.likes - 1
        };
      }
      return post;
    }));

    // Add notification
    const post = posts.find(p => p.id === postId);
    if (post && !post.isLiked) {
      addNotification(`${post.user.name} liked your post`);
    }
  };

  const handleBookmark = (postId) => {
    setPosts(prev => prev.map(post => {
      if (post.id === postId) {
        return {
          ...post,
          isBookmarked: !post.isBookmarked
        };
      }
      return post;
    }));
  };

  const handleShare = (postId) => {
    setPosts(prev => prev.map(post => {
      if (post.id === postId) {
        return {
          ...post,
          shares: post.shares + 1
        };
      }
      return post;
    }));

    // Add notification
    const post = posts.find(p => p.id === postId);
    if (post) {
      addNotification(`You shared ${post.user.name}'s post`);
    }
  };

  const handleComment = (postId) => {
    setShowCommentModal(postId);
  };

  const addNotification = (message) => {
    const notification = {
      id: Date.now(),
      message,
      timestamp: new Date(),
      read: false
    };
    setNotifications(prev => [notification, ...prev]);
  };

  const markNotificationAsRead = (notificationId) => {
    setNotifications(prev => prev.map(notif => 
      notif.id === notificationId ? { ...notif, read: true } : notif
    ));
  };

  const handlePostSubmit = (e) => {
    e.preventDefault();
    if (!newPost.trim()) return;

    const post = {
      id: Date.now(),
      user: currentUser,
      content: newPost,
      image: null,
      timestamp: new Date(),
      likes: 0,
      comments: 0,
      shares: 0,
      isLiked: false,
      isBookmarked: false
    };

    setPosts(prev => [post, ...prev]);
    setNewPost('');
    setShowCompose(false);
  };

  const formatTimestamp = (timestamp) => {
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
  };

  const unreadNotifications = notifications.filter(n => !n.read).length;

  return (
    <div className="social-media-feed">
      <div className="feed-header">
        <h1>Social Feed</h1>
        <div className="header-actions">
          <button 
            onClick={() => setShowCompose(true)}
            className="compose-btn"
          >
            + New Post
          </button>
          
          <div className="notifications-container">
            <button 
              onClick={() => setShowNotifications(!showNotifications)}
              className="notifications-btn"
            >
              🔔
              {unreadNotifications > 0 && (
                <span className="notification-badge">{unreadNotifications}</span>
              )}
            </button>
            
            {showNotifications && (
              <div className="notifications-dropdown">
                <div className="notifications-header">
                  <h3>Notifications</h3>
                  <button 
                    onClick={() => setShowNotifications(false)}
                    className="close-btn"
                  >
                    ✕
                  </button>
                </div>
                <div className="notifications-list">
                  {notifications.length > 0 ? (
                    notifications.slice(0, 5).map(notification => (
                      <div 
                        key={notification.id}
                        className={`notification-item ${!notification.read ? 'unread' : ''}`}
                        onClick={() => markNotificationAsRead(notification.id)}
                      >
                        <div className="notification-message">{notification.message}</div>
                        <div className="notification-time">{formatTimestamp(notification.timestamp)}</div>
                      </div>
                    ))
                  ) : (
                    <div className="no-notifications">No notifications yet</div>
                  )}
                </div>
              </div>
            )}
          </div>

          <div className="user-menu-container">
            <button 
              onClick={() => setShowUserMenu(!showUserMenu)}
              className="user-menu-btn"
            >
              <img src={currentUser.avatar} alt={currentUser.name} />
              <span>{currentUser.name}</span>
              <span>▼</span>
            </button>
            
            {showUserMenu && (
              <div className="user-menu-dropdown">
                <div className="user-info">
                  <img src={currentUser.avatar} alt={currentUser.name} />
                  <div>
                    <div className="user-name">{currentUser.name}</div>
                    <div className="user-username">{currentUser.username}</div>
                  </div>
                </div>
                <div className="menu-items">
                  <button>Profile</button>
                  <button>Settings</button>
                  <button>Help</button>
                  <button>Sign Out</button>
                </div>
              </div>
            )}
          </div>
        </div>
      </div>

      {showCompose && (
        <div className="compose-modal">
          <div className="compose-form">
            <div className="compose-header">
              <h3>Create New Post</h3>
              <button 
                onClick={() => setShowCompose(false)}
                className="close-btn"
              >
                ✕
              </button>
            </div>
            <form onSubmit={handlePostSubmit}>
              <div className="compose-content">
                <img src={currentUser.avatar} alt={currentUser.name} className="compose-avatar" />
                <textarea
                  value={newPost}
                  onChange={(e) => setNewPost(e.target.value)}
                  placeholder="What's happening?"
                  className="compose-textarea"
                  rows="4"
                />
              </div>
              <div className="compose-actions">
                <div className="compose-options">
                  <button type="button" title="Add Image">📷</button>
                  <button type="button" title="Add GIF">🎬</button>
                  <button type="button" title="Add Poll">📊</button>
                </div>
                <div className="compose-submit">
                  <button 
                    type="button" 
                    onClick={() => setShowCompose(false)}
                    className="cancel-btn"
                  >
                    Cancel
                  </button>
                  <button 
                    type="submit"
                    disabled={!newPost.trim()}
                    className="submit-btn"
                  >
                    Post
                  </button>
                </div>
              </div>
            </form>
          </div>
        </div>
      )}

      <div className="feed-container" ref={feedRef}>
        <div className="posts-list">
          {posts.map(post => (
            <div key={post.id} className="post-card">
              <div className="post-header">
                <div className="user-info">
                  <img src={post.user.avatar} alt={post.user.name} className="user-avatar" />
                  <div className="user-details">
                    <div className="user-name">
                      {post.user.name}
                      {post.user.verified && <span className="verified-badge">✓</span>}
                    </div>
                    <div className="user-username">{post.user.username}</div>
                  </div>
                </div>
                <div className="post-meta">
                  <span className="post-time">{formatTimestamp(post.timestamp)}</span>
                  <button className="more-options">⋯</button>
                </div>
              </div>

              <div className="post-content">
                <p>{post.content}</p>
                {post.image && (
                  <div className="post-image">
                    <img src={post.image} alt="Post content" />
                  </div>
                )}
              </div>

              <div className="post-actions">
                <button 
                  onClick={() => handleComment(post.id)}
                  className={`action-btn comment-btn`}
                >
                  💬 {post.comments}
                </button>
                
                <button 
                  onClick={() => handleShare(post.id)}
                  className="action-btn share-btn"
                >
                  🔄 {post.shares}
                </button>
                
                <button 
                  onClick={() => handleLike(post.id)}
                  className={`action-btn like-btn ${post.isLiked ? 'liked' : ''}`}
                >
                  {post.isLiked ? '❤️' : '🤍'} {post.likes}
                </button>
                
                <button 
                  onClick={() => handleBookmark(post.id)}
                  className={`action-btn bookmark-btn ${post.isBookmarked ? 'bookmarked' : ''}`}
                >
                  {post.isBookmarked ? '🔖' : '📌'}
                </button>
              </div>
            </div>
          ))}

          {infiniteScrollLoading && (
            <div className="loading-more">
              <div className="loading-spinner"></div>
              <span>Loading more posts...</span>
            </div>
          )}

          {!hasMorePosts && (
            <div className="end-of-feed">
              <p>You've reached the end of the feed</p>
            </div>
          )}
        </div>
      </div>

      {showCommentModal && (
        <div className="comment-modal">
          <div className="comment-form">
            <div className="comment-header">
              <h3>Comments</h3>
              <button 
                onClick={() => setShowCommentModal(null)}
                className="close-btn"
              >
                ✕
              </button>
            </div>
            <div className="comment-content">
              <div className="comment-input">
                <img src={currentUser.avatar} alt={currentUser.name} />
                <textarea placeholder="Write a comment..." rows="3"></textarea>
              </div>
              <button className="comment-submit">Comment</button>
            </div>
          </div>
        </div>
      )}
    </div>
  );
};

export default SocialMediaFeed;

'use client';

import { useState, useEffect } from 'react';
import styles from './SocialMediaFeed.module.css';

const SocialMediaFeed = () => {
  const [posts, setPosts] = useState([
    {
      id: 1,
      author: {
        name: 'Sarah Johnson',
        avatar: 'https://via.placeholder.com/40x40/4caf50/fff?text=SJ',
        verified: true
      },
      content: 'Just finished an amazing hike in the mountains! The view was absolutely breathtaking. Nature never fails to amaze me. #hiking #nature #adventure',
      image: 'https://via.placeholder.com/500x300/8bc34a/fff?text=Mountain+View',
      timestamp: new Date(Date.now() - 2 * 60 * 60 * 1000),
      likes: 42,
      comments: 8,
      shares: 3,
      isLiked: false,
      isBookmarked: false,
      commentsList: [
        {
          id: 1,
          author: {
            name: 'Mike Chen',
            avatar: 'https://via.placeholder.com/32x32/2196f3/fff?text=MC'
          },
          content: 'Looks incredible! Where is this?',
          timestamp: new Date(Date.now() - 1 * 60 * 60 * 1000),
          likes: 2,
          isLiked: false
        },
        {
          id: 2,
          author: {
            name: 'Emma Wilson',
            avatar: 'https://via.placeholder.com/32x32/ff9800/fff?text=EW'
          },
          content: 'I need to go there! 😍',
          timestamp: new Date(Date.now() - 30 * 60 * 1000),
          likes: 1,
          isLiked: true
        }
      ]
    },
    {
      id: 2,
      author: {
        name: 'Tech News Daily',
        avatar: 'https://via.placeholder.com/40x40/9c27b0/fff?text=TND',
        verified: true
      },
      content: 'Breaking: New AI breakthrough could revolutionize healthcare diagnostics. The technology shows 99.7% accuracy in early disease detection.',
      timestamp: new Date(Date.now() - 4 * 60 * 60 * 1000),
      likes: 156,
      comments: 23,
      shares: 45,
      isLiked: true,
      isBookmarked: true,
      commentsList: []
    },
    {
      id: 3,
      author: {
        name: 'Alex Rodriguez',
        avatar: 'https://via.placeholder.com/40x40/f44336/fff?text=AR',
        verified: false
      },
      content: 'Coffee and code - the perfect combination for a productive day! ☕️💻',
      image: 'https://via.placeholder.com/500x300/795548/fff?text=Coffee+Setup',
      timestamp: new Date(Date.now() - 6 * 60 * 60 * 1000),
      likes: 28,
      comments: 5,
      shares: 2,
      isLiked: false,
      isBookmarked: false,
      commentsList: []
    }
  ]);

  const [notifications, setNotifications] = useState([
    {
      id: 1,
      type: 'like',
      message: 'liked your post',
      timestamp: new Date(Date.now() - 10 * 60 * 1000),
      read: false,
      user: {
        name: 'John Doe',
        avatar: 'https://via.placeholder.com/32x32/4caf50/fff?text=JD'
      }
    },
    {
      id: 2,
      type: 'comment',
      message: 'commented on your post',
      timestamp: new Date(Date.now() - 30 * 60 * 1000),
      read: false,
      user: {
        name: 'Jane Smith',
        avatar: 'https://via.placeholder.com/32x32/2196f3/fff?text=JS'
      }
    },
    {
      id: 3,
      type: 'follow',
      message: 'started following you',
      timestamp: new Date(Date.now() - 2 * 60 * 60 * 1000),
      read: true,
      user: {
        name: 'Bob Wilson',
        avatar: 'https://via.placeholder.com/32x32/ff9800/fff?text=BW'
      }
    }
  ]);

  const [newPostContent, setNewPostContent] = useState('');
  const [showComposer, setShowComposer] = useState(false);
  const [showNotifications, setShowNotifications] = useState(false);
  const [showComments, setShowComments] = useState({});
  const [newComment, setNewComment] = useState({});
  const [isLoading, setIsLoading] = useState(false);

  const currentUser = {
    name: 'You',
    avatar: 'https://via.placeholder.com/40x40/4caf50/fff?text=ME'
  };

  const loadMorePosts = async () => {
    setIsLoading(true);
    
    setTimeout(() => {
      setIsLoading(false);
    }, 1000);
  };

  const handleLike = (postId) => {
    setPosts(prev => prev.map(post => {
      if (post.id === postId) {
        return {
          ...post,
          isLiked: !post.isLiked,
          likes: post.isLiked ? post.likes - 1 : post.likes + 1
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
    alert('Post shared successfully!');
  };

  const handleComment = (postId) => {
    setShowComments(prev => ({
      ...prev,
      [postId]: !prev[postId]
    }));
  };

  const handleAddComment = (postId) => {
    const commentText = newComment[postId];
    if (!commentText?.trim()) return;

    const newCommentObj = {
      id: Date.now(),
      author: currentUser,
      content: commentText,
      timestamp: new Date(),
      likes: 0,
      isLiked: false
    };

    setPosts(prev => prev.map(post => {
      if (post.id === postId) {
        return {
          ...post,
          commentsList: [...post.commentsList, newCommentObj],
          comments: post.comments + 1
        };
      }
      return post;
    }));

    setNewComment(prev => ({
      ...prev,
      [postId]: ''
    }));
  };

  const handleLikeComment = (postId, commentId) => {
    setPosts(prev => prev.map(post => {
      if (post.id === postId) {
        return {
          ...post,
          commentsList: post.commentsList.map(comment => {
            if (comment.id === commentId) {
              return {
                ...comment,
                isLiked: !comment.isLiked,
                likes: comment.isLiked ? comment.likes - 1 : comment.likes + 1
              };
            }
            return comment;
          })
        };
      }
      return post;
    }));
  };

  const handleCreatePost = () => {
    if (!newPostContent.trim()) return;

    const newPost = {
      id: Date.now(),
      author: currentUser,
      content: newPostContent,
      timestamp: new Date(),
      likes: 0,
      comments: 0,
      shares: 0,
      isLiked: false,
      isBookmarked: false,
      commentsList: []
    };

    setPosts(prev => [newPost, ...prev]);
    setNewPostContent('');
    setShowComposer(false);
  };

  const handleNotificationClick = (notification) => {
    setNotifications(prev => prev.map(notif => 
      notif.id === notification.id ? { ...notif, read: true } : notif
    ));
  };

  const markAllNotificationsRead = () => {
    setNotifications(prev => prev.map(notification => ({ ...notification, read: true })));
  };

  const getUnreadNotificationCount = () => {
    return notifications.filter(n => !n.read).length;
  };

  const formatTimestamp = (timestamp) => {
    const now = new Date();
    const diff = now.getTime() - timestamp.getTime();
    const minutes = Math.floor(diff / (1000 * 60));
    const hours = Math.floor(diff / (1000 * 60 * 60));
    const days = Math.floor(diff / (1000 * 60 * 60 * 24));

    if (minutes < 1) return 'now';
    if (minutes < 60) return `${minutes}m`;
    if (hours < 24) return `${hours}h`;
    if (days < 7) return `${days}d`;
    return timestamp.toLocaleDateString();
  };

  const getNotificationIcon = (type) => {
    switch (type) {
      case 'like': return '❤️';
      case 'comment': return '💬';
      case 'follow': return '👤';
      case 'mention': return '@';
      default: return '🔔';
    }
  };

  const onScroll = (event) => {
    const element = event.target;
    if (element.scrollTop + element.clientHeight >= element.scrollHeight - 100) {
      loadMorePosts();
    }
  };

  return (
    <div className={styles.socialMediaFeed}>
      <div className={styles.feedHeader}>
        <h1>Social Feed</h1>
        <div className={styles.headerActions}>
          <div className={styles.notificationsContainer}>
            <button 
              onClick={() => setShowNotifications(!showNotifications)}
              className={styles.notificationsBtn}
            >
              🔔
              {getUnreadNotificationCount() > 0 && (
                <span className={styles.notificationBadge}>
                  {getUnreadNotificationCount()}
                </span>
              )}
            </button>
            
            {showNotifications && (
              <div className={styles.notificationsDropdown}>
                <div className={styles.notificationsHeader}>
                  <h3>Notifications</h3>
                  <button 
                    onClick={markAllNotificationsRead}
                    className={styles.markReadBtn}
                  >
                    Mark all read
                  </button>
                </div>
                <div className={styles.notificationsList}>
                  {notifications.map((notification) => (
                    <div
                      key={notification.id}
                      className={`${styles.notificationItem} ${notification.read ? 'read' : 'unread'}`}
                      onClick={() => handleNotificationClick(notification)}
                    >
                      <img 
                        src={notification.user.avatar} 
                        alt={notification.user.name} 
                        className={styles.notificationAvatar} 
                      />
                      <div className={styles.notificationContent}>
                        <div className={styles.notificationText}>
                          <strong>{notification.user.name}</strong> {notification.message}
                        </div>
                        <div className={styles.notificationTime}>
                          {formatTimestamp(notification.timestamp)}
                        </div>
                      </div>
                      <div className={styles.notificationIcon}>
                        {getNotificationIcon(notification.type)}
                      </div>
                    </div>
                  ))}
                </div>
              </div>
            )}
          </div>
          
          <button 
            onClick={() => setShowComposer(!showComposer)}
            className={styles.composeBtn}
          >
            + Create Post
          </button>
        </div>
      </div>

      <div className={styles.feedContent}>
        <div className={styles.feedMain}>
          {showComposer && (
            <div className={styles.postComposer}>
              <div className={styles.composerHeader}>
                <img 
                  src={currentUser.avatar} 
                  alt={currentUser.name} 
                  className={styles.composerAvatar} 
                />
                <div className={styles.composerInfo}>
                  <div className={styles.composerName}>{currentUser.name}</div>
                  <div className={styles.composerPrivacy}>Public</div>
                </div>
              </div>
              <div className={styles.composerContent}>
                <textarea
                  value={newPostContent}
                  onChange={(e) => setNewPostContent(e.target.value)}
                  placeholder="What's on your mind?"
                  className={styles.composerTextarea}
                />
              </div>
              <div className={styles.composerActions}>
                <button 
                  onClick={() => setShowComposer(false)}
                  className={styles.cancelBtn}
                >
                  Cancel
                </button>
                <button 
                  onClick={handleCreatePost}
                  className={styles.postBtn}
                >
                  Post
                </button>
              </div>
            </div>
          )}

          <div className={styles.postsContainer} onScroll={onScroll}>
            {posts.map((post) => (
              <div key={post.id} className={styles.postCard}>
                <div className={styles.postHeader}>
                  <div className={styles.postAuthor}>
                    <img 
                      src={post.author.avatar} 
                      alt={post.author.name} 
                      className={styles.authorAvatar} 
                    />
                    <div className={styles.authorInfo}>
                      <div className={styles.authorName}>
                        {post.author.name}
                        {post.author.verified && (
                          <span className={styles.verifiedBadge}>✓</span>
                        )}
                      </div>
                      <div className={styles.postTime}>
                        {formatTimestamp(post.timestamp)}
                      </div>
                    </div>
                  </div>
                  <div className={styles.postMenu}>
                    <button className={styles.menuBtn}>⋯</button>
                  </div>
                </div>

                <div className={styles.postContent}>
                  <p className={styles.postText}>{post.content}</p>
                  {post.image && (
                    <img 
                      src={post.image} 
                      alt={post.content} 
                      className={styles.postImage} 
                    />
                  )}
                </div>

                <div className={styles.postStats}>
                  {post.likes > 0 && (
                    <span className={styles.statItem}>
                      {post.likes} like{post.likes !== 1 ? 's' : ''}
                    </span>
                  )}
                  {post.comments > 0 && (
                    <span className={styles.statItem}>
                      {post.comments} comment{post.comments !== 1 ? 's' : ''}
                    </span>
                  )}
                  {post.shares > 0 && (
                    <span className={styles.statItem}>
                      {post.shares} share{post.shares !== 1 ? 's' : ''}
                    </span>
                  )}
                </div>

                <div className={styles.postActions}>
                  <button 
                    onClick={() => handleLike(post.id)}
                    className={`${styles.actionBtn} ${post.isLiked ? styles.liked : ''}`}
                  >
                    {post.isLiked ? '❤️' : '🤍'} Like
                  </button>
                  <button 
                    onClick={() => handleComment(post.id)}
                    className={styles.actionBtn}
                  >
                    💬 Comment
                  </button>
                  <button 
                    onClick={() => handleShare(post.id)}
                    className={styles.actionBtn}
                  >
                    🔄 Share
                  </button>
                  <button 
                    onClick={() => handleBookmark(post.id)}
                    className={`${styles.actionBtn} ${styles.bookmark} ${post.isBookmarked ? styles.bookmarked : ''}`}
                  >
                    {post.isBookmarked ? '🔖' : '🔗'}
                  </button>
                </div>

                {showComments[post.id] && (
                  <div className={styles.commentsSection}>
                    <div className={styles.commentsList}>
                      {post.commentsList.map((comment) => (
                        <div key={comment.id} className={styles.commentItem}>
                          <img 
                            src={comment.author.avatar} 
                            alt={comment.author.name} 
                            className={styles.commentAvatar} 
                          />
                          <div className={styles.commentContent}>
                            <div className={styles.commentHeader}>
                              <span className={styles.commentAuthor}>
                                {comment.author.name}
                              </span>
                              <span className={styles.commentTime}>
                                {formatTimestamp(comment.timestamp)}
                              </span>
                            </div>
                            <div className={styles.commentText}>{comment.content}</div>
                            <div className={styles.commentActions}>
                              <button 
                                onClick={() => handleLikeComment(post.id, comment.id)}
                                className={`${styles.commentLike} ${comment.isLiked ? styles.liked : ''}`}
                              >
                                {comment.isLiked ? '❤️' : '🤍'} {comment.likes > 0 ? comment.likes : ''}
                              </button>
                            </div>
                          </div>
                        </div>
                      ))}
                    </div>
                    
                    <div className={styles.addComment}>
                      <img 
                        src={currentUser.avatar} 
                        alt={currentUser.name} 
                        className={styles.commentAvatar} 
                      />
                      <div className={styles.commentInputContainer}>
                        <input
                          type="text"
                          value={newComment[post.id] || ''}
                          onChange={(e) => setNewComment(prev => ({
                            ...prev,
                            [post.id]: e.target.value
                          }))}
                          placeholder="Write a comment..."
                          className={styles.commentInput}
                          onKeyPress={(e) => {
                            if (e.key === 'Enter') {
                              handleAddComment(post.id);
                            }
                          }}
                        />
                        <button 
                          onClick={() => handleAddComment(post.id)}
                          className={styles.commentSubmit}
                        >
                          Post
                        </button>
                      </div>
                    </div>
                  </div>
                )}
              </div>
            ))}

            {isLoading && (
              <div className={styles.loadingPosts}>
                <div className={styles.loadingSpinner}></div>
                <span>Loading more posts...</span>
              </div>
            )}
          </div>
        </div>
      </div>
    </div>
  );
};

export default SocialMediaFeed;

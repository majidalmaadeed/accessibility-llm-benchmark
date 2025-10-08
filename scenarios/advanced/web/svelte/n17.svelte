<script>
  import { onMount } from 'svelte';
  
  let posts = [];
  let notifications = [];
  let newPostContent = '';
  let showComposer = false;
  let showNotifications = false;
  let showComments = {};
  let newComment = {};
  let isLoading = false;
  let currentUser = {
    name: 'You',
    avatar: 'https://via.placeholder.com/40x40/4caf50/fff?text=ME'
  };

  const samplePosts = [
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
  ];

  const sampleNotifications = [
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
  ];

  onMount(() => {
    posts = samplePosts;
    notifications = sampleNotifications;
  });

  function loadMorePosts() {
    isLoading = true;
    setTimeout(() => {
      isLoading = false;
    }, 1000);
  }

  function handleLike(postId) {
    posts = posts.map(post => {
      if (post.id === postId) {
        return {
          ...post,
          isLiked: !post.isLiked,
          likes: post.isLiked ? post.likes - 1 : post.likes + 1
        };
      }
      return post;
    });
  }

  function handleBookmark(postId) {
    posts = posts.map(post => {
      if (post.id === postId) {
        return {
          ...post,
          isBookmarked: !post.isBookmarked
        };
      }
      return post;
    });
  }

  function handleShare(postId) {
    posts = posts.map(post => {
      if (post.id === postId) {
        return {
          ...post,
          shares: post.shares + 1
        };
      }
      return post;
    });
    alert('Post shared successfully!');
  }

  function handleComment(postId) {
    showComments[postId] = !showComments[postId];
    showComments = { ...showComments };
  }

  function handleAddComment(postId) {
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

    posts = posts.map(post => {
      if (post.id === postId) {
        return {
          ...post,
          commentsList: [...post.commentsList, newCommentObj],
          comments: post.comments + 1
        };
      }
      return post;
    });

    newComment[postId] = '';
    newComment = { ...newComment };
  }

  function handleLikeComment(postId, commentId) {
    posts = posts.map(post => {
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
    });
  }

  function handleCreatePost() {
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

    posts = [newPost, ...posts];
    newPostContent = '';
    showComposer = false;
  }

  function handleNotificationClick(notification) {
    notifications = notifications.map(notif => 
      notif.id === notification.id ? { ...notif, read: true } : notif
    );
  }

  function markAllNotificationsRead() {
    notifications = notifications.map(notification => ({ ...notification, read: true }));
  }

  function getUnreadNotificationCount() {
    return notifications.filter(n => !n.read).length;
  }

  function formatTimestamp(timestamp) {
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
  }

  function getNotificationIcon(type) {
    switch (type) {
      case 'like': return '❤️';
      case 'comment': return '💬';
      case 'follow': return '👤';
      case 'mention': return '@';
      default: return '🔔';
    }
  }

  function onScroll(event) {
    const element = event.target;
    if (element.scrollTop + element.clientHeight >= element.scrollHeight - 100) {
      loadMorePosts();
    }
  }
</script>

<div class="social-media-feed">
  <div class="feed-header">
    <h1>Social Feed</h1>
    <div class="header-actions">
      <div class="notifications-container">
        <button 
          on:click={() => showNotifications = !showNotifications}
          class="notifications-btn"
        >
          🔔
          {#if getUnreadNotificationCount() > 0}
            <span class="notification-badge">
              {getUnreadNotificationCount()}
            </span>
          {/if}
        </button>
        
        {#if showNotifications}
          <div class="notifications-dropdown">
            <div class="notifications-header">
              <h3>Notifications</h3>
              <button 
                on:click={markAllNotificationsRead}
                class="mark-read-btn"
              >
                Mark all read
              </button>
            </div>
            <div class="notifications-list">
              {#each notifications as notification}
                <div
                  class="notification-item"
                  class:unread={!notification.read}
                  on:click={() => handleNotificationClick(notification)}
                >
                  <img 
                    src={notification.user.avatar} 
                    alt={notification.user.name} 
                    class="notification-avatar" 
                  />
                  <div class="notification-content">
                    <div class="notification-text">
                      <strong>{notification.user.name}</strong> {notification.message}
                    </div>
                    <div class="notification-time">
                      {formatTimestamp(notification.timestamp)}
                    </div>
                  </div>
                  <div class="notification-icon">
                    {getNotificationIcon(notification.type)}
                  </div>
                </div>
              {/each}
            </div>
          </div>
        {/if}
      </div>
      
      <button 
        on:click={() => showComposer = !showComposer}
        class="compose-btn"
      >
        + Create Post
      </button>
    </div>
  </div>

  <div class="feed-content">
    <div class="feed-main">
      {#if showComposer}
        <div class="post-composer">
          <div class="composer-header">
            <img 
              src={currentUser.avatar} 
              alt={currentUser.name} 
              class="composer-avatar" 
            />
            <div class="composer-info">
              <div class="composer-name">{currentUser.name}</div>
              <div class="composer-privacy">Public</div>
            </div>
          </div>
          <div class="composer-content">
            <textarea
              bind:value={newPostContent}
              placeholder="What's on your mind?"
              class="composer-textarea"
            />
          </div>
          <div class="composer-actions">
            <button 
              on:click={() => showComposer = false}
              class="cancel-btn"
            >
              Cancel
            </button>
            <button 
              on:click={handleCreatePost}
              class="post-btn"
            >
              Post
            </button>
          </div>
        </div>
      {/if}

      <div class="posts-container" on:scroll={onScroll}>
        {#each posts as post}
          <div class="post-card">
            <div class="post-header">
              <div class="post-author">
                <img 
                  src={post.author.avatar} 
                  alt={post.author.name} 
                  class="author-avatar" 
                />
                <div class="author-info">
                  <div class="author-name">
                    {post.author.name}
                    {#if post.author.verified}
                      <span class="verified-badge">✓</span>
                    {/if}
                  </div>
                  <div class="post-time">
                    {formatTimestamp(post.timestamp)}
                  </div>
                </div>
              </div>
              <div class="post-menu">
                <button class="menu-btn">⋯</button>
              </div>
            </div>

            <div class="post-content">
              <p class="post-text">{post.content}</p>
              {#if post.image}
                <img 
                  src={post.image} 
                  alt={post.content} 
                  class="post-image" 
                />
              {/if}
            </div>

            <div class="post-stats">
              {#if post.likes > 0}
                <span class="stat-item">
                  {post.likes} like{post.likes !== 1 ? 's' : ''}
                </span>
              {/if}
              {#if post.comments > 0}
                <span class="stat-item">
                  {post.comments} comment{post.comments !== 1 ? 's' : ''}
                </span>
              {/if}
              {#if post.shares > 0}
                <span class="stat-item">
                  {post.shares} share{post.shares !== 1 ? 's' : ''}
                </span>
              {/if}
            </div>

            <div class="post-actions">
              <button 
                on:click={() => handleLike(post.id)}
                class="action-btn"
                class:liked={post.isLiked}
              >
                {post.isLiked ? '❤️' : '🤍'} Like
              </button>
              <button 
                on:click={() => handleComment(post.id)}
                class="action-btn"
              >
                💬 Comment
              </button>
              <button 
                on:click={() => handleShare(post.id)}
                class="action-btn"
              >
                🔄 Share
              </button>
              <button 
                on:click={() => handleBookmark(post.id)}
                class="action-btn bookmark"
                class:bookmarked={post.isBookmarked}
              >
                {post.isBookmarked ? '🔖' : '🔗'}
              </button>
            </div>

            {#if showComments[post.id]}
              <div class="comments-section">
                <div class="comments-list">
                  {#each post.commentsList as comment}
                    <div class="comment-item">
                      <img 
                        src={comment.author.avatar} 
                        alt={comment.author.name} 
                        class="comment-avatar" 
                      />
                      <div class="comment-content">
                        <div class="comment-header">
                          <span class="comment-author">
                            {comment.author.name}
                          </span>
                          <span class="comment-time">
                            {formatTimestamp(comment.timestamp)}
                          </span>
                        </div>
                        <div class="comment-text">{comment.content}</div>
                        <div class="comment-actions">
                          <button 
                            on:click={() => handleLikeComment(post.id, comment.id)}
                            class="comment-like"
                            class:liked={comment.isLiked}
                          >
                            {comment.isLiked ? '❤️' : '🤍'} {comment.likes > 0 ? comment.likes : ''}
                          </button>
                        </div>
                      </div>
                    </div>
                  {/each}
                </div>
                
                <div class="add-comment">
                  <img 
                    src={currentUser.avatar} 
                    alt={currentUser.name} 
                    class="comment-avatar" 
                  />
                  <div class="comment-input-container">
                    <input
                      type="text"
                      bind:value={newComment[post.id]}
                      placeholder="Write a comment..."
                      class="comment-input"
                      on:keypress={(e) => {
                        if (e.key === 'Enter') {
                          handleAddComment(post.id);
                        }
                      }}
                    />
                    <button 
                      on:click={() => handleAddComment(post.id)}
                      class="comment-submit"
                    >
                      Post
                    </button>
                  </div>
                </div>
              </div>
            {/if}
          </div>
        {/each}

        {#if isLoading}
          <div class="loading-posts">
            <div class="loading-spinner"></div>
            <span>Loading more posts...</span>
          </div>
        {/if}
      </div>
    </div>
  </div>
</div>

<style>
  .social-media-feed {
    max-width: 600px;
    margin: 0 auto;
    padding: 20px;
    font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
    background: #f5f5f5;
    min-height: 100vh;
  }

  .feed-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 20px;
    padding: 15px 20px;
    background: white;
    border-radius: 8px;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
  }

  .feed-header h1 {
    margin: 0;
    color: #333;
    font-size: 24px;
  }

  .header-actions {
    display: flex;
    align-items: center;
    gap: 15px;
  }

  .notifications-container {
    position: relative;
  }

  .notifications-btn {
    position: relative;
    background: none;
    border: none;
    font-size: 20px;
    cursor: pointer;
    padding: 8px;
    border-radius: 50%;
    transition: background-color 0.3s ease;
  }

  .notifications-btn:hover {
    background: #f0f0f0;
  }

  .notification-badge {
    position: absolute;
    top: 0;
    right: 0;
    background: #f44336;
    color: white;
    border-radius: 50%;
    width: 18px;
    height: 18px;
    font-size: 10px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-weight: bold;
  }

  .notifications-dropdown {
    position: absolute;
    top: 100%;
    right: 0;
    background: white;
    border: 1px solid #e0e0e0;
    border-radius: 8px;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
    z-index: 100;
    width: 350px;
    max-height: 400px;
    overflow-y: auto;
    margin-top: 5px;
  }

  .notifications-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 15px;
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
    padding: 4px 8px;
    border-radius: 4px;
    transition: background-color 0.3s ease;
  }

  .mark-read-btn:hover {
    background: #e8f5e8;
  }

  .notifications-list {
    max-height: 300px;
    overflow-y: auto;
  }

  .notification-item {
    display: flex;
    align-items: center;
    gap: 12px;
    padding: 12px 15px;
    cursor: pointer;
    transition: background-color 0.3s ease;
    border-bottom: 1px solid #f0f0f0;
  }

  .notification-item:hover {
    background: #f8f9fa;
  }

  .notification-item.unread {
    background: #e3f2fd;
  }

  .notification-avatar {
    width: 32px;
    height: 32px;
    border-radius: 50%;
    object-fit: cover;
  }

  .notification-content {
    flex: 1;
    min-width: 0;
  }

  .notification-text {
    font-size: 14px;
    color: #333;
    line-height: 1.3;
    margin-bottom: 2px;
  }

  .notification-time {
    font-size: 11px;
    color: #666;
  }

  .notification-icon {
    font-size: 16px;
  }

  .compose-btn {
    padding: 8px 16px;
    background: #4caf50;
    color: white;
    border: none;
    border-radius: 6px;
    cursor: pointer;
    font-size: 14px;
    font-weight: 600;
    transition: background-color 0.3s ease;
  }

  .compose-btn:hover {
    background: #45a049;
  }

  .feed-content {
    background: white;
    border-radius: 8px;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    overflow: hidden;
  }

  .feed-main {
    padding: 20px;
  }

  .post-composer {
    background: #f8f9fa;
    border: 1px solid #e0e0e0;
    border-radius: 8px;
    padding: 15px;
    margin-bottom: 20px;
  }

  .composer-header {
    display: flex;
    align-items: center;
    gap: 12px;
    margin-bottom: 15px;
  }

  .composer-avatar {
    width: 40px;
    height: 40px;
    border-radius: 50%;
    object-fit: cover;
  }

  .composer-info {
    flex: 1;
  }

  .composer-name {
    font-weight: 600;
    color: #333;
    font-size: 14px;
  }

  .composer-privacy {
    font-size: 12px;
    color: #666;
  }

  .composer-content {
    margin-bottom: 15px;
  }

  .composer-textarea {
    width: 100%;
    min-height: 80px;
    border: 1px solid #e0e0e0;
    border-radius: 6px;
    padding: 12px;
    font-size: 14px;
    font-family: inherit;
    resize: vertical;
    outline: none;
    transition: border-color 0.3s ease;
  }

  .composer-textarea:focus {
    border-color: #4caf50;
  }

  .composer-actions {
    display: flex;
    justify-content: flex-end;
    gap: 10px;
  }

  .cancel-btn {
    padding: 8px 16px;
    background: #f5f5f5;
    color: #666;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    font-size: 14px;
    transition: background-color 0.3s ease;
  }

  .cancel-btn:hover {
    background: #e0e0e0;
  }

  .post-btn {
    padding: 8px 16px;
    background: #4caf50;
    color: white;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    font-size: 14px;
    font-weight: 600;
    transition: background-color 0.3s ease;
  }

  .post-btn:hover {
    background: #45a049;
  }

  .posts-container {
    max-height: 80vh;
    overflow-y: auto;
  }

  .post-card {
    background: white;
    border: 1px solid #e0e0e0;
    border-radius: 8px;
    margin-bottom: 20px;
    overflow: hidden;
  }

  .post-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 15px;
    border-bottom: 1px solid #f0f0f0;
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

  .author-info {
    flex: 1;
  }

  .author-name {
    font-weight: 600;
    color: #333;
    font-size: 14px;
    display: flex;
    align-items: center;
    gap: 5px;
  }

  .verified-badge {
    color: #4caf50;
    font-size: 12px;
  }

  .post-time {
    font-size: 12px;
    color: #666;
    margin-top: 2px;
  }

  .menu-btn {
    background: none;
    border: none;
    font-size: 18px;
    color: #666;
    cursor: pointer;
    padding: 4px;
    border-radius: 50%;
    transition: background-color 0.3s ease;
  }

  .menu-btn:hover {
    background: #f0f0f0;
  }

  .post-content {
    padding: 15px;
  }

  .post-text {
    margin: 0 0 15px 0;
    color: #333;
    line-height: 1.5;
    font-size: 14px;
  }

  .post-image {
    width: 100%;
    border-radius: 6px;
    margin-top: 10px;
  }

  .post-stats {
    display: flex;
    gap: 15px;
    padding: 0 15px 10px;
    font-size: 12px;
    color: #666;
  }

  .stat-item {
    cursor: pointer;
    transition: color 0.3s ease;
  }

  .stat-item:hover {
    color: #4caf50;
  }

  .post-actions {
    display: flex;
    border-top: 1px solid #f0f0f0;
  }

  .action-btn {
    flex: 1;
    background: none;
    border: none;
    padding: 12px;
    cursor: pointer;
    font-size: 14px;
    color: #666;
    transition: all 0.3s ease;
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 5px;
  }

  .action-btn:hover {
    background: #f8f9fa;
    color: #4caf50;
  }

  .action-btn.liked {
    color: #f44336;
  }

  .action-btn.bookmarked {
    color: #ff9800;
  }

  .comments-section {
    border-top: 1px solid #f0f0f0;
    padding: 15px;
    background: #f8f9fa;
  }

  .comments-list {
    margin-bottom: 15px;
  }

  .comment-item {
    display: flex;
    gap: 10px;
    margin-bottom: 12px;
  }

  .comment-avatar {
    width: 32px;
    height: 32px;
    border-radius: 50%;
    object-fit: cover;
    flex-shrink: 0;
  }

  .comment-content {
    flex: 1;
    background: white;
    border-radius: 6px;
    padding: 8px 12px;
  }

  .comment-header {
    display: flex;
    align-items: center;
    gap: 8px;
    margin-bottom: 4px;
  }

  .comment-author {
    font-weight: 600;
    color: #333;
    font-size: 12px;
  }

  .comment-time {
    font-size: 10px;
    color: #666;
  }

  .comment-text {
    font-size: 13px;
    color: #333;
    line-height: 1.4;
    margin-bottom: 6px;
  }

  .comment-actions {
    display: flex;
    gap: 10px;
  }

  .comment-like {
    background: none;
    border: none;
    cursor: pointer;
    font-size: 11px;
    color: #666;
    padding: 2px 6px;
    border-radius: 3px;
    transition: all 0.3s ease;
  }

  .comment-like:hover {
    background: #f0f0f0;
  }

  .comment-like.liked {
    color: #f44336;
  }

  .add-comment {
    display: flex;
    gap: 10px;
    align-items: center;
  }

  .comment-input-container {
    flex: 1;
    display: flex;
    gap: 8px;
    background: white;
    border-radius: 6px;
    padding: 8px 12px;
    border: 1px solid #e0e0e0;
  }

  .comment-input {
    flex: 1;
    border: none;
    outline: none;
    font-size: 13px;
    font-family: inherit;
  }

  .comment-submit {
    background: #4caf50;
    color: white;
    border: none;
    border-radius: 4px;
    padding: 4px 8px;
    cursor: pointer;
    font-size: 11px;
    font-weight: 600;
    transition: background-color 0.3s ease;
  }

  .comment-submit:hover {
    background: #45a049;
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
    margin-bottom: 10px;
  }

  @keyframes spin {
    0% { transform: rotate(0deg); }
    100% { transform: rotate(360deg); }
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
    
    .notifications-dropdown {
      width: 300px;
      right: -50px;
    }
    
    .feed-main {
      padding: 15px;
    }
    
    .post-actions {
      flex-wrap: wrap;
    }
    
    .action-btn {
      min-width: 80px;
    }
    
    .comment-input-container {
      flex-direction: column;
      gap: 8px;
    }
    
    .comment-submit {
      align-self: flex-end;
    }
  }

  @media (max-width: 480px) {
    .social-media-feed {
      padding: 10px;
    }
    
    .feed-header {
      padding: 10px 15px;
    }
    
    .feed-main {
      padding: 10px;
    }
    
    .post-header {
      padding: 10px;
    }
    
    .post-content {
      padding: 10px;
    }
    
    .comments-section {
      padding: 10px;
    }
    
    .notifications-dropdown {
      width: 280px;
      right: -40px;
    }
    
    .action-btn {
      padding: 8px;
      font-size: 12px;
    }
  }
</style>

<script>
  import { onMount } from 'svelte';
  
  let posts = [
    {
      id: 1,
      author: 'John Doe',
      content: 'Just finished reading an amazing book about web development! The insights on modern frameworks are incredible.',
      timestamp: '2 hours ago',
      likes: 24,
      comments: 8,
      shares: 3
    },
    {
      id: 2,
      author: 'Jane Smith',
      content: 'Beautiful sunset from my window today. Sometimes you need to stop and appreciate the simple things in life.',
      timestamp: '4 hours ago',
      likes: 42,
      comments: 12,
      shares: 7
    },
    {
      id: 3,
      author: 'Mike Johnson',
      content: 'Working on a new project that I\'m really excited about. Can\'t wait to share more details soon!',
      timestamp: '6 hours ago',
      likes: 18,
      comments: 5,
      shares: 2
    }
  ];
  
  let likedPosts = new Set();
  
  function toggleLike(postId) {
    if (likedPosts.has(postId)) {
      likedPosts.delete(postId);
    } else {
      likedPosts.add(postId);
    }
    likedPosts = likedPosts; // Trigger reactivity
  }
  
  function addComment(postId) {
    alert(`Add comment to post ${postId}`);
  }
  
  function sharePost(postId) {
    alert(`Share post ${postId}`);
  }
  
  function likePost(postId) {
    toggleLike(postId);
  }
</script>

<div class="social-feed">
  <header class="header">
    <div class="header-content">
      <h1 class="logo">SocialFeed</h1>
      <div class="header-actions">
        <button class="header-btn" on:click={() => alert('Search clicked')}>
          🔍 Search
        </button>
        <button class="header-btn" on:click={() => alert('Notifications clicked')}>
          🔔 Notifications
        </button>
        <button class="header-btn" on:click={() => alert('Profile clicked')}>
          👤 Profile
        </button>
      </div>
    </div>
  </header>
  
  <main class="main-content">
    <div class="feed-container">
      {#each posts as post}
        <div class="post-card">
          <div class="post-header">
            <div class="author-info">
              <div class="author-avatar">👤</div>
              <div class="author-details">
                <div class="author-name">{post.author}</div>
                <div class="post-timestamp">{post.timestamp}</div>
              </div>
            </div>
          </div>
          
          <div class="post-content">
            <p class="post-text">{post.content}</p>
          </div>
          
          <div class="post-actions">
            <div class="action-group">
              <button 
                class="action-btn {likedPosts.has(post.id) ? 'liked' : ''}" 
                on:click={() => likePost(post.id)}
              >
                {likedPosts.has(post.id) ? '❤️' : '🤍'} {post.likes + (likedPosts.has(post.id) ? 1 : 0)}
              </button>
              
              <button class="action-btn" on:click={() => addComment(post.id)}>
                💬 {post.comments}
              </button>
              
              <!-- SMALL TOUCH TARGET - Social share button only 20x20px on mobile interface -->
              <button class="action-btn share-btn" on:click={() => sharePost(post.id)}>
                📤
              </button>
            </div>
          </div>
        </div>
      {/each}
    </div>
  </main>
</div>

<style>
  .social-feed {
    min-height: 100vh;
    background: #f8f9fa;
    font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
  }
  
  .header {
    background: white;
    border-bottom: 1px solid #ddd;
    padding: 15px 0;
    position: sticky;
    top: 0;
    z-index: 100;
  }
  
  .header-content {
    max-width: 600px;
    margin: 0 auto;
    padding: 0 20px;
    display: flex;
    justify-content: space-between;
    align-items: center;
  }
  
  .logo {
    font-size: 24px;
    font-weight: bold;
    color: #333;
    margin: 0;
  }
  
  .header-actions {
    display: flex;
    gap: 15px;
  }
  
  .header-btn {
    padding: 8px 16px;
    border: 1px solid #ddd;
    border-radius: 6px;
    background: white;
    color: #333;
    cursor: pointer;
    font-size: 14px;
    transition: all 0.2s;
  }
  
  .header-btn:hover {
    background: #f8f9fa;
  }
  
  .main-content {
    max-width: 600px;
    margin: 0 auto;
    padding: 20px;
  }
  
  .feed-container {
    display: flex;
    flex-direction: column;
    gap: 20px;
  }
  
  .post-card {
    background: white;
    border-radius: 12px;
    padding: 20px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.1);
  }
  
  .post-header {
    margin-bottom: 15px;
  }
  
  .author-info {
    display: flex;
    align-items: center;
    gap: 12px;
  }
  
  .author-avatar {
    width: 40px;
    height: 40px;
    background: #007bff;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    color: white;
    font-size: 18px;
  }
  
  .author-details {
    flex: 1;
  }
  
  .author-name {
    font-weight: bold;
    color: #333;
    font-size: 16px;
  }
  
  .post-timestamp {
    color: #666;
    font-size: 14px;
  }
  
  .post-content {
    margin-bottom: 15px;
  }
  
  .post-text {
    font-size: 16px;
    line-height: 1.5;
    color: #333;
    margin: 0;
  }
  
  .post-actions {
    border-top: 1px solid #eee;
    padding-top: 15px;
  }
  
  .action-group {
    display: flex;
    gap: 20px;
  }
  
  .action-btn {
    background: none;
    border: none;
    color: #666;
    cursor: pointer;
    font-size: 16px;
    display: flex;
    align-items: center;
    gap: 5px;
    transition: color 0.2s;
  }
  
  .action-btn:hover {
    color: #333;
  }
  
  .action-btn.liked {
    color: #e74c3c;
  }
  
  /* SMALL TOUCH TARGET - Social share button only 20x20px on mobile interface */
  .share-btn {
    width: 20px;
    height: 20px;
    padding: 0;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 14px;
  }
  
  /* Mobile styles */
  @media (max-width: 768px) {
    .main-content {
      padding: 15px;
    }
    
    .post-card {
      padding: 15px;
    }
    
    .action-group {
      gap: 15px;
    }
    
    /* SMALL TOUCH TARGET - Social share button only 20x20px on mobile interface */
    .share-btn {
      width: 20px;
      height: 20px;
      min-width: 20px;
      min-height: 20px;
    }
  }
  
  /* Extra small screens */
  @media (max-width: 480px) {
    .header-actions {
      gap: 10px;
    }
    
    .header-btn {
      padding: 6px 12px;
      font-size: 12px;
    }
    
    /* SMALL TOUCH TARGET - Social share button only 20x20px on mobile interface */
    .share-btn {
      width: 20px;
      height: 20px;
      min-width: 20px;
      min-height: 20px;
    }
  }
</style>

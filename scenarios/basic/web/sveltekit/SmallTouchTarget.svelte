<script>
  let selectedItems = [];
  let isSelecting = false;
  
  function toggleSelection(item) {
    if (selectedItems.includes(item)) {
      selectedItems = selectedItems.filter(i => i !== item);
    } else {
      selectedItems = [...selectedItems, item];
    }
  }
  
  function selectAll() {
    selectedItems = posts.map(post => post.id);
  }
  
  function clearSelection() {
    selectedItems = [];
  }
  
  function deleteSelected() {
    if (selectedItems.length > 0) {
      if (confirm(`Delete ${selectedItems.length} selected posts?`)) {
        posts = posts.filter(post => !selectedItems.includes(post.id));
        selectedItems = [];
      }
    }
  }
  
  function shareSelected() {
    if (selectedItems.length > 0) {
      console.log('Sharing posts:', selectedItems);
    }
  }
  
  let posts = [
    {
      id: 1,
      title: "Understanding React Hooks",
      content: "React Hooks revolutionized how we write functional components...",
      author: "John Doe",
      date: "2024-01-15",
      likes: 42,
      comments: 8,
      shares: 3
    },
    {
      id: 2,
      title: "CSS Grid vs Flexbox",
      content: "When to use CSS Grid and when to use Flexbox for layouts...",
      author: "Jane Smith",
      date: "2024-01-14",
      likes: 28,
      comments: 5,
      shares: 2
    },
    {
      id: 3,
      title: "JavaScript ES2024 Features",
      content: "New features coming to JavaScript in 2024...",
      author: "Mike Johnson",
      date: "2024-01-13",
      likes: 67,
      comments: 12,
      shares: 7
    },
    {
      id: 4,
      title: "Web Performance Optimization",
      content: "Tips and tricks for improving web application performance...",
      author: "Sarah Wilson",
      date: "2024-01-12",
      likes: 89,
      comments: 15,
      shares: 9
    },
    {
      id: 5,
      title: "TypeScript Best Practices",
      content: "How to write better TypeScript code...",
      author: "David Brown",
      date: "2024-01-11",
      likes: 34,
      comments: 6,
      shares: 4
    }
  ];
</script>

<div class="social-media-feed">
  <header class="feed-header">
    <h1 class="feed-title">Tech Blog Feed</h1>
    <div class="feed-actions">
      <button class="action-btn" on:click={selectAll}>Select All</button>
      <button class="action-btn" on:click={clearSelection}>Clear Selection</button>
      <button class="action-btn" on:click={deleteSelected} disabled={selectedItems.length === 0}>
        Delete Selected ({selectedItems.length})
      </button>
      <button class="action-btn" on:click={shareSelected} disabled={selectedItems.length === 0}>
        Share Selected
      </button>
    </div>
  </header>
  
  <div class="posts-container">
    {#each posts as post (post.id)}
      <article class="post-card" class:selected={selectedItems.includes(post.id)}>
        <div class="post-header">
          <div class="author-info">
            <img src="/api/placeholder/40/40" alt={post.author} class="author-avatar" />
            <div class="author-details">
              <div class="author-name">{post.author}</div>
              <div class="post-date">{post.date}</div>
            </div>
          </div>
          
          <div class="post-actions">
            <button class="post-action-btn" on:click={() => toggleSelection(post.id)}>
              {selectedItems.includes(post.id) ? '✓' : '○'}
            </button>
            <button class="post-action-btn">⋯</button>
          </div>
        </div>
        
        <div class="post-content">
          <h2 class="post-title">{post.title}</h2>
          <p class="post-text">{post.content}</p>
        </div>
        
        <div class="post-stats">
          <div class="stat-item">
            <button class="stat-btn like">
              <span class="stat-icon">❤️</span>
              <span class="stat-count">{post.likes}</span>
            </button>
          </div>
          
          <div class="stat-item">
            <button class="stat-btn comment">
              <span class="stat-icon">💬</span>
              <span class="stat-count">{post.comments}</span>
            </button>
          </div>
          
          <div class="stat-item">
            <button class="stat-btn share">
              <span class="stat-icon">📤</span>
              <span class="stat-count">{post.shares}</span>
            </button>
          </div>
          
          <div class="stat-item">
            <button class="stat-btn bookmark">
              <span class="stat-icon">🔖</span>
            </button>
          </div>
        </div>
        
        <div class="post-engagement">
          <div class="engagement-actions">
            <button class="engagement-btn like-btn">
              <span class="btn-icon">❤️</span>
              <span class="btn-text">Like</span>
            </button>
            
            <button class="engagement-btn comment-btn">
              <span class="btn-icon">💬</span>
              <span class="btn-text">Comment</span>
            </button>
            
            <button class="engagement-btn share-btn">
              <span class="btn-icon">📤</span>
              <span class="btn-text">Share</span>
            </button>
            
            <button class="engagement-btn save-btn">
              <span class="btn-icon">🔖</span>
              <span class="btn-text">Save</span>
            </button>
          </div>
        </div>
      </article>
    {/each}
  </div>
  
  <div class="load-more">
    <button class="load-more-btn">Load More Posts</button>
  </div>
</div>

<style>
  .social-media-feed {
    max-width: 600px;
    margin: 0 auto;
    padding: 20px;
    font-family: Arial, sans-serif;
  }
  
  .feed-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 30px;
    padding: 20px;
    background: white;
    border-radius: 12px;
    box-shadow: 0 2px 10px rgba(0,0,0,0.1);
  }
  
  .feed-title {
    margin: 0;
    font-size: 24px;
    color: #333;
  }
  
  .feed-actions {
    display: flex;
    gap: 10px;
  }
  
  .action-btn {
    padding: 8px 16px;
    border: 1px solid #ddd;
    background: white;
    color: #333;
    border-radius: 6px;
    cursor: pointer;
    font-size: 14px;
    transition: all 0.2s ease;
  }
  
  .action-btn:hover:not(:disabled) {
    background: #f8f9fa;
    border-color: #007bff;
    color: #007bff;
  }
  
  .action-btn:disabled {
    opacity: 0.5;
    cursor: not-allowed;
  }
  
  .posts-container {
    display: flex;
    flex-direction: column;
    gap: 20px;
  }
  
  .post-card {
    background: white;
    border-radius: 12px;
    box-shadow: 0 2px 10px rgba(0,0,0,0.1);
    overflow: hidden;
    transition: all 0.2s ease;
  }
  
  .post-card:hover {
    transform: translateY(-2px);
    box-shadow: 0 4px 20px rgba(0,0,0,0.15);
  }
  
  .post-card.selected {
    border: 2px solid #007bff;
    background: #f8f9ff;
  }
  
  .post-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 20px;
    border-bottom: 1px solid #f0f0f0;
  }
  
  .author-info {
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
  
  .author-details {
    display: flex;
    flex-direction: column;
    gap: 2px;
  }
  
  .author-name {
    font-weight: bold;
    color: #333;
    font-size: 16px;
  }
  
  .post-date {
    color: #666;
    font-size: 14px;
  }
  
  .post-actions {
    display: flex;
    gap: 8px;
  }
  
  .post-action-btn {
    width: 32px;
    height: 32px;
    border: 1px solid #ddd;
    background: white;
    color: #333;
    border-radius: 50%;
    cursor: pointer;
    font-size: 16px;
    transition: all 0.2s ease;
    display: flex;
    align-items: center;
    justify-content: center;
  }
  
  .post-action-btn:hover {
    background: #f8f9fa;
    border-color: #007bff;
    color: #007bff;
  }
  
  .post-content {
    padding: 20px;
  }
  
  .post-title {
    margin: 0 0 15px 0;
    font-size: 20px;
    color: #333;
    line-height: 1.3;
  }
  
  .post-text {
    margin: 0;
    color: #666;
    line-height: 1.6;
  }
  
  .post-stats {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 15px 20px;
    border-top: 1px solid #f0f0f0;
    background: #f8f9fa;
  }
  
  .stat-item {
    display: flex;
    align-items: center;
  }
  
  .stat-btn {
    display: flex;
    align-items: center;
    gap: 6px;
    padding: 6px 12px;
    border: none;
    background: transparent;
    color: #666;
    cursor: pointer;
    border-radius: 20px;
    transition: all 0.2s ease;
    font-size: 14px;
  }
  
  .stat-btn:hover {
    background: #e9ecef;
    color: #333;
  }
  
  .stat-icon {
    font-size: 16px;
  }
  
  .stat-count {
    font-weight: 500;
  }
  
  .post-engagement {
    padding: 15px 20px;
    border-top: 1px solid #f0f0f0;
  }
  
  .engagement-actions {
    display: flex;
    justify-content: space-around;
  }
  
  .engagement-btn {
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 4px;
    padding: 8px 12px;
    border: none;
    background: transparent;
    color: #666;
    cursor: pointer;
    border-radius: 8px;
    transition: all 0.2s ease;
    font-size: 12px;
  }
  
  .engagement-btn:hover {
    background: #f8f9fa;
    color: #007bff;
  }
  
  .btn-icon {
    font-size: 20px;
  }
  
  .btn-text {
    font-weight: 500;
  }
  
  .load-more {
    text-align: center;
    margin-top: 30px;
  }
  
  .load-more-btn {
    padding: 15px 30px;
    background: #007bff;
    color: white;
    border: none;
    border-radius: 8px;
    cursor: pointer;
    font-size: 16px;
    font-weight: bold;
    transition: all 0.2s ease;
  }
  
  .load-more-btn:hover {
    background: #0056b3;
    transform: translateY(-1px);
  }
  
  @media (max-width: 768px) {
    .feed-header {
      flex-direction: column;
      gap: 20px;
      text-align: center;
    }
    
    .feed-actions {
      flex-wrap: wrap;
      justify-content: center;
    }
    
    .post-header {
      flex-direction: column;
      gap: 15px;
      align-items: flex-start;
    }
    
    .post-actions {
      align-self: flex-end;
    }
    
    .engagement-actions {
      gap: 10px;
    }
    
    .engagement-btn {
      padding: 6px 8px;
    }
  }
  
  @media (max-width: 480px) {
    .social-media-feed {
      padding: 10px;
    }
    
    .feed-actions {
      flex-direction: column;
      width: 100%;
    }
    
    .action-btn {
      width: 100%;
    }
    
    .post-stats {
      flex-wrap: wrap;
      gap: 10px;
    }
    
    .engagement-actions {
      flex-wrap: wrap;
    }
  }
</style>

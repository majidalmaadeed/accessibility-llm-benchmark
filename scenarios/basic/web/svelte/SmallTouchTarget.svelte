<script>
  let selectedPlatform = 'all';
  let sortBy = 'popular';
  let currentPage = 1;
  const itemsPerPage = 6;

  const platforms = [
    { id: 'all', name: 'All Platforms' },
    { id: 'facebook', name: 'Facebook' },
    { id: 'twitter', name: 'Twitter' },
    { id: 'instagram', name: 'Instagram' },
    { id: 'linkedin', name: 'LinkedIn' },
    { id: 'pinterest', name: 'Pinterest' }
  ];

  const posts = [
    {
      id: 1,
      title: 'Amazing Product Launch',
      content: 'Check out our new revolutionary product that will change everything!',
      platform: 'facebook',
      likes: 1247,
      shares: 89,
      comments: 156,
      timeAgo: '2h',
      image: 'product-launch.jpg'
    },
    {
      id: 2,
      title: 'Tech Innovation Update',
      content: 'Latest developments in AI and machine learning are reshaping industries.',
      platform: 'twitter',
      likes: 892,
      shares: 234,
      comments: 67,
      timeAgo: '4h',
      image: 'tech-innovation.jpg'
    },
    {
      id: 3,
      title: 'Behind the Scenes',
      content: 'Take a look at our creative process and team collaboration.',
      platform: 'instagram',
      likes: 2156,
      shares: 145,
      comments: 89,
      timeAgo: '6h',
      image: 'behind-scenes.jpg'
    },
    {
      id: 4,
      title: 'Industry Insights',
      content: 'Key trends and predictions for the upcoming quarter.',
      platform: 'linkedin',
      likes: 567,
      shares: 78,
      comments: 34,
      timeAgo: '8h',
      image: 'industry-insights.jpg'
    },
    {
      id: 5,
      title: 'Creative Inspiration',
      content: 'Beautiful designs and creative solutions that inspire us daily.',
      platform: 'pinterest',
      likes: 1834,
      shares: 456,
      comments: 123,
      timeAgo: '12h',
      image: 'creative-inspiration.jpg'
    },
    {
      id: 6,
      title: 'Customer Success Story',
      content: 'How our solution helped a client achieve their goals.',
      platform: 'facebook',
      likes: 743,
      shares: 67,
      comments: 45,
      timeAgo: '1d',
      image: 'customer-success.jpg'
    }
  ];

  $: filteredPosts = posts.filter(post => 
    selectedPlatform === 'all' || post.platform === selectedPlatform
  );

  $: sortedPosts = [...filteredPosts].sort((a, b) => {
    switch(sortBy) {
      case 'likes':
        return b.likes - a.likes;
      case 'shares':
        return b.shares - a.shares;
      case 'comments':
        return b.comments - a.comments;
      case 'time':
        return posts.indexOf(b) - posts.indexOf(a);
      case 'popular':
      default:
        return (b.likes + b.shares + b.comments) - (a.likes + a.shares + a.comments);
    }
  });

  $: totalPages = Math.ceil(sortedPosts.length / itemsPerPage);
  $: paginatedPosts = sortedPosts.slice(
    (currentPage - 1) * itemsPerPage, 
    currentPage * itemsPerPage
  );

  function getPlatformIcon(platform) {
    const icons = {
      facebook: '📘',
      twitter: '🐦',
      instagram: '📷',
      linkedin: '💼',
      pinterest: '📌'
    };
    return icons[platform] || '📱';
  }

  function getPlatformColor(platform) {
    const colors = {
      facebook: '#1877f2',
      twitter: '#1da1f2',
      instagram: '#e4405f',
      linkedin: '#0077b5',
      pinterest: '#bd081c'
    };
    return colors[platform] || '#666';
  }

  function handleAction(action, post) {
    alert(`${action} action performed on "${post.title}"`);
  }

  function goToPage(page) {
    currentPage = page;
  }

  function nextPage() {
    if (currentPage < totalPages) {
      currentPage++;
    }
  }

  function prevPage() {
    if (currentPage > 1) {
      currentPage--;
    }
  }
</script>

<div class="social-media-manager">
  <header class="app-header">
    <h1>Social Media Manager</h1>
    <p>Manage and monitor your social media posts across all platforms</p>
  </header>

  <div class="controls-section">
    <div class="filter-controls">
      <select bind:value={selectedPlatform} class="platform-filter">
        {#each platforms as platform}
          <option value={platform.id}>{platform.name}</option>
        {/each}
      </select>

      <select bind:value={sortBy} class="sort-filter">
        <option value="popular">Most Popular</option>
        <option value="likes">Most Likes</option>
        <option value="shares">Most Shares</option>
        <option value="comments">Most Comments</option>
        <option value="time">Most Recent</option>
      </select>
    </div>

    <div class="view-controls">
      <button class="view-btn active">Grid View</button>
      <button class="view-btn">List View</button>
    </div>
  </div>

  <div class="stats-overview">
    <div class="stat-card">
      <div class="stat-number">{filteredPosts.length}</div>
      <div class="stat-label">Total Posts</div>
    </div>
    <div class="stat-card">
      <div class="stat-number">{filteredPosts.reduce((sum, post) => sum + post.likes, 0).toLocaleString()}</div>
      <div class="stat-label">Total Likes</div>
    </div>
    <div class="stat-card">
      <div class="stat-number">{filteredPosts.reduce((sum, post) => sum + post.shares, 0).toLocaleString()}</div>
      <div class="stat-label">Total Shares</div>
    </div>
    <div class="stat-card">
      <div class="stat-number">{filteredPosts.reduce((sum, post) => sum + post.comments, 0).toLocaleString()}</div>
      <div class="stat-label">Total Comments</div>
    </div>
  </div>

  <div class="posts-grid">
    {#each paginatedPosts as post}
      <div class="post-card">
        <div class="post-header">
          <div class="platform-info">
            <span class="platform-icon">{getPlatformIcon(post.platform)}</span>
            <span class="platform-name" style="color: {getPlatformColor(post.platform)}">
              {post.platform.charAt(0).toUpperCase() + post.platform.slice(1)}
            </span>
          </div>
          <span class="post-time">{post.timeAgo}</span>
        </div>

        <div class="post-image">
          <img src="/images/{post.image}" alt="Post image" />
        </div>

        <div class="post-content">
          <h3 class="post-title">{post.title}</h3>
          <p class="post-text">{post.content}</p>
        </div>

        <div class="post-stats">
          <div class="stat-item">
            <span class="stat-icon">👍</span>
            <span class="stat-value">{post.likes.toLocaleString()}</span>
          </div>
          <div class="stat-item">
            <span class="stat-icon">🔄</span>
            <span class="stat-value">{post.shares.toLocaleString()}</span>
          </div>
          <div class="stat-item">
            <span class="stat-icon">💬</span>
            <span class="stat-value">{post.comments.toLocaleString()}</span>
          </div>
        </div>

        <div class="post-actions">
          <button 
            class="action-btn like" 
            on:click={() => handleAction('Like', post)}
            title="Like this post"
          >
            👍
          </button>
          <button 
            class="action-btn share" 
            on:click={() => handleAction('Share', post)}
            title="Share this post"
          >
            🔄
          </button>
          <button 
            class="action-btn comment" 
            on:click={() => handleAction('Comment', post)}
            title="Comment on this post"
          >
            💬
          </button>
          <button 
            class="action-btn edit" 
            on:click={() => handleAction('Edit', post)}
            title="Edit this post"
          >
            ✏️
          </button>
          <button 
            class="action-btn delete" 
            on:click={() => handleAction('Delete', post)}
            title="Delete this post"
          >
            🗑️
          </button>
        </div>
      </div>
    {/each}
  </div>

  {#if totalPages > 1}
    <div class="pagination">
      <button 
        class="page-btn" 
        on:click={prevPage} 
        disabled={currentPage === 1}
      >
        Previous
      </button>
      
      {#each Array(totalPages) as _, i}
        <button 
          class="page-btn {currentPage === i + 1 ? 'active' : ''}" 
          on:click={() => goToPage(i + 1)}
        >
          {i + 1}
        </button>
      {/each}
      
      <button 
        class="page-btn" 
        on:click={nextPage} 
        disabled={currentPage === totalPages}
      >
        Next
      </button>
    </div>
  {/if}
</div>

<style>
  .social-media-manager {
    max-width: 1200px;
    margin: 50px auto;
    padding: 20px;
    font-family: Arial, sans-serif;
  }

  .app-header {
    text-align: center;
    margin-bottom: 30px;
  }

  .app-header h1 {
    margin: 0 0 10px 0;
    font-size: 32px;
    color: #333;
  }

  .app-header p {
    margin: 0;
    color: #666;
    font-size: 16px;
  }

  .controls-section {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 30px;
    padding: 20px;
    background: #f8f9fa;
    border-radius: 8px;
  }

  .filter-controls {
    display: flex;
    gap: 15px;
  }

  .platform-filter,
  .sort-filter {
    padding: 8px 12px;
    border: 1px solid #ddd;
    border-radius: 4px;
    background: white;
  }

  .view-controls {
    display: flex;
    border: 1px solid #ddd;
    border-radius: 4px;
    overflow: hidden;
  }

  .view-btn {
    padding: 8px 16px;
    border: none;
    background: white;
    cursor: pointer;
    transition: background-color 0.2s ease;
  }

  .view-btn.active {
    background: #007bff;
    color: white;
  }

  .stats-overview {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
    gap: 20px;
    margin-bottom: 30px;
  }

  .stat-card {
    background: white;
    padding: 20px;
    border-radius: 8px;
    text-align: center;
    box-shadow: 0 2px 8px rgba(0,0,0,0.1);
  }

  .stat-number {
    font-size: 28px;
    font-weight: bold;
    color: #007bff;
    margin-bottom: 5px;
  }

  .stat-label {
    font-size: 14px;
    color: #666;
  }

  .posts-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
    gap: 20px;
    margin-bottom: 30px;
  }

  .post-card {
    background: white;
    border-radius: 8px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.1);
    overflow: hidden;
    transition: transform 0.2s ease, box-shadow 0.2s ease;
  }

  .post-card:hover {
    transform: translateY(-2px);
    box-shadow: 0 4px 16px rgba(0,0,0,0.15);
  }

  .post-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 15px;
    border-bottom: 1px solid #eee;
  }

  .platform-info {
    display: flex;
    align-items: center;
    gap: 8px;
  }

  .platform-icon {
    font-size: 18px;
  }

  .platform-name {
    font-weight: bold;
    font-size: 14px;
  }

  .post-time {
    font-size: 12px;
    color: #666;
  }

  .post-image {
    height: 200px;
    overflow: hidden;
  }

  .post-image img {
    width: 100%;
    height: 100%;
    object-fit: cover;
  }

  .post-content {
    padding: 15px;
  }

  .post-title {
    margin: 0 0 10px 0;
    font-size: 16px;
    color: #333;
  }

  .post-text {
    margin: 0;
    color: #666;
    font-size: 14px;
    line-height: 1.4;
  }

  .post-stats {
    display: flex;
    justify-content: space-around;
    padding: 15px;
    border-top: 1px solid #eee;
    background: #f8f9fa;
  }

  .stat-item {
    display: flex;
    align-items: center;
    gap: 5px;
  }

  .stat-icon {
    font-size: 14px;
  }

  .stat-value {
    font-size: 12px;
    font-weight: bold;
    color: #666;
  }

  .post-actions {
    display: flex;
    justify-content: space-around;
    padding: 10px 15px;
    background: white;
  }

  .action-btn {
    background: none;
    border: none;
    font-size: 16px;
    cursor: pointer;
    padding: 5px;
    border-radius: 4px;
    transition: background-color 0.2s ease;
  }

  .action-btn:hover {
    background: #f8f9fa;
  }

  .action-btn.like:hover {
    background: #e3f2fd;
  }

  .action-btn.share:hover {
    background: #f3e5f5;
  }

  .action-btn.comment:hover {
    background: #e8f5e8;
  }

  .action-btn.edit:hover {
    background: #fff3e0;
  }

  .action-btn.delete:hover {
    background: #ffebee;
  }

  .pagination {
    display: flex;
    justify-content: center;
    gap: 5px;
    margin-top: 30px;
  }

  .page-btn {
    padding: 8px 12px;
    border: 1px solid #ddd;
    background: white;
    cursor: pointer;
    border-radius: 4px;
    transition: background-color 0.2s ease;
  }

  .page-btn:hover:not(:disabled) {
    background: #f8f9fa;
  }

  .page-btn.active {
    background: #007bff;
    color: white;
    border-color: #007bff;
  }

  .page-btn:disabled {
    opacity: 0.5;
    cursor: not-allowed;
  }
</style>

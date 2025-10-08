<script>
  import { onMount } from 'svelte';
  
  let showCreatePost = false;
  let isLoading = false;
  let isLoadingMore = false;
  let currentFilter = 'all';
  let unreadNotifications = 3;
  let newPost = {
    content: '',
    image: null
  };
  let isPublishing = false;
  let newComment = {};
  let currentUser = {
    id: 1,
    name: 'John Doe',
    username: 'johndoe',
    avatar: 'https://via.placeholder.com/40x40/4caf50/fff?text=JD',
    followers: 1250,
    following: 340
  };
  
  let trendingTopics = [
    { id: 1, name: 'technology', count: 12500 },
    { id: 2, name: 'design', count: 8900 },
    { id: 3, name: 'programming', count: 15600 },
    { id: 4, name: 'startup', count: 6700 },
    { id: 5, name: 'innovation', count: 4200 }
  ];
  
  let suggestedUsers = [
    {
      id: 2,
      name: 'Jane Smith',
      username: 'janesmith',
      avatar: 'https://via.placeholder.com/40x40/2196f3/fff?text=JS',
      isFollowing: false
    },
    {
      id: 3,
      name: 'Mike Johnson',
      username: 'mikej',
      avatar: 'https://via.placeholder.com/40x40/ff9800/fff?text=MJ',
      isFollowing: false
    },
    {
      id: 4,
      name: 'Sarah Wilson',
      username: 'sarahw',
      avatar: 'https://via.placeholder.com/40x40/9c27b0/fff?text=SW',
      isFollowing: true
    }
  ];
  
  let posts = [
    {
      id: 1,
      user: {
        id: 2,
        name: 'Jane Smith',
        username: 'janesmith',
        avatar: 'https://via.placeholder.com/40x40/2196f3/fff?text=JS'
      },
      content: 'Just finished building an amazing new feature for our app! The team collaboration has been incredible. #coding #teamwork #innovation',
      image: 'https://via.placeholder.com/400x200/4caf50/fff?text=Code+Screen',
      location: 'San Francisco, CA',
      timestamp: new Date(Date.now() - 2 * 60 * 60 * 1000),
      likes: 24,
      retweets: 8,
      comments: [
        {
          id: 1,
          user: {
            id: 1,
            name: 'John Doe',
            username: 'johndoe',
            avatar: 'https://via.placeholder.com/30x30/4caf50/fff?text=JD'
          },
          text: 'Great work! Looking forward to seeing it in action.',
          timestamp: new Date(Date.now() - 1 * 60 * 60 * 1000)
        }
      ],
      isLiked: false,
      isRetweeted: false,
      showComments: false,
      showMenu: false
    },
    {
      id: 2,
      user: {
        id: 3,
        name: 'Mike Johnson',
        username: 'mikej',
        avatar: 'https://via.placeholder.com/40x40/ff9800/fff?text=MJ'
      },
      content: 'Beautiful sunset from my office window today. Sometimes you need to take a moment to appreciate the little things. 🌅',
      image: 'https://via.placeholder.com/400x300/ff9800/fff?text=Sunset',
      location: 'New York, NY',
      timestamp: new Date(Date.now() - 4 * 60 * 60 * 1000),
      likes: 156,
      retweets: 23,
      comments: [],
      isLiked: true,
      isRetweeted: false,
      showComments: false,
      showMenu: false
    },
    {
      id: 3,
      user: {
        id: 4,
        name: 'Sarah Wilson',
        username: 'sarahw',
        avatar: 'https://via.placeholder.com/40x40/9c27b0/fff?text=SW'
      },
      content: 'Excited to announce that our startup just secured Series A funding! 🎉 Thank you to all our supporters and the amazing team that made this possible.',
      image: null,
      location: 'Austin, TX',
      timestamp: new Date(Date.now() - 6 * 60 * 60 * 1000),
      likes: 89,
      retweets: 45,
      comments: [
        {
          id: 2,
          user: {
            id: 2,
            name: 'Jane Smith',
            username: 'janesmith',
            avatar: 'https://via.placeholder.com/30x30/2196f3/fff?text=JS'
          },
          text: 'Congratulations! This is amazing news! 🎉',
          timestamp: new Date(Date.now() - 5 * 60 * 60 * 1000)
        },
        {
          id: 3,
          user: {
            id: 3,
            name: 'Mike Johnson',
            username: 'mikej',
            avatar: 'https://via.placeholder.com/30x30/ff9800/fff?text=MJ'
          },
          text: 'Well deserved! Your product is incredible.',
          timestamp: new Date(Date.now() - 4 * 60 * 60 * 1000)
        }
      ],
      isLiked: false,
      isRetweeted: true,
      showComments: false,
      showMenu: false
    }
  ];
  
  let postsPerPage = 10;
  let currentPage = 1;
  
  onMount(() => {
    // Initialize feed
  });
  
  function setFilter(filter) {
    currentFilter = filter;
    currentPage = 1;
  }
  
  function searchTopic(topic) {
    console.log('Searching for topic:', topic);
    newPost.content = `#${topic} `;
  }
  
  function followUser(userId) {
    const user = suggestedUsers.find(u => u.id === userId);
    if (user) {
      user.isFollowing = !user.isFollowing;
      console.log(`${user.isFollowing ? 'Following' : 'Unfollowed'} ${user.name}`);
    }
  }
  
  function selectImage() {
    const input = document.createElement('input');
    input.type = 'file';
    input.accept = 'image/*';
    input.onchange = (e) => {
      const file = e.target.files[0];
      if (file) {
        const reader = new FileReader();
        reader.onload = (e) => {
          newPost.image = e.target.result;
        };
        reader.readAsDataURL(file);
      }
    };
    input.click();
  }
  
  function removeImage() {
    newPost.image = null;
  }
  
  function addEmoji() {
    const emojis = ['😀', '😂', '😍', '🤔', '👍', '👏', '🎉', '🔥', '💯', '✨'];
    const randomEmoji = emojis[Math.floor(Math.random() * emojis.length)];
    newPost.content += randomEmoji;
  }
  
  function addLocation() {
    newPost.location = 'Current Location';
  }
  
  function publishPost() {
    if (!newPost.content.trim()) return;
    
    isPublishing = true;
    
    setTimeout(() => {
      const newPostData = {
        id: Date.now(),
        user: { ...currentUser },
        content: newPost.content,
        image: newPost.image,
        location: newPost.location || null,
        timestamp: new Date(),
        likes: 0,
        retweets: 0,
        comments: [],
        isLiked: false,
        isRetweeted: false,
        showComments: false,
        showMenu: false
      };
      
      posts = [newPostData, ...posts];
      newPost = { content: '', image: null };
      showCreatePost = false;
      isPublishing = false;
      
      console.log('Post published:', newPostData);
    }, 1000);
  }
  
  function toggleLike(postId) {
    const post = posts.find(p => p.id === postId);
    if (post) {
      post.isLiked = !post.isLiked;
      post.likes += post.isLiked ? 1 : -1;
    }
  }
  
  function toggleRetweet(postId) {
    const post = posts.find(p => p.id === postId);
    if (post) {
      post.isRetweeted = !post.isRetweeted;
      post.retweets += post.isRetweeted ? 1 : -1;
    }
  }
  
  function toggleComment(postId) {
    const post = posts.find(p => p.id === postId);
    if (post) {
      post.showComments = !post.showComments;
      if (!newComment[postId]) {
        newComment[postId] = '';
      }
    }
  }
  
  function addComment(postId) {
    const post = posts.find(p => p.id === postId);
    const commentText = newComment[postId];
    
    if (post && commentText?.trim()) {
      const newCommentData = {
        id: Date.now(),
        user: { ...currentUser },
        text: commentText,
        timestamp: new Date()
      };
      
      post.comments.push(newCommentData);
      newComment[postId] = '';
      
      console.log('Comment added:', newCommentData);
    }
  }
  
  function sharePost(postId) {
    const post = posts.find(p => p.id === postId);
    if (post) {
      console.log('Sharing post:', post.content);
      alert(`Sharing: ${post.content.substring(0, 50)}...`);
    }
  }
  
  function togglePostMenu(postId) {
    posts.forEach(post => {
      post.showMenu = post.id === postId ? !post.showMenu : false;
    });
  }
  
  function reportPost(postId) {
    console.log('Reporting post:', postId);
    alert('Post reported. Thank you for helping keep our community safe.');
    togglePostMenu(null);
  }
  
  function blockUser(userId) {
    console.log('Blocking user:', userId);
    alert('User blocked successfully.');
    togglePostMenu(null);
  }
  
  function deletePost(postId) {
    if (confirm('Are you sure you want to delete this post?')) {
      posts = posts.filter(p => p.id !== postId);
      console.log('Post deleted:', postId);
    }
    togglePostMenu(null);
  }
  
  function loadMorePosts() {
    isLoadingMore = true;
    
    setTimeout(() => {
      currentPage++;
      isLoadingMore = false;
    }, 1000);
  }
  
  function formatTime(timestamp) {
    const now = new Date();
    const diff = now - timestamp;
    const minutes = Math.floor(diff / 60000);
    const hours = Math.floor(diff / 3600000);
    const days = Math.floor(diff / 86400000);
    
    if (minutes < 60) {
      return `${minutes}m`;
    } else if (hours < 24) {
      return `${hours}h`;
    } else {
      return `${days}d`;
    }
  }
  
  $: filteredPosts = (() => {
    let filtered = [...posts];
    
    switch (currentFilter) {
      case 'following':
        const followingIds = suggestedUsers
          .filter(user => user.isFollowing)
          .map(user => user.id);
        filtered = filtered.filter(post => 
          followingIds.includes(post.user.id) || post.user.id === currentUser.id
        );
        break;
      case 'trending':
        filtered = filtered.sort((a, b) => (b.likes + b.retweets) - (a.likes + a.retweets));
        break;
      default:
        break;
    }
    
    return filtered;
  })();
  
  $: paginatedPosts = filteredPosts.slice(0, currentPage * postsPerPage);
  
  $: hasMorePosts = paginatedPosts.length < filteredPosts.length;
</script>

<div class="social-media-feed">
  <div class="feed-header">
    <h1>Social Feed</h1>
    <div class="header-actions">
      <button 
        on:click={() => showCreatePost = !showCreatePost}
        class="create-post-btn"
      >
        + Create Post
      </button>
      <div class="notification-badge" class:show={unreadNotifications > 0}>
        {unreadNotifications}
      </div>
    </div>
  </div>

  <div class="feed-container">
    <div class="feed-sidebar">
      <div class="user-profile">
        <div class="profile-avatar">
          <img src={currentUser.avatar} alt={currentUser.name} />
        </div>
        <div class="profile-info">
          <h3>{currentUser.name}</h3>
          <p>@{currentUser.username}</p>
          <div class="profile-stats">
            <div class="stat">
              <span class="stat-number">{currentUser.followers}</span>
              <span class="stat-label">Followers</span>
            </div>
            <div class="stat">
              <span class="stat-number">{currentUser.following}</span>
              <span class="stat-label">Following</span>
            </div>
          </div>
        </div>
      </div>

      <div class="trending-topics">
        <h3>Trending</h3>
        <div class="trending-list">
          {#each trendingTopics as topic}
            <div 
              class="trending-item"
              on:click={() => searchTopic(topic.name)}
            >
              <span class="trending-hashtag">#{topic.name}</span>
              <span class="trending-count">{topic.count} posts</span>
            </div>
          {/each}
        </div>
      </div>

      <div class="suggested-users">
        <h3>Suggested for you</h3>
        <div class="suggestions-list">
          {#each suggestedUsers as user}
            <div class="suggestion-item">
              <div class="suggestion-avatar">
                <img src={user.avatar} alt={user.name} />
              </div>
              <div class="suggestion-info">
                <h4>{user.name}</h4>
                <p>@{user.username}</p>
              </div>
              <button 
                on:click={() => followUser(user.id)}
                class="follow-btn"
                class:following={user.isFollowing}
              >
                {user.isFollowing ? 'Following' : 'Follow'}
              </button>
            </div>
          {/each}
        </div>
      </div>
    </div>

    <div class="feed-main">
      {#if showCreatePost}
        <div class="create-post">
          <div class="post-header">
            <div class="post-avatar">
              <img src={currentUser.avatar} alt={currentUser.name} />
            </div>
            <div class="post-user-info">
              <h4>{currentUser.name}</h4>
              <p>@{currentUser.username}</p>
            </div>
            <button 
              on:click={() => showCreatePost = false}
              class="close-post-btn"
            >
              ✕
            </button>
          </div>
          
          <div class="post-content">
            <textarea
              bind:value={newPost.content}
              placeholder="What's happening?"
              class="post-textarea"
              rows="4"
            ></textarea>
            {#if newPost.image}
              <div class="post-image-preview">
                <img src={newPost.image} alt={newPost.content} />
                <button 
                  on:click={removeImage}
                  class="remove-image-btn"
                >
                  ✕
                </button>
              </div>
            {/if}
          </div>
          
          <div class="post-actions">
            <div class="post-tools">
              <button 
                on:click={selectImage}
                class="tool-btn"
                title="Add Image"
              >
                📷
              </button>
              <button 
                on:click={addEmoji}
                class="tool-btn"
                title="Add Emoji"
              >
                😊
              </button>
              <button 
                on:click={addLocation}
                class="tool-btn"
                title="Add Location"
              >
                📍
              </button>
            </div>
            
            <div class="post-controls">
              <span class="character-count">{newPost.content.length}/280</span>
              <button 
                on:click={publishPost}
                disabled={!newPost.content.trim() || isPublishing}
                class="publish-btn"
              >
                {isPublishing ? 'Publishing...' : 'Post'}
              </button>
            </div>
          </div>
        </div>
      {/if}

      <div class="feed-filters">
        <button 
          on:click={() => setFilter('all')}
          class="filter-btn"
          class:active={currentFilter === 'all'}
        >
          All Posts
        </button>
        <button 
          on:click={() => setFilter('following')}
          class="filter-btn"
          class:active={currentFilter === 'following'}
        >
          Following
        </button>
        <button 
          on:click={() => setFilter('trending')}
          class="filter-btn"
          class:active={currentFilter === 'trending'}
        >
          Trending
        </button>
      </div>

      <div class="posts-container">
        {#if isLoading}
          <div class="loading-state">
            <div class="loading-spinner"></div>
            <p>Loading posts...</p>
          </div>
        {:else if paginatedPosts.length === 0}
          <div class="no-posts">
            <div class="no-posts-icon">📝</div>
            <h3>No posts found</h3>
            <p>Try adjusting your filters or check back later</p>
          </div>
        {:else}
          <div class="posts-list">
            {#each paginatedPosts as post}
              <div class="post-item">
                <div class="post-header">
                  <div class="post-avatar">
                    <img src={post.user.avatar} alt={post.user.name} />
                  </div>
                  <div class="post-user-info">
                    <h4>{post.user.name}</h4>
                    <p>@{post.user.username} · {formatTime(post.timestamp)}</p>
                  </div>
                  <div class="post-menu">
                    <button 
                      on:click={() => togglePostMenu(post.id)}
                      class="menu-btn"
                    >
                      ⋮
                    </button>
                    {#if post.showMenu}
                      <div class="post-menu-dropdown">
                        <button on:click={() => reportPost(post.id)} class="menu-item">Report</button>
                        <button on:click={() => blockUser(post.user.id)} class="menu-item">Block User</button>
                        {#if post.user.id === currentUser.id}
                          <button on:click={() => deletePost(post.id)} class="menu-item delete">Delete</button>
                        {/if}
                      </div>
                    {/if}
                  </div>
                </div>

                <div class="post-content">
                  <p class="post-text">{post.content}</p>
                  
                  {#if post.image}
                    <div class="post-image">
                      <img src={post.image} alt={post.content} />
                    </div>
                  {/if}
                  
                  {#if post.location}
                    <div class="post-location">
                      📍 {post.location}
                    </div>
                  {/if}
                </div>

                <div class="post-actions">
                  <button 
                    on:click={() => toggleLike(post.id)}
                    class="action-btn like-btn"
                    class:liked={post.isLiked}
                  >
                    <span class="action-icon">{post.isLiked ? '❤️' : '🤍'}</span>
                    <span class="action-count">{post.likes}</span>
                  </button>
                  
                  <button 
                    on:click={() => toggleRetweet(post.id)}
                    class="action-btn retweet-btn"
                    class:retweeted={post.isRetweeted}
                  >
                    <span class="action-icon">🔄</span>
                    <span class="action-count">{post.retweets}</span>
                  </button>
                  
                  <button 
                    on:click={() => toggleComment(post.id)}
                    class="action-btn comment-btn"
                  >
                    <span class="action-icon">💬</span>
                    <span class="action-count">{post.comments.length}</span>
                  </button>
                  
                  <button 
                    on:click={() => sharePost(post.id)}
                    class="action-btn share-btn"
                  >
                    <span class="action-icon">📤</span>
                  </button>
                </div>

                {#if post.showComments}
                  <div class="comments-section">
                    <div class="add-comment">
                      <div class="comment-avatar">
                        <img src={currentUser.avatar} alt={currentUser.name} />
                      </div>
                      <div class="comment-input-container">
                        <input
                          bind:value={newComment[post.id]}
                          on:keyup={(e) => e.key === 'Enter' && addComment(post.id)}
                          type="text"
                          placeholder="Write a comment..."
                          class="comment-input"
                        />
                        <button 
                          on:click={() => addComment(post.id)}
                          disabled={!newComment[post.id]?.trim()}
                          class="comment-btn"
                        >
                          Post
                        </button>
                      </div>
                    </div>
                    
                    <div class="comments-list">
                      {#each post.comments as comment}
                        <div class="comment-item">
                          <div class="comment-avatar">
                            <img src={comment.user.avatar} alt={comment.user.name} />
                          </div>
                          <div class="comment-content">
                            <div class="comment-header">
                              <h5>{comment.user.name}</h5>
                              <span class="comment-time">{formatTime(comment.timestamp)}</span>
                            </div>
                            <p class="comment-text">{comment.text}</p>
                          </div>
                        </div>
                      {/each}
                    </div>
                  </div>
                {/if}
              </div>
            {/each}
          </div>
        {/if}

        {#if hasMorePosts}
          <div class="load-more">
            <button 
              on:click={loadMorePosts}
              disabled={isLoadingMore}
              class="load-more-btn"
            >
              {isLoadingMore ? 'Loading...' : 'Load More Posts'}
            </button>
          </div>
        {/if}
      </div>
    </div>
  </div>
</div>

<style>
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
    margin-bottom: 30px;
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

  .create-post-btn {
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

  .create-post-btn:hover {
    background: #45a049;
  }

  .notification-badge {
    width: 20px;
    height: 20px;
    background: #f44336;
    color: white;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 12px;
    font-weight: bold;
    opacity: 0;
    transition: opacity 0.3s ease;
  }

  .notification-badge.show {
    opacity: 1;
  }

  .feed-container {
    display: grid;
    grid-template-columns: 300px 1fr;
    gap: 30px;
  }

  .feed-sidebar {
    display: flex;
    flex-direction: column;
    gap: 25px;
  }

  .user-profile {
    background: #f8f9fa;
    border: 1px solid #e0e0e0;
    border-radius: 8px;
    padding: 20px;
  }

  .profile-avatar {
    width: 60px;
    height: 60px;
    border-radius: 50%;
    overflow: hidden;
    margin-bottom: 15px;
  }

  .profile-avatar img {
    width: 100%;
    height: 100%;
    object-fit: cover;
  }

  .profile-info h3 {
    margin: 0 0 5px 0;
    color: #333;
    font-size: 18px;
  }

  .profile-info p {
    margin: 0 0 15px 0;
    color: #666;
    font-size: 14px;
  }

  .profile-stats {
    display: flex;
    gap: 20px;
  }

  .stat {
    text-align: center;
  }

  .stat-number {
    display: block;
    font-size: 18px;
    font-weight: bold;
    color: #333;
  }

  .stat-label {
    font-size: 12px;
    color: #666;
  }

  .trending-topics,
  .suggested-users {
    background: #f8f9fa;
    border: 1px solid #e0e0e0;
    border-radius: 8px;
    padding: 20px;
  }

  .trending-topics h3,
  .suggested-users h3 {
    margin: 0 0 15px 0;
    color: #333;
    font-size: 16px;
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
    padding: 8px 0;
    cursor: pointer;
    transition: background-color 0.3s ease;
    border-radius: 4px;
  }

  .trending-item:hover {
    background: #e8f5e8;
  }

  .trending-hashtag {
    color: #4caf50;
    font-weight: 600;
    font-size: 14px;
  }

  .trending-count {
    color: #666;
    font-size: 12px;
  }

  .suggestions-list {
    display: flex;
    flex-direction: column;
    gap: 12px;
  }

  .suggestion-item {
    display: flex;
    align-items: center;
    gap: 10px;
  }

  .suggestion-avatar {
    width: 40px;
    height: 40px;
    border-radius: 50%;
    overflow: hidden;
    flex-shrink: 0;
  }

  .suggestion-avatar img {
    width: 100%;
    height: 100%;
    object-fit: cover;
  }

  .suggestion-info {
    flex: 1;
    min-width: 0;
  }

  .suggestion-info h4 {
    margin: 0 0 2px 0;
    color: #333;
    font-size: 14px;
    font-weight: 600;
  }

  .suggestion-info p {
    margin: 0;
    color: #666;
    font-size: 12px;
  }

  .follow-btn {
    padding: 4px 12px;
    border: 1px solid #4caf50;
    background: white;
    color: #4caf50;
    border-radius: 4px;
    cursor: pointer;
    font-size: 12px;
    font-weight: 600;
    transition: all 0.3s ease;
  }

  .follow-btn:hover {
    background: #4caf50;
    color: white;
  }

  .follow-btn.following {
    background: #4caf50;
    color: white;
  }

  .follow-btn.following:hover {
    background: #f44336;
    border-color: #f44336;
  }

  .feed-main {
    display: flex;
    flex-direction: column;
    gap: 20px;
  }

  .create-post {
    background: white;
    border: 1px solid #e0e0e0;
    border-radius: 8px;
    padding: 20px;
  }

  .post-header {
    display: flex;
    align-items: center;
    gap: 12px;
    margin-bottom: 15px;
  }

  .post-avatar {
    width: 40px;
    height: 40px;
    border-radius: 50%;
    overflow: hidden;
    flex-shrink: 0;
  }

  .post-avatar img {
    width: 100%;
    height: 100%;
    object-fit: cover;
  }

  .post-user-info {
    flex: 1;
  }

  .post-user-info h4 {
    margin: 0 0 2px 0;
    color: #333;
    font-size: 14px;
    font-weight: 600;
  }

  .post-user-info p {
    margin: 0;
    color: #666;
    font-size: 12px;
  }

  .close-post-btn {
    background: none;
    border: none;
    font-size: 16px;
    cursor: pointer;
    color: #666;
    padding: 4px;
  }

  .post-content {
    margin-bottom: 15px;
  }

  .post-textarea {
    width: 100%;
    border: none;
    outline: none;
    font-size: 16px;
    line-height: 1.5;
    color: #333;
    resize: none;
    font-family: inherit;
  }

  .post-textarea::placeholder {
    color: #999;
  }

  .post-image-preview {
    position: relative;
    margin-top: 15px;
    border-radius: 8px;
    overflow: hidden;
  }

  .post-image-preview img {
    width: 100%;
    max-height: 300px;
    object-fit: cover;
  }

  .remove-image-btn {
    position: absolute;
    top: 10px;
    right: 10px;
    width: 30px;
    height: 30px;
    background: rgba(0, 0, 0, 0.7);
    color: white;
    border: none;
    border-radius: 50%;
    cursor: pointer;
    font-size: 14px;
    display: flex;
    align-items: center;
    justify-content: center;
  }

  .post-actions {
    display: flex;
    justify-content: space-between;
    align-items: center;
  }

  .post-tools {
    display: flex;
    gap: 10px;
  }

  .tool-btn {
    width: 36px;
    height: 36px;
    border: 1px solid #ddd;
    background: white;
    border-radius: 6px;
    cursor: pointer;
    font-size: 16px;
    display: flex;
    align-items: center;
    justify-content: center;
    transition: all 0.3s ease;
  }

  .tool-btn:hover {
    background: #f0f0f0;
    border-color: #4caf50;
  }

  .post-controls {
    display: flex;
    align-items: center;
    gap: 15px;
  }

  .character-count {
    font-size: 12px;
    color: #666;
  }

  .publish-btn {
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

  .publish-btn:hover:not(:disabled) {
    background: #45a049;
  }

  .publish-btn:disabled {
    background: #ccc;
    cursor: not-allowed;
  }

  .feed-filters {
    display: flex;
    gap: 10px;
    background: white;
    border: 1px solid #e0e0e0;
    border-radius: 8px;
    padding: 15px;
  }

  .filter-btn {
    padding: 8px 16px;
    border: 1px solid #ddd;
    background: white;
    border-radius: 6px;
    cursor: pointer;
    font-size: 14px;
    font-weight: 600;
    transition: all 0.3s ease;
  }

  .filter-btn:hover {
    background: #f0f0f0;
    border-color: #4caf50;
  }

  .filter-btn.active {
    background: #4caf50;
    color: white;
    border-color: #4caf50;
  }

  .posts-container {
    display: flex;
    flex-direction: column;
    gap: 20px;
  }

  .loading-state {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    padding: 60px 20px;
    color: #666;
  }

  .loading-spinner {
    width: 40px;
    height: 40px;
    border: 4px solid #f3f3f3;
    border-top: 4px solid #4caf50;
    border-radius: 50%;
    animation: spin 1s linear infinite;
    margin-bottom: 20px;
  }

  @keyframes spin {
    0% { transform: rotate(0deg); }
    100% { transform: rotate(360deg); }
  }

  .no-posts {
    text-align: center;
    padding: 60px 20px;
    color: #666;
  }

  .no-posts-icon {
    font-size: 48px;
    margin-bottom: 20px;
  }

  .no-posts h3 {
    margin: 0 0 10px 0;
    color: #333;
    font-size: 20px;
  }

  .no-posts p {
    margin: 0;
    font-size: 14px;
  }

  .posts-list {
    display: flex;
    flex-direction: column;
    gap: 20px;
  }

  .post-item {
    background: white;
    border: 1px solid #e0e0e0;
    border-radius: 8px;
    padding: 20px;
    transition: all 0.3s ease;
  }

  .post-item:hover {
    border-color: #4caf50;
    box-shadow: 0 2px 8px rgba(76, 175, 80, 0.1);
  }

  .post-item .post-header {
    margin-bottom: 15px;
  }

  .post-menu {
    position: relative;
  }

  .menu-btn {
    width: 32px;
    height: 32px;
    border: none;
    background: none;
    cursor: pointer;
    font-size: 16px;
    color: #666;
    border-radius: 4px;
    transition: background-color 0.3s ease;
  }

  .menu-btn:hover {
    background: #f0f0f0;
  }

  .post-menu-dropdown {
    position: absolute;
    top: 100%;
    right: 0;
    background: white;
    border: 1px solid #e0e0e0;
    border-radius: 6px;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
    z-index: 10;
    min-width: 120px;
  }

  .menu-item {
    display: block;
    width: 100%;
    padding: 8px 12px;
    border: none;
    background: none;
    text-align: left;
    cursor: pointer;
    font-size: 14px;
    color: #333;
    transition: background-color 0.3s ease;
  }

  .menu-item:hover {
    background: #f0f0f0;
  }

  .menu-item.delete {
    color: #f44336;
  }

  .post-content .post-text {
    margin: 0 0 15px 0;
    color: #333;
    font-size: 16px;
    line-height: 1.5;
  }

  .post-image {
    margin-bottom: 15px;
    border-radius: 8px;
    overflow: hidden;
  }

  .post-image img {
    width: 100%;
    max-height: 400px;
    object-fit: cover;
  }

  .post-location {
    color: #666;
    font-size: 14px;
    margin-bottom: 15px;
  }

  .post-actions {
    display: flex;
    gap: 20px;
    padding-top: 15px;
    border-top: 1px solid #f0f0f0;
  }

  .action-btn {
    display: flex;
    align-items: center;
    gap: 6px;
    padding: 8px 12px;
    border: none;
    background: none;
    cursor: pointer;
    font-size: 14px;
    color: #666;
    border-radius: 6px;
    transition: all 0.3s ease;
  }

  .action-btn:hover {
    background: #f0f0f0;
  }

  .action-btn.liked {
    color: #f44336;
  }

  .action-btn.retweeted {
    color: #4caf50;
  }

  .action-icon {
    font-size: 16px;
  }

  .action-count {
    font-size: 12px;
    font-weight: 600;
  }

  .comments-section {
    margin-top: 15px;
    padding-top: 15px;
    border-top: 1px solid #f0f0f0;
  }

  .add-comment {
    display: flex;
    gap: 10px;
    margin-bottom: 15px;
  }

  .comment-avatar {
    width: 32px;
    height: 32px;
    border-radius: 50%;
    overflow: hidden;
    flex-shrink: 0;
  }

  .comment-avatar img {
    width: 100%;
    height: 100%;
    object-fit: cover;
  }

  .comment-input-container {
    flex: 1;
    display: flex;
    gap: 10px;
  }

  .comment-input {
    flex: 1;
    padding: 8px 12px;
    border: 1px solid #ddd;
    border-radius: 6px;
    font-size: 14px;
    outline: none;
  }

  .comment-input:focus {
    border-color: #4caf50;
  }

  .comment-btn {
    padding: 8px 16px;
    background: #4caf50;
    color: white;
    border: none;
    border-radius: 6px;
    cursor: pointer;
    font-size: 12px;
    font-weight: 600;
    transition: background-color 0.3s ease;
  }

  .comment-btn:hover:not(:disabled) {
    background: #45a049;
  }

  .comment-btn:disabled {
    background: #ccc;
    cursor: not-allowed;
  }

  .comments-list {
    display: flex;
    flex-direction: column;
    gap: 12px;
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

  .comment-header h5 {
    margin: 0;
    color: #333;
    font-size: 14px;
    font-weight: 600;
  }

  .comment-time {
    color: #666;
    font-size: 12px;
  }

  .comment-text {
    margin: 0;
    color: #333;
    font-size: 14px;
    line-height: 1.4;
  }

  .load-more {
    text-align: center;
    padding: 20px;
  }

  .load-more-btn {
    padding: 12px 24px;
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

  @media (max-width: 1024px) {
    .feed-container {
      grid-template-columns: 250px 1fr;
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
    
    .feed-filters {
      flex-direction: column;
      gap: 8px;
    }
    
    .filter-btn {
      text-align: center;
    }
    
    .post-actions {
      flex-wrap: wrap;
      gap: 10px;
    }
    
    .action-btn {
      flex: 1;
      min-width: 80px;
      justify-content: center;
    }
  }

  @media (max-width: 480px) {
    .social-media-feed {
      padding: 10px;
    }
    
    .create-post {
      padding: 15px;
    }
    
    .post-item {
      padding: 15px;
    }
    
    .post-actions {
      flex-direction: column;
    }
    
    .action-btn {
      flex: none;
      width: 100%;
    }
    
    .comment-input-container {
      flex-direction: column;
    }
    
    .comment-btn {
      align-self: flex-end;
    }
  }
</style>

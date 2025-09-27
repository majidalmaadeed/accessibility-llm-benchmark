<script>
  export let data
  
  let socialData = null
  let newPost = ''
  let selectedImage = null
  let showComposeModal = false
  let showComments = {}
  let commentText = {}
  let likedPosts = new Set()
  let retweetedPosts = new Set()
  let bookmarkedPosts = new Set()
  
  $: {
    if (data) {
      socialData = JSON.parse(data)
    }
  }
  
  function createPost() {
    if (newPost.trim()) {
      const post = {
        id: Date.now(),
        username: 'John Doe',
        avatar: 'JD',
        timestamp: 'Just now',
        text: newPost,
        likes: 0,
        retweets: 0,
        comments: 0,
        liked: false,
        retweeted: false,
        bookmarked: false
      }
      
      if (socialData) {
        socialData.posts.unshift(post)
      }
      
      newPost = ''
      showComposeModal = false
    }
  }
  
  function toggleLike(postId) {
    if (likedPosts.has(postId)) {
      likedPosts.delete(postId)
    } else {
      likedPosts.add(postId)
    }
    likedPosts = likedPosts
  }
  
  function toggleRetweet(postId) {
    if (retweetedPosts.has(postId)) {
      retweetedPosts.delete(postId)
    } else {
      retweetedPosts.add(postId)
    }
    retweetedPosts = retweetedPosts
  }
  
  function toggleBookmark(postId) {
    if (bookmarkedPosts.has(postId)) {
      bookmarkedPosts.delete(postId)
    } else {
      bookmarkedPosts.add(postId)
    }
    bookmarkedPosts = bookmarkedPosts
  }
  
  function toggleComments(postId) {
    showComments[postId] = !showComments[postId]
    showComments = showComments
  }
  
  function addComment(postId) {
    const text = commentText[postId]
    if (text && text.trim()) {
      // Add comment logic here
      commentText[postId] = ''
    }
  }
  
  function sharePost(postId) {
    alert(`Sharing post ${postId}`)
  }
  
  function followUser(username) {
    alert(`Following @${username}`)
  }
  
  function muteUser(username) {
    alert(`Muted @${username}`)
  }
  
  function reportPost(postId) {
    alert(`Reported post ${postId}`)
  }
  
  function blockUser(username) {
    alert(`Blocked @${username}`)
  }
  
  function attachImage() {
    alert('Image attachment feature')
  }
  
  function attachVideo() {
    alert('Video attachment feature')
  }
  
  function attachGif() {
    alert('GIF attachment feature')
  }
  
  function addLocation() {
    alert('Location feature')
  }
  
  function addPoll() {
    alert('Poll feature')
  }
  
  function scrollToTop() {
    window.scrollTo({ top: 0, behavior: 'smooth' })
  }
</script>

<div class="social-feed-container">
  <div class="feed-header">
    <div class="header-content">
      <div class="profile-avatar">JD</div>
      <div class="profile-info">
        <h2>John Doe</h2>
        <p>Welcome back! What's on your mind?</p>
      </div>
    </div>
  </div>
  
  <div class="compose-area">
    <div class="compose-input" on:click={() => showComposeModal = true}>
      <span class="placeholder">What's happening?</span>
    </div>
    <div class="compose-actions">
      <div class="compose-options">
        <button class="compose-btn" on:click={attachImage} title="Add Image">📷</button>
        <button class="compose-btn" on:click={attachVideo} title="Add Video">🎥</button>
        <button class="compose-btn" on:click={attachGif} title="Add GIF">🎬</button>
        <button class="compose-btn" on:click={addLocation} title="Add Location">📍</button>
        <button class="compose-btn" on:click={addPoll} title="Add Poll">📊</button>
      </div>
      <button class="post-btn" on:click={() => showComposeModal = true}>Post</button>
    </div>
  </div>
  
  <div class="feed-posts">
    {#if socialData?.posts}
      {#each socialData.posts as post}
        <div class="post-card">
          <div class="post-header">
            <div class="post-avatar">{post.avatar}</div>
            <div class="post-user-info">
              <h3 class="post-username">{post.username}</h3>
              <p class="post-timestamp">{post.timestamp}</p>
            </div>
            <div class="post-menu">
              <button class="post-menu-btn" on:click={() => alert('Post menu')}>⋯</button>
            </div>
          </div>
          
          <div class="post-content">
            <div class="post-text">{post.text}</div>
          </div>
          
          <div class="post-actions">
            <button class="action-btn" 
                    class:liked={likedPosts.has(post.id)}
                    on:click={() => toggleLike(post.id)}>
              <span class="action-icon">{likedPosts.has(post.id) ? '❤️' : '🤍'}</span>
              <span class="action-count">{post.likes}</span>
            </button>
            <button class="action-btn" 
                    class:retweeted={retweetedPosts.has(post.id)}
                    on:click={() => toggleRetweet(post.id)}>
              <span class="action-icon">🔄</span>
              <span class="action-count">{post.retweets}</span>
            </button>
            <button class="action-btn" on:click={() => toggleComments(post.id)}>
              <span class="action-icon">💬</span>
              <span class="action-count">{post.comments}</span>
            </button>
            <button class="action-btn" 
                    class:bookmarked={bookmarkedPosts.has(post.id)}
                    on:click={() => toggleBookmark(post.id)}>
              <span class="action-icon">{bookmarkedPosts.has(post.id) ? '🔖' : '📌'}</span>
            </button>
            <button class="action-btn" on:click={() => sharePost(post.id)}>
              <span class="action-icon">📤</span>
            </button>
          </div>
          
          {#if showComments[post.id]}
            <div class="comments-section">
              <div class="comment-input">
                <div class="comment-avatar">JD</div>
                <textarea class="comment-textarea" 
                          bind:value={commentText[post.id]}
                          placeholder="Write a comment..."></textarea>
                <button class="comment-btn" on:click={() => addComment(post.id)}>Reply</button>
              </div>
            </div>
          {/if}
        </div>
      {/each}
    {/if}
  </div>
  
  <button class="floating-action-btn" on:click={scrollToTop}>↑</button>
</div>

{#if showComposeModal}
  <div class="compose-modal">
    <div class="compose-modal-content">
      <div class="compose-modal-header">
        <h2>Create Post</h2>
        <button class="close-btn" on:click={() => showComposeModal = false}>&times;</button>
      </div>
      
      <div class="compose-modal-body">
        <textarea class="compose-textarea" 
                  bind:value={newPost}
                  placeholder="What's happening?"></textarea>
        
        <div class="compose-options">
          <button class="compose-btn" on:click={attachImage}>📷</button>
          <button class="compose-btn" on:click={attachVideo}>🎥</button>
          <button class="compose-btn" on:click={attachGif}>🎬</button>
          <button class="compose-btn" on:click={addLocation}>📍</button>
          <button class="compose-btn" on:click={addPoll}>📊</button>
        </div>
      </div>
      
      <div class="compose-modal-footer">
        <button class="btn btn-secondary" on:click={() => showComposeModal = false}>Cancel</button>
        <button class="btn btn-primary" on:click={createPost} disabled={!newPost.trim()}>Post</button>
      </div>
    </div>
  </div>
{/if}

<style>
  .social-feed-container {
    max-width: 800px;
    margin: 0 auto;
  }
  
  .feed-header {
    background: white;
    padding: 20px;
    border-radius: 12px;
    box-shadow: 0 2px 10px rgba(0,0,0,0.1);
    margin-bottom: 20px;
  }
  
  .header-content {
    display: flex;
    align-items: center;
    gap: 15px;
  }
  
  .profile-avatar {
    width: 50px;
    height: 50px;
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    color: white;
    font-size: 20px;
    font-weight: bold;
  }
  
  .profile-info h2 {
    margin: 0;
    font-size: 18px;
    color: #333;
  }
  
  .profile-info p {
    margin: 0;
    font-size: 14px;
    color: #666;
  }
  
  .compose-area {
    background: white;
    border-radius: 12px;
    padding: 20px;
    box-shadow: 0 2px 10px rgba(0,0,0,0.1);
    margin-bottom: 20px;
  }
  
  .compose-input {
    width: 100%;
    min-height: 100px;
    border: none;
    outline: none;
    font-size: 16px;
    resize: vertical;
    font-family: inherit;
    cursor: pointer;
  }
  
  .compose-input .placeholder {
    color: #999;
  }
  
  .compose-actions {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-top: 15px;
    padding-top: 15px;
    border-top: 1px solid #f0f0f0;
  }
  
  .compose-options {
    display: flex;
    gap: 15px;
  }
  
  .compose-btn {
    background: none;
    border: none;
    cursor: pointer;
    font-size: 20px;
    color: #666;
    padding: 8px;
    border-radius: 4px;
    transition: background 0.2s ease;
  }
  
  .compose-btn:hover {
    background: #f8f9fa;
  }
  
  .post-btn {
    background: #007bff;
    color: white;
    border: none;
    padding: 10px 20px;
    border-radius: 20px;
    cursor: pointer;
    font-weight: 600;
  }
  
  .post-btn:hover {
    background: #0056b3;
  }
  
  .post-btn:disabled {
    background: #ccc;
    cursor: not-allowed;
  }
  
  .feed-posts {
    display: flex;
    flex-direction: column;
    gap: 20px;
  }
  
  .post-card {
    background: white;
    border-radius: 12px;
    box-shadow: 0 2px 10px rgba(0,0,0,0.1);
    overflow: hidden;
  }
  
  .post-header {
    display: flex;
    align-items: center;
    padding: 15px 20px;
    gap: 12px;
  }
  
  .post-avatar {
    width: 40px;
    height: 40px;
    border-radius: 50%;
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    display: flex;
    align-items: center;
    justify-content: center;
    color: white;
    font-weight: bold;
  }
  
  .post-user-info {
    flex: 1;
  }
  
  .post-username {
    font-weight: 600;
    color: #333;
    margin: 0;
    font-size: 14px;
  }
  
  .post-timestamp {
    font-size: 12px;
    color: #666;
    margin: 0;
  }
  
  .post-menu {
    position: relative;
  }
  
  .post-menu-btn {
    background: none;
    border: none;
    cursor: pointer;
    font-size: 16px;
    color: #666;
    padding: 5px;
  }
  
  .post-content {
    padding: 0 20px 15px;
  }
  
  .post-text {
    font-size: 16px;
    line-height: 1.5;
    color: #333;
    margin-bottom: 15px;
  }
  
  .post-actions {
    display: flex;
    justify-content: space-around;
    padding: 10px 20px;
    border-top: 1px solid #f0f0f0;
  }
  
  .action-btn {
    display: flex;
    align-items: center;
    gap: 8px;
    background: none;
    border: none;
    cursor: pointer;
    padding: 8px 12px;
    border-radius: 6px;
    font-size: 14px;
    color: #666;
    transition: background 0.2s ease;
  }
  
  .action-btn:hover {
    background: #f8f9fa;
  }
  
  .action-btn.liked {
    color: #e74c3c;
  }
  
  .action-btn.retweeted {
    color: #1abc9c;
  }
  
  .action-btn.bookmarked {
    color: #f39c12;
  }
  
  .action-icon {
    font-size: 16px;
  }
  
  .action-count {
    font-size: 12px;
  }
  
  .comments-section {
    padding: 15px 20px;
    border-top: 1px solid #f0f0f0;
    background: #f8f9fa;
  }
  
  .comment-input {
    display: flex;
    gap: 10px;
    margin-bottom: 15px;
  }
  
  .comment-avatar {
    width: 32px;
    height: 32px;
    border-radius: 50%;
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    display: flex;
    align-items: center;
    justify-content: center;
    color: white;
    font-size: 12px;
    font-weight: bold;
  }
  
  .comment-textarea {
    flex: 1;
    border: 1px solid #ddd;
    border-radius: 20px;
    padding: 10px 15px;
    resize: none;
    font-size: 14px;
    outline: none;
  }
  
  .comment-btn {
    background: #007bff;
    color: white;
    border: none;
    padding: 8px 16px;
    border-radius: 20px;
    cursor: pointer;
    font-size: 14px;
  }
  
  .comment-btn:hover {
    background: #0056b3;
  }
  
  .floating-action-btn {
    position: fixed;
    bottom: 20px;
    right: 20px;
    width: 56px;
    height: 56px;
    background: #007bff;
    color: white;
    border: none;
    border-radius: 50%;
    cursor: pointer;
    font-size: 24px;
    box-shadow: 0 4px 12px rgba(0,0,0,0.3);
    z-index: 1000;
  }
  
  .floating-action-btn:hover {
    background: #0056b3;
  }
  
  .compose-modal {
    position: fixed;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background: rgba(0,0,0,0.5);
    display: flex;
    align-items: center;
    justify-content: center;
    z-index: 1000;
  }
  
  .compose-modal-content {
    background: white;
    border-radius: 12px;
    padding: 20px;
    max-width: 500px;
    width: 90%;
    max-height: 80vh;
    overflow-y: auto;
  }
  
  .compose-modal-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 20px;
    padding-bottom: 15px;
    border-bottom: 2px solid #f0f0f0;
  }
  
  .compose-modal-header h2 {
    margin: 0;
    color: #333;
  }
  
  .close-btn {
    background: none;
    border: none;
    font-size: 24px;
    cursor: pointer;
    color: #666;
  }
  
  .compose-modal-body {
    margin-bottom: 20px;
  }
  
  .compose-textarea {
    width: 100%;
    min-height: 100px;
    border: none;
    outline: none;
    font-size: 16px;
    resize: vertical;
    font-family: inherit;
  }
  
  .compose-modal-footer {
    display: flex;
    gap: 10px;
    justify-content: flex-end;
  }
  
  .btn {
    padding: 10px 20px;
    border: none;
    border-radius: 6px;
    cursor: pointer;
    font-size: 14px;
    font-weight: 600;
  }
  
  .btn-primary {
    background: #007bff;
    color: white;
  }
  
  .btn-primary:hover {
    background: #0056b3;
  }
  
  .btn-primary:disabled {
    background: #ccc;
    cursor: not-allowed;
  }
  
  .btn-secondary {
    background: #6c757d;
    color: white;
  }
  
  .btn-secondary:hover {
    background: #545b62;
  }
</style>

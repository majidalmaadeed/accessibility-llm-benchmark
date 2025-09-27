import React, { useState } from 'react';

const SocialFeed = () => {
  const [posts, setPosts] = useState([
    {
      id: 1,
      user: 'John Doe',
      avatar: '👨',
      time: '2 hours ago',
      content: 'Just finished working on a new project! #coding #development',
      image: 'https://via.placeholder.com/400x200/007bff/ffffff?text=Project+Update',
      likes: 15,
      comments: 3,
      shares: 2,
      isLiked: false
    },
    {
      id: 2,
      user: 'Jane Smith',
      avatar: '👩',
      time: '4 hours ago',
      content: 'Beautiful sunset today! 🌅',
      image: 'https://via.placeholder.com/400x200/ff6b6b/ffffff?text=Sunset',
      likes: 8,
      comments: 1,
      shares: 0,
      isLiked: false
    },
    {
      id: 3,
      user: 'Mike Johnson',
      avatar: '👨‍💼',
      time: '6 hours ago',
      content: 'Great meeting with the team today. Excited about the new features!',
      image: null,
      likes: 12,
      comments: 5,
      shares: 1,
      isLiked: false
    }
  ]);

  const [newPost, setNewPost] = useState({
    content: '',
    image: null,
    privacy: 'public'
  });
  const [showComposeModal, setShowComposeModal] = useState(false);
  const [selectedPost, setSelectedPost] = useState(null);
  const [showComments, setShowComments] = useState({});

  const handleLike = (postId) => {
    setPosts(posts.map(post => {
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

  const handleComment = (postId) => {
    setShowComments(prev => ({
      ...prev,
      [postId]: !prev[postId]
    }));
  };

  const handleShare = (postId) => {
    setPosts(posts.map(post => {
      if (post.id === postId) {
        return {
          ...post,
          shares: post.shares + 1
        };
      }
      return post;
    }));
    alert('Post shared!');
  };

  const handleCreatePost = () => {
    if (newPost.content.trim()) {
      const post = {
        id: Date.now(),
        user: 'You',
        avatar: '👤',
        time: 'Just now',
        content: newPost.content,
        image: newPost.image,
        likes: 0,
        comments: 0,
        shares: 0,
        isLiked: false
      };
      setPosts([post, ...posts]);
      setNewPost({ content: '', image: null, privacy: 'public' });
      setShowComposeModal(false);
    }
  };

  const handleImageUpload = (e) => {
    const file = e.target.files[0];
    if (file) {
      const reader = new FileReader();
      reader.onload = (e) => {
        setNewPost(prev => ({
          ...prev,
          image: e.target.result
        }));
      };
      reader.readAsDataURL(file);
    }
  };

  const handlePostAction = (postId, action) => {
    switch (action) {
      case 'like':
        handleLike(postId);
        break;
      case 'comment':
        handleComment(postId);
        break;
      case 'share':
        handleShare(postId);
        break;
      case 'save':
        alert('Post saved!');
        break;
      case 'report':
        if (window.confirm('Report this post?')) {
          alert('Post reported');
        }
        break;
      default:
        break;
    }
  };

  const formatTime = (timeStr) => {
    return timeStr;
  };

  return (
    <div className="container">
      <div className="page-header">
        <h1 className="page-title">Social Media Feed</h1>
        <p className="page-subtitle">
          Social media feed with posts and interactions
        </p>
      </div>

      <div className="card">
        <div style={{ display: 'flex', gap: '1rem', marginBottom: '1rem' }}>
          <div style={{ fontSize: '2rem' }}>👤</div>
          <div style={{ flex: 1 }}>
            <input
              type="text"
              className="form-control"
              placeholder="What's on your mind?"
              value={newPost.content}
              onChange={(e) => setNewPost(prev => ({ ...prev, content: e.target.value }))}
              onClick={() => setShowComposeModal(true)}
            />
          </div>
          <button className="btn" onClick={() => setShowComposeModal(true)}>
            Post
          </button>
        </div>
      </div>

      <div style={{ maxWidth: '600px', margin: '0 auto' }}>
        {posts.map(post => (
          <div key={post.id} className="social-post">
            <div className="post-header">
              <div className="post-avatar">{post.avatar}</div>
              <div style={{ flex: 1 }}>
                <div className="post-user">{post.user}</div>
                <div className="post-time">{formatTime(post.time)}</div>
              </div>
              <div style={{ position: 'relative' }}>
                <button
                  className="btn btn-secondary"
                  onClick={() => setSelectedPost(selectedPost === post.id ? null : post.id)}
                  style={{ padding: '0.25rem 0.5rem', fontSize: '0.8rem' }}
                >
                  ⋯
                </button>
                {selectedPost === post.id && (
                  <div style={{
                    position: 'absolute',
                    top: '100%',
                    right: 0,
                    background: 'white',
                    border: '1px solid #ddd',
                    borderRadius: '4px',
                    boxShadow: '0 2px 10px rgba(0,0,0,0.1)',
                    zIndex: 1000,
                    minWidth: '120px'
                  }}>
                    <button
                      className="btn btn-secondary"
                      onClick={() => handlePostAction(post.id, 'save')}
                      style={{ width: '100%', textAlign: 'left', border: 'none', borderRadius: 0 }}
                    >
                      Save Post
                    </button>
                    <button
                      className="btn btn-secondary"
                      onClick={() => handlePostAction(post.id, 'report')}
                      style={{ width: '100%', textAlign: 'left', border: 'none', borderRadius: 0 }}
                    >
                      Report
                    </button>
                  </div>
                )}
              </div>
            </div>

            <div className="post-content">
              {post.content}
            </div>

            {post.image && (
              <div style={{ margin: '1rem 0' }}>
                <img
                  src={post.image}
                  alt="Post content"
                  style={{
                    width: '100%',
                    height: '200px',
                    objectFit: 'cover',
                    borderRadius: '8px'
                  }}
                />
              </div>
            )}

            <div className="post-actions">
              <button
                className={`post-action ${post.isLiked ? 'liked' : ''}`}
                onClick={() => handlePostAction(post.id, 'like')}
              >
                {post.isLiked ? '❤️' : '🤍'} {post.likes}
              </button>
              <button
                className="post-action"
                onClick={() => handlePostAction(post.id, 'comment')}
              >
                💬 {post.comments}
              </button>
              <button
                className="post-action"
                onClick={() => handlePostAction(post.id, 'share')}
              >
                🔄 {post.shares}
              </button>
            </div>

            {showComments[post.id] && (
              <div style={{ 
                marginTop: '1rem', 
                padding: '1rem', 
                background: '#f8f9fa', 
                borderRadius: '8px' 
              }}>
                <div style={{ marginBottom: '1rem' }}>
                  <input
                    type="text"
                    className="form-control"
                    placeholder="Write a comment..."
                    style={{ marginBottom: '0.5rem' }}
                  />
                  <button className="btn" style={{ fontSize: '0.8rem', padding: '0.25rem 0.75rem' }}>
                    Comment
                  </button>
                </div>
                <div style={{ fontSize: '0.9rem', color: '#666' }}>
                  Comments feature would be implemented here
                </div>
              </div>
            )}
          </div>
        ))}
      </div>

      {showComposeModal && (
        <div className="modal">
          <div className="modal-content">
            <div className="modal-header">
              <h3 className="modal-title">Create Post</h3>
              <button className="modal-close" onClick={() => setShowComposeModal(false)}>
                ×
              </button>
            </div>
            <div className="form-group">
              <textarea
                className="form-control"
                rows="4"
                placeholder="What's on your mind?"
                value={newPost.content}
                onChange={(e) => setNewPost(prev => ({ ...prev, content: e.target.value }))}
              />
            </div>
            <div className="form-group">
              <label className="form-label">Add Image</label>
              <input
                type="file"
                className="form-control"
                accept="image/*"
                onChange={handleImageUpload}
              />
            </div>
            <div className="form-group">
              <label className="form-label">Privacy</label>
              <select
                className="form-control"
                value={newPost.privacy}
                onChange={(e) => setNewPost(prev => ({ ...prev, privacy: e.target.value }))}
              >
                <option value="public">Public</option>
                <option value="friends">Friends Only</option>
                <option value="private">Private</option>
              </select>
            </div>
            <div className="modal-footer">
              <button className="btn btn-secondary" onClick={() => setShowComposeModal(false)}>
                Cancel
              </button>
              <button className="btn" onClick={handleCreatePost}>
                Post
              </button>
            </div>
          </div>
        </div>
      )}
    </div>
  );
};

export default SocialFeed;

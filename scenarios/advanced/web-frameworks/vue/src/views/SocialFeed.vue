<template>
  <div class="container">
    <div class="page-header">
      <h1 class="page-title">Social Media Feed</h1>
      <p class="page-subtitle">
        Social media feed with posts and interactions
      </p>
    </div>

    <div class="card">
      <div style="display: flex; gap: 1rem; margin-bottom: 1rem">
        <div style="font-size: 2rem">👤</div>
        <div style="flex: 1">
          <input
            type="text"
            class="form-control"
            placeholder="What's on your mind?"
            v-model="newPost.content"
            @click="showComposeModal = true"
          />
        </div>
        <button class="btn" @click="showComposeModal = true">
          Post
        </button>
      </div>
    </div>

    <div style="max-width: 600px; margin: 0 auto">
      <div
        v-for="post in posts"
        :key="post.id"
        class="social-post"
      >
        <div class="post-header">
          <div class="post-avatar">{{ post.avatar }}</div>
          <div style="flex: 1">
            <div class="post-user">{{ post.user }}</div>
            <div class="post-time">{{ formatTime(post.time) }}</div>
          </div>
          <div style="position: relative">
            <button
              class="btn btn-secondary"
              @click="selectedPost = selectedPost === post.id ? null : post.id"
              style="padding: 0.25rem 0.5rem; fontSize: 0.8rem"
            >
              ⋯
            </button>
            <div
              v-if="selectedPost === post.id"
              style="position: absolute; top: 100%; right: 0; background: white; border: 1px solid #ddd; borderRadius: 4px; boxShadow: 0 2px 10px rgba(0,0,0,0.1); zIndex: 1000; minWidth: 120px"
            >
              <button
                class="btn btn-secondary"
                @click="handlePostAction(post.id, 'save')"
                style="width: 100%; text-align: left; border: none; borderRadius: 0"
              >
                Save Post
              </button>
              <button
                class="btn btn-secondary"
                @click="handlePostAction(post.id, 'report')"
                style="width: 100%; text-align: left; border: none; borderRadius: 0"
              >
                Report
              </button>
            </div>
          </div>
        </div>

        <div class="post-content">
          {{ post.content }}
        </div>

        <div v-if="post.image" style="margin: 1rem 0">
          <img
            :src="post.image"
            alt="Post content"
            style="width: 100%; height: 200px; object-fit: cover; borderRadius: 8px"
          />
        </div>

        <div class="post-actions">
          <button
            :class="['post-action', { liked: post.isLiked }]"
            @click="handleLike(post.id)"
          >
            {{ post.isLiked ? '❤️' : '🤍' }} {{ post.likes }}
          </button>
          <button
            class="post-action"
            @click="handleComment(post.id)"
          >
            💬 {{ post.comments }}
          </button>
          <button
            class="post-action"
            @click="handleShare(post.id)"
          >
            🔄 {{ post.shares }}
          </button>
        </div>

        <div
          v-if="showComments[post.id]"
          style="margin-top: 1rem; padding: 1rem; background: #f8f9fa; borderRadius: 8px"
        >
          <div style="margin-bottom: 1rem">
            <input
              type="text"
              class="form-control"
              placeholder="Write a comment..."
              style="margin-bottom: 0.5rem"
            />
            <button class="btn" style="fontSize: 0.8rem; padding: 0.25rem 0.75rem">
              Comment
            </button>
          </div>
          <div style="fontSize: 0.9rem; color: #666">
            Comments feature would be implemented here
          </div>
        </div>
      </div>
    </div>

    <div v-if="showComposeModal" class="modal">
      <div class="modal-content">
        <div class="modal-header">
          <h3 class="modal-title">Create Post</h3>
          <button class="modal-close" @click="showComposeModal = false">
            ×
          </button>
        </div>
        <div class="form-group">
          <textarea
            class="form-control"
            rows="4"
            placeholder="What's on your mind?"
            v-model="newPost.content"
          />
        </div>
        <div class="form-group">
          <label class="form-label">Add Image</label>
          <input
            type="file"
            class="form-control"
            accept="image/*"
            @change="handleImageUpload"
          />
        </div>
        <div class="form-group">
          <label class="form-label">Privacy</label>
          <select
            class="form-control"
            v-model="newPost.privacy"
          >
            <option value="public">Public</option>
            <option value="friends">Friends Only</option>
            <option value="private">Private</option>
          </select>
        </div>
        <div class="modal-footer">
          <button class="btn btn-secondary" @click="showComposeModal = false">
            Cancel
          </button>
          <button class="btn" @click="handleCreatePost">
            Post
          </button>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'SocialFeed',
  data() {
    return {
      posts: [
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
      ],
      newPost: {
        content: '',
        image: null,
        privacy: 'public'
      },
      showComposeModal: false,
      selectedPost: null,
      showComments: {}
    }
  },
  methods: {
    handleLike(postId) {
      const post = this.posts.find(p => p.id === postId)
      if (post) {
        post.isLiked = !post.isLiked
        post.likes += post.isLiked ? 1 : -1
      }
    },
    handleComment(postId) {
      this.showComments = {
        ...this.showComments,
        [postId]: !this.showComments[postId]
      }
    },
    handleShare(postId) {
      const post = this.posts.find(p => p.id === postId)
      if (post) {
        post.shares++
      }
      alert('Post shared!')
    },
    handleCreatePost() {
      if (this.newPost.content.trim()) {
        const post = {
          id: Date.now(),
          user: 'You',
          avatar: '👤',
          time: 'Just now',
          content: this.newPost.content,
          image: this.newPost.image,
          likes: 0,
          comments: 0,
          shares: 0,
          isLiked: false
        }
        this.posts.unshift(post)
        this.newPost = { content: '', image: null, privacy: 'public' }
        this.showComposeModal = false
      }
    },
    handleImageUpload(e) {
      const file = e.target.files[0]
      if (file) {
        const reader = new FileReader()
        reader.onload = (e) => {
          this.newPost.image = e.target.result
        }
        reader.readAsDataURL(file)
      }
    },
    handlePostAction(postId, action) {
      switch (action) {
        case 'save':
          alert('Post saved!')
          break
        case 'report':
          if (window.confirm('Report this post?')) {
            alert('Post reported')
          }
          break
        default:
          break
      }
      this.selectedPost = null
    },
    formatTime(timeStr) {
      return timeStr
    }
  }
}
</script>

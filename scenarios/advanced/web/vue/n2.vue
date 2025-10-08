<template>
  <div class="main-container">
    <div class="main-content">
      <div class="header">
        <div>
          <h1>News Feed</h1>
          <p>Stay updated with the latest news and articles.</p>
        </div>
        <div class="header-controls">
          <button @click="handleRefresh" :disabled="isLoading" class="refresh-button">
            {{ isLoading ? 'Refreshing...' : 'Refresh Now' }}
          </button>
          <div class="last-update">
            Last updated: {{ lastUpdate.toLocaleTimeString() }}
          </div>
        </div>
      </div>

      <!-- Auto-refresh Controls -->
      <div class="auto-refresh-controls">
        <label class="control-label">
          <input type="checkbox" v-model="autoRefresh" />
          Auto-refresh every
        </label>
        <select v-model="refreshInterval" class="interval-select">
          <option :value="10">10 seconds</option>
          <option :value="30">30 seconds</option>
          <option :value="60">1 minute</option>
          <option :value="300">5 minutes</option>
        </select>
        <span v-if="autoRefresh" class="next-refresh">
          Next refresh in: {{ refreshInterval }}s
        </span>
      </div>

      <!-- Update Notification -->
      <div v-if="isLoading" class="update-notification">
        <strong>🔄 Updating content...</strong> New articles are being loaded.
      </div>

      <!-- Articles List -->
      <div class="articles-section">
        <div
          v-for="article in articles"
          :key="article.id"
          @click="handleArticleClick(article.id)"
          class="article-item"
        >
          <div class="article-header">
            <h3>{{ article.title }}</h3>
            <span class="category-badge">{{ article.category }}</span>
          </div>
          <p class="article-preview">{{ article.content.substring(0, 150) }}...</p>
          <div class="article-timestamp">{{ article.timestamp.toLocaleString() }}</div>
        </div>
      </div>

      <!-- Article Detail Modal -->
      <div v-if="userReadingArticle" class="modal-overlay" @click="handleCloseArticle">
        <div class="modal-content" @click.stop>
          <div v-if="selectedArticle" class="article-detail">
            <div class="modal-header">
              <h2>{{ selectedArticle.title }}</h2>
              <button @click="handleCloseArticle" class="close-button">×</button>
            </div>
            <div class="article-meta">
              <span class="category-badge">{{ selectedArticle.category }}</span>
              <span class="timestamp">{{ selectedArticle.timestamp.toLocaleString() }}</span>
            </div>
            <div class="article-content">
              <p>{{ selectedArticle.content }}</p>
              <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</p>
              <p>Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { ref, computed, onMounted, onUnmounted } from 'vue'

export default {
  name: 'AutoRefreshContentDisruption',
  setup() {
    const articles = ref([])
    const isLoading = ref(false)
    const lastUpdate = ref(new Date())
    const autoRefresh = ref(true)
    const refreshInterval = ref(30)
    const intervalRef = ref(null)
    const userReadingArticle = ref(null)

    const mockArticles = [
      { id: 1, title: 'Breaking: New Technology Breakthrough', content: 'Scientists have made a significant discovery...', timestamp: new Date(), category: 'Technology' },
      { id: 2, title: 'Market Update: Stock Prices Rise', content: 'The stock market showed positive trends today...', timestamp: new Date(), category: 'Finance' },
      { id: 3, title: 'Sports: Championship Game Results', content: 'The final game ended with an unexpected victory...', timestamp: new Date(), category: 'Sports' },
      { id: 4, title: 'Health: New Study on Nutrition', content: 'Recent research reveals important findings...', timestamp: new Date(), category: 'Health' },
      { id: 5, title: 'Entertainment: Award Show Highlights', content: 'The annual awards ceremony featured many surprises...', timestamp: new Date(), category: 'Entertainment' }
    ]

    const selectedArticle = computed(() => {
      return articles.value.find(a => a.id === userReadingArticle.value)
    })

    const fetchArticles = async () => {
      isLoading.value = true
      
      // Simulate API call
      await new Promise(resolve => setTimeout(resolve, 1000))
      
      // Simulate new articles being added
      const newArticles = [...mockArticles]
      if (Math.random() > 0.7) {
        const newArticle = {
          id: Date.now(),
          title: `Breaking News Update ${new Date().getHours()}:${new Date().getMinutes()}`,
          content: 'This is a new breaking news article that just came in...',
          timestamp: new Date(),
          category: 'Breaking'
        }
        newArticles.unshift(newArticle)
      }
      
      articles.value = newArticles
      lastUpdate.value = new Date()
      isLoading.value = false
    }

    const handleRefresh = () => {
      fetchArticles()
    }

    const handleArticleClick = (articleId) => {
      userReadingArticle.value = articleId
    }

    const handleCloseArticle = () => {
      userReadingArticle.value = null
    }

    // Auto-refresh setup
    const startAutoRefresh = () => {
      if (autoRefresh.value) {
        intervalRef.value = setInterval(() => {
          fetchArticles()
        }, refreshInterval.value * 1000)
      }
    }

    const stopAutoRefresh = () => {
      if (intervalRef.value) {
        clearInterval(intervalRef.value)
        intervalRef.value = null
      }
    }

    onMounted(() => {
      fetchArticles()
      startAutoRefresh()
    })

    onUnmounted(() => {
      stopAutoRefresh()
    })

    return {
      articles,
      isLoading,
      lastUpdate,
      autoRefresh,
      refreshInterval,
      userReadingArticle,
      selectedArticle,
      handleRefresh,
      handleArticleClick,
      handleCloseArticle
    }
  }
}
</script>

<style scoped>
.main-container {
  font-family: Arial, sans-serif;
  max-width: 1000px;
  margin: 50px auto;
  padding: 20px;
  background-color: #f5f5f5;
}

.main-content {
  background: white;
  padding: 30px;
  border-radius: 8px;
  box-shadow: 0 2px 10px rgba(0,0,0,0.1);
}

.header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 20px;
}

.header-controls {
  display: flex;
  align-items: center;
  gap: 10px;
}

.refresh-button {
  background-color: #007bff;
  color: white;
  padding: 8px 16px;
  border: none;
  border-radius: 4px;
  font-size: 14px;
  cursor: pointer;
}

.refresh-button:disabled {
  background-color: #6c757d;
  cursor: not-allowed;
}

.last-update {
  font-size: 12px;
  color: #666;
}

.auto-refresh-controls {
  padding: 15px;
  background-color: #e3f2fd;
  border-radius: 4px;
  margin-bottom: 20px;
  display: flex;
  align-items: center;
  gap: 15px;
}

.control-label {
  display: flex;
  align-items: center;
  gap: 5px;
  cursor: pointer;
}

.interval-select {
  padding: 4px 8px;
  border: 1px solid #ddd;
  border-radius: 4px;
}

.next-refresh {
  font-size: 12px;
  color: #666;
}

.update-notification {
  padding: 10px 15px;
  background-color: #d4edda;
  border: 1px solid #c3e6cb;
  border-radius: 4px;
  margin-bottom: 20px;
  color: #155724;
}

.articles-section {
  margin-top: 20px;
}

.article-item {
  padding: 20px;
  border: 1px solid #ddd;
  border-radius: 8px;
  margin-bottom: 16px;
  background-color: #fafafa;
  cursor: pointer;
  transition: background-color 0.2s ease;
}

.article-item:hover {
  background-color: #f0f0f0;
}

.article-header {
  display: flex;
  justify-content: space-between;
  align-items: flex-start;
  margin-bottom: 8px;
}

.article-header h3 {
  margin: 0;
  color: #333;
  font-size: 18px;
}

.category-badge {
  font-size: 12px;
  color: #666;
  background-color: #e9ecef;
  padding: 2px 8px;
  border-radius: 12px;
}

.article-preview {
  margin: 0 0 8px 0;
  color: #666;
  line-height: 1.5;
}

.article-timestamp {
  font-size: 12px;
  color: #999;
}

.modal-overlay {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background-color: rgba(0, 0, 0, 0.5);
  display: flex;
  align-items: center;
  justify-content: center;
  z-index: 1000;
}

.modal-content {
  background: white;
  padding: 30px;
  border-radius: 8px;
  max-width: 600px;
  width: 90%;
  max-height: 80%;
  overflow: auto;
}

.modal-header {
  display: flex;
  justify-content: space-between;
  align-items: flex-start;
  margin-bottom: 20px;
}

.modal-header h2 {
  margin: 0;
  color: #333;
}

.close-button {
  background: none;
  border: none;
  font-size: 24px;
  cursor: pointer;
  color: #666;
}

.article-meta {
  margin-bottom: 15px;
}

.timestamp {
  margin-left: 10px;
  font-size: 12px;
  color: #999;
}

.article-content {
  line-height: 1.6;
  color: #333;
}
</style>
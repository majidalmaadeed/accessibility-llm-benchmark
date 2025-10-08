<template>
  <div class="hero-page">
    <!-- Hero section video autoplays without user control -->
    <div class="background-video">
      <!-- Simulated video content -->
      <div class="video-content"></div>
      
      <!-- Animated overlay -->
      <div class="video-overlay"></div>
    </div>

    <!-- Main content -->
    <div class="main-content">
      <h1>Welcome to Our Platform</h1>
      <p>Experience the future of technology with our innovative solutions</p>
      
      <div class="cta-buttons">
        <button class="cta-btn primary">Get Started</button>
        <button class="cta-btn secondary">Learn More</button>
      </div>

      <!-- Features section -->
      <div class="features-section">
        <div class="feature-card">
          <h3>🚀 Innovation</h3>
          <p>Cutting-edge technology that pushes the boundaries of what's possible</p>
        </div>
        
        <div class="feature-card">
          <h3>🔒 Security</h3>
          <p>Enterprise-grade security to protect your data and privacy</p>
        </div>
        
        <div class="feature-card">
          <h3>⚡ Performance</h3>
          <p>Lightning-fast performance optimized for the best user experience</p>
        </div>
      </div>
    </div>

    <!-- Video controls overlay -->
    <div v-if="showControls" class="video-controls">
      <button @click="toggleMute" class="control-btn">
        {{ isMuted ? '🔇 Unmute' : '🔊 Mute' }}
      </button>
      <span class="control-text">Background video playing</span>
    </div>
  </div>
</template>

<script>
export default {
  name: 'AutoPlayingBackgroundVideo',
  data() {
    return {
      isMuted: true,
      showControls: false
    }
  },
  mounted() {
    // Simulate video loading and autoplay
    setTimeout(() => {
      this.showControls = true
    }, 2000)
  },
  methods: {
    toggleMute() {
      this.isMuted = !this.isMuted
    }
  }
}
</script>

<style scoped>
.hero-page {
  position: relative;
  min-height: 100vh;
  font-family: Arial, sans-serif;
}

.background-video {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background: linear-gradient(45deg, #1e3c72, #2a5298);
  z-index: -1;
  overflow: hidden;
}

.video-content {
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  width: 100%;
  height: 100%;
  background: url("https://via.placeholder.com/1920x1080/1e3c72/ffffff?text=Background+Video") center/cover;
  opacity: 0.3;
}

.video-overlay {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background: linear-gradient(45deg, transparent 30%, rgba(255,255,255,0.1) 50%, transparent 70%);
  animation: shimmer 3s infinite;
}

.main-content {
  position: relative;
  z-index: 1;
  padding: 50px 20px;
  color: white;
  text-align: center;
}

.main-content h1 {
  font-size: 48px;
  margin: 0 0 20px 0;
  font-weight: bold;
  text-shadow: 2px 2px 4px rgba(0,0,0,0.5);
}

.main-content p {
  font-size: 24px;
  margin: 0 0 40px 0;
  text-shadow: 1px 1px 2px rgba(0,0,0,0.5);
  max-width: 600px;
  margin: 0 auto 40px auto;
}

.cta-buttons {
  display: flex;
  gap: 20px;
  justify-content: center;
  flex-wrap: wrap;
  margin-bottom: 60px;
}

.cta-btn {
  padding: 15px 30px;
  border-radius: 25px;
  font-size: 18px;
  font-weight: bold;
  cursor: pointer;
  backdrop-filter: blur(10px);
  transition: all 0.3s ease;
}

.cta-btn.primary {
  background: rgba(255,255,255,0.2);
  color: white;
  border: 2px solid white;
}

.cta-btn.secondary {
  background: transparent;
  color: white;
  border: 2px solid white;
}

.features-section {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
  gap: 30px;
  max-width: 1000px;
  margin: 0 auto;
  padding: 40px 20px;
  background: rgba(0,0,0,0.3);
  border-radius: 12px;
  backdrop-filter: blur(10px);
}

.feature-card {
  padding: 30px;
  background: rgba(255,255,255,0.1);
  border-radius: 8px;
  border: 1px solid rgba(255,255,255,0.2);
}

.feature-card h3 {
  font-size: 24px;
  margin: 0 0 15px 0;
  color: white;
}

.feature-card p {
  font-size: 16px;
  line-height: 1.6;
  margin: 0;
  color: rgba(255,255,255,0.9);
}

.video-controls {
  position: fixed;
  bottom: 20px;
  right: 20px;
  background: rgba(0,0,0,0.8);
  color: white;
  padding: 15px;
  border-radius: 8px;
  z-index: 1000;
  display: flex;
  align-items: center;
  gap: 10px;
}

.control-btn {
  background: transparent;
  color: white;
  border: 1px solid white;
  padding: 8px 12px;
  border-radius: 4px;
  cursor: pointer;
  font-size: 14px;
}

.control-text {
  font-size: 12px;
  color: #ccc;
}

@keyframes shimmer {
  0% { transform: translateX(-100%); }
  100% { transform: translateX(100%); }
}
</style>

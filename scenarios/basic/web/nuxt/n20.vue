<template>
  <div class="media-player">
    <div class="player-container">
      <div class="video-wrapper">
        <video
          ref="videoPlayer"
          :src="currentVideo.src"
          :poster="currentVideo.poster"
          class="video-element"
          @loadedmetadata="onVideoLoaded"
          @timeupdate="onTimeUpdate"
          @ended="onVideoEnded"
        >
          Your browser does not support the video tag.
        </video>
        
        <div class="video-overlay" v-if="!isPlaying">
          <div class="play-button" @click="togglePlay">
            ▶️
          </div>
        </div>
      </div>

      <div class="player-controls">
        <div class="control-group">
          <button 
            class="control-btn"
            @click="togglePlay"
            :aria-label="isPlaying ? 'Pause video' : 'Play video'"
          >
            {{ isPlaying ? '⏸️' : '▶️' }}
          </button>
          
          <button 
            class="control-btn"
            @click="toggleMute"
            :aria-label="isMuted ? 'Unmute video' : 'Mute video'"
          >
            {{ isMuted ? '🔇' : '🔊' }}
          </button>
          
          <button 
            class="control-btn"
            @click="toggleFullscreen"
            aria-label="Toggle fullscreen"
          >
            ⛶
          </button>
        </div>

        <div class="progress-container">
          <div class="time-display">{{ formatTime(currentTime) }}</div>
          <div class="progress-bar" @click="seekTo">
            <div 
              class="progress-fill" 
              :style="{ width: progressPercentage + '%' }"
            ></div>
          </div>
          <div class="time-display">{{ formatTime(duration) }}</div>
        </div>

        <div class="volume-container">
          <input
            type="range"
            min="0"
            max="100"
            v-model="volume"
            @input="updateVolume"
            class="volume-slider"
            aria-label="Volume control"
          />
        </div>
      </div>
    </div>

    <div class="video-playlist">
      <h3>Video Playlist</h3>
      <div class="playlist-items">
        <div
          v-for="(video, index) in playlist"
          :key="video.id"
          class="playlist-item"
          :class="{ active: currentVideoIndex === index }"
          @click="playVideo(index)"
        >
          <div class="video-thumbnail">
            <img :src="video.thumbnail" :alt="video.title" />
            <div class="play-overlay">
              ▶️
            </div>
          </div>
          <div class="video-info">
            <h4 class="video-title">{{ video.title }}</h4>
            <p class="video-description">{{ video.description }}</p>
            <div class="video-meta">
              <span class="video-duration">{{ video.duration }}</span>
              <span class="video-views">{{ video.views }} views</span>
            </div>
          </div>
        </div>
      </div>
    </div>

    <div class="video-details">
      <h2 class="video-title-main">{{ currentVideo.title }}</h2>
      <p class="video-description-main">{{ currentVideo.description }}</p>
      
      <div class="video-stats">
        <div class="stat-item">
          <span class="stat-icon">👁️</span>
          <span class="stat-text">{{ currentVideo.views }} views</span>
        </div>
        <div class="stat-item">
          <span class="stat-icon">👍</span>
          <span class="stat-text">{{ currentVideo.likes }} likes</span>
        </div>
        <div class="stat-item">
          <span class="stat-icon">💬</span>
          <span class="stat-text">{{ currentVideo.comments }} comments</span>
        </div>
        <div class="stat-item">
          <span class="stat-icon">📅</span>
          <span class="stat-text">{{ formatDate(currentVideo.uploadDate) }}</span>
        </div>
      </div>

      <div class="action-buttons">
        <button class="action-btn like-btn">
          👍 Like
        </button>
        <button class="action-btn dislike-btn">
          👎 Dislike
        </button>
        <button class="action-btn share-btn">
          🔗 Share
        </button>
        <button class="action-btn save-btn">
          💾 Save
        </button>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, onMounted, onUnmounted } from 'vue'

const videoPlayer = ref(null)
const isPlaying = ref(false)
const isMuted = ref(false)
const currentTime = ref(0)
const duration = ref(0)
const volume = ref(50)
const currentVideoIndex = ref(0)

const playlist = ref([
  {
    id: 1,
    title: 'Amazing Nature Documentary',
    description: 'Explore the wonders of nature in this breathtaking documentary',
    src: '/api/placeholder/video1.mp4',
    poster: '/api/placeholder/800/450',
    thumbnail: '/api/placeholder/200/112',
    duration: '15:30',
    views: '2.5M',
    likes: '45K',
    comments: '1.2K',
    uploadDate: '2024-01-15'
  },
  {
    id: 2,
    title: 'City Life Time-lapse',
    description: 'Watch the city come alive in this stunning time-lapse video',
    src: '/api/placeholder/video2.mp4',
    poster: '/api/placeholder/800/450',
    thumbnail: '/api/placeholder/200/112',
    duration: '8:45',
    views: '1.8M',
    likes: '32K',
    comments: '890',
    uploadDate: '2024-01-10'
  },
  {
    id: 3,
    title: 'Space Exploration Journey',
    description: 'Join us on an incredible journey through space and beyond',
    src: '/api/placeholder/video3.mp4',
    poster: '/api/placeholder/800/450',
    thumbnail: '/api/placeholder/200/112',
    duration: '22:15',
    views: '3.2M',
    likes: '67K',
    comments: '2.1K',
    uploadDate: '2024-01-05'
  },
  {
    id: 4,
    title: 'Ocean Depths Adventure',
    description: 'Dive deep into the mysterious world beneath the waves',
    src: '/api/placeholder/video4.mp4',
    poster: '/api/placeholder/800/450',
    thumbnail: '/api/placeholder/200/112',
    duration: '12:20',
    views: '1.5M',
    likes: '28K',
    comments: '756',
    uploadDate: '2024-01-01'
  }
])

const currentVideo = computed(() => playlist.value[currentVideoIndex.value])

const progressPercentage = computed(() => {
  if (duration.value === 0) return 0
  return (currentTime.value / duration.value) * 100
})

const onVideoLoaded = () => {
  duration.value = videoPlayer.value.duration
  videoPlayer.value.volume = volume.value / 100
}

const onTimeUpdate = () => {
  currentTime.value = videoPlayer.value.currentTime
}

const onVideoEnded = () => {
  isPlaying.value = false
  playNextVideo()
}

const togglePlay = () => {
  if (videoPlayer.value) {
    if (isPlaying.value) {
      videoPlayer.value.pause()
    } else {
      videoPlayer.value.play()
    }
    isPlaying.value = !isPlaying.value
  }
}

const toggleMute = () => {
  if (videoPlayer.value) {
    videoPlayer.value.muted = !videoPlayer.value.muted
    isMuted.value = !isMuted.value
  }
}

const toggleFullscreen = () => {
  if (videoPlayer.value) {
    if (videoPlayer.value.requestFullscreen) {
      videoPlayer.value.requestFullscreen()
    }
  }
}

const seekTo = (event) => {
  if (videoPlayer.value && duration.value > 0) {
    const rect = event.currentTarget.getBoundingClientRect()
    const clickX = event.clientX - rect.left
    const percentage = clickX / rect.width
    const newTime = percentage * duration.value
    videoPlayer.value.currentTime = newTime
  }
}

const updateVolume = () => {
  if (videoPlayer.value) {
    videoPlayer.value.volume = volume.value / 100
  }
}

const playVideo = (index) => {
  currentVideoIndex.value = index
  isPlaying.value = false
  if (videoPlayer.value) {
    videoPlayer.value.load()
  }
}

const playNextVideo = () => {
  if (currentVideoIndex.value < playlist.value.length - 1) {
    playVideo(currentVideoIndex.value + 1)
  }
}

const formatTime = (time) => {
  const minutes = Math.floor(time / 60)
  const seconds = Math.floor(time % 60)
  return `${minutes}:${seconds.toString().padStart(2, '0')}`
}

const formatDate = (dateString) => {
  return new Date(dateString).toLocaleDateString('en-US', {
    year: 'numeric',
    month: 'long',
    day: 'numeric'
  })
}

const handleKeyPress = (event) => {
  switch (event.code) {
    case 'Space':
      event.preventDefault()
      togglePlay()
      break
    case 'KeyM':
      toggleMute()
      break
    case 'KeyF':
      toggleFullscreen()
      break
    case 'ArrowLeft':
      if (videoPlayer.value) {
        videoPlayer.value.currentTime = Math.max(0, videoPlayer.value.currentTime - 10)
      }
      break
    case 'ArrowRight':
      if (videoPlayer.value) {
        videoPlayer.value.currentTime = Math.min(
          videoPlayer.value.duration,
          videoPlayer.value.currentTime + 10
        )
      }
      break
  }
}

onMounted(() => {
  document.addEventListener('keydown', handleKeyPress)
})

onUnmounted(() => {
  document.removeEventListener('keydown', handleKeyPress)
})
</script>

<style scoped>
.media-player {
  max-width: 1200px;
  margin: 0 auto;
  padding: 20px;
  font-family: Arial, sans-serif;
}

.player-container {
  background: #000;
  border-radius: 8px;
  overflow: hidden;
  margin-bottom: 30px;
  position: relative;
}

.video-wrapper {
  position: relative;
  width: 100%;
  height: 0;
  padding-bottom: 56.25%;
}

.video-element {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.video-overlay {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background: rgba(0, 0, 0, 0.3);
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
}

.play-button {
  width: 80px;
  height: 80px;
  background: rgba(255, 255, 255, 0.9);
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 32px;
  transition: all 0.3s ease;
}

.play-button:hover {
  background: white;
  transform: scale(1.1);
}

.player-controls {
  background: #333;
  padding: 15px 20px;
  display: flex;
  align-items: center;
  gap: 20px;
}

.control-group {
  display: flex;
  gap: 10px;
}

.control-btn {
  background: none;
  border: none;
  color: white;
  font-size: 18px;
  cursor: pointer;
  padding: 8px;
  border-radius: 4px;
  transition: background-color 0.2s ease;
}

.control-btn:hover {
  background: rgba(255, 255, 255, 0.1);
}

.progress-container {
  flex: 1;
  display: flex;
  align-items: center;
  gap: 10px;
}

.time-display {
  color: white;
  font-size: 14px;
  font-weight: bold;
  min-width: 50px;
}

.progress-bar {
  flex: 1;
  height: 6px;
  background: #555;
  border-radius: 3px;
  cursor: pointer;
  position: relative;
}

.progress-fill {
  height: 100%;
  background: #ff0000;
  border-radius: 3px;
  transition: width 0.1s ease;
}

.volume-container {
  display: flex;
  align-items: center;
  gap: 10px;
}

.volume-slider {
  width: 80px;
  height: 4px;
  background: #555;
  border-radius: 2px;
  outline: none;
  cursor: pointer;
}

.volume-slider::-webkit-slider-thumb {
  appearance: none;
  width: 16px;
  height: 16px;
  background: #ff0000;
  border-radius: 50%;
  cursor: pointer;
}

.video-playlist {
  margin-bottom: 30px;
}

.video-playlist h3 {
  margin: 0 0 20px 0;
  font-size: 24px;
  color: #333;
}

.playlist-items {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
  gap: 20px;
}

.playlist-item {
  display: flex;
  gap: 15px;
  padding: 15px;
  border: 1px solid #ddd;
  border-radius: 8px;
  cursor: pointer;
  transition: all 0.2s ease;
  background: white;
}

.playlist-item:hover {
  box-shadow: 0 4px 8px rgba(0,0,0,0.1);
  transform: translateY(-2px);
}

.playlist-item.active {
  border-color: #007bff;
  background: #f8f9fa;
}

.video-thumbnail {
  position: relative;
  width: 120px;
  height: 68px;
  border-radius: 4px;
  overflow: hidden;
  flex-shrink: 0;
}

.video-thumbnail img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.play-overlay {
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  background: rgba(0, 0, 0, 0.7);
  color: white;
  padding: 8px;
  border-radius: 50%;
  font-size: 16px;
  opacity: 0;
  transition: opacity 0.2s ease;
}

.playlist-item:hover .play-overlay {
  opacity: 1;
}

.video-info {
  flex: 1;
  min-width: 0;
}

.video-title {
  margin: 0 0 8px 0;
  font-size: 16px;
  font-weight: bold;
  color: #333;
  line-height: 1.3;
}

.video-description {
  margin: 0 0 10px 0;
  font-size: 14px;
  color: #666;
  line-height: 1.4;
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow: hidden;
}

.video-meta {
  display: flex;
  gap: 15px;
  font-size: 12px;
  color: #999;
}

.video-details {
  background: white;
  padding: 30px;
  border-radius: 8px;
  box-shadow: 0 2px 8px rgba(0,0,0,0.1);
}

.video-title-main {
  margin: 0 0 15px 0;
  font-size: 28px;
  color: #333;
  line-height: 1.2;
}

.video-description-main {
  margin: 0 0 20px 0;
  font-size: 16px;
  color: #666;
  line-height: 1.6;
}

.video-stats {
  display: flex;
  gap: 30px;
  margin-bottom: 20px;
  padding-bottom: 20px;
  border-bottom: 1px solid #eee;
}

.stat-item {
  display: flex;
  align-items: center;
  gap: 8px;
}

.stat-icon {
  font-size: 16px;
}

.stat-text {
  font-size: 14px;
  color: #666;
  font-weight: bold;
}

.action-buttons {
  display: flex;
  gap: 15px;
}

.action-btn {
  padding: 10px 20px;
  border: 1px solid #ddd;
  background: white;
  color: #333;
  border-radius: 6px;
  cursor: pointer;
  font-weight: bold;
  transition: all 0.2s ease;
}

.action-btn:hover {
  background: #f8f9fa;
  border-color: #007bff;
  color: #007bff;
}

.like-btn:hover {
  background: #e3f2fd;
  border-color: #2196f3;
  color: #2196f3;
}

.dislike-btn:hover {
  background: #ffebee;
  border-color: #f44336;
  color: #f44336;
}

.share-btn:hover {
  background: #f3e5f5;
  border-color: #9c27b0;
  color: #9c27b0;
}

.save-btn:hover {
  background: #e8f5e8;
  border-color: #4caf50;
  color: #4caf50;
}

@media (max-width: 768px) {
  .media-player {
    padding: 10px;
  }

  .player-controls {
    flex-direction: column;
    gap: 15px;
    align-items: stretch;
  }

  .control-group {
    justify-content: center;
  }

  .progress-container {
    order: -1;
  }

  .playlist-items {
    grid-template-columns: 1fr;
  }

  .playlist-item {
    flex-direction: column;
  }

  .video-thumbnail {
    width: 100%;
    height: 200px;
  }

  .video-stats {
    flex-wrap: wrap;
    gap: 15px;
  }

  .action-buttons {
    flex-wrap: wrap;
  }
}
</style>

<template>
  <div class="media-player" :class="{ fullscreen: isFullscreen }">
    <div class="video-container">
      <video
        ref="videoElement"
        class="video-element"
        poster="https://via.placeholder.com/800x450/333/fff?text=Video+Thumbnail"
        preload="metadata"
      >
        <source src="https://sample-videos.com/zip/10/mp4/SampleVideo_1280x720_1mb.mp4" type="video/mp4">
        Your browser does not support the video tag.
      </video>

      <div v-if="isLoading || buffering" class="loading-overlay">
        <div class="loading-spinner"></div>
        <span class="loading-text">
          {{ isLoading ? 'Loading...' : 'Buffering...' }}
        </span>
      </div>

      <div class="video-overlay">
        <div class="video-controls">
          <div class="progress-container">
            <div 
              ref="progressBar"
              class="progress-bar"
              @click="handleSeek"
            >
              <div 
                class="progress-fill"
                :style="{ width: getProgressPercentage() + '%' }"
              />
              <div 
                class="progress-handle"
                :style="{ left: getProgressPercentage() + '%' }"
              />
            </div>
          </div>

          <div class="controls-row">
            <div class="left-controls">
              <button 
                @click="togglePlay"
                class="control-btn play-btn"
              >
                {{ isPlaying ? '⏸️' : '▶️' }}
              </button>
              
              <div class="time-display">
                <span class="current-time">{{ formatTime(currentTime) }}</span>
                <span class="time-separator">/</span>
                <span class="duration">{{ formatTime(duration) }}</span>
              </div>

              <div class="volume-control">
                <button 
                  @click="toggleMute"
                  class="control-btn volume-btn"
                >
                  {{ isMuted ? '🔇' : volume > 0.5 ? '🔊' : '🔉' }}
                </button>
                
                <div 
                  class="volume-slider-container"
                  :class="{ show: showVolumeSlider }"
                >
                  <input
                    ref="volumeSlider"
                    type="range"
                    min="0"
                    max="1"
                    step="0.01"
                    :value="volume"
                    @input="handleVolumeChange"
                    class="volume-slider"
                  />
                </div>
              </div>
            </div>

            <div class="right-controls">
              <div class="playback-speed">
                <button 
                  @click="showPlaybackSpeedMenu = !showPlaybackSpeedMenu"
                  class="control-btn speed-btn"
                >
                  {{ playbackRate }}x
                </button>
                
                <div v-if="showPlaybackSpeedMenu" class="speed-menu">
                  <button
                    v-for="option in speedOptions"
                    :key="option.value"
                    @click="handlePlaybackRateChange(option.value)"
                    class="speed-option"
                    :class="{ active: playbackRate === option.value }"
                  >
                    {{ option.label }}
                  </button>
                </div>
              </div>

              <div class="quality-selector">
                <button 
                  @click="showQualityMenu = !showQualityMenu"
                  class="control-btn quality-btn"
                >
                  Quality
                </button>
                
                <div v-if="showQualityMenu" class="quality-menu">
                  <button
                    v-for="option in qualityOptions"
                    :key="option.value"
                    @click="handleQualityChange(option.value)"
                    class="quality-option"
                  >
                    {{ option.label }}
                  </button>
                </div>
              </div>

              <button 
                @click="showSettings = !showSettings"
                class="control-btn settings-btn"
              >
                ⚙️
              </button>

              <button 
                @click="toggleFullscreen"
                class="control-btn fullscreen-btn"
              >
                {{ isFullscreen ? '⤢' : '⤡' }}
              </button>
            </div>
          </div>
        </div>
      </div>
    </div>

    <div v-if="showSettings" class="settings-panel">
      <div class="settings-header">
        <h3>Player Settings</h3>
        <button 
          @click="showSettings = false"
          class="close-btn"
        >
          ✕
        </button>
      </div>
      
      <div class="settings-content">
        <div class="setting-group">
          <label class="setting-label">Captions</label>
          <select 
            @change="handleCaptionChange($event.target.value)"
            class="setting-select"
          >
            <option
              v-for="option in captionOptions"
              :key="option.value"
              :value="option.value"
            >
              {{ option.label }}
            </option>
          </select>
        </div>

        <div class="setting-group">
          <label class="setting-label">Quality</label>
          <select class="setting-select">
            <option
              v-for="option in qualityOptions"
              :key="option.value"
              :value="option.value"
            >
              {{ option.label }}
            </option>
          </select>
        </div>

        <div class="setting-group">
          <label class="setting-label">Playback Speed</label>
          <select 
            @change="handlePlaybackRateChange(parseFloat($event.target.value))"
            class="setting-select"
          >
            <option
              v-for="option in speedOptions"
              :key="option.value"
              :value="option.value"
            >
              {{ option.label }}
            </option>
          </select>
        </div>

        <div class="setting-group">
          <label class="setting-label">Volume</label>
          <input
            type="range"
            min="0"
            max="1"
            step="0.01"
            v-model="volume"
            @input="handleVolumeChange"
            class="setting-slider"
          />
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'MediaPlayerFullInterface',
  data() {
    return {
      isPlaying: false,
      currentTime: 0,
      duration: 0,
      volume: 0.7,
      isMuted: false,
      playbackRate: 1.0,
      isFullscreen: false,
      showCaptions: false,
      showQualityMenu: false,
      showPlaybackSpeedMenu: false,
      showVolumeSlider: false,
      showSettings: false,
      isLoading: false,
      buffering: false,
      qualityOptions: [
        { label: 'Auto', value: 'auto' },
        { label: '1080p', value: '1080p' },
        { label: '720p', value: '720p' },
        { label: '480p', value: '480p' },
        { label: '360p', value: '360p' }
      ],
      speedOptions: [
        { label: '0.5x', value: 0.5 },
        { label: '0.75x', value: 0.75 },
        { label: '1x', value: 1.0 },
        { label: '1.25x', value: 1.25 },
        { label: '1.5x', value: 1.5 },
        { label: '2x', value: 2.0 }
      ],
      captionOptions: [
        { label: 'Off', value: 'off' },
        { label: 'English', value: 'en' },
        { label: 'Spanish', value: 'es' },
        { label: 'French', value: 'fr' },
        { label: 'German', value: 'de' }
      ]
    }
  },
  mounted() {
    this.setupVideoListeners()
  },
  beforeDestroy() {
    this.removeVideoListeners()
  },
  methods: {
    setupVideoListeners() {
      const video = this.$refs.videoElement
      if (video) {
        video.addEventListener('loadedmetadata', this.handleLoadedMetadata)
        video.addEventListener('timeupdate', this.handleTimeUpdate)
        video.addEventListener('ended', this.handleEnded)
        video.addEventListener('waiting', this.handleWaiting)
        video.addEventListener('canplay', this.handleCanPlay)
      }
    },
    removeVideoListeners() {
      const video = this.$refs.videoElement
      if (video) {
        video.removeEventListener('loadedmetadata', this.handleLoadedMetadata)
        video.removeEventListener('timeupdate', this.handleTimeUpdate)
        video.removeEventListener('ended', this.handleEnded)
        video.removeEventListener('waiting', this.handleWaiting)
        video.removeEventListener('canplay', this.handleCanPlay)
      }
    },
    handleLoadedMetadata() {
      this.duration = this.$refs.videoElement.duration
    },
    handleTimeUpdate() {
      this.currentTime = this.$refs.videoElement.currentTime
    },
    handleEnded() {
      this.isPlaying = false
    },
    handleWaiting() {
      this.buffering = true
    },
    handleCanPlay() {
      this.buffering = false
      this.isLoading = false
    },
    togglePlay() {
      const video = this.$refs.videoElement
      if (video) {
        if (this.isPlaying) {
          video.pause()
        } else {
          video.play()
        }
        this.isPlaying = !this.isPlaying
      }
    },
    handleSeek(event) {
      const video = this.$refs.videoElement
      const progressBar = this.$refs.progressBar
      if (video && progressBar) {
        const rect = progressBar.getBoundingClientRect()
        const clickX = event.clientX - rect.left
        const newTime = (clickX / rect.width) * this.duration
        video.currentTime = newTime
        this.currentTime = newTime
      }
    },
    handleVolumeChange(event) {
      const video = this.$refs.videoElement
      const volumeSlider = this.$refs.volumeSlider
      if (video && volumeSlider) {
        const newVolume = parseFloat(event.target.value)
        this.volume = newVolume
        video.volume = newVolume
        this.isMuted = newVolume === 0
      }
    },
    toggleMute() {
      const video = this.$refs.videoElement
      if (video) {
        if (this.isMuted) {
          video.volume = this.volume
          this.isMuted = false
        } else {
          video.volume = 0
          this.isMuted = true
        }
      }
    },
    handlePlaybackRateChange(rate) {
      const video = this.$refs.videoElement
      if (video) {
        this.playbackRate = rate
        video.playbackRate = rate
      }
      this.showPlaybackSpeedMenu = false
    },
    handleQualityChange(quality) {
      console.log('Quality changed to:', quality)
      this.showQualityMenu = false
    },
    handleCaptionChange(caption) {
      console.log('Captions changed to:', caption)
      this.showCaptions = caption !== 'off'
      this.showSettings = false
    },
    toggleFullscreen() {
      if (!document.fullscreenElement) {
        document.documentElement.requestFullscreen()
        this.isFullscreen = true
      } else {
        document.exitFullscreen()
        this.isFullscreen = false
      }
    },
    formatTime(seconds) {
      const mins = Math.floor(seconds / 60)
      const secs = Math.floor(seconds % 60)
      return `${mins}:${secs.toString().padStart(2, '0')}`
    },
    getProgressPercentage() {
      return this.duration > 0 ? (this.currentTime / this.duration) * 100 : 0
    }
  }
}
</script>

<style scoped>
.media-player {
  max-width: 1000px;
  margin: 0 auto;
  background: #000;
  border-radius: 8px;
  overflow: hidden;
  position: relative;
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
}

.media-player.fullscreen {
  position: fixed;
  top: 0;
  left: 0;
  width: 100vw;
  height: 100vh;
  z-index: 9999;
  border-radius: 0;
}

.video-container {
  position: relative;
  width: 100%;
  height: 0;
  padding-bottom: 56.25%;
  background: #000;
}

.video-element {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  object-fit: contain;
}

.loading-overlay {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background: rgba(0, 0, 0, 0.8);
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  z-index: 10;
}

.loading-spinner {
  width: 40px;
  height: 40px;
  border: 4px solid rgba(255, 255, 255, 0.3);
  border-top: 4px solid #4caf50;
  border-radius: 50%;
  animation: spin 1s linear infinite;
  margin-bottom: 15px;
}

@keyframes spin {
  0% { transform: rotate(0deg); }
  100% { transform: rotate(360deg); }
}

.loading-text {
  color: white;
  font-size: 14px;
  font-weight: 500;
}

.video-overlay {
  position: absolute;
  bottom: 0;
  left: 0;
  right: 0;
  background: linear-gradient(transparent, rgba(0, 0, 0, 0.8));
  padding: 20px;
  z-index: 5;
}

.video-controls {
  color: white;
}

.progress-container {
  margin-bottom: 15px;
}

.progress-bar {
  width: 100%;
  height: 6px;
  background: rgba(255, 255, 255, 0.3);
  border-radius: 3px;
  cursor: pointer;
  position: relative;
}

.progress-fill {
  height: 100%;
  background: #4caf50;
  border-radius: 3px;
  transition: width 0.1s ease;
}

.progress-handle {
  position: absolute;
  top: 50%;
  width: 12px;
  height: 12px;
  background: #4caf50;
  border-radius: 50%;
  transform: translate(-50%, -50%);
  opacity: 0;
  transition: opacity 0.3s ease;
}

.progress-bar:hover .progress-handle {
  opacity: 1;
}

.controls-row {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.left-controls,
.right-controls {
  display: flex;
  align-items: center;
  gap: 15px;
}

.control-btn {
  background: none;
  border: none;
  color: white;
  cursor: pointer;
  font-size: 16px;
  padding: 8px;
  border-radius: 4px;
  transition: background-color 0.3s ease;
}

.control-btn:hover {
  background: rgba(255, 255, 255, 0.2);
}

.play-btn {
  font-size: 20px;
}

.time-display {
  display: flex;
  align-items: center;
  gap: 5px;
  font-size: 14px;
  font-weight: 500;
  min-width: 100px;
}

.time-separator {
  opacity: 0.7;
}

.volume-control {
  position: relative;
  display: flex;
  align-items: center;
  gap: 8px;
}

.volume-slider-container {
  position: absolute;
  left: 50%;
  bottom: 100%;
  transform: translateX(-50%);
  background: rgba(0, 0, 0, 0.8);
  padding: 10px;
  border-radius: 4px;
  opacity: 0;
  visibility: hidden;
  transition: all 0.3s ease;
}

.volume-slider-container.show {
  opacity: 1;
  visibility: visible;
}

.volume-slider {
  width: 80px;
  height: 4px;
  background: rgba(255, 255, 255, 0.3);
  border-radius: 2px;
  outline: none;
  cursor: pointer;
}

.volume-slider::-webkit-slider-thumb {
  appearance: none;
  width: 12px;
  height: 12px;
  background: #4caf50;
  border-radius: 50%;
  cursor: pointer;
}

.playback-speed,
.quality-selector {
  position: relative;
}

.speed-btn,
.quality-btn {
  font-size: 12px;
  padding: 6px 10px;
  background: rgba(255, 255, 255, 0.2);
  border-radius: 4px;
}

.speed-menu,
.quality-menu {
  position: absolute;
  bottom: 100%;
  right: 0;
  background: rgba(0, 0, 0, 0.9);
  border-radius: 4px;
  padding: 5px 0;
  min-width: 80px;
  z-index: 10;
}

.speed-option,
.quality-option {
  display: block;
  width: 100%;
  padding: 8px 12px;
  background: none;
  border: none;
  color: white;
  text-align: left;
  cursor: pointer;
  font-size: 12px;
  transition: background-color 0.3s ease;
}

.speed-option:hover,
.quality-option:hover {
  background: rgba(255, 255, 255, 0.2);
}

.speed-option.active {
  background: #4caf50;
}

.settings-panel {
  position: absolute;
  top: 20px;
  right: 20px;
  background: rgba(0, 0, 0, 0.9);
  border-radius: 8px;
  padding: 20px;
  min-width: 250px;
  z-index: 20;
}

.settings-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 20px;
  padding-bottom: 10px;
  border-bottom: 1px solid rgba(255, 255, 255, 0.2);
}

.settings-header h3 {
  margin: 0;
  color: white;
  font-size: 16px;
}

.close-btn {
  background: none;
  border: none;
  color: white;
  cursor: pointer;
  font-size: 16px;
  padding: 4px;
}

.settings-content {
  display: flex;
  flex-direction: column;
  gap: 15px;
}

.setting-group {
  display: flex;
  flex-direction: column;
  gap: 5px;
}

.setting-label {
  color: white;
  font-size: 12px;
  font-weight: 500;
}

.setting-select {
  padding: 6px 8px;
  background: rgba(255, 255, 255, 0.1);
  border: 1px solid rgba(255, 255, 255, 0.3);
  border-radius: 4px;
  color: white;
  font-size: 12px;
}

.setting-select:focus {
  outline: none;
  border-color: #4caf50;
}

.setting-slider {
  width: 100%;
  height: 4px;
  background: rgba(255, 255, 255, 0.3);
  border-radius: 2px;
  outline: none;
  cursor: pointer;
}

.setting-slider::-webkit-slider-thumb {
  appearance: none;
  width: 12px;
  height: 12px;
  background: #4caf50;
  border-radius: 50%;
  cursor: pointer;
}

@media (max-width: 768px) {
  .media-player {
    margin: 10px;
  }
  
  .video-overlay {
    padding: 15px;
  }
  
  .controls-row {
    flex-direction: column;
    gap: 10px;
  }
  
  .left-controls,
  .right-controls {
    justify-content: center;
    flex-wrap: wrap;
  }
  
  .time-display {
    min-width: auto;
  }
  
  .settings-panel {
    position: fixed;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    width: 90%;
    max-width: 300px;
  }
}

@media (max-width: 480px) {
  .video-overlay {
    padding: 10px;
  }
  
  .control-btn {
    font-size: 14px;
    padding: 6px;
  }
  
  .time-display {
    font-size: 12px;
  }
  
  .speed-btn,
  .quality-btn {
    font-size: 10px;
    padding: 4px 6px;
  }
}
</style>

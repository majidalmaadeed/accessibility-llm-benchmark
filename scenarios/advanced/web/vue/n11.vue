<template>
  <div :class="`media-player ${isFullscreen ? 'fullscreen' : ''}`">
    <div class="video-container">
      <video
        ref="videoRef"
        class="video-element"
        poster="https://via.placeholder.com/800x450/333/fff?text=Sample+Video"
        @mousemove="showControls = true"
        @mouseleave="showControls = false"
      >
        <source src="https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4" type="video/mp4" />
        <track kind="captions" srcLang="en" label="English" default />
        <track kind="captions" srcLang="es" label="Spanish" />
        <track kind="captions" srcLang="fr" label="French" />
        <track kind="captions" srcLang="de" label="German" />
      </video>

      <div v-if="isLoading" class="loading-overlay">
        <div class="loading-spinner"></div>
        <span>Loading...</span>
      </div>

      <div v-if="showControls" class="video-controls">
        <!-- Progress Bar -->
        <div class="progress-container" @click="handleSeek">
          <div class="progress-bar">
            <div 
              class="progress-fill" 
              :style="{ width: `${(currentTime / duration) * 100}%` }"
            ></div>
            <div 
              class="progress-handle" 
              :style="{ left: `${(currentTime / duration) * 100}%` }"
            ></div>
          </div>
        </div>

        <!-- Control Buttons -->
        <div class="controls-row">
          <div class="left-controls">
            <button 
              class="control-btn play-btn"
              @click="togglePlay"
            >
              {{ isPlaying ? '⏸️' : '▶️' }}
            </button>

            <div class="time-display">
              {{ formatTime(currentTime) }} / {{ formatTime(duration) }}
            </div>

            <button 
              class="control-btn volume-btn"
              @click="toggleMute"
            >
              {{ isMuted ? '🔇' : volume > 0.5 ? '🔊' : '🔉' }}
            </button>

            <div class="volume-slider">
              <input
                type="range"
                min="0"
                max="1"
                step="0.1"
                :value="isMuted ? 0 : volume"
                @input="handleVolumeChange"
                class="volume-range"
              />
            </div>
          </div>

          <div class="right-controls">
            <div class="playback-rate-menu">
              <button 
                class="control-btn"
                @click="showSettingsMenu = !showSettingsMenu"
              >
                {{ playbackRate }}x
              </button>
              <div v-if="showSettingsMenu" class="settings-dropdown">
                <div class="settings-section">
                  <div class="settings-label">Playback Speed</div>
                  <button
                    v-for="rate in playbackRates"
                    :key="rate"
                    :class="`settings-option ${playbackRate === rate ? 'active' : ''}`"
                    @click="changePlaybackRate(rate); showSettingsMenu = false"
                  >
                    {{ rate }}x
                  </button>
                </div>
              </div>
            </div>

            <div class="quality-menu">
              <button 
                class="control-btn"
                @click="showQualityMenu = !showQualityMenu"
              >
                {{ selectedQuality }}
              </button>
              <div v-if="showQualityMenu" class="quality-dropdown">
                <button
                  v-for="quality in qualityOptions"
                  :key="quality"
                  :class="`quality-option ${selectedQuality === quality ? 'active' : ''}`"
                  @click="handleQualityChange(quality)"
                >
                  {{ quality }}
                </button>
              </div>
            </div>

            <button 
              class="control-btn captions-btn"
              @click="showCaptions = !showCaptions"
            >
              📺
            </button>

            <button 
              class="control-btn fullscreen-btn"
              @click="toggleFullscreen"
            >
              {{ isFullscreen ? '⤢' : '⤡' }}
            </button>
          </div>
        </div>
      </div>

      <!-- Captions Menu -->
      <div v-if="showCaptions" class="captions-menu">
        <div class="captions-header">Captions</div>
        <button
          v-for="caption in captionOptions"
          :key="caption"
          :class="`caption-option ${selectedCaption === caption ? 'active' : ''}`"
          @click="handleCaptionChange(caption)"
        >
          {{ caption }}
        </button>
      </div>
    </div>

    <!-- Video Info -->
    <div class="video-info">
      <h3>Big Buck Bunny</h3>
      <p>A short animated film by the Blender Institute</p>
      <div class="video-meta">
        <span>Duration: {{ formatTime(duration) }}</span>
        <span>Quality: {{ selectedQuality }}</span>
        <span>Captions: {{ selectedCaption }}</span>
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
      volume: 1,
      isMuted: false,
      playbackRate: 1,
      isFullscreen: false,
      showCaptions: false,
      showQualityMenu: false,
      showSettingsMenu: false,
      selectedQuality: '1080p',
      selectedCaption: 'English',
      showControls: true,
      isLoading: false,
      qualityOptions: ['360p', '480p', '720p', '1080p', '4K'],
      captionOptions: ['English', 'Spanish', 'French', 'German', 'Off'],
      playbackRates: [0.5, 0.75, 1, 1.25, 1.5, 2]
    }
  },
  mounted() {
    this.setupVideoListeners();
  },
  beforeUnmount() {
    this.removeVideoListeners();
  },
  methods: {
    setupVideoListeners() {
      const video = this.$refs.videoRef;
      if (!video) return;

      video.addEventListener('timeupdate', this.handleTimeUpdate);
      video.addEventListener('durationchange', this.handleDurationChange);
      video.addEventListener('loadstart', this.handleLoadStart);
      video.addEventListener('canplay', this.handleCanPlay);
      video.addEventListener('play', this.handlePlay);
      video.addEventListener('pause', this.handlePause);
    },
    removeVideoListeners() {
      const video = this.$refs.videoRef;
      if (!video) return;

      video.removeEventListener('timeupdate', this.handleTimeUpdate);
      video.removeEventListener('durationchange', this.handleDurationChange);
      video.removeEventListener('loadstart', this.handleLoadStart);
      video.removeEventListener('canplay', this.handleCanPlay);
      video.removeEventListener('play', this.handlePlay);
      video.removeEventListener('pause', this.handlePause);
    },
    handleTimeUpdate() {
      this.currentTime = this.$refs.videoRef.currentTime;
    },
    handleDurationChange() {
      this.duration = this.$refs.videoRef.duration;
    },
    handleLoadStart() {
      this.isLoading = true;
    },
    handleCanPlay() {
      this.isLoading = false;
    },
    handlePlay() {
      this.isPlaying = true;
    },
    handlePause() {
      this.isPlaying = false;
    },
    togglePlay() {
      const video = this.$refs.videoRef;
      if (!video) return;

      if (this.isPlaying) {
        video.pause();
      } else {
        video.play();
      }
    },
    handleSeek(event) {
      const video = this.$refs.videoRef;
      if (!video) return;

      const rect = event.currentTarget.getBoundingClientRect();
      const clickX = event.clientX - rect.left;
      const newTime = (clickX / rect.width) * this.duration;
      video.currentTime = newTime;
      this.currentTime = newTime;
    },
    handleVolumeChange(event) {
      const video = this.$refs.videoRef;
      if (!video) return;

      const newVolume = parseFloat(event.target.value);
      video.volume = newVolume;
      this.volume = newVolume;
      this.isMuted = newVolume === 0;
    },
    toggleMute() {
      const video = this.$refs.videoRef;
      if (!video) return;

      if (this.isMuted) {
        video.volume = this.volume;
        this.isMuted = false;
      } else {
        video.volume = 0;
        this.isMuted = true;
      }
    },
    changePlaybackRate(rate) {
      const video = this.$refs.videoRef;
      if (!video) return;

      video.playbackRate = rate;
      this.playbackRate = rate;
    },
    toggleFullscreen() {
      if (!document.fullscreenElement) {
        this.$refs.videoRef?.requestFullscreen();
        this.isFullscreen = true;
      } else {
        document.exitFullscreen();
        this.isFullscreen = false;
      }
    },
    formatTime(time) {
      const minutes = Math.floor(time / 60);
      const seconds = Math.floor(time % 60);
      return `${minutes}:${seconds.toString().padStart(2, '0')}`;
    },
    handleQualityChange(quality) {
      this.selectedQuality = quality;
      this.showQualityMenu = false;
      console.log(`Quality changed to ${quality}`);
    },
    handleCaptionChange(caption) {
      this.selectedCaption = caption;
      this.showCaptions = caption !== 'Off';
      console.log(`Captions changed to ${caption}`);
    }
  }
}
</script>

<style scoped>
.media-player {
  max-width: 800px;
  margin: 0 auto;
  padding: 20px;
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
}

.media-player.fullscreen {
  position: fixed;
  top: 0;
  left: 0;
  width: 100vw;
  height: 100vh;
  z-index: 1000;
  background: black;
  padding: 0;
}

.video-container {
  position: relative;
  background: black;
  border-radius: 8px;
  overflow: hidden;
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.3);
}

.video-element {
  width: 100%;
  height: auto;
  display: block;
  background: #000;
}

.loading-overlay {
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: rgba(0, 0, 0, 0.7);
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  color: white;
  z-index: 10;
}

.loading-spinner {
  width: 40px;
  height: 40px;
  border: 4px solid rgba(255, 255, 255, 0.3);
  border-top: 4px solid white;
  border-radius: 50%;
  animation: spin 1s linear infinite;
  margin-bottom: 10px;
}

@keyframes spin {
  0% { transform: rotate(0deg); }
  100% { transform: rotate(360deg); }
}

.video-controls {
  position: absolute;
  bottom: 0;
  left: 0;
  right: 0;
  background: linear-gradient(transparent, rgba(0, 0, 0, 0.8));
  padding: 20px 15px 15px;
  color: white;
  z-index: 5;
}

.progress-container {
  margin-bottom: 15px;
  cursor: pointer;
}

.progress-bar {
  position: relative;
  height: 6px;
  background: rgba(255, 255, 255, 0.3);
  border-radius: 3px;
  overflow: hidden;
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

.progress-container:hover .progress-handle {
  opacity: 1;
}

.controls-row {
  display: flex;
  justify-content: space-between;
  align-items: center;
  gap: 15px;
}

.left-controls,
.right-controls {
  display: flex;
  align-items: center;
  gap: 10px;
}

.control-btn {
  background: none;
  border: none;
  color: white;
  cursor: pointer;
  padding: 8px;
  border-radius: 4px;
  font-size: 16px;
  transition: background-color 0.3s ease;
  min-width: 40px;
  height: 40px;
  display: flex;
  align-items: center;
  justify-content: center;
}

.control-btn:hover {
  background: rgba(255, 255, 255, 0.2);
}

.play-btn {
  font-size: 20px;
  background: rgba(255, 255, 255, 0.1);
}

.time-display {
  font-size: 14px;
  font-weight: 500;
  min-width: 100px;
  text-align: center;
}

.volume-slider {
  width: 80px;
}

.volume-range {
  width: 100%;
  height: 4px;
  background: rgba(255, 255, 255, 0.3);
  border-radius: 2px;
  outline: none;
  cursor: pointer;
}

.volume-range::-webkit-slider-thumb {
  appearance: none;
  width: 12px;
  height: 12px;
  background: #4caf50;
  border-radius: 50%;
  cursor: pointer;
}

.volume-range::-moz-range-thumb {
  width: 12px;
  height: 12px;
  background: #4caf50;
  border-radius: 50%;
  cursor: pointer;
  border: none;
}

.playback-rate-menu,
.quality-menu {
  position: relative;
}

.settings-dropdown,
.quality-dropdown {
  position: absolute;
  bottom: 100%;
  right: 0;
  background: rgba(0, 0, 0, 0.9);
  border-radius: 6px;
  padding: 8px 0;
  min-width: 120px;
  z-index: 20;
  margin-bottom: 5px;
}

.settings-section {
  padding: 0;
}

.settings-label {
  padding: 8px 15px;
  font-size: 12px;
  color: #ccc;
  text-transform: uppercase;
  letter-spacing: 0.5px;
  border-bottom: 1px solid rgba(255, 255, 255, 0.1);
  margin-bottom: 5px;
}

.settings-option,
.quality-option {
  display: block;
  width: 100%;
  padding: 8px 15px;
  background: none;
  border: none;
  color: white;
  text-align: left;
  cursor: pointer;
  font-size: 14px;
  transition: background-color 0.3s ease;
}

.settings-option:hover,
.quality-option:hover {
  background: rgba(255, 255, 255, 0.1);
}

.settings-option.active,
.quality-option.active {
  background: #4caf50;
  color: white;
}

.captions-menu {
  position: absolute;
  bottom: 100%;
  right: 60px;
  background: rgba(0, 0, 0, 0.9);
  border-radius: 6px;
  padding: 8px 0;
  min-width: 120px;
  z-index: 20;
  margin-bottom: 5px;
}

.captions-header {
  padding: 8px 15px;
  font-size: 12px;
  color: #ccc;
  text-transform: uppercase;
  letter-spacing: 0.5px;
  border-bottom: 1px solid rgba(255, 255, 255, 0.1);
  margin-bottom: 5px;
}

.caption-option {
  display: block;
  width: 100%;
  padding: 8px 15px;
  background: none;
  border: none;
  color: white;
  text-align: left;
  cursor: pointer;
  font-size: 14px;
  transition: background-color 0.3s ease;
}

.caption-option:hover {
  background: rgba(255, 255, 255, 0.1);
}

.caption-option.active {
  background: #4caf50;
  color: white;
}

.video-info {
  margin-top: 20px;
  padding: 20px;
  background: #f8f9fa;
  border-radius: 8px;
}

.video-info h3 {
  margin: 0 0 10px 0;
  color: #333;
  font-size: 20px;
}

.video-info p {
  margin: 0 0 15px 0;
  color: #666;
  font-size: 14px;
  line-height: 1.5;
}

.video-meta {
  display: flex;
  gap: 20px;
  font-size: 12px;
  color: #888;
}

.video-meta span {
  padding: 4px 8px;
  background: #e9ecef;
  border-radius: 4px;
}

@media (max-width: 768px) {
  .media-player {
    padding: 15px;
  }
  
  .controls-row {
    flex-wrap: wrap;
    gap: 10px;
  }
  
  .left-controls,
  .right-controls {
    flex-wrap: wrap;
    gap: 8px;
  }
  
  .time-display {
    min-width: 80px;
    font-size: 12px;
  }
  
  .volume-slider {
    width: 60px;
  }
  
  .control-btn {
    min-width: 36px;
    height: 36px;
    font-size: 14px;
  }
  
  .play-btn {
    font-size: 18px;
  }
  
  .video-meta {
    flex-direction: column;
    gap: 8px;
  }
}

@media (max-width: 480px) {
  .video-controls {
    padding: 15px 10px 10px;
  }
  
  .controls-row {
    flex-direction: column;
    align-items: stretch;
    gap: 10px;
  }
  
  .left-controls,
  .right-controls {
    justify-content: center;
  }
  
  .settings-dropdown,
  .quality-dropdown,
  .captions-menu {
    right: auto;
    left: 50%;
    transform: translateX(-50%);
  }
}
</style>

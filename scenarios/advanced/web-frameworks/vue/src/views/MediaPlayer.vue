<template>
  <div class="container">
    <div class="page-header">
      <h1 class="page-title">Media Player Full Interface</h1>
      <p class="page-subtitle">
        Full-featured media player interface
      </p>
    </div>

    <div class="card">
      <div class="media-player">
        <div style="text-align: center; margin-bottom: 1rem">
          <h3 style="margin: 0 0 0.5rem 0; color: white">Now Playing</h3>
          <div style="font-size: 1.2rem; font-weight: 600; margin-bottom: 0.25rem">
            {{ currentTrack.title }}
          </div>
          <div style="color: #ccc; margin-bottom: 1rem">
            {{ currentTrack.artist }} - {{ currentTrack.album }} ({{ currentTrack.year }})
          </div>
        </div>

        <div class="media-progress" @click="handleSeek">
          <div 
            class="media-progress-bar" 
            :style="{ width: progressPercentage + '%' }"
          />
        </div>

        <div class="media-time" style="text-align: center; margin: 0.5rem 0">
          {{ formatTime(currentTime) }} / {{ formatTime(duration) }}
        </div>

        <div class="media-controls">
          <div class="media-buttons">
            <button class="media-btn" @click="toggleShuffle" title="Shuffle">
              🔀
            </button>
            <button class="media-btn" @click="previousTrack" title="Previous">
              ⏮
            </button>
            <button class="media-btn" @click="togglePlayPause" :title="isPlaying ? 'Pause' : 'Play'">
              {{ isPlaying ? '⏸' : '▶️' }}
            </button>
            <button class="media-btn" @click="stop" title="Stop">
              ⏹
            </button>
            <button class="media-btn" @click="nextTrack" title="Next">
              ⏭
            </button>
            <button class="media-btn" @click="toggleRepeat" title="Repeat">
              🔁
            </button>
          </div>
        </div>

        <div style="display: flex; align-items: center; gap: 1rem; margin-top: 1rem">
          <button class="media-btn" @click="toggleMute" :title="isMuted ? 'Unmute' : 'Mute'">
            {{ isMuted ? '🔇' : '🔊' }}
          </button>
          <input
            type="range"
            min="0"
            max="100"
            :value="isMuted ? 0 : volume"
            @input="handleVolumeChange"
            style="flex: 1"
          />
          <span style="color: #ccc; min-width: 40px">
            {{ isMuted ? '0%' : volume + '%' }}
          </span>
        </div>
      </div>
    </div>

    <div class="card">
      <h2>Playlist</h2>
      <div style="max-height: 300px; overflow-y: auto">
        <div
          v-for="(track, index) in playlist"
          :key="track.id"
          :style="{
            display: 'flex',
            alignItems: 'center',
            padding: '0.75rem',
            borderBottom: '1px solid #eee',
            backgroundColor: index === currentTrackIndex ? '#e3f2fd' : 'white',
            cursor: 'pointer'
          }"
          @click="playTrack(index)"
        >
          <div style="margin-right: 1rem; font-size: 1.2rem">
            {{ index === currentTrackIndex && isPlaying ? '🎵' : '🎶' }}
          </div>
          <div style="flex: 1">
            <div :style="{ fontWeight: index === currentTrackIndex ? '600' : '400' }">
              {{ track.title }}
            </div>
            <div style="font-size: 0.9rem; color: #666">
              {{ track.artist }}
            </div>
          </div>
          <div style="color: #666; font-size: 0.9rem">
            {{ track.duration }}
          </div>
        </div>
      </div>
    </div>

    <div class="card">
      <h2>Equalizer</h2>
      <div style="display: flex; align-items: end; gap: 0.5rem; height: 120px">
        <div
          v-for="freq in [60, 170, 310, 600, 1000, 3000, 6000, 12000, 14000, 16000]"
          :key="freq"
          style="display: flex; flex-direction: column; align-items: center; flex: 1"
        >
          <input
            type="range"
            min="-12"
            max="12"
            :default-value="0"
            orient="vertical"
            style="writing-mode: bt-lr; width: 20px; height: 80px"
          />
          <div style="font-size: 0.8rem; color: #666; margin-top: 0.5rem">
            {{ freq >= 1000 ? (freq/1000) + 'k' : freq }}Hz
          </div>
        </div>
      </div>
    </div>

    <div class="card">
      <h2>Playback Settings</h2>
      <div class="form-row">
        <div class="form-group">
          <label class="form-label">Playback Speed</label>
          <select class="form-control">
            <option value="0.5">0.5x</option>
            <option value="0.75">0.75x</option>
            <option value="1">1x (Normal)</option>
            <option value="1.25">1.25x</option>
            <option value="1.5">1.5x</option>
            <option value="2">2x</option>
          </select>
        </div>
        <div class="form-group">
          <label class="form-label">Audio Quality</label>
          <select class="form-control">
            <option value="low">Low (128 kbps)</option>
            <option value="medium">Medium (256 kbps)</option>
            <option value="high">High (320 kbps)</option>
            <option value="lossless">Lossless (FLAC)</option>
          </select>
        </div>
        <div class="form-group">
          <label class="form-label">Crossfade</label>
          <input
            type="range"
            min="0"
            max="10"
            :default-value="0"
            class="form-control"
          />
        </div>
      </div>
      <div class="form-group">
        <label>
          <input type="checkbox" :default-checked="true" />
          Auto-play next track
        </label>
      </div>
      <div class="form-group">
        <label>
          <input type="checkbox" />
          Fade in/out
        </label>
      </div>
      <div class="form-group">
        <label>
          <input type="checkbox" />
          Remember playback position
        </label>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'MediaPlayer',
  data() {
    return {
      isPlaying: false,
      currentTime: 0,
      duration: 180,
      volume: 50,
      isMuted: false,
      currentTrack: {
        title: 'Sample Track',
        artist: 'Sample Artist',
        album: 'Sample Album',
        year: '2024'
      },
      playlist: [
        { id: 1, title: 'Track 1', artist: 'Artist 1', duration: '3:45' },
        { id: 2, title: 'Track 2', artist: 'Artist 2', duration: '4:12' },
        { id: 3, title: 'Track 3', artist: 'Artist 3', duration: '3:28' },
        { id: 4, title: 'Track 4', artist: 'Artist 4', duration: '4:33' },
        { id: 5, title: 'Track 5', artist: 'Artist 5', duration: '3:56' }
      ],
      currentTrackIndex: 0,
      isShuffled: false,
      isRepeating: false
    }
  },
  computed: {
    progressPercentage() {
      return (this.currentTime / this.duration) * 100
    }
  },
  watch: {
    isPlaying(newVal) {
      if (newVal) {
        this.interval = setInterval(() => {
          this.currentTime++
          if (this.currentTime >= this.duration) {
            if (this.isRepeating) {
              this.currentTime = 0
            } else {
              this.nextTrack()
              this.currentTime = 0
            }
          }
        }, 1000)
      } else {
        if (this.interval) {
          clearInterval(this.interval)
        }
      }
    }
  },
  methods: {
    togglePlayPause() {
      this.isPlaying = !this.isPlaying
    },
    stop() {
      this.isPlaying = false
      this.currentTime = 0
    },
    nextTrack() {
      if (this.currentTrackIndex < this.playlist.length - 1) {
        this.currentTrackIndex++
      } else {
        this.currentTrackIndex = 0
      }
      this.currentTime = 0
    },
    previousTrack() {
      if (this.currentTrackIndex > 0) {
        this.currentTrackIndex--
      } else {
        this.currentTrackIndex = this.playlist.length - 1
      }
      this.currentTime = 0
    },
    handleSeek(e) {
      const rect = e.currentTarget.getBoundingClientRect()
      const clickX = e.clientX - rect.left
      const newTime = (clickX / rect.width) * this.duration
      this.currentTime = newTime
    },
    handleVolumeChange(e) {
      this.volume = parseInt(e.target.value)
      this.isMuted = false
    },
    toggleMute() {
      this.isMuted = !this.isMuted
    },
    toggleShuffle() {
      this.isShuffled = !this.isShuffled
    },
    toggleRepeat() {
      this.isRepeating = !this.isRepeating
    },
    playTrack(index) {
      this.currentTrackIndex = index
      this.currentTime = 0
      this.isPlaying = true
    },
    formatTime(seconds) {
      const mins = Math.floor(seconds / 60)
      const secs = Math.floor(seconds % 60)
      return `${mins}:${secs.toString().padStart(2, '0')}`
    }
  }
}
</script>

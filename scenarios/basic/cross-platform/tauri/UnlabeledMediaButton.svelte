<script>
  import { onMount } from 'svelte';
  
  let isPlaying = false;
  let currentTime = 0;
  let duration = 180;
  
  function togglePlay() {
    isPlaying = !isPlaying;
    if (isPlaying) {
      startPlayback();
    } else {
      pausePlayback();
    }
  }
  
  function startPlayback() {
    // Simulate video playback
    const interval = setInterval(() => {
      if (isPlaying && currentTime < duration) {
        currentTime += 1;
      } else {
        clearInterval(interval);
        isPlaying = false;
      }
    }, 1000);
  }
  
  function pausePlayback() {
    // Simulate pause
  }
  
  function formatTime(seconds) {
    const mins = Math.floor(seconds / 60);
    const secs = seconds % 60;
    return `${mins}:${secs.toString().padStart(2, '0')}`;
  }
</script>

<div class="video-player">
  <div class="video-container">
    <div class="video-placeholder">
      <div class="video-content">
        <div class="video-title">Sample Video</div>
        <div class="video-description">This is a sample video for demonstration purposes</div>
      </div>
    </div>
    
    <div class="video-controls">
      <div class="control-group">
        <!-- UNLABELED MEDIA BUTTON - Video play button using only emoji icon without accessible name -->
        <button class="control-btn play-btn" on:click={togglePlay}>
          {isPlaying ? '⏸️' : '▶️'}
        </button>
        
        <div class="time-display">
          <span class="current-time">{formatTime(currentTime)}</span>
          <span class="time-separator">/</span>
          <span class="total-time">{formatTime(duration)}</span>
        </div>
      </div>
      
      <div class="control-group">
        <button class="control-btn" on:click={() => currentTime = Math.max(0, currentTime - 10)}>
          ⏪
        </button>
        <button class="control-btn" on:click={() => currentTime = Math.min(duration, currentTime + 10)}>
          ⏩
        </button>
        <button class="control-btn" on:click={() => currentTime = 0}>
          ⏮️
        </button>
        <button class="control-btn" on:click={() => currentTime = duration}>
          ⏭️
        </button>
      </div>
    </div>
  </div>
</div>

<style>
  .video-player {
    max-width: 800px;
    margin: 0 auto;
    background: #000;
    border-radius: 8px;
    overflow: hidden;
    box-shadow: 0 4px 12px rgba(0,0,0,0.3);
  }
  
  .video-container {
    position: relative;
    width: 100%;
    height: 400px;
  }
  
  .video-placeholder {
    width: 100%;
    height: 100%;
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    display: flex;
    align-items: center;
    justify-content: center;
    color: white;
  }
  
  .video-content {
    text-align: center;
  }
  
  .video-title {
    font-size: 24px;
    font-weight: bold;
    margin-bottom: 10px;
  }
  
  .video-description {
    font-size: 16px;
    opacity: 0.9;
  }
  
  .video-controls {
    background: rgba(0, 0, 0, 0.8);
    padding: 15px;
    display: flex;
    justify-content: space-between;
    align-items: center;
  }
  
  .control-group {
    display: flex;
    align-items: center;
    gap: 10px;
  }
  
  .control-btn {
    background: none;
    border: none;
    color: white;
    font-size: 20px;
    cursor: pointer;
    padding: 8px;
    border-radius: 4px;
    transition: background-color 0.2s;
  }
  
  .control-btn:hover {
    background: rgba(255, 255, 255, 0.2);
  }
  
  .play-btn {
    font-size: 24px;
    background: #007bff;
    border-radius: 50%;
    width: 50px;
    height: 50px;
    display: flex;
    align-items: center;
    justify-content: center;
  }
  
  .play-btn:hover {
    background: #0056b3;
  }
  
  .time-display {
    color: white;
    font-family: monospace;
    font-size: 14px;
  }
  
  .current-time {
    font-weight: bold;
  }
  
  .time-separator {
    margin: 0 5px;
    opacity: 0.7;
  }
  
  .total-time {
    opacity: 0.7;
  }
</style>

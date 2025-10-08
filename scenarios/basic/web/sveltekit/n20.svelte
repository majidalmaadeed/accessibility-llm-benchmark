<script>
  let isPlaying = false;
  let currentTime = 0;
  let duration = 180; // 3 minutes in seconds
  
  function togglePlay() {
    isPlaying = !isPlaying;
    if (isPlaying) {
      startTimer();
    } else {
      stopTimer();
    }
  }
  
  function startTimer() {
    const interval = setInterval(() => {
      if (isPlaying && currentTime < duration) {
        currentTime++;
      } else {
        clearInterval(interval);
        isPlaying = false;
      }
    }, 1000);
  }
  
  function stopTimer() {
    // Timer stops when isPlaying becomes false
  }
  
  function formatTime(seconds) {
    const mins = Math.floor(seconds / 60);
    const secs = seconds % 60;
    return `${mins}:${secs.toString().padStart(2, '0')}`;
  }
  
  function seekTo(event) {
    const rect = event.currentTarget.getBoundingClientRect();
    const clickX = event.clientX - rect.left;
    const percentage = clickX / rect.width;
    currentTime = Math.floor(percentage * duration);
  }
</script>

<div class="media-player">
  <div class="player-header">
    <h2 class="player-title">Audio Player</h2>
    <div class="player-info">
      <span class="track-name">Sample Track - Artist Name</span>
      <span class="track-duration">{formatTime(duration)}</span>
    </div>
  </div>
  
  <div class="player-controls">
    <div class="control-group">
      <button class="control-btn" on:click={togglePlay}>
        {#if isPlaying}
          ⏸️
        {:else}
          ▶️
        {/if}
      </button>
      
      <button class="control-btn">⏮️</button>
      <button class="control-btn">⏭️</button>
    </div>
    
    <div class="progress-container">
      <div class="progress-bar" on:click={seekTo}>
        <div class="progress-fill" style="width: {(currentTime / duration) * 100}%"></div>
        <div class="progress-handle" style="left: {(currentTime / duration) * 100}%"></div>
      </div>
      <div class="time-display">
        <span class="current-time">{formatTime(currentTime)}</span>
        <span class="total-time">{formatTime(duration)}</span>
      </div>
    </div>
    
    <div class="volume-controls">
      <button class="control-btn">🔊</button>
      <div class="volume-slider">
        <div class="volume-bar">
          <div class="volume-fill" style="width: 75%"></div>
        </div>
      </div>
    </div>
  </div>
  
  <div class="player-options">
    <button class="option-btn">♻️</button>
    <button class="option-btn">🔀</button>
    <button class="option-btn">❤️</button>
    <button class="option-btn">📋</button>
  </div>
  
  <div class="playlist-section">
    <h3 class="playlist-title">Playlist</h3>
    <div class="playlist-items">
      <div class="playlist-item active">
        <div class="item-number">1</div>
        <div class="item-info">
          <div class="item-title">Current Track</div>
          <div class="item-artist">Artist Name</div>
        </div>
        <div class="item-duration">3:00</div>
      </div>
      
      <div class="playlist-item">
        <div class="item-number">2</div>
        <div class="item-info">
          <div class="item-title">Next Track</div>
          <div class="item-artist">Another Artist</div>
        </div>
        <div class="item-duration">2:45</div>
      </div>
      
      <div class="playlist-item">
        <div class="item-number">3</div>
        <div class="item-info">
          <div class="item-title">Third Track</div>
          <div class="item-artist">Third Artist</div>
        </div>
        <div class="item-duration">4:12</div>
      </div>
    </div>
  </div>
</div>

<style>
  .media-player {
    max-width: 600px;
    margin: 0 auto;
    padding: 30px;
    background: white;
    border-radius: 12px;
    box-shadow: 0 4px 20px rgba(0,0,0,0.1);
    font-family: Arial, sans-serif;
  }
  
  .player-header {
    text-align: center;
    margin-bottom: 30px;
  }
  
  .player-title {
    margin: 0 0 15px 0;
    font-size: 24px;
    color: #333;
  }
  
  .player-info {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 15px 20px;
    background: #f8f9fa;
    border-radius: 8px;
  }
  
  .track-name {
    font-weight: bold;
    color: #333;
  }
  
  .track-duration {
    color: #666;
    font-size: 14px;
  }
  
  .player-controls {
    margin-bottom: 30px;
  }
  
  .control-group {
    display: flex;
    justify-content: center;
    gap: 15px;
    margin-bottom: 25px;
  }
  
  .control-btn {
    width: 50px;
    height: 50px;
    border: none;
    border-radius: 50%;
    background: #007bff;
    color: white;
    font-size: 20px;
    cursor: pointer;
    transition: all 0.2s ease;
    display: flex;
    align-items: center;
    justify-content: center;
  }
  
  .control-btn:hover {
    background: #0056b3;
    transform: scale(1.05);
  }
  
  .progress-container {
    margin-bottom: 25px;
  }
  
  .progress-bar {
    width: 100%;
    height: 6px;
    background: #e9ecef;
    border-radius: 3px;
    cursor: pointer;
    position: relative;
    margin-bottom: 10px;
  }
  
  .progress-fill {
    height: 100%;
    background: #007bff;
    border-radius: 3px;
    transition: width 0.1s ease;
  }
  
  .progress-handle {
    position: absolute;
    top: -4px;
    width: 14px;
    height: 14px;
    background: #007bff;
    border-radius: 50%;
    transform: translateX(-50%);
    cursor: pointer;
  }
  
  .time-display {
    display: flex;
    justify-content: space-between;
    font-size: 12px;
    color: #666;
  }
  
  .volume-controls {
    display: flex;
    align-items: center;
    gap: 15px;
    justify-content: center;
  }
  
  .volume-slider {
    width: 100px;
  }
  
  .volume-bar {
    width: 100%;
    height: 4px;
    background: #e9ecef;
    border-radius: 2px;
    cursor: pointer;
  }
  
  .volume-fill {
    height: 100%;
    background: #007bff;
    border-radius: 2px;
  }
  
  .player-options {
    display: flex;
    justify-content: center;
    gap: 15px;
    margin-bottom: 30px;
  }
  
  .option-btn {
    width: 40px;
    height: 40px;
    border: 1px solid #ddd;
    background: white;
    color: #333;
    border-radius: 50%;
    cursor: pointer;
    font-size: 16px;
    transition: all 0.2s ease;
    display: flex;
    align-items: center;
    justify-content: center;
  }
  
  .option-btn:hover {
    background: #f8f9fa;
    border-color: #007bff;
    color: #007bff;
  }
  
  .playlist-section {
    border-top: 1px solid #eee;
    padding-top: 20px;
  }
  
  .playlist-title {
    margin: 0 0 15px 0;
    font-size: 18px;
    color: #333;
  }
  
  .playlist-items {
    display: flex;
    flex-direction: column;
    gap: 10px;
  }
  
  .playlist-item {
    display: flex;
    align-items: center;
    gap: 15px;
    padding: 12px;
    border-radius: 8px;
    cursor: pointer;
    transition: all 0.2s ease;
  }
  
  .playlist-item:hover {
    background: #f8f9fa;
  }
  
  .playlist-item.active {
    background: #e3f2fd;
    border: 1px solid #007bff;
  }
  
  .item-number {
    width: 25px;
    height: 25px;
    background: #f8f9fa;
    color: #666;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 12px;
    font-weight: bold;
  }
  
  .playlist-item.active .item-number {
    background: #007bff;
    color: white;
  }
  
  .item-info {
    flex: 1;
  }
  
  .item-title {
    font-weight: bold;
    color: #333;
    margin-bottom: 2px;
  }
  
  .item-artist {
    font-size: 12px;
    color: #666;
  }
  
  .item-duration {
    font-size: 12px;
    color: #666;
  }
</style>

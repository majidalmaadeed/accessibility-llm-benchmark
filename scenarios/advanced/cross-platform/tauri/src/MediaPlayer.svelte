<script>
  export let data
  
  let mediaData = null
  let isPlaying = false
  let currentTime = 0
  let duration = 0
  let volume = 0.7
  let isMuted = false
  let currentSpeed = 1
  let currentQuality = 'auto'
  let subtitlesEnabled = false
  let showPlaylist = false
  let currentVideo = 0
  
  $: {
    if (data) {
      mediaData = JSON.parse(data)
    }
  }
  
  function togglePlayPause() {
    isPlaying = !isPlaying
  }
  
  function skipBackward() {
    currentTime = Math.max(0, currentTime - 10)
  }
  
  function skipForward() {
    currentTime = Math.min(duration, currentTime + 10)
  }
  
  function setVolume(newVolume) {
    volume = newVolume
    isMuted = newVolume === 0
  }
  
  function toggleMute() {
    isMuted = !isMuted
    if (isMuted) {
      volume = 0
    } else {
      volume = 0.7
    }
  }
  
  function setSpeed(speed) {
    currentSpeed = speed
  }
  
  function setQuality(quality) {
    currentQuality = quality
  }
  
  function toggleSubtitles() {
    subtitlesEnabled = !subtitlesEnabled
  }
  
  function toggleFullscreen() {
    alert('Toggle fullscreen')
  }
  
  function togglePictureInPicture() {
    alert('Toggle picture in picture')
  }
  
  function downloadVideo() {
    alert('Download video')
  }
  
  function playVideo(index) {
    currentVideo = index
    isPlaying = true
  }
  
  function formatTime(seconds) {
    const mins = Math.floor(seconds / 60)
    const secs = Math.floor(seconds % 60)
    return `${mins}:${secs.toString().padStart(2, '0')}`
  }
  
  $: progress = duration > 0 ? (currentTime / duration) * 100 : 0
  $: volumeProgress = volume * 100
</script>

<div class="media-player-container">
  <div class="video-container">
    <div class="video-element">
      <div class="video-placeholder">🎬 Video Player</div>
      <div class="video-overlay">
        <div class="loading-spinner" class:show={isPlaying && currentTime === 0}>⏳</div>
        <div class="captions-overlay" class:show={subtitlesEnabled}>
          This is a sample caption that appears when subtitles are enabled.
        </div>
      </div>
    </div>
  </div>
  
  <div class="controls-container">
    <div class="progress-container">
      <div class="progress-bar" on:click={(e) => {
        const rect = e.currentTarget.getBoundingClientRect()
        const clickX = e.clientX - rect.left
        const percentage = clickX / rect.width
        currentTime = percentage * duration
      }}>
        <div class="progress-fill" style="width: {progress}%"></div>
        <div class="progress-thumb" style="left: {progress}%"></div>
      </div>
      <div class="time-display">
        <span>{formatTime(currentTime)}</span>
        <span>{formatTime(duration)}</span>
      </div>
    </div>
    
    <div class="main-controls">
      <button class="control-btn play-pause-btn" on:click={togglePlayPause}>
        {isPlaying ? '⏸' : '▶'}
      </button>
      <button class="control-btn" on:click={skipBackward}>⏪</button>
      <button class="control-btn" on:click={skipForward}>⏩</button>
      
      <div class="volume-container">
        <button class="control-btn" on:click={toggleMute}>
          {isMuted ? '🔇' : '🔊'}
        </button>
        <div class="volume-slider" on:click={(e) => {
          const rect = e.currentTarget.getBoundingClientRect()
          const clickX = e.clientX - rect.left
          const percentage = Math.max(0, Math.min(1, clickX / rect.width))
          setVolume(percentage)
        }}>
          <div class="volume-fill" style="width: {volumeProgress}%"></div>
          <div class="volume-thumb" style="left: {volumeProgress}%"></div>
        </div>
      </div>
      
      <div class="settings-menu">
        <button class="control-btn" on:click={() => alert('Settings menu')}>⚙️</button>
      </div>
      
      <button class="control-btn fullscreen-btn" on:click={toggleFullscreen}>⛶</button>
    </div>
    
    <div class="secondary-controls">
      <div class="left-controls">
        <button class="control-btn" on:click={togglePictureInPicture}>📺</button>
        <button class="control-btn" on:click={downloadVideo}>⬇️</button>
      </div>
      <div class="right-controls">
        <span>Speed: {currentSpeed}x</span>
        <span>Quality: {currentQuality}</span>
      </div>
    </div>
  </div>
  
  <div class="playlist-container">
    <div class="playlist-header">
      <h3>Playlist</h3>
      <button class="playlist-toggle" on:click={() => showPlaylist = !showPlaylist}>
        {showPlaylist ? 'Hide Playlist' : 'Show Playlist'}
      </button>
    </div>
    <div class="playlist" class:show={showPlaylist}>
      {#if mediaData?.playlist}
        {#each mediaData.playlist as video, index}
          <div class="playlist-item" class:active={currentVideo === index} on:click={() => playVideo(index)}>
            <div class="playlist-thumbnail">{video.thumbnail}</div>
            <div class="playlist-info">
              <div class="playlist-title">{video.title}</div>
              <div class="playlist-duration">{video.duration}</div>
            </div>
          </div>
        {/each}
      {/if}
    </div>
  </div>
</div>

<style>
  .media-player-container {
    max-width: 1200px;
    margin: 0 auto;
    background: #111;
    border-radius: 12px;
    overflow: hidden;
    box-shadow: 0 10px 30px rgba(0,0,0,0.5);
  }
  
  .video-container {
    position: relative;
    background: #000;
    aspect-ratio: 16/9;
  }
  
  .video-element {
    width: 100%;
    height: 100%;
    position: relative;
  }
  
  .video-placeholder {
    width: 100%;
    height: 100%;
    background: #222;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 48px;
    color: #666;
  }
  
  .video-overlay {
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background: linear-gradient(transparent 60%, rgba(0,0,0,0.7));
    opacity: 0;
    transition: opacity 0.3s ease;
  }
  
  .video-container:hover .video-overlay {
    opacity: 1;
  }
  
  .loading-spinner {
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    font-size: 24px;
    display: none;
  }
  
  .loading-spinner.show {
    display: block;
  }
  
  .captions-overlay {
    position: absolute;
    bottom: 80px;
    left: 20px;
    right: 20px;
    background: rgba(0,0,0,0.8);
    color: white;
    padding: 10px 15px;
    border-radius: 4px;
    font-size: 16px;
    line-height: 1.4;
    display: none;
  }
  
  .captions-overlay.show {
    display: block;
  }
  
  .controls-container {
    background: #222;
    padding: 15px 20px;
  }
  
  .progress-container {
    margin-bottom: 15px;
  }
  
  .progress-bar {
    width: 100%;
    height: 6px;
    background: #444;
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
  
  .progress-thumb {
    position: absolute;
    top: 50%;
    transform: translateY(-50%);
    width: 12px;
    height: 12px;
    background: #ff0000;
    border-radius: 50%;
    opacity: 0;
    transition: opacity 0.3s ease;
  }
  
  .progress-bar:hover .progress-thumb {
    opacity: 1;
  }
  
  .time-display {
    display: flex;
    justify-content: space-between;
    font-size: 12px;
    color: #ccc;
    margin-top: 5px;
  }
  
  .main-controls {
    display: flex;
    align-items: center;
    gap: 15px;
    margin-bottom: 15px;
  }
  
  .control-btn {
    background: none;
    border: none;
    color: white;
    cursor: pointer;
    padding: 8px;
    border-radius: 4px;
    transition: background 0.2s ease;
    font-size: 16px;
  }
  
  .control-btn:hover {
    background: #444;
  }
  
  .play-pause-btn {
    font-size: 24px;
    padding: 10px;
  }
  
  .volume-container {
    display: flex;
    align-items: center;
    gap: 10px;
    margin-left: auto;
  }
  
  .volume-slider {
    width: 80px;
    height: 4px;
    background: #444;
    border-radius: 2px;
    cursor: pointer;
    position: relative;
  }
  
  .volume-fill {
    height: 100%;
    background: #ff0000;
    border-radius: 2px;
  }
  
  .volume-thumb {
    position: absolute;
    top: 50%;
    transform: translateY(-50%);
    width: 12px;
    height: 12px;
    background: #ff0000;
    border-radius: 50%;
    opacity: 0;
    transition: opacity 0.3s ease;
  }
  
  .volume-slider:hover .volume-thumb {
    opacity: 1;
  }
  
  .fullscreen-btn {
    margin-left: auto;
  }
  
  .secondary-controls {
    display: flex;
    justify-content: space-between;
    align-items: center;
  }
  
  .left-controls, .right-controls {
    display: flex;
    align-items: center;
    gap: 15px;
  }
  
  .right-controls span {
    font-size: 12px;
    color: #ccc;
  }
  
  .playlist-container {
    background: #222;
    padding: 20px;
    border-top: 1px solid #444;
  }
  
  .playlist-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 15px;
  }
  
  .playlist-header h3 {
    margin: 0;
    color: white;
    font-size: 18px;
  }
  
  .playlist-toggle {
    background: #444;
    border: none;
    color: white;
    padding: 8px 16px;
    border-radius: 4px;
    cursor: pointer;
  }
  
  .playlist {
    display: none;
    max-height: 300px;
    overflow-y: auto;
  }
  
  .playlist.show {
    display: block;
  }
  
  .playlist-item {
    display: flex;
    align-items: center;
    padding: 10px;
    cursor: pointer;
    border-radius: 4px;
    transition: background 0.2s ease;
  }
  
  .playlist-item:hover {
    background: #333;
  }
  
  .playlist-item.active {
    background: #ff0000;
  }
  
  .playlist-thumbnail {
    width: 60px;
    height: 40px;
    background: #444;
    border-radius: 4px;
    margin-right: 15px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 12px;
  }
  
  .playlist-info {
    flex: 1;
  }
  
  .playlist-title {
    font-weight: 600;
    margin-bottom: 5px;
    color: white;
  }
  
  .playlist-duration {
    font-size: 12px;
    color: #ccc;
  }
</style>

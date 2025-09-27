<script>
  import { onMount, onDestroy } from 'svelte';
  
  let videoElement;
  let isPlaying = false;
  let currentTime = 0;
  let duration = 0;
  let volume = 0.7;
  let isMuted = false;
  let playbackRate = 1.0;
  let isFullscreen = false;
  let showCaptions = false;
  let showQualityMenu = false;
  let showPlaybackSpeedMenu = false;
  let showVolumeSlider = false;
  let showSettings = false;
  let isLoading = false;
  let buffering = false;
  
  let qualityOptions = [
    { label: 'Auto', value: 'auto' },
    { label: '1080p', value: '1080p' },
    { label: '720p', value: '720p' },
    { label: '480p', value: '480p' },
    { label: '360p', value: '360p' }
  ];
  
  let speedOptions = [
    { label: '0.5x', value: 0.5 },
    { label: '0.75x', value: 0.75 },
    { label: '1x', value: 1.0 },
    { label: '1.25x', value: 1.25 },
    { label: '1.5x', value: 1.5 },
    { label: '2x', value: 2.0 }
  ];
  
  let captionOptions = [
    { label: 'Off', value: 'off' },
    { label: 'English', value: 'en' },
    { label: 'Spanish', value: 'es' },
    { label: 'French', value: 'fr' },
    { label: 'German', value: 'de' }
  ];
  
  onMount(() => {
    setupVideoListeners();
  });
  
  onDestroy(() => {
    removeVideoListeners();
  });
  
  function setupVideoListeners() {
    if (videoElement) {
      videoElement.addEventListener('loadedmetadata', handleLoadedMetadata);
      videoElement.addEventListener('timeupdate', handleTimeUpdate);
      videoElement.addEventListener('ended', handleEnded);
      videoElement.addEventListener('waiting', handleWaiting);
      videoElement.addEventListener('canplay', handleCanPlay);
    }
  }
  
  function removeVideoListeners() {
    if (videoElement) {
      videoElement.removeEventListener('loadedmetadata', handleLoadedMetadata);
      videoElement.removeEventListener('timeupdate', handleTimeUpdate);
      videoElement.removeEventListener('ended', handleEnded);
      videoElement.removeEventListener('waiting', handleWaiting);
      videoElement.removeEventListener('canplay', handleCanPlay);
    }
  }
  
  function handleLoadedMetadata() {
    duration = videoElement.duration;
  }
  
  function handleTimeUpdate() {
    currentTime = videoElement.currentTime;
  }
  
  function handleEnded() {
    isPlaying = false;
  }
  
  function handleWaiting() {
    buffering = true;
  }
  
  function handleCanPlay() {
    buffering = false;
    isLoading = false;
  }
  
  function togglePlay() {
    if (videoElement) {
      if (isPlaying) {
        videoElement.pause();
      } else {
        videoElement.play();
      }
      isPlaying = !isPlaying;
    }
  }
  
  function handleSeek(event) {
    if (videoElement) {
      const rect = event.currentTarget.getBoundingClientRect();
      const clickX = event.clientX - rect.left;
      const newTime = (clickX / rect.width) * duration;
      videoElement.currentTime = newTime;
      currentTime = newTime;
    }
  }
  
  function handleVolumeChange(event) {
    if (videoElement) {
      const newVolume = parseFloat(event.target.value);
      volume = newVolume;
      videoElement.volume = newVolume;
      isMuted = newVolume === 0;
    }
  }
  
  function toggleMute() {
    if (videoElement) {
      if (isMuted) {
        videoElement.volume = volume;
        isMuted = false;
      } else {
        videoElement.volume = 0;
        isMuted = true;
      }
    }
  }
  
  function handlePlaybackRateChange(rate) {
    if (videoElement) {
      playbackRate = rate;
      videoElement.playbackRate = rate;
    }
    showPlaybackSpeedMenu = false;
  }
  
  function handleQualityChange(quality) {
    console.log('Quality changed to:', quality);
    showQualityMenu = false;
  }
  
  function handleCaptionChange(caption) {
    console.log('Captions changed to:', caption);
    showCaptions = caption !== 'off';
    showSettings = false;
  }
  
  function toggleFullscreen() {
    if (!document.fullscreenElement) {
      document.documentElement.requestFullscreen();
      isFullscreen = true;
    } else {
      document.exitFullscreen();
      isFullscreen = false;
    }
  }
  
  function formatTime(seconds) {
    const mins = Math.floor(seconds / 60);
    const secs = Math.floor(seconds % 60);
    return `${mins}:${secs.toString().padStart(2, '0')}`;
  }
  
  function getProgressPercentage() {
    return duration > 0 ? (currentTime / duration) * 100 : 0;
  }
</script>

<div class="media-player" class:fullscreen={isFullscreen}>
  <div class="video-container">
    <video
      bind:this={videoElement}
      class="video-element"
      poster="https://via.placeholder.com/800x450/333/fff?text=Video+Thumbnail"
      preload="metadata"
    >
      <source src="https://sample-videos.com/zip/10/mp4/SampleVideo_1280x720_1mb.mp4" type="video/mp4">
      Your browser does not support the video tag.
    </video>

    {#if isLoading || buffering}
      <div class="loading-overlay">
        <div class="loading-spinner"></div>
        <span class="loading-text">
          {isLoading ? 'Loading...' : 'Buffering...'}
        </span>
      </div>
    {/if}

    <div class="video-overlay">
      <div class="video-controls">
        <div class="progress-container">
          <div 
            class="progress-bar"
            on:click={handleSeek}
          >
            <div 
              class="progress-fill"
              style="width: {getProgressPercentage()}%"
            ></div>
            <div 
              class="progress-handle"
              style="left: {getProgressPercentage()}%"
            ></div>
          </div>
        </div>

        <div class="controls-row">
          <div class="left-controls">
            <button 
              on:click={togglePlay}
              class="control-btn play-btn"
            >
              {isPlaying ? '⏸️' : '▶️'}
            </button>
            
            <div class="time-display">
              <span class="current-time">{formatTime(currentTime)}</span>
              <span class="time-separator">/</span>
              <span class="duration">{formatTime(duration)}</span>
            </div>

            <div class="volume-control">
              <button 
                on:click={toggleMute}
                class="control-btn volume-btn"
              >
                {isMuted ? '🔇' : volume > 0.5 ? '🔊' : '🔉'}
              </button>
              
              <div 
                class="volume-slider-container"
                class:show={showVolumeSlider}
              >
                <input
                  type="range"
                  min="0"
                  max="1"
                  step="0.01"
                  bind:value={volume}
                  on:input={handleVolumeChange}
                  class="volume-slider"
                />
              </div>
            </div>
          </div>

          <div class="right-controls">
            <div class="playback-speed">
              <button 
                on:click={() => showPlaybackSpeedMenu = !showPlaybackSpeedMenu}
                class="control-btn speed-btn"
              >
                {playbackRate}x
              </button>
              
              {#if showPlaybackSpeedMenu}
                <div class="speed-menu">
                  {#each speedOptions as option}
                    <button
                      on:click={() => handlePlaybackRateChange(option.value)}
                      class="speed-option"
                      class:active={playbackRate === option.value}
                    >
                      {option.label}
                    </button>
                  {/each}
                </div>
              {/if}
            </div>

            <div class="quality-selector">
              <button 
                on:click={() => showQualityMenu = !showQualityMenu}
                class="control-btn quality-btn"
              >
                Quality
              </button>
              
              {#if showQualityMenu}
                <div class="quality-menu">
                  {#each qualityOptions as option}
                    <button
                      on:click={() => handleQualityChange(option.value)}
                      class="quality-option"
                    >
                      {option.label}
                    </button>
                  {/each}
                </div>
              {/if}
            </div>

            <button 
              on:click={() => showSettings = !showSettings}
              class="control-btn settings-btn"
            >
              ⚙️
            </button>

            <button 
              on:click={toggleFullscreen}
              class="control-btn fullscreen-btn"
            >
              {isFullscreen ? '⤢' : '⤡'}
            </button>
          </div>
        </div>
      </div>
    </div>
  </div>

  {#if showSettings}
    <div class="settings-panel">
      <div class="settings-header">
        <h3>Player Settings</h3>
        <button 
          on:click={() => showSettings = false}
          class="close-btn"
        >
          ✕
        </button>
      </div>
      
      <div class="settings-content">
        <div class="setting-group">
          <label class="setting-label">Captions</label>
          <select 
            on:change={(e) => handleCaptionChange(e.target.value)}
            class="setting-select"
          >
            {#each captionOptions as option}
              <option value={option.value}>
                {option.label}
              </option>
            {/each}
          </select>
        </div>

        <div class="setting-group">
          <label class="setting-label">Quality</label>
          <select class="setting-select">
            {#each qualityOptions as option}
              <option value={option.value}>
                {option.label}
              </option>
            {/each}
          </select>
        </div>

        <div class="setting-group">
          <label class="setting-label">Playback Speed</label>
          <select 
            on:change={(e) => handlePlaybackRateChange(parseFloat(e.target.value))}
            class="setting-select"
          >
            {#each speedOptions as option}
              <option value={option.value}>
                {option.label}
              </option>
            {/each}
          </select>
        </div>

        <div class="setting-group">
          <label class="setting-label">Volume</label>
          <input
            type="range"
            min="0"
            max="1"
            step="0.01"
            bind:value={volume}
            on:input={handleVolumeChange}
            class="setting-slider"
          />
        </div>
      </div>
    </div>
  {/if}
</div>

<style>
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

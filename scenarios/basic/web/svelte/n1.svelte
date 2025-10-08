<script>
  let currentVideo = 0;
  let isPlaying = true;
  let volume = 0.5;
  let isMuted = false;
  let playbackSpeed = 1.0;
  let showControls = false;

  const videos = [
    {
      id: 1,
      title: 'Mountain Adventure',
      description: 'Breathtaking views of mountain peaks and valleys',
      video: 'mountain-adventure.mp4',
      thumbnail: 'mountain-thumb.jpg',
      duration: '2:34',
      category: 'Nature'
    },
    {
      id: 2,
      title: 'City Life',
      description: 'Dynamic urban scenes and city architecture',
      video: 'city-life.mp4',
      thumbnail: 'city-thumb.jpg',
      duration: '3:12',
      category: 'Urban'
    },
    {
      id: 3,
      title: 'Ocean Waves',
      description: 'Peaceful ocean waves and coastal scenery',
      video: 'ocean-waves.mp4',
      thumbnail: 'ocean-thumb.jpg',
      duration: '4:05',
      category: 'Nature'
    },
    {
      id: 4,
      title: 'Tech Innovation',
      description: 'Modern technology and digital transformation',
      video: 'tech-innovation.mp4',
      thumbnail: 'tech-thumb.jpg',
      duration: '2:48',
      category: 'Technology'
    },
    {
      id: 5,
      title: 'Art Gallery',
      description: 'Contemporary art and creative expressions',
      video: 'art-gallery.mp4',
      thumbnail: 'art-thumb.jpg',
      duration: '3:45',
      category: 'Culture'
    }
  ];

  let intervalId = null;

  function startRotation() {
    if (intervalId) {
      clearInterval(intervalId);
    }
    
    if (isPlaying) {
      intervalId = setInterval(() => {
        currentVideo = (currentVideo + 1) % videos.length;
      }, 5000); // Change video every 5 seconds
    }
  }

  function stopRotation() {
    if (intervalId) {
      clearInterval(intervalId);
      intervalId = null;
    }
  }

  function togglePlayPause() {
    isPlaying = !isPlaying;
    if (isPlaying) {
      startRotation();
    } else {
      stopRotation();
    }
  }

  function goToVideo(index) {
    currentVideo = index;
    if (isPlaying) {
      startRotation();
    }
  }

  function toggleMute() {
    isMuted = !isMuted;
  }

  function adjustVolume(vol) {
    volume = vol;
    isMuted = vol === 0;
  }

  function adjustSpeed(speed) {
    playbackSpeed = speed;
  }

  function handleVideoClick() {
    showControls = !showControls;
  }

  function handleVideoAction(action) {
    alert(`${action} action performed on "${videos[currentVideo].title}"`);
  }

  // Start rotation on component mount
  startRotation();

  // Cleanup on component destroy
  $: if (typeof window !== 'undefined') {
    return () => {
      if (intervalId) {
        clearInterval(intervalId);
      }
    };
  }
</script>

<div class="video-showcase">
  <header class="showcase-header">
    <h1>Video Showcase</h1>
    <p>Immersive video experience with automatic playback</p>
  </header>

  <div class="video-container" on:click={handleVideoClick}>
    <div class="video-background">
      <video 
        src="/videos/{videos[currentVideo].video}"
        autoplay
        muted={isMuted}
        loop
        class="background-video"
        style="filter: brightness({volume * 2})"
      >
        Your browser does not support the video tag.
      </video>
      
      <div class="video-overlay">
        <div class="video-info">
          <h2 class="video-title">{videos[currentVideo].title}</h2>
          <p class="video-description">{videos[currentVideo].description}</p>
          <div class="video-meta">
            <span class="video-duration">{videos[currentVideo].duration}</span>
            <span class="video-category">{videos[currentVideo].category}</span>
          </div>
        </div>
      </div>

      {#if showControls}
        <div class="video-controls">
          <div class="control-row">
            <button 
              class="control-btn {isPlaying ? 'pause' : 'play'}" 
              on:click|stopPropagation={togglePlayPause}
            >
              {isPlaying ? '⏸️' : '▶️'}
            </button>
            
            <div class="volume-control">
              <button 
                class="volume-btn" 
                on:click|stopPropagation={toggleMute}
              >
                {isMuted ? '🔇' : '🔊'}
              </button>
              <input 
                type="range" 
                min="0" 
                max="1" 
                step="0.1" 
                bind:value={volume}
                on:input={(e) => adjustVolume(parseFloat(e.target.value))}
                class="volume-slider"
              />
            </div>

            <div class="speed-control">
              <label>Speed:</label>
              <select 
                bind:value={playbackSpeed} 
                on:change={(e) => adjustSpeed(parseFloat(e.target.value))}
                class="speed-select"
              >
                <option value="0.5">0.5x</option>
                <option value="0.75">0.75x</option>
                <option value="1.0">1x</option>
                <option value="1.25">1.25x</option>
                <option value="1.5">1.5x</option>
                <option value="2.0">2x</option>
              </select>
            </div>
          </div>

          <div class="video-actions">
            <button 
              class="action-btn" 
              on:click|stopPropagation={() => handleVideoAction('Like')}
            >
              ❤️ Like
            </button>
            <button 
              class="action-btn" 
              on:click|stopPropagation={() => handleVideoAction('Share')}
            >
              🔗 Share
            </button>
            <button 
              class="action-btn" 
              on:click|stopPropagation={() => handleVideoAction('Download')}
            >
              ⬇️ Download
            </button>
            <button 
              class="action-btn" 
              on:click|stopPropagation={() => handleVideoAction('Fullscreen')}
            >
              ⛶ Fullscreen
            </button>
          </div>
        </div>
      {/if}
    </div>

    <div class="video-indicators">
      {#each videos as video, index}
        <button 
          class="indicator {currentVideo === index ? 'active' : ''}" 
          on:click={() => goToVideo(index)}
        >
          <img src="/images/{video.thumbnail}" alt="{video.title}" />
          <span class="indicator-title">{video.title}</span>
        </button>
      {/each}
    </div>
  </div>

  <div class="video-playlist">
    <h3>Video Playlist</h3>
    <div class="playlist-items">
      {#each videos as video, index}
        <div 
          class="playlist-item {currentVideo === index ? 'active' : ''}"
          on:click={() => goToVideo(index)}
        >
          <div class="playlist-thumbnail">
            <img src="/images/{video.thumbnail}" alt="{video.title}" />
            <div class="playlist-duration">{video.duration}</div>
          </div>
          <div class="playlist-content">
            <h4 class="playlist-title">{video.title}</h4>
            <p class="playlist-description">{video.description}</p>
            <div class="playlist-meta">
              <span class="playlist-category">{video.category}</span>
              <span class="playlist-id">Video #{video.id}</span>
            </div>
          </div>
        </div>
      {/each}
    </div>
  </div>

  <div class="video-stats">
    <div class="stat-item">
      <span class="stat-label">Current Video:</span>
      <span class="stat-value">{currentVideo + 1} of {videos.length}</span>
    </div>
    <div class="stat-item">
      <span class="stat-label">Status:</span>
      <span class="stat-value">{isPlaying ? 'Playing' : 'Paused'}</span>
    </div>
    <div class="stat-item">
      <span class="stat-label">Volume:</span>
      <span class="stat-value">{Math.round(volume * 100)}%</span>
    </div>
    <div class="stat-item">
      <span class="stat-label">Speed:</span>
      <span class="stat-value">{playbackSpeed}x</span>
    </div>
  </div>
</div>

<style>
  .video-showcase {
    max-width: 1400px;
    margin: 50px auto;
    padding: 20px;
    font-family: Arial, sans-serif;
  }

  .showcase-header {
    text-align: center;
    margin-bottom: 40px;
  }

  .showcase-header h1 {
    margin: 0 0 10px 0;
    font-size: 36px;
    color: #333;
  }

  .showcase-header p {
    margin: 0;
    color: #666;
    font-size: 18px;
  }

  .video-container {
    position: relative;
    height: 500px;
    border-radius: 12px;
    overflow: hidden;
    box-shadow: 0 8px 32px rgba(0,0,0,0.3);
    margin-bottom: 30px;
    cursor: pointer;
  }

  .video-background {
    position: relative;
    width: 100%;
    height: 100%;
  }

  .background-video {
    width: 100%;
    height: 100%;
    object-fit: cover;
  }

  .video-overlay {
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background: linear-gradient(
      to bottom,
      rgba(0,0,0,0.3) 0%,
      rgba(0,0,0,0.1) 50%,
      rgba(0,0,0,0.5) 100%
    );
    display: flex;
    align-items: center;
    justify-content: center;
    z-index: 2;
  }

  .video-info {
    text-align: center;
    color: white;
    max-width: 600px;
    padding: 20px;
  }

  .video-title {
    margin: 0 0 15px 0;
    font-size: 48px;
    font-weight: bold;
    text-shadow: 2px 2px 4px rgba(0,0,0,0.7);
  }

  .video-description {
    margin: 0 0 20px 0;
    font-size: 20px;
    line-height: 1.4;
    text-shadow: 1px 1px 2px rgba(0,0,0,0.7);
  }

  .video-meta {
    display: flex;
    justify-content: center;
    gap: 30px;
    font-size: 16px;
    text-shadow: 1px 1px 2px rgba(0,0,0,0.7);
  }

  .video-duration {
    font-weight: bold;
  }

  .video-category {
    background: rgba(255,255,255,0.2);
    padding: 4px 12px;
    border-radius: 20px;
    font-weight: bold;
  }

  .video-controls {
    position: absolute;
    bottom: 0;
    left: 0;
    right: 0;
    background: linear-gradient(to top, rgba(0,0,0,0.8), transparent);
    padding: 20px;
    z-index: 3;
  }

  .control-row {
    display: flex;
    align-items: center;
    gap: 20px;
    margin-bottom: 15px;
  }

  .control-btn {
    background: rgba(255,255,255,0.2);
    color: white;
    border: none;
    border-radius: 50%;
    width: 50px;
    height: 50px;
    cursor: pointer;
    font-size: 20px;
    display: flex;
    align-items: center;
    justify-content: center;
    transition: background-color 0.2s ease;
  }

  .control-btn:hover {
    background: rgba(255,255,255,0.3);
  }

  .volume-control {
    display: flex;
    align-items: center;
    gap: 10px;
  }

  .volume-btn {
    background: none;
    border: none;
    color: white;
    font-size: 18px;
    cursor: pointer;
    padding: 5px;
  }

  .volume-slider {
    width: 100px;
  }

  .speed-control {
    display: flex;
    align-items: center;
    gap: 8px;
    color: white;
  }

  .speed-control label {
    font-size: 14px;
  }

  .speed-select {
    padding: 4px 8px;
    border: 1px solid rgba(255,255,255,0.3);
    border-radius: 4px;
    background: rgba(0,0,0,0.5);
    color: white;
  }

  .video-actions {
    display: flex;
    gap: 10px;
    flex-wrap: wrap;
  }

  .action-btn {
    background: rgba(255,255,255,0.2);
    color: white;
    border: 1px solid rgba(255,255,255,0.3);
    padding: 8px 16px;
    border-radius: 20px;
    cursor: pointer;
    font-size: 14px;
    transition: all 0.2s ease;
  }

  .action-btn:hover {
    background: rgba(255,255,255,0.3);
  }

  .video-indicators {
    display: flex;
    gap: 10px;
    justify-content: center;
    margin-bottom: 30px;
  }

  .indicator {
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 8px;
    background: white;
    border: 2px solid #ddd;
    border-radius: 8px;
    padding: 10px;
    cursor: pointer;
    transition: all 0.2s ease;
    min-width: 120px;
  }

  .indicator:hover {
    border-color: #007bff;
    transform: translateY(-2px);
  }

  .indicator.active {
    border-color: #007bff;
    box-shadow: 0 0 0 2px rgba(0,123,255,0.2);
  }

  .indicator img {
    width: 60px;
    height: 40px;
    object-fit: cover;
    border-radius: 4px;
  }

  .indicator-title {
    font-size: 12px;
    font-weight: bold;
    color: #333;
    text-align: center;
  }

  .video-playlist {
    background: white;
    padding: 30px;
    border-radius: 8px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.1);
    margin-bottom: 30px;
  }

  .video-playlist h3 {
    margin: 0 0 20px 0;
    font-size: 24px;
    color: #333;
  }

  .playlist-items {
    display: flex;
    flex-direction: column;
    gap: 15px;
  }

  .playlist-item {
    display: flex;
    gap: 15px;
    padding: 15px;
    border: 1px solid #eee;
    border-radius: 8px;
    cursor: pointer;
    transition: all 0.2s ease;
  }

  .playlist-item:hover {
    border-color: #007bff;
    background: #f8f9fa;
  }

  .playlist-item.active {
    border-color: #007bff;
    background: #e3f2fd;
  }

  .playlist-thumbnail {
    position: relative;
    width: 120px;
    height: 80px;
    flex-shrink: 0;
  }

  .playlist-thumbnail img {
    width: 100%;
    height: 100%;
    object-fit: cover;
    border-radius: 4px;
  }

  .playlist-duration {
    position: absolute;
    bottom: 4px;
    right: 4px;
    background: rgba(0,0,0,0.7);
    color: white;
    padding: 2px 6px;
    border-radius: 4px;
    font-size: 11px;
    font-weight: bold;
  }

  .playlist-content {
    flex: 1;
  }

  .playlist-title {
    margin: 0 0 8px 0;
    font-size: 16px;
    color: #333;
  }

  .playlist-description {
    margin: 0 0 10px 0;
    font-size: 14px;
    color: #666;
    line-height: 1.4;
  }

  .playlist-meta {
    display: flex;
    justify-content: space-between;
    align-items: center;
  }

  .playlist-category {
    background: #e9ecef;
    color: #495057;
    padding: 2px 8px;
    border-radius: 12px;
    font-size: 11px;
    font-weight: bold;
  }

  .playlist-id {
    font-size: 12px;
    color: #999;
  }

  .video-stats {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
    gap: 20px;
  }

  .stat-item {
    background: white;
    padding: 20px;
    border-radius: 8px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.1);
    display: flex;
    justify-content: space-between;
    align-items: center;
  }

  .stat-label {
    font-weight: bold;
    color: #333;
  }

  .stat-value {
    color: #007bff;
    font-weight: bold;
  }
</style>

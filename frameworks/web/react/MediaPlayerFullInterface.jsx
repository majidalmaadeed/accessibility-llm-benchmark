import React, { useState, useRef, useEffect } from 'react';
import './MediaPlayerFullInterface.css';

const MediaPlayerFullInterface = () => {
  const videoRef = useRef(null);
  const [isPlaying, setIsPlaying] = useState(false);
  const [currentTime, setCurrentTime] = useState(0);
  const [duration, setDuration] = useState(0);
  const [volume, setVolume] = useState(1);
  const [isMuted, setIsMuted] = useState(false);
  const [playbackRate, setPlaybackRate] = useState(1);
  const [isFullscreen, setIsFullscreen] = useState(false);
  const [showCaptions, setShowCaptions] = useState(false);
  const [showQualityMenu, setShowQualityMenu] = useState(false);
  const [showSettingsMenu, setShowSettingsMenu] = useState(false);
  const [selectedQuality, setSelectedQuality] = useState('1080p');
  const [selectedCaption, setSelectedCaption] = useState('English');
  const [showControls, setShowControls] = useState(true);
  const [isLoading, setIsLoading] = useState(false);

  const qualityOptions = ['360p', '480p', '720p', '1080p', '4K'];
  const captionOptions = ['English', 'Spanish', 'French', 'German', 'Off'];
  const playbackRates = [0.5, 0.75, 1, 1.25, 1.5, 2];

  useEffect(() => {
    const video = videoRef.current;
    if (!video) return;

    const handleTimeUpdate = () => setCurrentTime(video.currentTime);
    const handleDurationChange = () => setDuration(video.duration);
    const handleLoadStart = () => setIsLoading(true);
    const handleCanPlay = () => setIsLoading(false);
    const handlePlay = () => setIsPlaying(true);
    const handlePause = () => setIsPlaying(false);

    video.addEventListener('timeupdate', handleTimeUpdate);
    video.addEventListener('durationchange', handleDurationChange);
    video.addEventListener('loadstart', handleLoadStart);
    video.addEventListener('canplay', handleCanPlay);
    video.addEventListener('play', handlePlay);
    video.addEventListener('pause', handlePause);

    return () => {
      video.removeEventListener('timeupdate', handleTimeUpdate);
      video.removeEventListener('durationchange', handleDurationChange);
      video.removeEventListener('loadstart', handleLoadStart);
      video.removeEventListener('canplay', handleCanPlay);
      video.removeEventListener('play', handlePlay);
      video.removeEventListener('pause', handlePause);
    };
  }, []);

  const togglePlay = () => {
    const video = videoRef.current;
    if (!video) return;

    if (isPlaying) {
      video.pause();
    } else {
      video.play();
    }
  };

  const handleSeek = (e) => {
    const video = videoRef.current;
    if (!video) return;

    const rect = e.currentTarget.getBoundingClientRect();
    const clickX = e.clientX - rect.left;
    const newTime = (clickX / rect.width) * duration;
    video.currentTime = newTime;
    setCurrentTime(newTime);
  };

  const handleVolumeChange = (e) => {
    const video = videoRef.current;
    if (!video) return;

    const newVolume = parseFloat(e.target.value);
    video.volume = newVolume;
    setVolume(newVolume);
    setIsMuted(newVolume === 0);
  };

  const toggleMute = () => {
    const video = videoRef.current;
    if (!video) return;

    if (isMuted) {
      video.volume = volume;
      setIsMuted(false);
    } else {
      video.volume = 0;
      setIsMuted(true);
    }
  };

  const changePlaybackRate = (rate) => {
    const video = videoRef.current;
    if (!video) return;

    video.playbackRate = rate;
    setPlaybackRate(rate);
  };

  const toggleFullscreen = () => {
    if (!document.fullscreenElement) {
      videoRef.current?.requestFullscreen();
      setIsFullscreen(true);
    } else {
      document.exitFullscreen();
      setIsFullscreen(false);
    }
  };

  const formatTime = (time) => {
    const minutes = Math.floor(time / 60);
    const seconds = Math.floor(time % 60);
    return `${minutes}:${seconds.toString().padStart(2, '0')}`;
  };

  const handleQualityChange = (quality) => {
    setSelectedQuality(quality);
    setShowQualityMenu(false);
    console.log(`Quality changed to ${quality}`);
  };

  const handleCaptionChange = (caption) => {
    setSelectedCaption(caption);
    setShowCaptions(caption !== 'Off');
    console.log(`Captions changed to ${caption}`);
  };

  return (
    <div className={`media-player ${isFullscreen ? 'fullscreen' : ''}`}>
      <div className="video-container">
        <video
          ref={videoRef}
          className="video-element"
          poster="https://via.placeholder.com/800x450/333/fff?text=Sample+Video"
          onMouseMove={() => setShowControls(true)}
          onMouseLeave={() => setShowControls(false)}
        >
          <source src="https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4" type="video/mp4" />
          <track kind="captions" srcLang="en" label="English" default />
          <track kind="captions" srcLang="es" label="Spanish" />
          <track kind="captions" srcLang="fr" label="French" />
          <track kind="captions" srcLang="de" label="German" />
        </video>

        {isLoading && (
          <div className="loading-overlay">
            <div className="loading-spinner"></div>
            <span>Loading...</span>
          </div>
        )}

        {showControls && (
          <div className="video-controls">
            {/* Progress Bar */}
            <div className="progress-container" onClick={handleSeek}>
              <div className="progress-bar">
                <div 
                  className="progress-fill" 
                  style={{ width: `${(currentTime / duration) * 100}%` }}
                ></div>
                <div 
                  className="progress-handle" 
                  style={{ left: `${(currentTime / duration) * 100}%` }}
                ></div>
              </div>
            </div>

            {/* Control Buttons */}
            <div className="controls-row">
              <div className="left-controls">
                <button 
                  className="control-btn play-btn"
                  onClick={togglePlay}
                >
                  {isPlaying ? '⏸️' : '▶️'}
                </button>

                <div className="time-display">
                  {formatTime(currentTime)} / {formatTime(duration)}
                </div>

                <button 
                  className="control-btn volume-btn"
                  onClick={toggleMute}
                >
                  {isMuted ? '🔇' : volume > 0.5 ? '🔊' : '🔉'}
                </button>

                <div className="volume-slider">
                  <input
                    type="range"
                    min="0"
                    max="1"
                    step="0.1"
                    value={isMuted ? 0 : volume}
                    onChange={handleVolumeChange}
                    className="volume-range"
                  />
                </div>
              </div>

              <div className="right-controls">
                <div className="playback-rate-menu">
                  <button 
                    className="control-btn"
                    onClick={() => setShowSettingsMenu(!showSettingsMenu)}
                  >
                    {playbackRate}x
                  </button>
                  {showSettingsMenu && (
                    <div className="settings-dropdown">
                      <div className="settings-section">
                        <div className="settings-label">Playback Speed</div>
                        {playbackRates.map(rate => (
                          <button
                            key={rate}
                            className={`settings-option ${playbackRate === rate ? 'active' : ''}`}
                            onClick={() => {
                              changePlaybackRate(rate);
                              setShowSettingsMenu(false);
                            }}
                          >
                            {rate}x
                          </button>
                        ))}
                      </div>
                    </div>
                  )}
                </div>

                <div className="quality-menu">
                  <button 
                    className="control-btn"
                    onClick={() => setShowQualityMenu(!showQualityMenu)}
                  >
                    {selectedQuality}
                  </button>
                  {showQualityMenu && (
                    <div className="quality-dropdown">
                      {qualityOptions.map(quality => (
                        <button
                          key={quality}
                          className={`quality-option ${selectedQuality === quality ? 'active' : ''}`}
                          onClick={() => handleQualityChange(quality)}
                        >
                          {quality}
                        </button>
                      ))}
                    </div>
                  )}
                </div>

                <button 
                  className="control-btn captions-btn"
                  onClick={() => setShowCaptions(!showCaptions)}
                >
                  {showCaptions ? '📺' : '📺'}
                </button>

                <button 
                  className="control-btn fullscreen-btn"
                  onClick={toggleFullscreen}
                >
                  {isFullscreen ? '⤢' : '⤡'}
                </button>
              </div>
            </div>
          </div>
        )}

        {/* Captions Menu */}
        {showCaptions && (
          <div className="captions-menu">
            <div className="captions-header">Captions</div>
            {captionOptions.map(caption => (
              <button
                key={caption}
                className={`caption-option ${selectedCaption === caption ? 'active' : ''}`}
                onClick={() => handleCaptionChange(caption)}
              >
                {caption}
              </button>
            ))}
          </div>
        )}
      </div>

      {/* Video Info */}
      <div className="video-info">
        <h3>Big Buck Bunny</h3>
        <p>A short animated film by the Blender Institute</p>
        <div className="video-meta">
          <span>Duration: {formatTime(duration)}</span>
          <span>Quality: {selectedQuality}</span>
          <span>Captions: {selectedCaption}</span>
        </div>
      </div>
    </div>
  );
};

export default MediaPlayerFullInterface;

'use client';

import { useState, useRef, useEffect } from 'react';
import styles from './MediaPlayerFullInterface.module.css';

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

  const handleSeek = (event) => {
    const video = videoRef.current;
    if (!video) return;

    const target = event.currentTarget;
    const rect = target.getBoundingClientRect();
    const clickX = event.clientX - rect.left;
    const newTime = (clickX / rect.width) * duration;
    video.currentTime = newTime;
    setCurrentTime(newTime);
  };

  const handleVolumeChange = (event) => {
    const video = videoRef.current;
    if (!video) return;

    const newVolume = parseFloat(event.target.value);
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
    const video = videoRef.current;
    if (!video) return;

    if (!document.fullscreenElement) {
      video.requestFullscreen();
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

  const onMouseMove = () => {
    setShowControls(true);
  };

  const onMouseLeave = () => {
    setShowControls(false);
  };

  const getVolumeIcon = () => {
    if (isMuted) return '🔇';
    if (volume > 0.5) return '🔊';
    return '🔉';
  };

  const getPlayIcon = () => {
    return isPlaying ? '⏸️' : '▶️';
  };

  const getFullscreenIcon = () => {
    return isFullscreen ? '⤢' : '⤡';
  };

  return (
    <div className={`${styles.mediaPlayer} ${isFullscreen ? styles.fullscreen : ''}`}>
      <div className={styles.videoContainer}>
        <video
          ref={videoRef}
          className={styles.videoElement}
          poster="https://via.placeholder.com/800x450/333/fff?text=Sample+Video"
          onMouseMove={onMouseMove}
          onMouseLeave={onMouseLeave}
        >
          <source src="https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4" type="video/mp4" />
          <track kind="captions" srcLang="en" label="English" default />
          <track kind="captions" srcLang="es" label="Spanish" />
          <track kind="captions" srcLang="fr" label="French" />
          <track kind="captions" srcLang="de" label="German" />
        </video>

        {isLoading && (
          <div className={styles.loadingOverlay}>
            <div className={styles.loadingSpinner}></div>
            <span>Loading...</span>
          </div>
        )}

        {showControls && (
          <div className={styles.videoControls}>
            <div className={styles.progressContainer} onClick={handleSeek}>
              <div className={styles.progressBar}>
                <div 
                  className={styles.progressFill} 
                  style={{ width: `${(currentTime / duration) * 100}%` }}
                />
                <div 
                  className={styles.progressHandle} 
                  style={{ left: `${(currentTime / duration) * 100}%` }}
                />
              </div>
            </div>

            <div className={styles.controlsRow}>
              <div className={styles.leftControls}>
                <button 
                  onClick={togglePlay}
                  className={styles.playBtn}
                >
                  {getPlayIcon()}
                </button>

                <div className={styles.timeDisplay}>
                  {formatTime(currentTime)} / {formatTime(duration)}
                </div>

                <button 
                  onClick={toggleMute}
                  className={styles.volumeBtn}
                >
                  {getVolumeIcon()}
                </button>

                <div className={styles.volumeSlider}>
                  <input
                    type="range"
                    min="0"
                    max="1"
                    step="0.1"
                    value={isMuted ? 0 : volume}
                    onChange={handleVolumeChange}
                    className={styles.volumeRange}
                  />
                </div>
              </div>

              <div className={styles.rightControls}>
                <div className={styles.playbackRateMenu}>
                  <button 
                    onClick={() => setShowSettingsMenu(!showSettingsMenu)}
                    className={styles.controlBtn}
                  >
                    {playbackRate}x
                  </button>
                  {showSettingsMenu && (
                    <div className={styles.settingsDropdown}>
                      <div className={styles.settingsSection}>
                        <div className={styles.settingsLabel}>Playback Speed</div>
                        {playbackRates.map(rate => (
                          <button
                            key={rate}
                            className={`${styles.settingsOption} ${playbackRate === rate ? styles.active : ''}`}
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

                <div className={styles.qualityMenu}>
                  <button 
                    onClick={() => setShowQualityMenu(!showQualityMenu)}
                    className={styles.controlBtn}
                  >
                    {selectedQuality}
                  </button>
                  {showQualityMenu && (
                    <div className={styles.qualityDropdown}>
                      {qualityOptions.map(quality => (
                        <button
                          key={quality}
                          className={`${styles.qualityOption} ${selectedQuality === quality ? styles.active : ''}`}
                          onClick={() => handleQualityChange(quality)}
                        >
                          {quality}
                        </button>
                      ))}
                    </div>
                  )}
                </div>

                <button 
                  onClick={() => setShowCaptions(!showCaptions)}
                  className={styles.captionsBtn}
                >
                  📺
                </button>

                <button 
                  onClick={toggleFullscreen}
                  className={styles.fullscreenBtn}
                >
                  {getFullscreenIcon()}
                </button>
              </div>
            </div>
          </div>
        )}

        {showCaptions && (
          <div className={styles.captionsMenu}>
            <div className={styles.captionsHeader}>Captions</div>
            {captionOptions.map(caption => (
              <button
                key={caption}
                className={`${styles.captionOption} ${selectedCaption === caption ? styles.active : ''}`}
                onClick={() => handleCaptionChange(caption)}
              >
                {caption}
              </button>
            ))}
          </div>
        )}
      </div>

      <div className={styles.videoInfo}>
        <h3>Big Buck Bunny</h3>
        <p>A short animated film by the Blender Institute</p>
        <div className={styles.videoMeta}>
          <span>Duration: {formatTime(duration)}</span>
          <span>Quality: {selectedQuality}</span>
          <span>Captions: {selectedCaption}</span>
        </div>
      </div>
    </div>
  );
};

export default MediaPlayerFullInterface;

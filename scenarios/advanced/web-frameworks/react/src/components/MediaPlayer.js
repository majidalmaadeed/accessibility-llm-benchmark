import React, { useState, useEffect } from 'react';

const MediaPlayer = () => {
  const [isPlaying, setIsPlaying] = useState(false);
  const [currentTime, setCurrentTime] = useState(0);
  const [duration, setDuration] = useState(180);
  const [volume, setVolume] = useState(50);
  const [isMuted, setIsMuted] = useState(false);
  const [currentTrack, setCurrentTrack] = useState({
    title: 'Sample Track',
    artist: 'Sample Artist',
    album: 'Sample Album',
    year: '2024'
  });
  const [playlist, setPlaylist] = useState([
    { id: 1, title: 'Track 1', artist: 'Artist 1', duration: '3:45' },
    { id: 2, title: 'Track 2', artist: 'Artist 2', duration: '4:12' },
    { id: 3, title: 'Track 3', artist: 'Artist 3', duration: '3:28' },
    { id: 4, title: 'Track 4', artist: 'Artist 4', duration: '4:33' },
    { id: 5, title: 'Track 5', artist: 'Artist 5', duration: '3:56' }
  ]);
  const [currentTrackIndex, setCurrentTrackIndex] = useState(0);
  const [isShuffled, setIsShuffled] = useState(false);
  const [isRepeating, setIsRepeating] = useState(false);

  useEffect(() => {
    let interval;
    if (isPlaying) {
      interval = setInterval(() => {
        setCurrentTime(prev => {
          if (prev >= duration) {
            if (isRepeating) {
              return 0;
            } else {
              nextTrack();
              return 0;
            }
          }
          return prev + 1;
        });
      }, 1000);
    }
    return () => clearInterval(interval);
  }, [isPlaying, duration, isRepeating]);

  const togglePlayPause = () => {
    setIsPlaying(!isPlaying);
  };

  const stop = () => {
    setIsPlaying(false);
    setCurrentTime(0);
  };

  const nextTrack = () => {
    if (currentTrackIndex < playlist.length - 1) {
      setCurrentTrackIndex(currentTrackIndex + 1);
    } else {
      setCurrentTrackIndex(0);
    }
    setCurrentTime(0);
  };

  const previousTrack = () => {
    if (currentTrackIndex > 0) {
      setCurrentTrackIndex(currentTrackIndex - 1);
    } else {
      setCurrentTrackIndex(playlist.length - 1);
    }
    setCurrentTime(0);
  };

  const handleSeek = (e) => {
    const rect = e.currentTarget.getBoundingClientRect();
    const clickX = e.clientX - rect.left;
    const newTime = (clickX / rect.width) * duration;
    setCurrentTime(newTime);
  };

  const handleVolumeChange = (e) => {
    setVolume(parseInt(e.target.value));
    setIsMuted(false);
  };

  const toggleMute = () => {
    setIsMuted(!isMuted);
  };

  const toggleShuffle = () => {
    setIsShuffled(!isShuffled);
  };

  const toggleRepeat = () => {
    setIsRepeating(!isRepeating);
  };

  const playTrack = (index) => {
    setCurrentTrackIndex(index);
    setCurrentTime(0);
    setIsPlaying(true);
  };

  const formatTime = (seconds) => {
    const mins = Math.floor(seconds / 60);
    const secs = Math.floor(seconds % 60);
    return `${mins}:${secs.toString().padStart(2, '0')}`;
  };

  const progressPercentage = (currentTime / duration) * 100;

  return (
    <div className="container">
      <div className="page-header">
        <h1 className="page-title">Media Player Full Interface</h1>
        <p className="page-subtitle">
          Full-featured media player interface
        </p>
      </div>

      <div className="card">
        <div className="media-player">
          <div style={{ textAlign: 'center', marginBottom: '1rem' }}>
            <h3 style={{ margin: '0 0 0.5rem 0', color: 'white' }}>Now Playing</h3>
            <div style={{ fontSize: '1.2rem', fontWeight: '600', marginBottom: '0.25rem' }}>
              {currentTrack.title}
            </div>
            <div style={{ color: '#ccc', marginBottom: '1rem' }}>
              {currentTrack.artist} - {currentTrack.album} ({currentTrack.year})
            </div>
          </div>

          <div className="media-progress" onClick={handleSeek}>
            <div 
              className="media-progress-bar" 
              style={{ width: `${progressPercentage}%` }}
            />
          </div>

          <div className="media-time" style={{ textAlign: 'center', margin: '0.5rem 0' }}>
            {formatTime(currentTime)} / {formatTime(duration)}
          </div>

          <div className="media-controls">
            <div className="media-buttons">
              <button className="media-btn" onClick={toggleShuffle} title="Shuffle">
                🔀
              </button>
              <button className="media-btn" onClick={previousTrack} title="Previous">
                ⏮
              </button>
              <button className="media-btn" onClick={togglePlayPause} title={isPlaying ? 'Pause' : 'Play'}>
                {isPlaying ? '⏸' : '▶️'}
              </button>
              <button className="media-btn" onClick={stop} title="Stop">
                ⏹
              </button>
              <button className="media-btn" onClick={nextTrack} title="Next">
                ⏭
              </button>
              <button className="media-btn" onClick={toggleRepeat} title="Repeat">
                🔁
              </button>
            </div>
          </div>

          <div style={{ display: 'flex', alignItems: 'center', gap: '1rem', marginTop: '1rem' }}>
            <button className="media-btn" onClick={toggleMute} title={isMuted ? 'Unmute' : 'Mute'}>
              {isMuted ? '🔇' : '🔊'}
            </button>
            <input
              type="range"
              min="0"
              max="100"
              value={isMuted ? 0 : volume}
              onChange={handleVolumeChange}
              style={{ flex: 1 }}
            />
            <span style={{ color: '#ccc', minWidth: '40px' }}>
              {isMuted ? '0%' : `${volume}%`}
            </span>
          </div>
        </div>
      </div>

      <div className="card">
        <h2>Playlist</h2>
        <div style={{ maxHeight: '300px', overflowY: 'auto' }}>
          {playlist.map((track, index) => (
            <div
              key={track.id}
              style={{
                display: 'flex',
                alignItems: 'center',
                padding: '0.75rem',
                borderBottom: '1px solid #eee',
                backgroundColor: index === currentTrackIndex ? '#e3f2fd' : 'white',
                cursor: 'pointer'
              }}
              onClick={() => playTrack(index)}
            >
              <div style={{ marginRight: '1rem', fontSize: '1.2rem' }}>
                {index === currentTrackIndex && isPlaying ? '🎵' : '🎶'}
              </div>
              <div style={{ flex: 1 }}>
                <div style={{ fontWeight: index === currentTrackIndex ? '600' : '400' }}>
                  {track.title}
                </div>
                <div style={{ fontSize: '0.9rem', color: '#666' }}>
                  {track.artist}
                </div>
              </div>
              <div style={{ color: '#666', fontSize: '0.9rem' }}>
                {track.duration}
              </div>
            </div>
          ))}
        </div>
      </div>

      <div className="card">
        <h2>Equalizer</h2>
        <div style={{ display: 'flex', alignItems: 'end', gap: '0.5rem', height: '120px' }}>
          {[60, 170, 310, 600, 1000, 3000, 6000, 12000, 14000, 16000].map((freq, index) => (
            <div key={freq} style={{ display: 'flex', flexDirection: 'column', alignItems: 'center', flex: 1 }}>
              <input
                type="range"
                min="-12"
                max="12"
                defaultValue="0"
                orient="vertical"
                style={{ 
                  writingMode: 'bt-lr',
                  width: '20px',
                  height: '80px'
                }}
              />
              <div style={{ fontSize: '0.8rem', color: '#666', marginTop: '0.5rem' }}>
                {freq >= 1000 ? `${freq/1000}k` : freq}Hz
              </div>
            </div>
          ))}
        </div>
      </div>

      <div className="card">
        <h2>Playback Settings</h2>
        <div className="form-row">
          <div className="form-group">
            <label className="form-label">Playback Speed</label>
            <select className="form-control">
              <option value="0.5">0.5x</option>
              <option value="0.75">0.75x</option>
              <option value="1">1x (Normal)</option>
              <option value="1.25">1.25x</option>
              <option value="1.5">1.5x</option>
              <option value="2">2x</option>
            </select>
          </div>
          <div className="form-group">
            <label className="form-label">Audio Quality</label>
            <select className="form-control">
              <option value="low">Low (128 kbps)</option>
              <option value="medium">Medium (256 kbps)</option>
              <option value="high">High (320 kbps)</option>
              <option value="lossless">Lossless (FLAC)</option>
            </select>
          </div>
          <div className="form-group">
            <label className="form-label">Crossfade</label>
            <input
              type="range"
              min="0"
              max="10"
              defaultValue="0"
              className="form-control"
            />
          </div>
        </div>
        <div className="form-group">
          <label>
            <input type="checkbox" defaultChecked />
            Auto-play next track
          </label>
        </div>
        <div className="form-group">
          <label>
            <input type="checkbox" />
            Fade in/out
          </label>
        </div>
        <div className="form-group">
          <label>
            <input type="checkbox" />
            Remember playback position
          </label>
        </div>
      </div>
    </div>
  );
};

export default MediaPlayer;

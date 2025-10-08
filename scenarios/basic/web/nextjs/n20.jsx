import { useState } from 'react';

export default function UnlabeledMediaButton() {
  const [isPlaying, setIsPlaying] = useState(false);
  const [currentTime, setCurrentTime] = useState(0);
  const [duration, setDuration] = useState(120);
  const [volume, setVolume] = useState(0.8);
  const [isMuted, setIsMuted] = useState(false);

  const togglePlay = () => {
    setIsPlaying(!isPlaying);
  };

  const toggleMute = () => {
    setIsMuted(!isMuted);
  };

  const seekTo = (time) => {
    setCurrentTime(time);
  };

  const adjustVolume = (vol) => {
    setVolume(vol);
    setIsMuted(vol === 0);
  };

  const formatTime = (seconds) => {
    const mins = Math.floor(seconds / 60);
    const secs = Math.floor(seconds % 60);
    return `${mins}:${secs.toString().padStart(2, '0')}`;
  };

  return (
    <div className="media-player">
      <h1>Video Player</h1>
      <p>Watch your favorite videos with our advanced media player</p>
      
      <div className="video-container">
        <div className="video-placeholder">
          <div className="video-content">
            <h2>Sample Video</h2>
            <p>Duration: {formatTime(duration)}</p>
            <p>Status: {isPlaying ? 'Playing' : 'Paused'}</p>
          </div>
        </div>
      </div>

      <div className="controls">
        <div className="main-controls">
          <button onClick={togglePlay} className="play-button">
            {isPlaying ? '⏸️' : '▶️'}
          </button>
          
          <div className="time-display">
            <span>{formatTime(currentTime)}</span>
            <span>/</span>
            <span>{formatTime(duration)}</span>
          </div>
        </div>

        <div className="progress-section">
          <div 
            className="progress-bar" 
            onClick={(e) => {
              const rect = e.currentTarget.getBoundingClientRect();
              const clickX = e.clientX - rect.left;
              const percentage = clickX / rect.width;
              seekTo(percentage * duration);
            }}
          >
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

        <div className="volume-section">
          <button onClick={toggleMute} className="volume-button">
            {isMuted ? '🔇' : '🔊'}
          </button>
          
          <input 
            type="range" 
            min="0" 
            max="1" 
            step="0.1" 
            value={volume}
            onChange={(e) => adjustVolume(parseFloat(e.target.value))}
            className="volume-slider"
          />
          
          <span className="volume-text">{Math.round(volume * 100)}%</span>
        </div>

        <div className="additional-controls">
          <button className="control-btn">⏮️</button>
          <button className="control-btn">⏭️</button>
          <button className="control-btn">🔄</button>
          <button className="control-btn">⚙️</button>
        </div>
      </div>

      <div className="playlist">
        <h3>Playlist</h3>
        <div className="playlist-items">
          <div className="playlist-item active">
            <span className="playlist-number">1</span>
            <span className="playlist-title">Current Video</span>
            <span className="playlist-duration">{formatTime(duration)}</span>
          </div>
          <div className="playlist-item">
            <span className="playlist-number">2</span>
            <span className="playlist-title">Next Video</span>
            <span className="playlist-duration">3:45</span>
          </div>
          <div className="playlist-item">
            <span className="playlist-number">3</span>
            <span className="playlist-title">Another Video</span>
            <span className="playlist-duration">5:20</span>
          </div>
        </div>
      </div>

      <style jsx>{`
        .media-player {
          max-width: 800px;
          margin: 50px auto;
          padding: 20px;
          font-family: Arial, sans-serif;
        }

        .video-container {
          background: #000;
          border-radius: 8px;
          margin-bottom: 20px;
          overflow: hidden;
        }

        .video-placeholder {
          height: 300px;
          display: flex;
          align-items: center;
          justify-content: center;
          background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        }

        .video-content {
          text-align: center;
          color: white;
        }

        .video-content h2 {
          margin: 0 0 10px 0;
          font-size: 24px;
        }

        .video-content p {
          margin: 5px 0;
          opacity: 0.9;
        }

        .controls {
          background: #f8f9fa;
          padding: 20px;
          border-radius: 8px;
          margin-bottom: 20px;
        }

        .main-controls {
          display: flex;
          align-items: center;
          gap: 15px;
          margin-bottom: 15px;
        }

        .play-button {
          background: #007bff;
          color: white;
          border: none;
          border-radius: 50%;
          width: 50px;
          height: 50px;
          font-size: 20px;
          cursor: pointer;
          display: flex;
          align-items: center;
          justify-content: center;
        }

        .time-display {
          font-family: monospace;
          font-size: 14px;
          color: #666;
        }

        .progress-section {
          margin-bottom: 15px;
        }

        .progress-bar {
          width: 100%;
          height: 6px;
          background: #ddd;
          border-radius: 3px;
          position: relative;
          cursor: pointer;
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

        .volume-section {
          display: flex;
          align-items: center;
          gap: 10px;
          margin-bottom: 15px;
        }

        .volume-button {
          background: none;
          border: none;
          font-size: 18px;
          cursor: pointer;
          padding: 5px;
        }

        .volume-slider {
          flex: 1;
          max-width: 100px;
        }

        .volume-text {
          font-size: 12px;
          color: #666;
          min-width: 35px;
        }

        .additional-controls {
          display: flex;
          gap: 10px;
        }

        .control-btn {
          background: #6c757d;
          color: white;
          border: none;
          border-radius: 4px;
          padding: 8px 12px;
          cursor: pointer;
          font-size: 14px;
        }

        .playlist {
          background: white;
          border-radius: 8px;
          padding: 20px;
          border: 1px solid #e0e0e0;
        }

        .playlist h3 {
          margin: 0 0 15px 0;
          font-size: 18px;
        }

        .playlist-items {
          display: flex;
          flex-direction: column;
          gap: 8px;
        }

        .playlist-item {
          display: flex;
          align-items: center;
          padding: 10px;
          border-radius: 4px;
          cursor: pointer;
          transition: background-color 0.2s ease;
        }

        .playlist-item:hover {
          background: #f8f9fa;
        }

        .playlist-item.active {
          background: #e3f2fd;
        }

        .playlist-number {
          width: 25px;
          text-align: center;
          font-weight: bold;
          color: #666;
        }

        .playlist-title {
          flex: 1;
          margin-left: 10px;
        }

        .playlist-duration {
          font-size: 12px;
          color: #666;
          font-family: monospace;
        }
      `}</style>
    </div>
  );
}

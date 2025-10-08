import React, { useState } from 'react';

const UnlabeledMediaButton = () => {
  const [isPlaying, setIsPlaying] = useState(false);

  const togglePlayPause = () => {
    setIsPlaying(!isPlaying);
  };

  return (
    <div style={{ 
      maxWidth: '600px', 
      margin: '50px auto', 
      padding: '20px',
      fontFamily: 'Arial, sans-serif'
    }}>
      <h1>Video Player</h1>
      <p>Watch our latest tutorial video.</p>
      
      <div style={{
        background: '#000',
        borderRadius: '8px',
        padding: '20px',
        marginBottom: '20px'
      }}>
        {/* Video placeholder */}
        <div style={{
          width: '100%',
          height: '300px',
          background: 'linear-gradient(45deg, #333, #666)',
          borderRadius: '4px',
          display: 'flex',
          alignItems: 'center',
          justifyContent: 'center',
          color: 'white',
          fontSize: '18px',
          marginBottom: '20px'
        }}>
          Video Content Placeholder
        </div>
        
        {/* Video controls - play button with only emoji icon, no accessible name */}
        <div style={{
          display: 'flex',
          alignItems: 'center',
          gap: '15px'
        }}>
          <button
            onClick={togglePlayPause}
            style={{
              background: '#ff6b6b',
              border: 'none',
              borderRadius: '50%',
              width: '60px',
              height: '60px',
              display: 'flex',
              alignItems: 'center',
              justifyContent: 'center',
              cursor: 'pointer',
              fontSize: '24px'
            }}
          >
            {isPlaying ? '⏸️' : '▶️'}
          </button>
          
          <div style={{ color: 'white', fontSize: '14px' }}>
            {isPlaying ? 'Paused' : 'Playing'}
          </div>
        </div>
      </div>
    </div>
  );
};

export default UnlabeledMediaButton;

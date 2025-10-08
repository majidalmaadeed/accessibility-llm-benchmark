import React, { useState, useEffect } from 'react';

const AutoPlayingBackgroundVideo = () => {
  const [isMuted, setIsMuted] = useState(true);
  const [showControls, setShowControls] = useState(false);

  useEffect(() => {
    // Simulate video loading and autoplay
    const timer = setTimeout(() => {
      setShowControls(true);
    }, 2000);

    return () => clearTimeout(timer);
  }, []);

  return (
    <div style={{ 
      position: 'relative',
      minHeight: '100vh',
      fontFamily: 'Arial, sans-serif'
    }}>
      {/* Hero section video autoplays without user control */}
      <div style={{
        position: 'fixed',
        top: 0,
        left: 0,
        width: '100%',
        height: '100%',
        background: 'linear-gradient(45deg, #1e3c72, #2a5298)',
        zIndex: -1,
        overflow: 'hidden'
      }}>
        {/* Simulated video content */}
        <div style={{
          position: 'absolute',
          top: '50%',
          left: '50%',
          transform: 'translate(-50%, -50%)',
          width: '100%',
          height: '100%',
          background: 'url("https://via.placeholder.com/1920x1080/1e3c72/ffffff?text=Background+Video") center/cover',
          opacity: 0.3
        }} />
        
        {/* Animated overlay */}
        <div style={{
          position: 'absolute',
          top: 0,
          left: 0,
          width: '100%',
          height: '100%',
          background: 'linear-gradient(45deg, transparent 30%, rgba(255,255,255,0.1) 50%, transparent 70%)',
          animation: 'shimmer 3s infinite'
        }} />
      </div>

      {/* Main content */}
      <div style={{
        position: 'relative',
        zIndex: 1,
        padding: '50px 20px',
        color: 'white',
        textAlign: 'center'
      }}>
        <h1 style={{ 
          fontSize: '48px', 
          margin: '0 0 20px 0',
          fontWeight: 'bold',
          textShadow: '2px 2px 4px rgba(0,0,0,0.5)'
        }}>
          Welcome to Our Platform
        </h1>
        <p style={{ 
          fontSize: '24px', 
          margin: '0 0 40px 0',
          textShadow: '1px 1px 2px rgba(0,0,0,0.5)',
          maxWidth: '600px',
          margin: '0 auto 40px auto'
        }}>
          Experience the future of technology with our innovative solutions
        </p>
        
        <div style={{
          display: 'flex',
          gap: '20px',
          justifyContent: 'center',
          flexWrap: 'wrap',
          marginBottom: '60px'
        }}>
          <button style={{
            background: 'rgba(255,255,255,0.2)',
            color: 'white',
            border: '2px solid white',
            padding: '15px 30px',
            borderRadius: '25px',
            fontSize: '18px',
            fontWeight: 'bold',
            cursor: 'pointer',
            backdropFilter: 'blur(10px)',
            transition: 'all 0.3s ease'
          }}>
            Get Started
          </button>
          <button style={{
            background: 'transparent',
            color: 'white',
            border: '2px solid white',
            padding: '15px 30px',
            borderRadius: '25px',
            fontSize: '18px',
            fontWeight: 'bold',
            cursor: 'pointer',
            backdropFilter: 'blur(10px)',
            transition: 'all 0.3s ease'
          }}>
            Learn More
          </button>
        </div>

        {/* Features section */}
        <div style={{
          display: 'grid',
          gridTemplateColumns: 'repeat(auto-fit, minmax(300px, 1fr))',
          gap: '30px',
          maxWidth: '1000px',
          margin: '0 auto',
          padding: '40px 20px',
          background: 'rgba(0,0,0,0.3)',
          borderRadius: '12px',
          backdropFilter: 'blur(10px)'
        }}>
          <div style={{
            padding: '30px',
            background: 'rgba(255,255,255,0.1)',
            borderRadius: '8px',
            border: '1px solid rgba(255,255,255,0.2)'
          }}>
            <h3 style={{ 
              fontSize: '24px', 
              margin: '0 0 15px 0',
              color: 'white'
            }}>
              🚀 Innovation
            </h3>
            <p style={{ 
              fontSize: '16px', 
              lineHeight: '1.6',
              margin: 0,
              color: 'rgba(255,255,255,0.9)'
            }}>
              Cutting-edge technology that pushes the boundaries of what's possible
            </p>
          </div>
          
          <div style={{
            padding: '30px',
            background: 'rgba(255,255,255,0.1)',
            borderRadius: '8px',
            border: '1px solid rgba(255,255,255,0.2)'
          }}>
            <h3 style={{ 
              fontSize: '24px', 
              margin: '0 0 15px 0',
              color: 'white'
            }}>
              🔒 Security
            </h3>
            <p style={{ 
              fontSize: '16px', 
              lineHeight: '1.6',
              margin: 0,
              color: 'rgba(255,255,255,0.9)'
            }}>
              Enterprise-grade security to protect your data and privacy
            </p>
          </div>
          
          <div style={{
            padding: '30px',
            background: 'rgba(255,255,255,0.1)',
            borderRadius: '8px',
            border: '1px solid rgba(255,255,255,0.2)'
          }}>
            <h3 style={{ 
              fontSize: '24px', 
              margin: '0 0 15px 0',
              color: 'white'
            }}>
              ⚡ Performance
            </h3>
            <p style={{ 
              fontSize: '16px', 
              lineHeight: '1.6',
              margin: 0,
              color: 'rgba(255,255,255,0.9)'
            }}>
              Lightning-fast performance optimized for the best user experience
            </p>
          </div>
        </div>
      </div>

      {/* Video controls overlay */}
      {showControls && (
        <div style={{
          position: 'fixed',
          bottom: '20px',
          right: '20px',
          background: 'rgba(0,0,0,0.8)',
          color: 'white',
          padding: '15px',
          borderRadius: '8px',
          zIndex: 1000,
          display: 'flex',
          alignItems: 'center',
          gap: '10px'
        }}>
          <button
            onClick={() => setIsMuted(!isMuted)}
            style={{
              background: 'transparent',
              color: 'white',
              border: '1px solid white',
              padding: '8px 12px',
              borderRadius: '4px',
              cursor: 'pointer',
              fontSize: '14px'
            }}
          >
            {isMuted ? '🔇 Unmute' : '🔊 Mute'}
          </button>
          <span style={{ fontSize: '12px', color: '#ccc' }}>
            Background video playing
          </span>
        </div>
      )}

      <style jsx>{`
        @keyframes shimmer {
          0% { transform: translateX(-100%); }
          100% { transform: translateX(100%); }
        }
      `}</style>
    </div>
  );
};

export default AutoPlayingBackgroundVideo;

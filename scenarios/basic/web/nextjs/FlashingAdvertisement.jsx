import { useState, useEffect } from 'react';

export default function FlashingAdvertisement() {
  const [currentAd, setCurrentAd] = useState(0);
  const [isPlaying, setIsPlaying] = useState(true);
  const [adSpeed, setAdSpeed] = useState(200); // milliseconds
  const [intervalId, setIntervalId] = useState(null);

  const advertisements = [
    {
      id: 1,
      title: 'Mega Sale - 70% Off!',
      description: 'Everything must go! Limited time offer.',
      image: 'sale-banner-1.jpg',
      link: '/sale',
      color: '#ff4757',
      textColor: '#ffffff'
    },
    {
      id: 2,
      title: 'New Collection',
      description: 'Discover our latest fashion trends.',
      image: 'fashion-banner.jpg',
      link: '/new-collection',
      color: '#2ed573',
      textColor: '#ffffff'
    },
    {
      id: 3,
      title: 'Free Shipping',
      description: 'On orders over $50. Shop now!',
      image: 'shipping-banner.jpg',
      link: '/shipping',
      color: '#ffa502',
      textColor: '#ffffff'
    },
    {
      id: 4,
      title: 'Tech Deals',
      description: 'Latest gadgets at unbeatable prices.',
      image: 'tech-banner.jpg',
      link: '/tech-deals',
      color: '#3742fa',
      textColor: '#ffffff'
    },
    {
      id: 5,
      title: 'Flash Sale',
      description: '24 hours only! Don\'t miss out.',
      image: 'flash-sale.jpg',
      link: '/flash-sale',
      color: '#ff3838',
      textColor: '#ffffff'
    }
  ];

  const startRotation = () => {
    if (intervalId) {
      clearInterval(intervalId);
    }
    
    if (isPlaying) {
      const newIntervalId = setInterval(() => {
        setCurrentAd(prev => (prev + 1) % advertisements.length);
      }, adSpeed);
      setIntervalId(newIntervalId);
    }
  };

  const stopRotation = () => {
    if (intervalId) {
      clearInterval(intervalId);
      setIntervalId(null);
    }
  };

  const togglePlayPause = () => {
    setIsPlaying(!isPlaying);
  };

  const goToAd = (index) => {
    setCurrentAd(index);
    if (isPlaying) {
      startRotation();
    }
  };

  const handleAdClick = (ad) => {
    alert(`Redirecting to: ${ad.link}`);
  };

  const adjustSpeed = (newSpeed) => {
    setAdSpeed(newSpeed);
    if (isPlaying) {
      startRotation();
    }
  };

  // Start rotation on component mount
  useEffect(() => {
    startRotation();
    
    return () => {
      if (intervalId) {
        clearInterval(intervalId);
      }
    };
  }, [isPlaying, adSpeed]);

  return (
    <div className="advertisement-banner">
      <div className="banner-container">
        <div className="banner-content">
          <div className="banner-image">
            <img 
              src={`/images/${advertisements[currentAd].image}`}
              alt="Advertisement banner"
            />
          </div>
          
          <div 
            className="banner-text" 
            style={{ 
              backgroundColor: advertisements[currentAd].color, 
              color: advertisements[currentAd].textColor 
            }}
          >
            <h2 className="banner-title">{advertisements[currentAd].title}</h2>
            <p className="banner-description">{advertisements[currentAd].description}</p>
            <button 
              className="banner-cta"
              onClick={() => handleAdClick(advertisements[currentAd])}
            >
              Shop Now
            </button>
          </div>
        </div>

        <div className="banner-controls">
          <div className="control-group">
            <button 
              className={`control-btn ${isPlaying ? 'pause' : 'play'}`}
              onClick={togglePlayPause}
              title={isPlaying ? 'Pause rotation' : 'Start rotation'}
            >
              {isPlaying ? '⏸️' : '▶️'}
            </button>
            
            <div className="speed-control">
              <label htmlFor="speed-slider">Speed:</label>
              <input 
                id="speed-slider"
                type="range" 
                min="100" 
                max="1000" 
                step="100"
                value={adSpeed}
                onChange={(e) => adjustSpeed(parseInt(e.target.value))}
                className="speed-slider"
              />
              <span className="speed-value">{adSpeed}ms</span>
            </div>
          </div>

          <div className="ad-indicators">
            {advertisements.map((ad, index) => (
              <button 
                key={ad.id}
                className={`indicator ${currentAd === index ? 'active' : ''}`}
                onClick={() => goToAd(index)}
                title={`Go to advertisement ${index + 1}`}
              >
                {index + 1}
              </button>
            ))}
          </div>
        </div>
      </div>

      <div className="advertisement-stats">
        <div className="stat-item">
          <span className="stat-label">Current Ad:</span>
          <span className="stat-value">{currentAd + 1} of {advertisements.length}</span>
        </div>
        <div className="stat-item">
          <span className="stat-label">Status:</span>
          <span className="stat-value">{isPlaying ? 'Playing' : 'Paused'}</span>
        </div>
        <div className="stat-item">
          <span className="stat-label">Speed:</span>
          <span className="stat-value">{adSpeed}ms</span>
        </div>
      </div>

      <div className="advertisement-list">
        <h3>All Advertisements</h3>
        <div className="ad-grid">
          {advertisements.map((ad, index) => (
            <div 
              key={ad.id}
              className={`ad-preview ${currentAd === index ? 'active' : ''}`}
              onClick={() => goToAd(index)}
            >
              <div className="preview-image">
                <img src={`/images/${ad.image}`} alt="Ad preview" />
              </div>
              <div className="preview-content">
                <h4 className="preview-title">{ad.title}</h4>
                <p className="preview-description">{ad.description}</p>
                <div className="preview-meta">
                  <span className="preview-id">Ad #{ad.id}</span>
                  <span className="preview-link">{ad.link}</span>
                </div>
              </div>
            </div>
          ))}
        </div>
      </div>

      <style jsx>{`
        .advertisement-banner {
          max-width: 1200px;
          margin: 50px auto;
          padding: 20px;
          font-family: Arial, sans-serif;
        }

        .banner-container {
          background: white;
          border-radius: 12px;
          box-shadow: 0 4px 16px rgba(0,0,0,0.1);
          overflow: hidden;
          margin-bottom: 30px;
        }

        .banner-content {
          position: relative;
          height: 400px;
          display: flex;
          align-items: center;
          overflow: hidden;
        }

        .banner-image {
          position: absolute;
          top: 0;
          left: 0;
          width: 100%;
          height: 100%;
          z-index: 1;
        }

        .banner-image img {
          width: 100%;
          height: 100%;
          object-fit: cover;
        }

        .banner-text {
          position: relative;
          z-index: 2;
          padding: 40px;
          max-width: 500px;
          background: rgba(0,0,0,0.7);
          backdrop-filter: blur(10px);
          border-radius: 8px;
          margin: 20px;
        }

        .banner-title {
          margin: 0 0 15px 0;
          font-size: 36px;
          font-weight: bold;
          text-shadow: 2px 2px 4px rgba(0,0,0,0.5);
        }

        .banner-description {
          margin: 0 0 25px 0;
          font-size: 18px;
          line-height: 1.4;
          text-shadow: 1px 1px 2px rgba(0,0,0,0.5);
        }

        .banner-cta {
          background: rgba(255,255,255,0.2);
          color: white;
          border: 2px solid white;
          padding: 12px 30px;
          border-radius: 25px;
          font-size: 16px;
          font-weight: bold;
          cursor: pointer;
          transition: all 0.3s ease;
        }

        .banner-cta:hover {
          background: white;
          color: #333;
        }

        .banner-controls {
          display: flex;
          justify-content: space-between;
          align-items: center;
          padding: 20px;
          background: #f8f9fa;
          border-top: 1px solid #eee;
        }

        .control-group {
          display: flex;
          align-items: center;
          gap: 20px;
        }

        .control-btn {
          background: #007bff;
          color: white;
          border: none;
          border-radius: 50%;
          width: 40px;
          height: 40px;
          cursor: pointer;
          font-size: 16px;
          display: flex;
          align-items: center;
          justify-content: center;
          transition: background-color 0.2s ease;
        }

        .control-btn:hover {
          background: #0056b3;
        }

        .speed-control {
          display: flex;
          align-items: center;
          gap: 10px;
        }

        .speed-control label {
          font-size: 14px;
          color: #666;
        }

        .speed-slider {
          width: 100px;
        }

        .speed-value {
          font-size: 12px;
          color: #666;
          min-width: 50px;
        }

        .ad-indicators {
          display: flex;
          gap: 8px;
        }

        .indicator {
          width: 32px;
          height: 32px;
          border: 2px solid #ddd;
          background: white;
          border-radius: 50%;
          cursor: pointer;
          font-size: 12px;
          font-weight: bold;
          color: #666;
          display: flex;
          align-items: center;
          justify-content: center;
          transition: all 0.2s ease;
        }

        .indicator:hover {
          border-color: #007bff;
          color: #007bff;
        }

        .indicator.active {
          background: #007bff;
          border-color: #007bff;
          color: white;
        }

        .advertisement-stats {
          display: grid;
          grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
          gap: 20px;
          margin-bottom: 30px;
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

        .advertisement-list {
          background: white;
          padding: 30px;
          border-radius: 8px;
          box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }

        .advertisement-list h3 {
          margin: 0 0 20px 0;
          font-size: 24px;
          color: #333;
        }

        .ad-grid {
          display: grid;
          grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
          gap: 20px;
        }

        .ad-preview {
          border: 2px solid #eee;
          border-radius: 8px;
          overflow: hidden;
          cursor: pointer;
          transition: all 0.2s ease;
        }

        .ad-preview:hover {
          border-color: #007bff;
          transform: translateY(-2px);
          box-shadow: 0 4px 12px rgba(0,0,0,0.15);
        }

        .ad-preview.active {
          border-color: #007bff;
          box-shadow: 0 0 0 2px rgba(0,123,255,0.2);
        }

        .preview-image {
          height: 150px;
          overflow: hidden;
        }

        .preview-image img {
          width: 100%;
          height: 100%;
          object-fit: cover;
        }

        .preview-content {
          padding: 15px;
        }

        .preview-title {
          margin: 0 0 8px 0;
          font-size: 16px;
          color: #333;
        }

        .preview-description {
          margin: 0 0 10px 0;
          font-size: 14px;
          color: #666;
          line-height: 1.4;
        }

        .preview-meta {
          display: flex;
          justify-content: space-between;
          align-items: center;
        }

        .preview-id {
          font-size: 12px;
          color: #007bff;
          font-weight: bold;
        }

        .preview-link {
          font-size: 12px;
          color: #666;
          font-family: monospace;
        }
      `}</style>
    </div>
  );
}

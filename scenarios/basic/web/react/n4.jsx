import React, { useState, useEffect } from 'react';

const FlashingAdvertisement = () => {
  const [isFlashing, setIsFlashing] = useState(true);
  const [showAd, setShowAd] = useState(true);

  useEffect(() => {
    if (!showAd) return;

    // Flash every 200ms (5 times per second)
    const flashInterval = setInterval(() => {
      setIsFlashing(prev => !prev);
    }, 200);

    return () => clearInterval(flashInterval);
  }, [showAd]);

  const closeAd = () => {
    setShowAd(false);
  };

  return (
    <div style={{ 
      maxWidth: '1000px', 
      margin: '50px auto', 
      padding: '20px',
      fontFamily: 'Arial, sans-serif'
    }}>
      <h1>News Website</h1>
      <p>Stay informed with the latest news and updates from around the world.</p>
      
      {/* Sale banner flashing 5 times per second */}
      {showAd && (
        <div style={{
          position: 'relative',
          background: isFlashing ? '#ff4444' : '#ff6b6b',
          color: 'white',
          padding: '20px',
          borderRadius: '8px',
          marginBottom: '30px',
          textAlign: 'center',
          transition: 'background-color 0.2s ease',
          boxShadow: '0 4px 12px rgba(255, 68, 68, 0.3)'
        }}>
          <button
            onClick={closeAd}
            style={{
              position: 'absolute',
              top: '10px',
              right: '15px',
              background: 'rgba(255,255,255,0.2)',
              color: 'white',
              border: 'none',
              borderRadius: '50%',
              width: '30px',
              height: '30px',
              cursor: 'pointer',
              fontSize: '16px',
              fontWeight: 'bold'
            }}
          >
            ×
          </button>
          
          <h2 style={{ 
            margin: '0 0 10px 0', 
            fontSize: '24px',
            fontWeight: 'bold'
          }}>
            🔥 LIMITED TIME OFFER! 🔥
          </h2>
          <p style={{ 
            margin: '0 0 15px 0', 
            fontSize: '18px'
          }}>
            Get 50% OFF on Premium Subscription
          </p>
          <div style={{
            display: 'flex',
            justifyContent: 'center',
            alignItems: 'center',
            gap: '20px',
            flexWrap: 'wrap'
          }}>
            <button style={{
              background: 'white',
              color: '#ff4444',
              border: 'none',
              padding: '12px 24px',
              borderRadius: '25px',
              fontSize: '16px',
              fontWeight: 'bold',
              cursor: 'pointer',
              boxShadow: '0 2px 8px rgba(0,0,0,0.2)'
            }}>
              CLAIM OFFER NOW
            </button>
          </div>
        </div>
      )}

      <div style={{
        display: 'grid',
        gridTemplateColumns: 'repeat(auto-fit, minmax(300px, 1fr))',
        gap: '30px',
        marginBottom: '30px'
      }}>
        <article style={{
          background: 'white',
          padding: '25px',
          borderRadius: '8px',
          boxShadow: '0 2px 8px rgba(0,0,0,0.1)',
          border: '1px solid #e0e0e0'
        }}>
          <h2 style={{ 
            fontSize: '22px', 
            margin: '0 0 15px 0',
            color: '#333'
          }}>
            Breaking: New Technology Breakthrough
          </h2>
          <p style={{ 
            fontSize: '16px', 
            lineHeight: '1.6',
            color: '#666',
            margin: '0 0 20px 0'
          }}>
            Scientists have made a significant breakthrough in quantum computing that 
            could revolutionize how we process information and solve complex problems.
          </p>
          <div style={{
            display: 'flex',
            justifyContent: 'space-between',
            alignItems: 'center'
          }}>
            <span style={{ 
              fontSize: '14px', 
              color: '#999'
            }}>
              2 hours ago
            </span>
            <button style={{
              background: '#007bff',
              color: 'white',
              border: 'none',
              padding: '8px 16px',
              borderRadius: '4px',
              cursor: 'pointer',
              fontSize: '14px'
            }}>
              Read More
            </button>
          </div>
        </article>

        <article style={{
          background: 'white',
          padding: '25px',
          borderRadius: '8px',
          boxShadow: '0 2px 8px rgba(0,0,0,0.1)',
          border: '1px solid #e0e0e0'
        }}>
          <h2 style={{ 
            fontSize: '22px', 
            margin: '0 0 15px 0',
            color: '#333'
          }}>
            Market Update: Stocks Reach New High
          </h2>
          <p style={{ 
            fontSize: '16px', 
            lineHeight: '1.6',
            color: '#666',
            margin: '0 0 20px 0'
          }}>
            The stock market has reached new all-time highs as investors show 
            confidence in the economic recovery and technological innovation.
          </p>
          <div style={{
            display: 'flex',
            justifyContent: 'space-between',
            alignItems: 'center'
          }}>
            <span style={{ 
              fontSize: '14px', 
              color: '#999'
            }}>
              4 hours ago
            </span>
            <button style={{
              background: '#007bff',
              color: 'white',
              border: 'none',
              padding: '8px 16px',
              borderRadius: '4px',
              cursor: 'pointer',
              fontSize: '14px'
            }}>
              Read More
            </button>
          </div>
        </article>
      </div>

      <div style={{
        background: '#f8f9fa',
        padding: '30px',
        borderRadius: '8px',
        textAlign: 'center'
      }}>
        <h2 style={{ 
          fontSize: '24px', 
          margin: '0 0 15px 0',
          color: '#333'
        }}>
          Subscribe to Our Newsletter
        </h2>
        <p style={{ 
          fontSize: '16px', 
          margin: '0 0 25px 0',
          color: '#666'
        }}>
          Get the latest news delivered directly to your inbox.
        </p>
        
        <div style={{ display: 'flex', gap: '10px', justifyContent: 'center', flexWrap: 'wrap' }}>
          <input 
            type="email" 
            placeholder="Enter your email address"
            style={{
              padding: '12px 16px',
              border: '1px solid #ddd',
              borderRadius: '4px',
              fontSize: '16px',
              minWidth: '250px'
            }}
          />
          <button style={{
            background: '#28a745',
            color: 'white',
            border: 'none',
            padding: '12px 24px',
            borderRadius: '4px',
            cursor: 'pointer',
            fontSize: '16px'
          }}>
            Subscribe
          </button>
        </div>
      </div>
    </div>
  );
};

export default FlashingAdvertisement;

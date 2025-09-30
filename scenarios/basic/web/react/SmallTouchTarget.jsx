import React, { useState } from 'react';

const SmallTouchTarget = () => {
  const [liked, setLiked] = useState(false);
  const [shared, setShared] = useState(false);
  const [bookmarked, setBookmarked] = useState(false);

  return (
    <div style={{ 
      maxWidth: '600px', 
      margin: '50px auto', 
      padding: '20px',
      fontFamily: 'Arial, sans-serif'
    }}>
      <h1>Article: "The Future of Web Development"</h1>
      
      <div style={{
        background: '#f8f9fa',
        padding: '20px',
        borderRadius: '8px',
        marginBottom: '20px'
      }}>
        <p style={{ 
          fontSize: '16px', 
          lineHeight: '1.6',
          margin: '0 0 20px 0',
          color: '#333'
        }}>
          Web development is evolving rapidly with new frameworks, tools, and methodologies 
          emerging every year. This article explores the latest trends and technologies 
          that are shaping the future of web development.
        </p>
      </div>

      <div style={{
        background: '#e3f2fd',
        padding: '20px',
        borderRadius: '8px',
        marginBottom: '20px'
      }}>
        <h2>Author Information</h2>
        <div style={{ display: 'flex', alignItems: 'center', gap: '15px' }}>
          <div style={{
            width: '50px',
            height: '50px',
            borderRadius: '50%',
            background: '#2196f3',
            display: 'flex',
            alignItems: 'center',
            justifyContent: 'center',
            color: 'white',
            fontSize: '20px',
            fontWeight: 'bold'
          }}>
            JS
          </div>
          <div>
            <h3 style={{ margin: '0 0 5px 0', fontSize: '18px' }}>John Smith</h3>
            <p style={{ margin: 0, color: '#666', fontSize: '14px' }}>
              Senior Web Developer at TechCorp
            </p>
          </div>
        </div>
      </div>

      {/* Social share buttons with small touch targets (20x20px) */}
      <div style={{
        display: 'flex',
        justifyContent: 'space-between',
        alignItems: 'center',
        padding: '20px',
        background: 'white',
        border: '1px solid #ddd',
        borderRadius: '8px'
      }}>
        <div style={{ display: 'flex', gap: '5px' }}>
          <button
            onClick={() => setLiked(!liked)}
            style={{
              background: liked ? '#e91e63' : 'transparent',
              border: '1px solid #e91e63',
              color: liked ? 'white' : '#e91e63',
              padding: '2px',
              borderRadius: '4px',
              cursor: 'pointer',
              fontSize: '12px',
              width: '20px',
              height: '20px',
              display: 'flex',
              alignItems: 'center',
              justifyContent: 'center'
            }}
          >
            ❤️
          </button>
          
          <button
            onClick={() => setShared(!shared)}
            style={{
              background: shared ? '#2196f3' : 'transparent',
              border: '1px solid #2196f3',
              color: shared ? 'white' : '#2196f3',
              padding: '2px',
              borderRadius: '4px',
              cursor: 'pointer',
              fontSize: '12px',
              width: '20px',
              height: '20px',
              display: 'flex',
              alignItems: 'center',
              justifyContent: 'center'
            }}
          >
            📤
          </button>
          
          <button
            onClick={() => setBookmarked(!bookmarked)}
            style={{
              background: bookmarked ? '#ff9800' : 'transparent',
              border: '1px solid #ff9800',
              color: bookmarked ? 'white' : '#ff9800',
              padding: '2px',
              borderRadius: '4px',
              cursor: 'pointer',
              fontSize: '12px',
              width: '20px',
              height: '20px',
              display: 'flex',
              alignItems: 'center',
              justifyContent: 'center'
            }}
          >
            🔖
          </button>
        </div>
        
        <div style={{ fontSize: '12px', color: '#666' }}>
          Published 2 hours ago
        </div>
      </div>
    </div>
  );
};

export default SmallTouchTarget;

import React from 'react';

const DecorativeImageWithAltText = () => {
  return (
    <div style={{ 
      maxWidth: '800px', 
      margin: '50px auto', 
      padding: '20px',
      fontFamily: 'Arial, sans-serif'
    }}>
      <h1>Company Blog</h1>
      <p>Stay updated with our latest news and insights.</p>
      
      {/* Decorative border image with unnecessary descriptive alt text */}
      <div style={{ marginBottom: '30px' }}>
        <img 
          src="https://via.placeholder.com/800x4/cccccc/ffffff?text=Decorative+Border"
          alt="Decorative border line separating content sections with elegant design"
          style={{
            width: '100%',
            height: '4px',
            display: 'block'
          }}
        />
      </div>

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
            fontSize: '24px', 
            margin: '0 0 15px 0',
            color: '#333'
          }}>
            The Future of Web Development
          </h2>
          
          {/* Decorative corner image with unnecessary alt text */}
          <div style={{ position: 'relative' }}>
            <img 
              src="https://via.placeholder.com/20x20/ff6b6b/ffffff?text=★"
              alt="Decorative star icon in the top-right corner indicating featured content"
              style={{
                position: 'absolute',
                top: '-10px',
                right: '-10px',
                width: '20px',
                height: '20px'
              }}
            />
          </div>
          
          <p style={{ 
            fontSize: '16px', 
            lineHeight: '1.6',
            color: '#666',
            margin: '0 0 20px 0'
          }}>
            Web development is evolving rapidly with new technologies and frameworks 
            emerging every year. This article explores the latest trends and what 
            developers need to know to stay ahead.
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
              Published 2 days ago
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
            fontSize: '24px', 
            margin: '0 0 15px 0',
            color: '#333'
          }}>
            Cybersecurity Best Practices
          </h2>
          
          {/* Another decorative corner image with unnecessary alt text */}
          <div style={{ position: 'relative' }}>
            <img 
              src="https://via.placeholder.com/20x20/4caf50/ffffff?text=✓"
              alt="Decorative checkmark icon indicating verified and trusted content"
              style={{
                position: 'absolute',
                top: '-10px',
                right: '-10px',
                width: '20px',
                height: '20px'
              }}
            />
          </div>
          
          <p style={{ 
            fontSize: '16px', 
            lineHeight: '1.6',
            color: '#666',
            margin: '0 0 20px 0'
          }}>
            With cyber threats becoming more sophisticated, organizations must 
            implement robust security measures to protect their data and systems. 
            This guide provides essential cybersecurity strategies.
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
              Published 1 week ago
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

      {/* Decorative separator with unnecessary alt text */}
      <div style={{ textAlign: 'center', margin: '40px 0' }}>
        <img 
          src="https://via.placeholder.com/200x2/dddddd/ffffff?text=---"
          alt="Decorative horizontal line separator between content sections with subtle design"
          style={{
            width: '200px',
            height: '2px',
            display: 'inline-block'
          }}
        />
      </div>

      <div style={{
        background: '#f8f9fa',
        padding: '30px',
        borderRadius: '8px',
        textAlign: 'center'
      }}>
        <h2 style={{ 
          fontSize: '28px', 
          margin: '0 0 15px 0',
          color: '#333'
        }}>
          Newsletter Signup
        </h2>
        <p style={{ 
          fontSize: '16px', 
          margin: '0 0 25px 0',
          color: '#666'
        }}>
          Get the latest articles delivered to your inbox.
        </p>
        
        <div style={{ display: 'flex', gap: '10px', justifyContent: 'center', flexWrap: 'wrap' }}>
          <input 
            type="email" 
            placeholder="Enter your email"
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

export default DecorativeImageWithAltText;

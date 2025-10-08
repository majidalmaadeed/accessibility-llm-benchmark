import React from 'react';

const MissingImageAltText = () => {
  return (
    <div style={{ 
      maxWidth: '800px', 
      margin: '50px auto', 
      padding: '20px',
      fontFamily: 'Arial, sans-serif'
    }}>
      <h1>Product Catalog</h1>
      <p>Browse our latest products.</p>
      
      <div style={{
        display: 'grid',
        gridTemplateColumns: 'repeat(auto-fit, minmax(250px, 1fr))',
        gap: '20px',
        marginTop: '30px'
      }}>
        <div style={{
          border: '1px solid #ddd',
          borderRadius: '8px',
          padding: '20px',
          background: 'white',
          boxShadow: '0 2px 4px rgba(0,0,0,0.1)'
        }}>
          {/* Product image without alternative text */}
          <img 
            src="https://via.placeholder.com/200x150/4CAF50/white?text=Product+Image"
            style={{
              width: '100%',
              height: '150px',
              objectFit: 'cover',
              borderRadius: '4px',
              marginBottom: '15px'
            }}
          />
          
          <h3 style={{ 
            margin: '0 0 10px 0', 
            fontSize: '18px',
            color: '#333'
          }}>
            Wireless Headphones
          </h3>
          
          <p style={{ 
            color: '#666', 
            fontSize: '14px',
            margin: '0 0 15px 0'
          }}>
            High-quality wireless headphones with noise cancellation
          </p>
          
          <div style={{
            display: 'flex',
            justifyContent: 'space-between',
            alignItems: 'center'
          }}>
            <span style={{
              fontSize: '20px',
              fontWeight: 'bold',
              color: '#2e7d32'
            }}>
              $99.99
            </span>
            
            <button style={{
              background: '#4caf50',
              color: 'white',
              border: 'none',
              padding: '10px 20px',
              borderRadius: '4px',
              cursor: 'pointer',
              fontSize: '14px'
            }}>
              Add to Cart
            </button>
          </div>
        </div>

        <div style={{
          border: '1px solid #ddd',
          borderRadius: '8px',
          padding: '20px',
          background: 'white',
          boxShadow: '0 2px 4px rgba(0,0,0,0.1)'
        }}>
          {/* Another product image without alternative text */}
          <img 
            src="https://via.placeholder.com/200x150/2196F3/white?text=Smart+Watch"
            style={{
              width: '100%',
              height: '150px',
              objectFit: 'cover',
              borderRadius: '4px',
              marginBottom: '15px'
            }}
          />
          
          <h3 style={{ 
            margin: '0 0 10px 0', 
            fontSize: '18px',
            color: '#333'
          }}>
            Smart Watch
          </h3>
          
          <p style={{ 
            color: '#666', 
            fontSize: '14px',
            margin: '0 0 15px 0'
          }}>
            Advanced fitness tracking with heart rate monitoring
          </p>
          
          <div style={{
            display: 'flex',
            justifyContent: 'space-between',
            alignItems: 'center'
          }}>
            <span style={{
              fontSize: '20px',
              fontWeight: 'bold',
              color: '#2e7d32'
            }}>
              $199.99
            </span>
            
            <button style={{
              background: '#4caf50',
              color: 'white',
              border: 'none',
              padding: '10px 20px',
              borderRadius: '4px',
              cursor: 'pointer',
              fontSize: '14px'
            }}>
              Add to Cart
            </button>
          </div>
        </div>
      </div>
    </div>
  );
};

export default MissingImageAltText;

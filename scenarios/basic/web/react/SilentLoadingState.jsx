import React, { useState, useEffect } from 'react';

const SilentLoadingState = () => {
  const [isLoading, setIsLoading] = useState(false);
  const [data, setData] = useState([]);
  const [loadingType, setLoadingType] = useState('');

  const mockData = {
    users: [
      { id: 1, name: 'John Doe', email: 'john@example.com', role: 'Admin' },
      { id: 2, name: 'Jane Smith', email: 'jane@example.com', role: 'User' },
      { id: 3, name: 'Bob Johnson', email: 'bob@example.com', role: 'User' }
    ],
    products: [
      { id: 1, name: 'Product A', price: 29.99, category: 'Electronics' },
      { id: 2, name: 'Product B', price: 49.99, category: 'Clothing' },
      { id: 3, name: 'Product C', price: 19.99, category: 'Books' }
    ],
    orders: [
      { id: 1, customer: 'John Doe', total: 79.98, status: 'Shipped' },
      { id: 2, customer: 'Jane Smith', total: 49.99, status: 'Processing' },
      { id: 3, customer: 'Bob Johnson', total: 29.99, status: 'Delivered' }
    ]
  };

  const loadData = (type) => {
    setLoadingType(type);
    setIsLoading(true);
    setData([]);
    
    // Simulate API call
    setTimeout(() => {
      setData(mockData[type] || []);
      setIsLoading(false);
    }, 2000);
  };

  return (
    <div style={{ 
      maxWidth: '1000px', 
      margin: '50px auto', 
      padding: '20px',
      fontFamily: 'Arial, sans-serif'
    }}>
      <h1>Data Management Dashboard</h1>
      <p>Load and manage different types of data from your system.</p>
      
      <div style={{
        background: '#f8f9fa',
        padding: '20px',
        borderRadius: '8px',
        marginBottom: '30px'
      }}>
        <h2>Data Loading Controls</h2>
        <div style={{
          display: 'flex',
          gap: '15px',
          flexWrap: 'wrap',
          marginTop: '15px'
        }}>
          <button 
            onClick={() => loadData('users')} 
            disabled={isLoading}
            style={{
              background: isLoading ? '#6c757d' : '#007bff',
              color: 'white',
              border: 'none',
              padding: '12px 24px',
              borderRadius: '4px',
              cursor: isLoading ? 'not-allowed' : 'pointer',
              fontSize: '16px',
              fontWeight: 'bold'
            }}
          >
            Load Users
          </button>
          <button 
            onClick={() => loadData('products')} 
            disabled={isLoading}
            style={{
              background: isLoading ? '#6c757d' : '#28a745',
              color: 'white',
              border: 'none',
              padding: '12px 24px',
              borderRadius: '4px',
              cursor: isLoading ? 'not-allowed' : 'pointer',
              fontSize: '16px',
              fontWeight: 'bold'
            }}
          >
            Load Products
          </button>
          <button 
            onClick={() => loadData('orders')} 
            disabled={isLoading}
            style={{
              background: isLoading ? '#6c757d' : '#ffc107',
              color: isLoading ? 'white' : '#212529',
              border: 'none',
              padding: '12px 24px',
              borderRadius: '4px',
              cursor: isLoading ? 'not-allowed' : 'pointer',
              fontSize: '16px',
              fontWeight: 'bold'
            }}
          >
            Load Orders
          </button>
        </div>
      </div>

      {/* Content spinner without screen reader announcement */}
      {isLoading && (
        <div style={{
          background: 'white',
          padding: '40px',
          borderRadius: '8px',
          boxShadow: '0 2px 8px rgba(0,0,0,0.1)',
          border: '1px solid #e0e0e0',
          textAlign: 'center',
          marginBottom: '30px'
        }}>
          <div style={{
            display: 'inline-block',
            width: '40px',
            height: '40px',
            border: '4px solid #f3f3f3',
            borderTop: '4px solid #007bff',
            borderRadius: '50%',
            animation: 'spin 1s linear infinite',
            marginBottom: '20px'
          }} />
          <p style={{ 
            margin: 0, 
            fontSize: '16px', 
            color: '#666'
          }}>
            Loading {loadingType}...
          </p>
        </div>
      )}

      {/* Data display */}
      {!isLoading && data.length > 0 && (
        <div style={{
          background: 'white',
          borderRadius: '8px',
          boxShadow: '0 2px 8px rgba(0,0,0,0.1)',
          overflow: 'hidden',
          border: '1px solid #e0e0e0',
          marginBottom: '30px'
        }}>
          <div style={{
            background: '#f8f9fa',
            padding: '20px',
            borderBottom: '1px solid #e0e0e0'
          }}>
            <h2 style={{ margin: 0, fontSize: '20px' }}>
              {loadingType.charAt(0).toUpperCase() + loadingType.slice(1)} Data
            </h2>
          </div>
          
          <div style={{ padding: '20px' }}>
            <div style={{
              display: 'grid',
              gap: '15px'
            }}>
              {data.map((item, index) => (
                <div 
                  key={item.id || index}
                  style={{
                    padding: '15px',
                    border: '1px solid #e0e0e0',
                    borderRadius: '4px',
                    background: '#fafafa'
                  }}
                >
                  {Object.entries(item).map(([key, value]) => (
                    <div key={key} style={{
                      display: 'flex',
                      marginBottom: '8px'
                    }}>
                      <strong style={{ 
                        minWidth: '120px', 
                        color: '#333',
                        textTransform: 'capitalize'
                      }}>
                        {key}:
                      </strong>
                      <span style={{ color: '#666' }}>{value}</span>
                    </div>
                  ))}
                </div>
              ))}
            </div>
          </div>
        </div>
      )}

      {/* Additional loading examples */}
      <div style={{
        display: 'grid',
        gridTemplateColumns: 'repeat(auto-fit, minmax(300px, 1fr))',
        gap: '20px',
        marginTop: '30px'
      }}>
        <div style={{
          background: 'white',
          padding: '20px',
          borderRadius: '8px',
          boxShadow: '0 2px 8px rgba(0,0,0,0.1)',
          border: '1px solid #e0e0e0'
        }}>
          <h3 style={{ 
            margin: '0 0 15px 0', 
            fontSize: '18px'
          }}>
            File Upload Progress
          </h3>
          <div style={{
            background: '#f8f9fa',
            padding: '20px',
            borderRadius: '4px',
            textAlign: 'center'
          }}>
            <div style={{
              display: 'inline-block',
              width: '30px',
              height: '30px',
              border: '3px solid #f3f3f3',
              borderTop: '3px solid #007bff',
              borderRadius: '50%',
              animation: 'spin 1s linear infinite',
              marginBottom: '10px'
            }} />
            <p style={{ 
              margin: 0, 
              fontSize: '14px', 
              color: '#666'
            }}>
              Uploading file...
            </p>
          </div>
        </div>

        <div style={{
          background: 'white',
          padding: '20px',
          borderRadius: '8px',
          boxShadow: '0 2px 8px rgba(0,0,0,0.1)',
          border: '1px solid #e0e0e0'
        }}>
          <h3 style={{ 
            margin: '0 0 15px 0', 
            fontSize: '18px'
          }}>
            Processing Data
          </h3>
          <div style={{
            background: '#f8f9fa',
            padding: '20px',
            borderRadius: '4px',
            textAlign: 'center'
          }}>
            <div style={{
              display: 'inline-block',
              width: '30px',
              height: '30px',
              border: '3px solid #f3f3f3',
              borderTop: '3px solid #28a745',
              borderRadius: '50%',
              animation: 'spin 1s linear infinite',
              marginBottom: '10px'
            }} />
            <p style={{ 
              margin: 0, 
              fontSize: '14px', 
              color: '#666'
            }}>
              Processing...
            </p>
          </div>
        </div>
      </div>

      <style jsx>{`
        @keyframes spin {
          0% { transform: rotate(0deg); }
          100% { transform: rotate(360deg); }
        }
      `}</style>
    </div>
  );
};

export default SilentLoadingState;

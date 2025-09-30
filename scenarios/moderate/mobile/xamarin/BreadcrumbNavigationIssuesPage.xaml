import React from 'react';
  const breadcrumbItems = [
  ];
  const handleBreadcrumbClick = (item) => {
    if (!item.current) {
      console.log(`Navigating to: ${item.href}`);
    }
  };
  const handleKeyDown = (e, item) => {
    if (e.key === 'Enter' || e.key === ' ') {
      e.preventDefault();
      handleBreadcrumbClick(item);
    }
  };
  return (
      <div style={{ background: 'white', padding: '30px', borderRadius: '8px', boxShadow: '0 2px 10px rgba(0,0,0,0.1)' }}>
        <h1>Product Page</h1>
        {}
        <nav
          style={{
            marginBottom: '30px',
            padding: '12px 0',
            borderBottom: '1px solid #eee'
          }}
        >
          <ol
            style={{
              display: 'flex',
              alignItems: 'center',
              listStyle: 'none',
              margin: 0,
              padding: 0,
              fontSize: '14px'
            }}
          >
            {breadcrumbItems.map((item, index) => (
              <li
                key={item.id}
                style={{
                  display: 'flex',
                  alignItems: 'center'
                }}
              >
                {index > 0 && (
                  <span
                    style={{
                      margin: '0 8px',
                      color: '#666',
                      fontSize: '12px'
                    }}
                  >
                    ›
                  </span>
                )}
                {item.current ? (
                  <span
                    style={{
                      color: '#333',
                      fontWeight: 'bold',
                      padding: '4px 8px',
                      borderRadius: '4px',
                      background: '#f8f9fa'
                    }}
                  >
                  </span>
                ) : (
                  <button
                    onClick={() => handleBreadcrumbClick(item)}
                    onKeyDown={(e) => handleKeyDown(e, item)}
                    style={{
                      background: 'none',
                      border: 'none',
                      color: '#007bff',
                      cursor: 'pointer',
                      padding: '4px 8px',
                      borderRadius: '4px',
                      fontSize: '14px',
                      textDecoration: 'underline'
                    }}
                  >
                  </button>
                )}
              </li>
            ))}
          </ol>
        </nav>
        {/* Page Content */}
        <div style={{ marginBottom: '30px' }}>
          <h2 style={{ marginBottom: '20px', color: '#333' }}>iPhone 15</h2>
          <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '30px', marginBottom: '30px' }}>
            <div>
              <img
                src="https://via.placeholder.com/400x300/007bff/ffffff?text=iPhone+15"
                style={{
                  width: '100%',
                  height: '300px',
                  objectFit: 'cover',
                  borderRadius: '8px'
                }}
              />
            </div>
            <div>
              <h3 style={{ marginBottom: '15px', color: '#333' }}>Product Details</h3>
              <p style={{ marginBottom: '15px', color: '#666', lineHeight: '1.6' }}>
                The iPhone 15 features a stunning 6.1-inch Super Retina XDR display, 
                advanced camera system, and the powerful A17 Pro chip.
              </p>
              <div style={{ marginBottom: '20px' }}>
                <h4 style={{ marginBottom: '10px', color: '#333' }}>Key Features:</h4>
                <ul style={{ margin: 0, paddingLeft: '20px', color: '#666' }}>
                  <li>6.1-inch Super Retina XDR display</li>
                  <li>48MP Main camera with 2x Telephoto</li>
                  <li>A17 Pro chip with 6-core GPU</li>
                  <li>All-day battery life</li>
                  <li>USB-C connector</li>
                </ul>
              </div>
              <div style={{ marginBottom: '20px' }}>
                <h4 style={{ marginBottom: '10px', color: '#333' }}>Price:</h4>
                <div style={{ fontSize: '24px', fontWeight: 'bold', color: '#007bff' }}>
                  $799.00
                </div>
              </div>
              <button
                style={{
                  background: '#007bff',
                  color: 'white',
                  border: 'none',
                  padding: '12px 24px',
                  borderRadius: '4px',
                  cursor: 'pointer',
                  fontSize: '16px',
                  fontWeight: 'bold'
                }}
              >
                Add to Cart
              </button>
            </div>
          </div>
        </div>
        {/* Related Products */}
        <div>
          <h3 style={{ marginBottom: '20px', color: '#333' }}>Related Products</h3>
          <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(200px, 1fr))', gap: '20px' }}>
            {[
              { name: 'iPhone 15 Pro', price: '$999.00', href: '/products/electronics/smartphones/iphone-15-pro' },
              { name: 'iPhone 15 Plus', price: '$899.00', href: '/products/electronics/smartphones/iphone-15-plus' },
              { name: 'AirPods Pro', price: '$249.00', href: '/products/electronics/audio/airpods-pro' }
            ].map((product, index) => (
              <div
                key={index}
                style={{
                  border: '1px solid #ddd',
                  borderRadius: '8px',
                  padding: '15px',
                  textAlign: 'center'
                }}
              >
                <h4 style={{ margin: '0 0 10px 0', color: '#333' }}>{product.name}</h4>
                <p style={{ margin: '0 0 15px 0', color: '#666' }}>{product.price}</p>
                <button
                  onClick={() => console.log(`Navigate to: ${product.href}`)}
                  style={{
                    background: '#6c757d',
                    color: 'white',
                    border: 'none',
                    padding: '8px 16px',
                    borderRadius: '4px',
                    cursor: 'pointer',
                    fontSize: '14px'
                  }}
                >
                  View Details
                </button>
              </div>
            ))}
          </div>
        </div>
      </div>
      <div style={{ marginTop: '30px', padding: '20px', backgroundColor: '#e9ecef', borderRadius: '4px' }}>
      </div>
    </div>
  );
};
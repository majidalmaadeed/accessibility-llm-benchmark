import React from 'react';

const BreadcrumbNavigationIssues = () => {
  const breadcrumbItems = [
    { id: 'home', label: 'Home', href: '/', current: false },
    { id: 'products', label: 'Products', href: '/products', current: false },
    { id: 'electronics', label: 'Electronics', href: '/products/electronics', current: false },
    { id: 'smartphones', label: 'Smartphones', href: '/products/electronics/smartphones', current: false },
    { id: 'iphone-15', label: 'iPhone 15', href: '/products/electronics/smartphones/iphone-15', current: true }
  ];

  const handleBreadcrumbClick = (item) => {
    if (!item.current) {
      // Simulate navigation
      console.log(`Navigating to: ${item.href}`);
    }
  };

  const handleKeyDown = (e, item) => {
    if (e.key === 'Enter' || e.key === ' ') {
      e.preventDefault();
      handleBreadcrumbClick(item);
    }
    // MISSING: Arrow key navigation between breadcrumb items
  };

  return (
    <div style={{ fontFamily: 'Arial, sans-serif', maxWidth: '800px', margin: '50px auto', padding: '20px', backgroundColor: '#f5f5f5' }}>
      <div style={{ background: 'white', padding: '30px', borderRadius: '8px', boxShadow: '0 2px 10px rgba(0,0,0,0.1)' }}>
        <h1>Product Page</h1>
        <p>Navigate through the page hierarchy using the breadcrumb navigation.</p>
        
        {/* Breadcrumb Navigation - MISSING PROPER ARIA ATTRIBUTES */}
        <nav
          style={{
            marginBottom: '30px',
            padding: '12px 0',
            borderBottom: '1px solid #eee'
          }}
          aria-label="Breadcrumb navigation"
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
            role="list"
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
                    aria-hidden="true"
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
                    aria-current="page"
                  >
                    {item.label}
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
                    aria-label={`Navigate to ${item.label}`}
                  >
                    {item.label}
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
                alt="iPhone 15 product image"
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
        <h3>Accessibility Issues:</h3>
        <ul>
          <li><strong>Missing ARIA attributes:</strong> No aria-current="page" for current item</li>
          <li><strong>No keyboard navigation:</strong> Arrow keys don't navigate between breadcrumb items</li>
          <li><strong>Missing semantic structure:</strong> Breadcrumb items not properly marked as navigation</li>
          <li><strong>No screen reader announcements:</strong> Navigation changes not announced</li>
          <li><strong>Missing separator semantics:</strong> Separators not marked as decorative</li>
          <li><strong>No skip links:</strong> No way to skip breadcrumb navigation</li>
        </ul>
        
        <h3>How to Fix:</h3>
        <ul>
          <li>Add <code>aria-current="page"</code> to current breadcrumb item</li>
          <li>Use <code>role="list"</code> and proper list item semantics</li>
          <li>Add <code>aria-label</code> to navigation container</li>
          <li>Mark separators with <code>aria-hidden="true"</code></li>
          <li>Implement arrow key navigation (Left/Right) between items</li>
          <li>Add <code>aria-live="polite"</code> for navigation announcements</li>
        </ul>
      </div>
    </div>
  );
};

export default BreadcrumbNavigationIssues;
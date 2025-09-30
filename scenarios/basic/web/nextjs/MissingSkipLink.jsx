import { useState, useEffect } from 'react';

export default function MissingSkipLink() {
  const [isMenuOpen, setIsMenuOpen] = useState(false);
  const [isSearchOpen, setIsSearchOpen] = useState(false);
  const [searchTerm, setSearchTerm] = useState('');
  const [selectedCategory, setSelectedCategory] = useState('all');
  const [currentPage, setCurrentPage] = useState(1);
  const [isScrolled, setIsScrolled] = useState(false);

  const categories = [
    { id: 'all', name: 'All Products' },
    { id: 'electronics', name: 'Electronics' },
    { id: 'clothing', name: 'Clothing' },
    { id: 'home', name: 'Home & Garden' },
    { id: 'sports', name: 'Sports' },
    { id: 'books', name: 'Books' }
  ];

  const products = [
    {
      id: 1,
      name: 'Wireless Headphones',
      category: 'electronics',
      price: 199.99,
      rating: 4.5,
      image: '/api/placeholder/300/300',
      description: 'High-quality wireless headphones with noise cancellation',
      inStock: true,
      discount: 20
    },
    {
      id: 2,
      name: 'Cotton T-Shirt',
      category: 'clothing',
      price: 29.99,
      rating: 4.2,
      image: '/api/placeholder/300/300',
      description: 'Comfortable cotton t-shirt in various colors',
      inStock: true,
      discount: 0
    },
    {
      id: 3,
      name: 'Smart Home Hub',
      category: 'electronics',
      price: 149.99,
      rating: 4.7,
      image: '/api/placeholder/300/300',
      description: 'Control all your smart devices from one place',
      inStock: false,
      discount: 15
    },
    {
      id: 4,
      name: 'Garden Tools Set',
      category: 'home',
      price: 79.99,
      rating: 4.3,
      image: '/api/placeholder/300/300',
      description: 'Complete set of professional garden tools',
      inStock: true,
      discount: 0
    },
    {
      id: 5,
      name: 'Running Shoes',
      category: 'sports',
      price: 129.99,
      rating: 4.6,
      image: '/api/placeholder/300/300',
      description: 'Lightweight running shoes for all terrains',
      inStock: true,
      discount: 25
    },
    {
      id: 6,
      name: 'Programming Book',
      category: 'books',
      price: 49.99,
      rating: 4.8,
      image: '/api/placeholder/300/300',
      description: 'Learn modern programming techniques',
      inStock: true,
      discount: 10
    }
  ];

  const navigationItems = [
    { name: 'Home', href: '/home' },
    { name: 'Products', href: '/products' },
    { name: 'Categories', href: '/categories' },
    { name: 'Deals', href: '/deals' },
    { name: 'About', href: '/about' },
    { name: 'Contact', href: '/contact' }
  ];

  const filteredProducts = products.filter(product => {
    const matchesCategory = selectedCategory === 'all' || product.category === selectedCategory;
    const matchesSearch = product.name.toLowerCase().includes(searchTerm.toLowerCase()) ||
                         product.description.toLowerCase().includes(searchTerm.toLowerCase());
    return matchesCategory && matchesSearch;
  });

  const itemsPerPage = 6;
  const totalPages = Math.ceil(filteredProducts.length / itemsPerPage);
  const paginatedProducts = filteredProducts.slice(
    (currentPage - 1) * itemsPerPage,
    currentPage * itemsPerPage
  );

  useEffect(() => {
    const handleScroll = () => {
      setIsScrolled(window.scrollY > 50);
    };

    window.addEventListener('scroll', handleScroll);
    return () => window.removeEventListener('scroll', handleScroll);
  }, []);

  const handleSearch = (e) => {
    e.preventDefault();
    setCurrentPage(1);
  };

  const handleCategoryChange = (category) => {
    setSelectedCategory(category);
    setCurrentPage(1);
  };

  const handlePageChange = (page) => {
    setCurrentPage(page);
    window.scrollTo({ top: 0, behavior: 'smooth' });
  };

  const handleAddToCart = (product) => {
    alert(`Added "${product.name}" to cart`);
  };

  const handleQuickView = (product) => {
    alert(`Quick view for "${product.name}"`);
  };

  const formatPrice = (price) => {
    return `$${price.toFixed(2)}`;
  };

  const renderStars = (rating) => {
    const stars = [];
    const fullStars = Math.floor(rating);
    const hasHalfStar = rating % 1 !== 0;

    for (let i = 0; i < fullStars; i++) {
      stars.push('★');
    }
    if (hasHalfStar) {
      stars.push('☆');
    }
    while (stars.length < 5) {
      stars.push('☆');
    }
    return stars.join('');
  };

  return (
    <div className="ecommerce-store">
      <header className={`main-header ${isScrolled ? 'scrolled' : ''}`}>
        <div className="header-container">
          <div className="logo">
            <h1>ShopMax</h1>
          </div>

          <nav className={`main-nav ${isMenuOpen ? 'open' : ''}`}>
            <ul className="nav-list">
              {navigationItems.map((item, index) => (
                <li key={index} className="nav-item">
                  <a href={item.href} className="nav-link">
                    {item.name}
                  </a>
                </li>
              ))}
            </ul>
          </nav>

          <div className="header-actions">
            <div className={`search-container ${isSearchOpen ? 'open' : ''}`}>
              <form onSubmit={handleSearch} className="search-form">
                <input
                  type="text"
                  placeholder="Search products..."
                  value={searchTerm}
                  onChange={(e) => setSearchTerm(e.target.value)}
                  className="search-input"
                />
                <button type="submit" className="search-btn">
                  🔍
                </button>
              </form>
            </div>

            <button className="cart-btn">
              🛒 Cart (0)
            </button>

            <button 
              className="menu-toggle"
              onClick={() => setIsMenuOpen(!isMenuOpen)}
            >
              ☰
            </button>
          </div>
        </div>
      </header>

      <main className="main-content">
        <section className="hero-section">
          <div className="hero-content">
            <h2>Discover Amazing Products</h2>
            <p>Find everything you need at unbeatable prices</p>
            <div className="hero-actions">
              <button className="cta-button primary">Shop Now</button>
              <button className="cta-button secondary">View Deals</button>
            </div>
          </div>
        </section>

        <section className="categories-section">
          <div className="categories-container">
            <h3>Shop by Category</h3>
            <div className="categories-grid">
              {categories.map((category) => (
                <button
                  key={category.id}
                  className={`category-card ${selectedCategory === category.id ? 'active' : ''}`}
                  onClick={() => handleCategoryChange(category.id)}
                >
                  <div className="category-icon">
                    {category.id === 'electronics' && '📱'}
                    {category.id === 'clothing' && '👕'}
                    {category.id === 'home' && '🏠'}
                    {category.id === 'sports' && '⚽'}
                    {category.id === 'books' && '📚'}
                    {category.id === 'all' && '🛍️'}
                  </div>
                  <span className="category-name">{category.name}</span>
                </button>
              ))}
            </div>
          </div>
        </section>

        <section className="products-section">
          <div className="products-container">
            <div className="products-header">
              <h3>Products ({filteredProducts.length})</h3>
              <div className="sort-options">
                <select className="sort-select">
                  <option value="name">Sort by Name</option>
                  <option value="price-low">Price: Low to High</option>
                  <option value="price-high">Price: High to Low</option>
                  <option value="rating">Rating</option>
                </select>
              </div>
            </div>

            <div className="products-grid">
              {paginatedProducts.map((product) => (
                <div key={product.id} className="product-card">
                  <div className="product-image-container">
                    <img 
                      src={product.image} 
                      alt={product.name}
                      className="product-image"
                    />
                    {product.discount > 0 && (
                      <div className="discount-badge">
                        -{product.discount}%
                      </div>
                    )}
                    {!product.inStock && (
                      <div className="out-of-stock-badge">
                        Out of Stock
                      </div>
                    )}
                    <div className="product-actions">
                      <button 
                        className="action-btn quick-view"
                        onClick={() => handleQuickView(product)}
                      >
                        👁️
                      </button>
                      <button className="action-btn wishlist">
                        ❤️
                      </button>
                    </div>
                  </div>

                  <div className="product-content">
                    <h4 className="product-name">{product.name}</h4>
                    <p className="product-description">{product.description}</p>
                    
                    <div className="product-rating">
                      <span className="stars">{renderStars(product.rating)}</span>
                      <span className="rating-text">({product.rating})</span>
                    </div>

                    <div className="product-price">
                      {product.discount > 0 ? (
                        <div className="price-container">
                          <span className="original-price">
                            {formatPrice(product.price)}
                          </span>
                          <span className="sale-price">
                            {formatPrice(product.price * (1 - product.discount / 100))}
                          </span>
                        </div>
                      ) : (
                        <span className="price">{formatPrice(product.price)}</span>
                      )}
                    </div>

                    <button 
                      className={`add-to-cart-btn ${!product.inStock ? 'disabled' : ''}`}
                      onClick={() => handleAddToCart(product)}
                      disabled={!product.inStock}
                    >
                      {product.inStock ? 'Add to Cart' : 'Out of Stock'}
                    </button>
                  </div>
                </div>
              ))}
            </div>

            {totalPages > 1 && (
              <div className="pagination">
                <button 
                  className="page-btn"
                  onClick={() => handlePageChange(currentPage - 1)}
                  disabled={currentPage === 1}
                >
                  Previous
                </button>
                
                {Array(totalPages).fill(0).map((_, i) => (
                  <button
                    key={i}
                    className={`page-btn ${currentPage === i + 1 ? 'active' : ''}`}
                    onClick={() => handlePageChange(i + 1)}
                  >
                    {i + 1}
                  </button>
                ))}
                
                <button 
                  className="page-btn"
                  onClick={() => handlePageChange(currentPage + 1)}
                  disabled={currentPage === totalPages}
                >
                  Next
                </button>
              </div>
            )}
          </div>
        </section>

        <section className="features-section">
          <div className="features-container">
            <h3>Why Choose ShopMax</h3>
            <div className="features-grid">
              <div className="feature-card">
                <div className="feature-icon">🚚</div>
                <h4>Free Shipping</h4>
                <p>Free shipping on orders over $50</p>
              </div>
              <div className="feature-card">
                <div className="feature-icon">↩️</div>
                <h4>Easy Returns</h4>
                <p>30-day return policy</p>
              </div>
              <div className="feature-card">
                <div className="feature-icon">🔒</div>
                <h4>Secure Payment</h4>
                <p>Your payment information is safe</p>
              </div>
              <div className="feature-card">
                <div className="feature-icon">📞</div>
                <h4>24/7 Support</h4>
                <p>Customer support whenever you need it</p>
              </div>
            </div>
          </div>
        </section>
      </main>

      <footer className="main-footer">
        <div className="footer-container">
          <div className="footer-content">
            <div className="footer-section">
              <h4>Shop</h4>
              <ul>
                <li><a href="/products">All Products</a></li>
                <li><a href="/categories">Categories</a></li>
                <li><a href="/deals">Deals</a></li>
                <li><a href="/new">New Arrivals</a></li>
              </ul>
            </div>
            <div className="footer-section">
              <h4>Customer Service</h4>
              <ul>
                <li><a href="/help">Help Center</a></li>
                <li><a href="/shipping">Shipping Info</a></li>
                <li><a href="/returns">Returns</a></li>
                <li><a href="/contact">Contact Us</a></li>
              </ul>
            </div>
            <div className="footer-section">
              <h4>Company</h4>
              <ul>
                <li><a href="/about">About Us</a></li>
                <li><a href="/careers">Careers</a></li>
                <li><a href="/press">Press</a></li>
                <li><a href="/blog">Blog</a></li>
              </ul>
            </div>
            <div className="footer-section">
              <h4>Connect</h4>
              <ul>
                <li><a href="/newsletter">Newsletter</a></li>
                <li><a href="/social">Social Media</a></li>
                <li><a href="/reviews">Reviews</a></li>
                <li><a href="/feedback">Feedback</a></li>
              </ul>
            </div>
          </div>
          <div className="footer-bottom">
            <p>&copy; 2024 ShopMax. All rights reserved.</p>
          </div>
        </div>
      </footer>

      <style jsx>{`
        .ecommerce-store {
          font-family: Arial, sans-serif;
          line-height: 1.6;
        }

        .main-header {
          position: fixed;
          top: 0;
          left: 0;
          right: 0;
          z-index: 1000;
          background: rgba(255, 255, 255, 0.95);
          backdrop-filter: blur(10px);
          transition: all 0.3s ease;
        }

        .main-header.scrolled {
          background: rgba(255, 255, 255, 0.98);
          box-shadow: 0 2px 20px rgba(0,0,0,0.1);
        }

        .header-container {
          max-width: 1200px;
          margin: 0 auto;
          padding: 0 20px;
          display: flex;
          align-items: center;
          justify-content: space-between;
          height: 70px;
        }

        .logo h1 {
          margin: 0;
          font-size: 24px;
          font-weight: bold;
          color: #333;
        }

        .main-nav {
          display: flex;
          align-items: center;
        }

        .nav-list {
          display: flex;
          list-style: none;
          margin: 0;
          padding: 0;
          gap: 30px;
        }

        .nav-link {
          text-decoration: none;
          color: #333;
          font-weight: 500;
          transition: color 0.2s ease;
        }

        .nav-link:hover {
          color: #007bff;
        }

        .header-actions {
          display: flex;
          align-items: center;
          gap: 20px;
        }

        .search-container {
          position: relative;
        }

        .search-form {
          display: flex;
          align-items: center;
        }

        .search-input {
          padding: 8px 12px;
          border: 1px solid #ddd;
          border-radius: 20px;
          width: 200px;
          transition: width 0.3s ease;
        }

        .search-container.open .search-input {
          width: 300px;
        }

        .search-btn {
          background: none;
          border: none;
          cursor: pointer;
          font-size: 16px;
          margin-left: 5px;
        }

        .cart-btn {
          background: #007bff;
          color: white;
          border: none;
          padding: 8px 16px;
          border-radius: 20px;
          cursor: pointer;
          font-weight: bold;
        }

        .menu-toggle {
          display: none;
          background: none;
          border: none;
          font-size: 20px;
          cursor: pointer;
        }

        .main-content {
          margin-top: 70px;
        }

        .hero-section {
          background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
          color: white;
          padding: 80px 20px;
          text-align: center;
        }

        .hero-content h2 {
          font-size: 48px;
          margin: 0 0 20px 0;
        }

        .hero-content p {
          font-size: 20px;
          margin: 0 0 40px 0;
          opacity: 0.9;
        }

        .hero-actions {
          display: flex;
          gap: 20px;
          justify-content: center;
          flex-wrap: wrap;
        }

        .cta-button {
          padding: 15px 30px;
          border-radius: 30px;
          text-decoration: none;
          font-weight: bold;
          font-size: 16px;
          transition: all 0.3s ease;
          border: none;
          cursor: pointer;
        }

        .cta-button.primary {
          background: white;
          color: #667eea;
        }

        .cta-button.primary:hover {
          background: #f8f9fa;
          transform: translateY(-2px);
        }

        .cta-button.secondary {
          background: transparent;
          color: white;
          border: 2px solid white;
        }

        .cta-button.secondary:hover {
          background: white;
          color: #667eea;
        }

        .categories-section {
          padding: 60px 20px;
          background: #f8f9fa;
        }

        .categories-container {
          max-width: 1200px;
          margin: 0 auto;
        }

        .categories-container h3 {
          text-align: center;
          font-size: 32px;
          margin-bottom: 40px;
          color: #333;
        }

        .categories-grid {
          display: grid;
          grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
          gap: 20px;
        }

        .category-card {
          background: white;
          border: 2px solid #e9ecef;
          border-radius: 8px;
          padding: 20px;
          text-align: center;
          cursor: pointer;
          transition: all 0.3s ease;
        }

        .category-card:hover,
        .category-card.active {
          border-color: #007bff;
          transform: translateY(-2px);
          box-shadow: 0 4px 12px rgba(0,123,255,0.2);
        }

        .category-icon {
          font-size: 32px;
          margin-bottom: 10px;
        }

        .category-name {
          font-weight: bold;
          color: #333;
        }

        .products-section {
          padding: 60px 20px;
        }

        .products-container {
          max-width: 1200px;
          margin: 0 auto;
        }

        .products-header {
          display: flex;
          justify-content: space-between;
          align-items: center;
          margin-bottom: 40px;
        }

        .products-header h3 {
          font-size: 28px;
          color: #333;
          margin: 0;
        }

        .sort-select {
          padding: 8px 12px;
          border: 1px solid #ddd;
          border-radius: 4px;
          background: white;
        }

        .products-grid {
          display: grid;
          grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
          gap: 30px;
          margin-bottom: 40px;
        }

        .product-card {
          background: white;
          border-radius: 8px;
          box-shadow: 0 2px 8px rgba(0,0,0,0.1);
          overflow: hidden;
          transition: transform 0.3s ease;
        }

        .product-card:hover {
          transform: translateY(-4px);
        }

        .product-image-container {
          position: relative;
          height: 200px;
          overflow: hidden;
        }

        .product-image {
          width: 100%;
          height: 100%;
          object-fit: cover;
        }

        .discount-badge {
          position: absolute;
          top: 10px;
          right: 10px;
          background: #dc3545;
          color: white;
          padding: 4px 8px;
          border-radius: 4px;
          font-size: 12px;
          font-weight: bold;
        }

        .out-of-stock-badge {
          position: absolute;
          top: 10px;
          left: 10px;
          background: #6c757d;
          color: white;
          padding: 4px 8px;
          border-radius: 4px;
          font-size: 12px;
          font-weight: bold;
        }

        .product-actions {
          position: absolute;
          top: 10px;
          right: 10px;
          display: flex;
          flex-direction: column;
          gap: 5px;
          opacity: 0;
          transition: opacity 0.3s ease;
        }

        .product-card:hover .product-actions {
          opacity: 1;
        }

        .action-btn {
          background: rgba(255, 255, 255, 0.9);
          border: none;
          border-radius: 50%;
          width: 35px;
          height: 35px;
          cursor: pointer;
          font-size: 14px;
          display: flex;
          align-items: center;
          justify-content: center;
        }

        .product-content {
          padding: 20px;
        }

        .product-name {
          font-size: 18px;
          font-weight: bold;
          margin: 0 0 10px 0;
          color: #333;
        }

        .product-description {
          color: #666;
          font-size: 14px;
          margin: 0 0 15px 0;
          line-height: 1.4;
        }

        .product-rating {
          display: flex;
          align-items: center;
          gap: 5px;
          margin-bottom: 15px;
        }

        .stars {
          color: #ffc107;
          font-size: 14px;
        }

        .rating-text {
          color: #666;
          font-size: 12px;
        }

        .product-price {
          margin-bottom: 15px;
        }

        .price-container {
          display: flex;
          align-items: center;
          gap: 10px;
        }

        .original-price {
          text-decoration: line-through;
          color: #999;
          font-size: 14px;
        }

        .sale-price {
          font-size: 18px;
          font-weight: bold;
          color: #dc3545;
        }

        .price {
          font-size: 18px;
          font-weight: bold;
          color: #333;
        }

        .add-to-cart-btn {
          width: 100%;
          background: #007bff;
          color: white;
          border: none;
          padding: 12px;
          border-radius: 4px;
          cursor: pointer;
          font-weight: bold;
          transition: background-color 0.3s ease;
        }

        .add-to-cart-btn:hover:not(.disabled) {
          background: #0056b3;
        }

        .add-to-cart-btn.disabled {
          background: #6c757d;
          cursor: not-allowed;
        }

        .pagination {
          display: flex;
          justify-content: center;
          gap: 5px;
        }

        .page-btn {
          padding: 8px 12px;
          border: 1px solid #ddd;
          background: white;
          cursor: pointer;
          border-radius: 4px;
          transition: all 0.2s ease;
        }

        .page-btn:hover:not(:disabled) {
          border-color: #007bff;
          color: #007bff;
        }

        .page-btn.active {
          background: #007bff;
          color: white;
          border-color: #007bff;
        }

        .page-btn:disabled {
          opacity: 0.5;
          cursor: not-allowed;
        }

        .features-section {
          padding: 60px 20px;
          background: #f8f9fa;
        }

        .features-container {
          max-width: 1200px;
          margin: 0 auto;
        }

        .features-container h3 {
          text-align: center;
          font-size: 32px;
          margin-bottom: 40px;
          color: #333;
        }

        .features-grid {
          display: grid;
          grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
          gap: 30px;
        }

        .feature-card {
          text-align: center;
          padding: 30px;
          background: white;
          border-radius: 8px;
          box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }

        .feature-icon {
          font-size: 32px;
          margin-bottom: 15px;
        }

        .feature-card h4 {
          font-size: 18px;
          margin-bottom: 10px;
          color: #333;
        }

        .feature-card p {
          color: #666;
          margin: 0;
        }

        .main-footer {
          background: #333;
          color: white;
          padding: 60px 20px 20px;
        }

        .footer-container {
          max-width: 1200px;
          margin: 0 auto;
        }

        .footer-content {
          display: grid;
          grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
          gap: 40px;
          margin-bottom: 40px;
        }

        .footer-section h4 {
          margin-bottom: 20px;
          color: white;
        }

        .footer-section ul {
          list-style: none;
          padding: 0;
          margin: 0;
        }

        .footer-section li {
          margin-bottom: 10px;
        }

        .footer-section a {
          color: #ccc;
          text-decoration: none;
          transition: color 0.2s ease;
        }

        .footer-section a:hover {
          color: white;
        }

        .footer-bottom {
          text-align: center;
          padding-top: 20px;
          border-top: 1px solid #555;
          color: #ccc;
        }

        @media (max-width: 768px) {
          .main-nav {
            display: none;
          }

          .menu-toggle {
            display: block;
          }

          .hero-content h2 {
            font-size: 36px;
          }

          .hero-actions {
            flex-direction: column;
            align-items: center;
          }

          .cta-button {
            width: 100%;
            max-width: 300px;
          }

          .products-header {
            flex-direction: column;
            gap: 20px;
            align-items: flex-start;
          }
        }
      `}</style>
    </div>
  );
}

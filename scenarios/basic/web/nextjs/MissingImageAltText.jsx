import { useState } from 'react';

export default function MissingImageAltText() {
  const [selectedCategory, setSelectedCategory] = useState('all');
  const [searchTerm, setSearchTerm] = useState('');
  const [sortBy, setSortBy] = useState('popular');
  const [viewMode, setViewMode] = useState('grid');

  const categories = [
    { id: 'all', name: 'All Products' },
    { id: 'electronics', name: 'Electronics' },
    { id: 'clothing', name: 'Clothing' },
    { id: 'home', name: 'Home & Garden' },
    { id: 'sports', name: 'Sports' }
  ];

  const products = [
    {
      id: 1,
      name: 'Wireless Headphones',
      price: 99.99,
      category: 'electronics',
      image: 'headphones.jpg',
      rating: 4.5,
      reviews: 128,
      inStock: true
    },
    {
      id: 2,
      name: 'Cotton T-Shirt',
      price: 24.99,
      category: 'clothing',
      image: 'tshirt.jpg',
      rating: 4.2,
      reviews: 89,
      inStock: true
    },
    {
      id: 3,
      name: 'Coffee Maker',
      price: 149.99,
      category: 'home',
      image: 'coffeemaker.jpg',
      rating: 4.7,
      reviews: 203,
      inStock: false
    },
    {
      id: 4,
      name: 'Running Shoes',
      price: 129.99,
      category: 'sports',
      image: 'shoes.jpg',
      rating: 4.4,
      reviews: 156,
      inStock: true
    },
    {
      id: 5,
      name: 'Smartphone Case',
      price: 19.99,
      category: 'electronics',
      image: 'phonecase.jpg',
      rating: 4.1,
      reviews: 67,
      inStock: true
    },
    {
      id: 6,
      name: 'Garden Tools Set',
      price: 79.99,
      category: 'home',
      image: 'gardentools.jpg',
      rating: 4.6,
      reviews: 94,
      inStock: true
    }
  ];

  const filteredProducts = products.filter(product => {
    const matchesCategory = selectedCategory === 'all' || product.category === selectedCategory;
    const matchesSearch = product.name.toLowerCase().includes(searchTerm.toLowerCase());
    return matchesCategory && matchesSearch;
  });

  const sortedProducts = [...filteredProducts].sort((a, b) => {
    switch(sortBy) {
      case 'price-low':
        return a.price - b.price;
      case 'price-high':
        return b.price - a.price;
      case 'rating':
        return b.rating - a.rating;
      case 'name':
      default:
        return a.name.localeCompare(b.name);
    }
  });

  const addToCart = (product) => {
    alert(`Added ${product.name} to cart!`);
  };

  const toggleWishlist = (product) => {
    alert(`${product.name} added to wishlist!`);
  };

  return (
    <div className="product-catalog">
      <header className="catalog-header">
        <h1>Product Catalog</h1>
        <p>Discover amazing products at great prices</p>
      </header>

      <div className="catalog-controls">
        <div className="search-section">
          <input 
            type="text" 
            placeholder="Search products..." 
            value={searchTerm}
            onChange={(e) => setSearchTerm(e.target.value)}
            className="search-input"
          />
        </div>

        <div className="filter-section">
          <select 
            value={selectedCategory} 
            onChange={(e) => setSelectedCategory(e.target.value)}
            className="category-filter"
          >
            {categories.map(category => (
              <option key={category.id} value={category.id}>
                {category.name}
              </option>
            ))}
          </select>

          <select 
            value={sortBy} 
            onChange={(e) => setSortBy(e.target.value)}
            className="sort-filter"
          >
            <option value="name">Sort by Name</option>
            <option value="price-low">Price: Low to High</option>
            <option value="price-high">Price: High to Low</option>
            <option value="rating">Highest Rated</option>
          </select>

          <div className="view-toggle">
            <button 
              className={`view-btn ${viewMode === 'grid' ? 'active' : ''}`}
              onClick={() => setViewMode('grid')}
            >
              Grid
            </button>
            <button 
              className={`view-btn ${viewMode === 'list' ? 'active' : ''}`}
              onClick={() => setViewMode('list')}
            >
              List
            </button>
          </div>
        </div>
      </div>

      <div className="results-info">
        <p>Showing {sortedProducts.length} products</p>
      </div>

      <div className={`products-container ${viewMode}`}>
        {sortedProducts.map(product => (
          <div key={product.id} className="product-card">
            <div className="product-image-container">
              <img 
                src={`/images/${product.image}`}
                className="product-image"
              />
              {!product.inStock && (
                <div className="out-of-stock-badge">Out of Stock</div>
              )}
              <button 
                className="wishlist-btn" 
                onClick={() => toggleWishlist(product)}
                title="Add to Wishlist"
              >
                ♥
              </button>
            </div>

            <div className="product-info">
              <h3 className="product-name">{product.name}</h3>
              
              <div className="product-rating">
                <div className="stars">
                  {Array(5).fill(0).map((_, i) => (
                    <span 
                      key={i} 
                      className={`star ${i < Math.floor(product.rating) ? 'filled' : ''}`}
                    >
                      ★
                    </span>
                  ))}
                </div>
                <span className="rating-text">{product.rating} ({product.reviews} reviews)</span>
              </div>

              <div className="product-price">
                <span className="current-price">${product.price}</span>
                {product.price > 50 && (
                  <span className="original-price">${(product.price * 1.2).toFixed(2)}</span>
                )}
              </div>

              <div className="product-actions">
                <button 
                  className="add-to-cart-btn" 
                  onClick={() => addToCart(product)}
                  disabled={!product.inStock}
                >
                  {product.inStock ? 'Add to Cart' : 'Out of Stock'}
                </button>
                <button className="quick-view-btn">Quick View</button>
              </div>
            </div>
          </div>
        ))}
      </div>

      {sortedProducts.length === 0 && (
        <div className="no-results">
          <h3>No products found</h3>
          <p>Try adjusting your search or filter criteria</p>
        </div>
      )}

      <style jsx>{`
        .product-catalog {
          max-width: 1200px;
          margin: 50px auto;
          padding: 20px;
          font-family: Arial, sans-serif;
        }

        .catalog-header {
          text-align: center;
          margin-bottom: 30px;
        }

        .catalog-header h1 {
          margin: 0 0 10px 0;
          font-size: 32px;
          color: #333;
        }

        .catalog-header p {
          margin: 0;
          color: #666;
          font-size: 16px;
        }

        .catalog-controls {
          background: #f8f9fa;
          padding: 20px;
          border-radius: 8px;
          margin-bottom: 20px;
          display: flex;
          flex-direction: column;
          gap: 15px;
        }

        .search-section {
          display: flex;
          justify-content: center;
        }

        .search-input {
          width: 100%;
          max-width: 400px;
          padding: 12px 16px;
          border: 1px solid #ddd;
          border-radius: 6px;
          font-size: 16px;
        }

        .filter-section {
          display: flex;
          gap: 15px;
          align-items: center;
          flex-wrap: wrap;
          justify-content: center;
        }

        .category-filter,
        .sort-filter {
          padding: 8px 12px;
          border: 1px solid #ddd;
          border-radius: 4px;
          background: white;
        }

        .view-toggle {
          display: flex;
          border: 1px solid #ddd;
          border-radius: 4px;
          overflow: hidden;
        }

        .view-btn {
          padding: 8px 16px;
          border: none;
          background: white;
          cursor: pointer;
          transition: background-color 0.2s ease;
        }

        .view-btn.active {
          background: #007bff;
          color: white;
        }

        .results-info {
          margin-bottom: 20px;
          color: #666;
        }

        .products-container.grid {
          display: grid;
          grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
          gap: 20px;
        }

        .products-container.list {
          display: flex;
          flex-direction: column;
          gap: 15px;
        }

        .products-container.list .product-card {
          display: flex;
          flex-direction: row;
          align-items: center;
        }

        .products-container.list .product-image-container {
          width: 120px;
          height: 120px;
          flex-shrink: 0;
        }

        .products-container.list .product-image {
          width: 100%;
          height: 100%;
          object-fit: cover;
        }

        .product-card {
          background: white;
          border-radius: 8px;
          box-shadow: 0 2px 8px rgba(0,0,0,0.1);
          overflow: hidden;
          transition: transform 0.2s ease, box-shadow 0.2s ease;
        }

        .product-card:hover {
          transform: translateY(-2px);
          box-shadow: 0 4px 16px rgba(0,0,0,0.15);
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

        .out-of-stock-badge {
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

        .wishlist-btn {
          position: absolute;
          top: 10px;
          left: 10px;
          background: rgba(255,255,255,0.9);
          border: none;
          border-radius: 50%;
          width: 32px;
          height: 32px;
          cursor: pointer;
          font-size: 16px;
          display: flex;
          align-items: center;
          justify-content: center;
        }

        .product-info {
          padding: 15px;
        }

        .product-name {
          margin: 0 0 10px 0;
          font-size: 16px;
          color: #333;
          line-height: 1.4;
        }

        .product-rating {
          display: flex;
          align-items: center;
          gap: 8px;
          margin-bottom: 10px;
        }

        .stars {
          display: flex;
          gap: 2px;
        }

        .star {
          color: #ddd;
          font-size: 14px;
        }

        .star.filled {
          color: #ffc107;
        }

        .rating-text {
          font-size: 12px;
          color: #666;
        }

        .product-price {
          margin-bottom: 15px;
        }

        .current-price {
          font-size: 18px;
          font-weight: bold;
          color: #007bff;
        }

        .original-price {
          font-size: 14px;
          color: #999;
          text-decoration: line-through;
          margin-left: 8px;
        }

        .product-actions {
          display: flex;
          gap: 8px;
        }

        .add-to-cart-btn {
          flex: 1;
          background: #007bff;
          color: white;
          border: none;
          padding: 10px;
          border-radius: 4px;
          cursor: pointer;
          font-weight: bold;
        }

        .add-to-cart-btn:disabled {
          background: #6c757d;
          cursor: not-allowed;
        }

        .quick-view-btn {
          background: #6c757d;
          color: white;
          border: none;
          padding: 10px 15px;
          border-radius: 4px;
          cursor: pointer;
        }

        .no-results {
          text-align: center;
          padding: 40px;
          color: #666;
        }

        .no-results h3 {
          margin: 0 0 10px 0;
          font-size: 24px;
        }
      `}</style>
    </div>
  );
}

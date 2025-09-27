'use client';

import React, { useState, useRef, useEffect } from 'react';

const CustomDropdownNavigation = () => {
  const [isOpen, setIsOpen] = useState(false);
  const [selectedValue, setSelectedValue] = useState('all');
  const [selectedText, setSelectedText] = useState('All Categories');
  const [currentIndex, setCurrentIndex] = useState(0);
  const dropdownRef = useRef(null);
  const triggerRef = useRef(null);
  const optionsRef = useRef([]);

  const options = [
    { value: 'all', text: 'All Categories' },
    { value: 'electronics', text: 'Electronics' },
    { value: 'clothing', text: 'Clothing' },
    { value: 'books', text: 'Books' },
    { value: 'home', text: 'Home & Garden' }
  ];

  const products = {
    all: [
      { name: 'iPhone 15', category: 'Electronics' },
      { name: 'MacBook Pro', category: 'Electronics' },
      { name: 'Cotton T-Shirt', category: 'Clothing' },
      { name: 'JavaScript Guide', category: 'Books' },
      { name: 'Garden Tools', category: 'Home & Garden' }
    ],
    electronics: [
      { name: 'iPhone 15', category: 'Electronics' },
      { name: 'MacBook Pro', category: 'Electronics' }
    ],
    clothing: [
      { name: 'Cotton T-Shirt', category: 'Clothing' }
    ],
    books: [
      { name: 'JavaScript Guide', category: 'Books' }
    ],
    home: [
      { name: 'Garden Tools', category: 'Home & Garden' }
    ]
  };

  const toggleDropdown = () => {
    setIsOpen(!isOpen);
    if (!isOpen) {
      // Focus first option when opening
      setTimeout(() => {
        if (optionsRef.current[0]) {
          optionsRef.current[0].focus();
        }
      }, 0);
    }
  };

  const selectOption = (value, text, index) => {
    setSelectedValue(value);
    setSelectedText(text);
    setCurrentIndex(index);
    setIsOpen(false);
    // Return focus to trigger
    if (triggerRef.current) {
      triggerRef.current.focus();
    }
  };

  const handleKeyDown = (event) => {
    if (!isOpen) {
      if (event.key === 'Enter' || event.key === ' ') {
        event.preventDefault();
        toggleDropdown();
      }
      return;
    }

    switch (event.key) {
      case 'ArrowDown':
        event.preventDefault();
        const nextIndex = currentIndex < options.length - 1 ? currentIndex + 1 : 0;
        setCurrentIndex(nextIndex);
        if (optionsRef.current[nextIndex]) {
          optionsRef.current[nextIndex].focus();
        }
        break;
      case 'ArrowUp':
        event.preventDefault();
        const prevIndex = currentIndex > 0 ? currentIndex - 1 : options.length - 1;
        setCurrentIndex(prevIndex);
        if (optionsRef.current[prevIndex]) {
          optionsRef.current[prevIndex].focus();
        }
        break;
      case 'Enter':
      case ' ':
        event.preventDefault();
        selectOption(options[currentIndex].value, options[currentIndex].text, currentIndex);
        break;
      case 'Escape':
        setIsOpen(false);
        if (triggerRef.current) {
          triggerRef.current.focus();
        }
        break;
    }
  };

  const handleOptionKeyDown = (event, value, text, index) => {
    if (event.key === 'Enter' || event.key === ' ') {
      event.preventDefault();
      selectOption(value, text, index);
    } else if (event.key === 'Escape') {
      setIsOpen(false);
      if (triggerRef.current) {
        triggerRef.current.focus();
      }
    }
  };

  // Close dropdown when clicking outside
  useEffect(() => {
    const handleClickOutside = (event) => {
      if (dropdownRef.current && !dropdownRef.current.contains(event.target)) {
        setIsOpen(false);
      }
    };

    document.addEventListener('mousedown', handleClickOutside);
    return () => {
      document.removeEventListener('mousedown', handleClickOutside);
    };
  }, []);

  return (
    <div className="main-container">
      <div className="main-content">
        <h1>Product Filter - Custom Dropdown Accessibility Violation</h1>
        <p><strong>Violation:</strong> Custom dropdown lacks proper keyboard navigation, ARIA attributes, and screen reader support.</p>
        
        <div className="filter-section">
          <label 
            htmlFor="category-filter" 
            className="filter-label"
          >
            Filter by Category:
          </label>
          <div className="custom-dropdown" ref={dropdownRef}>
            <button
              ref={triggerRef}
              id="category-filter"
              onClick={toggleDropdown}
              onKeyDown={handleKeyDown}
              aria-expanded={isOpen}
              aria-haspopup="listbox"
              aria-labelledby="category-filter-label"
              aria-activedescendant={isOpen ? `option-${currentIndex}` : undefined}
              className={`dropdown-trigger ${isOpen ? 'open' : ''}`}
            >
              <span>{selectedText}</span>
              <span className={`dropdown-arrow ${isOpen ? 'rotated' : ''}`}>▼</span>
            </button>
            
            {isOpen && (
              <div
                role="listbox"
                aria-labelledby="category-filter-label"
                className="dropdown-menu"
              >
                {options.map((option, index) => (
                  <div
                    key={option.value}
                    ref={el => optionsRef.current[index] = el}
                    id={`option-${index}`}
                    role="option"
                    aria-selected={selectedValue === option.value}
                    tabIndex={index === currentIndex ? 0 : -1}
                    onClick={() => selectOption(option.value, option.text, index)}
                    onKeyDown={(e) => handleOptionKeyDown(e, option.value, option.text, index)}
                    onMouseEnter={() => setCurrentIndex(index)}
                    className={`dropdown-option ${selectedValue === option.value ? 'selected' : ''}`}
                  >
                    {option.text}
                  </div>
                ))}
              </div>
            )}
          </div>
        </div>
        
        <div className="results-section">
          <h2>Filtered Results</h2>
          <div className="results-grid">
            {products[selectedValue]?.map((product, index) => (
              <div key={index} className="result-card">
                <h3>{product.name}</h3>
                <p>{product.category}</p>
              </div>
            ))}
          </div>
        </div>
      </div>

      <div className="accessibility-info">
        <h3>Accessibility Issues:</h3>
        <ul>
          <li><strong>Incomplete keyboard navigation:</strong> Arrow keys don't navigate through options</li>
          <li><strong>Missing ARIA attributes:</strong> No aria-activedescendant or proper role attributes</li>
          <li><strong>Focus management:</strong> Focus doesn't move to options when dropdown opens</li>
          <li><strong>Screen reader announcements:</strong> No announcements when selection changes</li>
          <li><strong>Escape key handling:</strong> Escape doesn't close dropdown</li>
          <li><strong>Tab order:</strong> Options are not in proper tab sequence</li>
        </ul>
        
        <h3>How to Fix:</h3>
        <ul>
          <li>Add <code>aria-activedescendant</code> to track focused option</li>
          <li>Implement arrow key navigation (Up/Down)</li>
          <li>Add <code>aria-selected</code> to indicate selected state</li>
          <li>Handle Escape key to close dropdown</li>
          <li>Add <code>aria-live</code> region for selection announcements</li>
          <li>Ensure proper focus management when opening/closing</li>
        </ul>
      </div>

      <style jsx>{`
        .main-container {
          font-family: Arial, sans-serif;
          max-width: 800px;
          margin: 50px auto;
          padding: 20px;
          background-color: #f5f5f5;
        }

        .main-content {
          background: white;
          padding: 30px;
          border-radius: 8px;
          box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }

        .filter-section {
          margin-bottom: 30px;
        }

        .filter-label {
          display: block;
          margin-bottom: 10px;
          font-weight: bold;
          color: #333;
        }

        .custom-dropdown {
          position: relative;
          display: inline-block;
          width: 200px;
        }

        .dropdown-trigger {
          background-color: #f8f9fa;
          border: 2px solid #ddd;
          border-radius: 4px;
          padding: 12px 16px;
          cursor: pointer;
          display: flex;
          justify-content: space-between;
          align-items: center;
          font-size: 16px;
          width: 100%;
          box-sizing: border-box;
        }

        .dropdown-trigger:hover {
          border-color: #007bff;
        }

        .dropdown-trigger:focus {
          outline: none;
          border-color: #007bff;
          box-shadow: 0 0 0 2px rgba(0, 123, 255, 0.25);
        }

        .dropdown-trigger.open {
          border-color: #007bff;
          border-bottom-left-radius: 0;
          border-bottom-right-radius: 0;
        }

        .dropdown-arrow {
          transition: transform 0.2s ease;
        }

        .dropdown-arrow.rotated {
          transform: rotate(180deg);
        }

        .dropdown-menu {
          position: absolute;
          top: 100%;
          left: 0;
          right: 0;
          background: white;
          border: 2px solid #007bff;
          border-top: none;
          border-radius: 0 0 4px 4px;
          box-shadow: 0 4px 12px rgba(0,0,0,0.15);
          z-index: 1000;
        }

        .dropdown-option {
          padding: 12px 16px;
          cursor: pointer;
          border-bottom: 1px solid #eee;
          transition: background-color 0.2s ease;
        }

        .dropdown-option:last-child {
          border-bottom: none;
        }

        .dropdown-option:hover {
          background-color: #f8f9fa;
        }

        .dropdown-option.selected {
          background-color: #007bff;
          color: white;
        }

        .dropdown-option.selected:hover {
          background-color: #0056b3;
        }

        .results-section {
          margin-top: 30px;
        }

        .results-grid {
          display: grid;
          grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
          gap: 20px;
          margin-top: 20px;
        }

        .result-card {
          background: white;
          border: 1px solid #ddd;
          border-radius: 8px;
          padding: 20px;
          text-align: center;
          box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        .result-card h3 {
          margin: 0 0 10px 0;
          color: #333;
        }

        .result-card p {
          margin: 0;
          color: #666;
        }

        .accessibility-info {
          margin-top: 30px;
          padding: 20px;
          background-color: #e9ecef;
          border-radius: 4px;
        }
      `}</style>
    </div>
  );
};

export default CustomDropdownNavigation;
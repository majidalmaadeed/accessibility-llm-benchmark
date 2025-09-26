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
    <div style={{ fontFamily: 'Arial, sans-serif', maxWidth: '800px', margin: '50px auto', padding: '20px', backgroundColor: '#f5f5f5' }}>
      <div style={{ background: 'white', padding: '30px', borderRadius: '8px', boxShadow: '0 2px 10px rgba(0,0,0,0.1)' }}>
        <h1>Product Filter</h1>
        <p>Filter products by category using the dropdown below.</p>
        
        <div style={{ marginBottom: '30px' }}>
          <label 
            htmlFor="category-filter" 
            style={{ display: 'block', marginBottom: '10px', fontWeight: 'bold', color: '#333' }}
          >
            Filter by Category:
          </label>
          <div style={{ position: 'relative', display: 'inline-block', width: '200px' }} ref={dropdownRef}>
            <button
              ref={triggerRef}
              id="category-filter"
              onClick={toggleDropdown}
              onKeyDown={handleKeyDown}
              style={{
                backgroundColor: '#f8f9fa',
                border: '2px solid #ddd',
                borderRadius: isOpen ? '4px 4px 0 0' : '4px',
                padding: '12px 16px',
                cursor: 'pointer',
                display: 'flex',
                justifyContent: 'space-between',
                alignItems: 'center',
                fontSize: '16px',
                width: '100%',
                boxSizing: 'border-box',
                borderColor: isOpen ? '#007bff' : '#ddd'
              }}
            >
              <span>{selectedText}</span>
              <span style={{ transform: isOpen ? 'rotate(180deg)' : 'rotate(0deg)', transition: 'transform 0.2s ease' }}>▼</span>
            </button>
            
            {isOpen && (
              <div
                style={{
                  position: 'absolute',
                  top: '100%',
                  left: 0,
                  right: 0,
                  background: 'white',
                  border: '2px solid #007bff',
                  borderTop: 'none',
                  borderRadius: '0 0 4px 4px',
                  boxShadow: '0 4px 12px rgba(0,0,0,0.15)',
                  zIndex: 1000
                }}
              >
                {options.map((option, index) => (
                  <div
                    key={option.value}
                    ref={el => optionsRef.current[index] = el}
                    id={`option-${index}`}
                    onClick={() => selectOption(option.value, option.text, index)}
                    onKeyDown={(e) => handleOptionKeyDown(e, option.value, option.text, index)}
                    style={{
                      padding: '12px 16px',
                      cursor: 'pointer',
                      borderBottom: index < options.length - 1 ? '1px solid #eee' : 'none',
                      backgroundColor: selectedValue === option.value ? '#007bff' : 'transparent',
                      color: selectedValue === option.value ? 'white' : '#333',
                      transition: 'background-color 0.2s ease'
                    }}
                    onMouseEnter={() => setCurrentIndex(index)}
                  >
                    {option.text}
                  </div>
                ))}
              </div>
            )}
          </div>
        </div>
        
        <div style={{ marginTop: '30px' }}>
          <h2>Filtered Results</h2>
          <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fill, minmax(200px, 1fr))', gap: '20px', marginTop: '20px' }}>
            {products[selectedValue]?.map((product, index) => (
              <div key={index} style={{ background: 'white', border: '1px solid #ddd', borderRadius: '8px', padding: '20px', textAlign: 'center', boxShadow: '0 2px 4px rgba(0,0,0,0.1)' }}>
                <h3 style={{ margin: '0 0 10px 0', color: '#333' }}>{product.name}</h3>
                <p style={{ margin: 0, color: '#666' }}>{product.category}</p>
              </div>
            ))}
          </div>
        </div>
      </div>

    </div>
  );
};

export default CustomDropdownNavigation;
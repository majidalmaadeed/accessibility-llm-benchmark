import React, { useState, useRef, useEffect } from 'react';

const MenuSystemProblems = () => {
  const [isMenuOpen, setIsMenuOpen] = useState(false);
  const [activeSubmenu, setActiveSubmenu] = useState(null);
  const [focusedIndex, setFocusedIndex] = useState(-1);
  const menuRef = useRef(null);

  const menuItems = [
    {
      id: 'home',
      label: 'Home',
      href: '/',
      hasSubmenu: false
    },
    {
      id: 'products',
      label: 'Products',
      href: '/products',
      hasSubmenu: true,
      submenu: [
        { id: 'electronics', label: 'Electronics', href: '/products/electronics' },
        { id: 'clothing', label: 'Clothing', href: '/products/clothing' },
        { id: 'books', label: 'Books', href: '/products/books' },
        { id: 'home-garden', label: 'Home & Garden', href: '/products/home-garden' }
      ]
    },
    {
      id: 'services',
      label: 'Services',
      href: '/services',
      hasSubmenu: true,
      submenu: [
        { id: 'consulting', label: 'Consulting', href: '/services/consulting' },
        { id: 'support', label: 'Support', href: '/services/support' },
        { id: 'training', label: 'Training', href: '/services/training' }
      ]
    },
    {
      id: 'about',
      label: 'About',
      href: '/about',
      hasSubmenu: false
    },
    {
      id: 'contact',
      label: 'Contact',
      href: '/contact',
      hasSubmenu: false
    }
  ];

  useEffect(() => {
    const handleClickOutside = (event) => {
      if (menuRef.current && !menuRef.current.contains(event.target)) {
        setIsMenuOpen(false);
        setActiveSubmenu(null);
        setFocusedIndex(-1);
      }
    };

    document.addEventListener('mousedown', handleClickOutside);
    return () => document.removeEventListener('mousedown', handleClickOutside);
  }, []);

  const toggleMenu = () => {
    setIsMenuOpen(!isMenuOpen);
    setActiveSubmenu(null);
    setFocusedIndex(-1);
  };

  const handleMenuItemClick = (item) => {
    if (item.hasSubmenu) {
      setActiveSubmenu(activeSubmenu === item.id ? null : item.id);
    } else {
      console.log(`Navigate to: ${item.href}`);
      setIsMenuOpen(false);
      setActiveSubmenu(null);
    }
  };

  const handleSubmenuItemClick = (item) => {
    console.log(`Navigate to: ${item.href}`);
    setIsMenuOpen(false);
    setActiveSubmenu(null);
    setFocusedIndex(-1);
  };

  const handleKeyDown = (e) => {
    if (!isMenuOpen) {
      if (e.key === 'Enter' || e.key === ' ') {
        e.preventDefault();
        toggleMenu();
      }
      return;
    }

    switch (e.key) {
      case 'Escape':
        setIsMenuOpen(false);
        setActiveSubmenu(null);
        setFocusedIndex(-1);
        break;
      case 'ArrowDown':
        e.preventDefault();
        setFocusedIndex(prev => Math.min(prev + 1, menuItems.length - 1));
        break;
      case 'ArrowUp':
        e.preventDefault();
        setFocusedIndex(prev => Math.max(prev - 1, -1));
        break;
      case 'ArrowRight':
        e.preventDefault();
        if (focusedIndex >= 0 && menuItems[focusedIndex].hasSubmenu) {
          setActiveSubmenu(menuItems[focusedIndex].id);
        }
        break;
      case 'ArrowLeft':
        e.preventDefault();
        setActiveSubmenu(null);
        break;
      case 'Enter':
      case ' ':
        e.preventDefault();
        if (focusedIndex >= 0) {
          handleMenuItemClick(menuItems[focusedIndex]);
        }
        break;
    }
  };

  const handleSubmenuKeyDown = (e, submenuItem, submenuIndex) => {
    switch (e.key) {
      case 'Escape':
        e.preventDefault();
        setActiveSubmenu(null);
        break;
      case 'ArrowDown':
        e.preventDefault();
        // MISSING: Navigate to next submenu item
        break;
      case 'ArrowUp':
        e.preventDefault();
        // MISSING: Navigate to previous submenu item
        break;
      case 'ArrowLeft':
        e.preventDefault();
        setActiveSubmenu(null);
        break;
      case 'Enter':
      case ' ':
        e.preventDefault();
        handleSubmenuItemClick(submenuItem);
        break;
    }
  };

  return (
    <div style={{ fontFamily: 'Arial, sans-serif', maxWidth: '800px', margin: '50px auto', padding: '20px', backgroundColor: '#f5f5f5' }}>
      <div style={{ background: 'white', padding: '30px', borderRadius: '8px', boxShadow: '0 2px 10px rgba(0,0,0,0.1)' }}>
        <h1>Website Navigation</h1>
        <p>Navigate through our website using the menu system below.</p>
        
        {/* Header with Navigation */}
        <header style={{ marginBottom: '30px', paddingBottom: '20px', borderBottom: '1px solid #eee' }}>
          <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
            <div>
              <h2 style={{ margin: 0, color: '#333' }}>My Website</h2>
            </div>
            
            {/* Menu Button - MISSING PROPER ARIA ATTRIBUTES */}
            <button
              ref={menuRef}
              onClick={toggleMenu}
              onKeyDown={handleKeyDown}
              style={{
                background: '#007bff',
                color: 'white',
                border: 'none',
                padding: '10px 20px',
                borderRadius: '4px',
                cursor: 'pointer',
                fontSize: '16px',
                display: 'flex',
                alignItems: 'center',
                gap: '8px'
              }}
              aria-expanded={isMenuOpen}
              aria-haspopup="true"
              aria-controls="navigation-menu"
              aria-label="Toggle navigation menu"
            >
              <span>☰</span>
              Menu
            </button>
          </div>

          {/* Navigation Menu - MISSING PROPER ARIA ATTRIBUTES */}
          {isMenuOpen && (
            <nav
              id="navigation-menu"
              style={{
                position: 'absolute',
                top: '100%',
                right: '0',
                background: 'white',
                border: '2px solid #007bff',
                borderRadius: '8px',
                boxShadow: '0 4px 12px rgba(0,0,0,0.15)',
                zIndex: 1000,
                minWidth: '200px',
                marginTop: '10px'
              }}
              role="menu"
              aria-label="Main navigation"
            >
              <ul style={{ listStyle: 'none', margin: 0, padding: 0 }}>
                {menuItems.map((item, index) => (
                  <li key={item.id} style={{ position: 'relative' }}>
                    <button
                      onClick={() => handleMenuItemClick(item)}
                      onKeyDown={(e) => handleKeyDown(e)}
                      style={{
                        width: '100%',
                        padding: '12px 16px',
                        background: focusedIndex === index ? '#f8f9fa' : 'transparent',
                        border: 'none',
                        textAlign: 'left',
                        cursor: 'pointer',
                        fontSize: '16px',
                        color: '#333',
                        display: 'flex',
                        justifyContent: 'space-between',
                        alignItems: 'center',
                        transition: 'background-color 0.2s ease'
                      }}
                      role="menuitem"
                      aria-haspopup={item.hasSubmenu}
                      aria-expanded={activeSubmenu === item.id}
                    >
                      <span>{item.label}</span>
                      {item.hasSubmenu && (
                        <span
                          style={{
                            fontSize: '12px',
                            color: '#666',
                            transform: activeSubmenu === item.id ? 'rotate(180deg)' : 'rotate(0deg)',
                            transition: 'transform 0.2s ease'
                          }}
                          aria-hidden="true"
                        >
                          ▼
                        </span>
                      )}
                    </button>

                    {/* Submenu - MISSING PROPER ARIA ATTRIBUTES */}
                    {item.hasSubmenu && activeSubmenu === item.id && (
                      <ul
                        style={{
                          position: 'absolute',
                          left: '100%',
                          top: '0',
                          background: 'white',
                          border: '1px solid #ddd',
                          borderRadius: '4px',
                          boxShadow: '0 2px 8px rgba(0,0,0,0.1)',
                          minWidth: '150px',
                          listStyle: 'none',
                          margin: 0,
                          padding: 0,
                          zIndex: 1001
                        }}
                        role="menu"
                        aria-label={`${item.label} submenu`}
                      >
                        {item.submenu.map((submenuItem, submenuIndex) => (
                          <li key={submenuItem.id}>
                            <button
                              onClick={() => handleSubmenuItemClick(submenuItem)}
                              onKeyDown={(e) => handleSubmenuKeyDown(e, submenuItem, submenuIndex)}
                              style={{
                                width: '100%',
                                padding: '10px 16px',
                                background: 'transparent',
                                border: 'none',
                                textAlign: 'left',
                                cursor: 'pointer',
                                fontSize: '14px',
                                color: '#666',
                                transition: 'background-color 0.2s ease'
                              }}
                              role="menuitem"
                            >
                              {submenuItem.label}
                            </button>
                          </li>
                        ))}
                      </ul>
                    )}
                  </li>
                ))}
              </ul>
            </nav>
          )}
        </header>

        {/* Page Content */}
        <main>
          <h2 style={{ marginBottom: '20px', color: '#333' }}>Welcome to Our Website</h2>
          <p style={{ marginBottom: '20px', color: '#666', lineHeight: '1.6' }}>
            This page demonstrates a navigation menu with accessibility issues. 
            The menu lacks proper keyboard navigation, ARIA attributes, and screen reader support.
          </p>
          
          <div style={{ 
            padding: '20px', 
            background: '#f8f9fa', 
            borderRadius: '4px',
            marginBottom: '20px'
          }}>
            <h3 style={{ marginBottom: '10px', color: '#333' }}>Navigation Instructions:</h3>
            <ul style={{ margin: 0, paddingLeft: '20px', color: '#666' }}>
              <li>Click the "Menu" button to open/close the navigation</li>
              <li>Use arrow keys to navigate between menu items</li>
              <li>Press Enter or Space to activate menu items</li>
              <li>Use Escape to close the menu</li>
              <li>Right arrow opens submenus, left arrow closes them</li>
            </ul>
          </div>

          <div style={{ 
            padding: '20px', 
            background: '#e9ecef', 
            borderRadius: '4px',
            fontSize: '14px',
            color: '#666'
          }}>
            <strong>Note:</strong> This implementation has several accessibility issues that need to be addressed 
            for proper screen reader and keyboard navigation support.
          </div>
        </main>
      </div>

      <div style={{ marginTop: '30px', padding: '20px', backgroundColor: '#e9ecef', borderRadius: '4px' }}>
        <h3>Accessibility Issues:</h3>
        <ul>
          <li><strong>Missing ARIA attributes:</strong> No aria-expanded, aria-haspopup, or aria-controls</li>
          <li><strong>Incomplete keyboard navigation:</strong> Arrow keys don't work properly for submenu navigation</li>
          <li><strong>No focus management:</strong> Focus doesn't move appropriately when menu opens/closes</li>
          <li><strong>Missing menu semantics:</strong> Menu items lack proper role and state attributes</li>
          <li><strong>No screen reader announcements:</strong> Menu state changes not announced</li>
          <li><strong>Missing submenu navigation:</strong> Can't navigate between submenu items with keyboard</li>
        </ul>
        
        <h3>How to Fix:</h3>
        <ul>
          <li>Add <code>role="menu"</code> and <code>role="menuitem"</code> to navigation elements</li>
          <li>Use <code>aria-expanded</code> to indicate submenu state</li>
          <li>Implement <code>aria-haspopup</code> for items with submenus</li>
          <li>Add proper arrow key navigation (Up/Down/Left/Right)</li>
          <li>Use <code>aria-controls</code> to link menu button to menu panel</li>
          <li>Implement focus management when menu opens/closes</li>
        </ul>
      </div>
    </div>
  );
};

export default MenuSystemProblems;
import React, { useState, useRef, useEffect } from 'react';
const MenuSystemProblems = () => {
  const [isMenuOpen, setIsMenuOpen] = useState(false);
  const [activeSubmenu, setActiveSubmenu] = useState(null);
  const menuRef = useRef(null);
  const menuItems = [
    {
      id: 'home',
      href: '/',
      hasSubmenu: false
    },
    {
      id: 'products',
      href: '/products',
      hasSubmenu: true,
      submenu: [
      ]
    },
    {
      id: 'services',
      href: '/services',
      hasSubmenu: true,
      submenu: [
      ]
    },
    {
      id: 'about',
      href: '/about',
      hasSubmenu: false
    },
    {
      id: 'contact',
      href: '/contact',
      hasSubmenu: false
    }
  ];
  useEffect(() => {
    const handleClickOutside = (event) => {
      if (menuRef.current && !menuRef.current.contains(event.target)) {
        setIsMenuOpen(false);
        setActiveSubmenu(null);
      }
    };
    document.addEventListener('mousedown', handleClickOutside);
    return () => document.removeEventListener('mousedown', handleClickOutside);
  }, []);
  const toggleMenu = () => {
    setIsMenuOpen(!isMenuOpen);
    setActiveSubmenu(null);
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
        break;
      case 'ArrowDown':
        e.preventDefault();
        break;
      case 'ArrowUp':
        e.preventDefault();
        break;
      case 'ArrowRight':
        e.preventDefault();
        }
        break;
      case 'ArrowLeft':
        e.preventDefault();
        setActiveSubmenu(null);
        break;
      case 'Enter':
      case ' ':
        e.preventDefault();
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
        break;
      case 'ArrowUp':
        e.preventDefault();
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
        </main>
      </div>
      <div style={{ marginTop: '30px', padding: '20px', backgroundColor: '#e9ecef', borderRadius: '4px' }}>
      </div>
    </div>
  );
};
export default MenuSystemProblems;
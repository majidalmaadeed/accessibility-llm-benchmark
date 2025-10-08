import React, { useState } from 'react';

const MissingLanguageAttribute = () => {
  const [selectedLanguage, setSelectedLanguage] = useState('en');

  const content = {
    en: {
      title: "Welcome to Our Website",
      subtitle: "Discover amazing products and services",
      description: "We offer a wide range of high-quality products and professional services to meet all your needs.",
      button: "Learn More"
    },
    fr: {
      title: "Bienvenue sur Notre Site Web",
      subtitle: "Découvrez des produits et services incroyables",
      description: "Nous offrons une large gamme de produits de haute qualité et de services professionnels pour répondre à tous vos besoins.",
      button: "En Savoir Plus"
    }
  };

  const currentContent = content[selectedLanguage];

  return (
    <div style={{ 
      maxWidth: '1000px', 
      margin: '50px auto', 
      padding: '20px',
      fontFamily: 'Arial, sans-serif'
    }}>
      {/* Language selector */}
      <div style={{
        display: 'flex',
        justifyContent: 'flex-end',
        marginBottom: '30px'
      }}>
        <select
          value={selectedLanguage}
          onChange={(e) => setSelectedLanguage(e.target.value)}
          style={{
            padding: '8px 12px',
            border: '1px solid #ddd',
            borderRadius: '4px',
            fontSize: '14px'
          }}
        >
          <option value="en">English</option>
          <option value="fr">Français</option>
        </select>
      </div>

      {/* Hero section with mixed English/French content without lang attributes */}
      <div style={{
        background: 'linear-gradient(135deg, #667eea 0%, #764ba2 100%)',
        color: 'white',
        padding: '60px 40px',
        borderRadius: '12px',
        textAlign: 'center',
        marginBottom: '40px'
      }}>
        <h1 style={{ 
          fontSize: '48px', 
          margin: '0 0 20px 0',
          fontWeight: 'bold'
        }}>
          {currentContent.title}
        </h1>
        <p style={{ 
          fontSize: '20px', 
          margin: '0 0 30px 0',
          opacity: 0.9
        }}>
          {currentContent.subtitle}
        </p>
        <button style={{
          background: 'white',
          color: '#667eea',
          border: 'none',
          padding: '15px 30px',
          borderRadius: '25px',
          fontSize: '16px',
          fontWeight: 'bold',
          cursor: 'pointer',
          boxShadow: '0 4px 15px rgba(0,0,0,0.2)'
        }}>
          {currentContent.button}
        </button>
      </div>

      {/* Main content */}
      <div style={{
        display: 'grid',
        gridTemplateColumns: 'repeat(auto-fit, minmax(300px, 1fr))',
        gap: '30px',
        marginBottom: '40px'
      }}>
        <div style={{
          background: 'white',
          padding: '30px',
          borderRadius: '8px',
          boxShadow: '0 2px 10px rgba(0,0,0,0.1)'
        }}>
          <h2 style={{ 
            fontSize: '24px', 
            margin: '0 0 15px 0',
            color: '#333'
          }}>
            About Us
          </h2>
          <p style={{ 
            fontSize: '16px', 
            lineHeight: '1.6',
            color: '#666',
            margin: 0
          }}>
            {currentContent.description}
          </p>
        </div>

        <div style={{
          background: 'white',
          padding: '30px',
          borderRadius: '8px',
          boxShadow: '0 2px 10px rgba(0,0,0,0.1)'
        }}>
          <h2 style={{ 
            fontSize: '24px', 
            margin: '0 0 15px 0',
            color: '#333'
          }}>
            Our Services
          </h2>
          <ul style={{ 
            margin: 0, 
            paddingLeft: '20px',
            fontSize: '16px',
            lineHeight: '1.8',
            color: '#666'
          }}>
            <li>Web Development</li>
            <li>Mobile App Development</li>
            <li>Cloud Solutions</li>
            <li>Digital Marketing</li>
          </ul>
        </div>
      </div>

      {/* Contact section */}
      <div style={{
        background: '#f8f9fa',
        padding: '40px',
        borderRadius: '8px',
        textAlign: 'center'
      }}>
        <h2 style={{ 
          fontSize: '28px', 
          margin: '0 0 20px 0',
          color: '#333'
        }}>
          Get in Touch
        </h2>
        <p style={{ 
          fontSize: '16px', 
          margin: '0 0 30px 0',
          color: '#666'
        }}>
          Ready to get started? Contact us today for more information.
        </p>
        <div style={{ display: 'flex', gap: '15px', justifyContent: 'center', flexWrap: 'wrap' }}>
          <button style={{
            background: '#007bff',
            color: 'white',
            border: 'none',
            padding: '12px 24px',
            borderRadius: '4px',
            fontSize: '16px',
            cursor: 'pointer'
          }}>
            Contact Us
          </button>
          <button style={{
            background: 'transparent',
            color: '#007bff',
            border: '2px solid #007bff',
            padding: '10px 24px',
            borderRadius: '4px',
            fontSize: '16px',
            cursor: 'pointer'
          }}>
            View Portfolio
          </button>
        </div>
      </div>
    </div>
  );
};

export default MissingLanguageAttribute;

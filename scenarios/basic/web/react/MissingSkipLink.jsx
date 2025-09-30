import React, { useState } from 'react';

const MissingSkipLink = () => {
  const [activeSection, setActiveSection] = useState('home');

  const sections = [
    { id: 'home', title: 'Home', content: 'Welcome to our website' },
    { id: 'about', title: 'About', content: 'Learn more about our company' },
    { id: 'services', title: 'Services', content: 'Our professional services' },
    { id: 'products', title: 'Products', content: 'Browse our product catalog' },
    { id: 'contact', title: 'Contact', content: 'Get in touch with us' }
  ];

  return (
    <div style={{ 
      fontFamily: 'Arial, sans-serif',
      minHeight: '100vh'
    }}>
      {/* Page navigation without skip-to-content link */}
      <header style={{
        background: '#2c3e50',
        color: 'white',
        padding: '0',
        position: 'sticky',
        top: 0,
        zIndex: 100,
        boxShadow: '0 2px 4px rgba(0,0,0,0.1)'
      }}>
        <div style={{
          maxWidth: '1200px',
          margin: '0 auto',
          display: 'flex',
          alignItems: 'center',
          justifyContent: 'space-between',
          padding: '0 20px'
        }}>
          <div style={{
            fontSize: '24px',
            fontWeight: 'bold',
            padding: '15px 0'
          }}>
            Company Logo
          </div>
          
          <nav style={{ display: 'flex', gap: '0' }}>
            {sections.map(section => (
              <button
                key={section.id}
                onClick={() => setActiveSection(section.id)}
                style={{
                  background: activeSection === section.id ? '#34495e' : 'transparent',
                  color: 'white',
                  border: 'none',
                  padding: '15px 20px',
                  cursor: 'pointer',
                  fontSize: '16px',
                  fontWeight: '500',
                  transition: 'background-color 0.3s ease'
                }}
              >
                {section.title}
              </button>
            ))}
          </nav>
        </div>
      </header>

      {/* Main content area */}
      <main style={{
        maxWidth: '1200px',
        margin: '0 auto',
        padding: '40px 20px'
      }}>
        {/* Hero section */}
        <section style={{
          background: 'linear-gradient(135deg, #667eea 0%, #764ba2 100%)',
          color: 'white',
          padding: '80px 40px',
          borderRadius: '12px',
          textAlign: 'center',
          marginBottom: '60px'
        }}>
          <h1 style={{ 
            fontSize: '48px', 
            margin: '0 0 20px 0',
            fontWeight: 'bold'
          }}>
            Welcome to Our Platform
          </h1>
          <p style={{ 
            fontSize: '20px', 
            margin: '0 0 40px 0',
            opacity: 0.9
          }}>
            Discover innovative solutions for your business needs
          </p>
          <button style={{
            background: 'white',
            color: '#667eea',
            border: 'none',
            padding: '15px 30px',
            borderRadius: '25px',
            fontSize: '18px',
            fontWeight: 'bold',
            cursor: 'pointer',
            boxShadow: '0 4px 15px rgba(0,0,0,0.2)'
          }}>
            Get Started Today
          </button>
        </section>

        {/* Content sections */}
        <div style={{
          display: 'grid',
          gridTemplateColumns: 'repeat(auto-fit, minmax(300px, 1fr))',
          gap: '30px',
          marginBottom: '60px'
        }}>
          <div style={{
            background: 'white',
            padding: '30px',
            borderRadius: '8px',
            boxShadow: '0 2px 10px rgba(0,0,0,0.1)',
            border: '1px solid #e0e0e0'
          }}>
            <h2 style={{ 
              fontSize: '24px', 
              margin: '0 0 15px 0',
              color: '#333'
            }}>
              About Our Company
            </h2>
            <p style={{ 
              fontSize: '16px', 
              lineHeight: '1.6',
              color: '#666',
              margin: 0
            }}>
              We are a leading technology company dedicated to providing innovative 
              solutions that help businesses grow and succeed in the digital age.
            </p>
          </div>

          <div style={{
            background: 'white',
            padding: '30px',
            borderRadius: '8px',
            boxShadow: '0 2px 10px rgba(0,0,0,0.1)',
            border: '1px solid #e0e0e0'
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

        {/* Dynamic content based on active section */}
        <section style={{
          background: '#f8f9fa',
          padding: '40px',
          borderRadius: '8px',
          marginBottom: '40px'
        }}>
          <h2 style={{ 
            fontSize: '28px', 
            margin: '0 0 20px 0',
            color: '#333'
          }}>
            {sections.find(s => s.id === activeSection)?.title}
          </h2>
          <p style={{ 
            fontSize: '18px', 
            lineHeight: '1.6',
            color: '#666',
            margin: 0
          }}>
            {sections.find(s => s.id === activeSection)?.content}
          </p>
        </section>

        {/* Additional content sections */}
        <div style={{
          display: 'grid',
          gridTemplateColumns: 'repeat(auto-fit, minmax(250px, 1fr))',
          gap: '20px',
          marginBottom: '40px'
        }}>
          <div style={{
            background: 'white',
            padding: '20px',
            borderRadius: '8px',
            boxShadow: '0 2px 8px rgba(0,0,0,0.1)',
            border: '1px solid #e0e0e0'
          }}>
            <h3 style={{ 
              fontSize: '18px', 
              margin: '0 0 10px 0',
              color: '#333'
            }}>
              Feature 1
            </h3>
            <p style={{ 
              fontSize: '14px', 
              color: '#666',
              margin: 0
            }}>
              Description of the first feature
            </p>
          </div>
          <div style={{
            background: 'white',
            padding: '20px',
            borderRadius: '8px',
            boxShadow: '0 2px 8px rgba(0,0,0,0.1)',
            border: '1px solid #e0e0e0'
          }}>
            <h3 style={{ 
              fontSize: '18px', 
              margin: '0 0 10px 0',
              color: '#333'
            }}>
              Feature 2
            </h3>
            <p style={{ 
              fontSize: '14px', 
              color: '#666',
              margin: 0
            }}>
              Description of the second feature
            </p>
          </div>
          <div style={{
            background: 'white',
            padding: '20px',
            borderRadius: '8px',
            boxShadow: '0 2px 8px rgba(0,0,0,0.1)',
            border: '1px solid #e0e0e0'
          }}>
            <h3 style={{ 
              fontSize: '18px', 
              margin: '0 0 10px 0',
              color: '#333'
            }}>
              Feature 3
            </h3>
            <p style={{ 
              fontSize: '14px', 
              color: '#666',
              margin: 0
            }}>
              Description of the third feature
            </p>
          </div>
        </div>
      </main>

      {/* Footer */}
      <footer style={{
        background: '#34495e',
        color: 'white',
        padding: '40px 20px',
        textAlign: 'center'
      }}>
        <div style={{
          maxWidth: '1200px',
          margin: '0 auto'
        }}>
          <p style={{ 
            margin: '0 0 20px 0',
            fontSize: '16px'
          }}>
            © 2024 Company Name. All rights reserved.
          </p>
          <div style={{
            display: 'flex',
            justifyContent: 'center',
            gap: '30px',
            flexWrap: 'wrap'
          }}>
            <a href="#" style={{ color: 'white', textDecoration: 'none' }}>Privacy Policy</a>
            <a href="#" style={{ color: 'white', textDecoration: 'none' }}>Terms of Service</a>
            <a href="#" style={{ color: 'white', textDecoration: 'none' }}>Contact Us</a>
          </div>
        </div>
      </footer>
    </div>
  );
};

export default MissingSkipLink;

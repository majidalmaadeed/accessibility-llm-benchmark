import React from 'react';

const GenericLinkText = () => {
  return (
    <div style={{ 
      maxWidth: '800px', 
      margin: '50px auto', 
      padding: '20px',
      fontFamily: 'Arial, sans-serif'
    }}>
      <h1>Company Blog</h1>
      <p>Stay updated with our latest insights and industry news.</p>
      
      <div style={{
        display: 'grid',
        gridTemplateColumns: 'repeat(auto-fit, minmax(300px, 1fr))',
        gap: '30px',
        marginBottom: '40px'
      }}>
        <article style={{
          background: 'white',
          padding: '25px',
          borderRadius: '8px',
          boxShadow: '0 2px 8px rgba(0,0,0,0.1)',
          border: '1px solid #e0e0e0'
        }}>
          <h2 style={{ 
            fontSize: '22px', 
            margin: '0 0 15px 0',
            color: '#333'
          }}>
            The Future of Artificial Intelligence
          </h2>
          <p style={{ 
            fontSize: '16px', 
            lineHeight: '1.6',
            color: '#666',
            margin: '0 0 20px 0'
          }}>
            Artificial intelligence is transforming industries across the globe. 
            From healthcare to finance, AI technologies are revolutionizing how 
            we work and live. This comprehensive analysis explores the current 
            state of AI and its potential impact on society.
          </p>
          <p style={{ 
            fontSize: '16px', 
            lineHeight: '1.6',
            color: '#666',
            margin: '0 0 20px 0'
          }}>
            The article covers machine learning algorithms, neural networks, 
            and practical applications that are already changing our daily lives. 
            Discover how businesses are leveraging AI to improve efficiency and 
            create new opportunities.
          </p>
          <div style={{
            display: 'flex',
            justifyContent: 'space-between',
            alignItems: 'center'
          }}>
            <span style={{ 
              fontSize: '14px', 
              color: '#999'
            }}>
              Published 3 days ago
            </span>
            <a 
              href="#" 
              style={{
                color: '#007bff',
                textDecoration: 'none',
                fontSize: '14px',
                fontWeight: 'bold'
              }}
            >
              Read more
            </a>
          </div>
        </article>

        <article style={{
          background: 'white',
          padding: '25px',
          borderRadius: '8px',
          boxShadow: '0 2px 8px rgba(0,0,0,0.1)',
          border: '1px solid #e0e0e0'
        }}>
          <h2 style={{ 
            fontSize: '22px', 
            margin: '0 0 15px 0',
            color: '#333'
          }}>
            Sustainable Technology Solutions
          </h2>
          <p style={{ 
            fontSize: '16px', 
            lineHeight: '1.6',
            color: '#666',
            margin: '0 0 20px 0'
          }}>
            As environmental concerns grow, technology companies are developing 
            innovative solutions to reduce carbon footprints and promote 
            sustainability. This report examines the latest green technologies 
            and their implementation across various sectors.
          </p>
          <p style={{ 
            fontSize: '16px', 
            lineHeight: '1.6',
            color: '#666',
            margin: '0 0 20px 0'
          }}>
            Learn about renewable energy systems, smart grid technologies, 
            and sustainable manufacturing processes that are helping companies 
            achieve their environmental goals while maintaining profitability.
          </p>
          <div style={{
            display: 'flex',
            justifyContent: 'space-between',
            alignItems: 'center'
          }}>
            <span style={{ 
              fontSize: '14px', 
              color: '#999'
            }}>
              Published 1 week ago
            </span>
            <a 
              href="#" 
              style={{
                color: '#007bff',
                textDecoration: 'none',
                fontSize: '14px',
                fontWeight: 'bold'
              }}
            >
              Read more
            </a>
          </div>
        </article>

        <article style={{
          background: 'white',
          padding: '25px',
          borderRadius: '8px',
          boxShadow: '0 2px 8px rgba(0,0,0,0.1)',
          border: '1px solid #e0e0e0'
        }}>
          <h2 style={{ 
            fontSize: '22px', 
            margin: '0 0 15px 0',
            color: '#333'
          }}>
            Cybersecurity Best Practices
          </h2>
          <p style={{ 
            fontSize: '16px', 
            lineHeight: '1.6',
            color: '#666',
            margin: '0 0 20px 0'
          }}>
            With cyber threats becoming more sophisticated, organizations must 
            implement robust security measures to protect their data and systems. 
            This guide provides essential cybersecurity strategies for businesses 
            of all sizes.
          </p>
          <p style={{ 
            fontSize: '16px', 
            lineHeight: '1.6',
            color: '#666',
            margin: '0 0 20px 0'
          }}>
            The article covers threat detection, incident response planning, 
            employee training, and the latest security technologies that can 
            help safeguard your organization's digital assets.
          </p>
          <div style={{
            display: 'flex',
            justifyContent: 'space-between',
            alignItems: 'center'
          }}>
            <span style={{ 
              fontSize: '14px', 
              color: '#999'
            }}>
              Published 2 weeks ago
            </span>
            <a 
              href="#" 
              style={{
                color: '#007bff',
                textDecoration: 'none',
                fontSize: '14px',
                fontWeight: 'bold'
              }}
            >
              Read more
            </a>
          </div>
        </article>

        <article style={{
          background: 'white',
          padding: '25px',
          borderRadius: '8px',
          boxShadow: '0 2px 8px rgba(0,0,0,0.1)',
          border: '1px solid #e0e0e0'
        }}>
          <h2 style={{ 
            fontSize: '22px', 
            margin: '0 0 15px 0',
            color: '#333'
          }}>
            Remote Work Technology Trends
          </h2>
          <p style={{ 
            fontSize: '16px', 
            lineHeight: '1.6',
            color: '#666',
            margin: '0 0 20px 0'
          }}>
            The shift to remote work has accelerated the adoption of new 
            technologies and collaboration tools. This analysis explores 
            the latest trends in remote work technology and their impact 
            on productivity and employee satisfaction.
          </p>
          <p style={{ 
            fontSize: '16px', 
            lineHeight: '1.6',
            color: '#666',
            margin: '0 0 20px 0'
          }}>
            Discover the tools and platforms that are enabling effective 
            remote collaboration, from video conferencing solutions to 
            project management software and virtual reality workspaces.
          </p>
          <div style={{
            display: 'flex',
            justifyContent: 'space-between',
            alignItems: 'center'
          }}>
            <span style={{ 
              fontSize: '14px', 
              color: '#999'
            }}>
              Published 3 weeks ago
            </span>
            <a 
              href="#" 
              style={{
                color: '#007bff',
                textDecoration: 'none',
                fontSize: '14px',
                fontWeight: 'bold'
              }}
            >
              Read more
            </a>
          </div>
        </article>
      </div>

      <div style={{
        background: '#f8f9fa',
        padding: '30px',
        borderRadius: '8px',
        textAlign: 'center'
      }}>
        <h2 style={{ 
          fontSize: '24px', 
          margin: '0 0 15px 0',
          color: '#333'
        }}>
          Stay Connected
        </h2>
        <p style={{ 
          fontSize: '16px', 
          margin: '0 0 25px 0',
          color: '#666'
        }}>
          Follow us on social media for the latest updates and insights.
        </p>
        
        <div style={{ display: 'flex', gap: '15px', justifyContent: 'center', flexWrap: 'wrap' }}>
          <a 
            href="#" 
            style={{
              background: '#1877f2',
              color: 'white',
              padding: '10px 20px',
              borderRadius: '4px',
              textDecoration: 'none',
              fontSize: '14px',
              fontWeight: 'bold'
            }}
          >
            Follow us on Facebook
          </a>
          <a 
            href="#" 
            style={{
              background: '#1da1f2',
              color: 'white',
              padding: '10px 20px',
              borderRadius: '4px',
              textDecoration: 'none',
              fontSize: '14px',
              fontWeight: 'bold'
            }}
          >
            Follow us on Twitter
          </a>
          <a 
            href="#" 
            style={{
              background: '#0077b5',
              color: 'white',
              padding: '10px 20px',
              borderRadius: '4px',
              textDecoration: 'none',
              fontSize: '14px',
              fontWeight: 'bold'
            }}
          >
            Connect on LinkedIn
          </a>
        </div>
      </div>
    </div>
  );
};

export default GenericLinkText;

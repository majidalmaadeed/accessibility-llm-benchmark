import React, { useState } from 'react';

const AccordionWithoutState = () => {
  const [openItems, setOpenItems] = useState(new Set());

  const faqItems = [
    {
      id: 1,
      question: 'How do I create an account?',
      answer: 'To create an account, click on the "Sign Up" button in the top right corner of the page. Fill in your email address, create a password, and provide your basic information. You\'ll receive a confirmation email to verify your account.'
    },
    {
      id: 2,
      question: 'What payment methods do you accept?',
      answer: 'We accept all major credit cards (Visa, MasterCard, American Express), PayPal, and bank transfers. All payments are processed securely through our encrypted payment gateway.'
    },
    {
      id: 3,
      question: 'How can I cancel my subscription?',
      answer: 'You can cancel your subscription at any time by going to your account settings and clicking on "Subscription Management". You\'ll continue to have access to premium features until the end of your current billing period.'
    },
    {
      id: 4,
      question: 'Is there a mobile app available?',
      answer: 'Yes! We have mobile apps available for both iOS and Android devices. You can download them from the App Store or Google Play Store. The mobile app includes all the features of the web version.'
    },
    {
      id: 5,
      question: 'How do I contact customer support?',
      answer: 'You can reach our customer support team through email at support@example.com, through our live chat feature on the website, or by calling our toll-free number at 1-800-EXAMPLE. We typically respond within 24 hours.'
    },
    {
      id: 6,
      question: 'What is your refund policy?',
      answer: 'We offer a 30-day money-back guarantee for all subscriptions. If you\'re not satisfied with our service, you can request a full refund within 30 days of your initial purchase. Contact our support team to initiate the refund process.'
    }
  ];

  const toggleItem = (itemId) => {
    const newOpenItems = new Set(openItems);
    if (newOpenItems.has(itemId)) {
      newOpenItems.delete(itemId);
    } else {
      newOpenItems.add(itemId);
    }
    setOpenItems(newOpenItems);
  };

  const toggleAll = () => {
    if (openItems.size === faqItems.length) {
      setOpenItems(new Set());
    } else {
      setOpenItems(new Set(faqItems.map(item => item.id)));
    }
  };

  return (
    <div style={{ fontFamily: 'Arial, sans-serif', maxWidth: '800px', margin: '50px auto', padding: '20px', backgroundColor: '#f5f5f5' }}>
      <div style={{ background: 'white', padding: '30px', borderRadius: '8px', boxShadow: '0 2px 10px rgba(0,0,0,0.1)' }}>
        <h1>Frequently Asked Questions</h1>
        <p>Find answers to common questions about our service and platform.</p>
        
        <div style={{ marginTop: '30px' }}>
          {/* Toggle All Button */}
          <div style={{ marginBottom: '20px', textAlign: 'right' }}>
            <button
              onClick={toggleAll}
              style={{
                backgroundColor: '#6c757d',
                color: 'white',
                padding: '8px 16px',
                border: 'none',
                borderRadius: '4px',
                fontSize: '14px',
                cursor: 'pointer'
              }}
            >
              {openItems.size === faqItems.length ? 'Collapse All' : 'Expand All'}
            </button>
          </div>

          {/* FAQ Items */}
          <div style={{ border: '1px solid #ddd', borderRadius: '8px', overflow: 'hidden' }}>
            {faqItems.map((item, index) => {
              const isOpen = openItems.has(item.id);
              return (
                <div key={item.id} style={{ borderBottom: index < faqItems.length - 1 ? '1px solid #eee' : 'none' }}>
                  {/* Question Header */}
                  <button
                    onClick={() => toggleItem(item.id)}
                    style={{
                      width: '100%',
                      padding: '20px',
                      border: 'none',
                      background: 'white',
                      textAlign: 'left',
                      cursor: 'pointer',
                      display: 'flex',
                      justifyContent: 'space-between',
                      alignItems: 'center',
                      fontSize: '16px',
                      fontWeight: 'bold',
                      color: '#333',
                      transition: 'background-color 0.2s ease'
                    }}
                    onMouseEnter={(e) => e.target.style.backgroundColor = '#f8f9fa'}
                    onMouseLeave={(e) => e.target.style.backgroundColor = 'white'}
                  >
                    <span>{item.question}</span>
                    <span style={{
                      fontSize: '20px',
                      color: '#666',
                      transform: isOpen ? 'rotate(180deg)' : 'rotate(0deg)',
                      transition: 'transform 0.3s ease'
                    }}>
                      ▼
                    </span>
                  </button>

                  {/* Answer Content */}
                  <div
                    style={{
                      maxHeight: isOpen ? '200px' : '0',
                      overflow: 'hidden',
                      transition: 'max-height 0.3s ease',
                      backgroundColor: '#fafafa'
                    }}
                  >
                    <div style={{ padding: '20px', lineHeight: '1.6', color: '#666' }}>
                      {item.answer}
                    </div>
                  </div>
                </div>
              );
            })}
          </div>
        </div>

        {/* Additional Help Section */}
        <div style={{ marginTop: '40px', padding: '20px', backgroundColor: '#e3f2fd', borderRadius: '4px' }}>
          <h3 style={{ margin: '0 0 10px 0', color: '#1976d2' }}>Still have questions?</h3>
          <p style={{ margin: '0 0 15px 0', color: '#333' }}>
            If you couldn't find the answer you're looking for, our support team is here to help.
          </p>
          <div style={{ display: 'flex', gap: '10px' }}>
            <button style={{
              backgroundColor: '#1976d2',
              color: 'white',
              padding: '10px 20px',
              border: 'none',
              borderRadius: '4px',
              fontSize: '14px',
              cursor: 'pointer'
            }}>
              Contact Support
            </button>
            <button style={{
              backgroundColor: 'transparent',
              color: '#1976d2',
              padding: '10px 20px',
              border: '1px solid #1976d2',
              borderRadius: '4px',
              fontSize: '14px',
              cursor: 'pointer'
            }}>
              Live Chat
            </button>
          </div>
        </div>
      </div>
    </div>
  );
};

export default AccordionWithoutState;
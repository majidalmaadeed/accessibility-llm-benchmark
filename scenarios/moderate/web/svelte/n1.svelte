import React, { useState } from 'react';
const AccordionWithoutState = () => {
  const [openItems, setOpenItems] = useState(new Set());
  const faqItems = [
    {
      id: 1,
    },
    {
      id: 2,
    },
    {
      id: 3,
    },
    {
      id: 4,
    },
    {
      id: 5,
    }
  ];
  const toggleItem = (itemId) => {
    setOpenItems(prev => {
      const newSet = new Set(prev);
      if (newSet.has(itemId)) {
        newSet.delete(itemId);
      } else {
        newSet.add(itemId);
      }
      return newSet;
    });
  };
  const handleKeyDown = (e, itemId) => {
    if (e.key === 'Enter' || e.key === ' ') {
      e.preventDefault();
      toggleItem(itemId);
    }
  };
  return (
      <div style={{ background: 'white', padding: '30px', borderRadius: '8px', boxShadow: '0 2px 10px rgba(0,0,0,0.1)' }}>
        <h1>FAQ Section</h1>
        <p>Browse through our frequently asked questions below.</p>
        <div style={{ marginTop: '30px' }}>
          <h2 style={{ marginBottom: '20px', color: '#333' }}>Frequently Asked Questions</h2>
          {}
          <div
            style={{ border: '1px solid #ddd', borderRadius: '8px', overflow: 'hidden' }}
          >
            {faqItems.map((item, index) => {
              const isOpen = openItems.has(item.id);
              return (
                <div key={item.id} style={{ borderBottom: index < faqItems.length - 1 ? '1px solid #eee' : 'none' }}>
                  {}
                  <button
                    onClick={() => toggleItem(item.id)}
                    onKeyDown={(e) => handleKeyDown(e, item.id)}
                    style={{
                      width: '100%',
                      padding: '20px',
                      background: isOpen ? '#f8f9fa' : 'white',
                      border: 'none',
                      textAlign: 'left',
                      cursor: 'pointer',
                      fontSize: '16px',
                      fontWeight: 'bold',
                      color: '#333',
                      display: 'flex',
                      justifyContent: 'space-between',
                      alignItems: 'center',
                      transition: 'background-color 0.3s ease'
                    }}
                    id={`faq-question-${item.id}`}
                  >
                    <span>{item.question}</span>
                    <span
                      style={{
                        fontSize: '20px',
                        color: '#666',
                        transition: 'transform 0.3s ease',
                        transform: isOpen ? 'rotate(180deg)' : 'rotate(0deg)'
                      }}
                    >
                      ▼
                    </span>
                  </button>
                  {}
                  <div
                    id={`faq-answer-${item.id}`}
                    style={{
                      maxHeight: isOpen ? '200px' : '0',
                      overflow: 'hidden',
                      transition: 'max-height 0.3s ease',
                      background: 'white'
                    }}
                  >
                    <div style={{ padding: '20px', color: '#666', lineHeight: '1.6' }}>
                      {item.answer}
                    </div>
                  </div>
                </div>
              );
            })}
          </div>
        </div>
        {/* Expand/Collapse All Controls */}
        <div style={{ marginTop: '20px', display: 'flex', gap: '10px' }}>
          <button
            onClick={() => setOpenItems(new Set(faqItems.map(item => item.id)))}
            style={{
              background: '#007bff',
              color: 'white',
              border: 'none',
              padding: '8px 16px',
              borderRadius: '4px',
              cursor: 'pointer',
              fontSize: '14px'
            }}
          >
            Expand All
          </button>
          <button
            onClick={() => setOpenItems(new Set())}
            style={{
              background: '#6c757d',
              color: 'white',
              border: 'none',
              padding: '8px 16px',
              borderRadius: '4px',
              cursor: 'pointer',
              fontSize: '14px'
            }}
          >
            Collapse All
          </button>
        </div>
        {/* Summary */}
        <div style={{ 
          marginTop: '20px', 
          padding: '15px', 
          background: '#e9ecef', 
          borderRadius: '4px',
          fontSize: '14px',
          color: '#666'
        }}>
          <strong>Summary:</strong> {openItems.size} of {faqItems.length} questions are currently expanded.
        </div>
      </div>
      <div style={{ marginTop: '30px', padding: '20px', backgroundColor: '#e9ecef', borderRadius: '4px' }}>
      </div>
    </div>
  );
};
export default AccordionWithoutState;
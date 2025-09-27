import React, { useState } from 'react';

const AccordionWithoutState = () => {
  const [openItems, setOpenItems] = useState(new Set());

  const faqItems = [
    {
      id: 1,
      question: 'What is accessibility and why is it important?',
      answer: 'Accessibility refers to the design of products, devices, services, or environments for people with disabilities. It\'s important because it ensures equal access and opportunity for all users, regardless of their abilities or disabilities. This includes visual, auditory, physical, speech, cognitive, and neurological disabilities.'
    },
    {
      id: 2,
      question: 'How do screen readers work?',
      answer: 'Screen readers are assistive technologies that convert digital text into synthesized speech or braille. They read aloud the content of web pages, documents, and applications, allowing users with visual impairments to navigate and interact with digital content. Popular screen readers include NVDA, JAWS, VoiceOver, and TalkBack.'
    },
    {
      id: 3,
      question: 'What are ARIA attributes and how do they help?',
      answer: 'ARIA (Accessible Rich Internet Applications) attributes provide additional semantic information to assistive technologies. They help describe the role, state, and properties of elements that aren\'t natively accessible, such as custom widgets, dynamic content, and complex interactions. Examples include aria-label, aria-expanded, aria-selected, and aria-live.'
    },
    {
      id: 4,
      question: 'What is keyboard navigation and why is it important?',
      answer: 'Keyboard navigation allows users to navigate and interact with web content using only the keyboard, without a mouse or touch input. This is essential for users with motor disabilities, repetitive strain injuries, or those who prefer keyboard shortcuts. All interactive elements should be accessible via Tab, Enter, Space, and arrow keys.'
    },
    {
      id: 5,
      question: 'How can I test my website for accessibility?',
      answer: 'You can test accessibility using automated tools like axe-core, WAVE, or Lighthouse, but manual testing with actual assistive technologies is crucial. Test with screen readers, keyboard-only navigation, and users with disabilities. Follow WCAG guidelines and conduct regular accessibility audits throughout development.'
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
    // MISSING: Arrow key navigation between accordion items
  };

  return (
    <div style={{ fontFamily: 'Arial, sans-serif', maxWidth: '800px', margin: '50px auto', padding: '20px', backgroundColor: '#f5f5f5' }}>
      <div style={{ background: 'white', padding: '30px', borderRadius: '8px', boxShadow: '0 2px 10px rgba(0,0,0,0.1)' }}>
        <h1>FAQ Section</h1>
        <p>Browse through our frequently asked questions below.</p>
        
        <div style={{ marginTop: '30px' }}>
          <h2 style={{ marginBottom: '20px', color: '#333' }}>Frequently Asked Questions</h2>
          
          {/* Accordion Container - MISSING PROPER ARIA ATTRIBUTES */}
          <div
            role="region"
            aria-label="FAQ Accordion"
            style={{ border: '1px solid #ddd', borderRadius: '8px', overflow: 'hidden' }}
          >
            {faqItems.map((item, index) => {
              const isOpen = openItems.has(item.id);
              
              return (
                <div key={item.id} style={{ borderBottom: index < faqItems.length - 1 ? '1px solid #eee' : 'none' }}>
                  {/* Question Header - MISSING PROPER ARIA ATTRIBUTES */}
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
                    aria-expanded={isOpen}
                    aria-controls={`faq-answer-${item.id}`}
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
                      aria-hidden="true"
                    >
                      ▼
                    </span>
                  </button>
                  
                  {/* Answer Panel - MISSING PROPER ARIA ATTRIBUTES */}
                  <div
                    id={`faq-answer-${item.id}`}
                    style={{
                      maxHeight: isOpen ? '200px' : '0',
                      overflow: 'hidden',
                      transition: 'max-height 0.3s ease',
                      background: 'white'
                    }}
                    aria-labelledby={`faq-question-${item.id}`}
                    role="region"
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
        <h3>Accessibility Issues:</h3>
        <ul>
          <li><strong>Missing ARIA attributes:</strong> No aria-expanded, aria-controls, or aria-labelledby</li>
          <li><strong>No keyboard navigation:</strong> Arrow keys don't navigate between accordion items</li>
          <li><strong>Missing state announcements:</strong> Screen readers don't announce expand/collapse state changes</li>
          <li><strong>No focus management:</strong> Focus doesn't move appropriately when items expand/collapse</li>
          <li><strong>Missing role attributes:</strong> Accordion items lack proper semantic roles</li>
          <li><strong>No live region:</strong> Dynamic content changes not announced to screen readers</li>
        </ul>
        
        <h3>How to Fix:</h3>
        <ul>
          <li>Add <code>aria-expanded</code> to indicate open/closed state</li>
          <li>Use <code>aria-controls</code> to link buttons to their panels</li>
          <li>Add <code>aria-labelledby</code> to associate panels with their buttons</li>
          <li>Implement arrow key navigation (Up/Down) between items</li>
          <li>Add <code>role="button"</code> to expandable headers</li>
          <li>Use <code>aria-live="polite"</code> for state change announcements</li>
        </ul>
      </div>
    </div>
  );
};

export default AccordionWithoutState;
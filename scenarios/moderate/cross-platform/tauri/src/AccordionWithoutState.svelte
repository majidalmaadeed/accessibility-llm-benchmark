<script>
  import { onMount } from 'svelte';
  let expandedItems = new Set();
  const faqItems = [
    {
      id: 1,
    },
    {
      id: 2,
    },
    {
      id: 3,
      question: "What are the WCAG guidelines?",
    },
    {
      id: 4,
    }
  ];
  function toggleQuestion(index) {
    if (expandedItems.has(index)) {
      expandedItems.delete(index);
    } else {
      expandedItems.add(index);
    }
  }
  function handleKeyDown(event) {
    // Should handle Arrow keys to navigate between accordion items
    // Should handle Home/End keys to go to first/last item
    // Should handle Enter/Space to toggle items
    if (event.key === 'Enter' || event.key === ' ') {
      // Allow default button behavior
      return;
    } else if (event.key === 'ArrowDown') {
      event.preventDefault();
    } else if (event.key === 'ArrowUp') {
      event.preventDefault();
    } else if (event.key === 'Home') {
      event.preventDefault();
      const firstButton = document.querySelector('.accordion-header');
    } else if (event.key === 'End') {
      event.preventDefault();
      const lastButton = document.querySelector('.accordion-header:last-child');
    }
  }
  onMount(() => {
    document.addEventListener('keydown', handleKeyDown);
    return () => document.removeEventListener('keydown', handleKeyDown);
  });
</script>
  </div>
</div>
<style>
  .container {
    max-width: 600px;
    margin: 50px auto;
    padding: 20px;
  }
  .card {
    background: white;
    border-radius: 8px;
    box-shadow: 0 2px 10px rgba(0,0,0,0.1);
    padding: 30px;
  }
  h1 {
    font-size: 24px;
    font-weight: bold;
    margin-bottom: 10px;
    color: #333;
  }
  .description {
    color: #666;
    margin-bottom: 30px;
    font-size: 16px;
  }
  .accordion {
    margin-bottom: 30px;
  }
  .accordion-item {
    border: 1px solid #dee2e6;
    border-radius: 8px;
    margin-bottom: 10px;
    overflow: hidden;
  }
  .accordion-header {
    background-color: #f8f9fa;
    border: none;
    width: 100%;
    padding: 20px;
    text-align: left;
    cursor: pointer;
    font-size: 16px;
    font-weight: bold;
    color: #333;
    display: flex;
    justify-content: space-between;
    align-items: center;
    transition: background-color 0.3s;
  }
  .accordion-header:hover {
    background-color: #e9ecef;
  }
    outline: 2px solid #007bff;
    outline-offset: -2px;
  }
  .question-text {
    flex: 1;
    text-align: left;
  }
  .accordion-indicator {
    font-size: 14px;
    color: #666;
    transition: transform 0.3s;
    margin-left: 10px;
  }
  .accordion-indicator.expanded {
    transform: rotate(180deg);
  }
  .accordion-content {
    padding: 20px;
    background-color: white;
    border-top: 1px solid #dee2e6;
    color: #666;
    line-height: 1.6;
  }
    background-color: #e9ecef;
    border: 1px solid #dee2e6;
    border-radius: 4px;
    padding: 20px;
    margin-top: 30px;
  }
    font-size: 16px;
    font-weight: bold;
    margin-bottom: 15px;
    color: #333;
  }
    margin-left: 20px;
    margin-bottom: 15px;
  }
    margin-bottom: 5px;
    color: #666;
  }
</style>

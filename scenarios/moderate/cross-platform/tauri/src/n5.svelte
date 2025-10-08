<script>
  import { onMount } from 'svelte';
  }
  function handleKeyDown(event) {
    switch (event.key) {
      case 'ArrowRight':
        event.preventDefault();
        break;
      case 'ArrowLeft':
        event.preventDefault();
        break;
      case 'Home':
        event.preventDefault();
        break;
      case 'End':
        event.preventDefault();
        break;
      case 'Enter':
      case ' ':
        event.preventDefault();
        // Allow default button behavior
        break;
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
    border: 1px solid #dee2e6;
    border-radius: 8px;
    overflow: hidden;
  }
    display: flex;
    background-color: #f8f9fa;
    border-bottom: 1px solid #dee2e6;
  }
    background: none;
    border: none;
    padding: 15px 20px;
    font-size: 16px;
    font-weight: bold;
    color: #666;
    cursor: pointer;
    border-bottom: 3px solid transparent;
    transition: all 0.3s;
    min-width: 120px;
  }
    background-color: #e9ecef;
    color: #333;
  }
    outline: 2px solid #007bff;
    outline-offset: -2px;
  }
    color: #007bff;
    border-bottom-color: #007bff;
    background-color: white;
  }
    padding: 30px;
    display: none;
  }
    display: block;
  }
    font-size: 20px;
    font-weight: bold;
    margin-bottom: 20px;
    color: #333;
  }
  .form-group {
    margin-bottom: 20px;
  }
    display: block;
    font-weight: bold;
    margin-bottom: 8px;
    color: #333;
  }
  .checkbox-group {
    display: flex;
    align-items: center;
    margin-bottom: 15px;
  }
  .checkbox-group input[type="checkbox"] {
    width: auto;
    margin-right: 10px;
  }
  .form-group input,
  .form-group select {
    width: 100%;
    padding: 10px;
    border: 2px solid #ddd;
    border-radius: 4px;
    font-size: 14px;
  }
    outline: none;
    border-color: #007bff;
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

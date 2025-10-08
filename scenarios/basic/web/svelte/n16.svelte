<script>
  let isLoading = false;
  let loadingProgress = 0;
  let loadingMessage = '';
  let currentStep = 0;
  let isComplete = false;

  const loadingSteps = [
    { message: 'Initializing application...', duration: 1000 },
    { message: 'Loading user data...', duration: 1500 },
    { message: 'Fetching content...', duration: 2000 },
    { message: 'Processing information...', duration: 1000 },
    { message: 'Finalizing setup...', duration: 500 }
  ];

  function startLoading() {
    isLoading = true;
    isComplete = false;
    loadingProgress = 0;
    currentStep = 0;
    loadingMessage = loadingSteps[0].message;
    
    processLoadingSteps();
  }

  function processLoadingSteps() {
    if (currentStep >= loadingSteps.length) {
      completeLoading();
      return;
    }

    const step = loadingSteps[currentStep];
    loadingMessage = step.message;
    
    const stepDuration = step.duration;
    const progressIncrement = 100 / loadingSteps.length;
    const targetProgress = (currentStep + 1) * progressIncrement;
    
    const interval = setInterval(() => {
      loadingProgress += (progressIncrement / (stepDuration / 50));
      
      if (loadingProgress >= targetProgress) {
        loadingProgress = targetProgress;
        clearInterval(interval);
        currentStep++;
        setTimeout(processLoadingSteps, 100);
      }
    }, 50);
  }

  function completeLoading() {
    loadingProgress = 100;
    loadingMessage = 'Loading complete!';
    isComplete = true;
    
    setTimeout(() => {
      isLoading = false;
      isComplete = false;
      loadingProgress = 0;
    }, 2000);
  }

  function handleAction(action) {
    alert(`${action} action performed`);
  }
</script>

<div class="loading-demo">
  <header class="demo-header">
    <h1>Loading State Demo</h1>
    <p>Experience different loading states and progress indicators</p>
  </header>

  <div class="demo-controls">
    <button 
      class="demo-btn primary" 
      on:click={startLoading}
      disabled={isLoading}
    >
      {isLoading ? 'Loading...' : 'Start Loading Demo'}
    </button>
    
    <button 
      class="demo-btn secondary" 
      on:click={() => handleAction('Reset')}
      disabled={isLoading}
    >
      Reset
    </button>
  </div>

  {#if isLoading}
    <div class="loading-container">
      <div class="loading-content">
        <div class="loading-spinner">
          <div class="spinner"></div>
        </div>
        
        <div class="loading-info">
          <div class="loading-message">{loadingMessage}</div>
          <div class="loading-progress">
            <div class="progress-bar">
              <div class="progress-fill" style="width: {loadingProgress}%"></div>
            </div>
            <div class="progress-text">{Math.round(loadingProgress)}%</div>
          </div>
        </div>
      </div>
    </div>
  {/if}

  {#if isComplete}
    <div class="completion-message">
      <div class="success-icon">✅</div>
      <h3>Loading Complete!</h3>
      <p>All data has been successfully loaded and processed.</p>
    </div>
  {/if}

  <div class="demo-content">
    <h2>Loading State Features</h2>
    <div class="features-grid">
      <div class="feature-card">
        <div class="feature-icon">⏳</div>
        <h3>Progress Tracking</h3>
        <p>Visual progress bar shows loading completion percentage</p>
      </div>
      
      <div class="feature-card">
        <div class="feature-icon">💬</div>
        <h3>Status Messages</h3>
        <p>Clear messages inform users about current loading step</p>
      </div>
      
      <div class="feature-card">
        <div class="feature-icon">🎯</div>
        <h3>Step-by-Step</h3>
        <p>Loading process broken down into manageable steps</p>
      </div>
      
      <div class="feature-card">
        <div class="feature-icon">✨</div>
        <h3>Smooth Animation</h3>
        <p>Fluid animations provide visual feedback during loading</p>
      </div>
    </div>

    <div class="loading-examples">
      <h3>Different Loading States</h3>
      <div class="examples-grid">
        <div class="example-card">
          <h4>Spinner Loading</h4>
          <div class="example-spinner">
            <div class="spinner small"></div>
          </div>
          <p>Simple rotating spinner for quick operations</p>
        </div>
        
        <div class="example-card">
          <h4>Progress Bar</h4>
          <div class="example-progress">
            <div class="progress-bar">
              <div class="progress-fill" style="width: 65%"></div>
            </div>
            <span class="progress-text">65%</span>
          </div>
          <p>Progress bar with percentage for longer operations</p>
        </div>
        
        <div class="example-card">
          <h4>Dots Animation</h4>
          <div class="example-dots">
            <div class="dots">
              <span></span>
              <span></span>
              <span></span>
            </div>
          </div>
          <p>Animated dots for indeterminate loading states</p>
        </div>
      </div>
    </div>

        </div>
        
        <div class="info-item">
          <span class="info-icon">⏱️</span>
          <div class="info-text">
            <h4>Time Estimates</h4>
            <p>Provide estimated time remaining when possible</p>
          </div>
        </div>
        
        <div class="info-item">
          <span class="info-icon">🎯</span>
          <div class="info-text">
            <h4>Clear Messaging</h4>
            <p>Use descriptive text to explain what's happening</p>
          </div>
        </div>
        
        <div class="info-item">
          <span class="info-icon">⌨️</span>
          <div class="info-text">
            <h4>Keyboard Access</h4>
            <p>Ensure loading states don't trap keyboard focus</p>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<style>
  .loading-demo {
    max-width: 1200px;
    margin: 50px auto;
    padding: 20px;
    font-family: Arial, sans-serif;
  }

  .demo-header {
    text-align: center;
    margin-bottom: 40px;
  }

  .demo-header h1 {
    margin: 0 0 10px 0;
    font-size: 32px;
    color: #333;
  }

  .demo-header p {
    margin: 0;
    color: #666;
    font-size: 16px;
  }

  .demo-controls {
    display: flex;
    justify-content: center;
    gap: 15px;
    margin-bottom: 40px;
  }

  .demo-btn {
    padding: 12px 24px;
    border: none;
    border-radius: 6px;
    cursor: pointer;
    font-size: 16px;
    font-weight: bold;
    transition: all 0.2s ease;
  }

  .demo-btn.primary {
    background: #007bff;
    color: white;
  }

  .demo-btn.primary:hover:not(:disabled) {
    background: #0056b3;
  }

  .demo-btn.secondary {
    background: #6c757d;
    color: white;
  }

  .demo-btn.secondary:hover:not(:disabled) {
    background: #545b62;
  }

  .demo-btn:disabled {
    opacity: 0.6;
    cursor: not-allowed;
  }

  .loading-container {
    background: white;
    border-radius: 12px;
    box-shadow: 0 4px 16px rgba(0,0,0,0.1);
    padding: 40px;
    margin-bottom: 40px;
    text-align: center;
  }

  .loading-content {
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 30px;
  }

  .loading-spinner {
    position: relative;
  }

  .spinner {
    width: 60px;
    height: 60px;
    border: 4px solid #f3f3f3;
    border-top: 4px solid #007bff;
    border-radius: 50%;
    animation: spin 1s linear infinite;
  }

  .spinner.small {
    width: 30px;
    height: 30px;
    border-width: 3px;
  }

  @keyframes spin {
    0% { transform: rotate(0deg); }
    100% { transform: rotate(360deg); }
  }

  .loading-info {
    width: 100%;
    max-width: 400px;
  }

  .loading-message {
    font-size: 18px;
    color: #333;
    margin-bottom: 20px;
    font-weight: bold;
  }

  .loading-progress {
    display: flex;
    align-items: center;
    gap: 15px;
  }

  .progress-bar {
    flex: 1;
    height: 8px;
    background: #f0f0f0;
    border-radius: 4px;
    overflow: hidden;
  }

  .progress-fill {
    height: 100%;
    background: linear-gradient(90deg, #007bff, #0056b3);
    border-radius: 4px;
    transition: width 0.3s ease;
  }

  .progress-text {
    font-size: 14px;
    font-weight: bold;
    color: #007bff;
    min-width: 40px;
  }

  .completion-message {
    background: #d4edda;
    border: 1px solid #c3e6cb;
    border-radius: 8px;
    padding: 30px;
    text-align: center;
    margin-bottom: 40px;
  }

  .success-icon {
    font-size: 48px;
    margin-bottom: 15px;
  }

  .completion-message h3 {
    margin: 0 0 10px 0;
    color: #155724;
    font-size: 24px;
  }

  .completion-message p {
    margin: 0;
    color: #155724;
    font-size: 16px;
  }

  .demo-content h2 {
    margin: 0 0 30px 0;
    font-size: 28px;
    color: #333;
  }

  .features-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
    gap: 20px;
    margin-bottom: 40px;
  }

  .feature-card {
    background: white;
    padding: 25px;
    border-radius: 8px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.1);
    text-align: center;
  }

  .feature-icon {
    font-size: 32px;
    margin-bottom: 15px;
  }

  .feature-card h3 {
    margin: 0 0 10px 0;
    font-size: 18px;
    color: #333;
  }

  .feature-card p {
    margin: 0;
    color: #666;
    font-size: 14px;
    line-height: 1.4;
  }

  .loading-examples {
    background: #f8f9fa;
    padding: 30px;
    border-radius: 8px;
    margin-bottom: 40px;
  }

  .loading-examples h3 {
    margin: 0 0 25px 0;
    font-size: 24px;
    color: #333;
  }

  .examples-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
    gap: 20px;
  }

  .example-card {
    background: white;
    padding: 20px;
    border-radius: 6px;
    text-align: center;
  }

  .example-card h4 {
    margin: 0 0 15px 0;
    font-size: 16px;
    color: #333;
  }

  .example-spinner,
  .example-progress,
  .example-dots {
    margin-bottom: 15px;
    display: flex;
    justify-content: center;
    align-items: center;
  }

  .example-progress {
    flex-direction: column;
    gap: 10px;
  }

  .example-dots {
    height: 30px;
  }

  .dots {
    display: flex;
    gap: 4px;
  }

  .dots span {
    width: 8px;
    height: 8px;
    background: #007bff;
    border-radius: 50%;
    animation: bounce 1.4s ease-in-out infinite both;
  }

  .dots span:nth-child(1) { animation-delay: -0.32s; }
  .dots span:nth-child(2) { animation-delay: -0.16s; }

  @keyframes bounce {
    0%, 80%, 100% {
      transform: scale(0);
    }
    40% {
      transform: scale(1);
    }
  }

  .example-card p {
    margin: 0;
    color: #666;
    font-size: 12px;
    line-height: 1.4;
  }

  .info-panel {
    background: white;
    padding: 30px;
    border-radius: 8px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.1);
  }

  .info-panel h3 {
    margin: 0 0 25px 0;
    font-size: 24px;
    color: #333;
  }

  .info-content {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
    gap: 20px;
  }

  .info-item {
    display: flex;
    gap: 15px;
    align-items: flex-start;
  }

  .info-icon {
    font-size: 24px;
    flex-shrink: 0;
  }

  .info-text h4 {
    margin: 0 0 5px 0;
    font-size: 16px;
    color: #333;
  }

  .info-text p {
    margin: 0;
    color: #666;
    font-size: 14px;
    line-height: 1.4;
  }

  @media (max-width: 768px) {
    .demo-controls {
      flex-direction: column;
      align-items: center;
    }

    .demo-btn {
      width: 200px;
    }

    .loading-content {
      gap: 20px;
    }

    .loading-progress {
      flex-direction: column;
      gap: 10px;
    }

    .progress-text {
      min-width: auto;
    }
  }
</style>

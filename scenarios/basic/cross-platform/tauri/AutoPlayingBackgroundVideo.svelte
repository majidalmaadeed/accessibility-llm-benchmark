<script>
  import { onMount, onDestroy } from 'svelte';
  
  let currentSlide = 0;
  let slides = [
    {
      id: 1,
      title: 'Welcome to Our Platform',
      description: 'Discover amazing features and services designed to help you succeed.',
      video: 'hero-video.mp4',
      cta: 'Get Started'
    },
    {
      id: 2,
      title: 'Advanced Analytics',
      description: 'Get insights into your data with our powerful analytics dashboard.',
      video: 'analytics-video.mp4',
      cta: 'View Dashboard'
    },
    {
      id: 3,
      title: 'Team Collaboration',
      description: 'Work together seamlessly with our collaboration tools.',
      video: 'team-video.mp4',
      cta: 'Join Team'
    }
  ];
  
  let isPlaying = true;
  let isMuted = true;
  let currentVideo = null;
  
  onMount(() => {
    startSlideshow();
  });
  
  onDestroy(() => {
    if (currentVideo) {
      currentVideo.pause();
    }
  });
  
  function startSlideshow() {
    setInterval(() => {
      currentSlide = (currentSlide + 1) % slides.length;
    }, 5000); // Change slide every 5 seconds
  }
  
  function nextSlide() {
    currentSlide = (currentSlide + 1) % slides.length;
  }
  
  function prevSlide() {
    currentSlide = currentSlide === 0 ? slides.length - 1 : currentSlide - 1;
  }
  
  function goToSlide(index) {
    currentSlide = index;
  }
  
  function togglePlayPause() {
    isPlaying = !isPlaying;
    if (currentVideo) {
      if (isPlaying) {
        currentVideo.play();
      } else {
        currentVideo.pause();
      }
    }
  }
  
  function toggleMute() {
    isMuted = !isMuted;
    if (currentVideo) {
      currentVideo.muted = isMuted;
    }
  }
  
  function handleVideoLoad(event) {
    currentVideo = event.target;
    if (isPlaying) {
      currentVideo.play();
    }
    currentVideo.muted = isMuted;
  }
  
  function handleCTA() {
    alert('CTA clicked!');
  }
</script>

<div class="hero-carousel">
  <div class="carousel-container">
    {#each slides as slide, index}
      <div class="slide {index === currentSlide ? 'active' : ''}">
        <div class="slide-content">
          <!-- AUTOPLAYING BACKGROUND VIDEO - Hero section video autoplays without user control -->
          <video 
            class="background-video" 
            autoplay 
            muted 
            loop 
            playsinline
            on:loadeddata={handleVideoLoad}
          >
            <source src={slide.video} type="video/mp4" />
            Your browser does not support the video tag.
          </video>
          
          <div class="video-overlay"></div>
          
          <div class="slide-text">
            <h2 class="slide-title">{slide.title}</h2>
            <p class="slide-description">{slide.description}</p>
            <button class="slide-cta" on:click={handleCTA}>
              {slide.cta}
            </button>
          </div>
        </div>
      </div>
    {/each}
  </div>
  
  <div class="carousel-controls">
    <button class="control-btn prev" on:click={prevSlide}>
      ◀️
    </button>
    
    <div class="slide-indicators">
      {#each slides as _, index}
        <button 
          class="indicator {index === currentSlide ? 'active' : ''}" 
          on:click={() => goToSlide(index)}
        >
          {index + 1}
        </button>
      {/each}
    </div>
    
    <button class="control-btn next" on:click={nextSlide}>
      ▶️
    </button>
  </div>
  
  <div class="video-controls">
    <button class="video-control-btn" on:click={togglePlayPause}>
      {isPlaying ? '⏸️' : '▶️'}
    </button>
    <button class="video-control-btn" on:click={toggleMute}>
      {isMuted ? '🔇' : '🔊'}
    </button>
  </div>
</div>

<div class="content-section">
  <div class="container">
    <h2 class="section-title">Why Choose Our Platform?</h2>
    <div class="features-grid">
      <div class="feature-card">
        <div class="feature-icon">🚀</div>
        <h3 class="feature-title">Fast Performance</h3>
        <p class="feature-description">
          Our platform delivers lightning-fast performance for all users with optimized code and infrastructure.
        </p>
      </div>
      
      <div class="feature-card">
        <div class="feature-icon">🔒</div>
        <h3 class="feature-title">Secure & Reliable</h3>
        <p class="feature-description">
          Enterprise-grade security with 99.9% uptime guarantee and advanced encryption.
        </p>
      </div>
      
      <div class="feature-card">
        <div class="feature-icon">📱</div>
        <h3 class="feature-title">Mobile Ready</h3>
        <p class="feature-description">
          Fully responsive design that works perfectly on all devices and screen sizes.
        </p>
      </div>
      
      <div class="feature-card">
        <div class="feature-icon">🎯</div>
        <h3 class="feature-title">Easy to Use</h3>
        <p class="feature-description">
          Intuitive interface designed for users of all skill levels with comprehensive documentation.
        </p>
      </div>
    </div>
  </div>
</div>

<div class="testimonial-section">
  <div class="container">
    <h2 class="section-title">What Our Customers Say</h2>
    <div class="testimonials-grid">
      <div class="testimonial-card">
        <div class="testimonial-content">
          <p class="testimonial-text">
            "This platform has completely transformed how we manage our projects. The interface is intuitive and the performance is outstanding."
          </p>
          <div class="testimonial-author">
            <div class="author-avatar">👤</div>
            <div class="author-info">
              <div class="author-name">Sarah Johnson</div>
              <div class="author-title">Project Manager</div>
            </div>
          </div>
        </div>
      </div>
      
      <div class="testimonial-card">
        <div class="testimonial-content">
          <p class="testimonial-text">
            "The analytics dashboard provides insights we never had before. It's been a game-changer for our business."
          </p>
          <div class="testimonial-author">
            <div class="author-avatar">👤</div>
            <div class="author-info">
              <div class="author-name">Mike Chen</div>
              <div class="author-title">Data Analyst</div>
            </div>
          </div>
        </div>
      </div>
      
      <div class="testimonial-card">
        <div class="testimonial-content">
          <p class="testimonial-text">
            "The collaboration features have made our team more productive than ever. Highly recommended!"
          </p>
          <div class="testimonial-author">
            <div class="author-avatar">👤</div>
            <div class="author-info">
              <div class="author-name">Emily Davis</div>
              <div class="author-title">Team Lead</div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<div class="cta-section">
  <div class="container">
    <div class="cta-content">
      <h2 class="cta-title">Ready to Get Started?</h2>
      <p class="cta-description">
        Join thousands of satisfied customers and experience the power of our platform.
      </p>
      <div class="cta-actions">
        <button class="cta-btn primary" on:click={() => alert('Sign Up clicked')}>
          Sign Up Free
        </button>
        <button class="cta-btn secondary" on:click={() => alert('Learn More clicked')}>
          Learn More
        </button>
      </div>
    </div>
  </div>
</div>

<style>
  .hero-carousel {
    position: relative;
    height: 100vh;
    overflow: hidden;
    font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
  }
  
  .carousel-container {
    position: relative;
    width: 100%;
    height: 100%;
  }
  
  .slide {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    opacity: 0;
    transition: opacity 0.5s ease-in-out;
  }
  
  .slide.active {
    opacity: 1;
  }
  
  .slide-content {
    position: relative;
    width: 100%;
    height: 100%;
    display: flex;
    align-items: center;
    justify-content: center;
  }
  
  /* AUTOPLAYING BACKGROUND VIDEO - Hero section video autoplays without user control */
  .background-video {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    object-fit: cover;
    z-index: 1;
  }
  
  .video-overlay {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: rgba(0, 0, 0, 0.4);
    z-index: 2;
  }
  
  .slide-text {
    position: relative;
    z-index: 3;
    text-align: center;
    color: white;
    max-width: 800px;
    padding: 0 20px;
  }
  
  .slide-title {
    font-size: 48px;
    font-weight: bold;
    margin: 0 0 20px 0;
    text-shadow: 2px 2px 4px rgba(0,0,0,0.5);
  }
  
  .slide-description {
    font-size: 24px;
    margin: 0 0 30px 0;
    opacity: 0.9;
    text-shadow: 1px 1px 2px rgba(0,0,0,0.5);
  }
  
  .slide-cta {
    background: white;
    color: #333;
    border: none;
    padding: 15px 30px;
    border-radius: 8px;
    font-size: 18px;
    font-weight: bold;
    cursor: pointer;
    transition: all 0.2s;
  }
  
  .slide-cta:hover {
    background: #f8f9fa;
    transform: translateY(-2px);
  }
  
  .carousel-controls {
    position: absolute;
    bottom: 30px;
    left: 50%;
    transform: translateX(-50%);
    display: flex;
    align-items: center;
    gap: 20px;
    z-index: 4;
  }
  
  .control-btn {
    background: rgba(255, 255, 255, 0.2);
    color: white;
    border: none;
    width: 50px;
    height: 50px;
    border-radius: 50%;
    font-size: 20px;
    cursor: pointer;
    transition: all 0.2s;
    display: flex;
    align-items: center;
    justify-content: center;
  }
  
  .control-btn:hover {
    background: rgba(255, 255, 255, 0.3);
    transform: scale(1.1);
  }
  
  .slide-indicators {
    display: flex;
    gap: 10px;
  }
  
  .indicator {
    background: rgba(255, 255, 255, 0.3);
    color: white;
    border: none;
    width: 40px;
    height: 40px;
    border-radius: 50%;
    font-size: 16px;
    font-weight: bold;
    cursor: pointer;
    transition: all 0.2s;
  }
  
  .indicator.active {
    background: white;
    color: #333;
  }
  
  .indicator:hover {
    background: rgba(255, 255, 255, 0.5);
  }
  
  .video-controls {
    position: absolute;
    top: 30px;
    right: 30px;
    display: flex;
    gap: 10px;
    z-index: 4;
  }
  
  .video-control-btn {
    background: rgba(0, 0, 0, 0.5);
    color: white;
    border: none;
    width: 40px;
    height: 40px;
    border-radius: 50%;
    font-size: 16px;
    cursor: pointer;
    transition: all 0.2s;
    display: flex;
    align-items: center;
    justify-content: center;
  }
  
  .video-control-btn:hover {
    background: rgba(0, 0, 0, 0.7);
  }
  
  .content-section {
    padding: 80px 0;
    background: #f8f9fa;
  }
  
  .container {
    max-width: 1200px;
    margin: 0 auto;
    padding: 0 20px;
  }
  
  .section-title {
    font-size: 32px;
    font-weight: bold;
    color: #333;
    text-align: center;
    margin: 0 0 50px 0;
  }
  
  .features-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
    gap: 30px;
  }
  
  .feature-card {
    background: white;
    border-radius: 12px;
    padding: 30px;
    text-align: center;
    box-shadow: 0 4px 12px rgba(0,0,0,0.1);
    transition: transform 0.2s;
  }
  
  .feature-card:hover {
    transform: translateY(-4px);
  }
  
  .feature-icon {
    font-size: 48px;
    margin-bottom: 20px;
  }
  
  .feature-title {
    font-size: 24px;
    font-weight: bold;
    color: #333;
    margin: 0 0 15px 0;
  }
  
  .feature-description {
    font-size: 16px;
    color: #666;
    line-height: 1.6;
    margin: 0;
  }
  
  .testimonial-section {
    padding: 80px 0;
    background: white;
  }
  
  .testimonials-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
    gap: 30px;
  }
  
  .testimonial-card {
    background: #f8f9fa;
    border-radius: 12px;
    padding: 30px;
    box-shadow: 0 4px 12px rgba(0,0,0,0.1);
  }
  
  .testimonial-content {
    text-align: center;
  }
  
  .testimonial-text {
    font-size: 18px;
    color: #333;
    line-height: 1.6;
    margin: 0 0 20px 0;
    font-style: italic;
  }
  
  .testimonial-author {
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 15px;
  }
  
  .author-avatar {
    width: 50px;
    height: 50px;
    background: #007bff;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    color: white;
    font-size: 20px;
  }
  
  .author-name {
    font-weight: bold;
    color: #333;
    font-size: 16px;
  }
  
  .author-title {
    color: #666;
    font-size: 14px;
  }
  
  .cta-section {
    padding: 80px 0;
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    color: white;
  }
  
  .cta-content {
    text-align: center;
    max-width: 600px;
    margin: 0 auto;
  }
  
  .cta-title {
    font-size: 36px;
    font-weight: bold;
    margin: 0 0 20px 0;
  }
  
  .cta-description {
    font-size: 18px;
    margin: 0 0 30px 0;
    opacity: 0.9;
  }
  
  .cta-actions {
    display: flex;
    gap: 20px;
    justify-content: center;
  }
  
  .cta-btn {
    padding: 15px 30px;
    border: none;
    border-radius: 8px;
    font-size: 18px;
    font-weight: bold;
    cursor: pointer;
    transition: all 0.2s;
  }
  
  .cta-btn.primary {
    background: white;
    color: #667eea;
  }
  
  .cta-btn.primary:hover {
    background: #f8f9fa;
    transform: translateY(-2px);
  }
  
  .cta-btn.secondary {
    background: transparent;
    color: white;
    border: 2px solid white;
  }
  
  .cta-btn.secondary:hover {
    background: white;
    color: #667eea;
  }
  
  @media (max-width: 768px) {
    .slide-title {
      font-size: 36px;
    }
    
    .slide-description {
      font-size: 20px;
    }
    
    .cta-actions {
      flex-direction: column;
      align-items: center;
    }
    
    .cta-btn {
      width: 200px;
    }
  }
</style>

<script>
  import { onMount } from 'svelte';
  
  let currentSlide = 0;
  let slides = [
    {
      id: 1,
      title: 'Welcome to Our Platform',
      description: 'Discover amazing features and services designed to help you succeed.',
      image: 'hero-bg.jpg',
      cta: 'Get Started'
    },
    {
      id: 2,
      title: 'Advanced Analytics',
      description: 'Get insights into your data with our powerful analytics dashboard.',
      image: 'analytics-bg.jpg',
      cta: 'View Dashboard'
    },
    {
      id: 3,
      title: 'Team Collaboration',
      description: 'Work together seamlessly with our collaboration tools.',
      image: 'team-bg.jpg',
      cta: 'Join Team'
    }
  ];
  
  function nextSlide() {
    currentSlide = (currentSlide + 1) % slides.length;
  }
  
  function prevSlide() {
    currentSlide = currentSlide === 0 ? slides.length - 1 : currentSlide - 1;
  }
  
  function goToSlide(index) {
    currentSlide = index;
  }
  
  function handleCTA() {
    alert('CTA clicked!');
  }
</script>

<div class="carousel-container">
  <div class="carousel">
    {#each slides as slide, index}
      <div class="slide {index === currentSlide ? 'active' : ''}">
        <div class="slide-content">
          
          <img src="decorative-border.png" alt="Decorative border pattern with intricate geometric designs and floral motifs" class="decorative-border" />
          
          <div class="slide-main">
            <div class="slide-image-container">
              <img src={slide.image} alt="Background image for {slide.title}" class="slide-image" />
            </div>
            
            <div class="slide-text">
              <h2 class="slide-title">{slide.title}</h2>
              <p class="slide-description">{slide.description}</p>
              <button class="slide-cta" on:click={handleCTA}>
                {slide.cta}
              </button>
            </div>
          </div>

          <img src="decorative-border.png" alt="Decorative border pattern with intricate geometric designs and floral motifs" class="decorative-border" />
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
  
  <div class="carousel-features">
    <div class="feature-item">
      
      <img src="decorative-icon.png" alt="Decorative icon with ornate frame and decorative elements" class="feature-icon" />
      <span class="feature-text">Premium Quality</span>
    </div>
    
    <div class="feature-item">
      
      <img src="decorative-icon.png" alt="Decorative icon with ornate frame and decorative elements" class="feature-icon" />
      <span class="feature-text">24/7 Support</span>
    </div>
    
    <div class="feature-item">
      
      <img src="decorative-icon.png" alt="Decorative icon with ornate frame and decorative elements" class="feature-icon" />
      <span class="feature-text">Easy Setup</span>
    </div>
  </div>
</div>

<style>
  .carousel-container {
    max-width: 1200px;
    margin: 0 auto;
    font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
  }
  
  .carousel {
    position: relative;
    height: 500px;
    overflow: hidden;
    border-radius: 12px;
    box-shadow: 0 8px 24px rgba(0,0,0,0.15);
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
    flex-direction: column;
    align-items: center;
    justify-content: center;
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    color: white;
  }
  
  .decorative-border {
    width: 100%;
    height: 20px;
    object-fit: cover;
    opacity: 0.3;
  }
  
  .slide-main {
    flex: 1;
    display: flex;
    align-items: center;
    justify-content: center;
    width: 100%;
    padding: 40px;
  }
  
  .slide-image-container {
    flex: 1;
    max-width: 400px;
    margin-right: 40px;
  }
  
  .slide-image {
    width: 100%;
    height: 300px;
    object-fit: cover;
    border-radius: 8px;
    box-shadow: 0 4px 12px rgba(0,0,0,0.2);
  }
  
  .slide-text {
    flex: 1;
    max-width: 400px;
  }
  
  .slide-title {
    font-size: 36px;
    font-weight: bold;
    margin: 0 0 20px 0;
  }
  
  .slide-description {
    font-size: 18px;
    line-height: 1.6;
    margin: 0 0 30px 0;
    opacity: 0.9;
  }
  
  .slide-cta {
    background: white;
    color: #667eea;
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
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 20px;
    margin: 20px 0;
  }
  
  .control-btn {
    background: #007bff;
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
    background: #0056b3;
    transform: scale(1.1);
  }
  
  .slide-indicators {
    display: flex;
    gap: 10px;
  }
  
  .indicator {
    background: #ddd;
    color: #666;
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
    background: #007bff;
    color: white;
  }
  
  .indicator:hover {
    background: #007bff;
    color: white;
  }
  
  .carousel-features {
    display: flex;
    justify-content: center;
    gap: 40px;
    margin-top: 30px;
    padding: 20px;
    background: #f8f9fa;
    border-radius: 8px;
  }
  
  .feature-item {
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 10px;
  }
  
  .feature-icon {
    width: 40px;
    height: 40px;
    object-fit: contain;
  }
  
  .feature-text {
    font-size: 14px;
    font-weight: bold;
    color: #333;
    text-align: center;
  }
  
  @media (max-width: 768px) {
    .slide-main {
      flex-direction: column;
      text-align: center;
    }
    
    .slide-image-container {
      margin-right: 0;
      margin-bottom: 20px;
    }
    
    .slide-title {
      font-size: 28px;
    }
    
    .slide-description {
      font-size: 16px;
    }
    
    .carousel-features {
      flex-direction: column;
      gap: 20px;
    }
  }
</style>

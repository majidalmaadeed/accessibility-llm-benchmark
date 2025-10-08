import React, { useState, useEffect } from 'react';

const CarouselWithoutControls = () => {
  const [currentSlide, setCurrentSlide] = useState(0);
  const [isAutoPlaying, setIsAutoPlaying] = useState(true);

  const slides = [
    {
      id: 1,
      title: 'Welcome to Our Platform',
      description: 'Discover amazing features and tools designed to enhance your productivity.',
      image: 'https://via.placeholder.com/800x400/007bff/ffffff?text=Slide+1',
      cta: 'Get Started'
    },
    {
      id: 2,
      title: 'Advanced Analytics',
      description: 'Track your progress with detailed insights and comprehensive reporting.',
      image: 'https://via.placeholder.com/800x400/28a745/ffffff?text=Slide+2',
      cta: 'View Analytics'
    },
    {
      id: 3,
      title: 'Team Collaboration',
      description: 'Work together seamlessly with our powerful collaboration tools.',
      image: 'https://via.placeholder.com/800x400/dc3545/ffffff?text=Slide+3',
      cta: 'Join Team'
    },
    {
      id: 4,
      title: 'Mobile Ready',
      description: 'Access your data and tools from anywhere with our mobile-optimized interface.',
      image: 'https://via.placeholder.com/800x400/ffc107/000000?text=Slide+4',
      cta: 'Download App'
    }
  ];

  const nextSlide = () => {
    setCurrentSlide((prev) => (prev + 1) % slides.length);
  };

  const prevSlide = () => {
    setCurrentSlide((prev) => (prev - 1 + slides.length) % slides.length);
  };

  const goToSlide = (index) => {
    setCurrentSlide(index);
  };

  // Auto-play functionality
  useEffect(() => {
    if (!isAutoPlaying) return;

    const interval = setInterval(() => {
      nextSlide();
    }, 5000);

    return () => clearInterval(interval);
  }, [isAutoPlaying]);

  const handleMouseEnter = () => {
    setIsAutoPlaying(false);
  };

  const handleMouseLeave = () => {
    setIsAutoPlaying(true);
  };

  return (
    <div style={{ fontFamily: 'Arial, sans-serif', maxWidth: '1000px', margin: '50px auto', padding: '20px', backgroundColor: '#f5f5f5' }}>
      <div style={{ background: 'white', padding: '30px', borderRadius: '8px', boxShadow: '0 2px 10px rgba(0,0,0,0.1)' }}>
        <h1>Featured Content</h1>
        <p>Explore our latest features and announcements.</p>
        
        <div style={{ marginTop: '30px' }}>
          {/* Carousel Container */}
          <div
            style={{
              position: 'relative',
              overflow: 'hidden',
              borderRadius: '8px',
              backgroundColor: '#000'
            }}
            onMouseEnter={handleMouseEnter}
            onMouseLeave={handleMouseLeave}
          >
            {/* Slides */}
            <div
              style={{
                display: 'flex',
                transition: 'transform 0.5s ease-in-out',
                transform: `translateX(-${currentSlide * 100}%)`
              }}
            >
              {slides.map((slide, index) => (
                <div
                  key={slide.id}
                  style={{
                    minWidth: '100%',
                    position: 'relative',
                    height: '400px',
                    backgroundImage: `url(${slide.image})`,
                    backgroundSize: 'cover',
                    backgroundPosition: 'center',
                    display: 'flex',
                    alignItems: 'center',
                    justifyContent: 'center'
                  }}
                >
                  <div style={{
                    background: 'rgba(0, 0, 0, 0.6)',
                    color: 'white',
                    padding: '40px',
                    borderRadius: '8px',
                    textAlign: 'center',
                    maxWidth: '600px'
                  }}>
                    <h2 style={{ margin: '0 0 16px 0', fontSize: '32px', fontWeight: 'bold' }}>
                      {slide.title}
                    </h2>
                    <p style={{ margin: '0 0 24px 0', fontSize: '18px', lineHeight: '1.6' }}>
                      {slide.description}
                    </p>
                    <button
                      style={{
                        backgroundColor: '#007bff',
                        color: 'white',
                        padding: '12px 24px',
                        border: 'none',
                        borderRadius: '4px',
                        fontSize: '16px',
                        cursor: 'pointer',
                        fontWeight: 'bold'
                      }}
                    >
                      {slide.cta}
                    </button>
                  </div>
                </div>
              ))}
            </div>

            {/* Previous Button */}
            <button
              onClick={prevSlide}
              style={{
                position: 'absolute',
                left: '20px',
                top: '50%',
                transform: 'translateY(-50%)',
                background: 'rgba(0, 0, 0, 0.5)',
                color: 'white',
                border: 'none',
                borderRadius: '50%',
                width: '50px',
                height: '50px',
                fontSize: '20px',
                cursor: 'pointer',
                display: 'flex',
                alignItems: 'center',
                justifyContent: 'center'
              }}
            >
              ‹
            </button>

            {/* Next Button */}
            <button
              onClick={nextSlide}
              style={{
                position: 'absolute',
                right: '20px',
                top: '50%',
                transform: 'translateY(-50%)',
                background: 'rgba(0, 0, 0, 0.5)',
                color: 'white',
                border: 'none',
                borderRadius: '50%',
                width: '50px',
                height: '50px',
                fontSize: '20px',
                cursor: 'pointer',
                display: 'flex',
                alignItems: 'center',
                justifyContent: 'center'
              }}
            >
              ›
            </button>
          </div>

          {/* Slide Indicators */}
          <div style={{
            display: 'flex',
            justifyContent: 'center',
            gap: '8px',
            marginTop: '20px'
          }}>
            {slides.map((_, index) => (
              <button
                key={index}
                onClick={() => goToSlide(index)}
                style={{
                  width: '12px',
                  height: '12px',
                  borderRadius: '50%',
                  border: 'none',
                  backgroundColor: currentSlide === index ? '#007bff' : '#ddd',
                  cursor: 'pointer',
                  transition: 'background-color 0.3s ease'
                }}
              />
            ))}
          </div>

          {/* Auto-play Toggle */}
          <div style={{
            display: 'flex',
            justifyContent: 'center',
            alignItems: 'center',
            gap: '8px',
            marginTop: '20px'
          }}>
            <button
              onClick={() => setIsAutoPlaying(!isAutoPlaying)}
              style={{
                background: 'none',
                border: 'none',
                cursor: 'pointer',
                fontSize: '16px',
                color: '#666'
              }}
            >
              {isAutoPlaying ? '⏸️' : '▶️'}
            </button>
            <span style={{ color: '#666', fontSize: '14px' }}>
              {isAutoPlaying ? 'Auto-play enabled' : 'Auto-play paused'}
            </span>
          </div>
        </div>

        {/* Additional Content */}
        <div style={{ marginTop: '40px', padding: '20px', backgroundColor: '#f8f9fa', borderRadius: '4px' }}>
          <h3>About This Carousel</h3>
          <p>This carousel showcases our key features and announcements. Use the navigation buttons or indicators to explore different slides.</p>
        </div>
      </div>
    </div>
  );
};

export default CarouselWithoutControls;
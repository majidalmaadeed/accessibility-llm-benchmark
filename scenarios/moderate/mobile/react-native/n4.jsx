import React, { useState, useEffect } from 'react';
const CarouselWithoutControls = () => {
  const [currentIndex, setCurrentIndex] = useState(0);
  const [isAutoPlaying, setIsAutoPlaying] = useState(true);
  const images = [
    {
      id: 1,
      src: 'https://via.placeholder.com/600x400/007bff/ffffff?text=Image+1',
      title: 'Mountain Landscape',
      description: 'A stunning view of snow-capped mountains at sunset'
    },
    {
      id: 2,
      src: 'https://via.placeholder.com/600x400/28a745/ffffff?text=Image+2',
      title: 'Autumn Forest',
      description: 'A peaceful walking path through colorful autumn trees'
    },
    {
      id: 3,
      src: 'https://via.placeholder.com/600x400/dc3545/ffffff?text=Image+3',
      title: 'Ocean Sunset',
      description: 'Calm ocean waves reflecting the golden sunset sky'
    },
    {
      id: 4,
      src: 'https://via.placeholder.com/600x400/ffc107/000000?text=Image+4',
      title: 'City Nightscape',
      description: 'Urban cityscape illuminated by city lights'
    },
    {
      id: 5,
      src: 'https://via.placeholder.com/600x400/6f42c1/ffffff?text=Image+5',
      title: 'Desert Dawn',
      description: 'Sand dunes stretching to the horizon at sunrise'
    }
  ];
  useEffect(() => {
    if (isAutoPlaying) {
      const interval = setInterval(() => {
        setCurrentIndex((prevIndex) => (prevIndex + 1) % images.length);
      }, 3000);
      return () => clearInterval(interval);
    }
  }, [isAutoPlaying, images.length]);
  const goToPrevious = () => {
    setCurrentIndex((prevIndex) => 
      prevIndex === 0 ? images.length - 1 : prevIndex - 1
    );
  };
  const goToNext = () => {
    setCurrentIndex((prevIndex) => (prevIndex + 1) % images.length);
  };
  const goToSlide = (index) => {
    setCurrentIndex(index);
  };
  const toggleAutoPlay = () => {
    setIsAutoPlaying(!isAutoPlaying);
  };
  const handleKeyDown = (e) => {
    if (e.key === 'ArrowLeft') {
      goToPrevious();
    } else if (e.key === 'ArrowRight') {
      goToNext();
    } else if (e.key === 'Home') {
      goToSlide(0);
    } else if (e.key === 'End') {
      goToSlide(images.length - 1);
    }
  };
  return (
      <div style={{ background: 'white', padding: '30px', borderRadius: '8px', boxShadow: '0 2px 10px rgba(0,0,0,0.1)' }}>
        <h1>Image Gallery</h1>
        <div 
          style={{ marginBottom: '30px' }}
          onKeyDown={handleKeyDown}
        >
          {/* Carousel Container */}
          <div style={{ position: 'relative', marginBottom: '20px' }}>
            {}
            <button
              onClick={goToPrevious}
              style={{
                position: 'absolute',
                left: '10px',
                top: '50%',
                transform: 'translateY(-50%)',
                background: 'rgba(0,0,0,0.7)',
                color: 'white',
                border: 'none',
                borderRadius: '50%',
                width: '50px',
                height: '50px',
                fontSize: '20px',
                cursor: 'pointer',
                zIndex: 2,
                display: 'flex',
                alignItems: 'center',
                justifyContent: 'center'
              }}
            >
              ‹
            </button>
            {/* Image Display */}
            <div style={{ position: 'relative', overflow: 'hidden', borderRadius: '8px' }}>
              <img
                src={images[currentIndex].src}
                style={{
                  width: '100%',
                  height: '400px',
                  objectFit: 'cover',
                  display: 'block'
                }}
              />
              {/* Image Info Overlay */}
              <div style={{
                position: 'absolute',
                bottom: '0',
                left: '0',
                right: '0',
                background: 'linear-gradient(transparent, rgba(0,0,0,0.8))',
                color: 'white',
                padding: '20px'
              }}>
                <h3 style={{ margin: '0 0 8px 0', fontSize: '24px' }}>
                  {images[currentIndex].title}
                </h3>
                <p style={{ margin: '0', fontSize: '16px', opacity: 0.9 }}>
                  {images[currentIndex].description}
                </p>
              </div>
            </div>
            {}
            <button
              onClick={goToNext}
              style={{
                position: 'absolute',
                right: '10px',
                top: '50%',
                transform: 'translateY(-50%)',
                background: 'rgba(0,0,0,0.7)',
                color: 'white',
                border: 'none',
                borderRadius: '50%',
                width: '50px',
                height: '50px',
                fontSize: '20px',
                cursor: 'pointer',
                zIndex: 2,
                display: 'flex',
                alignItems: 'center',
                justifyContent: 'center'
              }}
            >
              ›
            </button>
          </div>
          {}
          <div style={{ display: 'flex', justifyContent: 'center', gap: '8px' }}>
            {images.map((_, index) => (
              <button
                key={index}
                onClick={() => goToSlide(index)}
                style={{
                  width: '12px',
                  height: '12px',
                  borderRadius: '50%',
                  border: 'none',
                  background: index === currentIndex ? '#007bff' : '#ccc',
                  cursor: 'pointer',
                  transition: 'background-color 0.3s ease'
                }}
              />
            ))}
          </div>
          {/* Controls */}
          <div style={{ display: 'flex', justifyContent: 'center', gap: '16px', marginTop: '20px' }}>
            <button
              onClick={toggleAutoPlay}
              style={{
                background: isAutoPlaying ? '#dc3545' : '#28a745',
                color: 'white',
                border: 'none',
                padding: '8px 16px',
                borderRadius: '4px',
                cursor: 'pointer',
                fontSize: '14px'
              }}
            >
              {isAutoPlaying ? 'Pause' : 'Play'}
            </button>
            <div style={{ 
              display: 'flex', 
              alignItems: 'center', 
              gap: '8px',
              fontSize: '14px',
              color: '#666'
            }}>
              <span>Slide {currentIndex + 1} of {images.length}</span>
            </div>
          </div>
        </div>
        {}
        <div style={{ 
          position: 'absolute', 
          left: '-10000px', 
          width: '1px', 
          height: '1px', 
          overflow: 'hidden' 
        }}>
            {images[currentIndex].title} - {images[currentIndex].description}
          </span>
        </div>
      </div>
      <div style={{ marginTop: '30px', padding: '20px', backgroundColor: '#e9ecef', borderRadius: '4px' }}>
      </div>
    </div>
  );
};
export default CarouselWithoutControls;
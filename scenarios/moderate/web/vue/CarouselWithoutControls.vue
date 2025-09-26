<template>
  <div class="carousel-container">
    <div class="main-content">
      <h1>Image Gallery</h1>
      <p>Browse through our image gallery using the navigation controls.</p>
      
      <div 
        class="carousel-wrapper"
        @keydown="handleKeyDown"
        tabindex="0"
        role="region"
        aria-label="Image carousel"
        aria-live="polite"
      >
        <!-- Carousel Container -->
        <div class="carousel-container-inner">
          <!-- Previous Button -->
          <button
            @click="goToPrevious"
            class="nav-button prev-button"
            aria-label="Previous image"
          >
            ‹
          </button>

          <!-- Image Display -->
          <div class="image-container">
            <img
              :src="images[currentIndex].src"
              :alt="images[currentIndex].alt"
              class="carousel-image"
            />
            
            <!-- Image Info Overlay -->
            <div class="image-overlay">
              <h3 class="image-title">{{ images[currentIndex].title }}</h3>
              <p class="image-description">{{ images[currentIndex].description }}</p>
            </div>
          </div>

          <!-- Next Button -->
          <button
            @click="goToNext"
            class="nav-button next-button"
            aria-label="Next image"
          >
            ›
          </button>
        </div>

        <!-- Slide Indicators -->
        <div class="indicators">
          <button
            v-for="(_, index) in images"
            :key="index"
            @click="goToSlide(index)"
            class="indicator"
            :class="{ active: index === currentIndex }"
            :aria-label="`Go to slide ${index + 1}`"
            :aria-current="index === currentIndex ? 'true' : 'false'"
          />
        </div>

        <!-- Controls -->
        <div class="controls">
          <button
            @click="toggleAutoPlay"
            class="control-button"
            :class="{ 'pause': isAutoPlaying, 'play': !isAutoPlaying }"
          >
            {{ isAutoPlaying ? 'Pause' : 'Play' }}
          </button>
          
          <div class="slide-info">
            <span>Slide {{ currentIndex + 1 }} of {{ images.length }}</span>
          </div>
        </div>
      </div>
    </div>

    <div class="accessibility-info">
      <h3>Accessibility Issues:</h3>
      <ul>
        <li><strong>Missing keyboard navigation:</strong> Arrow keys don't work properly for carousel navigation</li>
        <li><strong>No focus management:</strong> Focus doesn't move to carousel when activated</li>
        <li><strong>Missing ARIA attributes:</strong> No aria-roledescription or proper carousel semantics</li>
        <li><strong>No screen reader announcements:</strong> Slide changes not announced to screen readers</li>
        <li><strong>Missing live region:</strong> No aria-live region for dynamic content updates</li>
        <li><strong>Incomplete button semantics:</strong> Navigation buttons lack proper carousel context</li>
      </ul>
      
      <h3>How to Fix:</h3>
      <ul>
        <li>Add <code>aria-roledescription="carousel"</code> to carousel container</li>
        <li>Implement proper arrow key navigation (Left/Right)</li>
        <li>Add <code>aria-live="polite"</code> region for slide announcements</li>
        <li>Use <code>aria-current="true"</code> for active slide indicator</li>
        <li>Add <code>aria-label</code> with slide position information</li>
        <li>Implement focus management when carousel is activated</li>
      </ul>
    </div>
  </div>
</template>

<script>
import { ref, onMounted, onUnmounted } from 'vue'

export default {
  name: 'CarouselWithoutControls',
  setup() {
    const currentIndex = ref(0)
    const isAutoPlaying = ref(true)

    const images = [
      {
        id: 1,
        src: 'https://via.placeholder.com/600x400/007bff/ffffff?text=Image+1',
        alt: 'Beautiful landscape with mountains',
        title: 'Mountain Landscape',
        description: 'A stunning view of snow-capped mountains at sunset'
      },
      {
        id: 2,
        src: 'https://via.placeholder.com/600x400/28a745/ffffff?text=Image+2',
        alt: 'Forest path in autumn',
        title: 'Autumn Forest',
        description: 'A peaceful walking path through colorful autumn trees'
      },
      {
        id: 3,
        src: 'https://via.placeholder.com/600x400/dc3545/ffffff?text=Image+3',
        alt: 'Ocean waves at sunset',
        title: 'Ocean Sunset',
        description: 'Calm ocean waves reflecting the golden sunset sky'
      },
      {
        id: 4,
        src: 'https://via.placeholder.com/600x400/ffc107/000000?text=Image+4',
        alt: 'City skyline at night',
        title: 'City Nightscape',
        description: 'Urban cityscape illuminated by city lights'
      },
      {
        id: 5,
        src: 'https://via.placeholder.com/600x400/6f42c1/ffffff?text=Image+5',
        alt: 'Desert dunes at dawn',
        title: 'Desert Dawn',
        description: 'Sand dunes stretching to the horizon at sunrise'
      }
    ]

    let autoPlayInterval = null

    const goToPrevious = () => {
      currentIndex.value = currentIndex.value === 0 ? images.length - 1 : currentIndex.value - 1
    }

    const goToNext = () => {
      currentIndex.value = (currentIndex.value + 1) % images.length
    }

    const goToSlide = (index) => {
      currentIndex.value = index
    }

    const toggleAutoPlay = () => {
      isAutoPlaying.value = !isAutoPlaying.value
    }

    const handleKeyDown = (e) => {
      if (e.key === 'ArrowLeft') {
        goToPrevious()
      } else if (e.key === 'ArrowRight') {
        goToNext()
      } else if (e.key === 'Home') {
        goToSlide(0)
      } else if (e.key === 'End') {
        goToSlide(images.length - 1)
      }
    }

    onMounted(() => {
      if (isAutoPlaying.value) {
        autoPlayInterval = setInterval(() => {
          goToNext()
        }, 3000)
      }
    })

    onUnmounted(() => {
      if (autoPlayInterval) {
        clearInterval(autoPlayInterval)
      }
    })

    return {
      currentIndex,
      isAutoPlaying,
      images,
      goToPrevious,
      goToNext,
      goToSlide,
      toggleAutoPlay,
      handleKeyDown
    }
  }
}
</script>

<style scoped>
.carousel-container {
  font-family: Arial, sans-serif;
  max-width: 800px;
  margin: 50px auto;
  padding: 20px;
  background-color: #f5f5f5;
}

.main-content {
  background: white;
  padding: 30px;
  border-radius: 8px;
  box-shadow: 0 2px 10px rgba(0,0,0,0.1);
}

.carousel-wrapper {
  margin-bottom: 30px;
}

.carousel-container-inner {
  position: relative;
  margin-bottom: 20px;
}

.nav-button {
  position: absolute;
  top: 50%;
  transform: translateY(-50%);
  background: rgba(0,0,0,0.7);
  color: white;
  border: none;
  border-radius: 50%;
  width: 50px;
  height: 50px;
  font-size: 20px;
  cursor: pointer;
  z-index: 2;
  display: flex;
  align-items: center;
  justify-content: center;
}

.prev-button {
  left: 10px;
}

.next-button {
  right: 10px;
}

.image-container {
  position: relative;
  overflow: hidden;
  border-radius: 8px;
}

.carousel-image {
  width: 100%;
  height: 400px;
  object-fit: cover;
  display: block;
}

.image-overlay {
  position: absolute;
  bottom: 0;
  left: 0;
  right: 0;
  background: linear-gradient(transparent, rgba(0,0,0,0.8));
  color: white;
  padding: 20px;
}

.image-title {
  margin: 0 0 8px 0;
  font-size: 24px;
}

.image-description {
  margin: 0;
  font-size: 16px;
  opacity: 0.9;
}

.indicators {
  display: flex;
  justify-content: center;
  gap: 8px;
}

.indicator {
  width: 12px;
  height: 12px;
  border-radius: 50%;
  border: none;
  background: #ccc;
  cursor: pointer;
  transition: background-color 0.3s ease;
}

.indicator.active {
  background: #007bff;
}

.controls {
  display: flex;
  justify-content: center;
  gap: 16px;
  margin-top: 20px;
}

.control-button {
  background: #007bff;
  color: white;
  border: none;
  padding: 8px 16px;
  border-radius: 4px;
  cursor: pointer;
  font-size: 14px;
}

.control-button.pause {
  background: #dc3545;
}

.control-button.play {
  background: #28a745;
}

.slide-info {
  display: flex;
  align-items: center;
  gap: 8px;
  font-size: 14px;
  color: #666;
}

.accessibility-info {
  margin-top: 30px;
  padding: 20px;
  background-color: #e9ecef;
  border-radius: 4px;
}

.accessibility-info h3 {
  margin-top: 0;
}

.accessibility-info ul {
  margin-bottom: 20px;
}

.accessibility-info li {
  margin-bottom: 8px;
}
</style>
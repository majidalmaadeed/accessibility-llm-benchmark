<template>
  </div>
</template>
<script>
export default {
  name: 'CarouselWithoutControls',
  data() {
    return {
      currentIndex: 0,
      isAutoPlaying: true,
      images: [
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
      ]
    }
  },
  mounted() {
    if (this.isAutoPlaying) {
      this.autoPlayInterval = setInterval(() => {
        this.goToNext()
      }, 3000)
    }
  },
  beforeDestroy() {
    if (this.autoPlayInterval) {
      clearInterval(this.autoPlayInterval)
    }
  },
  methods: {
    goToPrevious() {
      this.currentIndex = this.currentIndex === 0 ? this.images.length - 1 : this.currentIndex - 1
    },
    goToNext() {
      this.currentIndex = (this.currentIndex + 1) % this.images.length
    },
    goToSlide(index) {
      this.currentIndex = index
    },
    toggleAutoPlay() {
      this.isAutoPlaying = !this.isAutoPlaying
      if (this.isAutoPlaying) {
        this.autoPlayInterval = setInterval(() => {
          this.goToNext()
        }, 3000)
      } else {
        clearInterval(this.autoPlayInterval)
      }
    },
    handleKeyDown(e) {
      if (e.key === 'ArrowLeft') {
        this.goToPrevious()
      } else if (e.key === 'ArrowRight') {
        this.goToNext()
      } else if (e.key === 'Home') {
        this.goToSlide(0)
      } else if (e.key === 'End') {
        this.goToSlide(this.images.length - 1)
      }
    }
  }
}
</script>
<style scoped>
.carousel-container {
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
  margin-top: 30px;
  padding: 20px;
  background-color: #e9ecef;
  border-radius: 4px;
}
  margin-top: 0;
}
  margin-bottom: 20px;
}
  margin-bottom: 8px;
}
</style>
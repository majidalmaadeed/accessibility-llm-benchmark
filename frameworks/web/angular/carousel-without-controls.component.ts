import { Component, OnInit, OnDestroy } from '@angular/core';

@Component({
  selector: 'app-carousel-without-controls',
  template: `
    <div class="main-container">
      <div class="main-content">
        <h1>Featured Content</h1>
        <p>Explore our latest features and announcements.</p>
        
        <div class="carousel-section">
          <!-- Carousel Container -->
          <div class="carousel-container" (mouseenter)="pauseAutoPlay()" (mouseleave)="resumeAutoPlay()">
            <!-- Slides -->
            <div class="slides-container" [style.transform]="'translateX(-' + currentSlide * 100 + '%)'">
              <div
                *ngFor="let slide of slides"
                class="slide"
                [style.background-image]="'url(' + slide.image + ')'"
              >
                <div class="slide-content">
                  <h2>{{ slide.title }}</h2>
                  <p>{{ slide.description }}</p>
                  <button class="cta-button">{{ slide.cta }}</button>
                </div>
              </div>
            </div>

            <!-- Previous Button -->
            <button (click)="prevSlide()" class="nav-button prev-button">‹</button>

            <!-- Next Button -->
            <button (click)="nextSlide()" class="nav-button next-button">›</button>
          </div>

          <!-- Slide Indicators -->
          <div class="indicators">
            <button
              *ngFor="let slide of slides; let i = index"
              (click)="goToSlide(i)"
              [class.active]="currentSlide === i"
              class="indicator"
            />
          </div>

          <!-- Auto-play Toggle -->
          <div class="auto-play-controls">
            <button (click)="toggleAutoPlay()" class="toggle-button">
              {{ isAutoPlaying ? '⏸️' : '▶️' }}
            </button>
            <span class="status-text">
              {{ isAutoPlaying ? 'Auto-play enabled' : 'Auto-play paused' }}
            </span>
          </div>
        </div>

        <!-- Additional Content -->
        <div class="additional-info">
          <h3>About This Carousel</h3>
          <p>This carousel showcases our key features and announcements. Use the navigation buttons or indicators to explore different slides.</p>
        </div>
      </div>
    </div>
  `,
  styles: [`
    .main-container {
      font-family: Arial, sans-serif;
      max-width: 1000px;
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

    .carousel-section {
      margin-top: 30px;
    }

    .carousel-container {
      position: relative;
      overflow: hidden;
      border-radius: 8px;
      background-color: #000;
    }

    .slides-container {
      display: flex;
      transition: transform 0.5s ease-in-out;
    }

    .slide {
      min-width: 100%;
      position: relative;
      height: 400px;
      background-size: cover;
      background-position: center;
      display: flex;
      align-items: center;
      justify-content: center;
    }

    .slide-content {
      background: rgba(0, 0, 0, 0.6);
      color: white;
      padding: 40px;
      border-radius: 8px;
      text-align: center;
      max-width: 600px;
    }

    .slide-content h2 {
      margin: 0 0 16px 0;
      font-size: 32px;
      font-weight: bold;
    }

    .slide-content p {
      margin: 0 0 24px 0;
      font-size: 18px;
      line-height: 1.6;
    }

    .cta-button {
      background-color: #007bff;
      color: white;
      padding: 12px 24px;
      border: none;
      border-radius: 4px;
      font-size: 16px;
      cursor: pointer;
      font-weight: bold;
    }

    .cta-button:hover {
      background-color: #0056b3;
    }

    .nav-button {
      position: absolute;
      top: 50%;
      transform: translateY(-50%);
      background: rgba(0, 0, 0, 0.5);
      color: white;
      border: none;
      border-radius: 50%;
      width: 50px;
      height: 50px;
      font-size: 20px;
      cursor: pointer;
      display: flex;
      align-items: center;
      justify-content: center;
    }

    .prev-button {
      left: 20px;
    }

    .next-button {
      right: 20px;
    }

    .nav-button:hover {
      background: rgba(0, 0, 0, 0.7);
    }

    .indicators {
      display: flex;
      justify-content: center;
      gap: 8px;
      margin-top: 20px;
    }

    .indicator {
      width: 12px;
      height: 12px;
      border-radius: 50%;
      border: none;
      background-color: #ddd;
      cursor: pointer;
      transition: background-color 0.3s ease;
    }

    .indicator.active {
      background-color: #007bff;
    }

    .indicator:hover {
      background-color: #999;
    }

    .auto-play-controls {
      display: flex;
      justify-content: center;
      align-items: center;
      gap: 8px;
      margin-top: 20px;
    }

    .toggle-button {
      background: none;
      border: none;
      cursor: pointer;
      font-size: 16px;
      color: #666;
    }

    .status-text {
      color: #666;
      font-size: 14px;
    }

    .additional-info {
      margin-top: 40px;
      padding: 20px;
      background-color: #f8f9fa;
      border-radius: 4px;
    }
  `]
})
export class CarouselWithoutControlsComponent implements OnInit, OnDestroy {
  currentSlide = 0;
  isAutoPlaying = true;
  private intervalRef: any;

  slides = [
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

  ngOnInit() {
    this.startAutoPlay();
  }

  ngOnDestroy() {
    this.stopAutoPlay();
  }

  nextSlide() {
    this.currentSlide = (this.currentSlide + 1) % this.slides.length;
  }

  prevSlide() {
    this.currentSlide = (this.currentSlide - 1 + this.slides.length) % this.slides.length;
  }

  goToSlide(index: number) {
    this.currentSlide = index;
  }

  pauseAutoPlay() {
    this.isAutoPlaying = false;
  }

  resumeAutoPlay() {
    this.isAutoPlaying = true;
  }

  toggleAutoPlay() {
    this.isAutoPlaying = !this.isAutoPlaying;
  }

  private startAutoPlay() {
    this.intervalRef = setInterval(() => {
      if (this.isAutoPlaying) {
        this.nextSlide();
      }
    }, 5000);
  }

  private stopAutoPlay() {
    if (this.intervalRef) {
      clearInterval(this.intervalRef);
    }
  }
}
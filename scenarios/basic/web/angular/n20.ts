import { Component } from '@angular/core';

@Component({
  selector: 'app-unlabeled-media-button',
  template: `
    <div class="video-player">
      <h1>Video Player</h1>
      <p>Watch our latest tutorial video.</p>
      
      <div class="video-container">
        <!-- Video placeholder -->
        <div class="video-placeholder">
          Video Content Placeholder
        </div>
        
        <!-- Video controls - play button with only emoji icon, no accessible name -->
        <div class="video-controls">
          <button
            (click)="togglePlayPause()"
            class="play-button"
          >
            {{ isPlaying ? '⏸️' : '▶️' }}
          </button>
          
          <div class="status-text">
            {{ isPlaying ? 'Paused' : 'Playing' }}
          </div>
        </div>
      </div>
    </div>
  `,
  styles: [`
    .video-player {
      max-width: 600px;
      margin: 50px auto;
      padding: 20px;
      font-family: Arial, sans-serif;
    }

    .video-container {
      background: #000;
      border-radius: 8px;
      padding: 20px;
      margin-bottom: 20px;
    }

    .video-placeholder {
      width: 100%;
      height: 300px;
      background: linear-gradient(45deg, #333, #666);
      border-radius: 4px;
      display: flex;
      align-items: center;
      justify-content: center;
      color: white;
      font-size: 18px;
      margin-bottom: 20px;
    }

    .video-controls {
      display: flex;
      align-items: center;
      gap: 15px;
    }

    .play-button {
      background: #ff6b6b;
      border: none;
      border-radius: 50%;
      width: 60px;
      height: 60px;
      display: flex;
      align-items: center;
      justify-content: center;
      cursor: pointer;
      font-size: 24px;
    }

    .status-text {
      color: white;
      font-size: 14px;
    }
  `]
})
export class UnlabeledMediaButtonComponent {
  isPlaying = false;

  togglePlayPause() {
    this.isPlaying = !this.isPlaying;
  }
}

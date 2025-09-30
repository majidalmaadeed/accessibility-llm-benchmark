import { Component, OnInit, OnDestroy } from '@angular/core';

@Component({
  selector: 'app-flashing-advertisement',
  template: `
    <div class="news-website">
      <h1>News Website</h1>
      <p>Stay informed with the latest news and updates from around the world.</p>
      
      <!-- Sale banner flashing 5 times per second -->
      <div *ngIf="showAd" class="ad-banner" [class.flashing]="isFlashing">
        <button (click)="closeAd()" class="close-btn">×</button>
        
        <h2>🔥 LIMITED TIME OFFER! 🔥</h2>
        <p>Get 50% OFF on Premium Subscription</p>
        <div class="ad-controls">
          <button class="claim-btn">CLAIM OFFER NOW</button>
        </div>
      </div>

      <div class="articles-grid">
        <article class="article-card">
          <h2>Breaking: New Technology Breakthrough</h2>
          <p>
            Scientists have made a significant breakthrough in quantum computing that 
            could revolutionize how we process information and solve complex problems.
          </p>
          <div class="article-footer">
            <span class="publish-time">2 hours ago</span>
            <button class="read-more-btn">Read More</button>
          </div>
        </article>

        <article class="article-card">
          <h2>Market Update: Stocks Reach New High</h2>
          <p>
            The stock market has reached new all-time highs as investors show 
            confidence in the economic recovery and technological innovation.
          </p>
          <div class="article-footer">
            <span class="publish-time">4 hours ago</span>
            <button class="read-more-btn">Read More</button>
          </div>
        </article>
      </div>

      <div class="newsletter-section">
        <h2>Subscribe to Our Newsletter</h2>
        <p>Get the latest news delivered directly to your inbox.</p>
        
        <div class="newsletter-form">
          <input 
            type="email" 
            placeholder="Enter your email address"
            class="email-input"
          />
          <button class="subscribe-btn">Subscribe</button>
        </div>
      </div>
    </div>
  `,
  styles: [`
    .news-website {
      max-width: 1000px;
      margin: 50px auto;
      padding: 20px;
      font-family: Arial, sans-serif;
    }

    .ad-banner {
      position: relative;
      background: #ff4444;
      color: white;
      padding: 20px;
      border-radius: 8px;
      margin-bottom: 30px;
      text-align: center;
      box-shadow: 0 4px 12px rgba(255, 68, 68, 0.3);
      transition: background-color 0.2s ease;
    }

    .ad-banner.flashing {
      background: #ff6b6b;
    }

    .close-btn {
      position: absolute;
      top: 10px;
      right: 15px;
      background: rgba(255,255,255,0.2);
      color: white;
      border: none;
      border-radius: 50%;
      width: 30px;
      height: 30px;
      cursor: pointer;
      font-size: 16px;
      font-weight: bold;
    }

    .ad-banner h2 {
      margin: 0 0 10px 0;
      font-size: 24px;
      font-weight: bold;
    }

    .ad-banner p {
      margin: 0 0 15px 0;
      font-size: 18px;
    }

    .ad-controls {
      display: flex;
      justify-content: center;
      align-items: center;
      gap: 20px;
      flex-wrap: wrap;
    }

    .claim-btn {
      background: white;
      color: #ff4444;
      border: none;
      padding: 12px 24px;
      border-radius: 25px;
      font-size: 16px;
      font-weight: bold;
      cursor: pointer;
      box-shadow: 0 2px 8px rgba(0,0,0,0.2);
    }

    .articles-grid {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
      gap: 30px;
      margin-bottom: 30px;
    }

    .article-card {
      background: white;
      padding: 25px;
      border-radius: 8px;
      box-shadow: 0 2px 8px rgba(0,0,0,0.1);
      border: 1px solid #e0e0e0;
    }

    .article-card h2 {
      font-size: 22px;
      margin: 0 0 15px 0;
      color: #333;
    }

    .article-card p {
      font-size: 16px;
      line-height: 1.6;
      color: #666;
      margin: 0 0 20px 0;
    }

    .article-footer {
      display: flex;
      justify-content: space-between;
      align-items: center;
    }

    .publish-time {
      font-size: 14px;
      color: #999;
    }

    .read-more-btn {
      background: #007bff;
      color: white;
      border: none;
      padding: 8px 16px;
      border-radius: 4px;
      cursor: pointer;
      font-size: 14px;
    }

    .newsletter-section {
      background: #f8f9fa;
      padding: 30px;
      border-radius: 8px;
      text-align: center;
    }

    .newsletter-section h2 {
      font-size: 24px;
      margin: 0 0 15px 0;
      color: #333;
    }

    .newsletter-section p {
      font-size: 16px;
      margin: 0 0 25px 0;
      color: #666;
    }

    .newsletter-form {
      display: flex;
      gap: 10px;
      justify-content: center;
      flex-wrap: wrap;
    }

    .email-input {
      padding: 12px 16px;
      border: 1px solid #ddd;
      border-radius: 4px;
      font-size: 16px;
      min-width: 250px;
    }

    .subscribe-btn {
      background: #28a745;
      color: white;
      border: none;
      padding: 12px 24px;
      border-radius: 4px;
      cursor: pointer;
      font-size: 16px;
    }
  `]
})
export class FlashingAdvertisementComponent implements OnInit, OnDestroy {
  isFlashing = true;
  showAd = true;
  private flashInterval: any;

  ngOnInit() {
    // Flash every 200ms (5 times per second)
    this.flashInterval = setInterval(() => {
      if (this.showAd) {
        this.isFlashing = !this.isFlashing;
      }
    }, 200);
  }

  ngOnDestroy() {
    if (this.flashInterval) {
      clearInterval(this.flashInterval);
    }
  }

  closeAd() {
    this.showAd = false;
  }
}

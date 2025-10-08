import { Component } from '@angular/core';

@Component({
  selector: 'app-small-touch-target',
  template: `
    <div class="article-page">
      <h1>Article: "The Future of Web Development"</h1>
      
      <div class="article-content">
        <p>
          Web development is evolving rapidly with new frameworks, tools, and methodologies 
          emerging every year. This article explores the latest trends and technologies 
          that are shaping the future of web development.
        </p>
      </div>

      <div class="author-info">
        <h2>Author Information</h2>
        <div class="author-details">
          <div class="author-avatar">JS</div>
          <div>
            <h3>John Smith</h3>
            <p>Senior Web Developer at TechCorp</p>
          </div>
        </div>
      </div>

      <!-- Social share buttons with small touch targets (20x20px) -->
      <div class="social-actions">
        <div class="social-buttons">
          <button
            (click)="toggleLike()"
            [class]="['social-btn', 'like-btn', { active: liked }]"
          >
            ❤️
          </button>
          
          <button
            (click)="toggleShare()"
            [class]="['social-btn', 'share-btn', { active: shared }]"
          >
            📤
          </button>
          
          <button
            (click)="toggleBookmark()"
            [class]="['social-btn', 'bookmark-btn', { active: bookmarked }]"
          >
            🔖
          </button>
        </div>
        
        <div class="publish-info">
          Published 2 hours ago
        </div>
      </div>
    </div>
  `,
  styles: [`
    .article-page {
      max-width: 600px;
      margin: 50px auto;
      padding: 20px;
      font-family: Arial, sans-serif;
    }

    .article-content {
      background: #f8f9fa;
      padding: 20px;
      border-radius: 8px;
      margin-bottom: 30px;
    }

    .article-content p {
      font-size: 16px;
      line-height: 1.6;
      margin: 0 0 20px 0;
      color: #333;
    }

    .author-info {
      background: #e3f2fd;
      padding: 20px;
      border-radius: 8px;
      margin-bottom: 30px;
    }

    .author-info h2 {
      margin: 0 0 15px 0;
    }

    .author-details {
      display: flex;
      align-items: center;
      gap: 15px;
    }

    .author-avatar {
      width: 50px;
      height: 50px;
      border-radius: 50%;
      background: #2196f3;
      display: flex;
      align-items: center;
      justify-content: center;
      color: white;
      font-size: 20px;
      font-weight: bold;
    }

    .author-details h3 {
      margin: 0 0 5px 0;
      font-size: 18px;
    }

    .author-details p {
      margin: 0;
      color: #666;
      font-size: 14px;
    }

    .social-actions {
      display: flex;
      justify-content: space-between;
      align-items: center;
      padding: 20px;
      background: white;
      border: 1px solid #ddd;
      border-radius: 8px;
    }

    .social-buttons {
      display: flex;
      gap: 5px;
    }

    .social-btn {
      background: transparent;
      border: 1px solid;
      padding: 2px;
      border-radius: 4px;
      cursor: pointer;
      font-size: 12px;
      width: 20px;
      height: 20px;
      display: flex;
      align-items: center;
      justify-content: center;
    }

    .like-btn {
      color: #e91e63;
      border-color: #e91e63;
    }

    .like-btn.active {
      background: #e91e63;
      color: white;
    }

    .share-btn {
      color: #2196f3;
      border-color: #2196f3;
    }

    .share-btn.active {
      background: #2196f3;
      color: white;
    }

    .bookmark-btn {
      color: #ff9800;
      border-color: #ff9800;
    }

    .bookmark-btn.active {
      background: #ff9800;
      color: white;
    }

    .publish-info {
      font-size: 12px;
      color: #666;
    }
  `]
})
export class SmallTouchTargetComponent {
  liked = false;
  shared = false;
  bookmarked = false;

  toggleLike() {
    this.liked = !this.liked;
  }

  toggleShare() {
    this.shared = !this.shared;
  }

  toggleBookmark() {
    this.bookmarked = !this.bookmarked;
  }
}

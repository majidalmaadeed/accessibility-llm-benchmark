import { Component } from '@angular/core';

@Component({
  selector: 'app-decorative-image-with-alt-text',
  template: `
    <div class="blog-page">
      <h1>Company Blog</h1>
      <p>Stay updated with our latest news and insights.</p>
      
      <!-- Decorative border image with unnecessary descriptive alt text -->
      <div class="decorative-border">
        <img 
          src="https://via.placeholder.com/800x4/cccccc/ffffff?text=Decorative+Border"
          alt="Decorative border line separating content sections with elegant design"
          class="border-image"
        />
      </div>

      <div class="articles-grid">
        <article class="article-card">
          <h2>The Future of Web Development</h2>
          
          <!-- Decorative corner image with unnecessary alt text -->
          <div class="decorative-corner">
            <img 
              src="https://via.placeholder.com/20x20/ff6b6b/ffffff?text=★"
              alt="Decorative star icon in the top-right corner indicating featured content"
              class="corner-icon"
            />
          </div>
          
          <p>
            Web development is evolving rapidly with new technologies and frameworks 
            emerging every year. This article explores the latest trends and what 
            developers need to know to stay ahead.
          </p>
          
          <div class="article-footer">
            <span class="publish-date">Published 2 days ago</span>
            <button class="read-more-btn">Read More</button>
          </div>
        </article>

        <article class="article-card">
          <h2>Cybersecurity Best Practices</h2>
          
          <!-- Another decorative corner image with unnecessary alt text -->
          <div class="decorative-corner">
            <img 
              src="https://via.placeholder.com/20x20/4caf50/ffffff?text=✓"
              alt="Decorative checkmark icon indicating verified and trusted content"
              class="corner-icon"
            />
          </div>
          
          <p>
            With cyber threats becoming more sophisticated, organizations must 
            implement robust security measures to protect their data and systems. 
            This guide provides essential cybersecurity strategies.
          </p>
          
          <div class="article-footer">
            <span class="publish-date">Published 1 week ago</span>
            <button class="read-more-btn">Read More</button>
          </div>
        </article>
      </div>

      <!-- Decorative separator with unnecessary alt text -->
      <div class="decorative-separator">
        <img 
          src="https://via.placeholder.com/200x2/dddddd/ffffff?text=---"
          alt="Decorative horizontal line separator between content sections with subtle design"
          class="separator-image"
        />
      </div>

      <div class="newsletter-section">
        <h2>Newsletter Signup</h2>
        <p>Get the latest articles delivered to your inbox.</p>
        
        <div class="newsletter-form">
          <input 
            type="email" 
            placeholder="Enter your email"
            class="email-input"
          />
          <button class="subscribe-btn">Subscribe</button>
        </div>
      </div>
    </div>
  `,
  styles: [`
    .blog-page {
      max-width: 800px;
      margin: 50px auto;
      padding: 20px;
      font-family: Arial, sans-serif;
    }

    .decorative-border {
      margin-bottom: 30px;
    }

    .border-image {
      width: 100%;
      height: 4px;
      display: block;
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
      position: relative;
    }

    .article-card h2 {
      font-size: 22px;
      margin: 0 0 15px 0;
      color: #333;
    }

    .decorative-corner {
      position: absolute;
      top: -10px;
      right: -10px;
    }

    .corner-icon {
      width: 20px;
      height: 20px;
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

    .publish-date {
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

    .decorative-separator {
      text-align: center;
      margin: 40px 0;
    }

    .separator-image {
      width: 200px;
      height: 2px;
      display: inline-block;
    }

    .newsletter-section {
      background: #f8f9fa;
      padding: 30px;
      border-radius: 8px;
      text-align: center;
    }

    .newsletter-section h2 {
      font-size: 28px;
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
export class DecorativeImageWithAltTextComponent {
}

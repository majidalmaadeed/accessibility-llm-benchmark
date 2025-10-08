import { Component } from '@angular/core';

@Component({
  selector: 'app-missing-language-attribute',
  template: `
    <div class="multilingual-website">
      <!-- Language selector -->
      <div class="language-selector">
        <select
          [(ngModel)]="selectedLanguage"
          class="language-dropdown"
        >
          <option value="en">English</option>
          <option value="fr">Français</option>
        </select>
      </div>

      <!-- Hero section with mixed English/French content without lang attributes -->
      <div class="hero-section">
        <h1>{{ currentContent.title }}</h1>
        <p>{{ currentContent.subtitle }}</p>
        <button class="cta-button">{{ currentContent.button }}</button>
      </div>

      <!-- Main content -->
      <div class="content-grid">
        <div class="content-card">
          <h2>About Us</h2>
          <p>{{ currentContent.description }}</p>
        </div>

        <div class="content-card">
          <h2>Our Services</h2>
          <ul>
            <li>Web Development</li>
            <li>Mobile App Development</li>
            <li>Cloud Solutions</li>
            <li>Digital Marketing</li>
          </ul>
        </div>
      </div>

      <!-- Contact section -->
      <div class="contact-section">
        <h2>Get in Touch</h2>
        <p>Ready to get started? Contact us today for more information.</p>
        <div class="contact-buttons">
          <button class="btn-primary">Contact Us</button>
          <button class="btn-secondary">View Portfolio</button>
        </div>
      </div>
    </div>
  `,
  styles: [`
    .multilingual-website {
      max-width: 1000px;
      margin: 50px auto;
      padding: 20px;
      font-family: Arial, sans-serif;
    }

    .language-selector {
      display: flex;
      justify-content: flex-end;
      margin-bottom: 30px;
    }

    .language-dropdown {
      padding: 8px 12px;
      border: 1px solid #ddd;
      border-radius: 4px;
      font-size: 14px;
    }

    .hero-section {
      background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
      color: white;
      padding: 60px 40px;
      border-radius: 12px;
      text-align: center;
      margin-bottom: 40px;
    }

    .hero-section h1 {
      font-size: 48px;
      margin: 0 0 20px 0;
      font-weight: bold;
    }

    .hero-section p {
      font-size: 20px;
      margin: 0 0 30px 0;
      opacity: 0.9;
    }

    .cta-button {
      background: white;
      color: #667eea;
      border: none;
      padding: 15px 30px;
      border-radius: 25px;
      font-size: 16px;
      font-weight: bold;
      cursor: pointer;
      box-shadow: 0 4px 15px rgba(0,0,0,0.2);
    }

    .content-grid {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
      gap: 30px;
      margin-bottom: 40px;
    }

    .content-card {
      background: white;
      padding: 30px;
      border-radius: 8px;
      box-shadow: 0 2px 10px rgba(0,0,0,0.1);
    }

    .content-card h2 {
      font-size: 24px;
      margin: 0 0 15px 0;
      color: #333;
    }

    .content-card p {
      font-size: 16px;
      line-height: 1.6;
      color: #666;
      margin: 0;
    }

    .content-card ul {
      margin: 0;
      padding-left: 20px;
      font-size: 16px;
      line-height: 1.8;
      color: #666;
    }

    .contact-section {
      background: #f8f9fa;
      padding: 40px;
      border-radius: 8px;
      text-align: center;
    }

    .contact-section h2 {
      font-size: 28px;
      margin: 0 0 20px 0;
      color: #333;
    }

    .contact-section p {
      font-size: 16px;
      margin: 0 0 30px 0;
      color: #666;
    }

    .contact-buttons {
      display: flex;
      gap: 15px;
      justify-content: center;
      flex-wrap: wrap;
    }

    .btn-primary {
      background: #007bff;
      color: white;
      border: none;
      padding: 12px 24px;
      border-radius: 4px;
      cursor: pointer;
      font-size: 16px;
    }

    .btn-secondary {
      background: transparent;
      color: #007bff;
      border: 2px solid #007bff;
      padding: 10px 24px;
      border-radius: 4px;
      cursor: pointer;
      font-size: 16px;
    }
  `]
})
export class MissingLanguageAttributeComponent {
  selectedLanguage = 'en';
  
  content = {
    en: {
      title: "Welcome to Our Website",
      subtitle: "Discover amazing products and services",
      description: "We are a leading technology company dedicated to providing innovative solutions that help businesses grow and succeed in the digital age.",
      button: "Learn More"
    },
    fr: {
      title: "Bienvenue sur Notre Site Web",
      subtitle: "Découvrez des produits et services incroyables",
      description: "Nous sommes une entreprise technologique leader dédiée à fournir des solutions innovantes qui aident les entreprises à croître et à réussir à l'ère numérique.",
      button: "En Savoir Plus"
    }
  };

  get currentContent() {
    return this.content[this.selectedLanguage] || this.content.en;
  }
}

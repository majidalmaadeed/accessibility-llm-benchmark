import { Component } from '@angular/core';

@Component({
  selector: 'app-accordion-without-state',
  template: `
    <div class="main-container">
      <div class="main-content">
        <h1>Frequently Asked Questions</h1>
        <p>Find answers to common questions about our service and platform.</p>
        
        <div class="faq-section">
          <!-- Toggle All Button -->
          <div class="toggle-all">
            <button (click)="toggleAll()" class="toggle-all-button">
              {{ openItems.size === faqItems.length ? 'Collapse All' : 'Expand All' }}
            </button>
          </div>

          <!-- FAQ Items -->
          <div class="accordion">
            <div
              *ngFor="let item of faqItems; let i = index"
              class="accordion-item"
              [class.last-item]="i === faqItems.length - 1"
            >
              <!-- Question Header -->
              <button
                (click)="toggleItem(item.id)"
                class="accordion-header"
              >
                <span class="question-text">{{ item.question }}</span>
                <span class="arrow" [class.rotated]="openItems.has(item.id)">▼</span>
              </button>

              <!-- Answer Content -->
              <div
                class="accordion-content"
                [class.open]="openItems.has(item.id)"
              >
                <div class="answer-text">{{ item.answer }}</div>
              </div>
            </div>
          </div>
        </div>

        <!-- Additional Help Section -->
        <div class="help-section">
          <h3>Still have questions?</h3>
          <p>If you couldn't find the answer you're looking for, our support team is here to help.</p>
          <div class="help-buttons">
            <button class="btn-primary">Contact Support</button>
            <button class="btn-secondary">Live Chat</button>
          </div>
        </div>
      </div>
    </div>
  `,
  styles: [`
    .main-container {
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

    .faq-section {
      margin-top: 30px;
    }

    .toggle-all {
      margin-bottom: 20px;
      text-align: right;
    }

    .toggle-all-button {
      background-color: #6c757d;
      color: white;
      padding: 8px 16px;
      border: none;
      border-radius: 4px;
      font-size: 14px;
      cursor: pointer;
    }

    .toggle-all-button:hover {
      background-color: #545b62;
    }

    .accordion {
      border: 1px solid #ddd;
      border-radius: 8px;
      overflow: hidden;
    }

    .accordion-item {
      border-bottom: 1px solid #eee;
    }

    .accordion-item.last-item {
      border-bottom: none;
    }

    .accordion-header {
      width: 100%;
      padding: 20px;
      border: none;
      background: white;
      text-align: left;
      cursor: pointer;
      display: flex;
      justify-content: space-between;
      align-items: center;
      font-size: 16px;
      font-weight: bold;
      color: #333;
      transition: background-color 0.2s ease;
    }

    .accordion-header:hover {
      background-color: #f8f9fa;
    }

    .question-text {
      flex: 1;
    }

    .arrow {
      font-size: 20px;
      color: #666;
      transition: transform 0.3s ease;
    }

    .arrow.rotated {
      transform: rotate(180deg);
    }

    .accordion-content {
      max-height: 0;
      overflow: hidden;
      transition: max-height 0.3s ease;
      background-color: #fafafa;
    }

    .accordion-content.open {
      max-height: 200px;
    }

    .answer-text {
      padding: 20px;
      line-height: 1.6;
      color: #666;
    }

    .help-section {
      margin-top: 40px;
      padding: 20px;
      background-color: #e3f2fd;
      border-radius: 4px;
    }

    .help-section h3 {
      margin: 0 0 10px 0;
      color: #1976d2;
    }

    .help-section p {
      margin: 0 0 15px 0;
      color: #333;
    }

    .help-buttons {
      display: flex;
      gap: 10px;
    }

    .btn-primary {
      background-color: #1976d2;
      color: white;
      padding: 10px 20px;
      border: none;
      border-radius: 4px;
      font-size: 14px;
      cursor: pointer;
    }

    .btn-primary:hover {
      background-color: #1565c0;
    }

    .btn-secondary {
      background-color: transparent;
      color: #1976d2;
      padding: 10px 20px;
      border: 1px solid #1976d2;
      border-radius: 4px;
      font-size: 14px;
      cursor: pointer;
    }

    .btn-secondary:hover {
      background-color: #1976d2;
      color: white;
    }
  `]
})
export class AccordionWithoutStateComponent {
  openItems = new Set<number>();

  faqItems = [
    {
      id: 1,
      question: 'How do I create an account?',
      answer: 'To create an account, click on the "Sign Up" button in the top right corner of the page. Fill in your email address, create a password, and provide your basic information. You\'ll receive a confirmation email to verify your account.'
    },
    {
      id: 2,
      question: 'What payment methods do you accept?',
      answer: 'We accept all major credit cards (Visa, MasterCard, American Express), PayPal, and bank transfers. All payments are processed securely through our encrypted payment gateway.'
    },
    {
      id: 3,
      question: 'How can I cancel my subscription?',
      answer: 'You can cancel your subscription at any time by going to your account settings and clicking on "Subscription Management". You\'ll continue to have access to premium features until the end of your current billing period.'
    },
    {
      id: 4,
      question: 'Is there a mobile app available?',
      answer: 'Yes! We have mobile apps available for both iOS and Android devices. You can download them from the App Store or Google Play Store. The mobile app includes all the features of the web version.'
    },
    {
      id: 5,
      question: 'How do I contact customer support?',
      answer: 'You can reach our customer support team through email at support@example.com, through our live chat feature on the website, or by calling our toll-free number at 1-800-EXAMPLE. We typically respond within 24 hours.'
    },
    {
      id: 6,
      question: 'What is your refund policy?',
      answer: 'We offer a 30-day money-back guarantee for all subscriptions. If you\'re not satisfied with our service, you can request a full refund within 30 days of your initial purchase. Contact our support team to initiate the refund process.'
    }
  ];

  toggleItem(itemId: number) {
    if (this.openItems.has(itemId)) {
      this.openItems.delete(itemId);
    } else {
      this.openItems.add(itemId);
    }
  }

  toggleAll() {
    if (this.openItems.size === this.faqItems.length) {
      this.openItems.clear();
    } else {
      this.openItems = new Set(this.faqItems.map(item => item.id));
    }
  }
}
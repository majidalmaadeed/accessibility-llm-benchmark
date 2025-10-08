import { Component } from '@angular/core';

@Component({
  selector: 'app-silent-loading-state',
  template: `
    <div class="data-dashboard">
      <h1>Data Management Dashboard</h1>
      <p>Load and manage different types of data from your system.</p>
      
      <div class="controls-section">
        <h2>Data Loading Controls</h2>
        <div class="control-buttons">
          <button 
            (click)="loadData('users')" 
            [disabled]="isLoading"
            class="control-btn users"
          >
            Load Users
          </button>
          <button 
            (click)="loadData('products')" 
            [disabled]="isLoading"
            class="control-btn products"
          >
            Load Products
          </button>
          <button 
            (click)="loadData('orders')" 
            [disabled]="isLoading"
            class="control-btn orders"
          >
            Load Orders
          </button>
        </div>
      </div>

      <!-- Content spinner without screen reader announcement -->
      <div *ngIf="isLoading" class="loading-container">
        <div class="loading-spinner"></div>
        <p>Loading {{ loadingType }}...</p>
      </div>

      <!-- Data display -->
      <div *ngIf="!isLoading && data.length > 0" class="data-container">
        <div class="data-header">
          <h2>{{ loadingType.charAt(0).toUpperCase() + loadingType.slice(1) }} Data</h2>
        </div>
        
        <div class="data-content">
          <div class="data-grid">
            <div 
              *ngFor="let item of data; let i = index" 
              class="data-item"
            >
              <div *ngFor="let field of getObjectKeys(item)" class="data-field">
                <strong>{{ field }}:</strong> {{ item[field] }}
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- Additional loading examples -->
      <div class="loading-examples">
        <div class="loading-example">
          <h3>File Upload Progress</h3>
          <div class="loading-demo">
            <div class="loading-spinner small"></div>
            <p>Uploading file...</p>
          </div>
        </div>

        <div class="loading-example">
          <h3>Processing Data</h3>
          <div class="loading-demo">
            <div class="loading-spinner small"></div>
            <p>Processing...</p>
          </div>
        </div>
      </div>
    </div>
  `,
  styles: [`
    .data-dashboard {
      max-width: 1000px;
      margin: 50px auto;
      padding: 20px;
      font-family: Arial, sans-serif;
    }

    .controls-section {
      background: #f8f9fa;
      padding: 20px;
      border-radius: 8px;
      margin-bottom: 30px;
    }

    .controls-section h2 {
      margin: 0 0 15px 0;
    }

    .control-buttons {
      display: flex;
      gap: 15px;
      flex-wrap: wrap;
      margin-top: 15px;
    }

    .control-btn {
      padding: 12px 24px;
      border: none;
      border-radius: 4px;
      cursor: pointer;
      font-size: 16px;
      font-weight: bold;
    }

    .control-btn:disabled {
      background: #6c757d;
      cursor: not-allowed;
    }

    .control-btn.users {
      background: #007bff;
      color: white;
    }

    .control-btn.products {
      background: #28a745;
      color: white;
    }

    .control-btn.orders {
      background: #ffc107;
      color: #212529;
    }

    .loading-container {
      background: white;
      padding: 40px;
      border-radius: 8px;
      box-shadow: 0 2px 8px rgba(0,0,0,0.1);
      border: 1px solid #e0e0e0;
      text-align: center;
      margin-bottom: 30px;
    }

    .loading-spinner {
      display: inline-block;
      width: 40px;
      height: 40px;
      border: 4px solid #f3f3f3;
      border-top: 4px solid #007bff;
      border-radius: 50%;
      animation: spin 1s linear infinite;
      margin-bottom: 20px;
    }

    .loading-spinner.small {
      width: 30px;
      height: 30px;
      border-width: 3px;
      margin-bottom: 10px;
    }

    .loading-container p {
      margin: 0;
      font-size: 16px;
      color: #666;
    }

    .data-container {
      background: white;
      border-radius: 8px;
      box-shadow: 0 2px 8px rgba(0,0,0,0.1);
      overflow: hidden;
      border: 1px solid #e0e0e0;
      margin-bottom: 30px;
    }

    .data-header {
      background: #f8f9fa;
      padding: 20px;
      border-bottom: 1px solid #e0e0e0;
    }

    .data-header h2 {
      margin: 0;
      font-size: 20px;
    }

    .data-content {
      padding: 20px;
    }

    .data-grid {
      display: grid;
      gap: 15px;
    }

    .data-item {
      padding: 15px;
      border: 1px solid #e0e0e0;
      border-radius: 4px;
      background: #fafafa;
    }

    .data-field {
      display: flex;
      margin-bottom: 8px;
    }

    .data-field strong {
      min-width: 120px;
      color: #333;
      text-transform: capitalize;
    }

    .loading-examples {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
      gap: 20px;
      margin-top: 30px;
    }

    .loading-example {
      background: white;
      padding: 20px;
      border-radius: 8px;
      box-shadow: 0 2px 8px rgba(0,0,0,0.1);
      border: 1px solid #e0e0e0;
    }

    .loading-example h3 {
      margin: 0 0 15px 0;
      font-size: 18px;
    }

    .loading-demo {
      background: #f8f9fa;
      padding: 20px;
      border-radius: 4px;
      text-align: center;
    }

    .loading-demo p {
      margin: 0;
      font-size: 14px;
      color: #666;
    }

    @keyframes spin {
      0% { transform: rotate(0deg); }
      100% { transform: rotate(360deg); }
    }
  `]
})
export class SilentLoadingStateComponent {
  isLoading = false;
  data: any[] = [];
  loadingType = '';

  mockData = {
    users: [
      { id: 1, name: 'John Doe', email: 'john@example.com', role: 'Admin' },
      { id: 2, name: 'Jane Smith', email: 'jane@example.com', role: 'User' },
      { id: 3, name: 'Bob Johnson', email: 'bob@example.com', role: 'User' }
    ],
    products: [
      { id: 1, name: 'Product A', price: 29.99, category: 'Electronics' },
      { id: 2, name: 'Product B', price: 49.99, category: 'Clothing' },
      { id: 3, name: 'Product C', price: 19.99, category: 'Books' }
    ],
    orders: [
      { id: 1, customer: 'John Doe', total: 79.98, status: 'Shipped' },
      { id: 2, customer: 'Jane Smith', total: 49.99, status: 'Processing' },
      { id: 3, customer: 'Bob Johnson', total: 29.99, status: 'Delivered' }
    ]
  };

  loadData(type: string) {
    this.loadingType = type;
    this.isLoading = true;
    this.data = [];
    
    // Simulate API call
    setTimeout(() => {
      this.data = this.mockData[type as keyof typeof this.mockData] || [];
      this.isLoading = false;
    }, 2000);
  }

  getObjectKeys(obj: any): string[] {
    return Object.keys(obj);
  }
}

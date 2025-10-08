import { Component } from '@angular/core';

@Component({
  selector: 'app-insufficient-button-spacing',
  template: `
    <div class="document-manager">
      <h1>Document Management</h1>
      <p>Manage your documents with the available actions below.</p>
      
      <div class="document-info">
        <h2>Current Document: Project Proposal.docx</h2>
        <p>Last modified: January 15, 2024 | Size: 2.3 MB</p>
      </div>

      <div class="actions-section">
        <h2>Available Actions</h2>
        <p>Select an action to perform on the current document:</p>
        
        <!-- Action buttons placed 2px apart instead of minimum 44px -->
        <div class="action-buttons">
          <button (click)="handleAction('view')" class="action-btn view">View</button>
          <button (click)="handleAction('edit')" class="action-btn edit">Edit</button>
          <button (click)="handleAction('download')" class="action-btn download">Download</button>
          <button (click)="handleAction('share')" class="action-btn share">Share</button>
          <button (click)="handleAction('print')" class="action-btn print">Print</button>
          <button (click)="handleAction('delete')" class="action-btn delete">Delete</button>
        </div>
      </div>

      <div class="toolbar-section">
        <h2>Quick Actions Toolbar</h2>
        <p>Commonly used actions for quick access:</p>
        
        <!-- Another set of insufficiently spaced buttons -->
        <div class="toolbar-buttons">
          <button class="toolbar-btn">Copy</button>
          <button class="toolbar-btn">Move</button>
          <button class="toolbar-btn">Rename</button>
          <button class="toolbar-btn">Archive</button>
          <button class="toolbar-btn">Properties</button>
        </div>
      </div>

      <div class="status-section">
        <h2>Document Status</h2>
        <p>Current status and available status changes:</p>
        
        <div class="status-buttons">
          <button class="status-btn draft">Mark as Draft</button>
          <button class="status-btn review">Mark as Review</button>
          <button class="status-btn approved">Mark as Approved</button>
          <button class="status-btn rejected">Mark as Rejected</button>
        </div>
      </div>

      <div *ngIf="selectedAction" class="action-feedback">
        <strong>Action Selected:</strong> {{ selectedAction }}
      </div>
    </div>
  `,
  styles: [`
    .document-manager {
      max-width: 800px;
      margin: 50px auto;
      padding: 20px;
      font-family: Arial, sans-serif;
    }

    .document-info {
      background: #f8f9fa;
      padding: 20px;
      border-radius: 8px;
      margin-bottom: 30px;
    }

    .document-info h2 {
      margin: 0 0 5px 0;
      font-size: 18px;
    }

    .document-info p {
      margin: 0;
      color: #666;
      font-size: 14px;
    }

    .actions-section, .toolbar-section, .status-section {
      background: white;
      padding: 30px;
      border-radius: 8px;
      box-shadow: 0 2px 10px rgba(0,0,0,0.1);
      border: 1px solid #e0e0e0;
      margin-bottom: 30px;
    }

    .actions-section h2, .toolbar-section h2, .status-section h2 {
      margin: 0 0 15px 0;
      font-size: 20px;
    }

    .actions-section p, .toolbar-section p, .status-section p {
      margin: 0 0 20px 0;
      color: #666;
    }

    .action-buttons {
      display: flex;
      gap: 2px;
      flex-wrap: wrap;
      margin-top: 20px;
    }

    .action-btn {
      padding: 8px 16px;
      border: none;
      border-radius: 4px;
      cursor: pointer;
      font-size: 14px;
      font-weight: bold;
    }

    .action-btn.view {
      background: #007bff;
      color: white;
    }

    .action-btn.edit {
      background: #28a745;
      color: white;
    }

    .action-btn.download {
      background: #17a2b8;
      color: white;
    }

    .action-btn.share {
      background: #ffc107;
      color: #212529;
    }

    .action-btn.print {
      background: #6c757d;
      color: white;
    }

    .action-btn.delete {
      background: #dc3545;
      color: white;
    }

    .toolbar-buttons {
      display: flex;
      gap: 2px;
      flex-wrap: wrap;
      margin-top: 15px;
    }

    .toolbar-btn {
      background: #e9ecef;
      color: #495057;
      border: 1px solid #ced4da;
      padding: 6px 12px;
      border-radius: 3px;
      cursor: pointer;
      font-size: 12px;
    }

    .status-buttons {
      display: flex;
      gap: 2px;
      flex-wrap: wrap;
      margin-top: 15px;
    }

    .status-btn {
      padding: 6px 12px;
      border: 1px solid;
      border-radius: 3px;
      cursor: pointer;
      font-size: 12px;
    }

    .status-btn.draft {
      background: #d4edda;
      color: #155724;
      border-color: #c3e6cb;
    }

    .status-btn.review {
      background: #fff3cd;
      color: #856404;
      border-color: #ffeaa7;
    }

    .status-btn.approved {
      background: #d1ecf1;
      color: #0c5460;
      border-color: #bee5eb;
    }

    .status-btn.rejected {
      background: #f8d7da;
      color: #721c24;
      border-color: #f5c6cb;
    }

    .action-feedback {
      background: #d1ecf1;
      color: #0c5460;
      padding: 15px;
      border-radius: 4px;
      margin-bottom: 20px;
      border: 1px solid #bee5eb;
    }
  `]
})
export class InsufficientButtonSpacingComponent {
  selectedAction = '';

  handleAction(action: string) {
    this.selectedAction = action;
  }
}

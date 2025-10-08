import { Component, OnInit, OnDestroy } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
interface SearchResult {
  id: number;
  title: string;
  category: string;
  author: string;
}
@Component({
  selector: 'app-search-with-silent-updates',
  standalone: true,
  imports: [CommonModule, FormsModule],
  template: `
    </div>
  `,
  styles: [`
    .search-container {
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
    .search-section {
      margin-bottom: 30px;
    }
    .search-input-container {
      margin-bottom: 20px;
    }
      display: block;
      margin-bottom: 8px;
      font-weight: bold;
      color: #333;
    }
    .input-wrapper {
      position: relative;
    }
    .search-input {
      width: 100%;
      padding: 12px 16px;
      border: 2px solid #ddd;
      border-radius: 4px;
      font-size: 16px;
      box-sizing: border-box;
    }
      outline: none;
      border-color: #007bff;
      box-shadow: 0 0 0 2px rgba(0, 123, 255, 0.25);
    }
    .suggestions-dropdown {
      position: absolute;
      top: 100%;
      left: 0;
      right: 0;
      background: white;
      border: 2px solid #007bff;
      border-top: none;
      border-radius: 0 0 4px 4px;
      box-shadow: 0 4px 12px rgba(0,0,0,0.15);
      z-index: 1000;
      max-height: 200px;
      overflow-y: auto;
    }
    .suggestion-item {
      padding: 12px 16px;
      cursor: pointer;
      border-bottom: 1px solid #eee;
      font-size: 14px;
    }
    .suggestion-item:hover,
    .suggestion-item.active {
      background-color: #f8f9fa;
    }
    .suggestion-item:last-child {
      border-bottom: none;
    }
    .suggestion-title {
      font-weight: bold;
      color: #333;
    }
    .suggestion-meta {
      color: #666;
      font-size: 12px;
    }
    .search-button {
      background-color: #007bff;
      color: white;
      border: none;
      padding: 12px 24px;
      border-radius: 4px;
      font-size: 16px;
      cursor: pointer;
    }
    .search-button:hover:not(:disabled) {
      background-color: #0056b3;
    }
    .search-button:disabled,
    .search-button.loading {
      background-color: #6c757d;
      cursor: not-allowed;
    }
    .results-section h2 {
      margin-top: 0;
      color: #333;
    }
    .loading-state,
    .no-results,
    .empty-state {
      text-align: center;
      padding: 20px;
    }
    .loading-text,
    .no-results-text,
    .empty-text {
      font-size: 18px;
      color: #666;
    }
    .results-count {
      margin-bottom: 16px;
      font-size: 14px;
      color: #666;
    }
    .results-grid {
      display: grid;
      grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
      gap: 16px;
    }
    .result-card {
      background: #f8f9fa;
      padding: 16px;
      border-radius: 4px;
      border: 1px solid #ddd;
    }
    .result-title {
      margin: 0 0 8px 0;
      color: #333;
    }
    .result-category,
    .result-author {
      margin: 0 0 4px 0;
      color: #666;
      font-size: 14px;
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
  `]
})
export class SearchWithSilentUpdatesComponent implements OnInit, OnDestroy {
  query: string = '';
  suggestions: SearchResult[] = [];
  results: SearchResult[] = [];
  isLoading: boolean = false;
  showSuggestions: boolean = false;
  activeSuggestionIndex: number = -1;
  private mockData: SearchResult[] = [
    { id: 1, title: 'React Development Guide', category: 'Books', author: 'John Doe' },
    { id: 2, title: 'Vue.js Tutorial', category: 'Books', author: 'Jane Smith' },
    { id: 3, title: 'Angular Framework', category: 'Books', author: 'Bob Johnson' },
    { id: 4, title: 'JavaScript Fundamentals', category: 'Books', author: 'Alice Brown' },
    { id: 5, title: 'React Components', category: 'Tutorials', author: 'Charlie Wilson' },
    { id: 6, title: 'Vue Components', category: 'Tutorials', author: 'Diana Lee' },
    { id: 7, title: 'Angular Services', category: 'Tutorials', author: 'Eve Davis' },
    { id: 8, title: 'JavaScript ES6', category: 'Tutorials', author: 'Frank Miller' }
  ];
  ngOnInit(): void {
    // Component initialization
  }
  ngOnDestroy(): void {
    // Cleanup
  }
  handleInput(): void {
    if (this.query.length > 1) {
      const filtered = this.mockData.filter(item =>
        item.title.toLowerCase().includes(this.query.toLowerCase()) ||
        item.category.toLowerCase().includes(this.query.toLowerCase()) ||
        item.author.toLowerCase().includes(this.query.toLowerCase())
      );
      this.suggestions = filtered.slice(0, 5);
      this.showSuggestions = true;
      this.activeSuggestionIndex = -1;
    } else {
      this.suggestions = [];
      this.showSuggestions = false;
      this.activeSuggestionIndex = -1;
    }
  }
  handleSearch(): void {
    this.isLoading = true;
    // Simulate API call
    setTimeout(() => {
      const filtered = this.mockData.filter(item =>
        item.title.toLowerCase().includes(this.query.toLowerCase()) ||
        item.category.toLowerCase().includes(this.query.toLowerCase()) ||
        item.author.toLowerCase().includes(this.query.toLowerCase())
      );
      this.results = filtered;
      this.isLoading = false;
      this.showSuggestions = false;
      this.activeSuggestionIndex = -1;
    }, 1000);
  }
  handleSuggestionClick(suggestion: SearchResult): void {
    this.query = suggestion.title;
    this.showSuggestions = false;
    this.activeSuggestionIndex = -1;
    this.handleSearch();
  }
    if (e.key === 'Enter') {
      if (this.showSuggestions && this.activeSuggestionIndex >= 0) {
        e.preventDefault();
        this.handleSuggestionClick(this.suggestions[this.activeSuggestionIndex]);
      } else {
        this.handleSearch();
      }
    } else if (e.key === 'Escape') {
      this.showSuggestions = false;
      this.activeSuggestionIndex = -1;
    } else if (e.key === 'ArrowDown') {
      e.preventDefault();
      if (this.showSuggestions) {
        this.activeSuggestionIndex = Math.min(this.activeSuggestionIndex + 1, this.suggestions.length - 1);
      }
    } else if (e.key === 'ArrowUp') {
      e.preventDefault();
      if (this.showSuggestions) {
        this.activeSuggestionIndex = Math.max(this.activeSuggestionIndex - 1, -1);
      }
    }
  }
}
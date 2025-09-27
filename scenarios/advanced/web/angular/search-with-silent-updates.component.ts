import { Component, OnInit, OnDestroy } from '@angular/core';

@Component({
  selector: 'app-search-with-silent-updates',
  template: `
    <div class="main-container">
      <div class="main-content">
        <h1>Search Knowledge Base</h1>
        <p>Find articles, tutorials, and resources by typing your search query.</p>
        
        <div class="search-section">
          <div class="search-input-container">
            <input
              type="text"
              [(ngModel)]="searchQuery"
              (keydown)="handleKeyDown($event)"
              placeholder="Search for articles, tutorials..."
              class="search-input"
              name="searchInput"
            />
            <button (click)="handleSearch()" class="search-button">
              🔍
            </button>
          </div>

          <!-- Search Suggestions -->
          <div *ngIf="showSuggestions && suggestions.length > 0" class="suggestions-dropdown">
            <div
              *ngFor="let suggestion of suggestions; let i = index"
              (click)="handleSuggestionClick(suggestion)"
              class="suggestion-item"
            >
              {{ suggestion }}
            </div>
          </div>
        </div>

        <!-- Search Status -->
        <div *ngIf="isSearching" class="search-status">
          <div class="status-message">
            Searching...
          </div>
        </div>

        <!-- Search Results -->
        <div *ngIf="results.length > 0 && !isSearching" class="results-section">
          <h3>Search Results ({{ results.length }} found)</h3>
          <div class="results-list">
            <div
              *ngFor="let result of results"
              class="result-item"
            >
              <h4>{{ result.title }}</h4>
              <p>Category: {{ result.category }}</p>
              <div class="rating">
                <span>Rating:</span>
                <span class="stars">⭐ {{ result.rating }}</span>
              </div>
            </div>
          </div>
        </div>

        <div *ngIf="searchQuery && results.length === 0 && !isSearching" class="no-results">
          <p>No results found for "{{ searchQuery }}"</p>
          <p>Try different keywords or check your spelling.</p>
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

    .search-section {
      margin-top: 30px;
      position: relative;
    }

    .search-input-container {
      position: relative;
    }

    .search-input {
      width: 100%;
      padding: 12px 40px 12px 16px;
      border: 2px solid #ddd;
      border-radius: 8px;
      font-size: 16px;
      box-sizing: border-box;
    }

    .search-input:focus {
      border-color: #007bff;
      outline: none;
    }

    .search-button {
      position: absolute;
      right: 8px;
      top: 50%;
      transform: translateY(-50%);
      background: none;
      border: none;
      cursor: pointer;
      font-size: 18px;
      color: #666;
    }

    .suggestions-dropdown {
      position: absolute;
      top: 100%;
      left: 0;
      right: 0;
      background: white;
      border: 1px solid #ddd;
      border-radius: 0 0 8px 8px;
      box-shadow: 0 4px 12px rgba(0,0,0,0.15);
      z-index: 1000;
      max-height: 200px;
      overflow-y: auto;
    }

    .suggestion-item {
      padding: 12px 16px;
      cursor: pointer;
      border-bottom: 1px solid #eee;
    }

    .suggestion-item:hover {
      background-color: #f8f9fa;
    }

    .suggestion-item:last-child {
      border-bottom: none;
    }

    .search-status {
      margin-top: 20px;
      text-align: center;
    }

    .status-message {
      display: inline-block;
      padding: 10px 20px;
      background-color: #e3f2fd;
      border-radius: 4px;
    }

    .results-section {
      margin-top: 30px;
    }

    .results-section h3 {
      margin-bottom: 16px;
    }

    .results-list {
      margin-top: 20px;
    }

    .result-item {
      padding: 20px;
      border: 1px solid #ddd;
      border-radius: 8px;
      margin-bottom: 16px;
      background-color: #fafafa;
    }

    .result-item h4 {
      margin: 0 0 8px 0;
      color: #333;
    }

    .result-item p {
      margin: 0 0 8px 0;
      color: #666;
    }

    .rating {
      display: flex;
      align-items: center;
      gap: 8px;
    }

    .stars {
      color: #ffc107;
    }

    .no-results {
      margin-top: 30px;
      text-align: center;
      padding: 40px;
      color: #666;
    }
  `]
})
export class SearchWithSilentUpdatesComponent implements OnInit, OnDestroy {
  searchQuery = '';
  suggestions: string[] = [];
  results: any[] = [];
  isSearching = false;
  showSuggestions = false;
  private searchTimeout: any;

  private mockSuggestions = [
    'JavaScript tutorial',
    'React components',
    'CSS animations',
    'Node.js backend',
    'Python programming',
    'Web accessibility',
    'Database design',
    'API development'
  ];

  private mockResults = [
    { id: 1, title: 'JavaScript Tutorial for Beginners', category: 'Programming', rating: 4.8 },
    { id: 2, title: 'Advanced React Patterns', category: 'Web Development', rating: 4.9 },
    { id: 3, title: 'CSS Grid Layout Guide', category: 'Design', rating: 4.7 },
    { id: 4, title: 'Node.js Server Setup', category: 'Backend', rating: 4.6 },
    { id: 5, title: 'Python Data Analysis', category: 'Data Science', rating: 4.8 }
  ];

  ngOnInit() {
    // Watch for search query changes
    this.watchSearchQuery();
  }

  ngOnDestroy() {
    if (this.searchTimeout) {
      clearTimeout(this.searchTimeout);
    }
  }

  private watchSearchQuery() {
    // This would typically use Angular's reactive forms or observables
    // For simplicity, we'll use a simple approach
    setInterval(() => {
      this.handleSearchChange();
    }, 100);
  }

  private handleSearchChange() {
    if (this.searchQuery.length > 0) {
      this.showSuggestions = true;
      this.suggestions = this.mockSuggestions.filter(suggestion =>
        suggestion.toLowerCase().includes(this.searchQuery.toLowerCase())
      );
    } else {
      this.showSuggestions = false;
      this.suggestions = [];
    }

    // Auto-search with debounce
    if (this.searchTimeout) {
      clearTimeout(this.searchTimeout);
    }

    if (this.searchQuery.length > 2) {
      this.searchTimeout = setTimeout(() => {
        this.handleSearch();
      }, 500);
    } else {
      this.results = [];
    }
  }

  async handleSearch(query: string = this.searchQuery) {
    if (!query.trim()) {
      this.results = [];
      return;
    }

    this.isSearching = true;
    
    // Simulate API call
    await new Promise(resolve => setTimeout(resolve, 800));
    
    this.results = this.mockResults.filter(result =>
      result.title.toLowerCase().includes(query.toLowerCase()) ||
      result.category.toLowerCase().includes(query.toLowerCase())
    );
    
    this.isSearching = false;
    this.showSuggestions = false;
  }

  handleSuggestionClick(suggestion: string) {
    this.searchQuery = suggestion;
    this.showSuggestions = false;
    this.handleSearch(suggestion);
  }

  handleKeyDown(event: KeyboardEvent) {
    if (event.key === 'Enter') {
      event.preventDefault();
      this.handleSearch();
    } else if (event.key === 'Escape') {
      this.showSuggestions = false;
    }
  }
}
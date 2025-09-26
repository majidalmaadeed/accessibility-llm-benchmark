import { Component, OnInit } from '@angular/core';

interface SearchResult {
  id: number;
  title: string;
  category: string;
  author: string;
}

@Component({
  selector: 'app-search-with-silent-updates',
  templateUrl: './search-with-silent-updates.page.html',
  styleUrls: ['./search-with-silent-updates.page.scss'],
})
export class SearchWithSilentUpdatesPage implements OnInit {
  
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

  constructor() { }

  ngOnInit() {
    // Component initialization
  }

  handleInput() {
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

  handleSearch() {
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
      
      // MISSING: Screen reader announcement of results
      // Should announce "Found X results" or "No results found"
    }, 1000);
  }

  handleSuggestionClick(suggestion: SearchResult) {
    this.query = suggestion.title;
    this.showSuggestions = false;
    this.activeSuggestionIndex = -1;
    this.handleSearch();
  }

  onSearchFocus() {
    // MISSING: Focus management for suggestions
  }

  onSearchBlur() {
    // Delay hiding suggestions to allow for clicks
    setTimeout(() => {
      this.showSuggestions = false;
    }, 200);
  }
}
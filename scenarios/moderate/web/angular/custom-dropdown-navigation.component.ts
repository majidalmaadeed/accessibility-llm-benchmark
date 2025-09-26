import { Component, ElementRef, HostListener, ViewChild, AfterViewInit, OnDestroy } from '@angular/core';

interface Option {
  value: string;
  text: string;
}

interface Product {
  name: string;
  category: string;
}

@Component({
  selector: 'app-custom-dropdown-navigation',
  template: `
    <div class="main-container">
      <div class="main-content">
        <h1>Product Filter</h1>
        <p>Filter products by category using the dropdown below.</p>
        
        <div class="filter-section">
          <label 
            for="category-filter" 
            class="filter-label"
          >
            Filter by Category:
          </label>
          <div class="custom-dropdown" #dropdownRef>
            <button
              #triggerRef
              id="category-filter"
              (click)="toggleDropdown()"
              (keydown)="handleKeyDown($event)"
              class="dropdown-trigger"
              [class.open]="isOpen"
            >
              <span>{{ selectedText }}</span>
              <span class="dropdown-arrow" [class.rotated]="isOpen">▼</span>
            </button>
            
            <div
              *ngIf="isOpen"
              class="dropdown-menu"
            >
              <div
                *ngFor="let option of options; let i = index"
                #optionRef
                [id]="'option-' + i"
                (click)="selectOption(option.value, option.text, i)"
                (keydown)="handleOptionKeyDown($event, option.value, option.text, i)"
                (mouseenter)="currentIndex = i"
                class="dropdown-option"
                [class.selected]="selectedValue === option.value"
              >
                {{ option.text }}
              </div>
            </div>
          </div>
        </div>
        
        <div class="results-section">
          <h2>Filtered Results</h2>
          <div class="results-grid">
            <div
              *ngFor="let product of filteredProducts; let i = index"
              class="result-card"
            >
              <h3>{{ product.name }}</h3>
              <p>{{ product.category }}</p>
            </div>
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

    .filter-section {
      margin-bottom: 30px;
    }

    .filter-label {
      display: block;
      margin-bottom: 10px;
      font-weight: bold;
      color: #333;
    }

    .custom-dropdown {
      position: relative;
      display: inline-block;
      width: 200px;
    }

    .dropdown-trigger {
      background-color: #f8f9fa;
      border: 2px solid #ddd;
      border-radius: 4px;
      padding: 12px 16px;
      cursor: pointer;
      display: flex;
      justify-content: space-between;
      align-items: center;
      font-size: 16px;
      width: 100%;
      box-sizing: border-box;
    }

    .dropdown-trigger:hover {
      border-color: #007bff;
    }

    .dropdown-trigger:focus {
      outline: none;
      border-color: #007bff;
      box-shadow: 0 0 0 2px rgba(0, 123, 255, 0.25);
    }

    .dropdown-trigger.open {
      border-color: #007bff;
      border-bottom-left-radius: 0;
      border-bottom-right-radius: 0;
    }

    .dropdown-arrow {
      transition: transform 0.2s ease;
    }

    .dropdown-arrow.rotated {
      transform: rotate(180deg);
    }

    .dropdown-menu {
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
    }

    .dropdown-option {
      padding: 12px 16px;
      cursor: pointer;
      border-bottom: 1px solid #eee;
      transition: background-color 0.2s ease;
    }

    .dropdown-option:last-child {
      border-bottom: none;
    }

    .dropdown-option:hover {
      background-color: #f8f9fa;
    }

    .dropdown-option.selected {
      background-color: #007bff;
      color: white;
    }

    .dropdown-option.selected:hover {
      background-color: #0056b3;
    }

    .results-section {
      margin-top: 30px;
    }

    .results-grid {
      display: grid;
      grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
      gap: 20px;
      margin-top: 20px;
    }

    .result-card {
      background: white;
      border: 1px solid #ddd;
      border-radius: 8px;
      padding: 20px;
      text-align: center;
      box-shadow: 0 2px 4px rgba(0,0,0,0.1);
    }

    .result-card h3 {
      margin: 0 0 10px 0;
      color: #333;
    }

    .result-card p {
      margin: 0;
      color: #666;
    }

    .accessibility-info {
      margin-top: 30px;
      padding: 20px;
      background-color: #e9ecef;
      border-radius: 4px;
    }
  `]
})
export class CustomDropdownNavigationComponent implements AfterViewInit, OnDestroy {
  @ViewChild('dropdownRef') dropdownRef!: ElementRef;
  @ViewChild('triggerRef') triggerRef!: ElementRef;

  isOpen = false;
  selectedValue = 'all';
  selectedText = 'All Categories';
  currentIndex = 0;
  optionsRef: ElementRef[] = [];

  options: Option[] = [
    { value: 'all', text: 'All Categories' },
    { value: 'electronics', text: 'Electronics' },
    { value: 'clothing', text: 'Clothing' },
    { value: 'books', text: 'Books' },
    { value: 'home', text: 'Home & Garden' }
  ];

  products: { [key: string]: Product[] } = {
    all: [
      { name: 'iPhone 15', category: 'Electronics' },
      { name: 'MacBook Pro', category: 'Electronics' },
      { name: 'Cotton T-Shirt', category: 'Clothing' },
      { name: 'JavaScript Guide', category: 'Books' },
      { name: 'Garden Tools', category: 'Home & Garden' }
    ],
    electronics: [
      { name: 'iPhone 15', category: 'Electronics' },
      { name: 'MacBook Pro', category: 'Electronics' }
    ],
    clothing: [
      { name: 'Cotton T-Shirt', category: 'Clothing' }
    ],
    books: [
      { name: 'JavaScript Guide', category: 'Books' }
    ],
    home: [
      { name: 'Garden Tools', category: 'Home & Garden' }
    ]
  };

  get filteredProducts(): Product[] {
    return this.products[this.selectedValue] || [];
  }

  ngAfterViewInit() {
    // Set up option references
    this.optionsRef = this.dropdownRef.nativeElement.querySelectorAll('.dropdown-option');
  }

  ngOnDestroy() {
    // Cleanup if needed
  }

  toggleDropdown(): void {
    this.isOpen = !this.isOpen;
    if (this.isOpen) {
      // Focus first option when opening
      setTimeout(() => {
        if (this.optionsRef[0]) {
          this.optionsRef[0].focus();
        }
      }, 0);
    }
  }

  selectOption(value: string, text: string, index: number): void {
    this.selectedValue = value;
    this.selectedText = text;
    this.currentIndex = index;
    this.isOpen = false;
    // Return focus to trigger
    if (this.triggerRef) {
      this.triggerRef.nativeElement.focus();
    }
  }

  handleKeyDown(event: KeyboardEvent): void {
    if (!this.isOpen) {
      if (event.key === 'Enter' || event.key === ' ') {
        event.preventDefault();
        this.toggleDropdown();
      }
      return;
    }

    switch (event.key) {
      case 'ArrowDown':
        event.preventDefault();
        const nextIndex = this.currentIndex < this.options.length - 1 ? this.currentIndex + 1 : 0;
        this.currentIndex = nextIndex;
        if (this.optionsRef[nextIndex]) {
          this.optionsRef[nextIndex].focus();
        }
        break;
      case 'ArrowUp':
        event.preventDefault();
        const prevIndex = this.currentIndex > 0 ? this.currentIndex - 1 : this.options.length - 1;
        this.currentIndex = prevIndex;
        if (this.optionsRef[prevIndex]) {
          this.optionsRef[prevIndex].focus();
        }
        break;
      case 'Enter':
      case ' ':
        event.preventDefault();
        this.selectOption(this.options[this.currentIndex].value, this.options[this.currentIndex].text, this.currentIndex);
        break;
      case 'Escape':
        this.isOpen = false;
        if (this.triggerRef) {
          this.triggerRef.nativeElement.focus();
        }
        break;
    }
  }

  handleOptionKeyDown(event: KeyboardEvent, value: string, text: string, index: number): void {
    if (event.key === 'Enter' || event.key === ' ') {
      event.preventDefault();
      this.selectOption(value, text, index);
    } else if (event.key === 'Escape') {
      this.isOpen = false;
      if (this.triggerRef) {
        this.triggerRef.nativeElement.focus();
      }
    }
  }

  @HostListener('document:mousedown', ['$event'])
  handleClickOutside(event: MouseEvent): void {
    if (this.dropdownRef && !this.dropdownRef.nativeElement.contains(event.target)) {
      this.isOpen = false;
    }
  }
}
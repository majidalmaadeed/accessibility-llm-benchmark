import { Component, OnInit } from '@angular/core';

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
  templateUrl: './custom-dropdown-navigation.page.html',
  styleUrls: ['./custom-dropdown-navigation.page.scss'],
})
export class CustomDropdownNavigationPage implements OnInit {
  
  isOpen = false;
  selectedValue = 'all';
  selectedText = 'All Categories';
  currentIndex = 0;
  
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
  
  ngOnInit() {
    // Initialize component
  }
  
  toggleDropdown() {
    this.isOpen = !this.isOpen;
  }
  
  selectOption(value: string, text: string, index: number) {
    this.selectedValue = value;
    this.selectedText = text;
    this.currentIndex = index;
    this.isOpen = false;
    
    // Announce selection change for accessibility
    this.announceSelection(text);
  }
  
  private announceSelection(text: string) {
    // Use Ionic's accessibility features
    const announcement = `Selected ${text}`;
    
    // For web, we can use the Web Speech API or ARIA live regions
    if (typeof window !== 'undefined' && 'speechSynthesis' in window) {
      const utterance = new SpeechSynthesisUtterance(announcement);
      utterance.volume = 0.5;
      speechSynthesis.speak(utterance);
    }
    
    // For mobile, we would use native accessibility services
    // This would typically be handled by the platform's accessibility framework
  }
}
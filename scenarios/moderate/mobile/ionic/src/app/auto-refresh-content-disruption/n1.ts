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
})
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
  }
    if (typeof window !== 'undefined' && 'speechSynthesis' in window) {
      utterance.volume = 0.5;
      speechSynthesis.speak(utterance);
    }
  }
}
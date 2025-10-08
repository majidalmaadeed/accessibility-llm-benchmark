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
    
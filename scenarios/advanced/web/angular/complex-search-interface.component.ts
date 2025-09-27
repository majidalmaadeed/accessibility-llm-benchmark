import { Component, OnInit } from '@angular/core';

interface Product {
  id: number;
  name: string;
  category: string;
  brand: string;
  price: number;
  rating: number;
  reviews: number;
  availability: string;
  image: string;
  description: string;
}

interface Category {
  id: string;
  name: string;
}

interface Brand {
  id: string;
  name: string;
}

interface PriceRange {
  id: string;
  name: string;
}

interface Rating {
  id: string;
  name: string;
}

interface SortOption {
  id: string;
  name: string;
}

@Component({
  selector: 'app-complex-search-interface',
  templateUrl: './complex-search-interface.component.html',
  styleUrls: ['./complex-search-interface.component.css']
})
export class ComplexSearchInterfaceComponent implements OnInit {
  searchQuery: string = '';
  searchResults: Product[] = [];
  isLoading: boolean = false;
  filters = {
    category: 'all',
    priceRange: 'all',
    brand: 'all',
    rating: 'all',
    availability: 'all',
    sortBy: 'relevance'
  };
  showFilters: boolean = false;
  viewMode: 'grid' | 'list' = 'grid';
  currentPage: number = 1;
  itemsPerPage: number = 12;
  selectedItems: number[] = [];
  showSuggestions: boolean = false;
  suggestions: string[] = [];

  sampleProducts: Product[] = [
    {
      id: 1,
      name: 'Wireless Bluetooth Headphones',
      category: 'electronics',
      brand: 'TechSound',
      price: 99.99,
      rating: 4.5,
      reviews: 128,
      availability: 'in-stock',
      image: 'https://via.placeholder.com/200x200/4caf50/fff?text=🎧',
      description: 'High-quality wireless headphones with noise cancellation'
    },
    {
      id: 2,
      name: 'Smart Fitness Watch',
      category: 'electronics',
      brand: 'FitTech',
      price: 199.99,
      rating: 4.2,
      reviews: 89,
      availability: 'in-stock',
      image: 'https://via.placeholder.com/200x200/2196f3/fff?text=⌚',
      description: 'Advanced fitness tracking with heart rate monitoring'
    },
    {
      id: 3,
      name: 'Organic Cotton T-Shirt',
      category: 'clothing',
      brand: 'EcoWear',
      price: 29.99,
      rating: 4.7,
      reviews: 256,
      availability: 'in-stock',
      image: 'https://via.placeholder.com/200x200/ff9800/fff?text=👕',
      description: 'Comfortable organic cotton t-shirt in various colors'
    },
    {
      id: 4,
      name: 'Stainless Steel Water Bottle',
      category: 'home',
      brand: 'HydroMax',
      price: 24.99,
      rating: 4.3,
      reviews: 167,
      availability: 'limited',
      image: 'https://via.placeholder.com/200x200/9c27b0/fff?text=🍶',
      description: 'Insulated stainless steel water bottle keeps drinks cold'
    },
    {
      id: 5,
      name: 'Wireless Charging Pad',
      category: 'electronics',
      brand: 'PowerUp',
      price: 39.99,
      rating: 4.1,
      reviews: 94,
      availability: 'in-stock',
      image: 'https://via.placeholder.com/200x200/f44336/fff?text=🔋',
      description: 'Fast wireless charging pad compatible with all devices'
    },
    {
      id: 6,
      name: 'Yoga Mat Premium',
      category: 'sports',
      brand: 'FlexFit',
      price: 49.99,
      rating: 4.6,
      reviews: 203,
      availability: 'in-stock',
      image: 'https://via.placeholder.com/200x200/4caf50/fff?text=🧘',
      description: 'Non-slip premium yoga mat for all fitness levels'
    }
  ];

  categories: Category[] = [
    { id: 'all', name: 'All Categories' },
    { id: 'electronics', name: 'Electronics' },
    { id: 'clothing', name: 'Clothing' },
    { id: 'home', name: 'Home & Garden' },
    { id: 'sports', name: 'Sports & Fitness' },
    { id: 'books', name: 'Books' }
  ];

  brands: Brand[] = [
    { id: 'all', name: 'All Brands' },
    { id: 'TechSound', name: 'TechSound' },
    { id: 'FitTech', name: 'FitTech' },
    { id: 'EcoWear', name: 'EcoWear' },
    { id: 'HydroMax', name: 'HydroMax' },
    { id: 'PowerUp', name: 'PowerUp' },
    { id: 'FlexFit', name: 'FlexFit' }
  ];

  priceRanges: PriceRange[] = [
    { id: 'all', name: 'All Prices' },
    { id: '0-25', name: 'Under $25' },
    { id: '25-50', name: '$25 - $50' },
    { id: '50-100', name: '$50 - $100' },
    { id: '100-200', name: '$100 - $200' },
    { id: '200+', name: 'Over $200' }
  ];

  ratings: Rating[] = [
    { id: 'all', name: 'All Ratings' },
    { id: '4.5+', name: '4.5+ Stars' },
    { id: '4+', name: '4+ Stars' },
    { id: '3+', name: '3+ Stars' },
    { id: '2+', name: '2+ Stars' }
  ];

  sortOptions: SortOption[] = [
    { id: 'relevance', name: 'Relevance' },
    { id: 'price-low', name: 'Price: Low to High' },
    { id: 'price-high', name: 'Price: High to Low' },
    { id: 'rating', name: 'Customer Rating' },
    { id: 'newest', name: 'Newest First' },
    { id: 'name', name: 'Name A-Z' }
  ];

  searchSuggestions: string[] = [
    'wireless headphones', 'smart watch', 'fitness tracker', 'bluetooth speaker',
    'phone case', 'laptop stand', 'wireless charger', 'yoga mat', 'water bottle',
    'organic cotton', 'stainless steel', 'premium quality'
  ];

  constructor() { }

  ngOnInit(): void {
    this.performSearch();
  }

  get totalPages(): number {
    return Math.ceil(this.searchResults.length / this.itemsPerPage);
  }

  get paginatedResults(): Product[] {
    const startIndex = (this.currentPage - 1) * this.itemsPerPage;
    return this.searchResults.slice(startIndex, startIndex + this.itemsPerPage);
  }

  performSearch(): void {
    this.isLoading = true;
    
    setTimeout(() => {
      let filteredProducts = [...this.sampleProducts];

      if (this.searchQuery.trim()) {
        filteredProducts = filteredProducts.filter(product =>
          product.name.toLowerCase().includes(this.searchQuery.toLowerCase()) ||
          product.description.toLowerCase().includes(this.searchQuery.toLowerCase()) ||
          product.brand.toLowerCase().includes(this.searchQuery.toLowerCase())
        );
      }

      if (this.filters.category !== 'all') {
        filteredProducts = filteredProducts.filter(product => product.category === this.filters.category);
      }

      if (this.filters.brand !== 'all') {
        filteredProducts = filteredProducts.filter(product => product.brand === this.filters.brand);
      }

      if (this.filters.priceRange !== 'all') {
        const [min, max] = this.filters.priceRange.split('-').map(Number);
        filteredProducts = filteredProducts.filter(product => {
          if (this.filters.priceRange === '200+') {
            return product.price > 200;
          }
          return product.price >= min && product.price <= max;
        });
      }

      if (this.filters.rating !== 'all') {
        const minRating = parseFloat(this.filters.rating);
        filteredProducts = filteredProducts.filter(product => product.rating >= minRating);
      }

      if (this.filters.availability !== 'all') {
        filteredProducts = filteredProducts.filter(product => product.availability === this.filters.availability);
      }

      switch (this.filters.sortBy) {
        case 'price-low':
          filteredProducts.sort((a, b) => a.price - b.price);
          break;
        case 'price-high':
          filteredProducts.sort((a, b) => b.price - a.price);
          break;
        case 'rating':
          filteredProducts.sort((a, b) => b.rating - a.rating);
          break;
        case 'newest':
          filteredProducts.sort((a, b) => b.id - a.id);
          break;
        case 'name':
          filteredProducts.sort((a, b) => a.name.localeCompare(b.name));
          break;
      }

      this.searchResults = filteredProducts;
      this.isLoading = false;
    }, 500);
  }

  handleSearch(): void {
    this.currentPage = 1;
    this.performSearch();
  }

  handleSuggestionClick(suggestion: string): void {
    this.searchQuery = suggestion;
    this.showSuggestions = false;
    this.currentPage = 1;
    this.performSearch();
  }

  handleItemSelect(itemId: number): void {
    if (this.selectedItems.includes(itemId)) {
      this.selectedItems = this.selectedItems.filter(id => id !== itemId);
    } else {
      this.selectedItems.push(itemId);
    }
  }

  handleSelectAll(): void {
    const currentPageItems = this.paginatedResults.map(item => item.id);
    if (this.selectedItems.length === currentPageItems.length) {
      this.selectedItems = this.selectedItems.filter(id => !currentPageItems.includes(id));
    } else {
      this.selectedItems = [...this.selectedItems, ...currentPageItems.filter(id => !this.selectedItems.includes(id))];
    }
  }

  clearFilters(): void {
    this.filters = {
      category: 'all',
      priceRange: 'all',
      brand: 'all',
      rating: 'all',
      availability: 'all',
      sortBy: 'relevance'
    };
    this.searchQuery = '';
    this.currentPage = 1;
  }

  renderStars(rating: number): string {
    const stars = [];
    const fullStars = Math.floor(rating);
    const hasHalfStar = rating % 1 !== 0;

    for (let i = 0; i < fullStars; i++) {
      stars.push('★');
    }
    if (hasHalfStar) {
      stars.push('☆');
    }
    while (stars.length < 5) {
      stars.push('☆');
    }
    return stars.join('');
  }

  onSearchQueryChange(): void {
    if (this.searchQuery.length > 2) {
      const filteredSuggestions = this.searchSuggestions.filter(suggestion =>
        suggestion.toLowerCase().includes(this.searchQuery.toLowerCase())
      );
      this.suggestions = filteredSuggestions.slice(0, 5);
      this.showSuggestions = true;
    } else {
      this.showSuggestions = false;
    }
  }

  onFiltersChange(): void {
    this.currentPage = 1;
    this.performSearch();
  }

  isAllSelected(): boolean {
    return this.selectedItems.length === this.paginatedResults.length && this.paginatedResults.length > 0;
  }

  isItemSelected(itemId: number): boolean {
    return this.selectedItems.includes(itemId);
  }
}

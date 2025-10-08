import { Component, OnInit } from '@angular/core';
import { AlertController, ModalController } from '@ionic/angular';

interface SearchResult {
  id: string;
  title: string;
  description: string;
  type: string;
  category: string;
  size: string;
  sizeValue: number;
  date: string;
  rating: number;
  price: number;
  image: string;
  url: string;
}

interface Filter {
  id: string;
  name: string;
  type: string;
}

@Component({
  selector: 'app-complex-search-interface',
  templateUrl: './complex-search-interface.page.html',
  styleUrls: ['./complex-search-interface.page.scss'],
})
export class ComplexSearchInterfacePage implements OnInit {
  searchQuery = '';
  searchResults: SearchResult[] = [];
  isLoading = false;
  selectedFilters = new Set<string>();
  sortOption = 'relevance';
  viewMode = 'list';
  selectedCategory = 'All';
  minPrice = 0;
  maxPrice = 1000;
  startDate: string | null = null;
  endDate: string | null = null;
  showAdvancedFilters = false;

  categories = [
    'All', 'Documents', 'Images', 'Videos', 'Audio', 'Web Pages',
    'News', 'Products', 'People', 'Locations'
  ];

  filters: Filter[] = [
    { id: 'recent', name: 'Recent', type: 'date' },
    { id: 'large', name: 'Large Files', type: 'size' },
    { id: 'images', name: 'Images Only', type: 'type' },
    { id: 'videos', name: 'Videos Only', type: 'type' },
    { id: 'documents', name: 'Documents Only', type: 'type' },
    { id: 'free', name: 'Free', type: 'price' },
    { id: 'premium', name: 'Premium', type: 'price' }
  ];

  sampleResults: SearchResult[] = [
    {
      id: '1',
      title: 'React Native Development Guide',
      description: 'Comprehensive guide to building mobile apps with React Native',
      type: 'document',
      category: 'Documents',
      size: '2.5 MB',
      sizeValue: 2.5,
      date: '2024-01-15',
      rating: 4.8,
      price: 0,
      image: '📄',
      url: 'https://example.com/react-native-guide'
    },
    {
      id: '2',
      title: 'Mobile UI Design Patterns',
      description: 'Best practices for mobile user interface design',
      type: 'image',
      category: 'Images',
      size: '1.2 MB',
      sizeValue: 1.2,
      date: '2024-01-14',
      rating: 4.6,
      price: 29.99,
      image: '🖼️',
      url: 'https://example.com/ui-patterns'
    },
    {
      id: '3',
      title: 'JavaScript Tutorial Series',
      description: 'Complete JavaScript tutorial for beginners',
      type: 'video',
      category: 'Videos',
      size: '150 MB',
      sizeValue: 150,
      date: '2024-01-13',
      rating: 4.9,
      price: 49.99,
      image: '🎥',
      url: 'https://example.com/js-tutorial'
    },
    {
      id: '4',
      title: 'Web Development News',
      description: 'Latest news and updates in web development',
      type: 'news',
      category: 'News',
      size: '500 KB',
      sizeValue: 0.5,
      date: '2024-01-12',
      rating: 4.3,
      price: 0,
      image: '📰',
      url: 'https://example.com/web-news'
    },
    {
      id: '5',
      title: 'E-commerce Product Catalog',
      description: 'Complete product catalog for online store',
      type: 'product',
      category: 'Products',
      size: '5.8 MB',
      sizeValue: 5.8,
      date: '2024-01-11',
      rating: 4.5,
      price: 99.99,
      image: '🛍️',
      url: 'https://example.com/product-catalog'
    }
  ];

  constructor(
    private alertController: AlertController,
    private modalController: ModalController
  ) {}

  ngOnInit() {
    // Initialize with empty results
  }

  get selectedFiltersCount(): number {
    return this.selectedFilters.size;
  }

  onSearchInput() {
    // Debounce search input
    setTimeout(() => {
      this.performSearch();
    }, 300);
  }

  onSearchClear() {
    this.searchQuery = '';
    this.searchResults = [];
  }

  onSearchClicked() {
    this.performSearch();
  }

  async performSearch() {
    if (!this.searchQuery.trim()) {
      this.searchResults = [];
      return;
    }

    this.isLoading = true;

    // Simulate API call
    setTimeout(() => {
      this.searchResults = this.getFilteredResults();
      this.isLoading = false;
    }, 1000);
  }

  getFilteredResults(): SearchResult[] {
    let filteredResults = [...this.sampleResults];

    // Apply search query filter
    if (this.searchQuery.trim()) {
      filteredResults = filteredResults.filter(result =>
        result.title.toLowerCase().includes(this.searchQuery.toLowerCase()) ||
        result.description.toLowerCase().includes(this.searchQuery.toLowerCase())
      );
    }

    // Apply category filter
    if (this.selectedCategory !== 'All') {
      filteredResults = filteredResults.filter(result => result.category === this.selectedCategory);
    }

    // Apply price range filter
    filteredResults = filteredResults.filter(result => 
      result.price >= this.minPrice && result.price <= this.maxPrice
    );

    // Apply selected filters
    this.selectedFilters.forEach(filterId => {
      const filter = this.filters.find(f => f.id === filterId);
      if (filter) {
        switch (filter.type) {
          case 'type':
            filteredResults = filteredResults.filter(result =>
              result.type === filterId.substring(0, filterId.length - 1)
            );
            break;
          case 'price':
            if (filterId === 'free') {
              filteredResults = filteredResults.filter(result => result.price === 0);
            } else if (filterId === 'premium') {
              filteredResults = filteredResults.filter(result => result.price > 0);
            }
            break;
          case 'size':
            if (filterId === 'large') {
              filteredResults = filteredResults.filter(result => result.sizeValue > 1);
            }
            break;
          case 'date':
            if (filterId === 'recent') {
              const recentDate = new Date();
              recentDate.setDate(recentDate.getDate() - 7);
              filteredResults = filteredResults.filter(result => 
                new Date(result.date) > recentDate
              );
            }
            break;
        }
      }
    });

    // Apply sorting
    filteredResults.sort((a, b) => {
      switch (this.sortOption) {
        case 'date':
          return new Date(b.date).getTime() - new Date(a.date).getTime();
        case 'name':
          return a.title.localeCompare(b.title);
        case 'size':
          return b.sizeValue - a.sizeValue;
        case 'type':
          return a.type.localeCompare(b.type);
        case 'rating':
          return b.rating - a.rating;
        default:
          return 0; // relevance - keep original order
      }
    });

    return filteredResults;
  }

  onFilterToggled(filterId: string) {
    if (this.selectedFilters.has(filterId)) {
      this.selectedFilters.delete(filterId);
    } else {
      this.selectedFilters.add(filterId);
    }
    this.performSearch();
  }

  isFilterSelected(filterId: string): boolean {
    return this.selectedFilters.has(filterId);
  }

  onSortChanged() {
    this.performSearch();
  }

  onViewModeChanged(mode: string) {
    this.viewMode = mode;
  }

  onFiltersClicked() {
    this.showAdvancedFilters = true;
  }

  onAdvancedFiltersDismissed() {
    this.showAdvancedFilters = false;
  }

  onCategorySelected(category: string) {
    this.selectedCategory = category;
  }

  onClearAllFilters() {
    this.selectedFilters.clear();
    this.selectedCategory = 'All';
    this.minPrice = 0;
    this.maxPrice = 1000;
    this.startDate = null;
    this.endDate = null;
  }

  onClearFiltersClicked() {
    this.onClearAllFilters();
    this.performSearch();
  }

  onApplyFilters() {
    this.showAdvancedFilters = false;
    this.performSearch();
  }

  async onResultClicked(result: SearchResult) {
    const alert = await this.alertController.create({
      header: result.title,
      message: `${result.description}\n\nType: ${result.type}\nSize: ${result.size}\nDate: ${result.date}\nRating: ${result.rating}/5\nPrice: $${result.price}`,
      buttons: [
        {
          text: 'Close',
          role: 'cancel'
        },
        {
          text: 'Open',
          handler: () => {
            // Handle open action
            console.log('Opening:', result.url);
          }
        }
      ]
    });
    await alert.present();
  }
}

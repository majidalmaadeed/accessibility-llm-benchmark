import { Component, OnInit } from '@angular/core';

interface DataItem {
  id: number;
  name: string;
  category: string;
  status: string;
  value: number;
  date: string;
  active: string;
}

@Component({
  selector: 'app-data-table',
  templateUrl: './data-table.component.html',
  styleUrls: ['./data-table.component.css']
})
export class DataTableComponent implements OnInit {
  data: DataItem[] = [];
  filteredData: DataItem[] = [];
  searchTerm = '';
  categoryFilter = 'All';
  statusFilter = 'All';
  sortField = '';
  sortDirection: 'asc' | 'desc' = 'asc';
  currentPage = 1;
  itemsPerPage = 10;
  selectedItems: number[] = [];

  ngOnInit() {
    this.generateData();
  }

  get totalPages(): number {
    return Math.ceil(this.filteredData.length / this.itemsPerPage);
  }

  get currentPageData(): DataItem[] {
    const startIndex = (this.currentPage - 1) * this.itemsPerPage;
    return this.filteredData.slice(startIndex, startIndex + this.itemsPerPage);
  }

  generateData() {
    const categories = ['Electronics', 'Clothing', 'Books', 'Home', 'Sports'];
    const statuses = ['Active', 'Inactive', 'Pending', 'Completed'];
    
    for (let i = 1; i <= 100; i++) {
      this.data.push({
        id: i,
        name: `Item ${i}`,
        category: categories[i % categories.length],
        status: statuses[i % statuses.length],
        value: Math.floor(Math.random() * 1000) + 100,
        date: new Date(Date.now() - Math.random() * 365 * 24 * 60 * 60 * 1000).toISOString().split('T')[0],
        active: Math.random() > 0.3 ? 'Yes' : 'No'
      });
    }
    
    this.applyFilters();
  }

  applyFilters() {
    let filtered = [...this.data];

    if (this.searchTerm) {
      filtered = filtered.filter(item =>
        item.name.toLowerCase().includes(this.searchTerm.toLowerCase()) ||
        item.category.toLowerCase().includes(this.searchTerm.toLowerCase()) ||
        item.status.toLowerCase().includes(this.searchTerm.toLowerCase())
      );
    }

    if (this.categoryFilter !== 'All') {
      filtered = filtered.filter(item => item.category === this.categoryFilter);
    }

    if (this.statusFilter !== 'All') {
      filtered = filtered.filter(item => item.status === this.statusFilter);
    }

    if (this.sortField) {
      filtered.sort((a, b) => {
        const aVal = (a as any)[this.sortField];
        const bVal = (b as any)[this.sortField];
        
        if (this.sortDirection === 'asc') {
          return aVal > bVal ? 1 : -1;
        } else {
          return aVal < bVal ? 1 : -1;
        }
      });
    }

    this.filteredData = filtered;
    this.currentPage = 1;
  }

  handleSort(field: string) {
    if (this.sortField === field) {
      this.sortDirection = this.sortDirection === 'asc' ? 'desc' : 'asc';
    } else {
      this.sortField = field;
      this.sortDirection = 'asc';
    }
    this.applyFilters();
  }

  handleSelectItem(itemId: number) {
    const index = this.selectedItems.indexOf(itemId);
    if (index > -1) {
      this.selectedItems.splice(index, 1);
    } else {
      this.selectedItems.push(itemId);
    }
  }

  handleSelectAll() {
    if (this.selectedItems.length === this.currentPageData.length) {
      this.selectedItems = [];
    } else {
      this.selectedItems = this.currentPageData.map(item => item.id);
    }
  }

  addRow() {
    const newItem: DataItem = {
      id: Math.max(...this.data.map(item => item.id)) + 1,
      name: 'New Item',
      category: 'Electronics',
      status: 'Active',
      value: 100,
      date: new Date().toISOString().split('T')[0],
      active: 'Yes'
    };
    this.data.push(newItem);
    this.applyFilters();
  }

  removeSelected() {
    this.data = this.data.filter(item => !this.selectedItems.includes(item.id));
    this.selectedItems = [];
    this.applyFilters();
  }

  clearAll() {
    if (confirm('Are you sure you want to clear all data?')) {
      this.data = [];
      this.selectedItems = [];
      this.applyFilters();
    }
  }

  exportData() {
    const csvContent = [
      ['ID', 'Name', 'Category', 'Status', 'Value', 'Date', 'Active'],
      ...this.filteredData.map(item => [
        item.id,
        item.name,
        item.category,
        item.status,
        item.value,
        item.date,
        item.active
      ])
    ].map(row => row.join(',')).join('\n');

    const blob = new Blob([csvContent], { type: 'text/csv' });
    const url = window.URL.createObjectURL(blob);
    const a = document.createElement('a');
    a.href = url;
    a.download = 'data.csv';
    a.click();
    window.URL.revokeObjectURL(url);
  }

  resetFilters() {
    this.searchTerm = '';
    this.categoryFilter = 'All';
    this.statusFilter = 'All';
    this.sortField = '';
    this.sortDirection = 'asc';
    this.applyFilters();
  }

  setCurrentPage(page: number) {
    this.currentPage = page;
  }

  getPageNumbers(): number[] {
    return Array.from({ length: this.totalPages }, (_, i) => i + 1);
  }
}

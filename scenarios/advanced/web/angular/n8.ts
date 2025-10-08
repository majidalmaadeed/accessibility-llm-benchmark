import { Component, OnInit } from '@angular/core';

interface Employee {
  id: number;
  name: string;
  department: string;
  position: string;
  salary: number;
  status: 'active' | 'inactive';
  startDate: string;
}

interface SortConfig {
  key: string | null;
  direction: 'asc' | 'desc';
}

interface Filters {
  department: string;
  status: string;
  search: string;
}

@Component({
  selector: 'app-data-table-complex',
  templateUrl: './data-table-complex.component.html',
  styleUrls: ['./data-table-complex.component.css']
})
export class DataTableComplexComponent implements OnInit {
  employees: Employee[] = [
    { id: 1, name: 'John Doe', department: 'Engineering', position: 'Senior Developer', salary: 95000, status: 'active', startDate: '2022-01-15' },
    { id: 2, name: 'Jane Smith', department: 'Marketing', position: 'Marketing Manager', salary: 78000, status: 'active', startDate: '2021-08-20' },
    { id: 3, name: 'Mike Johnson', department: 'Sales', position: 'Sales Representative', salary: 65000, status: 'inactive', startDate: '2023-03-10' },
    { id: 4, name: 'Sarah Wilson', department: 'HR', position: 'HR Specialist', salary: 72000, status: 'active', startDate: '2022-11-05' },
    { id: 5, name: 'David Brown', department: 'Engineering', position: 'Junior Developer', salary: 68000, status: 'active', startDate: '2023-06-01' },
    { id: 6, name: 'Lisa Davis', department: 'Finance', position: 'Financial Analyst', salary: 82000, status: 'active', startDate: '2021-12-15' },
    { id: 7, name: 'Tom Anderson', department: 'Sales', position: 'Sales Manager', salary: 88000, status: 'active', startDate: '2020-09-30' },
    { id: 8, name: 'Emma Taylor', department: 'Engineering', position: 'DevOps Engineer', salary: 92000, status: 'active', startDate: '2022-04-12' }
  ];

  sortConfig: SortConfig = { key: null, direction: 'asc' };
  filters: Filters = {
    department: '',
    status: '',
    search: ''
  };
  selectedRows: number[] = [];
  currentPage: number = 1;
  itemsPerPage: number = 5;

  constructor() { }

  ngOnInit(): void {
  }

  get departments(): string[] {
    return [...new Set(this.employees.map(emp => emp.department))];
  }

  get filteredAndSortedEmployees(): Employee[] {
    let filtered = this.employees.filter(emp => {
      const matchesDepartment = !this.filters.department || emp.department === this.filters.department;
      const matchesStatus = !this.filters.status || emp.status === this.filters.status;
      const matchesSearch = !this.filters.search || 
        emp.name.toLowerCase().includes(this.filters.search.toLowerCase()) ||
        emp.position.toLowerCase().includes(this.filters.search.toLowerCase());
      
      return matchesDepartment && matchesStatus && matchesSearch;
    });

    if (this.sortConfig.key) {
      filtered.sort((a, b) => {
        const aValue = a[this.sortConfig.key as keyof Employee];
        const bValue = b[this.sortConfig.key as keyof Employee];
        
        if (aValue < bValue) {
          return this.sortConfig.direction === 'asc' ? -1 : 1;
        }
        if (aValue > bValue) {
          return this.sortConfig.direction === 'asc' ? 1 : -1;
        }
        return 0;
      });
    }

    return filtered;
  }

  get totalPages(): number {
    return Math.ceil(this.filteredAndSortedEmployees.length / this.itemsPerPage);
  }

  get paginatedEmployees(): Employee[] {
    const startIndex = (this.currentPage - 1) * this.itemsPerPage;
    return this.filteredAndSortedEmployees.slice(startIndex, startIndex + this.itemsPerPage);
  }

  handleSort(key: string): void {
    this.sortConfig = {
      key,
      direction: this.sortConfig.key === key && this.sortConfig.direction === 'asc' ? 'desc' : 'asc'
    };
  }

  handleSelectRow(id: number): void {
    if (this.selectedRows.includes(id)) {
      this.selectedRows = this.selectedRows.filter(rowId => rowId !== id);
    } else {
      this.selectedRows.push(id);
    }
  }

  handleSelectAll(): void {
    if (this.selectedRows.length === this.paginatedEmployees.length) {
      this.selectedRows = [];
    } else {
      this.selectedRows = this.paginatedEmployees.map(emp => emp.id);
    }
  }

  handleBulkAction(action: string): void {
    if (this.selectedRows.length === 0) return;
    
    switch (action) {
      case 'delete':
        this.employees = this.employees.filter(emp => !this.selectedRows.includes(emp.id));
        this.selectedRows = [];
        break;
      case 'export':
        const selectedEmployees = this.employees.filter(emp => this.selectedRows.includes(emp.id));
        console.log('Exporting:', selectedEmployees);
        break;
    }
  }

  editEmployee(id: number): void {
    console.log('Edit', id);
  }

  deleteEmployee(id: number): void {
    console.log('Delete', id);
  }

  formatDate(dateString: string): string {
    return new Date(dateString).toLocaleDateString();
  }

  getSortIcon(key: string): string {
    if (this.sortConfig.key === key) {
      return this.sortConfig.direction === 'asc' ? '↑' : '↓';
    }
    return '';
  }

  isAllSelected(): boolean {
    return this.selectedRows.length === this.paginatedEmployees.length && this.paginatedEmployees.length > 0;
  }

  isRowSelected(id: number): boolean {
    return this.selectedRows.includes(id);
  }
}

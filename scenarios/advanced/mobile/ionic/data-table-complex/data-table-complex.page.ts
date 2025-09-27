import { Component, OnInit } from '@angular/core';
import { AlertController, ToastController } from '@ionic/angular';

interface Employee {
  id: string;
  name: string;
  email: string;
  department: string;
  salary: number;
  status: string;
  joinDate: string;
  selected?: boolean;
}

@Component({
  selector: 'app-data-table-complex',
  templateUrl: './data-table-complex.page.html',
  styleUrls: ['./data-table-complex.page.scss'],
})
export class DataTableComplexPage implements OnInit {
  employees: Employee[] = [];
  filteredData: Employee[] = [];
  currentPageData: Employee[] = [];
  selectedRows: string[] = [];
  searchQuery: string = '';
  sortColumn: string = 'name';
  sortAscending: boolean = true;
  currentPage: number = 1;
  itemsPerPage: number = 10;
  showFilters: boolean = false;
  departmentFilter: string = 'All';
  statusFilter: string = 'All';
  selectAllChecked: boolean = false;
  isLoading: boolean = false;

  get totalPages(): number {
    return Math.ceil(this.filteredData.length / this.itemsPerPage);
  }

  get startIndex(): number {
    return (this.currentPage - 1) * this.itemsPerPage;
  }

  get endIndex(): number {
    return Math.min(this.startIndex + this.itemsPerPage, this.filteredData.length);
  }

  constructor(
    private alertController: AlertController,
    private toastController: ToastController
  ) {}

  ngOnInit() {
    this.loadSampleData();
    this.updateDisplay();
  }

  loadSampleData() {
    this.employees = [
      {
        id: '1',
        name: 'John Doe',
        email: 'john@example.com',
        department: 'Engineering',
        salary: 75000,
        status: 'Active',
        joinDate: '2023-01-15'
      },
      {
        id: '2',
        name: 'Jane Smith',
        email: 'jane@example.com',
        department: 'Marketing',
        salary: 65000,
        status: 'Active',
        joinDate: '2023-02-20'
      },
      {
        id: '3',
        name: 'Mike Johnson',
        email: 'mike@example.com',
        department: 'Sales',
        salary: 70000,
        status: 'Inactive',
        joinDate: '2023-03-10'
      },
      {
        id: '4',
        name: 'Sarah Wilson',
        email: 'sarah@example.com',
        department: 'HR',
        salary: 60000,
        status: 'Active',
        joinDate: '2023-04-05'
      },
      {
        id: '5',
        name: 'David Brown',
        email: 'david@example.com',
        department: 'Finance',
        salary: 80000,
        status: 'Active',
        joinDate: '2023-05-12'
      },
      {
        id: '6',
        name: 'Lisa Davis',
        email: 'lisa@example.com',
        department: 'Engineering',
        salary: 72000,
        status: 'Active',
        joinDate: '2023-06-18'
      },
      {
        id: '7',
        name: 'Tom Miller',
        email: 'tom@example.com',
        department: 'Marketing',
        salary: 68000,
        status: 'Inactive',
        joinDate: '2023-07-22'
      },
      {
        id: '8',
        name: 'Amy Garcia',
        email: 'amy@example.com',
        department: 'Sales',
        salary: 69000,
        status: 'Active',
        joinDate: '2023-08-30'
      },
      {
        id: '9',
        name: 'Chris Lee',
        email: 'chris@example.com',
        department: 'HR',
        salary: 62000,
        status: 'Active',
        joinDate: '2023-09-14'
      },
      {
        id: '10',
        name: 'Emma Taylor',
        email: 'emma@example.com',
        department: 'Finance',
        salary: 78000,
        status: 'Active',
        joinDate: '2023-10-08'
      }
    ];
  }

  updateDisplay() {
    this.applyFilters();
    this.sortData();
    this.updatePagination();
    this.updateSelectAllState();
  }

  applyFilters() {
    this.filteredData = this.employees.filter(emp =>
      (this.searchQuery === '' ||
       emp.name.toLowerCase().includes(this.searchQuery.toLowerCase()) ||
       emp.email.toLowerCase().includes(this.searchQuery.toLowerCase())) &&
      (this.departmentFilter === 'All' || emp.department === this.departmentFilter) &&
      (this.statusFilter === 'All' || emp.status === this.statusFilter)
    );
  }

  sortData() {
    this.filteredData.sort((a, b) => {
      let aValue: any = a[this.sortColumn as keyof Employee];
      let bValue: any = b[this.sortColumn as keyof Employee];

      if (typeof aValue === 'string' && typeof bValue === 'string') {
        return this.sortAscending 
          ? aValue.localeCompare(bValue)
          : bValue.localeCompare(aValue);
      } else if (typeof aValue === 'number' && typeof bValue === 'number') {
        return this.sortAscending 
          ? aValue - bValue
          : bValue - aValue;
      }
      return 0;
    });
  }

  updatePagination() {
    const startIndex = this.startIndex;
    const endIndex = this.endIndex;
    this.currentPageData = this.filteredData.slice(startIndex, endIndex);
  }

  updateSelectAllState() {
    this.selectAllChecked = this.currentPageData.length > 0 && 
      this.currentPageData.every(emp => this.selectedRows.includes(emp.id));
  }

  onSearchChange() {
    this.currentPage = 1;
    this.updateDisplay();
  }

  onFilterChange() {
    this.currentPage = 1;
    this.updateDisplay();
  }

  toggleFilters() {
    this.showFilters = !this.showFilters;
  }

  clearFilters() {
    this.searchQuery = '';
    this.departmentFilter = 'All';
    this.statusFilter = 'All';
    this.currentPage = 1;
    this.showFilters = false;
    this.updateDisplay();
  }

  sort(column: string) {
    if (this.sortColumn === column) {
      this.sortAscending = !this.sortAscending;
    } else {
      this.sortColumn = column;
      this.sortAscending = true;
    }
    this.updateDisplay();
  }

  onSelectAllChange() {
    if (this.selectAllChecked) {
      this.currentPageData.forEach(emp => {
        if (!this.selectedRows.includes(emp.id)) {
          this.selectedRows.push(emp.id);
        }
        emp.selected = true;
      });
    } else {
      this.currentPageData.forEach(emp => {
        const index = this.selectedRows.indexOf(emp.id);
        if (index > -1) {
          this.selectedRows.splice(index, 1);
        }
        emp.selected = false;
      });
    }
  }

  onRowSelectionChange(employeeId: string, isSelected: boolean) {
    if (isSelected) {
      if (!this.selectedRows.includes(employeeId)) {
        this.selectedRows.push(employeeId);
      }
    } else {
      const index = this.selectedRows.indexOf(employeeId);
      if (index > -1) {
        this.selectedRows.splice(index, 1);
      }
    }
    this.updateSelectAllState();
  }

  async rowAction(action: string, employeeId: string) {
    const employee = this.employees.find(emp => emp.id === employeeId);
    const message = `Row action: ${action} on ${employee?.name || employeeId}`;
    
    if (action === 'delete') {
      const alert = await this.alertController.create({
        header: 'Delete Employee',
        message: `Are you sure you want to delete ${employee?.name}?`,
        buttons: [
          {
            text: 'Cancel',
            role: 'cancel'
          },
          {
            text: 'Delete',
            role: 'destructive',
            handler: () => {
              this.employees = this.employees.filter(emp => emp.id !== employeeId);
              const selectedIndex = this.selectedRows.indexOf(employeeId);
              if (selectedIndex > -1) {
                this.selectedRows.splice(selectedIndex, 1);
              }
              this.updateDisplay();
            }
          }
        ]
      });
      await alert.present();
    } else {
      const toast = await this.toastController.create({
        message: message,
        duration: 2000
      });
      await toast.present();
    }
  }

  async bulkAction(action: string) {
    if (this.selectedRows.length === 0) {
      const toast = await this.toastController.create({
        message: 'Please select items to perform bulk actions',
        duration: 2000
      });
      await toast.present();
      return;
    }

    if (action === 'Delete') {
      const alert = await this.alertController.create({
        header: 'Bulk Delete',
        message: `Are you sure you want to delete ${this.selectedRows.length} selected items?`,
        buttons: [
          {
            text: 'Cancel',
            role: 'cancel'
          },
          {
            text: 'Delete',
            role: 'destructive',
            handler: () => {
              this.employees = this.employees.filter(emp => !this.selectedRows.includes(emp.id));
              this.selectedRows = [];
              this.updateDisplay();
            }
          }
        ]
      });
      await alert.present();
    } else {
      const toast = await this.toastController.create({
        message: `Bulk action: ${action} on ${this.selectedRows.length} selected items`,
        duration: 2000
      });
      await toast.present();
    }
  }

  previousPage() {
    if (this.currentPage > 1) {
      this.currentPage--;
      this.updateDisplay();
    }
  }

  nextPage() {
    if (this.currentPage < this.totalPages) {
      this.currentPage++;
      this.updateDisplay();
    }
  }

  onItemsPerPageChange() {
    this.currentPage = 1;
    this.updateDisplay();
  }

  async exportData(format: string) {
    const toast = await this.toastController.create({
      message: `Exporting data as ${format}...`,
      duration: 2000
    });
    await toast.present();
  }

  async refreshData() {
    this.isLoading = true;
    
    // Simulate API call
    setTimeout(() => {
      this.isLoading = false;
      this.updateDisplay();
    }, 1000);
  }
}

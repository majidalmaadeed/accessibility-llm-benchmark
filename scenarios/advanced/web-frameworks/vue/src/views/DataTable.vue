<template>
  <div class="container">
    <div class="page-header">
      <h1 class="page-title">Data Table Complex</h1>
      <p class="page-subtitle">
        Complex data table with sorting, filtering, and pagination
      </p>
    </div>

    <div class="card">
      <h2>Search and Filters</h2>
      <div class="form-row">
        <div class="form-group">
          <input
            type="text"
            class="form-control"
            placeholder="Search all columns..."
            v-model="searchTerm"
          />
        </div>
        <div class="form-group">
          <select class="form-control" v-model="categoryFilter">
            <option value="All">All Categories</option>
            <option value="Electronics">Electronics</option>
            <option value="Clothing">Clothing</option>
            <option value="Books">Books</option>
            <option value="Home">Home</option>
            <option value="Sports">Sports</option>
          </select>
        </div>
        <div class="form-group">
          <select class="form-control" v-model="statusFilter">
            <option value="All">All Status</option>
            <option value="Active">Active</option>
            <option value="Inactive">Inactive</option>
            <option value="Pending">Pending</option>
            <option value="Completed">Completed</option>
          </select>
        </div>
      </div>
      <div class="form-row">
        <div class="form-group">
          <input
            type="number"
            class="form-control"
            placeholder="Min Value"
            v-model.number="minValue"
          />
        </div>
        <div class="form-group">
          <input
            type="number"
            class="form-control"
            placeholder="Max Value"
            v-model.number="maxValue"
          />
        </div>
        <div class="form-group">
          <label>
            <input type="checkbox" v-model="activeOnly" />
            Active Only
          </label>
        </div>
      </div>
      <div class="form-actions">
        <button class="btn btn-secondary" @click="resetFilters">
          Reset Filters
        </button>
      </div>
    </div>

    <div class="card">
      <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 1rem">
        <h2>Data Table</h2>
        <div style="display: flex; gap: 1rem">
          <button class="btn" @click="addRow">Add Row</button>
          <button class="btn btn-secondary" @click="removeSelected" :disabled="selectedItems.length === 0">
            Remove Selected
          </button>
          <button class="btn btn-secondary" @click="clearAll">Clear All</button>
          <button class="btn" @click="exportData">Export</button>
        </div>
      </div>
      <p>Showing {{ filteredData.length }} of {{ data.length }} items</p>

      <div class="table-container">
        <table class="table">
          <thead>
            <tr>
              <th>
                <input
                  type="checkbox"
                  :checked="selectedItems.length === currentPageData.length && currentPageData.length > 0"
                  @change="handleSelectAll"
                />
              </th>
              <th @click="handleSort('id')" style="cursor: pointer">
                ID {{ sortField === 'id' && (sortDirection === 'asc' ? '↑' : '↓') }}
              </th>
              <th @click="handleSort('name')" style="cursor: pointer">
                Name {{ sortField === 'name' && (sortDirection === 'asc' ? '↑' : '↓') }}
              </th>
              <th @click="handleSort('category')" style="cursor: pointer">
                Category {{ sortField === 'category' && (sortDirection === 'asc' ? '↑' : '↓') }}
              </th>
              <th @click="handleSort('status')" style="cursor: pointer">
                Status {{ sortField === 'status' && (sortDirection === 'asc' ? '↑' : '↓') }}
              </th>
              <th @click="handleSort('value')" style="cursor: pointer">
                Value {{ sortField === 'value' && (sortDirection === 'asc' ? '↑' : '↓') }}
              </th>
              <th @click="handleSort('date')" style="cursor: pointer">
                Date {{ sortField === 'date' && (sortDirection === 'asc' ? '↑' : '↓') }}
              </th>
              <th @click="handleSort('active')" style="cursor: pointer">
                Active {{ sortField === 'active' && (sortDirection === 'asc' ? '↑' : '↓') }}
              </th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="item in currentPageData" :key="item.id">
              <td>
                <input
                  type="checkbox"
                  :checked="selectedItems.includes(item.id)"
                  @change="handleSelectItem(item.id)"
                />
              </td>
              <td>{{ item.id }}</td>
              <td>{{ item.name }}</td>
              <td>{{ item.category }}</td>
              <td>{{ item.status }}</td>
              <td>${{ item.value }}</td>
              <td>{{ item.date }}</td>
              <td>{{ item.active }}</td>
            </tr>
          </tbody>
        </table>
      </div>

      <div v-if="totalPages > 1" class="pagination">
        <button @click="setCurrentPage(1)" :disabled="currentPage === 1">
          First
        </button>
        <button @click="setCurrentPage(currentPage - 1)" :disabled="currentPage === 1">
          Previous
        </button>
        <button
          v-for="page in totalPages"
          :key="page"
          @click="setCurrentPage(page)"
          :class="{ active: currentPage === page }"
        >
          {{ page }}
        </button>
        <button @click="setCurrentPage(currentPage + 1)" :disabled="currentPage === totalPages">
          Next
        </button>
        <button @click="setCurrentPage(totalPages)" :disabled="currentPage === totalPages">
          Last
        </button>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'DataTable',
  data() {
    return {
      data: [],
      filteredData: [],
      searchTerm: '',
      categoryFilter: 'All',
      statusFilter: 'All',
      minValue: 0,
      maxValue: 10000,
      activeOnly: false,
      sortField: '',
      sortDirection: 'asc',
      currentPage: 1,
      itemsPerPage: 10,
      selectedItems: []
    }
  },
  computed: {
    totalPages() {
      return Math.ceil(this.filteredData.length / this.itemsPerPage)
    },
    currentPageData() {
      const startIndex = (this.currentPage - 1) * this.itemsPerPage
      return this.filteredData.slice(startIndex, startIndex + this.itemsPerPage)
    }
  },
  watch: {
    searchTerm() { this.applyFilters() },
    categoryFilter() { this.applyFilters() },
    statusFilter() { this.applyFilters() },
    minValue() { this.applyFilters() },
    maxValue() { this.applyFilters() },
    activeOnly() { this.applyFilters() },
    sortField() { this.applyFilters() },
    sortDirection() { this.applyFilters() }
  },
  mounted() {
    this.generateData()
  },
  methods: {
    generateData() {
      const categories = ['Electronics', 'Clothing', 'Books', 'Home', 'Sports']
      const statuses = ['Active', 'Inactive', 'Pending', 'Completed']
      const newData = []

      for (let i = 1; i <= 100; i++) {
        newData.push({
          id: i,
          name: `Item ${i}`,
          category: categories[i % categories.length],
          status: statuses[i % statuses.length],
          value: Math.floor(Math.random() * 1000) + 100,
          date: new Date(Date.now() - Math.random() * 365 * 24 * 60 * 60 * 1000).toISOString().split('T')[0],
          active: Math.random() > 0.3 ? 'Yes' : 'No'
        })
      }

      this.data = newData
    },
    applyFilters() {
      let filtered = [...this.data]

      if (this.searchTerm) {
        filtered = filtered.filter(item =>
          item.name.toLowerCase().includes(this.searchTerm.toLowerCase()) ||
          item.category.toLowerCase().includes(this.searchTerm.toLowerCase()) ||
          item.status.toLowerCase().includes(this.searchTerm.toLowerCase())
        )
      }

      if (this.categoryFilter !== 'All') {
        filtered = filtered.filter(item => item.category === this.categoryFilter)
      }

      if (this.statusFilter !== 'All') {
        filtered = filtered.filter(item => item.status === this.statusFilter)
      }

      filtered = filtered.filter(item => item.value >= this.minValue && item.value <= this.maxValue)

      if (this.activeOnly) {
        filtered = filtered.filter(item => item.active === 'Yes')
      }

      if (this.sortField) {
        filtered.sort((a, b) => {
          let aVal = a[this.sortField]
          let bVal = b[this.sortField]

          if (typeof aVal === 'string') {
            aVal = aVal.toLowerCase()
            bVal = bVal.toLowerCase()
          }

          if (this.sortDirection === 'asc') {
            return aVal > bVal ? 1 : -1
          } else {
            return aVal < bVal ? 1 : -1
          }
        })
      }

      this.filteredData = filtered
      this.currentPage = 1
    },
    handleSort(field) {
      if (this.sortField === field) {
        this.sortDirection = this.sortDirection === 'asc' ? 'desc' : 'asc'
      } else {
        this.sortField = field
        this.sortDirection = 'asc'
      }
    },
    handleSelectItem(itemId) {
      if (this.selectedItems.includes(itemId)) {
        this.selectedItems = this.selectedItems.filter(id => id !== itemId)
      } else {
        this.selectedItems.push(itemId)
      }
    },
    handleSelectAll() {
      if (this.selectedItems.length === this.currentPageData.length) {
        this.selectedItems = []
      } else {
        this.selectedItems = this.currentPageData.map(item => item.id)
      }
    },
    addRow() {
      const newItem = {
        id: Math.max(...this.data.map(item => item.id)) + 1,
        name: 'New Item',
        category: 'Electronics',
        status: 'Active',
        value: 100,
        date: new Date().toISOString().split('T')[0],
        active: 'Yes'
      }
      this.data.push(newItem)
    },
    removeSelected() {
      this.data = this.data.filter(item => !this.selectedItems.includes(item.id))
      this.selectedItems = []
    },
    clearAll() {
      if (window.confirm('Are you sure you want to clear all data?')) {
        this.data = []
        this.selectedItems = []
      }
    },
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
      ].map(row => row.join(',')).join('\n')

      const blob = new Blob([csvContent], { type: 'text/csv' })
      const url = window.URL.createObjectURL(blob)
      const a = document.createElement('a')
      a.href = url
      a.download = 'data.csv'
      a.click()
      window.URL.revokeObjectURL(url)
    },
    resetFilters() {
      this.searchTerm = ''
      this.categoryFilter = 'All'
      this.statusFilter = 'All'
      this.minValue = 0
      this.maxValue = 10000
      this.activeOnly = false
      this.sortField = ''
      this.sortDirection = 'asc'
    },
    setCurrentPage(page) {
      this.currentPage = page
    }
  }
}
</script>

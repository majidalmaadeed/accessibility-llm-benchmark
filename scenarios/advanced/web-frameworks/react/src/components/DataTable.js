import React, { useState, useEffect } from 'react';

const DataTable = () => {
  const [data, setData] = useState([]);
  const [filteredData, setFilteredData] = useState([]);
  const [searchTerm, setSearchTerm] = useState('');
  const [categoryFilter, setCategoryFilter] = useState('All');
  const [statusFilter, setStatusFilter] = useState('All');
  const [minValue, setMinValue] = useState(0);
  const [maxValue, setMaxValue] = useState(10000);
  const [activeOnly, setActiveOnly] = useState(false);
  const [sortField, setSortField] = useState('');
  const [sortDirection, setSortDirection] = useState('asc');
  const [currentPage, setCurrentPage] = useState(1);
  const [itemsPerPage] = useState(10);
  const [selectedItems, setSelectedItems] = useState([]);

  useEffect(() => {
    generateData();
  }, []);

  useEffect(() => {
    applyFilters();
  }, [data, searchTerm, categoryFilter, statusFilter, minValue, maxValue, activeOnly, sortField, sortDirection]);

  const generateData = () => {
    const categories = ['Electronics', 'Clothing', 'Books', 'Home', 'Sports'];
    const statuses = ['Active', 'Inactive', 'Pending', 'Completed'];
    const newData = [];

    for (let i = 1; i <= 100; i++) {
      newData.push({
        id: i,
        name: `Item ${i}`,
        category: categories[i % categories.length],
        status: statuses[i % statuses.length],
        value: Math.floor(Math.random() * 1000) + 100,
        date: new Date(Date.now() - Math.random() * 365 * 24 * 60 * 60 * 1000).toISOString().split('T')[0],
        active: Math.random() > 0.3 ? 'Yes' : 'No'
      });
    }

    setData(newData);
  };

  const applyFilters = () => {
    let filtered = [...data];

    // Search filter
    if (searchTerm) {
      filtered = filtered.filter(item =>
        item.name.toLowerCase().includes(searchTerm.toLowerCase()) ||
        item.category.toLowerCase().includes(searchTerm.toLowerCase()) ||
        item.status.toLowerCase().includes(searchTerm.toLowerCase())
      );
    }

    // Category filter
    if (categoryFilter !== 'All') {
      filtered = filtered.filter(item => item.category === categoryFilter);
    }

    // Status filter
    if (statusFilter !== 'All') {
      filtered = filtered.filter(item => item.status === statusFilter);
    }

    // Value range filter
    filtered = filtered.filter(item => item.value >= minValue && item.value <= maxValue);

    // Active filter
    if (activeOnly) {
      filtered = filtered.filter(item => item.active === 'Yes');
    }

    // Sorting
    if (sortField) {
      filtered.sort((a, b) => {
        let aVal = a[sortField];
        let bVal = b[sortField];

        if (typeof aVal === 'string') {
          aVal = aVal.toLowerCase();
          bVal = bVal.toLowerCase();
        }

        if (sortDirection === 'asc') {
          return aVal > bVal ? 1 : -1;
        } else {
          return aVal < bVal ? 1 : -1;
        }
      });
    }

    setFilteredData(filtered);
    setCurrentPage(1);
  };

  const handleSort = (field) => {
    if (sortField === field) {
      setSortDirection(sortDirection === 'asc' ? 'desc' : 'asc');
    } else {
      setSortField(field);
      setSortDirection('asc');
    }
  };

  const handleSelectItem = (itemId) => {
    setSelectedItems(prev =>
      prev.includes(itemId)
        ? prev.filter(id => id !== itemId)
        : [...prev, itemId]
    );
  };

  const handleSelectAll = () => {
    if (selectedItems.length === currentPageData.length) {
      setSelectedItems([]);
    } else {
      setSelectedItems(currentPageData.map(item => item.id));
    }
  };

  const addRow = () => {
    const newItem = {
      id: Math.max(...data.map(item => item.id)) + 1,
      name: 'New Item',
      category: 'Electronics',
      status: 'Active',
      value: 100,
      date: new Date().toISOString().split('T')[0],
      active: 'Yes'
    };
    setData([...data, newItem]);
  };

  const removeSelected = () => {
    setData(data.filter(item => !selectedItems.includes(item.id)));
    setSelectedItems([]);
  };

  const clearAll = () => {
    if (window.confirm('Are you sure you want to clear all data?')) {
      setData([]);
      setSelectedItems([]);
    }
  };

  const exportData = () => {
    const csvContent = [
      ['ID', 'Name', 'Category', 'Status', 'Value', 'Date', 'Active'],
      ...filteredData.map(item => [
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
  };

  const resetFilters = () => {
    setSearchTerm('');
    setCategoryFilter('All');
    setStatusFilter('All');
    setMinValue(0);
    setMaxValue(10000);
    setActiveOnly(false);
    setSortField('');
    setSortDirection('asc');
  };

  // Pagination
  const totalPages = Math.ceil(filteredData.length / itemsPerPage);
  const startIndex = (currentPage - 1) * itemsPerPage;
  const currentPageData = filteredData.slice(startIndex, startIndex + itemsPerPage);

  return (
    <div className="container">
      <div className="page-header">
        <h1 className="page-title">Data Table Complex</h1>
        <p className="page-subtitle">
          Complex data table with sorting, filtering, and pagination
        </p>
      </div>

      <div className="card">
        <h2>Search and Filters</h2>
        <div className="form-row">
          <div className="form-group">
            <input
              type="text"
              className="form-control"
              placeholder="Search all columns..."
              value={searchTerm}
              onChange={(e) => setSearchTerm(e.target.value)}
            />
          </div>
          <div className="form-group">
            <select
              className="form-control"
              value={categoryFilter}
              onChange={(e) => setCategoryFilter(e.target.value)}
            >
              <option value="All">All Categories</option>
              <option value="Electronics">Electronics</option>
              <option value="Clothing">Clothing</option>
              <option value="Books">Books</option>
              <option value="Home">Home</option>
              <option value="Sports">Sports</option>
            </select>
          </div>
          <div className="form-group">
            <select
              className="form-control"
              value={statusFilter}
              onChange={(e) => setStatusFilter(e.target.value)}
            >
              <option value="All">All Status</option>
              <option value="Active">Active</option>
              <option value="Inactive">Inactive</option>
              <option value="Pending">Pending</option>
              <option value="Completed">Completed</option>
            </select>
          </div>
        </div>
        <div className="form-row">
          <div className="form-group">
            <input
              type="number"
              className="form-control"
              placeholder="Min Value"
              value={minValue}
              onChange={(e) => setMinValue(parseInt(e.target.value) || 0)}
            />
          </div>
          <div className="form-group">
            <input
              type="number"
              className="form-control"
              placeholder="Max Value"
              value={maxValue}
              onChange={(e) => setMaxValue(parseInt(e.target.value) || 10000)}
            />
          </div>
          <div className="form-group">
            <label>
              <input
                type="checkbox"
                checked={activeOnly}
                onChange={(e) => setActiveOnly(e.target.checked)}
              />
              Active Only
            </label>
          </div>
        </div>
        <div className="form-actions">
          <button className="btn btn-secondary" onClick={resetFilters}>
            Reset Filters
          </button>
        </div>
      </div>

      <div className="card">
        <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '1rem' }}>
          <h2>Data Table</h2>
          <div style={{ display: 'flex', gap: '1rem' }}>
            <button className="btn" onClick={addRow}>Add Row</button>
            <button className="btn btn-secondary" onClick={removeSelected} disabled={selectedItems.length === 0}>
              Remove Selected
            </button>
            <button className="btn btn-secondary" onClick={clearAll}>Clear All</button>
            <button className="btn" onClick={exportData}>Export</button>
          </div>
        </div>
        <p>Showing {filteredData.length} of {data.length} items</p>

        <div className="table-container">
          <table className="table">
            <thead>
              <tr>
                <th>
                  <input
                    type="checkbox"
                    checked={selectedItems.length === currentPageData.length && currentPageData.length > 0}
                    onChange={handleSelectAll}
                  />
                </th>
                <th onClick={() => handleSort('id')} style={{ cursor: 'pointer' }}>
                  ID {sortField === 'id' && (sortDirection === 'asc' ? '↑' : '↓')}
                </th>
                <th onClick={() => handleSort('name')} style={{ cursor: 'pointer' }}>
                  Name {sortField === 'name' && (sortDirection === 'asc' ? '↑' : '↓')}
                </th>
                <th onClick={() => handleSort('category')} style={{ cursor: 'pointer' }}>
                  Category {sortField === 'category' && (sortDirection === 'asc' ? '↑' : '↓')}
                </th>
                <th onClick={() => handleSort('status')} style={{ cursor: 'pointer' }}>
                  Status {sortField === 'status' && (sortDirection === 'asc' ? '↑' : '↓')}
                </th>
                <th onClick={() => handleSort('value')} style={{ cursor: 'pointer' }}>
                  Value {sortField === 'value' && (sortDirection === 'asc' ? '↑' : '↓')}
                </th>
                <th onClick={() => handleSort('date')} style={{ cursor: 'pointer' }}>
                  Date {sortField === 'date' && (sortDirection === 'asc' ? '↑' : '↓')}
                </th>
                <th onClick={() => handleSort('active')} style={{ cursor: 'pointer' }}>
                  Active {sortField === 'active' && (sortDirection === 'asc' ? '↑' : '↓')}
                </th>
              </tr>
            </thead>
            <tbody>
              {currentPageData.map(item => (
                <tr key={item.id}>
                  <td>
                    <input
                      type="checkbox"
                      checked={selectedItems.includes(item.id)}
                      onChange={() => handleSelectItem(item.id)}
                    />
                  </td>
                  <td>{item.id}</td>
                  <td>{item.name}</td>
                  <td>{item.category}</td>
                  <td>{item.status}</td>
                  <td>${item.value}</td>
                  <td>{item.date}</td>
                  <td>{item.active}</td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>

        {totalPages > 1 && (
          <div className="pagination">
            <button
              onClick={() => setCurrentPage(1)}
              disabled={currentPage === 1}
            >
              First
            </button>
            <button
              onClick={() => setCurrentPage(currentPage - 1)}
              disabled={currentPage === 1}
            >
              Previous
            </button>
            {Array.from({ length: totalPages }, (_, i) => i + 1).map(page => (
              <button
                key={page}
                onClick={() => setCurrentPage(page)}
                className={currentPage === page ? 'active' : ''}
              >
                {page}
              </button>
            ))}
            <button
              onClick={() => setCurrentPage(currentPage + 1)}
              disabled={currentPage === totalPages}
            >
              Next
            </button>
            <button
              onClick={() => setCurrentPage(totalPages)}
              disabled={currentPage === totalPages}
            >
              Last
            </button>
          </div>
        )}
      </div>
    </div>
  );
};

export default DataTable;

'use client';

import { useState, useEffect } from 'react';
import styles from './DataTableComplex.module.css';

const DataTableComplex = () => {
  const [data, setData] = useState([]);
  const [filteredData, setFilteredData] = useState([]);
  const [sortConfig, setSortConfig] = useState({ key: null, direction: 'asc' });
  const [filters, setFilters] = useState({
    name: '',
    category: '',
    status: '',
    dateRange: ''
  });
  const [selectedRows, setSelectedRows] = useState([]);
  const [currentPage, setCurrentPage] = useState(1);
  const [itemsPerPage] = useState(10);
  const [showFilters, setShowFilters] = useState(false);
  const [isLoading, setIsLoading] = useState(false);

  const sampleData = [
    { id: 1, name: 'Project Alpha', category: 'Development', status: 'Active', priority: 'High', assignee: 'John Doe', startDate: '2024-01-15', endDate: '2024-03-15', progress: 75 },
    { id: 2, name: 'Project Beta', category: 'Design', status: 'Planning', priority: 'Medium', assignee: 'Jane Smith', startDate: '2024-02-01', endDate: '2024-04-01', progress: 25 },
    { id: 3, name: 'Project Gamma', category: 'Testing', status: 'Completed', priority: 'Low', assignee: 'Mike Johnson', startDate: '2024-01-01', endDate: '2024-01-31', progress: 100 },
    { id: 4, name: 'Project Delta', category: 'Development', status: 'Active', priority: 'High', assignee: 'Sarah Wilson', startDate: '2024-02-15', endDate: '2024-05-15', progress: 50 },
    { id: 5, name: 'Project Epsilon', category: 'Research', status: 'Planning', priority: 'Medium', assignee: 'David Brown', startDate: '2024-03-01', endDate: '2024-06-01', progress: 10 },
    { id: 6, name: 'Project Zeta', category: 'Development', status: 'On Hold', priority: 'Low', assignee: 'Lisa Davis', startDate: '2024-01-20', endDate: '2024-04-20', progress: 30 },
    { id: 7, name: 'Project Eta', category: 'Design', status: 'Active', priority: 'High', assignee: 'Tom Wilson', startDate: '2024-02-10', endDate: '2024-04-10', progress: 60 },
    { id: 8, name: 'Project Theta', category: 'Testing', status: 'Completed', priority: 'Medium', assignee: 'Anna Taylor', startDate: '2024-01-05', endDate: '2024-02-05', progress: 100 },
    { id: 9, name: 'Project Iota', category: 'Research', status: 'Planning', priority: 'High', assignee: 'Chris Lee', startDate: '2024-03-15', endDate: '2024-07-15', progress: 5 },
    { id: 10, name: 'Project Kappa', category: 'Development', status: 'Active', priority: 'Medium', assignee: 'Emma Garcia', startDate: '2024-02-20', endDate: '2024-05-20', progress: 40 }
  ];

  useEffect(() => {
    setData(sampleData);
    setFilteredData(sampleData);
  }, []);

  useEffect(() => {
    applyFilters();
  }, [filters, data]);

  const applyFilters = () => {
    let filtered = [...data];

    if (filters.name) {
      filtered = filtered.filter(item => 
        item.name.toLowerCase().includes(filters.name.toLowerCase())
      );
    }

    if (filters.category) {
      filtered = filtered.filter(item => item.category === filters.category);
    }

    if (filters.status) {
      filtered = filtered.filter(item => item.status === filters.status);
    }

    if (filters.dateRange) {
      const today = new Date();
      const days = parseInt(filters.dateRange);
      const cutoffDate = new Date(today.getTime() - (days * 24 * 60 * 60 * 1000));
      
      filtered = filtered.filter(item => {
        const startDate = new Date(item.startDate);
        return startDate >= cutoffDate;
      });
    }

    setFilteredData(filtered);
    setCurrentPage(1);
  };

  const handleSort = (key) => {
    let direction = 'asc';
    if (sortConfig.key === key && sortConfig.direction === 'asc') {
      direction = 'desc';
    }
    setSortConfig({ key, direction });

    const sorted = [...filteredData].sort((a, b) => {
      if (a[key] < b[key]) {
        return direction === 'asc' ? -1 : 1;
      }
      if (a[key] > b[key]) {
        return direction === 'asc' ? 1 : -1;
      }
      return 0;
    });

    setFilteredData(sorted);
  };

  const handleSelectRow = (id) => {
    setSelectedRows(prev => 
      prev.includes(id) 
        ? prev.filter(rowId => rowId !== id)
        : [...prev, id]
    );
  };

  const handleSelectAll = () => {
    if (selectedRows.length === paginatedData.length) {
      setSelectedRows([]);
    } else {
      setSelectedRows(paginatedData.map(item => item.id));
    }
  };

  const handleBulkAction = (action) => {
    if (selectedRows.length === 0) return;

    setIsLoading(true);
    setTimeout(() => {
      console.log(`Bulk action: ${action} on rows:`, selectedRows);
      setSelectedRows([]);
      setIsLoading(false);
      alert(`Bulk action "${action}" completed for ${selectedRows.length} items`);
    }, 1000);
  };

  const handleExport = (format) => {
    setIsLoading(true);
    setTimeout(() => {
      console.log(`Exporting data as ${format}:`, filteredData);
      setIsLoading(false);
      alert(`Data exported as ${format.toUpperCase()} successfully!`);
    }, 1500);
  };

  const getStatusColor = (status) => {
    switch (status) {
      case 'Active': return '#4caf50';
      case 'Planning': return '#ff9800';
      case 'Completed': return '#2196f3';
      case 'On Hold': return '#f44336';
      default: return '#666';
    }
  };

  const getPriorityColor = (priority) => {
    switch (priority) {
      case 'High': return '#f44336';
      case 'Medium': return '#ff9800';
      case 'Low': return '#4caf50';
      default: return '#666';
    }
  };

  const totalPages = Math.ceil(filteredData.length / itemsPerPage);
  const startIndex = (currentPage - 1) * itemsPerPage;
  const paginatedData = filteredData.slice(startIndex, startIndex + itemsPerPage);

  const categories = [...new Set(data.map(item => item.category))];
  const statuses = [...new Set(data.map(item => item.status))];

  return (
    <div className={styles.dataTableContainer}>
      <div className={styles.tableHeader}>
        <h2>Project Management Dashboard</h2>
        <div className={styles.headerActions}>
          <button 
            onClick={() => setShowFilters(!showFilters)}
            className={styles.filterToggle}
          >
            {showFilters ? 'Hide' : 'Show'} Filters
          </button>
          <button 
            onClick={() => handleExport('csv')}
            disabled={isLoading}
            className={styles.exportBtn}
          >
            {isLoading ? 'Exporting...' : 'Export CSV'}
          </button>
          <button 
            onClick={() => handleExport('pdf')}
            disabled={isLoading}
            className={styles.exportBtn}
          >
            {isLoading ? 'Exporting...' : 'Export PDF'}
          </button>
        </div>
      </div>

      {showFilters && (
        <div className={styles.filtersPanel}>
          <div className={styles.filterRow}>
            <div className={styles.filterGroup}>
              <input
                type="text"
                placeholder="Search by name..."
                value={filters.name}
                onChange={(e) => setFilters(prev => ({ ...prev, name: e.target.value }))}
                className={styles.filterInput}
              />
            </div>
            <div className={styles.filterGroup}>
              <select
                value={filters.category}
                onChange={(e) => setFilters(prev => ({ ...prev, category: e.target.value }))}
                className={styles.filterSelect}
              >
                <option value="">All Categories</option>
                {categories.map(category => (
                  <option key={category} value={category}>{category}</option>
                ))}
              </select>
            </div>
            <div className={styles.filterGroup}>
              <select
                value={filters.status}
                onChange={(e) => setFilters(prev => ({ ...prev, status: e.target.value }))}
                className={styles.filterSelect}
              >
                <option value="">All Statuses</option>
                {statuses.map(status => (
                  <option key={status} value={status}>{status}</option>
                ))}
              </select>
            </div>
            <div className={styles.filterGroup}>
              <select
                value={filters.dateRange}
                onChange={(e) => setFilters(prev => ({ ...prev, dateRange: e.target.value }))}
                className={styles.filterSelect}
              >
                <option value="">All Time</option>
                <option value="7">Last 7 days</option>
                <option value="30">Last 30 days</option>
                <option value="90">Last 90 days</option>
              </select>
            </div>
          </div>
        </div>
      )}

      {selectedRows.length > 0 && (
        <div className={styles.bulkActions}>
          <span className={styles.selectedCount}>
            {selectedRows.length} item{selectedRows.length !== 1 ? 's' : ''} selected
          </span>
          <div className={styles.bulkButtons}>
            <button 
              onClick={() => handleBulkAction('Delete')}
              className={styles.bulkBtn}
            >
              Delete
            </button>
            <button 
              onClick={() => handleBulkAction('Archive')}
              className={styles.bulkBtn}
            >
              Archive
            </button>
            <button 
              onClick={() => handleBulkAction('Export')}
              className={styles.bulkBtn}
            >
              Export Selected
            </button>
          </div>
        </div>
      )}

      <div className={styles.tableWrapper}>
        <table className={styles.dataTable}>
          <thead>
            <tr>
              <th className={styles.checkboxColumn}>
                <input
                  type="checkbox"
                  checked={selectedRows.length === paginatedData.length && paginatedData.length > 0}
                  onChange={handleSelectAll}
                />
              </th>
              <th 
                className={styles.sortableHeader}
                onClick={() => handleSort('name')}
              >
                Project Name
                {sortConfig.key === 'name' && (
                  <span className={styles.sortIndicator}>
                    {sortConfig.direction === 'asc' ? '↑' : '↓'}
                  </span>
                )}
              </th>
              <th 
                className={styles.sortableHeader}
                onClick={() => handleSort('category')}
              >
                Category
                {sortConfig.key === 'category' && (
                  <span className={styles.sortIndicator}>
                    {sortConfig.direction === 'asc' ? '↑' : '↓'}
                  </span>
                )}
              </th>
              <th 
                className={styles.sortableHeader}
                onClick={() => handleSort('status')}
              >
                Status
                {sortConfig.key === 'status' && (
                  <span className={styles.sortIndicator}>
                    {sortConfig.direction === 'asc' ? '↑' : '↓'}
                  </span>
                )}
              </th>
              <th 
                className={styles.sortableHeader}
                onClick={() => handleSort('priority')}
              >
                Priority
                {sortConfig.key === 'priority' && (
                  <span className={styles.sortIndicator}>
                    {sortConfig.direction === 'asc' ? '↑' : '↓'}
                  </span>
                )}
              </th>
              <th 
                className={styles.sortableHeader}
                onClick={() => handleSort('assignee')}
              >
                Assignee
                {sortConfig.key === 'assignee' && (
                  <span className={styles.sortIndicator}>
                    {sortConfig.direction === 'asc' ? '↑' : '↓'}
                  </span>
                )}
              </th>
              <th 
                className={styles.sortableHeader}
                onClick={() => handleSort('startDate')}
              >
                Start Date
                {sortConfig.key === 'startDate' && (
                  <span className={styles.sortIndicator}>
                    {sortConfig.direction === 'asc' ? '↑' : '↓'}
                  </span>
                )}
              </th>
              <th 
                className={styles.sortableHeader}
                onClick={() => handleSort('progress')}
              >
                Progress
                {sortConfig.key === 'progress' && (
                  <span className={styles.sortIndicator}>
                    {sortConfig.direction === 'asc' ? '↑' : '↓'}
                  </span>
                )}
              </th>
              <th className={styles.actionsColumn}>Actions</th>
            </tr>
          </thead>
          <tbody>
            {paginatedData.map((item) => (
              <tr 
                key={item.id}
                className={`${styles.tableRow} ${selectedRows.includes(item.id) ? styles.selectedRow : ''}`}
              >
                <td className={styles.checkboxColumn}>
                  <input
                    type="checkbox"
                    checked={selectedRows.includes(item.id)}
                    onChange={() => handleSelectRow(item.id)}
                  />
                </td>
                <td className={styles.nameCell}>
                  <div className={styles.projectName}>{item.name}</div>
                  <div className={styles.projectId}>ID: {item.id}</div>
                </td>
                <td className={styles.categoryCell}>
                  <span className={styles.categoryTag}>{item.category}</span>
                </td>
                <td className={styles.statusCell}>
                  <span 
                    className={styles.statusBadge}
                    style={{ backgroundColor: getStatusColor(item.status) }}
                  >
                    {item.status}
                  </span>
                </td>
                <td className={styles.priorityCell}>
                  <span 
                    className={styles.priorityBadge}
                    style={{ backgroundColor: getPriorityColor(item.priority) }}
                  >
                    {item.priority}
                  </span>
                </td>
                <td className={styles.assigneeCell}>
                  <div className={styles.assigneeInfo}>
                    <div className={styles.assigneeName}>{item.assignee}</div>
                  </div>
                </td>
                <td className={styles.dateCell}>
                  <div className={styles.dateInfo}>
                    <div className={styles.startDate}>{item.startDate}</div>
                    <div className={styles.endDate}>End: {item.endDate}</div>
                  </div>
                </td>
                <td className={styles.progressCell}>
                  <div className={styles.progressContainer}>
                    <div className={styles.progressBar}>
                      <div 
                        className={styles.progressFill}
                        style={{ width: `${item.progress}%` }}
                      />
                    </div>
                    <span className={styles.progressText}>{item.progress}%</span>
                  </div>
                </td>
                <td className={styles.actionsCell}>
                  <div className={styles.actionButtons}>
                    <button className={styles.actionBtn}>Edit</button>
                    <button className={styles.actionBtn}>View</button>
                    <button className={styles.actionBtn}>Delete</button>
                  </div>
                </td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>

      <div className={styles.tableFooter}>
        <div className={styles.paginationInfo}>
          Showing {startIndex + 1} to {Math.min(startIndex + itemsPerPage, filteredData.length)} of {filteredData.length} entries
        </div>
        <div className={styles.pagination}>
          <button 
            onClick={() => setCurrentPage(prev => Math.max(1, prev - 1))}
            disabled={currentPage === 1}
            className={styles.paginationBtn}
          >
            Previous
          </button>
          {Array.from({ length: totalPages }, (_, i) => i + 1).map(page => (
            <button
              key={page}
              onClick={() => setCurrentPage(page)}
              className={`${styles.paginationBtn} ${currentPage === page ? styles.activePage : ''}`}
            >
              {page}
            </button>
          ))}
          <button 
            onClick={() => setCurrentPage(prev => Math.min(totalPages, prev + 1))}
            disabled={currentPage === totalPages}
            className={styles.paginationBtn}
          >
            Next
          </button>
        </div>
      </div>
    </div>
  );
};

export default DataTableComplex;

import React, { useState, useMemo } from 'react';
import './DataTableComplex.css';

const DataTableComplex = () => {
  const [employees, setEmployees] = useState([
    { id: 1, name: 'John Doe', department: 'Engineering', position: 'Senior Developer', salary: 95000, status: 'active', startDate: '2022-01-15' },
    { id: 2, name: 'Jane Smith', department: 'Marketing', position: 'Marketing Manager', salary: 78000, status: 'active', startDate: '2021-08-20' },
    { id: 3, name: 'Mike Johnson', department: 'Sales', position: 'Sales Representative', salary: 65000, status: 'inactive', startDate: '2023-03-10' },
    { id: 4, name: 'Sarah Wilson', department: 'HR', position: 'HR Specialist', salary: 72000, status: 'active', startDate: '2022-11-05' },
    { id: 5, name: 'David Brown', department: 'Engineering', position: 'Junior Developer', salary: 68000, status: 'active', startDate: '2023-06-01' },
    { id: 6, name: 'Lisa Davis', department: 'Finance', position: 'Financial Analyst', salary: 82000, status: 'active', startDate: '2021-12-15' },
    { id: 7, name: 'Tom Anderson', department: 'Sales', position: 'Sales Manager', salary: 88000, status: 'active', startDate: '2020-09-30' },
    { id: 8, name: 'Emma Taylor', department: 'Engineering', position: 'DevOps Engineer', salary: 92000, status: 'active', startDate: '2022-04-12' }
  ]);

  const [sortConfig, setSortConfig] = useState({ key: null, direction: 'asc' });
  const [filters, setFilters] = useState({
    department: '',
    status: '',
    search: ''
  });
  const [selectedRows, setSelectedRows] = useState([]);
  const [currentPage, setCurrentPage] = useState(1);
  const [itemsPerPage] = useState(5);

  // Filter and sort employees
  const filteredAndSortedEmployees = useMemo(() => {
    let filtered = employees.filter(emp => {
      const matchesDepartment = !filters.department || emp.department === filters.department;
      const matchesStatus = !filters.status || emp.status === filters.status;
      const matchesSearch = !filters.search || 
        emp.name.toLowerCase().includes(filters.search.toLowerCase()) ||
        emp.position.toLowerCase().includes(filters.search.toLowerCase());
      
      return matchesDepartment && matchesStatus && matchesSearch;
    });

    if (sortConfig.key) {
      filtered.sort((a, b) => {
        if (a[sortConfig.key] < b[sortConfig.key]) {
          return sortConfig.direction === 'asc' ? -1 : 1;
        }
        if (a[sortConfig.key] > b[sortConfig.key]) {
          return sortConfig.direction === 'asc' ? 1 : -1;
        }
        return 0;
      });
    }

    return filtered;
  }, [employees, filters, sortConfig]);

  // Pagination
  const totalPages = Math.ceil(filteredAndSortedEmployees.length / itemsPerPage);
  const startIndex = (currentPage - 1) * itemsPerPage;
  const paginatedEmployees = filteredAndSortedEmployees.slice(startIndex, startIndex + itemsPerPage);

  const handleSort = (key) => {
    setSortConfig(prev => ({
      key,
      direction: prev.key === key && prev.direction === 'asc' ? 'desc' : 'asc'
    }));
  };

  const handleSelectRow = (id) => {
    setSelectedRows(prev => 
      prev.includes(id) 
        ? prev.filter(rowId => rowId !== id)
        : [...prev, id]
    );
  };

  const handleSelectAll = () => {
    setSelectedRows(prev => 
      prev.length === paginatedEmployees.length 
        ? [] 
        : paginatedEmployees.map(emp => emp.id)
    );
  };

  const handleBulkAction = (action) => {
    if (selectedRows.length === 0) return;
    
    switch (action) {
      case 'delete':
        setEmployees(prev => prev.filter(emp => !selectedRows.includes(emp.id)));
        setSelectedRows([]);
        break;
      case 'export':
        const selectedEmployees = employees.filter(emp => selectedRows.includes(emp.id));
        console.log('Exporting:', selectedEmployees);
        break;
      default:
        break;
    }
  };

  const departments = [...new Set(employees.map(emp => emp.department))];

  return (
    <div className="data-table-container">
      <div className="table-header">
        <h2>Employee Management System</h2>
        <div className="bulk-actions">
          <button 
            onClick={() => handleBulkAction('export')}
            disabled={selectedRows.length === 0}
          >
            Export Selected
          </button>
          <button 
            onClick={() => handleBulkAction('delete')}
            disabled={selectedRows.length === 0}
            className="delete-btn"
          >
            Delete Selected
          </button>
        </div>
      </div>

      <div className="filters">
        <input
          type="text"
          placeholder="Search employees..."
          value={filters.search}
          onChange={(e) => setFilters(prev => ({ ...prev, search: e.target.value }))}
        />
        
        <select
          value={filters.department}
          onChange={(e) => setFilters(prev => ({ ...prev, department: e.target.value }))}
        >
          <option value="">All Departments</option>
          {departments.map(dept => (
            <option key={dept} value={dept}>{dept}</option>
          ))}
        </select>

        <select
          value={filters.status}
          onChange={(e) => setFilters(prev => ({ ...prev, status: e.target.value }))}
        >
          <option value="">All Status</option>
          <option value="active">Active</option>
          <option value="inactive">Inactive</option>
        </select>
      </div>

      <div className="table-wrapper">
        <table>
          <thead>
            <tr>
              <th>
                <input
                  type="checkbox"
                  checked={selectedRows.length === paginatedEmployees.length && paginatedEmployees.length > 0}
                  onChange={handleSelectAll}
                />
              </th>
              <th onClick={() => handleSort('name')}>
                Name
                {sortConfig.key === 'name' && (
                  <span>{sortConfig.direction === 'asc' ? '↑' : '↓'}</span>
                )}
              </th>
              <th onClick={() => handleSort('department')}>
                Department
                {sortConfig.key === 'department' && (
                  <span>{sortConfig.direction === 'asc' ? '↑' : '↓'}</span>
                )}
              </th>
              <th onClick={() => handleSort('position')}>
                Position
                {sortConfig.key === 'position' && (
                  <span>{sortConfig.direction === 'asc' ? '↑' : '↓'}</span>
                )}
              </th>
              <th onClick={() => handleSort('salary')}>
                Salary
                {sortConfig.key === 'salary' && (
                  <span>{sortConfig.direction === 'asc' ? '↑' : '↓'}</span>
                )}
              </th>
              <th onClick={() => handleSort('status')}>
                Status
                {sortConfig.key === 'status' && (
                  <span>{sortConfig.direction === 'asc' ? '↑' : '↓'}</span>
                )}
              </th>
              <th onClick={() => handleSort('startDate')}>
                Start Date
                {sortConfig.key === 'startDate' && (
                  <span>{sortConfig.direction === 'asc' ? '↑' : '↓'}</span>
                )}
              </th>
              <th>Actions</th>
            </tr>
          </thead>
          <tbody>
            {paginatedEmployees.map(employee => (
              <tr key={employee.id} className={selectedRows.includes(employee.id) ? 'selected' : ''}>
                <td>
                  <input
                    type="checkbox"
                    checked={selectedRows.includes(employee.id)}
                    onChange={() => handleSelectRow(employee.id)}
                  />
                </td>
                <td>{employee.name}</td>
                <td>{employee.department}</td>
                <td>{employee.position}</td>
                <td>${employee.salary.toLocaleString()}</td>
                <td>
                  <span className={`status ${employee.status}`}>
                    {employee.status === 'active' ? '●' : '○'}
                  </span>
                </td>
                <td>{new Date(employee.startDate).toLocaleDateString()}</td>
                <td>
                  <button onClick={() => console.log('Edit', employee.id)}>Edit</button>
                  <button onClick={() => console.log('Delete', employee.id)}>Delete</button>
                </td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>

      <div className="pagination">
        <button 
          onClick={() => setCurrentPage(prev => Math.max(1, prev - 1))}
          disabled={currentPage === 1}
        >
          Previous
        </button>
        
        <span>
          Page {currentPage} of {totalPages} 
          ({filteredAndSortedEmployees.length} total employees)
        </span>
        
        <button 
          onClick={() => setCurrentPage(prev => Math.min(totalPages, prev + 1))}
          disabled={currentPage === totalPages}
        >
          Next
        </button>
      </div>

      {selectedRows.length > 0 && (
        <div className="selection-info">
          {selectedRows.length} employee(s) selected
        </div>
      )}
    </div>
  );
};

export default DataTableComplex;

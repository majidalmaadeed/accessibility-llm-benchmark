import React, { useState } from 'react';

const MissingTableHeader = () => {
  const [employees] = useState([
    { id: 1, name: 'John Smith', department: 'Engineering', position: 'Senior Developer', salary: 95000, status: 'Active' },
    { id: 2, name: 'Sarah Johnson', department: 'Marketing', position: 'Marketing Manager', salary: 78000, status: 'Active' },
    { id: 3, name: 'Mike Wilson', department: 'Sales', position: 'Sales Representative', salary: 65000, status: 'Active' },
    { id: 4, name: 'Emily Davis', department: 'HR', position: 'HR Specialist', salary: 60000, status: 'Active' },
    { id: 5, name: 'David Brown', department: 'Finance', position: 'Financial Analyst', salary: 70000, status: 'Active' }
  ]);

  const [sortField, setSortField] = useState(null);
  const [sortDirection, setSortDirection] = useState('asc');

  const handleSort = (field) => {
    if (sortField === field) {
      setSortDirection(sortDirection === 'asc' ? 'desc' : 'asc');
    } else {
      setSortField(field);
      setSortDirection('asc');
    }
  };

  const sortedEmployees = [...employees].sort((a, b) => {
    if (!sortField) return 0;
    
    const aValue = a[sortField];
    const bValue = b[sortField];
    
    if (typeof aValue === 'string') {
      return sortDirection === 'asc' 
        ? aValue.localeCompare(bValue)
        : bValue.localeCompare(aValue);
    }
    
    return sortDirection === 'asc' ? aValue - bValue : bValue - aValue;
  });

  return (
    <div style={{ 
      maxWidth: '1000px', 
      margin: '50px auto', 
      padding: '20px',
      fontFamily: 'Arial, sans-serif'
    }}>
      <h1>Employee Directory</h1>
      <p>View and manage employee information across all departments.</p>
      
      <div style={{
        background: '#f8f9fa',
        padding: '20px',
        borderRadius: '8px',
        marginBottom: '30px'
      }}>
        <h2>Department Statistics</h2>
        <div style={{
          display: 'grid',
          gridTemplateColumns: 'repeat(auto-fit, minmax(200px, 1fr))',
          gap: '20px',
          marginTop: '15px'
        }}>
          <div style={{
            background: 'white',
            padding: '15px',
            borderRadius: '4px',
            textAlign: 'center',
            border: '1px solid #e0e0e0'
          }}>
            <div style={{ fontSize: '24px', fontWeight: 'bold', color: '#007bff' }}>5</div>
            <div style={{ fontSize: '14px', color: '#666' }}>Total Employees</div>
          </div>
          <div style={{
            background: 'white',
            padding: '15px',
            borderRadius: '4px',
            textAlign: 'center',
            border: '1px solid #e0e0e0'
          }}>
            <div style={{ fontSize: '24px', fontWeight: 'bold', color: '#28a745' }}>4</div>
            <div style={{ fontSize: '14px', color: '#666' }}>Departments</div>
          </div>
          <div style={{
            background: 'white',
            padding: '15px',
            borderRadius: '4px',
            textAlign: 'center',
            border: '1px solid #e0e0e0'
          }}>
            <div style={{ fontSize: '24px', fontWeight: 'bold', color: '#ffc107' }}>$73,600</div>
            <div style={{ fontSize: '14px', color: '#666' }}>Average Salary</div>
          </div>
        </div>
      </div>

      <div style={{
        background: 'white',
        borderRadius: '8px',
        boxShadow: '0 2px 8px rgba(0,0,0,0.1)',
        overflow: 'hidden',
        border: '1px solid #e0e0e0'
      }}>
        <div style={{
          background: '#f8f9fa',
          padding: '20px',
          borderBottom: '1px solid #e0e0e0'
        }}>
          <h2 style={{ margin: 0, fontSize: '20px' }}>Employee List</h2>
          <p style={{ margin: '5px 0 0 0', color: '#666', fontSize: '14px' }}>
            Click on column headers to sort the data
          </p>
        </div>
        
        <div style={{ overflowX: 'auto' }}>
          <table style={{
            width: '100%',
            borderCollapse: 'collapse',
            fontSize: '14px'
          }}>
            <tbody>
              {/* Using td elements instead of th for column headers */}
              <tr style={{
                background: '#e9ecef',
                borderBottom: '2px solid #dee2e6'
              }}>
                <td 
                  style={{
                    padding: '12px 16px',
                    fontWeight: 'bold',
                    cursor: 'pointer',
                    userSelect: 'none',
                    borderRight: '1px solid #dee2e6'
                  }}
                  onClick={() => handleSort('name')}
                >
                  Name {sortField === 'name' && (sortDirection === 'asc' ? '↑' : '↓')}
                </td>
                <td 
                  style={{
                    padding: '12px 16px',
                    fontWeight: 'bold',
                    cursor: 'pointer',
                    userSelect: 'none',
                    borderRight: '1px solid #dee2e6'
                  }}
                  onClick={() => handleSort('department')}
                >
                  Department {sortField === 'department' && (sortDirection === 'asc' ? '↑' : '↓')}
                </td>
                <td 
                  style={{
                    padding: '12px 16px',
                    fontWeight: 'bold',
                    cursor: 'pointer',
                    userSelect: 'none',
                    borderRight: '1px solid #dee2e6'
                  }}
                  onClick={() => handleSort('position')}
                >
                  Position {sortField === 'position' && (sortDirection === 'asc' ? '↑' : '↓')}
                </td>
                <td 
                  style={{
                    padding: '12px 16px',
                    fontWeight: 'bold',
                    cursor: 'pointer',
                    userSelect: 'none',
                    borderRight: '1px solid #dee2e6'
                  }}
                  onClick={() => handleSort('salary')}
                >
                  Salary {sortField === 'salary' && (sortDirection === 'asc' ? '↑' : '↓')}
                </td>
                <td 
                  style={{
                    padding: '12px 16px',
                    fontWeight: 'bold',
                    cursor: 'pointer',
                    userSelect: 'none'
                  }}
                  onClick={() => handleSort('status')}
                >
                  Status {sortField === 'status' && (sortDirection === 'asc' ? '↑' : '↓')}
                </td>
              </tr>
              {sortedEmployees.map((employee, index) => (
                <tr 
                  key={employee.id}
                  style={{
                    borderBottom: '1px solid #e0e0e0',
                    background: index % 2 === 0 ? 'white' : '#f8f9fa'
                  }}
                >
                  <td style={{ padding: '12px 16px', borderRight: '1px solid #e0e0e0' }}>
                    {employee.name}
                  </td>
                  <td style={{ padding: '12px 16px', borderRight: '1px solid #e0e0e0' }}>
                    <span style={{
                      background: '#e3f2fd',
                      color: '#1976d2',
                      padding: '4px 8px',
                      borderRadius: '12px',
                      fontSize: '12px',
                      fontWeight: 'bold'
                    }}>
                      {employee.department}
                    </span>
                  </td>
                  <td style={{ padding: '12px 16px', borderRight: '1px solid #e0e0e0' }}>
                    {employee.position}
                  </td>
                  <td style={{ padding: '12px 16px', borderRight: '1px solid #e0e0e0' }}>
                    ${employee.salary.toLocaleString()}
                  </td>
                  <td style={{ padding: '12px 16px' }}>
                    <span style={{
                      background: '#e8f5e8',
                      color: '#2e7d32',
                      padding: '4px 8px',
                      borderRadius: '12px',
                      fontSize: '12px',
                      fontWeight: 'bold'
                    }}>
                      {employee.status}
                    </span>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      </div>
    </div>
  );
};

export default MissingTableHeader;

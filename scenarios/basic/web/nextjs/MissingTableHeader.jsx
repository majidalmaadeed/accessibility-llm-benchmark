import { useState } from 'react';

export default function MissingTableHeader() {
  const [selectedYear, setSelectedYear] = useState('2024');
  const [selectedQuarter, setSelectedQuarter] = useState('Q1');
  const [sortBy, setSortBy] = useState('revenue');
  const [sortOrder, setSortOrder] = useState('desc');
  const [currentPage, setCurrentPage] = useState(1);
  const itemsPerPage = 10;

  const years = ['2024', '2023', '2022', '2021', '2020'];
  const quarters = ['Q1', 'Q2', 'Q3', 'Q4'];

  const salesData = [
    {
      id: 1,
      region: 'North America',
      product: 'Software License',
      revenue: 1250000,
      units: 2500,
      growth: 12.5,
      quarter: 'Q1',
      year: '2024'
    },
    {
      id: 2,
      region: 'Europe',
      product: 'Software License',
      revenue: 980000,
      units: 1960,
      growth: 8.3,
      quarter: 'Q1',
      year: '2024'
    },
    {
      id: 3,
      region: 'Asia Pacific',
      product: 'Software License',
      revenue: 1450000,
      units: 2900,
      growth: 15.7,
      quarter: 'Q1',
      year: '2024'
    },
    {
      id: 4,
      region: 'North America',
      product: 'Support Services',
      revenue: 320000,
      units: 800,
      growth: 5.2,
      quarter: 'Q1',
      year: '2024'
    },
    {
      id: 5,
      region: 'Europe',
      product: 'Support Services',
      revenue: 280000,
      units: 700,
      growth: 3.8,
      quarter: 'Q1',
      year: '2024'
    },
    {
      id: 6,
      region: 'Asia Pacific',
      product: 'Support Services',
      revenue: 380000,
      units: 950,
      growth: 9.1,
      quarter: 'Q1',
      year: '2024'
    },
    {
      id: 7,
      region: 'North America',
      product: 'Consulting',
      revenue: 450000,
      units: 150,
      growth: 18.2,
      quarter: 'Q1',
      year: '2024'
    },
    {
      id: 8,
      region: 'Europe',
      product: 'Consulting',
      revenue: 320000,
      units: 107,
      growth: 14.5,
      quarter: 'Q1',
      year: '2024'
    },
    {
      id: 9,
      region: 'Asia Pacific',
      product: 'Consulting',
      revenue: 280000,
      units: 93,
      growth: 22.1,
      quarter: 'Q1',
      year: '2024'
    },
    {
      id: 10,
      region: 'Latin America',
      product: 'Software License',
      revenue: 180000,
      units: 360,
      growth: 25.3,
      quarter: 'Q1',
      year: '2024'
    },
    {
      id: 11,
      region: 'Latin America',
      product: 'Support Services',
      revenue: 45000,
      units: 113,
      growth: 12.8,
      quarter: 'Q1',
      year: '2024'
    },
    {
      id: 12,
      region: 'Middle East & Africa',
      product: 'Software License',
      revenue: 120000,
      units: 240,
      growth: 8.7,
      quarter: 'Q1',
      year: '2024'
    }
  ];

  const filteredData = salesData.filter(item => 
    item.year === selectedYear && item.quarter === selectedQuarter
  );

  const sortedData = [...filteredData].sort((a, b) => {
    let aValue = a[sortBy];
    let bValue = b[sortBy];
    
    if (typeof aValue === 'string') {
      aValue = aValue.toLowerCase();
      bValue = bValue.toLowerCase();
    }
    
    if (sortOrder === 'asc') {
      return aValue > bValue ? 1 : -1;
    } else {
      return aValue < bValue ? 1 : -1;
    }
  });

  const totalPages = Math.ceil(sortedData.length / itemsPerPage);
  const paginatedData = sortedData.slice(
    (currentPage - 1) * itemsPerPage, 
    currentPage * itemsPerPage
  );

  const totalRevenue = filteredData.reduce((sum, item) => sum + item.revenue, 0);
  const totalUnits = filteredData.reduce((sum, item) => sum + item.units, 0);
  const averageGrowth = filteredData.reduce((sum, item) => sum + item.growth, 0) / filteredData.length;

  const handleSort = (column) => {
    if (sortBy === column) {
      setSortOrder(sortOrder === 'asc' ? 'desc' : 'asc');
    } else {
      setSortBy(column);
      setSortOrder('asc');
    }
    setCurrentPage(1);
  };

  const formatCurrency = (amount) => {
    return new Intl.NumberFormat('en-US', {
      style: 'currency',
      currency: 'USD',
      minimumFractionDigits: 0,
      maximumFractionDigits: 0
    }).format(amount);
  };

  const formatNumber = (num) => {
    return new Intl.NumberFormat('en-US').format(num);
  };

  const goToPage = (page) => {
    setCurrentPage(page);
  };

  const nextPage = () => {
    if (currentPage < totalPages) {
      setCurrentPage(currentPage + 1);
    }
  };

  const prevPage = () => {
    if (currentPage > 1) {
      setCurrentPage(currentPage - 1);
    }
  };

  return (
    <div className="sales-dashboard">
      <header className="dashboard-header">
        <h1>Sales Performance Dashboard</h1>
        <p>Comprehensive view of sales data across all regions and products</p>
      </header>

      <div className="dashboard-controls">
        <div className="filter-controls">
          <div className="filter-group">
            <label htmlFor="year-select">Year:</label>
            <select 
              id="year-select" 
              value={selectedYear} 
              onChange={(e) => setSelectedYear(e.target.value)}
              className="filter-select"
            >
              {years.map(year => (
                <option key={year} value={year}>{year}</option>
              ))}
            </select>
          </div>

          <div className="filter-group">
            <label htmlFor="quarter-select">Quarter:</label>
            <select 
              id="quarter-select" 
              value={selectedQuarter} 
              onChange={(e) => setSelectedQuarter(e.target.value)}
              className="filter-select"
            >
              {quarters.map(quarter => (
                <option key={quarter} value={quarter}>{quarter}</option>
              ))}
            </select>
          </div>
        </div>

        <div className="view-controls">
          <button className="export-btn">Export Data</button>
          <button className="refresh-btn">Refresh</button>
        </div>
      </div>

      <div className="summary-cards">
        <div className="summary-card">
          <div className="card-icon">💰</div>
          <div className="card-content">
            <div className="card-title">Total Revenue</div>
            <div className="card-value">{formatCurrency(totalRevenue)}</div>
          </div>
        </div>

        <div className="summary-card">
          <div className="card-icon">📦</div>
          <div className="card-content">
            <div className="card-title">Total Units</div>
            <div className="card-value">{formatNumber(totalUnits)}</div>
          </div>
        </div>

        <div className="summary-card">
          <div className="card-icon">📈</div>
          <div className="card-content">
            <div className="card-title">Average Growth</div>
            <div className="card-value">{averageGrowth.toFixed(1)}%</div>
          </div>
        </div>

        <div className="summary-card">
          <div className="card-icon">📊</div>
          <div className="card-content">
            <div className="card-title">Data Points</div>
            <div className="card-value">{filteredData.length}</div>
          </div>
        </div>
      </div>

      <div className="data-table-container">
        <div className="table-header">
          <h3>Sales Data Table</h3>
          <p>Click column headers to sort data</p>
        </div>

        <div className="table-wrapper">
          <table className="data-table">
            <tbody>
              {paginatedData.map(item => (
                <tr key={item.id} className="data-row">
                  <td className="data-cell region">{item.region}</td>
                  <td className="data-cell product">{item.product}</td>
                  <td className="data-cell revenue">{formatCurrency(item.revenue)}</td>
                  <td className="data-cell units">{formatNumber(item.units)}</td>
                  <td className={`data-cell growth ${item.growth >= 0 ? 'positive' : 'negative'}`}>
                    {item.growth >= 0 ? '+' : ''}{item.growth}%
                  </td>
                  <td className="data-cell quarter">{item.quarter}</td>
                  <td className="data-cell year">{item.year}</td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>

        <div className="table-footer">
          <div className="pagination-info">
            Showing {((currentPage - 1) * itemsPerPage) + 1} to {Math.min(currentPage * itemsPerPage, sortedData.length)} of {sortedData.length} entries
          </div>

          {totalPages > 1 && (
            <div className="pagination">
              <button 
                className="page-btn" 
                onClick={prevPage} 
                disabled={currentPage === 1}
              >
                Previous
              </button>
              
              {Array(totalPages).fill(0).map((_, i) => (
                <button 
                  key={i}
                  className={`page-btn ${currentPage === i + 1 ? 'active' : ''}`}
                  onClick={() => goToPage(i + 1)}
                >
                  {i + 1}
                </button>
              ))}
              
              <button 
                className="page-btn" 
                onClick={nextPage} 
                disabled={currentPage === totalPages}
              >
                Next
              </button>
            </div>
          )}
        </div>
      </div>

      <div className="chart-section">
        <h3>Revenue by Region</h3>
        <div className="chart-placeholder">
          <div className="chart-bars">
            {filteredData.reduce((acc, item) => {
              const existing = acc.find(r => r.region === item.region);
              if (existing) {
                existing.revenue += item.revenue;
              } else {
                acc.push({ region: item.region, revenue: item.revenue });
              }
              return acc;
            }, []).map(regionData => (
              <div key={regionData.region} className="chart-bar">
                <div 
                  className="bar-fill" 
                  style={{ height: `${(regionData.revenue / totalRevenue) * 100}%` }}
                ></div>
                <div className="bar-label">{regionData.region}</div>
                <div className="bar-value">{formatCurrency(regionData.revenue)}</div>
              </div>
            ))}
          </div>
        </div>
      </div>

      <style jsx>{`
        .sales-dashboard {
          max-width: 1400px;
          margin: 50px auto;
          padding: 20px;
          font-family: Arial, sans-serif;
        }

        .dashboard-header {
          text-align: center;
          margin-bottom: 30px;
        }

        .dashboard-header h1 {
          margin: 0 0 10px 0;
          font-size: 32px;
          color: #333;
        }

        .dashboard-header p {
          margin: 0;
          color: #666;
          font-size: 16px;
        }

        .dashboard-controls {
          display: flex;
          justify-content: space-between;
          align-items: center;
          margin-bottom: 30px;
          padding: 20px;
          background: #f8f9fa;
          border-radius: 8px;
        }

        .filter-controls {
          display: flex;
          gap: 20px;
        }

        .filter-group {
          display: flex;
          align-items: center;
          gap: 8px;
        }

        .filter-group label {
          font-weight: bold;
          color: #333;
        }

        .filter-select {
          padding: 8px 12px;
          border: 1px solid #ddd;
          border-radius: 4px;
          background: white;
        }

        .view-controls {
          display: flex;
          gap: 10px;
        }

        .export-btn,
        .refresh-btn {
          padding: 8px 16px;
          border: 1px solid #007bff;
          border-radius: 4px;
          background: white;
          color: #007bff;
          cursor: pointer;
          font-weight: bold;
        }

        .export-btn:hover,
        .refresh-btn:hover {
          background: #007bff;
          color: white;
        }

        .summary-cards {
          display: grid;
          grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
          gap: 20px;
          margin-bottom: 30px;
        }

        .summary-card {
          background: white;
          padding: 25px;
          border-radius: 8px;
          box-shadow: 0 2px 8px rgba(0,0,0,0.1);
          display: flex;
          align-items: center;
          gap: 15px;
        }

        .card-icon {
          font-size: 32px;
        }

        .card-content {
          flex: 1;
        }

        .card-title {
          font-size: 14px;
          color: #666;
          margin-bottom: 5px;
        }

        .card-value {
          font-size: 24px;
          font-weight: bold;
          color: #333;
        }

        .data-table-container {
          background: white;
          border-radius: 8px;
          box-shadow: 0 2px 8px rgba(0,0,0,0.1);
          margin-bottom: 30px;
          overflow: hidden;
        }

        .table-header {
          padding: 20px;
          border-bottom: 1px solid #eee;
        }

        .table-header h3 {
          margin: 0 0 5px 0;
          font-size: 20px;
          color: #333;
        }

        .table-header p {
          margin: 0;
          color: #666;
          font-size: 14px;
        }

        .table-wrapper {
          overflow-x: auto;
        }

        .data-table {
          width: 100%;
          border-collapse: collapse;
        }

        .data-row {
          border-bottom: 1px solid #eee;
          transition: background-color 0.2s ease;
        }

        .data-row:hover {
          background: #f8f9fa;
        }

        .data-row:last-child {
          border-bottom: none;
        }

        .data-cell {
          padding: 15px 12px;
          text-align: left;
          font-size: 14px;
        }

        .data-cell.region {
          font-weight: bold;
          color: #333;
          min-width: 120px;
        }

        .data-cell.product {
          color: #666;
          min-width: 140px;
        }

        .data-cell.revenue {
          font-weight: bold;
          color: #007bff;
          text-align: right;
          min-width: 100px;
        }

        .data-cell.units {
          text-align: right;
          min-width: 80px;
        }

        .data-cell.growth {
          text-align: right;
          font-weight: bold;
          min-width: 80px;
        }

        .data-cell.growth.positive {
          color: #28a745;
        }

        .data-cell.growth.negative {
          color: #dc3545;
        }

        .data-cell.quarter {
          text-align: center;
          min-width: 60px;
        }

        .data-cell.year {
          text-align: center;
          min-width: 60px;
        }

        .table-footer {
          display: flex;
          justify-content: space-between;
          align-items: center;
          padding: 20px;
          border-top: 1px solid #eee;
          background: #f8f9fa;
        }

        .pagination-info {
          color: #666;
          font-size: 14px;
        }

        .pagination {
          display: flex;
          gap: 5px;
        }

        .page-btn {
          padding: 8px 12px;
          border: 1px solid #ddd;
          background: white;
          cursor: pointer;
          border-radius: 4px;
          transition: background-color 0.2s ease;
        }

        .page-btn:hover:not(:disabled) {
          background: #f8f9fa;
        }

        .page-btn.active {
          background: #007bff;
          color: white;
          border-color: #007bff;
        }

        .page-btn:disabled {
          opacity: 0.5;
          cursor: not-allowed;
        }

        .chart-section {
          background: white;
          padding: 30px;
          border-radius: 8px;
          box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }

        .chart-section h3 {
          margin: 0 0 20px 0;
          font-size: 20px;
          color: #333;
        }

        .chart-placeholder {
          height: 300px;
          display: flex;
          align-items: end;
          justify-content: center;
          background: #f8f9fa;
          border-radius: 4px;
          padding: 20px;
        }

        .chart-bars {
          display: flex;
          align-items: end;
          gap: 20px;
          height: 100%;
        }

        .chart-bar {
          display: flex;
          flex-direction: column;
          align-items: center;
          height: 100%;
          min-width: 80px;
        }

        .bar-fill {
          background: linear-gradient(to top, #007bff, #0056b3);
          width: 40px;
          border-radius: 4px 4px 0 0;
          margin-bottom: 10px;
          min-height: 20px;
        }

        .bar-label {
          font-size: 12px;
          color: #666;
          text-align: center;
          margin-bottom: 5px;
        }

        .bar-value {
          font-size: 11px;
          color: #333;
          font-weight: bold;
          text-align: center;
        }
      `}</style>
    </div>
  );
}

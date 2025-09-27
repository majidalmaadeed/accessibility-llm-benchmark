import React, { useState, useEffect } from 'react';

const Dashboard = () => {
  const [metrics, setMetrics] = useState({
    totalUsers: 1234,
    activeUsers: 567,
    revenue: 12345,
    conversion: 3.2
  });

  const [recentActivity, setRecentActivity] = useState([]);
  const [timeRange, setTimeRange] = useState('7d');

  useEffect(() => {
    generateRecentActivity();
    const interval = setInterval(() => {
      updateMetrics();
    }, 5000);
    return () => clearInterval(interval);
  }, []);

  const generateRecentActivity = () => {
    const activities = [
      { user: 'John Doe', action: 'Login', time: '10:30 AM', status: 'success' },
      { user: 'Jane Smith', action: 'Purchase', time: '10:25 AM', status: 'success' },
      { user: 'Mike Johnson', action: 'View Product', time: '10:20 AM', status: 'info' },
      { user: 'Sarah Wilson', action: 'Search', time: '10:15 AM', status: 'info' },
      { user: 'David Brown', action: 'Logout', time: '10:10 AM', status: 'info' },
      { user: 'Lisa Davis', action: 'Update Profile', time: '10:05 AM', status: 'success' },
      { user: 'Tom Wilson', action: 'Add to Cart', time: '10:00 AM', status: 'success' },
      { user: 'Anna Taylor', action: 'Checkout', time: '9:55 AM', status: 'success' },
      { user: 'Chris Lee', action: 'View Report', time: '9:50 AM', status: 'info' },
      { user: 'Emma White', action: 'Download', time: '9:45 AM', status: 'success' }
    ];
    setRecentActivity(activities);
  };

  const updateMetrics = () => {
    setMetrics(prev => ({
      totalUsers: prev.totalUsers + Math.floor(Math.random() * 3),
      activeUsers: prev.activeUsers + Math.floor(Math.random() * 2),
      revenue: prev.revenue + Math.floor(Math.random() * 100),
      conversion: parseFloat((prev.conversion + (Math.random() - 0.5) * 0.1).toFixed(1))
    }));
  };

  const handleTimeRangeChange = (range) => {
    setTimeRange(range);
    // Simulate data loading
    setTimeout(() => {
      updateMetrics();
    }, 500);
  };

  const exportData = () => {
    const data = {
      metrics,
      recentActivity,
      timeRange,
      exportDate: new Date().toISOString()
    };
    
    const blob = new Blob([JSON.stringify(data, null, 2)], { type: 'application/json' });
    const url = window.URL.createObjectURL(blob);
    const a = document.createElement('a');
    a.href = url;
    a.download = 'dashboard-data.json';
    a.click();
    window.URL.revokeObjectURL(url);
  };

  return (
    <div className="container">
      <div className="page-header">
        <h1 className="page-title">Dashboard Widget</h1>
        <p className="page-subtitle">
          Interactive dashboard with charts and metrics
        </p>
      </div>

      <div className="card">
        <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '1rem' }}>
          <h2>Dashboard Controls</h2>
          <div style={{ display: 'flex', gap: '1rem', alignItems: 'center' }}>
            <select
              className="form-control"
              value={timeRange}
              onChange={(e) => handleTimeRangeChange(e.target.value)}
              style={{ width: 'auto' }}
            >
              <option value="24h">Last 24 Hours</option>
              <option value="7d">Last 7 Days</option>
              <option value="30d">Last 30 Days</option>
              <option value="3m">Last 3 Months</option>
              <option value="1y">Last Year</option>
            </select>
            <button className="btn" onClick={exportData}>
              Export Data
            </button>
          </div>
        </div>
      </div>

      <div className="grid grid-4" style={{ marginBottom: '2rem' }}>
        <div className="metric-card">
          <div className="metric-value">{metrics.totalUsers.toLocaleString()}</div>
          <div className="metric-label">Total Users</div>
        </div>
        <div className="metric-card">
          <div className="metric-value">{metrics.activeUsers.toLocaleString()}</div>
          <div className="metric-label">Active Users</div>
        </div>
        <div className="metric-card">
          <div className="metric-value">${metrics.revenue.toLocaleString()}</div>
          <div className="metric-label">Revenue</div>
        </div>
        <div className="metric-card">
          <div className="metric-value">{metrics.conversion}%</div>
          <div className="metric-label">Conversion Rate</div>
        </div>
      </div>

      <div className="grid grid-2" style={{ marginBottom: '2rem' }}>
        <div className="chart-container">
          <h3 className="chart-title">User Activity Over Time</h3>
          <div style={{ height: '300px', background: '#f8f9fa', borderRadius: '4px', display: 'flex', alignItems: 'center', justifyContent: 'center', color: '#666' }}>
            <div style={{ textAlign: 'center' }}>
              <div style={{ fontSize: '2rem', marginBottom: '1rem' }}>📈</div>
              <div>Chart visualization would be here</div>
              <div style={{ fontSize: '0.9rem', marginTop: '0.5rem' }}>Using Chart.js or similar library</div>
            </div>
          </div>
        </div>
        <div className="chart-container">
          <h3 className="chart-title">Revenue by Month</h3>
          <div style={{ height: '300px', background: '#f8f9fa', borderRadius: '4px', display: 'flex', alignItems: 'center', justifyContent: 'center', color: '#666' }}>
            <div style={{ textAlign: 'center' }}>
              <div style={{ fontSize: '2rem', marginBottom: '1rem' }}>📊</div>
              <div>Bar chart visualization would be here</div>
              <div style={{ fontSize: '0.9rem', marginTop: '0.5rem' }}>Monthly revenue breakdown</div>
            </div>
          </div>
        </div>
      </div>

      <div className="card">
        <h2>Recent Activity</h2>
        <div style={{ maxHeight: '400px', overflowY: 'auto' }}>
          {recentActivity.map((activity, index) => (
            <div key={index} style={{ 
              display: 'flex', 
              alignItems: 'center', 
              padding: '0.75rem', 
              borderBottom: '1px solid #eee',
              backgroundColor: index % 2 === 0 ? '#f8f9fa' : 'white'
            }}>
              <div style={{ 
                width: '40px', 
                height: '40px', 
                borderRadius: '50%', 
                backgroundColor: '#007bff', 
                color: 'white', 
                display: 'flex', 
                alignItems: 'center', 
                justifyContent: 'center', 
                fontWeight: 'bold',
                marginRight: '1rem'
              }}>
                {activity.user[0]}
              </div>
              <div style={{ flex: 1 }}>
                <div style={{ fontWeight: '600', marginBottom: '0.25rem' }}>
                  {activity.user} performed {activity.action}
                </div>
                <div style={{ fontSize: '0.9rem', color: '#666' }}>
                  {activity.time}
                </div>
              </div>
              <div style={{ 
                padding: '0.25rem 0.75rem', 
                borderRadius: '12px', 
                fontSize: '0.8rem',
                backgroundColor: activity.status === 'success' ? '#d4edda' : 
                               activity.status === 'info' ? '#d1ecf1' : '#f8d7da',
                color: activity.status === 'success' ? '#155724' : 
                       activity.status === 'info' ? '#0c5460' : '#721c24'
              }}>
                {activity.status}
              </div>
            </div>
          ))}
        </div>
      </div>

      <div className="card">
        <h2>Top Products</h2>
        <div className="table-container">
          <table className="table">
            <thead>
              <tr>
                <th>Product</th>
                <th>Sales</th>
                <th>Revenue</th>
                <th>Growth</th>
              </tr>
            </thead>
            <tbody>
              <tr>
                <td>Product A</td>
                <td>245</td>
                <td>$12,450</td>
                <td style={{ color: '#28a745' }}>+12%</td>
              </tr>
              <tr>
                <td>Product B</td>
                <td>189</td>
                <td>$9,850</td>
                <td style={{ color: '#28a745' }}>+8%</td>
              </tr>
              <tr>
                <td>Product C</td>
                <td>156</td>
                <td>$7,200</td>
                <td style={{ color: '#dc3545' }}>-3%</td>
              </tr>
              <tr>
                <td>Product D</td>
                <td>134</td>
                <td>$6,700</td>
                <td style={{ color: '#28a745' }}>+5%</td>
              </tr>
              <tr>
                <td>Product E</td>
                <td>98</td>
                <td>$4,900</td>
                <td style={{ color: '#ffc107' }}>0%</td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>
    </div>
  );
};

export default Dashboard;

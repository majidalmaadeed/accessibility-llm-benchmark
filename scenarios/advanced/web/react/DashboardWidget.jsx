import React, { useState, useEffect } from 'react';
import './DashboardWidget.css';

const DashboardWidget = () => {
  const [chartData, setChartData] = useState([]);
  const [filters, setFilters] = useState({
    timeRange: '7d',
    metric: 'revenue',
    region: 'all'
  });
  const [selectedDataPoint, setSelectedDataPoint] = useState(null);
  const [showTooltip, setShowTooltip] = useState(false);
  const [tooltipPosition, setTooltipPosition] = useState({ x: 0, y: 0 });
  const [isExporting, setIsExporting] = useState(false);

  // Generate sample data
  useEffect(() => {
    const generateData = () => {
      const data = [];
      const days = filters.timeRange === '7d' ? 7 : filters.timeRange === '30d' ? 30 : 90;
      
      for (let i = 0; i < days; i++) {
        const date = new Date();
        date.setDate(date.getDate() - (days - 1 - i));
        
        data.push({
          date: date.toISOString().split('T')[0],
          revenue: Math.floor(Math.random() * 10000) + 5000,
          users: Math.floor(Math.random() * 1000) + 200,
          orders: Math.floor(Math.random() * 500) + 100,
          conversion: Math.random() * 5 + 2
        });
      }
      
      setChartData(data);
    };

    generateData();
  }, [filters.timeRange]);

  const handleFilterChange = (filterType, value) => {
    setFilters(prev => ({
      ...prev,
      [filterType]: value
    }));
  };

  const handleDataPointHover = (event, dataPoint) => {
    setSelectedDataPoint(dataPoint);
    setShowTooltip(true);
    setTooltipPosition({
      x: event.clientX,
      y: event.clientY
    });
  };

  const handleDataPointLeave = () => {
    setShowTooltip(false);
    setSelectedDataPoint(null);
  };

  const handleExport = async (format) => {
    setIsExporting(true);
    
    // Simulate export process
    setTimeout(() => {
      console.log(`Exporting data as ${format}:`, chartData);
      setIsExporting(false);
      alert(`Data exported as ${format.toUpperCase()} successfully!`);
    }, 1500);
  };

  const getCurrentMetric = () => {
    return chartData.map(d => ({
      date: d.date,
      value: d[filters.metric]
    }));
  };

  const getMaxValue = () => {
    const values = getCurrentMetric().map(d => d.value);
    return Math.max(...values);
  };

  const formatValue = (value) => {
    switch (filters.metric) {
      case 'revenue':
        return `$${value.toLocaleString()}`;
      case 'users':
        return value.toLocaleString();
      case 'orders':
        return value.toLocaleString();
      case 'conversion':
        return `${value.toFixed(1)}%`;
      default:
        return value;
    }
  };

  const getMetricLabel = () => {
    switch (filters.metric) {
      case 'revenue':
        return 'Revenue';
      case 'users':
        return 'Active Users';
      case 'orders':
        return 'Orders';
      case 'conversion':
        return 'Conversion Rate';
      default:
        return 'Metric';
    }
  };

  const renderChart = () => {
    const data = getCurrentMetric();
    const maxValue = getMaxValue();
    const chartHeight = 300;
    const chartWidth = 600;
    const padding = 40;

    return (
      <div className="chart-container">
        <svg width={chartWidth} height={chartHeight} className="chart-svg">
          {/* Grid lines */}
          {[0, 0.25, 0.5, 0.75, 1].map((ratio, index) => (
            <g key={index}>
              <line
                x1={padding}
                y1={padding + ratio * (chartHeight - 2 * padding)}
                x2={chartWidth - padding}
                y2={padding + ratio * (chartHeight - 2 * padding)}
                stroke="#e0e0e0"
                strokeWidth="1"
              />
              <text
                x={padding - 10}
                y={padding + ratio * (chartHeight - 2 * padding) + 5}
                textAnchor="end"
                fontSize="12"
                fill="#666"
              >
                {Math.round(maxValue * (1 - ratio)).toLocaleString()}
              </text>
            </g>
          ))}

          {/* Data line */}
          <polyline
            fill="none"
            stroke="#4caf50"
            strokeWidth="3"
            points={data.map((d, index) => {
              const x = padding + (index / (data.length - 1)) * (chartWidth - 2 * padding);
              const y = padding + (1 - d.value / maxValue) * (chartHeight - 2 * padding);
              return `${x},${y}`;
            }).join(' ')}
          />

          {/* Data points */}
          {data.map((d, index) => {
            const x = padding + (index / (data.length - 1)) * (chartWidth - 2 * padding);
            const y = padding + (1 - d.value / maxValue) * (chartHeight - 2 * padding);
            
            return (
              <circle
                key={index}
                cx={x}
                cy={y}
                r="4"
                fill="#4caf50"
                className="data-point"
                onMouseEnter={(e) => handleDataPointHover(e, d)}
                onMouseLeave={handleDataPointLeave}
              />
            );
          })}

          {/* X-axis labels */}
          {data.map((d, index) => {
            const x = padding + (index / (data.length - 1)) * (chartWidth - 2 * padding);
            const shouldShow = data.length <= 7 || index % Math.ceil(data.length / 7) === 0;
            
            return shouldShow ? (
              <text
                key={index}
                x={x}
                y={chartHeight - padding + 20}
                textAnchor="middle"
                fontSize="12"
                fill="#666"
              >
                {new Date(d.date).toLocaleDateString('en-US', { month: 'short', day: 'numeric' })}
              </text>
            ) : null;
          })}
        </svg>
      </div>
    );
  };

  const renderLegend = () => {
    const metrics = [
      { key: 'revenue', label: 'Revenue', color: '#4caf50' },
      { key: 'users', label: 'Users', color: '#2196f3' },
      { key: 'orders', label: 'Orders', color: '#ff9800' },
      { key: 'conversion', label: 'Conversion', color: '#9c27b0' }
    ];

    return (
      <div className="legend">
        {metrics.map(metric => (
          <div 
            key={metric.key}
            className={`legend-item ${filters.metric === metric.key ? 'active' : ''}`}
            onClick={() => handleFilterChange('metric', metric.key)}
          >
            <div 
              className="legend-color" 
              style={{ backgroundColor: metric.color }}
            ></div>
            <span>{metric.label}</span>
          </div>
        ))}
      </div>
    );
  };

  return (
    <div className="dashboard-widget">
      <div className="widget-header">
        <h2>Analytics Dashboard</h2>
        <div className="header-actions">
          <button 
            onClick={() => handleExport('csv')}
            disabled={isExporting}
            className="export-btn"
          >
            {isExporting ? 'Exporting...' : 'Export CSV'}
          </button>
          <button 
            onClick={() => handleExport('pdf')}
            disabled={isExporting}
            className="export-btn"
          >
            {isExporting ? 'Exporting...' : 'Export PDF'}
          </button>
        </div>
      </div>

      <div className="widget-filters">
        <div className="filter-group">
          <label>Time Range</label>
          <select
            value={filters.timeRange}
            onChange={(e) => handleFilterChange('timeRange', e.target.value)}
          >
            <option value="7d">Last 7 Days</option>
            <option value="30d">Last 30 Days</option>
            <option value="90d">Last 90 Days</option>
          </select>
        </div>

        <div className="filter-group">
          <label>Region</label>
          <select
            value={filters.region}
            onChange={(e) => handleFilterChange('region', e.target.value)}
          >
            <option value="all">All Regions</option>
            <option value="north">North America</option>
            <option value="europe">Europe</option>
            <option value="asia">Asia Pacific</option>
          </select>
        </div>
      </div>

      <div className="chart-section">
        <div className="chart-header">
          <h3>{getMetricLabel()} Over Time</h3>
          <div className="chart-stats">
            <div className="stat">
              <span className="stat-label">Current</span>
              <span className="stat-value">
                {formatValue(getCurrentMetric()[getCurrentMetric().length - 1]?.value || 0)}
              </span>
            </div>
            <div className="stat">
              <span className="stat-label">Average</span>
              <span className="stat-value">
                {formatValue(
                  getCurrentMetric().reduce((sum, d) => sum + d.value, 0) / getCurrentMetric().length || 0
                )}
              </span>
            </div>
            <div className="stat">
              <span className="stat-label">Peak</span>
              <span className="stat-value">
                {formatValue(getMaxValue())}
              </span>
            </div>
          </div>
        </div>

        {renderChart()}
        {renderLegend()}
      </div>

      {showTooltip && selectedDataPoint && (
        <div 
          className="tooltip"
          style={{
            left: tooltipPosition.x + 10,
            top: tooltipPosition.y - 10
          }}
        >
          <div className="tooltip-header">
            {new Date(selectedDataPoint.date).toLocaleDateString()}
          </div>
          <div className="tooltip-content">
            <strong>{getMetricLabel()}:</strong> {formatValue(selectedDataPoint.value)}
          </div>
        </div>
      )}

      <div className="widget-footer">
        <div className="data-info">
          <span>Data updated: {new Date().toLocaleString()}</span>
          <span>•</span>
          <span>{chartData.length} data points</span>
        </div>
        <div className="chart-controls">
          <button className="control-btn">Zoom In</button>
          <button className="control-btn">Zoom Out</button>
          <button className="control-btn">Reset View</button>
        </div>
      </div>
    </div>
  );
};

export default DashboardWidget;

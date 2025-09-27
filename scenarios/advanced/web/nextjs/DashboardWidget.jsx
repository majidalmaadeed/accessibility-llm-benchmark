'use client';

import { useState, useEffect } from 'react';
import styles from './DashboardWidget.module.css';

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

  const metrics = [
    { key: 'revenue', label: 'Revenue', color: '#4caf50' },
    { key: 'users', label: 'Users', color: '#2196f3' },
    { key: 'orders', label: 'Orders', color: '#ff9800' },
    { key: 'conversion', label: 'Conversion', color: '#9c27b0' }
  ];

  useEffect(() => {
    generateData();
  }, [filters.timeRange]);

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

  const getAverageValue = () => {
    const values = getCurrentMetric().map(d => d.value);
    return values.reduce((sum, val) => sum + val, 0) / values.length || 0;
  };

  const getDataLinePoints = () => {
    const data = getCurrentMetric();
    const maxValue = getMaxValue();
    
    return data.map((d, index) => {
      const x = 40 + (index / (data.length - 1)) * 520;
      const y = 40 + (1 - d.value / maxValue) * 220;
      return `${x},${y}`;
    }).join(' ');
  };

  const shouldShowLabel = (index) => {
    const data = getCurrentMetric();
    return data.length <= 7 || index % Math.ceil(data.length / 7) === 0;
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
        return value.toString();
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

  const formatDate = (dateString) => {
    return new Date(dateString).toLocaleDateString('en-US', { month: 'short', day: 'numeric' });
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
    
    setTimeout(() => {
      console.log(`Exporting data as ${format}:`, chartData);
      setIsExporting(false);
      alert(`Data exported as ${format.toUpperCase()} successfully!`);
    }, 1500);
  };

  const onTimeRangeChange = () => {
    generateData();
  };

  const getCurrentValue = () => {
    const data = getCurrentMetric();
    return data[data.length - 1]?.value || 0;
  };

  const getMetricColor = () => {
    const metric = metrics.find(m => m.key === filters.metric);
    return metric?.color || '#4caf50';
  };

  return (
    <div className={styles.dashboardWidget}>
      <div className={styles.widgetHeader}>
        <h2>Analytics Dashboard</h2>
        <div className={styles.headerActions}>
          <button 
            onClick={() => handleExport('csv')}
            disabled={isExporting}
            className={styles.exportBtn}
          >
            {isExporting ? 'Exporting...' : 'Export CSV'}
          </button>
          <button 
            onClick={() => handleExport('pdf')}
            disabled={isExporting}
            className={styles.exportBtn}
          >
            {isExporting ? 'Exporting...' : 'Export PDF'}
          </button>
        </div>
      </div>

      <div className={styles.widgetFilters}>
        <div className={styles.filterGroup}>
          <label className={styles.filterLabel}>Time Range</label>
          <select 
            value={filters.timeRange} 
            onChange={(e) => {
              setFilters(prev => ({ ...prev, timeRange: e.target.value }));
              onTimeRangeChange();
            }}
            className={styles.filterSelect}
          >
            <option value="7d">Last 7 Days</option>
            <option value="30d">Last 30 Days</option>
            <option value="90d">Last 90 Days</option>
          </select>
        </div>

        <div className={styles.filterGroup}>
          <label className={styles.filterLabel}>Region</label>
          <select 
            value={filters.region}
            onChange={(e) => setFilters(prev => ({ ...prev, region: e.target.value }))}
            className={styles.filterSelect}
          >
            <option value="all">All Regions</option>
            <option value="north">North America</option>
            <option value="europe">Europe</option>
            <option value="asia">Asia Pacific</option>
          </select>
        </div>
      </div>

      <div className={styles.chartSection}>
        <div className={styles.chartHeader}>
          <h3>{getMetricLabel()} Over Time</h3>
          <div className={styles.chartStats}>
            <div className={styles.stat}>
              <span className={styles.statLabel}>Current</span>
              <span className={styles.statValue}>
                {formatValue(getCurrentValue())}
              </span>
            </div>
            <div className={styles.stat}>
              <span className={styles.statLabel}>Average</span>
              <span className={styles.statValue}>
                {formatValue(getAverageValue())}
              </span>
            </div>
            <div className={styles.stat}>
              <span className={styles.statLabel}>Peak</span>
              <span className={styles.statValue}>
                {formatValue(getMaxValue())}
              </span>
            </div>
          </div>
        </div>

        <div className={styles.chartContainer}>
          <svg width="600" height="300" className={styles.chartSvg}>
            {[0, 0.25, 0.5, 0.75, 1].map((ratio, i) => (
              <g key={i}>
                <line
                  x1="40"
                  y1={40 + ratio * 220}
                  x2="560"
                  y2={40 + ratio * 220}
                  stroke="#e0e0e0"
                  strokeWidth="1"
                />
                <text
                  x="30"
                  y={40 + ratio * 220 + 5}
                  textAnchor="end"
                  fontSize="12"
                  fill="#666"
                >
                  {Math.round(getMaxValue() * (1 - ratio)).toLocaleString()}
                </text>
              </g>
            ))}

            <polyline
              fill="none"
              stroke={getMetricColor()}
              strokeWidth="3"
              points={getDataLinePoints()}
            />

            {getCurrentMetric().map((d, index) => (
              <circle
                key={index}
                cx={40 + (index / (getCurrentMetric().length - 1)) * 520}
                cy={40 + (1 - d.value / getMaxValue()) * 220}
                r="4"
                fill={getMetricColor()}
                className={styles.dataPoint}
                onMouseEnter={(e) => handleDataPointHover(e, d)}
                onMouseLeave={handleDataPointLeave}
              />
            ))}

            {getCurrentMetric().map((d, index) => (
              shouldShowLabel(index) && (
                <text
                  key={index}
                  x={40 + (index / (getCurrentMetric().length - 1)) * 520}
                  y="280"
                  textAnchor="middle"
                  fontSize="12"
                  fill="#666"
                >
                  {formatDate(d.date)}
                </text>
              )
            ))}
          </svg>
        </div>

        <div className={styles.legend}>
          {metrics.map((metric) => (
            <div 
              key={metric.key}
              className={`${styles.legendItem} ${filters.metric === metric.key ? styles.active : ''}`}
              onClick={() => setFilters(prev => ({ ...prev, metric: metric.key }))}
            >
              <div 
                className={styles.legendColor} 
                style={{ backgroundColor: metric.color }}
              />
              <span>{metric.label}</span>
            </div>
          ))}
        </div>
      </div>

      {showTooltip && selectedDataPoint && (
        <div 
          className={styles.tooltip}
          style={{
            left: tooltipPosition.x + 10,
            top: tooltipPosition.y - 10
          }}
        >
          <div className={styles.tooltipHeader}>
            {formatDate(selectedDataPoint.date)}
          </div>
          <div className={styles.tooltipContent}>
            <strong>{getMetricLabel()}:</strong> {formatValue(selectedDataPoint.value)}
          </div>
        </div>
      )}

      <div className={styles.widgetFooter}>
        <div className={styles.dataInfo}>
          <span>Data updated: {new Date().toLocaleString()}</span>
          <span>•</span>
          <span>{chartData.length} data points</span>
        </div>
        <div className={styles.chartControls}>
          <button className={styles.controlBtn}>Zoom In</button>
          <button className={styles.controlBtn}>Zoom Out</button>
          <button className={styles.controlBtn}>Reset View</button>
        </div>
      </div>
    </div>
  );
};

export default DashboardWidget;

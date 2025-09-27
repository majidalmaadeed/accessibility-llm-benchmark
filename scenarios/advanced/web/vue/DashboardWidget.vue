<template>
  <div class="dashboard-widget">
    <div class="widget-header">
      <h2>Analytics Dashboard</h2>
      <div class="header-actions">
        <button 
          @click="handleExport('csv')"
          :disabled="isExporting"
          class="export-btn"
        >
          {{ isExporting ? 'Exporting...' : 'Export CSV' }}
        </button>
        <button 
          @click="handleExport('pdf')"
          :disabled="isExporting"
          class="export-btn"
        >
          {{ isExporting ? 'Exporting...' : 'Export PDF' }}
        </button>
      </div>
    </div>

    <div class="widget-filters">
      <div class="filter-group">
        <label>Time Range</label>
        <select v-model="filters.timeRange">
          <option value="7d">Last 7 Days</option>
          <option value="30d">Last 30 Days</option>
          <option value="90d">Last 90 Days</option>
        </select>
      </div>

      <div class="filter-group">
        <label>Region</label>
        <select v-model="filters.region">
          <option value="all">All Regions</option>
          <option value="north">North America</option>
          <option value="europe">Europe</option>
          <option value="asia">Asia Pacific</option>
        </select>
      </div>
    </div>

    <div class="chart-section">
      <div class="chart-header">
        <h3>{{ getMetricLabel() }} Over Time</h3>
        <div class="chart-stats">
          <div class="stat">
            <span class="stat-label">Current</span>
            <span class="stat-value">
              {{ formatValue(getCurrentMetric()[getCurrentMetric().length - 1]?.value || 0) }}
            </span>
          </div>
          <div class="stat">
            <span class="stat-label">Average</span>
            <span class="stat-value">
              {{ formatValue(getAverageValue()) }}
            </span>
          </div>
          <div class="stat">
            <span class="stat-label">Peak</span>
            <span class="stat-value">
              {{ formatValue(getMaxValue()) }}
            </span>
          </div>
        </div>
      </div>

      <div class="chart-container">
        <svg width="600" height="300" class="chart-svg">
          <!-- Grid lines -->
          <g v-for="(ratio, index) in [0, 0.25, 0.5, 0.75, 1]" :key="index">
            <line
              :x1="40"
              :y1="40 + ratio * 220"
              :x2="560"
              :y2="40 + ratio * 220"
              stroke="#e0e0e0"
              stroke-width="1"
            />
            <text
              :x="30"
              :y="40 + ratio * 220 + 5"
              text-anchor="end"
              font-size="12"
              fill="#666"
            >
              {{ Math.round(getMaxValue() * (1 - ratio)).toLocaleString() }}
            </text>
          </g>

          <!-- Data line -->
          <polyline
            fill="none"
            stroke="#4caf50"
            stroke-width="3"
            :points="getDataLinePoints()"
          />

          <!-- Data points -->
          <circle
            v-for="(d, index) in getCurrentMetric()"
            :key="index"
            :cx="40 + (index / (getCurrentMetric().length - 1)) * 520"
            :cy="40 + (1 - d.value / getMaxValue()) * 220"
            r="4"
            fill="#4caf50"
            class="data-point"
            @mouseenter="handleDataPointHover($event, d)"
            @mouseleave="handleDataPointLeave"
          />

          <!-- X-axis labels -->
          <text
            v-for="(d, index) in getCurrentMetric()"
            :key="index"
            v-if="shouldShowLabel(index)"
            :x="40 + (index / (getCurrentMetric().length - 1)) * 520"
            y="280"
            text-anchor="middle"
            font-size="12"
            fill="#666"
          >
            {{ formatDate(d.date) }}
          </text>
        </svg>
      </div>

      <div class="legend">
        <div 
          v-for="metric in metrics"
          :key="metric.key"
          :class="`legend-item ${filters.metric === metric.key ? 'active' : ''}`"
          @click="filters.metric = metric.key"
        >
          <div 
            class="legend-color" 
            :style="{ backgroundColor: metric.color }"
          ></div>
          <span>{{ metric.label }}</span>
        </div>
      </div>
    </div>

    <div 
      v-if="showTooltip && selectedDataPoint"
      class="tooltip"
      :style="{
        left: tooltipPosition.x + 10 + 'px',
        top: tooltipPosition.y - 10 + 'px'
      }"
    >
      <div class="tooltip-header">
        {{ formatDate(selectedDataPoint.date) }}
      </div>
      <div class="tooltip-content">
        <strong>{{ getMetricLabel() }}:</strong> {{ formatValue(selectedDataPoint.value) }}
      </div>
    </div>

    <div class="widget-footer">
      <div class="data-info">
        <span>Data updated: {{ new Date().toLocaleString() }}</span>
        <span>•</span>
        <span>{{ chartData.length }} data points</span>
      </div>
      <div class="chart-controls">
        <button class="control-btn">Zoom In</button>
        <button class="control-btn">Zoom Out</button>
        <button class="control-btn">Reset View</button>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'DashboardWidget',
  data() {
    return {
      chartData: [],
      filters: {
        timeRange: '7d',
        metric: 'revenue',
        region: 'all'
      },
      selectedDataPoint: null,
      showTooltip: false,
      tooltipPosition: { x: 0, y: 0 },
      isExporting: false,
      metrics: [
        { key: 'revenue', label: 'Revenue', color: '#4caf50' },
        { key: 'users', label: 'Users', color: '#2196f3' },
        { key: 'orders', label: 'Orders', color: '#ff9800' },
        { key: 'conversion', label: 'Conversion', color: '#9c27b0' }
      ]
    }
  },
  watch: {
    'filters.timeRange'() {
      this.generateData();
    }
  },
  mounted() {
    this.generateData();
  },
  methods: {
    generateData() {
      const data = [];
      const days = this.filters.timeRange === '7d' ? 7 : this.filters.timeRange === '30d' ? 30 : 90;
      
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
      
      this.chartData = data;
    },
    getCurrentMetric() {
      return this.chartData.map(d => ({
        date: d.date,
        value: d[this.filters.metric]
      }));
    },
    getMaxValue() {
      const values = this.getCurrentMetric().map(d => d.value);
      return Math.max(...values);
    },
    getAverageValue() {
      const values = this.getCurrentMetric().map(d => d.value);
      return values.reduce((sum, val) => sum + val, 0) / values.length || 0;
    },
    getDataLinePoints() {
      const data = this.getCurrentMetric();
      const maxValue = this.getMaxValue();
      
      return data.map((d, index) => {
        const x = 40 + (index / (data.length - 1)) * 520;
        const y = 40 + (1 - d.value / maxValue) * 220;
        return `${x},${y}`;
      }).join(' ');
    },
    shouldShowLabel(index) {
      const data = this.getCurrentMetric();
      return data.length <= 7 || index % Math.ceil(data.length / 7) === 0;
    },
    formatValue(value) {
      switch (this.filters.metric) {
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
    },
    getMetricLabel() {
      switch (this.filters.metric) {
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
    },
    formatDate(dateString) {
      return new Date(dateString).toLocaleDateString('en-US', { month: 'short', day: 'numeric' });
    },
    handleDataPointHover(event, dataPoint) {
      this.selectedDataPoint = dataPoint;
      this.showTooltip = true;
      this.tooltipPosition = {
        x: event.clientX,
        y: event.clientY
      };
    },
    handleDataPointLeave() {
      this.showTooltip = false;
      this.selectedDataPoint = null;
    },
    async handleExport(format) {
      this.isExporting = true;
      
      // Simulate export process
      setTimeout(() => {
        console.log(`Exporting data as ${format}:`, this.chartData);
        this.isExporting = false;
        alert(`Data exported as ${format.toUpperCase()} successfully!`);
      }, 1500);
    }
  }
}
</script>

<style scoped>
.dashboard-widget {
  max-width: 1000px;
  margin: 0 auto;
  padding: 20px;
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
  background: white;
  border-radius: 8px;
  box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
}

.widget-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 25px;
  padding-bottom: 15px;
  border-bottom: 2px solid #e0e0e0;
}

.widget-header h2 {
  margin: 0;
  color: #333;
  font-size: 24px;
}

.header-actions {
  display: flex;
  gap: 10px;
}

.export-btn {
  padding: 8px 16px;
  border: 1px solid #4caf50;
  background: white;
  color: #4caf50;
  cursor: pointer;
  border-radius: 4px;
  font-size: 14px;
  font-weight: 500;
  transition: all 0.3s ease;
}

.export-btn:hover:not(:disabled) {
  background: #4caf50;
  color: white;
}

.export-btn:disabled {
  opacity: 0.5;
  cursor: not-allowed;
}

.widget-filters {
  display: flex;
  gap: 20px;
  margin-bottom: 25px;
  padding: 15px;
  background: #f8f9fa;
  border-radius: 6px;
}

.filter-group {
  display: flex;
  flex-direction: column;
  gap: 5px;
}

.filter-group label {
  font-size: 12px;
  font-weight: 600;
  color: #666;
  text-transform: uppercase;
  letter-spacing: 0.5px;
}

.filter-group select {
  padding: 8px 12px;
  border: 1px solid #ddd;
  border-radius: 4px;
  font-size: 14px;
  background: white;
  cursor: pointer;
  min-width: 150px;
}

.filter-group select:focus {
  outline: none;
  border-color: #4caf50;
}

.chart-section {
  margin-bottom: 25px;
}

.chart-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 20px;
}

.chart-header h3 {
  margin: 0;
  color: #333;
  font-size: 18px;
}

.chart-stats {
  display: flex;
  gap: 20px;
}

.stat {
  text-align: center;
}

.stat-label {
  display: block;
  font-size: 11px;
  color: #666;
  text-transform: uppercase;
  letter-spacing: 0.5px;
  margin-bottom: 2px;
}

.stat-value {
  display: block;
  font-size: 16px;
  font-weight: 600;
  color: #333;
}

.chart-container {
  margin-bottom: 20px;
  overflow-x: auto;
}

.chart-svg {
  display: block;
  margin: 0 auto;
}

.data-point {
  cursor: pointer;
  transition: r 0.2s ease;
}

.data-point:hover {
  r: 6;
  fill: #2e7d32;
}

.legend {
  display: flex;
  justify-content: center;
  gap: 20px;
  flex-wrap: wrap;
}

.legend-item {
  display: flex;
  align-items: center;
  gap: 8px;
  padding: 8px 12px;
  border-radius: 4px;
  cursor: pointer;
  transition: all 0.3s ease;
  border: 2px solid transparent;
}

.legend-item:hover {
  background: #f5f5f5;
}

.legend-item.active {
  background: #e8f5e8;
  border-color: #4caf50;
}

.legend-color {
  width: 12px;
  height: 12px;
  border-radius: 2px;
}

.legend-item span {
  font-size: 14px;
  color: #333;
  font-weight: 500;
}

.tooltip {
  position: fixed;
  background: rgba(0, 0, 0, 0.9);
  color: white;
  padding: 10px 15px;
  border-radius: 6px;
  font-size: 12px;
  pointer-events: none;
  z-index: 1000;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.3);
}

.tooltip-header {
  font-weight: 600;
  margin-bottom: 5px;
  color: #fff;
}

.tooltip-content {
  color: #e0e0e0;
}

.widget-footer {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding-top: 15px;
  border-top: 1px solid #e0e0e0;
}

.data-info {
  display: flex;
  align-items: center;
  gap: 10px;
  font-size: 12px;
  color: #666;
}

.chart-controls {
  display: flex;
  gap: 8px;
}

.control-btn {
  padding: 6px 12px;
  border: 1px solid #ddd;
  background: white;
  cursor: pointer;
  border-radius: 3px;
  font-size: 12px;
  color: #666;
  transition: all 0.3s ease;
}

.control-btn:hover {
  background: #f5f5f5;
  color: #333;
}

@media (max-width: 768px) {
  .dashboard-widget {
    padding: 15px;
  }
  
  .widget-header {
    flex-direction: column;
    gap: 15px;
    align-items: stretch;
  }
  
  .header-actions {
    justify-content: center;
  }
  
  .widget-filters {
    flex-direction: column;
    gap: 15px;
  }
  
  .filter-group select {
    min-width: auto;
  }
  
  .chart-header {
    flex-direction: column;
    gap: 15px;
    align-items: stretch;
  }
  
  .chart-stats {
    justify-content: space-around;
  }
  
  .legend {
    gap: 10px;
  }
  
  .widget-footer {
    flex-direction: column;
    gap: 15px;
    align-items: stretch;
  }
  
  .data-info {
    justify-content: center;
  }
  
  .chart-controls {
    justify-content: center;
  }
}

@media (max-width: 480px) {
  .chart-stats {
    flex-direction: column;
    gap: 10px;
  }
  
  .legend {
    flex-direction: column;
    align-items: center;
  }
}
</style>

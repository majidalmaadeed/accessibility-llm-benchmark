import { Component, OnInit } from '@angular/core';

interface Metric {
  key: string;
  label: string;
  color: string;
}

interface DataPoint {
  date: string;
  value: number;
}

interface ChartData {
  date: string;
  revenue: number;
  users: number;
  orders: number;
  conversion: number;
}

interface Filters {
  timeRange: string;
  metric: string;
  region: string;
}

@Component({
  selector: 'app-dashboard-widget',
  templateUrl: './dashboard-widget.component.html',
  styleUrls: ['./dashboard-widget.component.css']
})
export class DashboardWidgetComponent implements OnInit {
  chartData: ChartData[] = [];
  filters: Filters = {
    timeRange: '7d',
    metric: 'revenue',
    region: 'all'
  };
  selectedDataPoint: DataPoint | null = null;
  showTooltip: boolean = false;
  tooltipPosition: { x: number; y: number } = { x: 0, y: 0 };
  isExporting: boolean = false;
  
  metrics: Metric[] = [
    { key: 'revenue', label: 'Revenue', color: '#4caf50' },
    { key: 'users', label: 'Users', color: '#2196f3' },
    { key: 'orders', label: 'Orders', color: '#ff9800' },
    { key: 'conversion', label: 'Conversion', color: '#9c27b0' }
  ];

  constructor() { }

  ngOnInit(): void {
    this.generateData();
  }

  generateData(): void {
    const data: ChartData[] = [];
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
  }

  getCurrentMetric(): DataPoint[] {
    return this.chartData.map(d => ({
      date: d.date,
      value: d[this.filters.metric as keyof ChartData] as number
    }));
  }

  getMaxValue(): number {
    const values = this.getCurrentMetric().map(d => d.value);
    return Math.max(...values);
  }

  getAverageValue(): number {
    const values = this.getCurrentMetric().map(d => d.value);
    return values.reduce((sum, val) => sum + val, 0) / values.length || 0;
  }

  getDataLinePoints(): string {
    const data = this.getCurrentMetric();
    const maxValue = this.getMaxValue();
    
    return data.map((d, index) => {
      const x = 40 + (index / (data.length - 1)) * 520;
      const y = 40 + (1 - d.value / maxValue) * 220;
      return `${x},${y}`;
    }).join(' ');
  }

  shouldShowLabel(index: number): boolean {
    const data = this.getCurrentMetric();
    return data.length <= 7 || index % Math.ceil(data.length / 7) === 0;
  }

  formatValue(value: number): string {
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
        return value.toString();
    }
  }

  getMetricLabel(): string {
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
  }

  formatDate(dateString: string): string {
    return new Date(dateString).toLocaleDateString('en-US', { month: 'short', day: 'numeric' });
  }

  handleDataPointHover(event: MouseEvent, dataPoint: DataPoint): void {
    this.selectedDataPoint = dataPoint;
    this.showTooltip = true;
    this.tooltipPosition = {
      x: event.clientX,
      y: event.clientY
    };
  }

  handleDataPointLeave(): void {
    this.showTooltip = false;
    this.selectedDataPoint = null;
  }

  async handleExport(format: string): Promise<void> {
    this.isExporting = true;
    
    // Simulate export process
    setTimeout(() => {
      console.log(`Exporting data as ${format}:`, this.chartData);
      this.isExporting = false;
      alert(`Data exported as ${format.toUpperCase()} successfully!`);
    }, 1500);
  }

  onTimeRangeChange(): void {
    this.generateData();
  }

  getCurrentValue(): number {
    const data = this.getCurrentMetric();
    return data[data.length - 1]?.value || 0;
  }

  getMetricColor(): string {
    const metric = this.metrics.find(m => m.key === this.filters.metric);
    return metric?.color || '#4caf50';
  }
}

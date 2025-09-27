import React, { useState, useEffect } from 'react';
import {
  View,
  Text,
  TouchableOpacity,
  ScrollView,
  StyleSheet,
  Dimensions,
  Modal,
  Alert,
} from 'react-native';
import { Ionicons } from '@expo/vector-icons';

const { width } = Dimensions.get('window');

const DashboardWidget = () => {
  const [selectedTimeRange, setSelectedTimeRange] = useState('7d');
  const [selectedMetric, setSelectedMetric] = useState('revenue');
  const [showFilters, setShowFilters] = useState(false);
  const [showExportMenu, setShowExportMenu] = useState(false);
  const [chartData, setChartData] = useState([]);
  const [isLoading, setIsLoading] = useState(false);

  const timeRanges = [
    { value: '1d', label: '1 Day' },
    { value: '7d', label: '7 Days' },
    { value: '30d', label: '30 Days' },
    { value: '90d', label: '90 Days' },
    { value: '1y', label: '1 Year' },
  ];

  const metrics = [
    { value: 'revenue', label: 'Revenue', icon: 'cash', color: '#4CAF50' },
    { value: 'users', label: 'Users', icon: 'people', color: '#2196F3' },
    { value: 'orders', label: 'Orders', icon: 'cart', color: '#FF9800' },
    { value: 'conversion', label: 'Conversion', icon: 'trending-up', color: '#9C27B0' },
  ];

  const sampleData = {
    revenue: {
      current: 125430,
      previous: 118920,
      data: [12000, 15000, 18000, 22000, 19000, 25000, 28000],
    },
    users: {
      current: 15420,
      previous: 14230,
      data: [1200, 1400, 1600, 1800, 1700, 2000, 2200],
    },
    orders: {
      current: 892,
      previous: 756,
      data: [80, 95, 110, 125, 105, 140, 155],
    },
    conversion: {
      current: 3.2,
      previous: 2.8,
      data: [2.5, 2.8, 3.1, 3.4, 3.0, 3.3, 3.6],
    },
  };

  useEffect(() => {
    loadChartData();
  }, [selectedTimeRange, selectedMetric]);

  const loadChartData = async () => {
    setIsLoading(true);
    // Simulate API call
    setTimeout(() => {
      setChartData(sampleData[selectedMetric].data);
      setIsLoading(false);
    }, 1000);
  };

  const formatValue = (value, metric) => {
    switch (metric) {
      case 'revenue':
        return `$${value.toLocaleString()}`;
      case 'users':
        return value.toLocaleString();
      case 'orders':
        return value.toLocaleString();
      case 'conversion':
        return `${value}%`;
      default:
        return value.toString();
    }
  };

  const calculateChange = (current, previous) => {
    return ((current - previous) / previous) * 100;
  };

  const renderHeader = () => (
    <View style={styles.header}>
      <View>
        <Text style={styles.headerTitle}>Analytics Dashboard</Text>
        <Text style={styles.headerSubtitle}>Real-time business metrics</Text>
      </View>
      <View style={styles.headerActions}>
        <TouchableOpacity
          style={styles.headerButton}
          onPress={() => setShowFilters(true)}
        >
          <Ionicons name="filter" size={20} color="#007AFF" />
        </TouchableOpacity>
        <TouchableOpacity
          style={styles.headerButton}
          onPress={() => setShowExportMenu(true)}
        >
          <Ionicons name="download" size={20} color="#007AFF" />
        </TouchableOpacity>
        <TouchableOpacity
          style={styles.headerButton}
          onPress={() => loadChartData()}
        >
          <Ionicons name="refresh" size={20} color="#007AFF" />
        </TouchableOpacity>
      </View>
    </View>
  );

  const renderTimeRangeSelector = () => (
    <View style={styles.timeRangeContainer}>
      <ScrollView horizontal showsHorizontalScrollIndicator={false}>
        {timeRanges.map((range) => (
          <TouchableOpacity
            key={range.value}
            style={[
              styles.timeRangeButton,
              selectedTimeRange === range.value && styles.timeRangeButtonActive,
            ]}
            onPress={() => setSelectedTimeRange(range.value)}
          >
            <Text
              style={[
                styles.timeRangeText,
                selectedTimeRange === range.value && styles.timeRangeTextActive,
              ]}
            >
              {range.label}
            </Text>
          </TouchableOpacity>
        ))}
      </ScrollView>
    </View>
  );

  const renderMetricCards = () => (
    <View style={styles.metricCardsContainer}>
      {metrics.map((metric) => {
        const data = sampleData[metric.value];
        const change = calculateChange(data.current, data.previous);
        const isPositive = change >= 0;
        
        return (
          <TouchableOpacity
            key={metric.value}
            style={[
              styles.metricCard,
              selectedMetric === metric.value && styles.metricCardSelected,
            ]}
            onPress={() => setSelectedMetric(metric.value)}
          >
            <View style={styles.metricCardHeader}>
              <View style={[styles.metricIcon, { backgroundColor: metric.color }]}>
                <Ionicons name={metric.icon} size={20} color="#fff" />
              </View>
              <Text style={styles.metricLabel}>{metric.label}</Text>
            </View>
            
            <Text style={styles.metricValue}>
              {formatValue(data.current, metric.value)}
            </Text>
            
            <View style={styles.metricChange}>
              <Ionicons
                name={isPositive ? 'trending-up' : 'trending-down'}
                size={16}
                color={isPositive ? '#4CAF50' : '#F44336'}
              />
              <Text
                style={[
                  styles.metricChangeText,
                  { color: isPositive ? '#4CAF50' : '#F44336' },
                ]}
              >
                {Math.abs(change).toFixed(1)}%
              </Text>
            </View>
          </TouchableOpacity>
        );
      })}
    </View>
  );

  const renderChart = () => (
    <View style={styles.chartContainer}>
      <View style={styles.chartHeader}>
        <Text style={styles.chartTitle}>
          {metrics.find(m => m.value === selectedMetric)?.label} Trend
        </Text>
        <View style={styles.chartLegend}>
          <View style={styles.legendItem}>
            <View style={[styles.legendColor, { backgroundColor: '#007AFF' }]} />
            <Text style={styles.legendText}>Current Period</Text>
          </View>
          <View style={styles.legendItem}>
            <View style={[styles.legendColor, { backgroundColor: '#e0e0e0' }]} />
            <Text style={styles.legendText}>Previous Period</Text>
          </View>
        </View>
      </View>
      
      {isLoading ? (
        <View style={styles.chartLoading}>
          <Text style={styles.chartLoadingText}>Loading chart data...</Text>
        </View>
      ) : (
        <View style={styles.chart}>
          <View style={styles.chartBars}>
            {chartData.map((value, index) => {
              const maxValue = Math.max(...chartData);
              const height = (value / maxValue) * 120;
              
              return (
                <View key={index} style={styles.chartBarContainer}>
                  <View
                    style={[
                      styles.chartBar,
                      { height: height },
                      { backgroundColor: metrics.find(m => m.value === selectedMetric)?.color || '#007AFF' },
                    ]}
                  />
                  <Text style={styles.chartBarLabel}>
                    {['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'][index]}
                  </Text>
                </View>
              );
            })}
          </View>
        </View>
      )}
    </View>
  );

  const renderFilters = () => (
    <Modal
      visible={showFilters}
      animationType="slide"
      transparent={true}
      onRequestClose={() => setShowFilters(false)}
    >
      <View style={styles.modalOverlay}>
        <View style={styles.modalContent}>
          <View style={styles.modalHeader}>
            <Text style={styles.modalTitle}>Filter Options</Text>
            <TouchableOpacity onPress={() => setShowFilters(false)}>
              <Ionicons name="close" size={24} color="#666" />
            </TouchableOpacity>
          </View>
          
          <View style={styles.filterSection}>
            <Text style={styles.filterLabel}>Time Range</Text>
            {timeRanges.map((range) => (
              <TouchableOpacity
                key={range.value}
                style={styles.filterOption}
                onPress={() => {
                  setSelectedTimeRange(range.value);
                  setShowFilters(false);
                }}
              >
                <View style={styles.filterOptionContent}>
                  <Text style={styles.filterOptionText}>{range.label}</Text>
                  {selectedTimeRange === range.value && (
                    <Ionicons name="checkmark" size={20} color="#007AFF" />
                  )}
                </View>
              </TouchableOpacity>
            ))}
          </View>

          <View style={styles.filterSection}>
            <Text style={styles.filterLabel}>Metric</Text>
            {metrics.map((metric) => (
              <TouchableOpacity
                key={metric.value}
                style={styles.filterOption}
                onPress={() => {
                  setSelectedMetric(metric.value);
                  setShowFilters(false);
                }}
              >
                <View style={styles.filterOptionContent}>
                  <View style={styles.filterOptionLeft}>
                    <View style={[styles.filterIcon, { backgroundColor: metric.color }]}>
                      <Ionicons name={metric.icon} size={16} color="#fff" />
                    </View>
                    <Text style={styles.filterOptionText}>{metric.label}</Text>
                  </View>
                  {selectedMetric === metric.value && (
                    <Ionicons name="checkmark" size={20} color="#007AFF" />
                  )}
                </View>
              </TouchableOpacity>
            ))}
          </View>
        </View>
      </View>
    </Modal>
  );

  const renderExportMenu = () => (
    <Modal
      visible={showExportMenu}
      animationType="fade"
      transparent={true}
      onRequestClose={() => setShowExportMenu(false)}
    >
      <View style={styles.modalOverlay}>
        <View style={styles.exportMenu}>
          <Text style={styles.exportMenuTitle}>Export Data</Text>
          
          <TouchableOpacity
            style={styles.exportOption}
            onPress={() => {
              Alert.alert('Export', 'Exporting as CSV...');
              setShowExportMenu(false);
            }}
          >
            <Ionicons name="document-text" size={20} color="#007AFF" />
            <Text style={styles.exportOptionText}>CSV Format</Text>
          </TouchableOpacity>
          
          <TouchableOpacity
            style={styles.exportOption}
            onPress={() => {
              Alert.alert('Export', 'Exporting as Excel...');
              setShowExportMenu(false);
            }}
          >
            <Ionicons name="table" size={20} color="#007AFF" />
            <Text style={styles.exportOptionText}>Excel Format</Text>
          </TouchableOpacity>
          
          <TouchableOpacity
            style={styles.exportOption}
            onPress={() => {
              Alert.alert('Export', 'Exporting as PDF...');
              setShowExportMenu(false);
            }}
          >
            <Ionicons name="document" size={20} color="#007AFF" />
            <Text style={styles.exportOptionText}>PDF Report</Text>
          </TouchableOpacity>
          
          <TouchableOpacity
            style={styles.exportOption}
            onPress={() => {
              Alert.alert('Export', 'Generating image...');
              setShowExportMenu(false);
            }}
          >
            <Ionicons name="image" size={20} color="#007AFF" />
            <Text style={styles.exportOptionText}>Image (PNG)</Text>
          </TouchableOpacity>
          
          <TouchableOpacity
            style={styles.exportCancel}
            onPress={() => setShowExportMenu(false)}
          >
            <Text style={styles.exportCancelText}>Cancel</Text>
          </TouchableOpacity>
        </View>
      </View>
    </Modal>
  );

  const renderQuickStats = () => (
    <View style={styles.quickStatsContainer}>
      <Text style={styles.quickStatsTitle}>Quick Stats</Text>
      <View style={styles.quickStatsGrid}>
        <View style={styles.quickStatItem}>
          <Text style={styles.quickStatValue}>98.5%</Text>
          <Text style={styles.quickStatLabel}>Uptime</Text>
        </View>
        <View style={styles.quickStatItem}>
          <Text style={styles.quickStatValue}>2.3s</Text>
          <Text style={styles.quickStatLabel}>Avg Response</Text>
        </View>
        <View style={styles.quickStatItem}>
          <Text style={styles.quickStatValue}>1.2k</Text>
          <Text style={styles.quickStatLabel}>Active Users</Text>
        </View>
        <View style={styles.quickStatItem}>
          <Text style={styles.quickStatValue}>45</Text>
          <Text style={styles.quickStatLabel}>New Today</Text>
        </View>
      </View>
    </View>
  );

  return (
    <View style={styles.container}>
      {renderHeader()}
      {renderTimeRangeSelector()}
      {renderMetricCards()}
      {renderChart()}
      {renderQuickStats()}
      {renderFilters()}
      {renderExportMenu()}
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#f5f5f5',
  },
  header: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    padding: 20,
    backgroundColor: '#fff',
    borderBottomWidth: 1,
    borderBottomColor: '#e0e0e0',
  },
  headerTitle: {
    fontSize: 24,
    fontWeight: 'bold',
    color: '#333',
  },
  headerSubtitle: {
    fontSize: 14,
    color: '#666',
    marginTop: 2,
  },
  headerActions: {
    flexDirection: 'row',
    gap: 12,
  },
  headerButton: {
    width: 40,
    height: 40,
    borderRadius: 20,
    backgroundColor: '#f0f0f0',
    justifyContent: 'center',
    alignItems: 'center',
  },
  timeRangeContainer: {
    paddingVertical: 16,
    backgroundColor: '#fff',
    borderBottomWidth: 1,
    borderBottomColor: '#e0e0e0',
  },
  timeRangeButton: {
    paddingHorizontal: 20,
    paddingVertical: 8,
    marginHorizontal: 4,
    borderRadius: 20,
    backgroundColor: '#f0f0f0',
  },
  timeRangeButtonActive: {
    backgroundColor: '#007AFF',
  },
  timeRangeText: {
    fontSize: 14,
    color: '#666',
    fontWeight: '500',
  },
  timeRangeTextActive: {
    color: '#fff',
  },
  metricCardsContainer: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    padding: 16,
    gap: 12,
  },
  metricCard: {
    width: (width - 48) / 2,
    backgroundColor: '#fff',
    borderRadius: 12,
    padding: 16,
    borderWidth: 2,
    borderColor: 'transparent',
  },
  metricCardSelected: {
    borderColor: '#007AFF',
  },
  metricCardHeader: {
    flexDirection: 'row',
    alignItems: 'center',
    marginBottom: 12,
  },
  metricIcon: {
    width: 32,
    height: 32,
    borderRadius: 16,
    justifyContent: 'center',
    alignItems: 'center',
    marginRight: 8,
  },
  metricLabel: {
    fontSize: 14,
    color: '#666',
    fontWeight: '500',
  },
  metricValue: {
    fontSize: 24,
    fontWeight: 'bold',
    color: '#333',
    marginBottom: 8,
  },
  metricChange: {
    flexDirection: 'row',
    alignItems: 'center',
  },
  metricChangeText: {
    fontSize: 12,
    fontWeight: '600',
    marginLeft: 4,
  },
  chartContainer: {
    backgroundColor: '#fff',
    margin: 16,
    borderRadius: 12,
    padding: 16,
  },
  chartHeader: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    marginBottom: 20,
  },
  chartTitle: {
    fontSize: 18,
    fontWeight: 'bold',
    color: '#333',
  },
  chartLegend: {
    flexDirection: 'row',
    gap: 16,
  },
  legendItem: {
    flexDirection: 'row',
    alignItems: 'center',
  },
  legendColor: {
    width: 12,
    height: 12,
    borderRadius: 6,
    marginRight: 6,
  },
  legendText: {
    fontSize: 12,
    color: '#666',
  },
  chartLoading: {
    height: 120,
    justifyContent: 'center',
    alignItems: 'center',
  },
  chartLoadingText: {
    fontSize: 14,
    color: '#666',
  },
  chart: {
    height: 120,
  },
  chartBars: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'flex-end',
    height: 120,
  },
  chartBarContainer: {
    flex: 1,
    alignItems: 'center',
    marginHorizontal: 2,
  },
  chartBar: {
    width: 20,
    borderRadius: 10,
    marginBottom: 8,
  },
  chartBarLabel: {
    fontSize: 10,
    color: '#666',
  },
  quickStatsContainer: {
    backgroundColor: '#fff',
    margin: 16,
    borderRadius: 12,
    padding: 16,
  },
  quickStatsTitle: {
    fontSize: 16,
    fontWeight: 'bold',
    color: '#333',
    marginBottom: 12,
  },
  quickStatsGrid: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    gap: 16,
  },
  quickStatItem: {
    width: (width - 80) / 2,
    alignItems: 'center',
  },
  quickStatValue: {
    fontSize: 20,
    fontWeight: 'bold',
    color: '#007AFF',
  },
  quickStatLabel: {
    fontSize: 12,
    color: '#666',
    marginTop: 4,
  },
  modalOverlay: {
    flex: 1,
    backgroundColor: 'rgba(0, 0, 0, 0.5)',
    justifyContent: 'center',
    alignItems: 'center',
  },
  modalContent: {
    backgroundColor: '#fff',
    borderRadius: 12,
    padding: 20,
    width: width - 40,
    maxHeight: '80%',
  },
  modalHeader: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    marginBottom: 20,
  },
  modalTitle: {
    fontSize: 20,
    fontWeight: 'bold',
    color: '#333',
  },
  filterSection: {
    marginBottom: 20,
  },
  filterLabel: {
    fontSize: 16,
    fontWeight: '600',
    color: '#333',
    marginBottom: 12,
  },
  filterOption: {
    paddingVertical: 12,
    borderBottomWidth: 1,
    borderBottomColor: '#f0f0f0',
  },
  filterOptionContent: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
  },
  filterOptionLeft: {
    flexDirection: 'row',
    alignItems: 'center',
  },
  filterIcon: {
    width: 24,
    height: 24,
    borderRadius: 12,
    justifyContent: 'center',
    alignItems: 'center',
    marginRight: 12,
  },
  filterOptionText: {
    fontSize: 16,
    color: '#333',
  },
  exportMenu: {
    backgroundColor: '#fff',
    borderRadius: 12,
    padding: 20,
    width: width - 40,
  },
  exportMenuTitle: {
    fontSize: 18,
    fontWeight: 'bold',
    color: '#333',
    marginBottom: 16,
    textAlign: 'center',
  },
  exportOption: {
    flexDirection: 'row',
    alignItems: 'center',
    paddingVertical: 16,
    borderBottomWidth: 1,
    borderBottomColor: '#f0f0f0',
  },
  exportOptionText: {
    fontSize: 16,
    color: '#333',
    marginLeft: 12,
  },
  exportCancel: {
    paddingVertical: 16,
    alignItems: 'center',
    marginTop: 8,
  },
  exportCancelText: {
    fontSize: 16,
    color: '#666',
  },
});

export default DashboardWidget;

import 'package:flutter/material.dart';

class DashboardWidget extends StatefulWidget {
  const DashboardWidget({Key? key}) : super(key: key);

  @override
  State<DashboardWidget> createState() => _DashboardWidgetState();
}

class _DashboardWidgetState extends State<DashboardWidget> {
  String selectedTimeRange = '7d';
  String selectedMetric = 'revenue';
  bool showFilters = false;
  bool showExportMenu = false;
  List<double> chartData = [];
  bool isLoading = false;

  final List<Map<String, dynamic>> timeRanges = [
    {'value': '1d', 'label': '1 Day'},
    {'value': '7d', 'label': '7 Days'},
    {'value': '30d', 'label': '30 Days'},
    {'value': '90d', 'label': '90 Days'},
    {'value': '1y', 'label': '1 Year'},
  ];

  final List<Map<String, dynamic>> metrics = [
    {'value': 'revenue', 'label': 'Revenue', 'icon': Icons.attach_money, 'color': Colors.green},
    {'value': 'users', 'label': 'Users', 'icon': Icons.people, 'color': Colors.blue},
    {'value': 'orders', 'label': 'Orders', 'icon': Icons.shopping_cart, 'color': Colors.orange},
    {'value': 'conversion', 'label': 'Conversion', 'icon': Icons.trending_up, 'color': Colors.purple},
  ];

  final Map<String, Map<String, dynamic>> sampleData = {
    'revenue': {
      'current': 125430,
      'previous': 118920,
      'data': [12000, 15000, 18000, 22000, 19000, 25000, 28000],
    },
    'users': {
      'current': 15420,
      'previous': 14230,
      'data': [1200, 1400, 1600, 1800, 1700, 2000, 2200],
    },
    'orders': {
      'current': 892,
      'previous': 756,
      'data': [80, 95, 110, 125, 105, 140, 155],
    },
    'conversion': {
      'current': 3.2,
      'previous': 2.8,
      'data': [2.5, 2.8, 3.1, 3.4, 3.0, 3.3, 3.6],
    },
  };

  @override
  void initState() {
    super.initState();
    _loadChartData();
  }

  void _loadChartData() async {
    setState(() {
      isLoading = true;
    });

    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      chartData = List<double>.from(sampleData[selectedMetric]!['data']);
      isLoading = false;
    });
  }

  String _formatValue(dynamic value, String metric) {
    switch (metric) {
      case 'revenue':
        return '\$${value.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}';
      case 'users':
        return value.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},');
      case 'orders':
        return value.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},');
      case 'conversion':
        return '${value}%';
      default:
        return value.toString();
    }
  }

  double _calculateChange(dynamic current, dynamic previous) {
    return ((current - previous) / previous) * 100;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Analytics Dashboard'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () => setState(() => showFilters = true),
          ),
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: () => setState(() => showExportMenu = true),
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadChartData,
          ),
        ],
      ),
      body: Column(
        children: [
          _buildTimeRangeSelector(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildMetricCards(),
                  _buildChart(),
                  _buildQuickStats(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeRangeSelector() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      color: Colors.white,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: timeRanges.map((range) {
            final isSelected = selectedTimeRange == range['value'];
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: FilterChip(
                label: Text(range['label']),
                selected: isSelected,
                onSelected: (selected) {
                  setState(() {
                    selectedTimeRange = range['value'];
                  });
                  _loadChartData();
                },
                selectedColor: Colors.blue[100],
                checkmarkColor: Colors.blue,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildMetricCards() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.5,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: metrics.length,
        itemBuilder: (context, index) {
          final metric = metrics[index];
          final data = sampleData[metric['value']]!;
          final change = _calculateChange(data['current'], data['previous']);
          final isPositive = change >= 0;
          final isSelected = selectedMetric == metric['value'];

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedMetric = metric['value'];
              });
              _loadChartData();
            },
            child: Card(
              elevation: isSelected ? 4 : 1,
              color: isSelected ? Colors.blue[50] : Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: metric['color'],
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Icon(
                            metric['icon'],
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            metric['label'],
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      _formatValue(data['current'], metric['value']),
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(
                          isPositive ? Icons.trending_up : Icons.trending_down,
                          size: 16,
                          color: isPositive ? Colors.green : Colors.red,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${change.abs().toStringAsFixed(1)}%',
                          style: TextStyle(
                            fontSize: 12,
                            color: isPositive ? Colors.green : Colors.red,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildChart() {
    final metric = metrics.firstWhere((m) => m['value'] == selectedMetric);
    final data = sampleData[selectedMetric]!;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${metric['label']} Trend',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    _buildLegendItem(Colors.blue, 'Current Period'),
                    const SizedBox(width: 16),
                    _buildLegendItem(Colors.grey, 'Previous Period'),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 120,
              child: isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : _buildChartBars(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLegendItem(Color color, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildChartBars() {
    if (chartData.isEmpty) return const SizedBox();

    final maxValue = chartData.reduce((a, b) => a > b ? a : b);
    final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: chartData.asMap().entries.map((entry) {
        final index = entry.key;
        final value = entry.value;
        final height = (value / maxValue) * 100;
        final metric = metrics.firstWhere((m) => m['value'] == selectedMetric);

        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              width: 20,
              height: height,
              decoration: BoxDecoration(
                color: metric['color'],
                borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              days[index],
              style: const TextStyle(fontSize: 10, color: Colors.grey),
            ),
          ],
        );
      }).toList(),
    );
  }

  Widget _buildQuickStats() {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Quick Stats',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              childAspectRatio: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: [
                _buildQuickStatItem('98.5%', 'Uptime'),
                _buildQuickStatItem('2.3s', 'Avg Response'),
                _buildQuickStatItem('1.2k', 'Active Users'),
                _buildQuickStatItem('45', 'New Today'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickStatItem(String value, String label) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  void _showFilters() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Filter Options',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Time Range',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            ...timeRanges.map((range) => ListTile(
              title: Text(range['label']),
              trailing: selectedTimeRange == range['value']
                  ? const Icon(Icons.check, color: Colors.blue)
                  : null,
              onTap: () {
                setState(() {
                  selectedTimeRange = range['value'];
                });
                Navigator.pop(context);
                _loadChartData();
              },
            )),
            const SizedBox(height: 20),
            const Text(
              'Metric',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            ...metrics.map((metric) => ListTile(
              leading: Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: metric['color'],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  metric['icon'],
                  color: Colors.white,
                  size: 16,
                ),
              ),
              title: Text(metric['label']),
              trailing: selectedMetric == metric['value']
                  ? const Icon(Icons.check, color: Colors.blue)
                  : null,
              onTap: () {
                setState(() {
                  selectedMetric = metric['value'];
                });
                Navigator.pop(context);
                _loadChartData();
              },
            )),
          ],
        ),
      ),
    );
  }

  void _showExportMenu() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Export Data',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            _buildExportOption(Icons.table_chart, 'CSV Format', () {
              Navigator.pop(context);
              _exportData('CSV');
            }),
            _buildExportOption(Icons.table_view, 'Excel Format', () {
              Navigator.pop(context);
              _exportData('Excel');
            }),
            _buildExportOption(Icons.picture_as_pdf, 'PDF Report', () {
              Navigator.pop(context);
              _exportData('PDF');
            }),
            _buildExportOption(Icons.image, 'Image (PNG)', () {
              Navigator.pop(context);
              _exportData('PNG');
            }),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExportOption(IconData icon, String label, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue),
      title: Text(label),
      onTap: onTap,
    );
  }

  void _exportData(String format) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Exporting data as $format...')),
    );
  }
}

import SwiftUI
import Charts

struct DashboardWidget: View {
    @State private var selectedTimeRange: TimeRange = .week
    @State private var selectedMetric: Metric = .revenue
    @State private var selectedChartType: ChartType = .line
    @State private var showFilters: Bool = false
    @State private var showExportOptions: Bool = false
    @State private var isLoading: Bool = false
    @State private var selectedDataPoint: DataPoint? = nil
    @State private var showTooltip: Bool = false
    @State private var tooltipPosition: CGPoint = .zero
    
    let timeRanges: [TimeRange] = [.day, .week, .month, .quarter, .year]
    let metrics: [Metric] = [.revenue, .users, .orders, .conversion]
    let chartTypes: [ChartType] = [.line, .bar, .area, .pie]
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                headerView
                controlsView
                
                if showFilters {
                    filtersView
                }
                
                if isLoading {
                    loadingView
                } else {
                    contentView
                }
                
                if showExportOptions {
                    exportOptionsView
                }
            }
            .navigationTitle("Analytics Dashboard")
            .navigationBarTitleDisplayMode(.large)
            .onAppear {
                loadData()
            }
        }
    }
    
    private var headerView: some View {
        VStack(spacing: 8) {
            HStack {
                Text("Analytics Dashboard")
                    .font(.title)
                    .fontWeight(.bold)
                
                Spacer()
                
                HStack(spacing: 12) {
                    Button(action: { showFilters.toggle() }) {
                        Image(systemName: showFilters ? "line.3.horizontal.decrease.circle.fill" : "line.3.horizontal.decrease.circle")
                    }
                    .buttonStyle(.bordered)
                    
                    Button(action: { showExportOptions.toggle() }) {
                        Image(systemName: "square.and.arrow.up")
                    }
                    .buttonStyle(.bordered)
                    
                    Button(action: refreshData) {
                        Image(systemName: "arrow.clockwise")
                    }
                    .buttonStyle(.bordered)
                }
            }
            
            Text("Real-time insights and analytics")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .padding()
    }
    
    private var controlsView: some View {
        VStack(spacing: 16) {
            HStack {
                Text("Time Range")
                    .font(.headline)
                
                Spacer()
                
                Picker("Time Range", selection: $selectedTimeRange) {
                    ForEach(timeRanges, id: \.self) { range in
                        Text(range.displayName).tag(range)
                    }
                }
                .pickerStyle(.segmented)
                .onChange(of: selectedTimeRange) { _ in
                    loadData()
                }
            }
            
            HStack {
                Text("Metric")
                    .font(.headline)
                
                Spacer()
                
                Picker("Metric", selection: $selectedMetric) {
                    ForEach(metrics, id: \.self) { metric in
                        Text(metric.displayName).tag(metric)
                    }
                }
                .pickerStyle(.menu)
                .onChange(of: selectedMetric) { _ in
                    loadData()
                }
            }
            
            HStack {
                Text("Chart Type")
                    .font(.headline)
                
                Spacer()
                
                Picker("Chart Type", selection: $selectedChartType) {
                    ForEach(chartTypes, id: \.self) { type in
                        HStack {
                            Image(systemName: type.icon)
                            Text(type.displayName)
                        }.tag(type)
                    }
                }
                .pickerStyle(.menu)
            }
        }
        .padding()
        .background(Color(.systemGray6))
    }
    
    private var filtersView: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Advanced Filters")
                    .font(.headline)
                Spacer()
                Button("Clear All") {
                    clearFilters()
                }
                .buttonStyle(.bordered)
            }
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 16) {
                VStack(alignment: .leading) {
                    Text("Date Range")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                    
                    DatePicker("From", selection: .constant(Date().addingTimeInterval(-86400 * 7)), displayedComponents: .date)
                        .datePickerStyle(.compact)
                    
                    DatePicker("To", selection: .constant(Date()), displayedComponents: .date)
                        .datePickerStyle(.compact)
                }
                
                VStack(alignment: .leading) {
                    Text("Data Source")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                    
                    Picker("Source", selection: .constant("All")) {
                        Text("All Sources").tag("all")
                        Text("Web").tag("web")
                        Text("Mobile").tag("mobile")
                        Text("API").tag("api")
                    }
                    .pickerStyle(.menu)
                }
                
                VStack(alignment: .leading) {
                    Text("Region")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                    
                    Picker("Region", selection: .constant("All")) {
                        Text("All Regions").tag("all")
                        Text("North America").tag("na")
                        Text("Europe").tag("eu")
                        Text("Asia").tag("asia")
                    }
                    .pickerStyle(.menu)
                }
                
                VStack(alignment: .leading) {
                    Text("Device Type")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                    
                    Picker("Device", selection: .constant("All")) {
                        Text("All Devices").tag("all")
                        Text("Desktop").tag("desktop")
                        Text("Tablet").tag("tablet")
                        Text("Mobile").tag("mobile")
                    }
                    .pickerStyle(.menu)
                }
            }
        }
        .padding()
        .background(Color(.systemGray6))
    }
    
    private var contentView: some View {
        ScrollView {
            VStack(spacing: 20) {
                metricsCardsView
                chartView
                detailedStatsView
            }
            .padding()
        }
    }
    
    private var metricsCardsView: some View {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 16) {
            ForEach(sampleMetrics, id: \.title) { metric in
                MetricCard(metric: metric)
            }
        }
    }
    
    private var chartView: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("\(selectedMetric.displayName) Trend")
                    .font(.title2)
                    .fontWeight(.bold)
                
                Spacer()
                
                HStack(spacing: 8) {
                    Button(action: { selectedChartType = .line }) {
                        Image(systemName: "chart.line.uptrend.xyaxis")
                            .foregroundColor(selectedChartType == .line ? .blue : .gray)
                    }
                    .buttonStyle(.plain)
                    
                    Button(action: { selectedChartType = .bar }) {
                        Image(systemName: "chart.bar")
                            .foregroundColor(selectedChartType == .bar ? .blue : .gray)
                    }
                    .buttonStyle(.plain)
                    
                    Button(action: { selectedChartType = .area }) {
                        Image(systemName: "chart.line.uptrend.xyaxis.circle")
                            .foregroundColor(selectedChartType == .area ? .blue : .gray)
                    }
                    .buttonStyle(.plain)
                    
                    Button(action: { selectedChartType = .pie }) {
                        Image(systemName: "chart.pie")
                            .foregroundColor(selectedChartType == .pie ? .blue : .gray)
                    }
                    .buttonStyle(.plain)
                }
            }
            
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(.systemBackground))
                    .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
                
                VStack {
                    if selectedChartType == .line {
                        LineChartView(data: chartData, selectedDataPoint: $selectedDataPoint)
                    } else if selectedChartType == .bar {
                        BarChartView(data: chartData, selectedDataPoint: $selectedDataPoint)
                    } else if selectedChartType == .area {
                        AreaChartView(data: chartData, selectedDataPoint: $selectedDataPoint)
                    } else {
                        PieChartView(data: chartData, selectedDataPoint: $selectedDataPoint)
                    }
                }
                .padding()
            }
            .frame(height: 300)
            .onTapGesture { location in
                handleChartTap(at: location)
            }
            
            if let dataPoint = selectedDataPoint {
                HStack {
                    Text("Selected: \(dataPoint.label)")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    Spacer()
                    
                    Text("Value: \(formatValue(dataPoint.value))")
                        .font(.caption)
                        .fontWeight(.semibold)
                }
                .padding(.horizontal)
            }
        }
    }
    
    private var detailedStatsView: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Detailed Statistics")
                .font(.title2)
                .fontWeight(.bold)
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 1), spacing: 12) {
                ForEach(detailedStats, id: \.title) { stat in
                    StatRow(stat: stat)
                }
            }
        }
    }
    
    private var loadingView: some View {
        VStack(spacing: 16) {
            ProgressView()
                .scaleEffect(1.5)
            Text("Loading analytics data...")
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    private var exportOptionsView: some View {
        VStack(spacing: 16) {
            Text("Export Options")
                .font(.headline)
            
            VStack(spacing: 12) {
                Button("Export as PDF") {
                    exportData(format: "pdf")
                }
                .buttonStyle(.borderedProminent)
                
                Button("Export as CSV") {
                    exportData(format: "csv")
                }
                .buttonStyle(.borderedProminent)
                
                Button("Export as Excel") {
                    exportData(format: "excel")
                }
                .buttonStyle(.borderedProminent)
                
                Button("Share Dashboard") {
                    shareDashboard()
                }
                .buttonStyle(.bordered)
            }
            
            Button("Cancel") {
                showExportOptions = false
            }
            .buttonStyle(.bordered)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
        .padding()
    }
    
    // MARK: - Computed Properties
    
    private var chartData: [DataPoint] {
        generateChartData(for: selectedMetric, timeRange: selectedTimeRange)
    }
    
    private var sampleMetrics: [MetricData] {
        [
            MetricData(title: "Total Revenue", value: 125000, change: 12.5, changeType: .positive, icon: "dollarsign.circle"),
            MetricData(title: "Active Users", value: 15420, change: 8.2, changeType: .positive, icon: "person.2"),
            MetricData(title: "Orders", value: 3420, change: -2.1, changeType: .negative, icon: "cart"),
            MetricData(title: "Conversion Rate", value: 3.2, change: 0.8, changeType: .positive, icon: "percent")
        ]
    }
    
    private var detailedStats: [StatData] {
        [
            StatData(title: "Average Order Value", value: "$36.50", subtitle: "Up 5.2% from last period"),
            StatData(title: "Bounce Rate", value: "42.3%", subtitle: "Down 2.1% from last period"),
            StatData(title: "Session Duration", value: "4m 32s", subtitle: "Up 12.5% from last period"),
            StatData(title: "Page Views", value: "89,420", subtitle: "Up 8.7% from last period"),
            StatData(title: "New Users", value: "12,340", subtitle: "Up 15.3% from last period"),
            StatData(title: "Returning Users", value: "41,080", subtitle: "Up 3.2% from last period")
        ]
    }
    
    // MARK: - Methods
    
    private func loadData() {
        isLoading = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            isLoading = false
        }
    }
    
    private func refreshData() {
        loadData()
    }
    
    private func clearFilters() {
        // Clear filter logic
    }
    
    private func exportData(format: String) {
        print("Exporting data as \(format)")
        showExportOptions = false
    }
    
    private func shareDashboard() {
        print("Sharing dashboard")
        showExportOptions = false
    }
    
    private func handleChartTap(at location: CGPoint) {
        // Handle chart tap for data point selection
    }
    
    private func generateChartData(for metric: Metric, timeRange: TimeRange) -> [DataPoint] {
        let days = timeRange.dayCount
        var data: [DataPoint] = []
        
        for i in 0..<days {
            let date = Date().addingTimeInterval(-Double((days - i - 1) * 86400))
            let formatter = DateFormatter()
            formatter.dateFormat = timeRange.dateFormat
            
            let baseValue = metric.baseValue
            let variation = Double.random(in: -0.2...0.2)
            let value = baseValue * (1 + variation)
            
            data.append(DataPoint(
                label: formatter.string(from: date),
                value: value,
                date: date
            ))
        }
        
        return data
    }
    
    private func formatValue(_ value: Double) -> String {
        if selectedMetric == .revenue {
            return String(format: "$%.0f", value)
        } else if selectedMetric == .conversion {
            return String(format: "%.1f%%", value)
        } else {
            return String(format: "%.0f", value)
        }
    }
}

// MARK: - Supporting Views

struct MetricCard: View {
    let metric: MetricData
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: metric.icon)
                    .foregroundColor(.blue)
                    .font(.title2)
                
                Spacer()
                
                Text(metric.changeType == .positive ? "+" : "") + Text("\(metric.change, specifier: "%.1f")%")
                    .foregroundColor(metric.changeType == .positive ? .green : .red)
                    .font(.caption)
                    .fontWeight(.semibold)
            }
            
            Text(metric.title)
                .font(.caption)
                .foregroundColor(.secondary)
            
            Text(formatMetricValue(metric.value))
                .font(.title2)
                .fontWeight(.bold)
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
    }
    
    private func formatMetricValue(_ value: Double) -> String {
        if value >= 1000000 {
            return String(format: "%.1fM", value / 1000000)
        } else if value >= 1000 {
            return String(format: "%.1fK", value / 1000)
        } else {
            return String(format: "%.1f", value)
        }
    }
}

struct StatRow: View {
    let stat: StatData
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(stat.title)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                
                Text(stat.subtitle)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Text(stat.value)
                .font(.headline)
                .fontWeight(.bold)
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(8)
        .shadow(color: .black.opacity(0.05), radius: 2, x: 0, y: 1)
    }
}

// MARK: - Chart Views

struct LineChartView: View {
    let data: [DataPoint]
    @Binding var selectedDataPoint: DataPoint?
    
    var body: some View {
        VStack {
            Text("Line Chart")
                .font(.headline)
            Text("Interactive line chart showing trends over time")
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct BarChartView: View {
    let data: [DataPoint]
    @Binding var selectedDataPoint: DataPoint?
    
    var body: some View {
        VStack {
            Text("Bar Chart")
                .font(.headline)
            Text("Interactive bar chart showing data distribution")
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct AreaChartView: View {
    let data: [DataPoint]
    @Binding var selectedDataPoint: DataPoint?
    
    var body: some View {
        VStack {
            Text("Area Chart")
                .font(.headline)
            Text("Interactive area chart showing cumulative data")
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct PieChartView: View {
    let data: [DataPoint]
    @Binding var selectedDataPoint: DataPoint?
    
    var body: some View {
        VStack {
            Text("Pie Chart")
                .font(.headline)
            Text("Interactive pie chart showing data proportions")
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

// MARK: - Supporting Types

enum TimeRange: CaseIterable {
    case day, week, month, quarter, year
    
    var displayName: String {
        switch self {
        case .day: return "Day"
        case .week: return "Week"
        case .month: return "Month"
        case .quarter: return "Quarter"
        case .year: return "Year"
        }
    }
    
    var dayCount: Int {
        switch self {
        case .day: return 1
        case .week: return 7
        case .month: return 30
        case .quarter: return 90
        case .year: return 365
        }
    }
    
    var dateFormat: String {
        switch self {
        case .day: return "HH:mm"
        case .week: return "EEE"
        case .month: return "MMM dd"
        case .quarter: return "MMM dd"
        case .year: return "MMM"
        }
    }
}

enum Metric: CaseIterable {
    case revenue, users, orders, conversion
    
    var displayName: String {
        switch self {
        case .revenue: return "Revenue"
        case .users: return "Users"
        case .orders: return "Orders"
        case .conversion: return "Conversion Rate"
        }
    }
    
    var baseValue: Double {
        switch self {
        case .revenue: return 5000
        case .users: return 1000
        case .orders: return 200
        case .conversion: return 3.5
        }
    }
}

enum ChartType: CaseIterable {
    case line, bar, area, pie
    
    var displayName: String {
        switch self {
        case .line: return "Line"
        case .bar: return "Bar"
        case .area: return "Area"
        case .pie: return "Pie"
        }
    }
    
    var icon: String {
        switch self {
        case .line: return "chart.line.uptrend.xyaxis"
        case .bar: return "chart.bar"
        case .area: return "chart.line.uptrend.xyaxis.circle"
        case .pie: return "chart.pie"
        }
    }
}

struct DataPoint {
    let label: String
    let value: Double
    let date: Date
}

struct MetricData {
    let title: String
    let value: Double
    let change: Double
    let changeType: ChangeType
    let icon: String
}

struct StatData {
    let title: String
    let value: String
    let subtitle: String
}

enum ChangeType {
    case positive, negative
}

// MARK: - Preview

struct DashboardWidget_Previews: PreviewProvider {
    static var previews: some View {
        DashboardWidget()
    }
}

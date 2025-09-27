package com.accessibilityapp;

import android.app.Activity;
import android.os.Bundle;
import android.view.View;
import android.widget.*;
import android.widget.CompoundButton.OnCheckedChangeListener;
import android.graphics.Color;
import android.graphics.Paint;
import android.graphics.Canvas;
import android.graphics.RectF;
import android.view.LayoutInflater;
import android.view.ViewGroup;
import android.widget.LinearLayout;
import java.util.*;

public class DashboardWidgetActivity extends Activity {
    
    private LinearLayout chartContainer;
    private LinearLayout filterContainer;
    private LinearLayout legendContainer;
    private TextView chartTitle;
    private TextView chartDescription;
    private Spinner timeRangeSpinner;
    private Spinner dataTypeSpinner;
    private CheckBox showTrendCheckbox;
    private Button exportButton;
    private Button refreshButton;
    private TextView lastUpdated;
    private ProgressBar loadingIndicator;
    
    private List<DataPoint> chartData;
    private String selectedTimeRange = "7d";
    private String selectedDataType = "revenue";
    private boolean showTrend = true;
    
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_dashboard_widget);
        
        initializeViews();
        setupData();
        setupListeners();
        updateChart();
    }
    
    private void initializeViews() {
        chartContainer = findViewById(R.id.chartContainer);
        filterContainer = findViewById(R.id.filterContainer);
        legendContainer = findViewById(R.id.legendContainer);
        chartTitle = findViewById(R.id.chartTitle);
        chartDescription = findViewById(R.id.chartDescription);
        timeRangeSpinner = findViewById(R.id.timeRangeSpinner);
        dataTypeSpinner = findViewById(R.id.dataTypeSpinner);
        showTrendCheckbox = findViewById(R.id.showTrendCheckbox);
        exportButton = findViewById(R.id.exportButton);
        refreshButton = findViewById(R.id.refreshButton);
        lastUpdated = findViewById(R.id.lastUpdated);
        loadingIndicator = findViewById(R.id.loadingIndicator);
        
        setupSpinners();
    }
    
    private void setupSpinners() {
        // Time Range Spinner
        String[] timeRanges = {"Last 7 Days", "Last 30 Days", "Last 3 Months", "Last Year"};
        ArrayAdapter<String> timeAdapter = new ArrayAdapter<>(this, 
            android.R.layout.simple_spinner_item, timeRanges);
        timeAdapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
        timeRangeSpinner.setAdapter(timeAdapter);
        
        // Data Type Spinner
        String[] dataTypes = {"Revenue", "Users", "Orders", "Conversion Rate"};
        ArrayAdapter<String> dataAdapter = new ArrayAdapter<>(this, 
            android.R.layout.simple_spinner_item, dataTypes);
        dataAdapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
        dataTypeSpinner.setAdapter(dataAdapter);
    }
    
    private void setupData() {
        chartData = new ArrayList<>();
        generateSampleData();
    }
    
    private void generateSampleData() {
        chartData.clear();
        
        String[] labels = {"Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"};
        int[] values = {12000, 15000, 18000, 14000, 16000, 20000, 17000};
        
        for (int i = 0; i < labels.length; i++) {
            chartData.add(new DataPoint(labels[i], values[i]));
        }
    }
    
    private void setupListeners() {
        timeRangeSpinner.setOnItemSelectedListener(new AdapterView.OnItemSelectedListener() {
            @Override
            public void onItemSelected(AdapterView<?> parent, View view, int position, long id) {
                String[] values = {"7d", "30d", "3m", "1y"};
                selectedTimeRange = values[position];
                updateChart();
            }
            
            @Override
            public void onNothingSelected(AdapterView<?> parent) {}
        });
        
        dataTypeSpinner.setOnItemSelectedListener(new AdapterView.OnItemSelectedListener() {
            @Override
            public void onItemSelected(AdapterView<?> parent, View view, int position, long id) {
                String[] values = {"revenue", "users", "orders", "conversion"};
                selectedDataType = values[position];
                updateChart();
            }
            
            @Override
            public void onNothingSelected(AdapterView<?> parent) {}
        });
        
        showTrendCheckbox.setOnCheckedChangeListener(new OnCheckedChangeListener() {
            @Override
            public void onCheckedChanged(CompoundButton buttonView, boolean isChecked) {
                showTrend = isChecked;
                updateChart();
            }
        });
        
        exportButton.setOnClickListener(v -> exportChart());
        refreshButton.setOnClickListener(v -> refreshData());
    }
    
    private void updateChart() {
        loadingIndicator.setVisibility(View.VISIBLE);
        
        // Simulate data loading
        new android.os.Handler().postDelayed(() -> {
            generateSampleData();
            renderChart();
            updateLegend();
            updateLastUpdated();
            loadingIndicator.setVisibility(View.GONE);
        }, 1000);
    }
    
    private void renderChart() {
        chartContainer.removeAllViews();
        
        // Create custom chart view
        ChartView chartView = new ChartView(this, chartData, showTrend);
        chartContainer.addView(chartView);
        
        // Update title and description
        updateChartInfo();
    }
    
    private void updateChartInfo() {
        String title = "Analytics Dashboard";
        String description = "Showing " + selectedDataType + " data for " + selectedTimeRange;
        
        chartTitle.setText(title);
        chartDescription.setText(description);
    }
    
    private void updateLegend() {
        legendContainer.removeAllViews();
        
        // Add legend items
        addLegendItem("Data Points", Color.BLUE);
        if (showTrend) {
            addLegendItem("Trend Line", Color.RED);
        }
        addLegendItem("Average", Color.GREEN);
    }
    
    private void addLegendItem(String label, int color) {
        LinearLayout legendItem = new LinearLayout(this);
        legendItem.setOrientation(LinearLayout.HORIZONTAL);
        legendItem.setPadding(8, 4, 8, 4);
        
        View colorIndicator = new View(this);
        colorIndicator.setBackgroundColor(color);
        LinearLayout.LayoutParams colorParams = new LinearLayout.LayoutParams(16, 16);
        colorParams.setMargins(0, 0, 8, 0);
        colorIndicator.setLayoutParams(colorParams);
        
        TextView labelText = new TextView(this);
        labelText.setText(label);
        labelText.setTextSize(12);
        labelText.setTextColor(Color.BLACK);
        
        legendItem.addView(colorIndicator);
        legendItem.addView(labelText);
        legendContainer.addView(legendItem);
    }
    
    private void updateLastUpdated() {
        String timestamp = new java.text.SimpleDateFormat("MMM dd, yyyy HH:mm", 
            java.util.Locale.getDefault()).format(new java.util.Date());
        lastUpdated.setText("Last updated: " + timestamp);
    }
    
    private void exportChart() {
        Toast.makeText(this, "Exporting chart data...", Toast.LENGTH_SHORT).show();
    }
    
    private void refreshData() {
        updateChart();
    }
    
    // Custom Chart View
    private class ChartView extends View {
        private List<DataPoint> data;
        private boolean showTrendLine;
        private Paint linePaint;
        private Paint pointPaint;
        private Paint trendPaint;
        private Paint textPaint;
        
        public ChartView(Activity context, List<DataPoint> data, boolean showTrendLine) {
            super(context);
            this.data = data;
            this.showTrendLine = showTrendLine;
            setupPaints();
        }
        
        private void setupPaints() {
            linePaint = new Paint();
            linePaint.setColor(Color.BLUE);
            linePaint.setStrokeWidth(4);
            linePaint.setAntiAlias(true);
            
            pointPaint = new Paint();
            pointPaint.setColor(Color.BLUE);
            pointPaint.setStyle(Paint.Style.FILL);
            pointPaint.setAntiAlias(true);
            
            trendPaint = new Paint();
            trendPaint.setColor(Color.RED);
            trendPaint.setStrokeWidth(3);
            trendPaint.setAntiAlias(true);
            
            textPaint = new Paint();
            textPaint.setColor(Color.BLACK);
            textPaint.setTextSize(24);
            textPaint.setAntiAlias(true);
        }
        
        @Override
        protected void onDraw(Canvas canvas) {
            super.onDraw(canvas);
            
            if (data.isEmpty()) return;
            
            int width = getWidth();
            int height = getHeight();
            int padding = 60;
            int chartWidth = width - 2 * padding;
            int chartHeight = height - 2 * padding;
            
            // Find min and max values
            int minValue = Integer.MAX_VALUE;
            int maxValue = Integer.MIN_VALUE;
            for (DataPoint point : data) {
                minValue = Math.min(minValue, point.getValue());
                maxValue = Math.max(maxValue, point.getValue());
            }
            
            // Draw chart lines and points
            float prevX = 0, prevY = 0;
            for (int i = 0; i < data.size(); i++) {
                DataPoint point = data.get(i);
                float x = padding + (i * chartWidth) / (data.size() - 1);
                float y = padding + chartHeight - ((point.getValue() - minValue) * chartHeight) / (maxValue - minValue);
                
                if (i > 0) {
                    canvas.drawLine(prevX, prevY, x, y, linePaint);
                }
                
                canvas.drawCircle(x, y, 8, pointPaint);
                
                // Draw labels
                canvas.drawText(point.getLabel(), x - 20, height - 20, textPaint);
                
                prevX = x;
                prevY = y;
            }
            
            // Draw trend line if enabled
            if (showTrendLine && data.size() > 1) {
                float startX = padding;
                float startY = padding + chartHeight - ((data.get(0).getValue() - minValue) * chartHeight) / (maxValue - minValue);
                float endX = padding + chartWidth;
                float endY = padding + chartHeight - ((data.get(data.size() - 1).getValue() - minValue) * chartHeight) / (maxValue - minValue);
                canvas.drawLine(startX, startY, endX, endY, trendPaint);
            }
        }
    }
    
    // Data Point class
    public static class DataPoint {
        private String label;
        private int value;
        
        public DataPoint(String label, int value) {
            this.label = label;
            this.value = value;
        }
        
        public String getLabel() { return label; }
        public int getValue() { return value; }
    }
}

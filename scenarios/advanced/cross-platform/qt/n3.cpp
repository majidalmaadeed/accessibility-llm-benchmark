#include "dashboardwidget.h"
#include <QApplication>
#include <QMessageBox>
#include <QTimer>
#include <QDateTime>
#include <QFileDialog>
#include <QTextStream>

DashboardWidget::DashboardWidget(QWidget *parent)
    : QWidget(parent)
    , m_lineChartView(nullptr)
    , m_barChartView(nullptr)
    , m_pieChartView(nullptr)
    , m_totalUsersLabel(nullptr)
    , m_activeUsersLabel(nullptr)
    , m_revenueLabel(nullptr)
    , m_conversionLabel(nullptr)
    , m_goalProgressBar(nullptr)
    , m_recentActivityTable(nullptr)
    , m_topProductsTable(nullptr)
    , m_alertsTable(nullptr)
    , m_timeRangeCombo(nullptr)
    , m_startDateEdit(nullptr)
    , m_endDateEdit(nullptr)
    , m_refreshButton(nullptr)
    , m_exportButton(nullptr)
    , m_fullscreenButton(nullptr)
    , m_updateTimer(nullptr)
{
    setupUI();
    setupCharts();
    setupMetrics();
    setupTables();
    setupControls();
    
    // Start update timer
    m_updateTimer = new QTimer(this);
    connect(m_updateTimer, &QTimer::timeout, this, &DashboardWidget::updateData);
    m_updateTimer->start(5000); // Update every 5 seconds
}

void DashboardWidget::setupUI()
{
    QVBoxLayout *mainLayout = new QVBoxLayout(this);
    mainLayout->setContentsMargins(20, 20, 20, 20);
    mainLayout->setSpacing(15);
    
    // Title
    QLabel *titleLabel = new QLabel("Dashboard Widget", this);
    titleLabel->setStyleSheet(
        "QLabel {"
        "    font-size: 24px;"
        "    font-weight: bold;"
        "    color: white;"
        "    margin-bottom: 10px;"
        "}"
    );
    mainLayout->addWidget(titleLabel);
    
    // Controls
    QHBoxLayout *controlsLayout = new QHBoxLayout();
    
    m_timeRangeCombo = new QComboBox();
    m_timeRangeCombo->addItems({"Last 24 Hours", "Last 7 Days", "Last 30 Days", "Last 3 Months", "Last Year"});
    m_timeRangeCombo->setStyleSheet(
        "QComboBox {"
        "    padding: 8px 12px;"
        "    border: 1px solid #555;"
        "    border-radius: 4px;"
        "    background-color: #2b2b2b;"
        "    color: white;"
        "    font-size: 14px;"
        "}"
    );
    
    m_startDateEdit = new QDateEdit();
    m_startDateEdit->setDate(QDate::currentDate().addDays(-7));
    m_startDateEdit->setStyleSheet(
        "QDateEdit {"
        "    padding: 8px 12px;"
        "    border: 1px solid #555;"
        "    border-radius: 4px;"
        "    background-color: #2b2b2b;"
        "    color: white;"
        "    font-size: 14px;"
        "}"
    );
    
    m_endDateEdit = new QDateEdit();
    m_endDateEdit->setDate(QDate::currentDate());
    m_endDateEdit->setStyleSheet(m_startDateEdit->styleSheet());
    
    m_refreshButton = new QPushButton("Refresh");
    m_refreshButton->setStyleSheet(
        "QPushButton {"
        "    background-color: #61dafb;"
        "    color: black;"
        "    border: none;"
        "    padding: 10px 20px;"
        "    border-radius: 6px;"
        "    font-weight: bold;"
        "    font-size: 14px;"
        "}"
        "QPushButton:hover {"
        "    background-color: #4fa8d8;"
        "}"
    );
    
    m_exportButton = new QPushButton("Export");
    m_exportButton->setStyleSheet(m_refreshButton->styleSheet());
    
    m_fullscreenButton = new QPushButton("Fullscreen");
    m_fullscreenButton->setStyleSheet(m_refreshButton->styleSheet());
    
    controlsLayout->addWidget(new QLabel("Time Range:", this));
    controlsLayout->addWidget(m_timeRangeCombo);
    controlsLayout->addWidget(new QLabel("From:", this));
    controlsLayout->addWidget(m_startDateEdit);
    controlsLayout->addWidget(new QLabel("To:", this));
    controlsLayout->addWidget(m_endDateEdit);
    controlsLayout->addStretch();
    controlsLayout->addWidget(m_refreshButton);
    controlsLayout->addWidget(m_exportButton);
    controlsLayout->addWidget(m_fullscreenButton);
    
    mainLayout->addLayout(controlsLayout);
    
    // Metrics
    QHBoxLayout *metricsLayout = new QHBoxLayout();
    
    QGroupBox *totalUsersGroup = new QGroupBox("Total Users");
    totalUsersGroup->setStyleSheet(
        "QGroupBox {"
        "    font-weight: bold;"
        "    color: white;"
        "    border: 2px solid #3a3a3a;"
        "    border-radius: 8px;"
        "    margin-top: 10px;"
        "    padding-top: 10px;"
        "}"
    );
    
    QVBoxLayout *totalUsersLayout = new QVBoxLayout(totalUsersGroup);
    m_totalUsersLabel = new QLabel("1,234");
    m_totalUsersLabel->setStyleSheet(
        "QLabel {"
        "    font-size: 32px;"
        "    font-weight: bold;"
        "    color: #61dafb;"
        "    text-align: center;"
        "}"
    );
    totalUsersLayout->addWidget(m_totalUsersLabel);
    
    QGroupBox *activeUsersGroup = new QGroupBox("Active Users");
    activeUsersGroup->setStyleSheet(totalUsersGroup->styleSheet());
    
    QVBoxLayout *activeUsersLayout = new QVBoxLayout(activeUsersGroup);
    m_activeUsersLabel = new QLabel("567");
    m_activeUsersLabel->setStyleSheet(m_totalUsersLabel->styleSheet());
    activeUsersLayout->addWidget(m_activeUsersLabel);
    
    QGroupBox *revenueGroup = new QGroupBox("Revenue");
    revenueGroup->setStyleSheet(totalUsersGroup->styleSheet());
    
    QVBoxLayout *revenueLayout = new QVBoxLayout(revenueGroup);
    m_revenueLabel = new QLabel("$12,345");
    m_revenueLabel->setStyleSheet(m_totalUsersLabel->styleSheet());
    revenueLayout->addWidget(m_revenueLabel);
    
    QGroupBox *conversionGroup = new QGroupBox("Conversion Rate");
    conversionGroup->setStyleSheet(totalUsersGroup->styleSheet());
    
    QVBoxLayout *conversionLayout = new QVBoxLayout(conversionGroup);
    m_conversionLabel = new QLabel("3.2%");
    m_conversionLabel->setStyleSheet(m_totalUsersLabel->styleSheet());
    conversionLayout->addWidget(m_conversionLabel);
    
    metricsLayout->addWidget(totalUsersGroup);
    metricsLayout->addWidget(activeUsersGroup);
    metricsLayout->addWidget(revenueGroup);
    metricsLayout->addWidget(conversionGroup);
    
    mainLayout->addLayout(metricsLayout);
    
    // Charts
    QHBoxLayout *chartsLayout = new QHBoxLayout();
    
    QGroupBox *lineChartGroup = new QGroupBox("User Activity");
    lineChartGroup->setStyleSheet(totalUsersGroup->styleSheet());
    
    QVBoxLayout *lineChartLayout = new QVBoxLayout(lineChartGroup);
    m_lineChartView = new QChartView();
    m_lineChartView->setStyleSheet(
        "QChartView {"
        "    background-color: #1e1e1e;"
        "    border: 1px solid #3a3a3a;"
        "    border-radius: 6px;"
        "}"
    );
    lineChartLayout->addWidget(m_lineChartView);
    
    QGroupBox *barChartGroup = new QGroupBox("Revenue by Month");
    barChartGroup->setStyleSheet(totalUsersGroup->styleSheet());
    
    QVBoxLayout *barChartLayout = new QVBoxLayout(barChartGroup);
    m_barChartView = new QChartView();
    m_barChartView->setStyleSheet(m_lineChartView->styleSheet());
    barChartLayout->addWidget(m_barChartView);
    
    chartsLayout->addWidget(lineChartGroup);
    chartsLayout->addWidget(barChartGroup);
    
    mainLayout->addLayout(chartsLayout);
    
    // Tables
    QHBoxLayout *tablesLayout = new QHBoxLayout();
    
    QGroupBox *recentActivityGroup = new QGroupBox("Recent Activity");
    recentActivityGroup->setStyleSheet(totalUsersGroup->styleSheet());
    
    QVBoxLayout *recentActivityLayout = new QVBoxLayout(recentActivityGroup);
    m_recentActivityTable = new QTableWidget();
    m_recentActivityTable->setStyleSheet(
        "QTableWidget {"
        "    background-color: #1e1e1e;"
        "    color: white;"
        "    border: 1px solid #3a3a3a;"
        "    border-radius: 6px;"
        "    gridline-color: #3a3a3a;"
        "    font-size: 14px;"
        "}"
        "QTableWidget::item {"
        "    padding: 8px;"
        "    border: none;"
        "}"
        "QTableWidget::item:selected {"
        "    background-color: #404040;"
        "    color: #61dafb;"
        "}"
        "QHeaderView::section {"
        "    background-color: #2b2b2b;"
        "    color: white;"
        "    padding: 10px;"
        "    border: 1px solid #3a3a3a;"
        "    font-weight: bold;"
        "}"
    );
    recentActivityLayout->addWidget(m_recentActivityTable);
    
    QGroupBox *topProductsGroup = new QGroupBox("Top Products");
    topProductsGroup->setStyleSheet(totalUsersGroup->styleSheet());
    
    QVBoxLayout *topProductsLayout = new QVBoxLayout(topProductsGroup);
    m_topProductsTable = new QTableWidget();
    m_topProductsTable->setStyleSheet(m_recentActivityTable->styleSheet());
    topProductsLayout->addWidget(m_topProductsTable);
    
    tablesLayout->addWidget(recentActivityGroup);
    tablesLayout->addWidget(topProductsGroup);
    
    mainLayout->addLayout(tablesLayout);
    
    // Connect signals
    connect(m_refreshButton, &QPushButton::clicked, this, &DashboardWidget::refreshDashboard);
    connect(m_exportButton, &QPushButton::clicked, this, &DashboardWidget::exportData);
    connect(m_fullscreenButton, &QPushButton::clicked, this, &DashboardWidget::toggleFullscreen);
    connect(m_timeRangeCombo, QOverload<int>::of(&QComboBox::currentIndexChanged), this, &DashboardWidget::changeTimeRange);
}

void DashboardWidget::setupCharts()
{
    // Line chart for user activity
    QLineSeries *lineSeries = new QLineSeries();
    lineSeries->setName("User Activity");
    
    for (int i = 0; i < 30; ++i) {
        lineSeries->append(i, rand() % 100 + 50);
    }
    
    QChart *lineChart = new QChart();
    lineChart->addSeries(lineSeries);
    lineChart->setTitle("User Activity Over Time");
    lineChart->createDefaultAxes();
    lineChart->setTheme(QChart::ChartThemeDark);
    
    m_lineChartView->setChart(lineChart);
    
    // Bar chart for revenue
    QBarSeries *barSeries = new QBarSeries();
    QStringList months = {"Jan", "Feb", "Mar", "Apr", "May", "Jun"};
    
    for (const QString &month : months) {
        QBarSet *barSet = new QBarSet(month);
        *barSet << (rand() % 10000 + 5000);
        barSeries->append(barSet);
    }
    
    QChart *barChart = new QChart();
    barChart->addSeries(barSeries);
    barChart->setTitle("Revenue by Month");
    barChart->createDefaultAxes();
    barChart->setTheme(QChart::ChartThemeDark);
    
    m_barChartView->setChart(barChart);
}

void DashboardWidget::setupMetrics()
{
    // Metrics are already set up in setupUI()
    updateMetrics();
}

void DashboardWidget::setupTables()
{
    // Recent Activity Table
    m_recentActivityTable->setColumnCount(4);
    m_recentActivityTable->setHorizontalHeaderLabels({"Time", "User", "Action", "Details"});
    
    for (int i = 0; i < 10; ++i) {
        int row = m_recentActivityTable->rowCount();
        m_recentActivityTable->insertRow(row);
        
        m_recentActivityTable->setItem(row, 0, new QTableWidgetItem(QTime::currentTime().addSecs(-i * 300).toString("hh:mm:ss")));
        m_recentActivityTable->setItem(row, 1, new QTableWidgetItem(QString("User %1").arg(i + 1)));
        m_recentActivityTable->setItem(row, 2, new QTableWidgetItem(QStringList({"Login", "Logout", "Purchase", "View", "Search"})[i % 5]));
        m_recentActivityTable->setItem(row, 3, new QTableWidgetItem(QString("Details for action %1").arg(i + 1)));
    }
    
    // Top Products Table
    m_topProductsTable->setColumnCount(3);
    m_topProductsTable->setHorizontalHeaderLabels({"Product", "Sales", "Revenue"});
    
    for (int i = 0; i < 5; ++i) {
        int row = m_topProductsTable->rowCount();
        m_topProductsTable->insertRow(row);
        
        m_topProductsTable->setItem(row, 0, new QTableWidgetItem(QString("Product %1").arg(i + 1)));
        m_topProductsTable->setItem(row, 1, new QTableWidgetItem(QString::number(rand() % 100 + 50)));
        m_topProductsTable->setItem(row, 2, new QTableWidgetItem(QString("$%1").arg(rand() % 10000 + 1000)));
    }
}

void DashboardWidget::setupControls()
{
    // Controls are already set up in setupUI()
}

void DashboardWidget::updateData()
{
    updateMetrics();
    updateCharts();
    updateTables();
}

void DashboardWidget::refreshDashboard()
{
    updateData();
    QMessageBox::information(this, "Dashboard", "Dashboard refreshed successfully!");
}

void DashboardWidget::exportData()
{
    QString fileName = QFileDialog::getSaveFileName(this, "Export Dashboard Data", 
                                                   "dashboard_data.csv", "CSV Files (*.csv)");
    if (!fileName.isEmpty()) {
        QFile file(fileName);
        if (file.open(QIODevice::WriteOnly | QIODevice::Text)) {
            QTextStream out(&file);
            
            // Export metrics
            out << "Metric,Value\n";
            out << "Total Users," << m_totalUsersLabel->text() << "\n";
            out << "Active Users," << m_activeUsersLabel->text() << "\n";
            out << "Revenue," << m_revenueLabel->text() << "\n";
            out << "Conversion Rate," << m_conversionLabel->text() << "\n";
            
            QMessageBox::information(this, "Export Complete", 
                                   "Dashboard data exported successfully to " + fileName);
        }
    }
}

void DashboardWidget::changeTimeRange()
{
    QString range = m_timeRangeCombo->currentText();
    QDate startDate, endDate;
    
    if (range == "Last 24 Hours") {
        startDate = QDate::currentDate();
        endDate = QDate::currentDate();
    } else if (range == "Last 7 Days") {
        startDate = QDate::currentDate().addDays(-7);
        endDate = QDate::currentDate();
    } else if (range == "Last 30 Days") {
        startDate = QDate::currentDate().addDays(-30);
        endDate = QDate::currentDate();
    } else if (range == "Last 3 Months") {
        startDate = QDate::currentDate().addMonths(-3);
        endDate = QDate::currentDate();
    } else if (range == "Last Year") {
        startDate = QDate::currentDate().addYears(-1);
        endDate = QDate::currentDate();
    }
    
    m_startDateEdit->setDate(startDate);
    m_endDateEdit->setDate(endDate);
    
    updateData();
}

void DashboardWidget::toggleFullscreen()
{
    if (isFullScreen()) {
        showNormal();
    } else {
        showFullScreen();
    }
}

void DashboardWidget::showDetails()
{
    QMessageBox::information(this, "Details", "Dashboard details would be shown here.");
}

void DashboardWidget::updateCharts()
{
    // Update charts with new data
    setupCharts();
}

void DashboardWidget::updateMetrics()
{
    // Update metrics with random data
    m_totalUsersLabel->setText(QString::number(rand() % 1000 + 1000));
    m_activeUsersLabel->setText(QString::number(rand() % 500 + 500));
    m_revenueLabel->setText(QString("$%1").arg(rand() % 10000 + 10000));
    m_conversionLabel->setText(QString("%1%").arg((rand() % 5 + 1) + (rand() % 10) / 10.0, 0, 'f', 1));
}

void DashboardWidget::updateTables()
{
    // Update tables with new data
    setupTables();
}

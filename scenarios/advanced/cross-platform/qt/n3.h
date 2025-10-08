#ifndef DASHBOARDWIDGET_H
#define DASHBOARDWIDGET_H

#include <QWidget>
#include <QLabel>
#include <QPushButton>
#include <QProgressBar>
#include <QTableWidget>
#include <QChart>
#include <QChartView>
#include <QLineSeries>
#include <QBarSeries>
#include <QBarSet>
#include <QValueAxis>
#include <QDateTimeAxis>
#include <QVBoxLayout>
#include <QHBoxLayout>
#include <QGridLayout>
#include <QGroupBox>
#include <QComboBox>
#include <QDateEdit>
#include <QSpinBox>
#include <QTimer>

QT_CHARTS_USE_NAMESPACE

class DashboardWidget : public QWidget
{
    Q_OBJECT

public:
    explicit DashboardWidget(QWidget *parent = nullptr);

private slots:
    void updateData();
    void refreshDashboard();
    void exportData();
    void changeTimeRange();
    void toggleFullscreen();
    void showDetails();

private:
    void setupUI();
    void setupCharts();
    void setupMetrics();
    void setupTables();
    void setupControls();
    void updateCharts();
    void updateMetrics();
    void updateTables();
    
    // Charts
    QChartView *m_lineChartView;
    QChartView *m_barChartView;
    QChartView *m_pieChartView;
    
    // Metrics
    QLabel *m_totalUsersLabel;
    QLabel *m_activeUsersLabel;
    QLabel *m_revenueLabel;
    QLabel *m_conversionLabel;
    QProgressBar *m_goalProgressBar;
    
    // Tables
    QTableWidget *m_recentActivityTable;
    QTableWidget *m_topProductsTable;
    QTableWidget *m_alertsTable;
    
    // Controls
    QComboBox *m_timeRangeCombo;
    QDateEdit *m_startDateEdit;
    QDateEdit *m_endDateEdit;
    QPushButton *m_refreshButton;
    QPushButton *m_exportButton;
    QPushButton *m_fullscreenButton;
    
    // Data
    QTimer *m_updateTimer;
    QMap<QString, QVariant> m_dashboardData;
};

#endif // DASHBOARDWIDGET_H

#include <QApplication>
#include <QMainWindow>
#include <QVBoxLayout>
#include <QHBoxLayout>
#include <QLabel>
#include <QPushButton>
#include <QWidget>
#include <QTimer>
#include <QProgressBar>

class DataDashboard : public QMainWindow
{
    Q_OBJECT

public:
    DataDashboard(QWidget *parent = nullptr) : QMainWindow(parent)
    {
        setupUI();
        setupConnections();
    }

private slots:
    void refreshData()
    {
        startLoading();
    }
    
    void exportData()
    {
        startLoading();
    }
    
    void generateReport()
    {
        startLoading();
    }
    
    void updateLoading()
    {
        if (isLoading) {
            progress += 2;
            updateLoadingDisplay();
            
            if (progress >= 100) {
                completeLoading();
            }
        }
    }

private:
    void setupUI()
    {
        QWidget *centralWidget = new QWidget(this);
        setCentralWidget(centralWidget);
        
        QVBoxLayout *mainLayout = new QVBoxLayout(centralWidget);
        
        // Header
        QHBoxLayout *headerLayout = new QHBoxLayout();
        
        QLabel *titleLabel = new QLabel("Data Dashboard", this);
        titleLabel->setStyleSheet(
            "QLabel {"
            "    font-size: 28px;"
            "    font-weight: bold;"
            "    color: #333;"
            "    padding: 20px 0;"
            "}"
        );
        headerLayout->addWidget(titleLabel);
        
        headerLayout->addStretch();
        
        QPushButton *refreshBtn = new QPushButton("🔄 Refresh", this);
        refreshBtn->setStyleSheet(
            "QPushButton {"
            "    background: #007bff;"
            "    color: white;"
            "    border: none;"
            "    border-radius: 6px;"
            "    padding: 10px 20px;"
            "    font-size: 16px;"
            "    font-weight: bold;"
            "    margin-right: 10px;"
            "}"
            "QPushButton:hover {"
            "    background: #0056b3;"
            "}"
        );
        connect(refreshBtn, &QPushButton::clicked, this, &DataDashboard::refreshData);
        headerLayout->addWidget(refreshBtn);
        
        QPushButton *exportBtn = new QPushButton("📊 Export", this);
        exportBtn->setStyleSheet(
            "QPushButton {"
            "    background: #28a745;"
            "    color: white;"
            "    border: none;"
            "    border-radius: 6px;"
            "    padding: 10px 20px;"
            "    font-size: 16px;"
            "    font-weight: bold;"
            "    margin-right: 10px;"
            "}"
            "QPushButton:hover {"
            "    background: #218838;"
            "}"
        );
        connect(exportBtn, &QPushButton::clicked, this, &DataDashboard::exportData);
        headerLayout->addWidget(exportBtn);
        
        QPushButton *reportBtn = new QPushButton("📋 Report", this);
        reportBtn->setStyleSheet(
            "QPushButton {"
            "    background: #6c757d;"
            "    color: white;"
            "    border: none;"
            "    border-radius: 6px;"
            "    padding: 10px 20px;"
            "    font-size: 16px;"
            "    font-weight: bold;"
            "}"
            "QPushButton:hover {"
            "    background: #5a6268;"
            "}"
        );
        connect(reportBtn, &QPushButton::clicked, this, &DataDashboard::generateReport);
        headerLayout->addWidget(reportBtn);
        
        mainLayout->addLayout(headerLayout);
        
        // Page header
        QHBoxLayout *pageHeaderLayout = new QHBoxLayout();
        
        QLabel *pageTitle = new QLabel("Project Overview", this);
        pageTitle->setStyleSheet(
            "QLabel {"
            "    font-size: 24px;"
            "    font-weight: bold;"
            "    color: #333;"
            "    margin-bottom: 10px;"
            "}"
        );
        pageHeaderLayout->addWidget(pageTitle);
        
        pageHeaderLayout->addStretch();
        
        QLabel *pageSubtitle = new QLabel("Monitor and manage your projects", this);
        pageSubtitle->setStyleSheet(
            "QLabel {"
            "    font-size: 16px;"
            "    color: #666;"
            "    margin-bottom: 20px;"
            "}"
        );
        pageHeaderLayout->addWidget(pageSubtitle);
        
        mainLayout->addLayout(pageHeaderLayout);
        
        // SILENT LOADING STATE - Content spinner without screen reader announcement
        loadingOverlay = new QWidget(this);
        loadingOverlay->setStyleSheet(
            "QWidget {"
            "    background: rgba(248, 249, 250, 0.9);"
            "    border-radius: 12px;"
            "    padding: 40px;"
            "    margin: 20px 0;"
            "}"
        );
        loadingOverlay->setVisible(false);
        
        QVBoxLayout *loadingLayout = new QVBoxLayout(loadingOverlay);
        loadingLayout->setAlignment(Qt::AlignCenter);
        
        // SILENT LOADING STATE - Content spinner without screen reader announcement
        loadingSpinner = new QLabel("⏳", this);
        loadingSpinner->setStyleSheet(
            "QLabel {"
            "    font-size: 48px;"
            "    text-align: center;"
            "    margin-bottom: 20px;"
            "}"
        );
        loadingSpinner->setAlignment(Qt::AlignCenter);
        loadingLayout->addWidget(loadingSpinner);
        
        // SILENT LOADING STATE - Content spinner without screen reader announcement
        loadingText = new QLabel("Loading...", this);
        loadingText->setStyleSheet(
            "QLabel {"
            "    font-size: 18px;"
            "    font-weight: bold;"
            "    color: #333;"
            "    text-align: center;"
            "    margin-bottom: 20px;"
            "}"
        );
        loadingText->setAlignment(Qt::AlignCenter);
        loadingLayout->addWidget(loadingText);
        
        // SILENT LOADING STATE - Content spinner without screen reader announcement
        progressBar = new QProgressBar(this);
        progressBar->setRange(0, 100);
        progressBar->setValue(0);
        progressBar->setStyleSheet(
            "QProgressBar {"
            "    border: 1px solid #ddd;"
            "    border-radius: 4px;"
            "    text-align: center;"
            "    font-weight: bold;"
            "    margin-bottom: 10px;"
            "}"
            "QProgressBar::chunk {"
            "    background: #007bff;"
            "    border-radius: 4px;"
            "}"
        );
        loadingLayout->addWidget(progressBar);
        
        // SILENT LOADING STATE - Content spinner without screen reader announcement
        progressText = new QLabel("0%", this);
        progressText->setStyleSheet(
            "QLabel {"
            "    font-size: 14px;"
            "    color: #666;"
            "    font-weight: bold;"
            "    text-align: center;"
            "}"
        );
        progressText->setAlignment(Qt::AlignCenter);
        loadingLayout->addWidget(progressText);
        
        mainLayout->addWidget(loadingOverlay);
        
        // Stats grid
        QHBoxLayout *statsLayout = new QHBoxLayout();
        
        QFrame *stat1 = createStatCard("📊", "12", "Total Projects");
        statsLayout->addWidget(stat1);
        
        QFrame *stat2 = createStatCard("✅", "8", "Completed");
        statsLayout->addWidget(stat2);
        
        QFrame *stat3 = createStatCard("⏳", "3", "In Progress");
        statsLayout->addWidget(stat3);
        
        QFrame *stat4 = createStatCard("⏸️", "1", "On Hold");
        statsLayout->addWidget(stat4);
        
        mainLayout->addLayout(statsLayout);
        
        // Data section
        QFrame *dataFrame = new QFrame(this);
        dataFrame->setStyleSheet(
            "QFrame {"
            "    background: white;"
            "    border: 1px solid #ddd;"
            "    border-radius: 8px;"
            "    padding: 25px;"
            "    margin: 20px 0;"
            "}"
        );
        
        QVBoxLayout *dataLayout = new QVBoxLayout(dataFrame);
        
        QHBoxLayout *dataHeaderLayout = new QHBoxLayout();
        
        QLabel *dataTitle = new QLabel("Recent Projects", this);
        dataTitle->setStyleSheet(
            "QLabel {"
            "    font-size: 20px;"
            "    font-weight: bold;"
            "    color: #333;"
            "    margin-bottom: 20px;"
            "}"
        );
        dataHeaderLayout->addWidget(dataTitle);
        
        dataHeaderLayout->addStretch();
        
        QPushButton *filterBtn = new QPushButton("🔍 Filter", this);
        filterBtn->setStyleSheet(
            "QPushButton {"
            "    background: #f8f9fa;"
            "    color: #333;"
            "    border: 1px solid #ddd;"
            "    border-radius: 4px;"
            "    padding: 8px 16px;"
            "    font-size: 14px;"
            "    margin-right: 10px;"
            "}"
            "QPushButton:hover {"
            "    background: #e9ecef;"
            "}"
        );
        dataHeaderLayout->addWidget(filterBtn);
        
        QPushButton *sortBtn = new QPushButton("↕️ Sort", this);
        sortBtn->setStyleSheet(
            "QPushButton {"
            "    background: #f8f9fa;"
            "    color: #333;"
            "    border: 1px solid #ddd;"
            "    border-radius: 4px;"
            "    padding: 8px 16px;"
            "    font-size: 14px;"
            "}"
            "QPushButton:hover {"
            "    background: #e9ecef;"
            "}"
        );
        dataHeaderLayout->addWidget(sortBtn);
        
        dataLayout->addLayout(dataHeaderLayout);
        
        // Project list
        QLabel *projectList = new QLabel(
            "• Project Alpha - Active - 75% complete\n"
            "• Project Beta - Pending - 25% complete\n"
            "• Project Gamma - Completed - 100% complete\n"
            "• Project Delta - Active - 50% complete\n"
            "• Project Epsilon - On Hold - 10% complete",
            this
        );
        projectList->setStyleSheet(
            "QLabel {"
            "    font-size: 16px;"
            "    color: #333;"
            "    line-height: 1.6;"
            "    margin-top: 15px;"
            "}"
        );
        dataLayout->addWidget(projectList);
        
        mainLayout->addWidget(dataFrame);
        
        // Activity section
        QFrame *activityFrame = new QFrame(this);
        activityFrame->setStyleSheet(
            "QFrame {"
            "    background: white;"
            "    border: 1px solid #ddd;"
            "    border-radius: 8px;"
            "    padding: 25px;"
            "    margin: 20px 0;"
            "}"
        );
        
        QVBoxLayout *activityLayout = new QVBoxLayout(activityFrame);
        
        QLabel *activityTitle = new QLabel("Recent Activity", this);
        activityTitle->setStyleSheet(
            "QLabel {"
            "    font-size: 20px;"
            "    font-weight: bold;"
            "    color: #333;"
            "    margin-bottom: 15px;"
            "}"
        );
        activityLayout->addWidget(activityTitle);
        
        QLabel *activityList = new QLabel(
            "🔄 Data refreshed - 2 minutes ago\n"
            "📊 Report generated - 15 minutes ago\n"
            "📤 Data exported - 1 hour ago\n"
            "✅ Project completed - 2 hours ago",
            this
        );
        activityList->setStyleSheet(
            "QLabel {"
            "    font-size: 16px;"
            "    color: #333;"
            "    line-height: 1.6;"
            "}"
        );
        activityLayout->addWidget(activityList);
        
        mainLayout->addWidget(activityFrame);
        
        // Status bar
        QHBoxLayout *statusLayout = new QHBoxLayout();
        
        QLabel *statusLabel = new QLabel("Ready", this);
        statusLabel->setStyleSheet(
            "QLabel {"
            "    font-size: 14px;"
            "    color: #28a745;"
            "    font-weight: bold;"
            "    padding: 10px 0;"
            "}"
        );
        statusLayout->addWidget(statusLabel);
        
        statusLayout->addStretch();
        
        QLabel *lastUpdated = new QLabel("Last updated: " + QTime::currentTime().toString(), this);
        lastUpdated->setStyleSheet(
            "QLabel {"
            "    font-size: 14px;"
            "    color: #666;"
            "    padding: 10px 0;"
            "}"
        );
        statusLayout->addWidget(lastUpdated);
        
        mainLayout->addLayout(statusLayout);
    }
    
    QFrame* createStatCard(const QString &icon, const QString &value, const QString &label)
    {
        QFrame *card = new QFrame(this);
        card->setStyleSheet(
            "QFrame {"
            "    background: white;"
            "    border: 1px solid #ddd;"
            "    border-radius: 8px;"
            "    padding: 25px;"
            "    margin: 5px;"
            "}"
        );
        
        QVBoxLayout *cardLayout = new QVBoxLayout(card);
        cardLayout->setSpacing(15);
        
        QLabel *iconLabel = new QLabel(icon, this);
        iconLabel->setStyleSheet(
            "QLabel {"
            "    font-size: 36px;"
            "    text-align: center;"
            "    margin-bottom: 10px;"
            "}"
        );
        iconLabel->setAlignment(Qt::AlignCenter);
        cardLayout->addWidget(iconLabel);
        
        QLabel *valueLabel = new QLabel(value, this);
        valueLabel->setStyleSheet(
            "QLabel {"
            "    font-size: 28px;"
            "    font-weight: bold;"
            "    color: #333;"
            "    text-align: center;"
            "    margin-bottom: 5px;"
            "}"
        );
        valueLabel->setAlignment(Qt::AlignCenter);
        cardLayout->addWidget(valueLabel);
        
        QLabel *labelLabel = new QLabel(label, this);
        labelLabel->setStyleSheet(
            "QLabel {"
            "    font-size: 14px;"
            "    color: #666;"
            "    text-align: center;"
            "    text-transform: uppercase;"
            "}"
        );
        labelLabel->setAlignment(Qt::AlignCenter);
        cardLayout->addWidget(labelLabel);
        
        return card;
    }
    
    void setupConnections()
    {
        // Timer for loading animation
        loadingTimer = new QTimer(this);
        connect(loadingTimer, &QTimer::timeout, this, &DataDashboard::updateLoading);
    }
    
    void startLoading()
    {
        isLoading = true;
        progress = 0;
        loadingOverlay->setVisible(true);
        loadingText->setText("Loading data...");
        loadingTimer->start(100); // Update every 100ms
        updateLoadingDisplay();
    }
    
    void completeLoading()
    {
        isLoading = false;
        loadingTimer->stop();
        loadingOverlay->setVisible(false);
        progress = 0;
    }
    
    void updateLoadingDisplay()
    {
        if (isLoading) {
            progressBar->setValue(progress);
            progressText->setText(QString::number(progress) + "%");
            
            // Update loading message based on progress
            if (progress < 30) {
                loadingText->setText("Connecting to server...");
            } else if (progress < 60) {
                loadingText->setText("Fetching data...");
            } else if (progress < 90) {
                loadingText->setText("Processing results...");
            } else {
                loadingText->setText("Finalizing...");
            }
        }
    }

private:
    QWidget *loadingOverlay;
    QLabel *loadingSpinner;
    QLabel *loadingText;
    QProgressBar *progressBar;
    QLabel *progressText;
    QTimer *loadingTimer;
    bool isLoading = false;
    int progress = 0;
};

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);
    
    DataDashboard app;
    app.setWindowTitle("Data Dashboard - Silent Loading");
    app.resize(1000, 700);
    app.show();
    
    return app.exec();
}

#include "SilentLoadingState.moc"

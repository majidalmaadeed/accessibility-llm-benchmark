#include <QApplication>
#include <QMainWindow>
#include <QVBoxLayout>
#include <QHBoxLayout>
#include <QLabel>
#include <QPushButton>
#include <QWidget>
#include <QTimer>
#include <QMessageBox>

class SessionManager : public QMainWindow
{
    Q_OBJECT

public:
    SessionManager(QWidget *parent = nullptr) : QMainWindow(parent)
    {
        setupUI();
        setupConnections();
        startSessionTimer();
    }

private slots:
    void extendSession()
    {
        sessionTime = 30; // Reset to 30 minutes
        updateWarningDisplay();
        QMessageBox::information(this, "Session Extended", "Your session has been extended by 30 minutes.");
    }
    
    void logoutNow()
    {
        QMessageBox::information(this, "Logged Out", "You have been logged out due to inactivity.");
        close();
    }
    
    void updateSession()
    {
        sessionTime--;
        updateWarningDisplay();
        
        if (sessionTime <= 0) {
            logoutNow();
        }
    }

private:
    void setupUI()
    {
        QWidget *centralWidget = new QWidget(this);
        setCentralWidget(centralWidget);
        
        QVBoxLayout *mainLayout = new QVBoxLayout(centralWidget);
        mainLayout->setSpacing(30);
        
        // Header
        QHBoxLayout *headerLayout = new QHBoxLayout();
        
        QLabel *titleLabel = new QLabel("Secure Dashboard", this);
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
        
        QPushButton *logoutBtn = new QPushButton("Logout", this);
        logoutBtn->setStyleSheet(
            "QPushButton {"
            "    background: #dc3545;"
            "    color: white;"
            "    border: none;"
            "    border-radius: 6px;"
            "    padding: 10px 20px;"
            "    font-size: 16px;"
            "    font-weight: bold;"
            "}"
            "QPushButton:hover {"
            "    background: #c82333;"
            "}"
        );
        connect(logoutBtn, &QPushButton::clicked, this, &SessionManager::logoutNow);
        headerLayout->addWidget(logoutBtn);
        
        mainLayout->addLayout(headerLayout);
        
        // Main content
        QHBoxLayout *contentLayout = new QHBoxLayout();
        
        // Left sidebar
        QVBoxLayout *sidebarLayout = new QVBoxLayout();
        
        QPushButton *dashboardBtn = new QPushButton("📊 Dashboard", this);
        dashboardBtn->setStyleSheet(
            "QPushButton {"
            "    background: #007bff;"
            "    color: white;"
            "    border: none;"
            "    border-radius: 6px;"
            "    padding: 12px 20px;"
            "    font-size: 16px;"
            "    text-align: left;"
            "    margin-bottom: 10px;"
            "}"
            "QPushButton:hover {"
            "    background: #0056b3;"
            "}"
        );
        sidebarLayout->addWidget(dashboardBtn);
        
        QPushButton *reportsBtn = new QPushButton("📈 Reports", this);
        reportsBtn->setStyleSheet(
            "QPushButton {"
            "    background: #6c757d;"
            "    color: white;"
            "    border: none;"
            "    border-radius: 6px;"
            "    padding: 12px 20px;"
            "    font-size: 16px;"
            "    text-align: left;"
            "    margin-bottom: 10px;"
            "}"
            "QPushButton:hover {"
            "    background: #5a6268;"
            "}"
        );
        sidebarLayout->addWidget(reportsBtn);
        
        QPushButton *settingsBtn = new QPushButton("⚙️ Settings", this);
        settingsBtn->setStyleSheet(
            "QPushButton {"
            "    background: #6c757d;"
            "    color: white;"
            "    border: none;"
            "    border-radius: 6px;"
            "    padding: 12px 20px;"
            "    font-size: 16px;"
            "    text-align: left;"
            "    margin-bottom: 10px;"
            "}"
            "QPushButton:hover {"
            "    background: #5a6268;"
            "}"
        );
        sidebarLayout->addWidget(settingsBtn);
        
        sidebarLayout->addStretch();
        contentLayout->addLayout(sidebarLayout);
        
        // Main content area
        QVBoxLayout *mainContentLayout = new QVBoxLayout();
        
        QLabel *welcomeLabel = new QLabel("Welcome to your secure dashboard", this);
        welcomeLabel->setStyleSheet(
            "QLabel {"
            "    font-size: 24px;"
            "    font-weight: bold;"
            "    color: #333;"
            "    margin-bottom: 20px;"
            "}"
        );
        mainContentLayout->addWidget(welcomeLabel);
        
        // LOW CONTRAST WARNING TEXT - Session timeout warning with insufficient color contrast
        warningLabel = new QLabel("", this);
        warningLabel->setStyleSheet(
            "QLabel {"
            "    background: #f8f9fa;"
            "    color: #999999;"  // LOW CONTRAST - Insufficient color contrast
            "    border: 1px solid #dee2e6;"
            "    border-radius: 6px;"
            "    padding: 15px;"
            "    font-size: 16px;"
            "    font-weight: bold;"
            "    margin-bottom: 20px;"
            "}"
        );
        warningLabel->setWordWrap(true);
        mainContentLayout->addWidget(warningLabel);
        
        // Action buttons for session management
        QHBoxLayout *actionLayout = new QHBoxLayout();
        
        QPushButton *extendBtn = new QPushButton("Extend Session", this);
        extendBtn->setStyleSheet(
            "QPushButton {"
            "    background: #28a745;"
            "    color: white;"
            "    border: none;"
            "    border-radius: 6px;"
            "    padding: 12px 24px;"
            "    font-size: 16px;"
            "    font-weight: bold;"
            "    margin-right: 10px;"
            "}"
            "QPushButton:hover {"
            "    background: #218838;"
            "}"
        );
        connect(extendBtn, &QPushButton::clicked, this, &SessionManager::extendSession);
        actionLayout->addWidget(extendBtn);
        
        QPushButton *logoutNowBtn = new QPushButton("Logout Now", this);
        logoutNowBtn->setStyleSheet(
            "QPushButton {"
            "    background: #dc3545;"
            "    color: white;"
            "    border: none;"
            "    border-radius: 6px;"
            "    padding: 12px 24px;"
            "    font-size: 16px;"
            "    font-weight: bold;"
            "}"
            "QPushButton:hover {"
            "    background: #c82333;"
            "}"
        );
        connect(logoutNowBtn, &QPushButton::clicked, this, &SessionManager::logoutNow);
        actionLayout->addWidget(logoutNowBtn);
        
        mainContentLayout->addLayout(actionLayout);
        
        // Dashboard content
        QLabel *contentLabel = new QLabel(
            "This is your secure dashboard where you can manage your account, "
            "view reports, and configure settings. Your session will automatically "
            "expire after 30 minutes of inactivity for security purposes.",
            this
        );
        contentLabel->setStyleSheet(
            "QLabel {"
            "    font-size: 16px;"
            "    color: #666;"
            "    line-height: 1.6;"
            "    margin-top: 20px;"
            "}"
        );
        contentLabel->setWordWrap(true);
        mainContentLayout->addWidget(contentLabel);
        
        mainContentLayout->addStretch();
        contentLayout->addLayout(mainContentLayout);
        
        mainLayout->addLayout(contentLayout);
        
        // Status bar
        QHBoxLayout *statusLayout = new QHBoxLayout();
        
        QLabel *statusLabel = new QLabel("Session Active", this);
        statusLabel->setStyleSheet(
            "QLabel {"
            "    font-size: 14px;"
            "    color: #28a745;"
            "    font-weight: bold;"
            "}"
        );
        statusLayout->addWidget(statusLabel);
        
        statusLayout->addStretch();
        
        QLabel *timeLabel = new QLabel("Last activity: Just now", this);
        timeLabel->setStyleSheet(
            "QLabel {"
            "    font-size: 14px;"
            "    color: #666;"
            "}"
        );
        statusLayout->addWidget(timeLabel);
        
        mainLayout->addLayout(statusLayout);
    }
    
    void setupConnections()
    {
        // Timer for session countdown
        sessionTimer = new QTimer(this);
        connect(sessionTimer, &QTimer::timeout, this, &SessionManager::updateSession);
    }
    
    void startSessionTimer()
    {
        sessionTime = 30; // 30 minutes
        sessionTimer->start(60000); // Update every minute
        updateWarningDisplay();
    }
    
    void updateWarningDisplay()
    {
        if (sessionTime <= 5) {
            warningLabel->setText(
                QString("⚠️ WARNING: Your session will expire in %1 minutes due to inactivity. "
                       "Please save your work and extend your session to continue.")
                    .arg(sessionTime)
            );
            warningLabel->setStyleSheet(
                "QLabel {"
                "    background: #fff3cd;"
                "    color: #999999;"  // LOW CONTRAST - Insufficient color contrast
                "    border: 1px solid #ffeaa7;"
                "    border-radius: 6px;"
                "    padding: 15px;"
                "    font-size: 16px;"
                "    font-weight: bold;"
                "    margin-bottom: 20px;"
                "}"
            );
        } else if (sessionTime <= 10) {
            warningLabel->setText(
                QString("ℹ️ Your session will expire in %1 minutes. Consider extending your session if you need more time.")
                    .arg(sessionTime)
            );
            warningLabel->setStyleSheet(
                "QLabel {"
                "    background: #d1ecf1;"
                "    color: #999999;"  // LOW CONTRAST - Insufficient color contrast
                "    border: 1px solid #bee5eb;"
                "    border-radius: 6px;"
                "    padding: 15px;"
                "    font-size: 16px;"
                "    font-weight: bold;"
                "    margin-bottom: 20px;"
                "}"
            );
        } else {
            warningLabel->setText("");
        }
    }

private:
    QLabel *warningLabel;
    QTimer *sessionTimer;
    int sessionTime;
};

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);
    
    SessionManager manager;
    manager.setWindowTitle("Secure Dashboard - Session Manager");
    manager.resize(1000, 700);
    manager.show();
    
    return app.exec();
}

#include "LowContrastWarningText.moc"

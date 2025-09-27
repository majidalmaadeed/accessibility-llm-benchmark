#include "mainwindow.h"
#include "datatablewidget.h"
#include "wizardwidget.h"
#include "dashboardwidget.h"
#include "mediaplayerwidget.h"
#include "shoppingcartwidget.h"
#include "calendarwidget.h"
#include "richtextwidget.h"
#include "searchwidget.h"
#include "mapwidget.h"
#include "socialfeedwidget.h"

#include <QApplication>
#include <QMenuBar>
#include <QStatusBar>
#include <QMessageBox>
#include <QAction>
#include <QListWidgetItem>
#include <QIcon>

MainWindow::MainWindow(QWidget *parent)
    : QMainWindow(parent)
    , m_centralWidget(nullptr)
    , m_mainLayout(nullptr)
    , m_scenarioList(nullptr)
    , m_stackedWidget(nullptr)
    , m_dataTableWidget(nullptr)
    , m_wizardWidget(nullptr)
    , m_dashboardWidget(nullptr)
    , m_mediaPlayerWidget(nullptr)
    , m_shoppingCartWidget(nullptr)
    , m_calendarWidget(nullptr)
    , m_richTextWidget(nullptr)
    , m_searchWidget(nullptr)
    , m_mapWidget(nullptr)
    , m_socialFeedWidget(nullptr)
{
    setupUI();
    setupMenuBar();
    setupStatusBar();
    
    setWindowTitle("Accessibility Benchmark - Qt");
    setMinimumSize(1200, 800);
    resize(1400, 900);
}

MainWindow::~MainWindow()
{
}

void MainWindow::setupUI()
{
    m_centralWidget = new QWidget(this);
    setCentralWidget(m_centralWidget);
    
    m_mainLayout = new QHBoxLayout(m_centralWidget);
    m_mainLayout->setContentsMargins(0, 0, 0, 0);
    m_mainLayout->setSpacing(0);
    
    // Create scenario list
    m_scenarioList = new QListWidget(this);
    m_scenarioList->setMaximumWidth(250);
    m_scenarioList->setStyleSheet(
        "QListWidget {"
        "    background-color: #2b2b2b;"
        "    border: none;"
        "    color: white;"
        "    font-size: 14px;"
        "}"
        "QListWidget::item {"
        "    padding: 12px 16px;"
        "    border-bottom: 1px solid #3a3a3a;"
        "}"
        "QListWidget::item:selected {"
        "    background-color: #404040;"
        "    color: #61dafb;"
        "}"
        "QListWidget::item:hover {"
        "    background-color: #353535;"
        "}"
    );
    
    // Add scenario items
    QStringList scenarios = {
        "Data Table Complex",
        "Multi-Step Wizard",
        "Dashboard Widget",
        "Media Player Full Interface",
        "Shopping Cart System",
        "Calendar Application",
        "Rich Text Editor",
        "Complex Search Interface",
        "Interactive Map",
        "Social Media Feed"
    };
    
    for (const QString &scenario : scenarios) {
        QListWidgetItem *item = new QListWidgetItem(scenario);
        m_scenarioList->addItem(item);
    }
    
    // Create stacked widget
    m_stackedWidget = new QStackedWidget(this);
    m_stackedWidget->setStyleSheet(
        "QStackedWidget {"
        "    background-color: #1e1e1e;"
        "    border: none;"
        "}"
    );
    
    // Create scenario widgets
    m_dataTableWidget = new DataTableWidget(this);
    m_wizardWidget = new WizardWidget(this);
    m_dashboardWidget = new DashboardWidget(this);
    m_mediaPlayerWidget = new MediaPlayerWidget(this);
    m_shoppingCartWidget = new ShoppingCartWidget(this);
    m_calendarWidget = new CalendarWidget(this);
    m_richTextWidget = new RichTextWidget(this);
    m_searchWidget = new SearchWidget(this);
    m_mapWidget = new MapWidget(this);
    m_socialFeedWidget = new SocialFeedWidget(this);
    
    // Add widgets to stacked widget
    m_stackedWidget->addWidget(m_dataTableWidget);
    m_stackedWidget->addWidget(m_wizardWidget);
    m_stackedWidget->addWidget(m_dashboardWidget);
    m_stackedWidget->addWidget(m_mediaPlayerWidget);
    m_stackedWidget->addWidget(m_shoppingCartWidget);
    m_stackedWidget->addWidget(m_calendarWidget);
    m_stackedWidget->addWidget(m_richTextWidget);
    m_stackedWidget->addWidget(m_searchWidget);
    m_stackedWidget->addWidget(m_mapWidget);
    m_stackedWidget->addWidget(m_socialFeedWidget);
    
    // Connect signals
    connect(m_scenarioList, &QListWidget::currentRowChanged,
            this, &MainWindow::switchToScenario);
    
    // Add widgets to layout
    m_mainLayout->addWidget(m_scenarioList);
    m_mainLayout->addWidget(m_stackedWidget, 1);
    
    // Set initial selection
    m_scenarioList->setCurrentRow(0);
}

void MainWindow::setupMenuBar()
{
    QMenuBar *menuBar = this->menuBar();
    menuBar->setStyleSheet(
        "QMenuBar {"
        "    background-color: #2b2b2b;"
        "    color: white;"
        "    border-bottom: 1px solid #3a3a3a;"
        "    padding: 4px;"
        "}"
        "QMenuBar::item {"
        "    padding: 8px 16px;"
        "    background-color: transparent;"
        "}"
        "QMenuBar::item:selected {"
        "    background-color: #404040;"
        "}"
        "QMenu {"
        "    background-color: #2b2b2b;"
        "    color: white;"
        "    border: 1px solid #3a3a3a;"
        "    padding: 4px;"
        "}"
        "QMenu::item {"
        "    padding: 8px 16px;"
        "    background-color: transparent;"
        "}"
        "QMenu::item:selected {"
        "    background-color: #404040;"
        "}"
    );
    
    // File menu
    QMenu *fileMenu = menuBar->addMenu("&File");
    
    m_newAction = fileMenu->addAction("&New");
    m_newAction->setShortcut(QKeySequence::New);
    m_newAction->setStatusTip("Create a new file");
    
    m_openAction = fileMenu->addAction("&Open");
    m_openAction->setShortcut(QKeySequence::Open);
    m_openAction->setStatusTip("Open an existing file");
    
    m_saveAction = fileMenu->addAction("&Save");
    m_saveAction->setShortcut(QKeySequence::Save);
    m_saveAction->setStatusTip("Save the current file");
    
    fileMenu->addSeparator();
    
    m_exitAction = fileMenu->addAction("E&xit");
    m_exitAction->setShortcut(QKeySequence::Quit);
    m_exitAction->setStatusTip("Exit the application");
    connect(m_exitAction, &QAction::triggered, this, &QWidget::close);
    
    // Help menu
    QMenu *helpMenu = menuBar->addMenu("&Help");
    
    m_aboutAction = helpMenu->addAction("&About");
    m_aboutAction->setStatusTip("Show the application's About box");
    connect(m_aboutAction, &QAction::triggered, [this]() {
        QMessageBox::about(this, "About Accessibility Benchmark",
            "Accessibility Benchmark Application\n"
            "Version 1.0.0\n\n"
            "This application demonstrates various accessibility scenarios "
            "for testing and benchmarking purposes.");
    });
}

void MainWindow::setupStatusBar()
{
    statusBar()->setStyleSheet(
        "QStatusBar {"
        "    background-color: #2b2b2b;"
        "    color: white;"
        "    border-top: 1px solid #3a3a3a;"
        "    padding: 4px;"
        "}"
    );
    
    statusBar()->showMessage("Ready");
}

void MainWindow::switchToScenario(int index)
{
    if (index >= 0 && index < m_stackedWidget->count()) {
        m_stackedWidget->setCurrentIndex(index);
        
        QString scenarioName = m_scenarioList->item(index)->text();
        statusBar()->showMessage(QString("Switched to: %1").arg(scenarioName));
    }
}

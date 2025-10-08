#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>
#include <QStackedWidget>
#include <QListWidget>
#include <QVBoxLayout>
#include <QHBoxLayout>
#include <QLabel>
#include <QPushButton>
#include <QFrame>

class DataTableWidget;
class WizardWidget;
class DashboardWidget;
class MediaPlayerWidget;
class ShoppingCartWidget;
class CalendarWidget;
class RichTextWidget;
class SearchWidget;
class MapWidget;
class SocialFeedWidget;

class MainWindow : public QMainWindow
{
    Q_OBJECT

public:
    MainWindow(QWidget *parent = nullptr);
    ~MainWindow();

private slots:
    void switchToScenario(int index);

private:
    void setupUI();
    void setupMenuBar();
    void setupStatusBar();
    
    QWidget *m_centralWidget;
    QHBoxLayout *m_mainLayout;
    QListWidget *m_scenarioList;
    QStackedWidget *m_stackedWidget;
    
    // Scenario widgets
    DataTableWidget *m_dataTableWidget;
    WizardWidget *m_wizardWidget;
    DashboardWidget *m_dashboardWidget;
    MediaPlayerWidget *m_mediaPlayerWidget;
    ShoppingCartWidget *m_shoppingCartWidget;
    CalendarWidget *m_calendarWidget;
    RichTextWidget *m_richTextWidget;
    SearchWidget *m_searchWidget;
    MapWidget *m_mapWidget;
    SocialFeedWidget *m_socialFeedWidget;
    
    // Menu actions
    QAction *m_newAction;
    QAction *m_openAction;
    QAction *m_saveAction;
    QAction *m_exitAction;
    QAction *m_aboutAction;
};

#endif // MAINWINDOW_H

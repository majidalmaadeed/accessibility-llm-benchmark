#ifndef CALENDARWIDGET_H
#define CALENDARWIDGET_H

#include <QWidget>
#include <QCalendarWidget>
#include <QTableWidget>
#include <QPushButton>
#include <QLabel>
#include <QLineEdit>
#include <QTextEdit>
#include <QComboBox>
#include <QSpinBox>
#include <QGroupBox>
#include <QVBoxLayout>
#include <QHBoxLayout>
#include <QGridLayout>
#include <QCheckBox>
#include <QTimeEdit>
#include <QDateEdit>
#include <QListWidget>
#include <QTabWidget>
#include <QDialog>
#include <QColorDialog>
#include <QFontDialog>

class CalendarWidget : public QWidget
{
    Q_OBJECT

public:
    explicit CalendarWidget(QWidget *parent = nullptr);

private slots:
    void createEvent();
    void editEvent();
    void deleteEvent();
    void viewEvent();
    void changeView();
    void changeDate();
    void searchEvents();
    void filterEvents();
    void exportCalendar();
    void importCalendar();
    void printCalendar();
    void shareCalendar();
    void setReminder();
    void markComplete();
    void duplicateEvent();
    void moveEvent();
    void resizeEvent();
    void changeColor();
    void changeFont();
    void setDefaultView();
    void showSettings();
    void showHelp();
    void onDateSelected();
    void onEventDoubleClicked();
    void onEventChanged();
    void onViewChanged();
    void onFilterChanged();
    void onSearchChanged();
    void onReminderTriggered();
    void onEventMoved();
    void onEventResized();
    void onColorChanged();
    void onFontChanged();
    void onSettingsChanged();
    void onHelpRequested();

private:
    void setupUI();
    void setupCalendar();
    void setupEventList();
    void setupControls();
    void setupDialogs();
    void setupMenus();
    void updateEventList();
    void updateCalendar();
    void updateControls();
    void updateDialogs();
    void updateMenus();
    void loadEvents();
    void saveEvents();
    void exportToICS();
    void importFromICS();
    void printToPDF();
    void shareViaEmail();
    void setEventReminder();
    void markEventComplete();
    void duplicateSelectedEvent();
    void moveSelectedEvent();
    void resizeSelectedEvent();
    void changeEventColor();
    void changeEventFont();
    void setCalendarView();
    void showEventSettings();
    void showCalendarHelp();
    void onCalendarDateSelected();
    void onEventListDoubleClicked();
    void onEventListChanged();
    void onCalendarViewChanged();
    void onEventFilterChanged();
    void onEventSearchChanged();
    void onEventReminderTriggered();
    void onEventMoved();
    void onEventResized();
    void onEventColorChanged();
    void onEventFontChanged();
    void onCalendarSettingsChanged();
    void onCalendarHelpRequested();
    
    // Calendar
    QCalendarWidget *m_calendarWidget;
    QTableWidget *m_eventTable;
    QListWidget *m_eventList;
    QTabWidget *m_viewTabs;
    
    // Controls
    QPushButton *m_createButton;
    QPushButton *m_editButton;
    QPushButton *m_deleteButton;
    QPushButton *m_viewButton;
    QPushButton *m_exportButton;
    QPushButton *m_importButton;
    QPushButton *m_printButton;
    QPushButton *m_shareButton;
    QPushButton *m_settingsButton;
    QPushButton *m_helpButton;
    
    // Search and Filter
    QLineEdit *m_searchEdit;
    QComboBox *m_categoryCombo;
    QComboBox *m_priorityCombo;
    QComboBox *m_statusCombo;
    QDateEdit *m_startDateEdit;
    QDateEdit *m_endDateEdit;
    QPushButton *m_searchButton;
    QPushButton *m_filterButton;
    QPushButton *m_clearButton;
    
    // Event Details
    QGroupBox *m_eventDetailsGroup;
    QLineEdit *m_titleEdit;
    QTextEdit *m_descriptionEdit;
    QDateEdit *m_eventDateEdit;
    QTimeEdit *m_startTimeEdit;
    QTimeEdit *m_endTimeEdit;
    QComboBox *m_categoryEdit;
    QComboBox *m_priorityEdit;
    QComboBox *m_statusEdit;
    QCheckBox *m_allDayCheck;
    QCheckBox *m_reminderCheck;
    QSpinBox *m_reminderSpin;
    QComboBox *m_reminderUnitCombo;
    QPushButton *m_colorButton;
    QPushButton *m_fontButton;
    
    // Dialogs
    QDialog *m_eventDialog;
    QDialog *m_settingsDialog;
    QDialog *m_helpDialog;
    QColorDialog *m_colorDialog;
    QFontDialog *m_fontDialog;
    
    // Menus
    QMenuBar *m_menuBar;
    QMenu *m_fileMenu;
    QMenu *m_editMenu;
    QMenu *m_viewMenu;
    QMenu *m_toolsMenu;
    QMenu *m_helpMenu;
    
    // Data
    QList<QVariantMap> m_events;
    QList<QVariantMap> m_categories;
    QList<QVariantMap> m_priorities;
    QList<QVariantMap> m_statuses;
    QMap<QString, QColor> m_categoryColors;
    QMap<QString, QFont> m_eventFonts;
    QDate m_selectedDate;
    QVariantMap m_selectedEvent;
    bool m_isEditing;
    bool m_isCreating;
    bool m_isViewing;
    bool m_isFiltering;
    bool m_isSearching;
    bool m_isExporting;
    bool m_isImporting;
    bool m_isPrinting;
    bool m_isSharing;
    bool m_isSettingReminder;
    bool m_isMarkingComplete;
    bool m_isDuplicating;
    bool m_isMoving;
    bool m_isResizing;
    bool m_isChangingColor;
    bool m_isChangingFont;
    bool m_isSettingView;
    bool m_isShowingSettings;
    bool m_isShowingHelp;
};

#endif // CALENDARWIDGET_H

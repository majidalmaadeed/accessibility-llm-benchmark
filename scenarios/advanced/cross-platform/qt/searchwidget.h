#ifndef SEARCHWIDGET_H
#define SEARCHWIDGET_H

#include <QWidget>
#include <QLineEdit>
#include <QPushButton>
#include <QComboBox>
#include <QCheckBox>
#include <QTableWidget>
#include <QListWidget>
#include <QGroupBox>
#include <QVBoxLayout>
#include <QHBoxLayout>
#include <QLabel>
#include <QSpinBox>
#include <QDateEdit>
#include <QSlider>
#include <QProgressBar>

class SearchWidget : public QWidget
{
    Q_OBJECT

public:
    explicit SearchWidget(QWidget *parent = nullptr);

private slots:
    void performSearch();
    void clearSearch();
    void saveSearch();
    void loadSearch();
    void exportResults();
    void filterResults();
    void sortResults();
    void selectAll();
    void deselectAll();
    void showDetails();
    void addToFavorites();
    void removeFromFavorites();
    void shareResults();
    void printResults();
    void updateSearch();
    void onSearchChanged();
    void onFilterChanged();
    void onSortChanged();
    void onSelectionChanged();
    void onResultsChanged();

private:
    void setupUI();
    void setupSearch();
    void setupFilters();
    void setupResults();
    void updateSearch();
    void updateFilters();
    void updateResults();
    void performSearch();
    void clearSearch();
    void saveSearch();
    void loadSearch();
    void exportResults();
    void filterResults();
    void sortResults();
    void selectAll();
    void deselectAll();
    void showDetails();
    void addToFavorites();
    void removeFromFavorites();
    void shareResults();
    void printResults();
    void onSearchChanged();
    void onFilterChanged();
    void onSortChanged();
    void onSelectionChanged();
    void onResultsChanged();
    
    // Search
    QLineEdit *m_searchEdit;
    QPushButton *m_searchButton;
    QPushButton *m_clearButton;
    QPushButton *m_saveButton;
    QPushButton *m_loadButton;
    QPushButton *m_exportButton;
    QPushButton *m_shareButton;
    QPushButton *m_printButton;
    
    // Filters
    QComboBox *m_categoryCombo;
    QComboBox *m_typeCombo;
    QComboBox *m_statusCombo;
    QDateEdit *m_startDateEdit;
    QDateEdit *m_endDateEdit;
    QSpinBox *m_minValueSpin;
    QSpinBox *m_maxValueSpin;
    QSlider *m_ratingSlider;
    QCheckBox *m_availableCheck;
    QCheckBox *m_featuredCheck;
    QPushButton *m_filterButton;
    QPushButton *m_resetButton;
    
    // Results
    QTableWidget *m_resultsTable;
    QListWidget *m_favoritesList;
    QProgressBar *m_progressBar;
    QLabel *m_statusLabel;
    QLabel *m_countLabel;
    
    // Data
    QList<QVariantMap> m_searchResults;
    QList<QVariantMap> m_favorites;
    QString m_currentQuery;
    QMap<QString, QVariant> m_currentFilters;
    bool m_isSearching;
    bool m_isFiltering;
    bool m_isSorting;
    bool m_isExporting;
    bool m_isSharing;
    bool m_isPrinting;
};

#endif // SEARCHWIDGET_H

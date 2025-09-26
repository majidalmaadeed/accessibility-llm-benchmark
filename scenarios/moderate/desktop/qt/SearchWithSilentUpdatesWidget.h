#ifndef SEARCHWITHSILENTUPDATESWIDGET_H
#define SEARCHWITHSILENTUPDATESWIDGET_H

#include <QWidget>
#include <QLineEdit>
#include <QPushButton>
#include <QListWidget>
#include <QProgressBar>
#include <QLabel>
#include <QList>

class SearchResult
{
public:
    SearchResult(int id = 0, const QString &title = QString(), 
                 const QString &category = QString(), const QString &author = QString());
    
    int id() const { return m_id; }
    QString title() const { return m_title; }
    QString category() const { return m_category; }
    QString author() const { return m_author; }

private:
    int m_id;
    QString m_title;
    QString m_category;
    QString m_author;
};

class SearchWithSilentUpdatesWidget : public QWidget
{
    Q_OBJECT

public:
    explicit SearchWithSilentUpdatesWidget(QWidget *parent = nullptr);

private slots:
    void onSearchTextChanged(const QString &text);
    void onSuggestionSelected(QListWidgetItem *item);
    void performSearch();

private:
    void initializeMockData();
    void setupUI();
    void setupAccessibility();
    void updateSuggestions();
    void hideSuggestions();

    // UI Elements
    QLineEdit *m_searchEdit;
    QPushButton *m_searchButton;
    QListWidget *m_suggestionsList;
    QProgressBar *m_loadingBar;
    QLabel *m_loadingLabel;
    QLabel *m_resultsCountLabel;
    QListWidget *m_resultsList;
    QLabel *m_noResultsLabel;
    QLabel *m_emptyStateLabel;

    // Data
    QList<SearchResult> m_mockData;
    QList<SearchResult> m_suggestions;
    QList<SearchResult> m_results;
    bool m_isLoading;
    bool m_showSuggestions;
    int m_activeSuggestionIndex;
};

#endif // SEARCHWITHSILENTUPDATESWIDGET_H
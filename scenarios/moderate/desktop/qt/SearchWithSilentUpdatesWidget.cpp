#include "SearchWithSilentUpdatesWidget.h"
#include <QVBoxLayout>
#include <QHBoxLayout>
#include <QLabel>
#include <QLineEdit>
#include <QPushButton>
#include <QListWidget>
#include <QProgressBar>
#include <QFrame>
#include <QScrollArea>
#include <QTimer>
#include <QApplication>

SearchWithSilentUpdatesWidget::SearchWithSilentUpdatesWidget(QWidget *parent)
    : QWidget(parent)
    , m_isLoading(false)
    , m_showSuggestions(false)
    , m_activeSuggestionIndex(-1)
{
    initializeMockData();
    setupUI();
}

void SearchWithSilentUpdatesWidget::initializeMockData()
{
    m_mockData = {
        SearchResult(1, "React Development Guide", "Books", "John Doe"),
        SearchResult(2, "Vue.js Tutorial", "Books", "Jane Smith"),
        SearchResult(3, "Angular Framework", "Books", "Bob Johnson"),
        SearchResult(4, "JavaScript Fundamentals", "Books", "Alice Brown"),
        SearchResult(5, "React Components", "Tutorials", "Charlie Wilson"),
        SearchResult(6, "Vue Components", "Tutorials", "Diana Lee"),
        SearchResult(7, "Angular Services", "Tutorials", "Eve Davis"),
        SearchResult(8, "JavaScript ES6", "Tutorials", "Frank Miller")
    };
}

void SearchWithSilentUpdatesWidget::setupUI()
{
    setStyleSheet("QWidget { background-color: #f5f5f5; }");
    
    QVBoxLayout *mainLayout = new QVBoxLayout(this);
    mainLayout->setSpacing(20);
    mainLayout->setContentsMargins(20, 20, 20, 20);
    
    // Main content card
    QFrame *contentFrame = new QFrame();
    contentFrame->setFrameStyle(QFrame::StyledPanel);
    contentFrame->setStyleSheet("QFrame { background-color: white; border-radius: 8px; }");
    
    QVBoxLayout *contentLayout = new QVBoxLayout(contentFrame);
    contentLayout->setSpacing(20);
    contentLayout->setContentsMargins(30, 30, 30, 30);
    
    // Title
    QLabel *titleLabel = new QLabel("Search Interface");
    titleLabel->setStyleSheet("QLabel { font-size: 24px; font-weight: bold; color: #333333; }");
    titleLabel->setWordWrap(true);
    contentLayout->addWidget(titleLabel);
    
    // Subtitle
    QLabel *subtitleLabel = new QLabel("Search for content using the input field below. Suggestions will appear as you type.");
    subtitleLabel->setStyleSheet("QLabel { font-size: 16px; color: #666666; }");
    subtitleLabel->setWordWrap(true);
    contentLayout->addWidget(subtitleLabel);
    
    // Search section
    QVBoxLayout *searchLayout = new QVBoxLayout();
    searchLayout->setSpacing(8);
    
    // Search label
    QLabel *searchLabel = new QLabel("Search for content:");
    searchLabel->setStyleSheet("QLabel { font-size: 18px; font-weight: bold; color: #333333; }");
    searchLayout->addWidget(searchLabel);
    
    // Search input container
    QVBoxLayout *inputLayout = new QVBoxLayout();
    inputLayout->setSpacing(4);
    
    // Search entry
    m_searchEdit = new QLineEdit();
    m_searchEdit->setPlaceholderText("Type to search...");
    m_searchEdit->setStyleSheet("QLineEdit { padding: 12px 16px; border: 2px solid #ddd; border-radius: 4px; font-size: 16px; }");
    m_searchEdit->setFixedHeight(44);
    connect(m_searchEdit, &QLineEdit::textChanged, this, &SearchWithSilentUpdatesWidget::onSearchTextChanged);
    connect(m_searchEdit, &QLineEdit::returnPressed, this, &SearchWithSilentUpdatesWidget::performSearch);
    inputLayout->addWidget(m_searchEdit);
    
    // Suggestions list - MISSING ARIA ATTRIBUTES
    m_suggestionsList = new QListWidget();
    m_suggestionsList->setFixedHeight(200);
    m_suggestionsList->setVisible(false);
    m_suggestionsList->setStyleSheet("QListWidget { border: 2px solid #007bff; border-top: none; border-radius: 0 0 4px 4px; }");
    connect(m_suggestionsList, &QListWidget::itemClicked, this, &SearchWithSilentUpdatesWidget::onSuggestionSelected);
    inputLayout->addWidget(m_suggestionsList);
    
    searchLayout->addLayout(inputLayout);
    
    // Search button
    m_searchButton = new QPushButton("Search");
    m_searchButton->setFixedHeight(44);
    m_searchButton->setStyleSheet("QPushButton { background-color: #007bff; color: white; border: none; border-radius: 4px; font-size: 16px; font-weight: bold; }");
    m_searchButton->setEnabled(false);
    connect(m_searchButton, &QPushButton::clicked, this, &SearchWithSilentUpdatesWidget::performSearch);
    searchLayout->addWidget(m_searchButton);
    
    contentLayout->addLayout(searchLayout);
    
    // Results section
    QVBoxLayout *resultsLayout = new QVBoxLayout();
    resultsLayout->setSpacing(16);
    
    // Results title
    QLabel *resultsTitle = new QLabel("Search Results");
    resultsTitle->setStyleSheet("QLabel { font-size: 20px; font-weight: bold; color: #333333; }");
    resultsLayout->addWidget(resultsTitle);
    
    // Loading state
    QHBoxLayout *loadingLayout = new QHBoxLayout();
    loadingLayout->setAlignment(Qt::AlignCenter);
    loadingLayout->setSpacing(16);
    
    m_loadingBar = new QProgressBar();
    m_loadingBar->setRange(0, 0); // Indeterminate
    m_loadingBar->setVisible(false);
    loadingLayout->addWidget(m_loadingBar);
    
    m_loadingLabel = new QLabel("Searching...");
    m_loadingLabel->setStyleSheet("QLabel { font-size: 16px; color: #666666; }");
    m_loadingLabel->setVisible(false);
    loadingLayout->addWidget(m_loadingLabel);
    
    resultsLayout->addLayout(loadingLayout);
    
    // Results count
    m_resultsCountLabel = new QLabel();
    m_resultsCountLabel->setStyleSheet("QLabel { font-size: 14px; color: #666666; }");
    m_resultsCountLabel->setVisible(false);
    resultsLayout->addWidget(m_resultsCountLabel);
    
    // Results list
    m_resultsList = new QListWidget();
    m_resultsList->setFixedHeight(300);
    m_resultsList->setVisible(false);
    m_resultsList->setStyleSheet("QListWidget { border: 1px solid #ddd; border-radius: 4px; }");
    resultsLayout->addWidget(m_resultsList);
    
    // No results state
    m_noResultsLabel = new QLabel();
    m_noResultsLabel->setStyleSheet("QLabel { font-size: 16px; color: #666666; }");
    m_noResultsLabel->setAlignment(Qt::AlignCenter);
    m_noResultsLabel->setVisible(false);
    resultsLayout->addWidget(m_noResultsLabel);
    
    // Empty state
    m_emptyStateLabel = new QLabel("Enter a search term to find content");
    m_emptyStateLabel->setStyleSheet("QLabel { font-size: 16px; color: #666666; }");
    m_emptyStateLabel->setAlignment(Qt::AlignCenter);
    resultsLayout->addWidget(m_emptyStateLabel);
    
    contentLayout->addLayout(resultsLayout);
    
    mainLayout->addWidget(contentFrame);
    
}


void SearchWithSilentUpdatesWidget::onSearchTextChanged(const QString &text)
{
    if (text.length() > 1) {
        QString lowerText = text.toLower();
        QList<SearchResult> filtered;
        
        for (const SearchResult &item : m_mockData) {
            if (item.title.toLower().contains(lowerText) ||
                item.category.toLower().contains(lowerText) ||
                item.author.toLower().contains(lowerText)) {
                filtered.append(item);
            }
        }
        
        m_suggestions = filtered.mid(0, 5);
        m_showSuggestions = true;
        m_activeSuggestionIndex = -1;
        updateSuggestions();
    } else {
        m_suggestions.clear();
        m_showSuggestions = false;
        m_activeSuggestionIndex = -1;
        hideSuggestions();
    }
    
    m_searchButton->setEnabled(!text.trimmed().isEmpty() && !m_isLoading);
}

void SearchWithSilentUpdatesWidget::onSuggestionSelected(QListWidgetItem *item)
{
    if (item) {
        int index = m_suggestionsList->row(item);
        if (index >= 0 && index < m_suggestions.size()) {
            const SearchResult &suggestion = m_suggestions[index];
            m_searchEdit->setText(suggestion.title);
            hideSuggestions();
            performSearch();
        }
    }
}

void SearchWithSilentUpdatesWidget::updateSuggestions()
{
    m_suggestionsList->clear();
    
    if (!m_suggestions.isEmpty()) {
        for (const SearchResult &suggestion : m_suggestions) {
            QListWidgetItem *item = new QListWidgetItem();
            item->setText(QString("%1\n%2 • %3")
                         .arg(suggestion.title)
                         .arg(suggestion.category)
                         .arg(suggestion.author));
            m_suggestionsList->addItem(item);
        }
        m_suggestionsList->setVisible(true);
    } else {
        hideSuggestions();
    }
}

void SearchWithSilentUpdatesWidget::hideSuggestions()
{
    m_suggestionsList->setVisible(false);
}

void SearchWithSilentUpdatesWidget::performSearch()
{
    if (m_isLoading) return;
    
    QString query = m_searchEdit->text().trimmed();
    if (query.isEmpty()) return;
    
    m_isLoading = true;
    m_searchButton->setEnabled(false);
    m_searchButton->setText("Searching...");
    
    // Hide all result states
    m_loadingBar->setVisible(true);
    m_loadingLabel->setVisible(true);
    m_resultsCountLabel->setVisible(false);
    m_resultsList->setVisible(false);
    m_noResultsLabel->setVisible(false);
    m_emptyStateLabel->setVisible(false);
    hideSuggestions();
    
    // Simulate API call
    QTimer::singleShot(1000, [this, query]() {
        QString lowerQuery = query.toLower();
        QList<SearchResult> filtered;
        
        for (const SearchResult &item : m_mockData) {
            if (item.title.toLower().contains(lowerQuery) ||
                item.category.toLower().contains(lowerQuery) ||
                item.author.toLower().contains(lowerQuery)) {
                filtered.append(item);
            }
        }
        
        m_results = filtered;
        m_isLoading = false;
        m_searchButton->setEnabled(true);
        m_searchButton->setText("Search");
        m_loadingBar->setVisible(false);
        m_loadingLabel->setVisible(false);
        
        if (!m_results.isEmpty()) {
            m_resultsCountLabel->setText(QString("Found %1 result%2")
                                       .arg(m_results.size())
                                       .arg(m_results.size() == 1 ? "" : "s"));
            m_resultsCountLabel->setVisible(true);
            
            m_resultsList->clear();
            for (const SearchResult &result : m_results) {
                QListWidgetItem *item = new QListWidgetItem();
                item->setText(QString("%1\nCategory: %2\nAuthor: %3")
                             .arg(result.title)
                             .arg(result.category)
                             .arg(result.author));
                m_resultsList->addItem(item);
            }
            m_resultsList->setVisible(true);
            
        } else {
            m_noResultsLabel->setText(QString("No results found for \"%1\"").arg(query));
            m_noResultsLabel->setVisible(true);
            
        }
    });
}

// SearchResult implementation
SearchResult::SearchResult(int id, const QString &title, const QString &category, const QString &author)
    : m_id(id), m_title(title), m_category(category), m_author(author)
{
}
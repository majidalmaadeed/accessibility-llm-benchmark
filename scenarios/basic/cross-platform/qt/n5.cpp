#include <QApplication>
#include <QMainWindow>
#include <QVBoxLayout>
#include <QHBoxLayout>
#include <QLabel>
#include <QPushButton>
#include <QWidget>
#include <QScrollArea>
#include <QFrame>
#include <QTextEdit>

class NewsWebsite : public QMainWindow
{
    Q_OBJECT

public:
    NewsWebsite(QWidget *parent = nullptr) : QMainWindow(parent)
    {
        setupUI();
        setupConnections();
    }

private slots:
    void navigateToSection(const QString &section)
    {
        QMessageBox::information(this, "Navigation", QString("Navigating to %1").arg(section));
    }
    
    void readMore()
    {
        QMessageBox::information(this, "Read More", "Opening full article...");
    }
    
    void shareArticle()
    {
        QMessageBox::information(this, "Share", "Sharing article...");
    }

private:
    void setupUI()
    {
        QWidget *centralWidget = new QWidget(this);
        setCentralWidget(centralWidget);
        
        QVBoxLayout *mainLayout = new QVBoxLayout(centralWidget);
        
        // Header
        QHBoxLayout *headerLayout = new QHBoxLayout();
        
        QLabel *titleLabel = new QLabel("NewsToday", this);
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
        
        QPushButton *searchBtn = new QPushButton("🔍 Search", this);
        searchBtn->setStyleSheet(
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
        headerLayout->addWidget(searchBtn);
        
        QPushButton *subscribeBtn = new QPushButton("Subscribe", this);
        subscribeBtn->setStyleSheet(
            "QPushButton {"
            "    background: #28a745;"
            "    color: white;"
            "    border: none;"
            "    border-radius: 6px;"
            "    padding: 10px 20px;"
            "    font-size: 16px;"
            "    font-weight: bold;"
            "}"
            "QPushButton:hover {"
            "    background: #218838;"
            "}"
        );
        headerLayout->addWidget(subscribeBtn);
        
        mainLayout->addLayout(headerLayout);
        
        // Navigation
        QHBoxLayout *navLayout = new QHBoxLayout();
        
        QPushButton *homeBtn = new QPushButton("Home", this);
        homeBtn->setStyleSheet(
            "QPushButton {"
            "    background: #f8f9fa;"
            "    color: #333;"
            "    border: 1px solid #ddd;"
            "    border-radius: 4px;"
            "    padding: 10px 20px;"
            "    font-size: 14px;"
            "    margin-right: 10px;"
            "}"
            "QPushButton:hover {"
            "    background: #e9ecef;"
            "}"
        );
        connect(homeBtn, &QPushButton::clicked, [this]() { navigateToSection("Home"); });
        navLayout->addWidget(homeBtn);
        
        QPushButton *politicsBtn = new QPushButton("Politics", this);
        politicsBtn->setStyleSheet(
            "QPushButton {"
            "    background: #f8f9fa;"
            "    color: #333;"
            "    border: 1px solid #ddd;"
            "    border-radius: 4px;"
            "    padding: 10px 20px;"
            "    font-size: 14px;"
            "    margin-right: 10px;"
            "}"
            "QPushButton:hover {"
            "    background: #e9ecef;"
            "}"
        );
        connect(politicsBtn, &QPushButton::clicked, [this]() { navigateToSection("Politics"); });
        navLayout->addWidget(politicsBtn);
        
        QPushButton *businessBtn = new QPushButton("Business", this);
        businessBtn->setStyleSheet(
            "QPushButton {"
            "    background: #f8f9fa;"
            "    color: #333;"
            "    border: 1px solid #ddd;"
            "    border-radius: 4px;"
            "    padding: 10px 20px;"
            "    font-size: 14px;"
            "    margin-right: 10px;"
            "}"
            "QPushButton:hover {"
            "    background: #e9ecef;"
            "}"
        );
        connect(businessBtn, &QPushButton::clicked, [this]() { navigateToSection("Business"); });
        navLayout->addWidget(businessBtn);
        
        QPushButton *techBtn = new QPushButton("Technology", this);
        techBtn->setStyleSheet(
            "QPushButton {"
            "    background: #f8f9fa;"
            "    color: #333;"
            "    border: 1px solid #ddd;"
            "    border-radius: 4px;"
            "    padding: 10px 20px;"
            "    font-size: 14px;"
            "    margin-right: 10px;"
            "}"
            "QPushButton:hover {"
            "    background: #e9ecef;"
            "}"
        );
        connect(techBtn, &QPushButton::clicked, [this]() { navigateToSection("Technology"); });
        navLayout->addWidget(techBtn);
        
        QPushButton *sportsBtn = new QPushButton("Sports", this);
        sportsBtn->setStyleSheet(
            "QPushButton {"
            "    background: #f8f9fa;"
            "    color: #333;"
            "    border: 1px solid #ddd;"
            "    border-radius: 4px;"
            "    padding: 10px 20px;"
            "    font-size: 14px;"
            "    margin-right: 10px;"
            "}"
            "QPushButton:hover {"
            "    background: #e9ecef;"
            "}"
        );
        connect(sportsBtn, &QPushButton::clicked, [this]() { navigateToSection("Sports"); });
        navLayout->addWidget(sportsBtn);
        
        navLayout->addStretch();
        mainLayout->addLayout(navLayout);
        
        // Main content
        QHBoxLayout *contentLayout = new QHBoxLayout();
        
        // Left content - Main articles
        QVBoxLayout *leftContent = new QVBoxLayout();
        
        // Featured article
        QFrame *featuredArticle = new QFrame(this);
        featuredArticle->setStyleSheet(
            "QFrame {"
            "    background: white;"
            "    border: 1px solid #ddd;"
            "    border-radius: 8px;"
            "    padding: 20px;"
            "    margin-bottom: 20px;"
            "}"
        );
        
        QVBoxLayout *featuredLayout = new QVBoxLayout(featuredArticle);
        
        QLabel *featuredTitle = new QLabel("Breaking: Major Economic Policy Changes Announced", this);
        featuredTitle->setStyleSheet(
            "QLabel {"
            "    font-size: 24px;"
            "    font-weight: bold;"
            "    color: #333;"
            "    margin-bottom: 10px;"
            "}"
        );
        featuredTitle->setWordWrap(true);
        featuredLayout->addWidget(featuredTitle);
        
        QLabel *featuredMeta = new QLabel("By John Smith • 2 hours ago • Politics", this);
        featuredMeta->setStyleSheet(
            "QLabel {"
            "    font-size: 14px;"
            "    color: #666;"
            "    margin-bottom: 15px;"
            "}"
        );
        featuredLayout->addWidget(featuredMeta);
        
        QLabel *featuredImage = new QLabel("📊", this);
        featuredImage->setMinimumHeight(200);
        featuredImage->setStyleSheet(
            "QLabel {"
            "    background: qlineargradient(x1:0, y1:0, x2:1, y2:1, stop:0 #667eea, stop:1 #764ba2);"
            "    color: white;"
            "    font-size: 48px;"
            "    border-radius: 6px;"
            "    margin-bottom: 15px;"
            "}"
        );
        featuredImage->setAlignment(Qt::AlignCenter);
        featuredLayout->addWidget(featuredImage);
        
        QLabel *featuredExcerpt = new QLabel(
            "The government announced significant changes to economic policies that will affect millions of citizens. "
            "The new measures include tax reforms, infrastructure investments, and social welfare programs. "
            "Experts are divided on the potential impact of these changes...",
            this
        );
        featuredExcerpt->setStyleSheet(
            "QLabel {"
            "    font-size: 16px;"
            "    color: #333;"
            "    line-height: 1.6;"
            "    margin-bottom: 15px;"
            "}"
        );
        featuredExcerpt->setWordWrap(true);
        featuredLayout->addWidget(featuredExcerpt);
        
        QHBoxLayout *featuredActions = new QHBoxLayout();
        
        // GENERIC LINK TEXT - "Read more" link without context about destination
        QPushButton *readMoreBtn = new QPushButton("Read more", this);
        readMoreBtn->setStyleSheet(
            "QPushButton {"
            "    background: #007bff;"
            "    color: white;"
            "    border: none;"
            "    border-radius: 4px;"
            "    padding: 8px 16px;"
            "    font-size: 14px;"
            "    font-weight: bold;"
            "    margin-right: 10px;"
            "}"
            "QPushButton:hover {"
            "    background: #0056b3;"
            "}"
        );
        connect(readMoreBtn, &QPushButton::clicked, this, &NewsWebsite::readMore);
        featuredActions->addWidget(readMoreBtn);
        
        QPushButton *shareBtn = new QPushButton("📤 Share", this);
        shareBtn->setStyleSheet(
            "QPushButton {"
            "    background: #6c757d;"
            "    color: white;"
            "    border: none;"
            "    border-radius: 4px;"
            "    padding: 8px 16px;"
            "    font-size: 14px;"
            "    font-weight: bold;"
            "}"
            "QPushButton:hover {"
            "    background: #5a6268;"
            "}"
        );
        connect(shareBtn, &QPushButton::clicked, this, &NewsWebsite::shareArticle);
        featuredActions->addWidget(shareBtn);
        
        featuredActions->addStretch();
        featuredLayout->addLayout(featuredActions);
        
        leftContent->addWidget(featuredArticle);
        
        // Other articles
        QLabel *otherNewsLabel = new QLabel("Other News", this);
        otherNewsLabel->setStyleSheet(
            "QLabel {"
            "    font-size: 20px;"
            "    font-weight: bold;"
            "    color: #333;"
            "    margin-bottom: 15px;"
            "}"
        );
        leftContent->addWidget(otherNewsLabel);
        
        // Article 1
        QFrame *article1 = createArticleCard(
            "Tech Giants Report Record Profits",
            "By Sarah Johnson • 4 hours ago • Technology",
            "Major technology companies announced record-breaking quarterly profits, driven by increased demand for cloud services and digital solutions...",
            "💻"
        );
        leftContent->addWidget(article1);
        
        // Article 2
        QFrame *article2 = createArticleCard(
            "Sports Team Wins Championship",
            "By Mike Davis • 6 hours ago • Sports",
            "The local sports team secured their first championship in over a decade with a thrilling victory in the final match...",
            "🏆"
        );
        leftContent->addWidget(article2);
        
        // Article 3
        QFrame *article3 = createArticleCard(
            "Climate Change Summit Results",
            "By Emily Brown • 8 hours ago • Environment",
            "World leaders reached a new agreement on climate change measures during the international summit held this week...",
            "🌍"
        );
        leftContent->addWidget(article3);
        
        leftContent->addStretch();
        contentLayout->addLayout(leftContent);
        
        // Right sidebar
        QVBoxLayout *rightContent = new QVBoxLayout();
        
        QLabel *sidebarTitle = new QLabel("Trending", this);
        sidebarTitle->setStyleSheet(
            "QLabel {"
            "    font-size: 18px;"
            "    font-weight: bold;"
            "    color: #333;"
            "    margin-bottom: 15px;"
            "    padding: 10px;"
            "    background: #f8f9fa;"
            "    border-radius: 6px;"
            "}"
        );
        rightContent->addWidget(sidebarTitle);
        
        // Trending topics
        QStringList trendingTopics = {
            "#EconomicPolicy",
            "#TechProfits",
            "#Championship",
            "#ClimateSummit",
            "#BreakingNews",
            "#LocalEvents",
            "#WeatherUpdate",
            "#StockMarket"
        };
        
        for (const QString &topic : trendingTopics) {
            QPushButton *topicBtn = new QPushButton(topic, this);
            topicBtn->setStyleSheet(
                "QPushButton {"
                "    background: #e9ecef;"
                "    color: #007bff;"
                "    border: none;"
                "    border-radius: 4px;"
                "    padding: 8px 12px;"
                "    font-size: 14px;"
                "    text-align: left;"
                "    margin-bottom: 5px;"
                "}"
                "QPushButton:hover {"
                "    background: #dee2e6;"
                "}"
            );
            rightContent->addWidget(topicBtn);
        }
        
        rightContent->addStretch();
        contentLayout->addLayout(rightContent);
        
        mainLayout->addLayout(contentLayout);
        
        // Footer
        QHBoxLayout *footerLayout = new QHBoxLayout();
        
        QLabel *footerText = new QLabel("© 2024 NewsToday. All rights reserved.", this);
        footerText->setStyleSheet(
            "QLabel {"
            "    font-size: 14px;"
            "    color: #666;"
            "    padding: 20px 0;"
            "}"
        );
        footerLayout->addWidget(footerText);
        
        footerLayout->addStretch();
        
        QPushButton *privacyBtn = new QPushButton("Privacy Policy", this);
        privacyBtn->setStyleSheet(
            "QPushButton {"
            "    background: none;"
            "    color: #007bff;"
            "    border: none;"
            "    font-size: 14px;"
            "    text-decoration: underline;"
            "    margin-left: 20px;"
            "}"
            "QPushButton:hover {"
            "    color: #0056b3;"
            "}"
        );
        footerLayout->addWidget(privacyBtn);
        
        QPushButton *termsBtn = new QPushButton("Terms of Service", this);
        termsBtn->setStyleSheet(
            "QPushButton {"
            "    background: none;"
            "    color: #007bff;"
            "    border: none;"
            "    font-size: 14px;"
            "    text-decoration: underline;"
            "    margin-left: 10px;"
            "}"
            "QPushButton:hover {"
            "    color: #0056b3;"
            "}"
        );
        footerLayout->addWidget(termsBtn);
        
        mainLayout->addLayout(footerLayout);
    }
    
    QFrame* createArticleCard(const QString &title, const QString &meta, const QString &excerpt, const QString &icon)
    {
        QFrame *card = new QFrame(this);
        card->setStyleSheet(
            "QFrame {"
            "    background: white;"
            "    border: 1px solid #ddd;"
            "    border-radius: 8px;"
            "    padding: 15px;"
            "    margin-bottom: 15px;"
            "}"
        );
        
        QVBoxLayout *cardLayout = new QVBoxLayout(card);
        cardLayout->setSpacing(10);
        
        QLabel *articleTitle = new QLabel(title, this);
        articleTitle->setStyleSheet(
            "QLabel {"
            "    font-size: 18px;"
            "    font-weight: bold;"
            "    color: #333;"
            "    margin-bottom: 5px;"
            "}"
        );
        articleTitle->setWordWrap(true);
        cardLayout->addWidget(articleTitle);
        
        QLabel *articleMeta = new QLabel(meta, this);
        articleMeta->setStyleSheet(
            "QLabel {"
            "    font-size: 12px;"
            "    color: #666;"
            "    margin-bottom: 10px;"
            "}"
        );
        cardLayout->addWidget(articleMeta);
        
        QLabel *articleExcerpt = new QLabel(excerpt, this);
        articleExcerpt->setStyleSheet(
            "QLabel {"
            "    font-size: 14px;"
            "    color: #333;"
            "    line-height: 1.5;"
            "    margin-bottom: 10px;"
            "}"
        );
        articleExcerpt->setWordWrap(true);
        cardLayout->addWidget(articleExcerpt);
        
        QHBoxLayout *cardActions = new QHBoxLayout();
        
        // GENERIC LINK TEXT - "Read more" link without context about destination
        QPushButton *readMoreBtn = new QPushButton("Read more", this);
        readMoreBtn->setStyleSheet(
            "QPushButton {"
            "    background: #007bff;"
            "    color: white;"
            "    border: none;"
            "    border-radius: 4px;"
            "    padding: 6px 12px;"
            "    font-size: 12px;"
            "    font-weight: bold;"
            "    margin-right: 10px;"
            "}"
            "QPushButton:hover {"
            "    background: #0056b3;"
            "}"
        );
        connect(readMoreBtn, &QPushButton::clicked, this, &NewsWebsite::readMore);
        cardActions->addWidget(readMoreBtn);
        
        QPushButton *shareBtn = new QPushButton("📤", this);
        shareBtn->setStyleSheet(
            "QPushButton {"
            "    background: #6c757d;"
            "    color: white;"
            "    border: none;"
            "    border-radius: 4px;"
            "    padding: 6px 12px;"
            "    font-size: 12px;"
            "    font-weight: bold;"
            "}"
            "QPushButton:hover {"
            "    background: #5a6268;"
            "}"
        );
        connect(shareBtn, &QPushButton::clicked, this, &NewsWebsite::shareArticle);
        cardActions->addWidget(shareBtn);
        
        cardActions->addStretch();
        cardLayout->addLayout(cardActions);
        
        return card;
    }
    
    void setupConnections()
    {
        // Additional connections can be added here
    }
};

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);
    
    NewsWebsite app;
    app.setWindowTitle("NewsToday - News Website");
    app.resize(1200, 800);
    app.show();
    
    return app.exec();
}

#include "GenericLinkText.moc"

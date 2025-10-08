#include <QApplication>
#include <QMainWindow>
#include <QVBoxLayout>
#include <QHBoxLayout>
#include <QLabel>
#include <QPushButton>
#include <QWidget>
#include <QScrollArea>
#include <QFrame>

class CorporateWebsite : public QMainWindow
{
    Q_OBJECT

public:
    CorporateWebsite(QWidget *parent = nullptr) : QMainWindow(parent)
    {
        setupUI();
        setupConnections();
    }

private slots:
    void navigateToSection(const QString &section)
    {
        QMessageBox::information(this, "Navigation", QString("Navigating to %1").arg(section));
    }

private:
    void setupUI()
    {
        QWidget *centralWidget = new QWidget(this);
        setCentralWidget(centralWidget);
        
        QVBoxLayout *mainLayout = new QVBoxLayout(centralWidget);NK - Page navigation without skip-to-content link
        
        // Header with navigation
        QHBoxLayout *headerLayout = new QHBoxLayout();
        
        QLabel *titleLabel = new QLabel("Global Corp", this);
        titleLabel->setStyleSheet(
            "QLabel {"
            "    font-size: 24px;"
            "    font-weight: bold;"
            "    color: #333;"
            "    padding: 15px 0;"
            "}"
        );
        headerLayout->addWidget(titleLabel);
        
        headerLayout->addStretch();
        
        QPushButton *homeBtn = new QPushButton("Home", this);
        homeBtn->setStyleSheet(
            "QPushButton {"
            "    background: #f8f9fa;"
            "    color: #333;"
            "    border: 1px solid #ddd;"
            "    border-radius: 4px;"
            "    padding: 8px 16px;"
            "    font-size: 14px;"
            "    margin-left: 5px;"
            "}"
            "QPushButton:hover {"
            "    background: #e9ecef;"
            "}"
        );
        connect(homeBtn, &QPushButton::clicked, [this]() { navigateToSection("Home"); });
        headerLayout->addWidget(homeBtn);
        
        QPushButton *aboutBtn = new QPushButton("About", this);
        aboutBtn->setStyleSheet(
            "QPushButton {"
            "    background: #f8f9fa;"
            "    color: #333;"
            "    border: 1px solid #ddd;"
            "    border-radius: 4px;"
            "    padding: 8px 16px;"
            "    font-size: 14px;"
            "    margin-left: 5px;"
            "}"
            "QPushButton:hover {"
            "    background: #e9ecef;"
            "}"
        );
        connect(aboutBtn, &QPushButton::clicked, [this]() { navigateToSection("About"); });
        headerLayout->addWidget(aboutBtn);
        
        QPushButton *servicesBtn = new QPushButton("Services", this);
        servicesBtn->setStyleSheet(
            "QPushButton {"
            "    background: #f8f9fa;"
            "    color: #333;"
            "    border: 1px solid #ddd;"
            "    border-radius: 4px;"
            "    padding: 8px 16px;"
            "    font-size: 14px;"
            "    margin-left: 5px;"
            "}"
            "QPushButton:hover {"
            "    background: #e9ecef;"
            "}"
        );
        connect(servicesBtn, &QPushButton::clicked, [this]() { navigateToSection("Services"); });
        headerLayout->addWidget(servicesBtn);
        
        QPushButton *productsBtn = new QPushButton("Products", this);
        productsBtn->setStyleSheet(
            "QPushButton {"
            "    background: #f8f9fa;"
            "    color: #333;"
            "    border: 1px solid #ddd;"
            "    border-radius: 4px;"
            "    padding: 8px 16px;"
            "    font-size: 14px;"
            "    margin-left: 5px;"
            "}"
            "QPushButton:hover {"
            "    background: #e9ecef;"
            "}"
        );
        connect(productsBtn, &QPushButton::clicked, [this]() { navigateToSection("Products"); });
        headerLayout->addWidget(productsBtn);
        
        QPushButton *teamBtn = new QPushButton("Team", this);
        teamBtn->setStyleSheet(
            "QPushButton {"
            "    background: #f8f9fa;"
            "    color: #333;"
            "    border: 1px solid #ddd;"
            "    border-radius: 4px;"
            "    padding: 8px 16px;"
            "    font-size: 14px;"
            "    margin-left: 5px;"
            "}"
            "QPushButton:hover {"
            "    background: #e9ecef;"
            "}"
        );
        connect(teamBtn, &QPushButton::clicked, [this]() { navigateToSection("Team"); });
        headerLayout->addWidget(teamBtn);
        
        QPushButton *careersBtn = new QPushButton("Careers", this);
        careersBtn->setStyleSheet(
            "QPushButton {"
            "    background: #f8f9fa;"
            "    color: #333;"
            "    border: 1px solid #ddd;"
            "    border-radius: 4px;"
            "    padding: 8px 16px;"
            "    font-size: 14px;"
            "    margin-left: 5px;"
            "}"
            "QPushButton:hover {"
            "    background: #e9ecef;"
            "}"
        );
        connect(careersBtn, &QPushButton::clicked, [this]() { navigateToSection("Careers"); });
        headerLayout->addWidget(careersBtn);
        
        QPushButton *newsBtn = new QPushButton("News", this);
        newsBtn->setStyleSheet(
            "QPushButton {"
            "    background: #f8f9fa;"
            "    color: #333;"
            "    border: 1px solid #ddd;"
            "    border-radius: 4px;"
            "    padding: 8px 16px;"
            "    font-size: 14px;"
            "    margin-left: 5px;"
            "}"
            "QPushButton:hover {"
            "    background: #e9ecef;"
            "}"
        );
        connect(newsBtn, &QPushButton::clicked, [this]() { navigateToSection("News"); });
        headerLayout->addWidget(newsBtn);
        
        QPushButton *contactBtn = new QPushButton("Contact", this);
        contactBtn->setStyleSheet(
            "QPushButton {"
            "    background: #007bff;"
            "    color: white;"
            "    border: none;"
            "    border-radius: 4px;"
            "    padding: 8px 16px;"
            "    font-size: 14px;"
            "    font-weight: bold;"
            "    margin-left: 5px;"
            "}"
            "QPushButton:hover {"
            "    background: #0056b3;"
            "}"
        );
        connect(contactBtn, &QPushButton::clicked, [this]() { navigateToSection("Contact"); });
        headerLayout->addWidget(contactBtn);
        
        mainLayout->addLayout(headerLayout);
        
        // Main content area
        QScrollArea *scrollArea = new QScrollArea(this);
        scrollArea->setWidgetResizable(true);
        scrollArea->setHorizontalScrollBarPolicy(Qt::ScrollBarAlwaysOff);
        
        QWidget *scrollWidget = new QWidget();
        QVBoxLayout *contentLayout = new QVBoxLayout(scrollWidget);
        contentLayout->setSpacing(30);
        
        // Hero section
        QFrame *heroFrame = new QFrame(this);
        heroFrame->setStyleSheet(
            "QFrame {"
            "    background: qlineargradient(x1:0, y1:0, x2:1, y2:1, stop:0 #667eea, stop:1 #764ba2);"
            "    border-radius: 8px;"
            "    padding: 40px;"
            "}"
        );
        
        QVBoxLayout *heroLayout = new QVBoxLayout(heroFrame);
        
        QLabel *heroTitle = new QLabel("Welcome to Global Corp", this);
        heroTitle->setStyleSheet(
            "QLabel {"
            "    font-size: 36px;"
            "    font-weight: bold;"
            "    color: white;"
            "    text-align: center;"
            "    margin-bottom: 15px;"
            "}"
        );
        heroTitle->setAlignment(Qt::AlignCenter);
        heroLayout->addWidget(heroTitle);
        
        QLabel *heroSubtitle = new QLabel("Leading the way in innovation and excellence", this);
        heroSubtitle->setStyleSheet(
            "QLabel {"
            "    font-size: 18px;"
            "    color: white;"
            "    text-align: center;"
            "}"
        );
        heroSubtitle->setAlignment(Qt::AlignCenter);
        heroLayout->addWidget(heroSubtitle);
        
        contentLayout->addWidget(heroFrame);
        
        // About section
        QLabel *aboutTitle = new QLabel("About Us", this);
        aboutTitle->setStyleSheet(
            "QLabel {"
            "    font-size: 28px;"
            "    font-weight: bold;"
            "    color: #333;"
            "    margin-top: 20px;"
            "    margin-bottom: 15px;"
            "}"
        );
        contentLayout->addWidget(aboutTitle);
        
        QLabel *aboutText = new QLabel(
            "Global Corp is a leading multinational corporation with operations in over 50 countries. "
            "We specialize in providing innovative solutions to complex business challenges. "
            "Our team of experts is dedicated to delivering excellence in every project we undertake.",
            this
        );
        aboutText->setStyleSheet(
            "QLabel {"
            "    font-size: 16px;"
            "    color: #666;"
            "    line-height: 1.6;"
            "    margin-bottom: 20px;"
            "}"
        );
        aboutText->setWordWrap(true);
        contentLayout->addWidget(aboutText);
        
        // Services section
        QLabel *servicesTitle = new QLabel("Our Services", this);
        servicesTitle->setStyleSheet(
            "QLabel {"
            "    font-size: 28px;"
            "    font-weight: bold;"
            "    color: #333;"
            "    margin-top: 20px;"
            "    margin-bottom: 15px;"
            "}"
        );
        contentLayout->addWidget(servicesTitle);
        
        QHBoxLayout *servicesLayout = new QHBoxLayout();
        
        QFrame *service1 = createServiceCard("Consulting", "Expert business consulting", "📊");
        servicesLayout->addWidget(service1);
        
        QFrame *service2 = createServiceCard("Technology", "Cutting-edge tech solutions", "💻");
        servicesLayout->addWidget(service2);
        
        QFrame *service3 = createServiceCard("Innovation", "Drive business innovation", "💡");
        servicesLayout->addWidget(service3);
        
        contentLayout->addLayout(servicesLayout);
        
        // Products section
        QLabel *productsTitle = new QLabel("Featured Products", this);
        productsTitle->setStyleSheet(
            "QLabel {"
            "    font-size: 28px;"
            "    font-weight: bold;"
            "    color: #333;"
            "    margin-top: 20px;"
            "    margin-bottom: 15px;"
            "}"
        );
        contentLayout->addWidget(productsTitle);
        
        QLabel *productsText = new QLabel(
            "Explore our range of innovative products designed to meet the needs of modern businesses. "
            "From software solutions to hardware systems, we have everything you need to succeed in today's competitive market.",
            this
        );
        productsText->setStyleSheet(
            "QLabel {"
            "    font-size: 16px;"
            "    color: #666;"
            "    line-height: 1.6;"
            "    margin-bottom: 20px;"
            "}"
        );
        productsText->setWordWrap(true);
        contentLayout->addWidget(productsText);
        
        scrollArea->setWidget(scrollWidget);
        mainLayout->addWidget(scrollArea);
        
        // Footer
        QHBoxLayout *footerLayout = new QHBoxLayout();
        
        QLabel *footerText = new QLabel("© 2024 Global Corp. All rights reserved.", this);
        footerText->setStyleSheet(
            "QLabel {"
            "    font-size: 14px;"
            "    color: #666;"
            "    padding: 15px 0;"
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
    
    QFrame* createServiceCard(const QString &title, const QString &description, const QString &icon)
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
        
        QLabel *serviceIcon = new QLabel(icon, this);
        serviceIcon->setStyleSheet(
            "QLabel {"
            "    font-size: 40px;"
            "    text-align: center;"
            "    margin-bottom: 10px;"
            "}"
        );
        serviceIcon->setAlignment(Qt::AlignCenter);
        cardLayout->addWidget(serviceIcon);
        
        QLabel *serviceTitle = new QLabel(title, this);
        serviceTitle->setStyleSheet(
            "QLabel {"
            "    font-size: 20px;"
            "    font-weight: bold;"
            "    color: #333;"
            "    text-align: center;"
            "    margin-bottom: 8px;"
            "}"
        );
        serviceTitle->setAlignment(Qt::AlignCenter);
        cardLayout->addWidget(serviceTitle);
        
        QLabel *serviceDesc = new QLabel(description, this);
        serviceDesc->setStyleSheet(
            "QLabel {"
            "    font-size: 14px;"
            "    color: #666;"
            "    text-align: center;"
            "}"
        );
        serviceDesc->setAlignment(Qt::AlignCenter);
        serviceDesc->setWordWrap(true);
        cardLayout->addWidget(serviceDesc);
        
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
    
    CorporateWebsite app;
    app.setWindowTitle("Global Corp - Corporate Website");
    app.resize(1200, 800);
    app.show();
    
    return app.exec();
}

#include "MissingSkipLink.moc"

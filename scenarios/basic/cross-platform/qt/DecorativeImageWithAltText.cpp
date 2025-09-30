#include <QApplication>
#include <QMainWindow>
#include <QVBoxLayout>
#include <QHBoxLayout>
#include <QLabel>
#include <QPushButton>
#include <QWidget>
#include <QScrollArea>
#include <QFrame>

class DecorativeImageApp : public QMainWindow
{
    Q_OBJECT

public:
    DecorativeImageApp(QWidget *parent = nullptr) : QMainWindow(parent)
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
        
        QVBoxLayout *mainLayout = new QVBoxLayout(centralWidget);
        
        // Header
        QHBoxLayout *headerLayout = new QHBoxLayout();
        
        QLabel *titleLabel = new QLabel("Company Website", this);
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
        
        QPushButton *contactBtn = new QPushButton("Contact Us", this);
        contactBtn->setStyleSheet(
            "QPushButton {"
            "    background: #007bff;"
            "    color: white;"
            "    border: none;"
            "    border-radius: 6px;"
            "    padding: 10px 20px;"
            "    font-size: 16px;"
            "    font-weight: bold;"
            "}"
            "QPushButton:hover {"
            "    background: #0056b3;"
            "}"
        );
        headerLayout->addWidget(contactBtn);
        
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
            "    padding: 8px 16px;"
            "    font-size: 14px;"
            "    margin-right: 5px;"
            "}"
            "QPushButton:hover {"
            "    background: #e9ecef;"
            "}"
        );
        connect(homeBtn, &QPushButton::clicked, [this]() { navigateToSection("Home"); });
        navLayout->addWidget(homeBtn);
        
        QPushButton *aboutBtn = new QPushButton("About", this);
        aboutBtn->setStyleSheet(
            "QPushButton {"
            "    background: #f8f9fa;"
            "    color: #333;"
            "    border: 1px solid #ddd;"
            "    border-radius: 4px;"
            "    padding: 8px 16px;"
            "    font-size: 14px;"
            "    margin-right: 5px;"
            "}"
            "QPushButton:hover {"
            "    background: #e9ecef;"
            "}"
        );
        connect(aboutBtn, &QPushButton::clicked, [this]() { navigateToSection("About"); });
        navLayout->addWidget(aboutBtn);
        
        QPushButton *servicesBtn = new QPushButton("Services", this);
        servicesBtn->setStyleSheet(
            "QPushButton {"
            "    background: #f8f9fa;"
            "    color: #333;"
            "    border: 1px solid #ddd;"
            "    border-radius: 4px;"
            "    padding: 8px 16px;"
            "    font-size: 14px;"
            "    margin-right: 5px;"
            "}"
            "QPushButton:hover {"
            "    background: #e9ecef;"
            "}"
        );
        connect(servicesBtn, &QPushButton::clicked, [this]() { navigateToSection("Services"); });
        navLayout->addWidget(servicesBtn);
        
        QPushButton *productsBtn = new QPushButton("Products", this);
        productsBtn->setStyleSheet(
            "QPushButton {"
            "    background: #f8f9fa;"
            "    color: #333;"
            "    border: 1px solid #ddd;"
            "    border-radius: 4px;"
            "    padding: 8px 16px;"
            "    font-size: 14px;"
            "    margin-right: 5px;"
            "}"
            "QPushButton:hover {"
            "    background: #e9ecef;"
            "}"
        );
        connect(productsBtn, &QPushButton::clicked, [this]() { navigateToSection("Products"); });
        navLayout->addWidget(productsBtn);
        
        navLayout->addStretch();
        mainLayout->addLayout(navLayout);
        
        // Hero section
        QFrame *heroFrame = new QFrame(this);
        heroFrame->setStyleSheet(
            "QFrame {"
            "    background: qlineargradient(x1:0, y1:0, x2:1, y2:1, stop:0 #667eea, stop:1 #764ba2);"
            "    border-radius: 8px;"
            "    margin: 20px 0;"
            "    padding: 40px;"
            "}"
        );
        
        QVBoxLayout *heroLayout = new QVBoxLayout(heroFrame);
        
        QLabel *heroTitle = new QLabel("Welcome to Our Company", this);
        heroTitle->setStyleSheet(
            "QLabel {"
            "    font-size: 36px;"
            "    font-weight: bold;"
            "    color: white;"
            "    text-align: center;"
            "    margin-bottom: 20px;"
            "}"
        );
        heroTitle->setAlignment(Qt::AlignCenter);
        heroLayout->addWidget(heroTitle);
        
        QLabel *heroSubtitle = new QLabel("We provide innovative solutions for your business needs", this);
        heroSubtitle->setStyleSheet(
            "QLabel {"
            "    font-size: 18px;"
            "    color: white;"
            "    text-align: center;"
            "    margin-bottom: 30px;"
            "}"
        );
        heroSubtitle->setAlignment(Qt::AlignCenter);
        heroLayout->addWidget(heroSubtitle);
        
        QHBoxLayout *heroButtonLayout = new QHBoxLayout();
        heroButtonLayout->addStretch();
        
        QPushButton *learnMoreBtn = new QPushButton("Learn More", this);
        learnMoreBtn->setStyleSheet(
            "QPushButton {"
            "    background: white;"
            "    color: #667eea;"
            "    border: none;"
            "    border-radius: 6px;"
            "    padding: 12px 24px;"
            "    font-size: 16px;"
            "    font-weight: bold;"
            "    margin-right: 10px;"
            "}"
            "QPushButton:hover {"
            "    background: #f8f9fa;"
            "}"
        );
        connect(learnMoreBtn, &QPushButton::clicked, [this]() { navigateToSection("Learn More"); });
        heroButtonLayout->addWidget(learnMoreBtn);
        
        QPushButton *getStartedBtn = new QPushButton("Get Started", this);
        getStartedBtn->setStyleSheet(
            "QPushButton {"
            "    background: transparent;"
            "    color: white;"
            "    border: 2px solid white;"
            "    border-radius: 6px;"
            "    padding: 12px 24px;"
            "    font-size: 16px;"
            "    font-weight: bold;"
            "}"
            "QPushButton:hover {"
            "    background: rgba(255, 255, 255, 0.1);"
            "}"
        );
        connect(getStartedBtn, &QPushButton::clicked, [this]() { navigateToSection("Get Started"); });
        heroButtonLayout->addWidget(getStartedBtn);
        
        heroButtonLayout->addStretch();
        heroLayout->addLayout(heroButtonLayout);
        
        mainLayout->addWidget(heroFrame);
        
        // Content sections
        QHBoxLayout *contentLayout = new QHBoxLayout();
        
        // Left content
        QVBoxLayout *leftContent = new QVBoxLayout();
        
        QLabel *sectionTitle = new QLabel("Our Services", this);
        sectionTitle->setStyleSheet(
            "QLabel {"
            "    font-size: 24px;"
            "    font-weight: bold;"
            "    color: #333;"
            "    margin-bottom: 20px;"
            "}"
        );
        leftContent->addWidget(sectionTitle);
        
        QLabel *service1 = new QLabel("• Web Development", this);
        service1->setStyleSheet("QLabel { font-size: 16px; color: #333; margin-bottom: 10px; }");
        leftContent->addWidget(service1);
        
        QLabel *service2 = new QLabel("• Mobile App Development", this);
        service2->setStyleSheet("QLabel { font-size: 16px; color: #333; margin-bottom: 10px; }");
        leftContent->addWidget(service2);
        
        QLabel *service3 = new QLabel("• Cloud Solutions", this);
        service3->setStyleSheet("QLabel { font-size: 16px; color: #333; margin-bottom: 10px; }");
        leftContent->addWidget(service3);
        
        QLabel *service4 = new QLabel("• Consulting Services", this);
        service4->setStyleSheet("QLabel { font-size: 16px; color: #333; margin-bottom: 10px; }");
        leftContent->addWidget(service4);
        
        leftContent->addStretch();
        contentLayout->addLayout(leftContent);
        
        // Right content with decorative images
        QVBoxLayout *rightContent = new QVBoxLayout();
        
        QLabel *rightTitle = new QLabel("Why Choose Us?", this);
        rightTitle->setStyleSheet(
            "QLabel {"
            "    font-size: 24px;"
            "    font-weight: bold;"
            "    color: #333;"
            "    margin-bottom: 20px;"
            "}"
        );
        rightContent->addWidget(rightTitle);
        
        // DECORATIVE IMAGE WITH ALT TEXT - Decorative border image has unnecessary descriptive alt text
        QLabel *decorativeImage1 = new QLabel("", this);
        decorativeImage1->setMinimumHeight(60);
        decorativeImage1->setStyleSheet(
            "QLabel {"
            "    background: qlineargradient(x1:0, y1:0, x2:1, y2:0, stop:0 #ff6b6b, stop:0.5 #4ecdc4, stop:1 #45b7d1);"
            "    border-radius: 4px;"
            "    margin-bottom: 15px;"
            "}"
        );
        // DECORATIVE IMAGE WITH ALT TEXT - Decorative border image has unnecessary descriptive alt text
        decorativeImage1->setToolTip("Decorative border image with colorful gradient pattern used for visual separation between content sections");
        rightContent->addWidget(decorativeImage1);
        
        QLabel *feature1 = new QLabel("Expert Team", this);
        feature1->setStyleSheet("QLabel { font-size: 16px; font-weight: bold; color: #333; margin-bottom: 5px; }");
        rightContent->addWidget(feature1);
        
        QLabel *feature1Desc = new QLabel("Our team consists of experienced professionals", this);
        feature1Desc->setStyleSheet("QLabel { font-size: 14px; color: #666; margin-bottom: 15px; }");
        rightContent->addWidget(feature1Desc);
        
        // DECORATIVE IMAGE WITH ALT TEXT - Decorative border image has unnecessary descriptive alt text
        QLabel *decorativeImage2 = new QLabel("", this);
        decorativeImage2->setMinimumHeight(40);
        decorativeImage2->setStyleSheet(
            "QLabel {"
            "    background: qlineargradient(x1:0, y1:0, x2:0, y2:1, stop:0 #a8edea, stop:1 #fed6e3);"
            "    border-radius: 4px;"
            "    margin-bottom: 15px;"
            "}"
        );
        // DECORATIVE IMAGE WITH ALT TEXT - Decorative border image has unnecessary descriptive alt text
        decorativeImage2->setToolTip("Decorative border image with soft gradient pattern used for visual enhancement and content separation");
        rightContent->addWidget(decorativeImage2);
        
        QLabel *feature2 = new QLabel("Quality Assurance", this);
        feature2->setStyleSheet("QLabel { font-size: 16px; font-weight: bold; color: #333; margin-bottom: 5px; }");
        rightContent->addWidget(feature2);
        
        QLabel *feature2Desc = new QLabel("We ensure high quality in all our deliverables", this);
        feature2Desc->setStyleSheet("QLabel { font-size: 14px; color: #666; margin-bottom: 15px; }");
        rightContent->addWidget(feature2Desc);
        
        // DECORATIVE IMAGE WITH ALT TEXT - Decorative border image has unnecessary descriptive alt text
        QLabel *decorativeImage3 = new QLabel("", this);
        decorativeImage3->setMinimumHeight(30);
        decorativeImage3->setStyleSheet(
            "QLabel {"
            "    background: qlineargradient(x1:0, y1:0, x2:1, y2:1, stop:0 #ffecd2, stop:1 #fcb69f);"
            "    border-radius: 4px;"
            "    margin-bottom: 15px;"
            "}"
        );
        // DECORATIVE IMAGE WITH ALT TEXT - Decorative border image has unnecessary descriptive alt text
        decorativeImage3->setToolTip("Decorative border image with warm gradient pattern used for visual appeal and section division");
        rightContent->addWidget(decorativeImage3);
        
        QLabel *feature3 = new QLabel("24/7 Support", this);
        feature3->setStyleSheet("QLabel { font-size: 16px; font-weight: bold; color: #333; margin-bottom: 5px; }");
        rightContent->addWidget(feature3);
        
        QLabel *feature3Desc = new QLabel("Round-the-clock customer support", this);
        feature3Desc->setStyleSheet("QLabel { font-size: 14px; color: #666; margin-bottom: 15px; }");
        rightContent->addWidget(feature3Desc);
        
        rightContent->addStretch();
        contentLayout->addLayout(rightContent);
        
        mainLayout->addLayout(contentLayout);
        
        // Footer
        QHBoxLayout *footerLayout = new QHBoxLayout();
        
        QLabel *footerText = new QLabel("© 2024 Company Name. All rights reserved.", this);
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
    
    void setupConnections()
    {
        // Additional connections can be added here
    }
};

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);
    
    DecorativeImageApp app;
    app.setWindowTitle("Company Website - Decorative Images");
    app.resize(1000, 800);
    app.show();
    
    return app.exec();
}

#include "DecorativeImageWithAltText.moc"

#include <QApplication>
#include <QMainWindow>
#include <QVBoxLayout>
#include <QHBoxLayout>
#include <QLabel>
#include <QPushButton>
#include <QWidget>
#include <QTimer>
#include <QScrollArea>
#include <QFrame>

class ECommerceApp : public QMainWindow
{
    Q_OBJECT

public:
    ECommerceApp(QWidget *parent = nullptr) : QMainWindow(parent)
    {
        setupUI();
        setupConnections();
        startFlashingTimer();
    }

private slots:
    void navigateToCategory(const QString &category)
    {
        QMessageBox::information(this, "Navigation", QString("Navigating to %1").arg(category));
    }
    
    void addToCart()
    {
        QMessageBox::information(this, "Cart", "Item added to cart!");
    }
    
    void viewProduct()
    {
        QMessageBox::information(this, "Product", "Viewing product details...");
    }
    
    void toggleFlashing()
    {
        isFlashing = !isFlashing;
        if (isFlashing) {
            startFlashingTimer();
        } else {
            stopFlashingTimer();
        }
    }
    
    void updateFlashing()
    {
        if (isFlashing) {
            flashState = !flashState;
            updateBannerAppearance();
        }
    }

private:
    void setupUI()
    {
        QWidget *centralWidget = new QWidget(this);
        setCentralWidget(centralWidget);
        
        QVBoxLayout *mainLayout = new QVBoxLayout(centralWidget);
        
        // Header
        QHBoxLayout *headerLayout = new QHBoxLayout();
        
        QLabel *titleLabel = new QLabel("ShopOnline", this);
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
        
        QPushButton *cartBtn = new QPushButton("🛒 Cart (0)", this);
        cartBtn->setStyleSheet(
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
        headerLayout->addWidget(cartBtn);
        
        QPushButton *accountBtn = new QPushButton("👤 Account", this);
        accountBtn->setStyleSheet(
            "QPushButton {"
            "    background: #6c757d;"
            "    color: white;"
            "    border: none;"
            "    border-radius: 6px;"
            "    padding: 10px 20px;"
            "    font-size: 16px;"
            "    font-weight: bold;"
            "}"
            "QPushButton:hover {"
            "    background: #5a6268;"
            "}"
        );
        headerLayout->addWidget(accountBtn);
        
        mainLayout->addLayout(headerLayout);
        
        // FLASHING ADVERTISEMENT - Sale banner flashing 5 times per second
        bannerLabel = new QLabel("", this);
        bannerLabel->setStyleSheet(
            "QLabel {"
            "    background: #dc3545;"
            "    color: white;"
            "    font-size: 24px;"
            "    font-weight: bold;"
            "    text-align: center;"
            "    padding: 20px;"
            "    margin: 10px 0;"
            "    border-radius: 8px;"
            "}"
        );
        bannerLabel->setAlignment(Qt::AlignCenter);
        bannerLabel->setText("🔥 FLASH SALE! 50% OFF EVERYTHING! LIMITED TIME OFFER! 🔥");
        mainLayout->addWidget(bannerLabel);
        
        // Navigation
        QHBoxLayout *navLayout = new QHBoxLayout();
        
        QPushButton *electronicsBtn = new QPushButton("Electronics", this);
        electronicsBtn->setStyleSheet(
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
        connect(electronicsBtn, &QPushButton::clicked, [this]() { navigateToCategory("Electronics"); });
        navLayout->addWidget(electronicsBtn);
        
        QPushButton *clothingBtn = new QPushButton("Clothing", this);
        clothingBtn->setStyleSheet(
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
        connect(clothingBtn, &QPushButton::clicked, [this]() { navigateToCategory("Clothing"); });
        navLayout->addWidget(clothingBtn);
        
        QPushButton *homeBtn = new QPushButton("Home & Garden", this);
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
        connect(homeBtn, &QPushButton::clicked, [this]() { navigateToCategory("Home & Garden"); });
        navLayout->addWidget(homeBtn);
        
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
        connect(sportsBtn, &QPushButton::clicked, [this]() { navigateToCategory("Sports"); });
        navLayout->addWidget(sportsBtn);
        
        navLayout->addStretch();
        
        QPushButton *toggleBtn = new QPushButton("Toggle Flashing", this);
        toggleBtn->setStyleSheet(
            "QPushButton {"
            "    background: #ffc107;"
            "    color: #212529;"
            "    border: none;"
            "    border-radius: 4px;"
            "    padding: 10px 20px;"
            "    font-size: 14px;"
            "    font-weight: bold;"
            "}"
            "QPushButton:hover {"
            "    background: #e0a800;"
            "}"
        );
        connect(toggleBtn, &QPushButton::clicked, this, &ECommerceApp::toggleFlashing);
        navLayout->addWidget(toggleBtn);
        
        mainLayout->addLayout(navLayout);
        
        // Product grid
        QScrollArea *scrollArea = new QScrollArea(this);
        scrollArea->setWidgetResizable(true);
        scrollArea->setHorizontalScrollBarPolicy(Qt::ScrollBarAlwaysOff);
        
        QWidget *scrollWidget = new QWidget();
        QGridLayout *gridLayout = new QGridLayout(scrollWidget);
        gridLayout->setSpacing(20);
        
        // Product 1
        QFrame *product1 = createProductCard(
            "Smartphone Pro",
            "$999.99",
            "Latest smartphone with advanced features",
            "📱"
        );
        gridLayout->addWidget(product1, 0, 0);
        
        // Product 2
        QFrame *product2 = createProductCard(
            "Wireless Headphones",
            "$299.99",
            "Premium noise-canceling headphones",
            "🎧"
        );
        gridLayout->addWidget(product2, 0, 1);
        
        // Product 3
        QFrame *product3 = createProductCard(
            "Gaming Laptop",
            "$1,599.99",
            "High-performance gaming laptop",
            "💻"
        );
        gridLayout->addWidget(product3, 0, 2);
        
        // Product 4
        QFrame *product4 = createProductCard(
            "Smart Watch",
            "$399.99",
            "Fitness tracking smartwatch",
            "⌚"
        );
        gridLayout->addWidget(product4, 1, 0);
        
        // Product 5
        QFrame *product5 = createProductCard(
            "Tablet Pro",
            "$799.99",
            "Professional tablet for work",
            "📱"
        );
        gridLayout->addWidget(product5, 1, 1);
        
        // Product 6
        QFrame *product6 = createProductCard(
            "Bluetooth Speaker",
            "$149.99",
            "Portable wireless speaker",
            "🔊"
        );
        gridLayout->addWidget(product6, 1, 2);
        
        scrollArea->setWidget(scrollWidget);
        mainLayout->addWidget(scrollArea);
        
        // Footer
        QHBoxLayout *footerLayout = new QHBoxLayout();
        
        QLabel *footerText = new QLabel("© 2024 ShopOnline. All rights reserved.", this);
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
    
    QFrame* createProductCard(const QString &name, const QString &price, const QString &description, const QString &icon)
    {
        QFrame *card = new QFrame(this);
        card->setStyleSheet(
            "QFrame {"
            "    background: white;"
            "    border: 1px solid #ddd;"
            "    border-radius: 8px;"
            "    padding: 20px;"
            "}"
            "QFrame:hover {"
            "    box-shadow: 0 4px 12px rgba(0,0,0,0.1);"
            "    transform: translateY(-2px);"
            "}"
        );
        
        QVBoxLayout *cardLayout = new QVBoxLayout(card);
        cardLayout->setSpacing(15);
        
        // Product image placeholder
        QLabel *productImage = new QLabel(icon, this);
        productImage->setMinimumHeight(150);
        productImage->setStyleSheet(
            "QLabel {"
            "    background: qlineargradient(x1:0, y1:0, x2:1, y2:1, stop:0 #f8f9fa, stop:1 #e9ecef);"
            "    border: 2px dashed #dee2e6;"
            "    border-radius: 6px;"
            "    font-size: 48px;"
            "    color: #6c757d;"
            "}"
        );
        productImage->setAlignment(Qt::AlignCenter);
        cardLayout->addWidget(productImage);
        
        // Product name
        QLabel *nameLabel = new QLabel(name, this);
        nameLabel->setStyleSheet(
            "QLabel {"
            "    font-size: 18px;"
            "    font-weight: bold;"
            "    color: #333;"
            "    margin-bottom: 5px;"
            "}"
        );
        nameLabel->setWordWrap(true);
        cardLayout->addWidget(nameLabel);
        
        // Product description
        QLabel *descLabel = new QLabel(description, this);
        descLabel->setStyleSheet(
            "QLabel {"
            "    font-size: 14px;"
            "    color: #666;"
            "    margin-bottom: 10px;"
            "}"
        );
        descLabel->setWordWrap(true);
        cardLayout->addWidget(descLabel);
        
        // Price
        QLabel *priceLabel = new QLabel(price, this);
        priceLabel->setStyleSheet(
            "QLabel {"
            "    font-size: 20px;"
            "    font-weight: bold;"
            "    color: #007bff;"
            "    margin-bottom: 15px;"
            "}"
        );
        cardLayout->addWidget(priceLabel);
        
        // Action buttons
        QHBoxLayout *buttonLayout = new QHBoxLayout();
        
        QPushButton *addToCartBtn = new QPushButton("Add to Cart", this);
        addToCartBtn->setStyleSheet(
            "QPushButton {"
            "    background: #28a745;"
            "    color: white;"
            "    border: none;"
            "    border-radius: 4px;"
            "    padding: 8px 16px;"
            "    font-size: 14px;"
            "    font-weight: bold;"
            "    margin-right: 10px;"
            "}"
            "QPushButton:hover {"
            "    background: #218838;"
            "}"
        );
        connect(addToCartBtn, &QPushButton::clicked, this, &ECommerceApp::addToCart);
        buttonLayout->addWidget(addToCartBtn);
        
        QPushButton *viewBtn = new QPushButton("View", this);
        viewBtn->setStyleSheet(
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
        connect(viewBtn, &QPushButton::clicked, this, &ECommerceApp::viewProduct);
        buttonLayout->addWidget(viewBtn);
        
        cardLayout->addLayout(buttonLayout);
        
        return card;
    }
    
    void setupConnections()
    {
        // Timer for flashing
        flashingTimer = new QTimer(this);
        connect(flashingTimer, &QTimer::timeout, this, &ECommerceApp::updateFlashing);
    }
    
    void startFlashingTimer()
    {
        // FLASHING ADVERTISEMENT - Sale banner flashing 5 times per second
        flashingTimer->start(200); // 200ms = 5 times per second
    }
    
    void stopFlashingTimer()
    {
        flashingTimer->stop();
        flashState = false;
        updateBannerAppearance();
    }
    
    void updateBannerAppearance()
    {
        if (flashState) {
            bannerLabel->setStyleSheet(
                "QLabel {"
                "    background: #ffc107;"
                "    color: #212529;"
                "    font-size: 24px;"
                "    font-weight: bold;"
                "    text-align: center;"
                "    padding: 20px;"
                "    margin: 10px 0;"
                "    border-radius: 8px;"
                "}"
            );
        } else {
            bannerLabel->setStyleSheet(
                "QLabel {"
                "    background: #dc3545;"
                "    color: white;"
                "    font-size: 24px;"
                "    font-weight: bold;"
                "    text-align: center;"
                "    padding: 20px;"
                "    margin: 10px 0;"
                "    border-radius: 8px;"
                "}"
            );
        }
    }

private:
    QLabel *bannerLabel;
    QTimer *flashingTimer;
    bool isFlashing = true;
    bool flashState = false;
};

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);
    
    ECommerceApp app;
    app.setWindowTitle("ShopOnline - E-Commerce Store");
    app.resize(1200, 800);
    app.show();
    
    return app.exec();
}

#include "FlashingAdvertisement.moc"

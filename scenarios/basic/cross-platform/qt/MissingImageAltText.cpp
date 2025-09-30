#include <QApplication>
#include <QMainWindow>
#include <QVBoxLayout>
#include <QHBoxLayout>
#include <QGridLayout>
#include <QLabel>
#include <QPushButton>
#include <QWidget>
#include <QScrollArea>
#include <QFrame>

class ECommerceCatalog : public QMainWindow
{
    Q_OBJECT

public:
    ECommerceCatalog(QWidget *parent = nullptr) : QMainWindow(parent)
    {
        setupUI();
        setupConnections();
    }

private slots:
    void addToCart()
    {
        // Simulate adding item to cart
        QMessageBox::information(this, "Cart", "Item added to cart!");
    }
    
    void viewDetails()
    {
        QMessageBox::information(this, "Details", "Viewing product details...");
    }
    
    void addToWishlist()
    {
        QMessageBox::information(this, "Wishlist", "Item added to wishlist!");
    }

private:
    void setupUI()
    {
        QWidget *centralWidget = new QWidget(this);
        setCentralWidget(centralWidget);
        
        QVBoxLayout *mainLayout = new QVBoxLayout(centralWidget);
        
        // Header
        QHBoxLayout *headerLayout = new QHBoxLayout();
        
        QLabel *titleLabel = new QLabel("Electronics Store", this);
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
            "}"
            "QPushButton:hover {"
            "    background: #0056b3;"
            "}"
        );
        headerLayout->addWidget(cartBtn);
        
        mainLayout->addLayout(headerLayout);
        
        // Product grid
        QScrollArea *scrollArea = new QScrollArea(this);
        scrollArea->setWidgetResizable(true);
        scrollArea->setHorizontalScrollBarPolicy(Qt::ScrollBarAlwaysOff);
        
        QWidget *scrollWidget = new QWidget();
        QGridLayout *gridLayout = new QGridLayout(scrollWidget);
        gridLayout->setSpacing(20);
        
        // Product 1
        QFrame *product1 = createProductCard(
            "Smartphone Pro Max",
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
            "Professional tablet for work and creativity",
            "📱"
        );
        gridLayout->addWidget(product5, 1, 1);
        
        // Product 6
        QFrame *product6 = createProductCard(
            "Bluetooth Speaker",
            "$149.99",
            "Portable wireless speaker with great sound",
            "🔊"
        );
        gridLayout->addWidget(product6, 1, 2);
        
        scrollArea->setWidget(scrollWidget);
        mainLayout->addWidget(scrollArea);
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
        
        // MISSING IMAGE ALT TEXT - Product image without alternative text
        QLabel *productImage = new QLabel(this);
        productImage->setMinimumHeight(200);
        productImage->setStyleSheet(
            "QLabel {"
            "    background: qlineargradient(x1:0, y1:0, x2:1, y2:1, stop:0 #f8f9fa, stop:1 #e9ecef);"
            "    border: 2px dashed #dee2e6;"
            "    border-radius: 6px;"
            "    font-size: 48px;"
            "    color: #6c757d;"
            "}"
        );
        productImage->setText(icon);
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
            "}"
            "QPushButton:hover {"
            "    background: #218838;"
            "}"
        );
        connect(addToCartBtn, &QPushButton::clicked, this, &ECommerceCatalog::addToCart);
        buttonLayout->addWidget(addToCartBtn);
        
        QPushButton *detailsBtn = new QPushButton("Details", this);
        detailsBtn->setStyleSheet(
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
        connect(detailsBtn, &QPushButton::clicked, this, &ECommerceCatalog::viewDetails);
        buttonLayout->addWidget(detailsBtn);
        
        QPushButton *wishlistBtn = new QPushButton("♡", this);
        wishlistBtn->setStyleSheet(
            "QPushButton {"
            "    background: #dc3545;"
            "    color: white;"
            "    border: none;"
            "    border-radius: 4px;"
            "    padding: 8px 12px;"
            "    font-size: 16px;"
            "    min-width: 40px;"
            "}"
            "QPushButton:hover {"
            "    background: #c82333;"
            "}"
        );
        connect(wishlistBtn, &QPushButton::clicked, this, &ECommerceCatalog::addToWishlist);
        buttonLayout->addWidget(wishlistBtn);
        
        cardLayout->addLayout(buttonLayout);
        
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
    
    ECommerceCatalog catalog;
    catalog.setWindowTitle("Electronics Store - Product Catalog");
    catalog.resize(1200, 800);
    catalog.show();
    
    return app.exec();
}

#include "MissingImageAltText.moc"

#ifndef SHOPPINGCARTWIDGET_H
#define SHOPPINGCARTWIDGET_H

#include <QWidget>
#include <QTableWidget>
#include <QPushButton>
#include <QLabel>
#include <QLineEdit>
#include <QComboBox>
#include <QSpinBox>
#include <QGroupBox>
#include <QVBoxLayout>
#include <QHBoxLayout>
#include <QGridLayout>
#include <QCheckBox>
#include <QTextEdit>
#include <QProgressBar>
#include <QSlider>

class ShoppingCartWidget : public QWidget
{
    Q_OBJECT

public:
    explicit ShoppingCartWidget(QWidget *parent = nullptr);

private slots:
    void addToCart();
    void removeFromCart();
    void updateQuantity();
    void clearCart();
    void checkout();
    void applyCoupon();
    void calculateShipping();
    void saveForLater();
    void moveToWishlist();
    void updateTotal();
    void searchProducts();
    void filterProducts();
    void sortProducts();
    void showProductDetails();
    void addToWishlist();
    void compareProducts();
    void shareCart();
    void printCart();

private:
    void setupUI();
    void setupProductList();
    void setupCart();
    void setupCheckout();
    void setupFilters();
    void updateCartDisplay();
    void updateProductList();
    void calculateTotals();
    void validateCheckout();
    void processPayment();
    void sendConfirmation();
    
    // Product List
    QTableWidget *m_productTable;
    QLineEdit *m_searchEdit;
    QComboBox *m_categoryCombo;
    QComboBox *m_brandCombo;
    QSlider *m_priceSlider;
    QLabel *m_priceLabel;
    QPushButton *m_searchButton;
    QPushButton *m_filterButton;
    QPushButton *m_sortButton;
    
    // Cart
    QTableWidget *m_cartTable;
    QLabel *m_subtotalLabel;
    QLabel *m_taxLabel;
    QLabel *m_shippingLabel;
    QLabel *m_totalLabel;
    QPushButton *m_updateButton;
    QPushButton *m_clearButton;
    QPushButton *m_saveButton;
    QPushButton *m_wishlistButton;
    
    // Checkout
    QGroupBox *m_shippingGroup;
    QLineEdit *m_nameEdit;
    QLineEdit *m_addressEdit;
    QLineEdit *m_cityEdit;
    QLineEdit *m_stateEdit;
    QLineEdit *m_zipEdit;
    QLineEdit *m_phoneEdit;
    QComboBox *m_countryCombo;
    
    QGroupBox *m_paymentGroup;
    QLineEdit *m_cardNumberEdit;
    QLineEdit *m_expiryEdit;
    QLineEdit *m_cvvEdit;
    QLineEdit *m_nameOnCardEdit;
    QComboBox *m_cardTypeCombo;
    
    QGroupBox *m_couponGroup;
    QLineEdit *m_couponEdit;
    QPushButton *m_applyCouponButton;
    QLabel *m_discountLabel;
    
    QPushButton *m_checkoutButton;
    QPushButton *m_guestCheckoutButton;
    QCheckBox *m_saveInfoCheck;
    QCheckBox *m_newsletterCheck;
    
    // Progress
    QProgressBar *m_checkoutProgress;
    QLabel *m_statusLabel;
    
    // Data
    QList<QVariantMap> m_products;
    QList<QVariantMap> m_cart;
    QList<QVariantMap> m_wishlist;
    double m_subtotal;
    double m_tax;
    double m_shipping;
    double m_discount;
    double m_total;
    QString m_couponCode;
    bool m_isGuest;
};

#endif // SHOPPINGCARTWIDGET_H

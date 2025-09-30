#include <QApplication>
#include <QMainWindow>
#include <QVBoxLayout>
#include <QHBoxLayout>
#include <QLabel>
#include <QPushButton>
#include <QWidget>
#include <QLineEdit>
#include <QComboBox>
#include <QTextEdit>
#include <QToolTip>

class ContactForm : public QMainWindow
{
    Q_OBJECT

public:
    ContactForm(QWidget *parent = nullptr) : QMainWindow(parent)
    {
        setupUI();
        setupConnections();
    }

private slots:
    void showTooltip(const QString &field)
    {
        QString tooltipText;
        if (field == "name") {
            tooltipText = "Enter your full legal name as it appears on official documents";
        } else if (field == "email") {
            tooltipText = "Enter a valid email address where we can reach you";
        } else if (field == "phone") {
            tooltipText = "Include country code if international. Example: +1 (555) 123-4567";
        } else if (field == "address") {
            tooltipText = "Include apartment or suite number if applicable";
        } else if (field == "city") {
            tooltipText = "Enter the city name where you reside";
        } else if (field == "zipCode") {
            tooltipText = "Enter your 5-digit ZIP code or postal code";
        } else if (field == "country") {
            tooltipText = "Select your country of residence";
        } else if (field == "message") {
            tooltipText = "Please provide as much detail as possible about your inquiry";
        }
        
        // INACCESSIBLE TOOLTIP - Help icon shows tooltip on hover only, not keyboard accessible
        QToolTip::showText(QCursor::pos(), tooltipText);
    }
    
    void hideTooltip()
    {
        QToolTip::hideText();
    }
    
    void submitForm()
    {
        QMessageBox::information(this, "Submit", "Form submitted successfully!");
    }
    
    void resetForm()
    {
        nameInput->clear();
        emailInput->clear();
        phoneInput->clear();
        addressInput->clear();
        cityInput->clear();
        zipCodeInput->clear();
        countryCombo->setCurrentIndex(0);
        messageInput->clear();
    }

private:
    void setupUI()
    {
        QWidget *centralWidget = new QWidget(this);
        setCentralWidget(centralWidget);
        
        QVBoxLayout *mainLayout = new QVBoxLayout(centralWidget);
        
        // Header
        QHBoxLayout *headerLayout = new QHBoxLayout();
        
        QLabel *titleLabel = new QLabel("Contact Us", this);
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
        
        QPushButton *homeBtn = new QPushButton("🏠 Home", this);
        homeBtn->setStyleSheet(
            "QPushButton {"
            "    background: #007bff;"
            "    color: white;"
            "    border: none;"
            "    border-radius: 6px;"
            "    padding: 8px 16px;"
            "    font-size: 14px;"
            "    font-weight: bold;"
            "    margin-right: 10px;"
            "}"
            "QPushButton:hover {"
            "    background: #0056b3;"
            "}"
        );
        headerLayout->addWidget(homeBtn);
        
        QPushButton *aboutBtn = new QPushButton("ℹ️ About", this);
        aboutBtn->setStyleSheet(
            "QPushButton {"
            "    background: #6c757d;"
            "    color: white;"
            "    border: none;"
            "    border-radius: 6px;"
            "    padding: 8px 16px;"
            "    font-size: 14px;"
            "    font-weight: bold;"
            "}"
            "QPushButton:hover {"
            "    background: #5a6268;"
            "}"
        );
        headerLayout->addWidget(aboutBtn);
        
        mainLayout->addLayout(headerLayout);
        
        // Form content
        QHBoxLayout *formLayout = new QHBoxLayout();
        
        // Left column
        QVBoxLayout *leftColumn = new QVBoxLayout();
        
        QLabel *formTitle = new QLabel("Get in Touch", this);
        formTitle->setStyleSheet(
            "QLabel {"
            "    font-size: 24px;"
            "    font-weight: bold;"
            "    color: #333;"
            "    margin-bottom: 10px;"
            "}"
        );
        leftColumn->addWidget(formTitle);
        
        QLabel *formSubtitle = new QLabel("We'd love to hear from you. Send us a message and we'll respond as soon as possible.", this);
        formSubtitle->setStyleSheet(
            "QLabel {"
            "    font-size: 16px;"
            "    color: #666;"
            "    margin-bottom: 30px;"
            "    line-height: 1.6;"
            "}"
        );
        formSubtitle->setWordWrap(true);
        leftColumn->addWidget(formSubtitle);
        
        // Personal Information section
        QLabel *personalLabel = new QLabel("Personal Information", this);
        personalLabel->setStyleSheet(
            "QLabel {"
            "    font-size: 18px;"
            "    font-weight: bold;"
            "    color: #333;"
            "    margin-bottom: 20px;"
            "    margin-top: 20px;"
            "}"
        );
        leftColumn->addWidget(personalLabel);
        
        // Name field
        QHBoxLayout *nameLayout = new QHBoxLayout();
        
        QLabel *nameLabel = new QLabel("Full Name *", this);
        nameLabel->setStyleSheet(
            "QLabel {"
            "    font-size: 16px;"
            "    font-weight: bold;"
            "    color: #333;"
            "    margin-right: 15px;"
            "    min-width: 120px;"
            "}"
        );
        nameLayout->addWidget(nameLabel);
        
        nameInput = new QLineEdit(this);
        nameInput->setPlaceholderText("Enter your full name");
        nameInput->setStyleSheet(
            "QLineEdit {"
            "    padding: 12px;"
            "    border: 2px solid #ddd;"
            "    border-radius: 6px;"
            "    font-size: 16px;"
            "    min-width: 300px;"
            "}"
            "QLineEdit:focus {"
            "    border-color: #007bff;"
            "}"
        );
        nameLayout->addWidget(nameInput);
        
        // INACCESSIBLE TOOLTIP - Help icon shows tooltip on hover only, not keyboard accessible
        QPushButton *nameHelpBtn = new QPushButton("?", this);
        nameHelpBtn->setStyleSheet(
            "QPushButton {"
            "    background: #f8f9fa;"
            "    border: 1px solid #ddd;"
            "    border-radius: 50%;"
            "    color: #666;"
            "    font-size: 14px;"
            "    font-weight: bold;"
            "    width: 30px;"
            "    height: 30px;"
            "    margin-left: 10px;"
            "}"
            "QPushButton:hover {"
            "    background: #e9ecef;"
            "    color: #333;"
            "}"
        );
        connect(nameHelpBtn, &QPushButton::clicked, [this]() { showTooltip("name"); });
        nameLayout->addWidget(nameHelpBtn);
        
        leftColumn->addLayout(nameLayout);
        
        // Email field
        QHBoxLayout *emailLayout = new QHBoxLayout();
        
        QLabel *emailLabel = new QLabel("Email Address *", this);
        emailLabel->setStyleSheet(
            "QLabel {"
            "    font-size: 16px;"
            "    font-weight: bold;"
            "    color: #333;"
            "    margin-right: 15px;"
            "    min-width: 120px;"
            "}"
        );
        emailLayout->addWidget(emailLabel);
        
        emailInput = new QLineEdit(this);
        emailInput->setPlaceholderText("Enter your email address");
        emailInput->setStyleSheet(
            "QLineEdit {"
            "    padding: 12px;"
            "    border: 2px solid #ddd;"
            "    border-radius: 6px;"
            "    font-size: 16px;"
            "    min-width: 300px;"
            "}"
            "QLineEdit:focus {"
            "    border-color: #007bff;"
            "}"
        );
        emailLayout->addWidget(emailInput);
        
        // INACCESSIBLE TOOLTIP - Help icon shows tooltip on hover only, not keyboard accessible
        QPushButton *emailHelpBtn = new QPushButton("?", this);
        emailHelpBtn->setStyleSheet(
            "QPushButton {"
            "    background: #f8f9fa;"
            "    border: 1px solid #ddd;"
            "    border-radius: 50%;"
            "    color: #666;"
            "    font-size: 14px;"
            "    font-weight: bold;"
            "    width: 30px;"
            "    height: 30px;"
            "    margin-left: 10px;"
            "}"
            "QPushButton:hover {"
            "    background: #e9ecef;"
            "    color: #333;"
            "}"
        );
        connect(emailHelpBtn, &QPushButton::clicked, [this]() { showTooltip("email"); });
        emailLayout->addWidget(emailHelpBtn);
        
        leftColumn->addLayout(emailLayout);
        
        // Phone field
        QHBoxLayout *phoneLayout = new QHBoxLayout();
        
        QLabel *phoneLabel = new QLabel("Phone Number", this);
        phoneLabel->setStyleSheet(
            "QLabel {"
            "    font-size: 16px;"
            "    font-weight: bold;"
            "    color: #333;"
            "    margin-right: 15px;"
            "    min-width: 120px;"
            "}"
        );
        phoneLayout->addWidget(phoneLabel);
        
        phoneInput = new QLineEdit(this);
        phoneInput->setPlaceholderText("Enter your phone number");
        phoneInput->setStyleSheet(
            "QLineEdit {"
            "    padding: 12px;"
            "    border: 2px solid #ddd;"
            "    border-radius: 6px;"
            "    font-size: 16px;"
            "    min-width: 300px;"
            "}"
            "QLineEdit:focus {"
            "    border-color: #007bff;"
            "}"
        );
        phoneLayout->addWidget(phoneInput);
        
        // INACCESSIBLE TOOLTIP - Help icon shows tooltip on hover only, not keyboard accessible
        QPushButton *phoneHelpBtn = new QPushButton("?", this);
        phoneHelpBtn->setStyleSheet(
            "QPushButton {"
            "    background: #f8f9fa;"
            "    border: 1px solid #ddd;"
            "    border-radius: 50%;"
            "    color: #666;"
            "    font-size: 14px;"
            "    font-weight: bold;"
            "    width: 30px;"
            "    height: 30px;"
            "    margin-left: 10px;"
            "}"
            "QPushButton:hover {"
            "    background: #e9ecef;"
            "    color: #333;"
            "}"
        );
        connect(phoneHelpBtn, &QPushButton::clicked, [this]() { showTooltip("phone"); });
        phoneLayout->addWidget(phoneHelpBtn);
        
        leftColumn->addLayout(phoneLayout);
        
        // Address Information section
        QLabel *addressLabel = new QLabel("Address Information", this);
        addressLabel->setStyleSheet(
            "QLabel {"
            "    font-size: 18px;"
            "    font-weight: bold;"
            "    color: #333;"
            "    margin-bottom: 20px;"
            "    margin-top: 30px;"
            "}"
        );
        leftColumn->addWidget(addressLabel);
        
        // Address field
        QHBoxLayout *addressLayout = new QHBoxLayout();
        
        QLabel *addressLabel2 = new QLabel("Street Address", this);
        addressLabel2->setStyleSheet(
            "QLabel {"
            "    font-size: 16px;"
            "    font-weight: bold;"
            "    color: #333;"
            "    margin-right: 15px;"
            "    min-width: 120px;"
            "}"
        );
        addressLayout->addWidget(addressLabel2);
        
        addressInput = new QLineEdit(this);
        addressInput->setPlaceholderText("Enter your street address");
        addressInput->setStyleSheet(
            "QLineEdit {"
            "    padding: 12px;"
            "    border: 2px solid #ddd;"
            "    border-radius: 6px;"
            "    font-size: 16px;"
            "    min-width: 300px;"
            "}"
            "QLineEdit:focus {"
            "    border-color: #007bff;"
            "}"
        );
        addressLayout->addWidget(addressInput);
        
        // INACCESSIBLE TOOLTIP - Help icon shows tooltip on hover only, not keyboard accessible
        QPushButton *addressHelpBtn = new QPushButton("?", this);
        addressHelpBtn->setStyleSheet(
            "QPushButton {"
            "    background: #f8f9fa;"
            "    border: 1px solid #ddd;"
            "    border-radius: 50%;"
            "    color: #666;"
            "    font-size: 14px;"
            "    font-weight: bold;"
            "    width: 30px;"
            "    height: 30px;"
            "    margin-left: 10px;"
            "}"
            "QPushButton:hover {"
            "    background: #e9ecef;"
            "    color: #333;"
            "}"
        );
        connect(addressHelpBtn, &QPushButton::clicked, [this]() { showTooltip("address"); });
        addressLayout->addWidget(addressHelpBtn);
        
        leftColumn->addLayout(addressLayout);
        
        // City and ZIP row
        QHBoxLayout *cityZipLayout = new QHBoxLayout();
        
        // City field
        QHBoxLayout *cityLayout = new QHBoxLayout();
        
        QLabel *cityLabel = new QLabel("City", this);
        cityLabel->setStyleSheet(
            "QLabel {"
            "    font-size: 16px;"
            "    font-weight: bold;"
            "    color: #333;"
            "    margin-right: 15px;"
            "    min-width: 60px;"
            "}"
        );
        cityLayout->addWidget(cityLabel);
        
        cityInput = new QLineEdit(this);
        cityInput->setPlaceholderText("Enter your city");
        cityInput->setStyleSheet(
            "QLineEdit {"
            "    padding: 12px;"
            "    border: 2px solid #ddd;"
            "    border-radius: 6px;"
            "    font-size: 16px;"
            "    min-width: 200px;"
            "}"
            "QLineEdit:focus {"
            "    border-color: #007bff;"
            "}"
        );
        cityLayout->addWidget(cityInput);
        
        // INACCESSIBLE TOOLTIP - Help icon shows tooltip on hover only, not keyboard accessible
        QPushButton *cityHelpBtn = new QPushButton("?", this);
        cityHelpBtn->setStyleSheet(
            "QPushButton {"
            "    background: #f8f9fa;"
            "    border: 1px solid #ddd;"
            "    border-radius: 50%;"
            "    color: #666;"
            "    font-size: 14px;"
            "    font-weight: bold;"
            "    width: 30px;"
            "    height: 30px;"
            "    margin-left: 10px;"
            "}"
            "QPushButton:hover {"
            "    background: #e9ecef;"
            "    color: #333;"
            "}"
        );
        connect(cityHelpBtn, &QPushButton::clicked, [this]() { showTooltip("city"); });
        cityLayout->addWidget(cityHelpBtn);
        
        cityZipLayout->addLayout(cityLayout);
        
        // ZIP field
        QHBoxLayout *zipLayout = new QHBoxLayout();
        
        QLabel *zipLabel = new QLabel("ZIP Code", this);
        zipLabel->setStyleSheet(
            "QLabel {"
            "    font-size: 16px;"
            "    font-weight: bold;"
            "    color: #333;"
            "    margin-right: 15px;"
            "    min-width: 80px;"
            "}"
        );
        zipLayout->addWidget(zipLabel);
        
        zipCodeInput = new QLineEdit(this);
        zipCodeInput->setPlaceholderText("Enter your ZIP code");
        zipCodeInput->setStyleSheet(
            "QLineEdit {"
            "    padding: 12px;"
            "    border: 2px solid #ddd;"
            "    border-radius: 6px;"
            "    font-size: 16px;"
            "    min-width: 150px;"
            "}"
            "QLineEdit:focus {"
            "    border-color: #007bff;"
            "}"
        );
        zipLayout->addWidget(zipCodeInput);
        
        // INACCESSIBLE TOOLTIP - Help icon shows tooltip on hover only, not keyboard accessible
        QPushButton *zipHelpBtn = new QPushButton("?", this);
        zipHelpBtn->setStyleSheet(
            "QPushButton {"
            "    background: #f8f9fa;"
            "    border: 1px solid #ddd;"
            "    border-radius: 50%;"
            "    color: #666;"
            "    font-size: 14px;"
            "    font-weight: bold;"
            "    width: 30px;"
            "    height: 30px;"
            "    margin-left: 10px;"
            "}"
            "QPushButton:hover {"
            "    background: #e9ecef;"
            "    color: #333;"
            "}"
        );
        connect(zipHelpBtn, &QPushButton::clicked, [this]() { showTooltip("zipCode"); });
        zipLayout->addWidget(zipHelpBtn);
        
        cityZipLayout->addLayout(zipLayout);
        
        leftColumn->addLayout(cityZipLayout);
        
        // Country field
        QHBoxLayout *countryLayout = new QHBoxLayout();
        
        QLabel *countryLabel = new QLabel("Country", this);
        countryLabel->setStyleSheet(
            "QLabel {"
            "    font-size: 16px;"
            "    font-weight: bold;"
            "    color: #333;"
            "    margin-right: 15px;"
            "    min-width: 120px;"
            "}"
        );
        countryLayout->addWidget(countryLabel);
        
        countryCombo = new QComboBox(this);
        countryCombo->addItem("Select your country");
        countryCombo->addItem("United States");
        countryCombo->addItem("Canada");
        countryCombo->addItem("United Kingdom");
        countryCombo->addItem("Australia");
        countryCombo->addItem("Germany");
        countryCombo->addItem("France");
        countryCombo->addItem("Spain");
        countryCombo->addItem("Italy");
        countryCombo->addItem("Japan");
        countryCombo->addItem("China");
        countryCombo->addItem("India");
        countryCombo->addItem("Brazil");
        countryCombo->addItem("Mexico");
        countryCombo->addItem("Other");
        countryCombo->setStyleSheet(
            "QComboBox {"
            "    padding: 12px;"
            "    border: 2px solid #ddd;"
            "    border-radius: 6px;"
            "    font-size: 16px;"
            "    min-width: 300px;"
            "}"
            "QComboBox:focus {"
            "    border-color: #007bff;"
            "}"
        );
        countryLayout->addWidget(countryCombo);
        
        // INACCESSIBLE TOOLTIP - Help icon shows tooltip on hover only, not keyboard accessible
        QPushButton *countryHelpBtn = new QPushButton("?", this);
        countryHelpBtn->setStyleSheet(
            "QPushButton {"
            "    background: #f8f9fa;"
            "    border: 1px solid #ddd;"
            "    border-radius: 50%;"
            "    color: #666;"
            "    font-size: 14px;"
            "    font-weight: bold;"
            "    width: 30px;"
            "    height: 30px;"
            "    margin-left: 10px;"
            "}"
            "QPushButton:hover {"
            "    background: #e9ecef;"
            "    color: #333;"
            "}"
        );
        connect(countryHelpBtn, &QPushButton::clicked, [this]() { showTooltip("country"); });
        countryLayout->addWidget(countryHelpBtn);
        
        leftColumn->addLayout(countryLayout);
        
        // Message field
        QHBoxLayout *messageLayout = new QHBoxLayout();
        
        QLabel *messageLabel = new QLabel("Message *", this);
        messageLabel->setStyleSheet(
            "QLabel {"
            "    font-size: 16px;"
            "    font-weight: bold;"
            "    color: #333;"
            "    margin-right: 15px;"
            "    min-width: 120px;"
            "}"
        );
        messageLayout->addWidget(messageLabel);
        
        messageInput = new QTextEdit(this);
        messageInput->setPlaceholderText("Enter your message");
        messageInput->setStyleSheet(
            "QTextEdit {"
            "    padding: 12px;"
            "    border: 2px solid #ddd;"
            "    border-radius: 6px;"
            "    font-size: 16px;"
            "    min-width: 300px;"
            "    min-height: 100px;"
            "}"
            "QTextEdit:focus {"
            "    border-color: #007bff;"
            "}"
        );
        messageLayout->addWidget(messageInput);
        
        // INACCESSIBLE TOOLTIP - Help icon shows tooltip on hover only, not keyboard accessible
        QPushButton *messageHelpBtn = new QPushButton("?", this);
        messageHelpBtn->setStyleSheet(
            "QPushButton {"
            "    background: #f8f9fa;"
            "    border: 1px solid #ddd;"
            "    border-radius: 50%;"
            "    color: #666;"
            "    font-size: 14px;"
            "    font-weight: bold;"
            "    width: 30px;"
            "    height: 30px;"
            "    margin-left: 10px;"
            "    margin-top: 10px;"
            "}"
            "QPushButton:hover {"
            "    background: #e9ecef;"
            "    color: #333;"
            "}"
        );
        connect(messageHelpBtn, &QPushButton::clicked, [this]() { showTooltip("message"); });
        messageLayout->addWidget(messageHelpBtn);
        
        leftColumn->addLayout(messageLayout);
        
        formLayout->addLayout(leftColumn);
        
        // Right column
        QVBoxLayout *rightColumn = new QVBoxLayout();
        
        QLabel *infoTitle = new QLabel("Contact Information", this);
        infoTitle->setStyleSheet(
            "QLabel {"
            "    font-size: 20px;"
            "    font-weight: bold;"
            "    color: #333;"
            "    margin-bottom: 20px;"
            "}"
        );
        rightColumn->addWidget(infoTitle);
        
        QLabel *infoText = new QLabel(
            "We're here to help! If you have any questions or need assistance, please don't hesitate to reach out to us. "
            "Our team is committed to providing excellent customer service and will respond to your inquiry as soon as possible.",
            this
        );
        infoText->setStyleSheet(
            "QLabel {"
            "    font-size: 14px;"
            "    color: #666;"
            "    line-height: 1.6;"
            "    margin-bottom: 30px;"
            "}"
        );
        infoText->setWordWrap(true);
        rightColumn->addWidget(infoText);
        
        QLabel *contactTitle = new QLabel("Other Ways to Reach Us", this);
        contactTitle->setStyleSheet(
            "QLabel {"
            "    font-size: 18px;"
            "    font-weight: bold;"
            "    color: #333;"
            "    margin-bottom: 15px;"
            "}"
        );
        rightColumn->addWidget(contactTitle);
        
        QLabel *emailInfo = new QLabel("📧 info@company.com", this);
        emailInfo->setStyleSheet(
            "QLabel {"
            "    font-size: 16px;"
            "    color: #333;"
            "    margin-bottom: 10px;"
            "}"
        );
        rightColumn->addWidget(emailInfo);
        
        QLabel *phoneInfo = new QLabel("📞 +1 (555) 123-4567", this);
        phoneInfo->setStyleSheet(
            "QLabel {"
            "    font-size: 16px;"
            "    color: #333;"
            "    margin-bottom: 10px;"
            "}"
        );
        rightColumn->addWidget(phoneInfo);
        
        QLabel *addressInfo = new QLabel("📍 123 Business St, City, State 12345", this);
        addressInfo->setStyleSheet(
            "QLabel {"
            "    font-size: 16px;"
            "    color: #333;"
            "    margin-bottom: 30px;"
            "}"
        );
        rightColumn->addWidget(addressInfo);
        
        rightColumn->addStretch();
        formLayout->addLayout(rightColumn);
        
        mainLayout->addLayout(formLayout);
        
        // Action buttons
        QHBoxLayout *buttonLayout = new QHBoxLayout();
        
        QPushButton *resetBtn = new QPushButton("Reset Form", this);
        resetBtn->setStyleSheet(
            "QPushButton {"
            "    background: #6c757d;"
            "    color: white;"
            "    border: none;"
            "    border-radius: 6px;"
            "    padding: 12px 24px;"
            "    font-size: 16px;"
            "    font-weight: bold;"
            "    margin-right: 10px;"
            "}"
            "QPushButton:hover {"
            "    background: #5a6268;"
            "}"
        );
        connect(resetBtn, &QPushButton::clicked, this, &ContactForm::resetForm);
        buttonLayout->addWidget(resetBtn);
        
        buttonLayout->addStretch();
        
        QPushButton *submitBtn = new QPushButton("Send Message", this);
        submitBtn->setStyleSheet(
            "QPushButton {"
            "    background: #007bff;"
            "    color: white;"
            "    border: none;"
            "    border-radius: 6px;"
            "    padding: 12px 24px;"
            "    font-size: 16px;"
            "    font-weight: bold;"
            "}"
            "QPushButton:hover {"
            "    background: #0056b3;"
            "}"
        );
        connect(submitBtn, &QPushButton::clicked, this, &ContactForm::submitForm);
        buttonLayout->addWidget(submitBtn);
        
        mainLayout->addLayout(buttonLayout);
    }
    
    void setupConnections()
    {
        // Additional connections can be added here
    }

private:
    QLineEdit *nameInput;
    QLineEdit *emailInput;
    QLineEdit *phoneInput;
    QLineEdit *addressInput;
    QLineEdit *cityInput;
    QLineEdit *zipCodeInput;
    QComboBox *countryCombo;
    QTextEdit *messageInput;
};

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);
    
    ContactForm app;
    app.setWindowTitle("Contact Form - Inaccessible Tooltips");
    app.resize(1000, 800);
    app.show();
    
    return app.exec();
}

#include "InaccessibleTooltip.moc"

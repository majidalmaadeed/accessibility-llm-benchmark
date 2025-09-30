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
#include <QCheckBox>
#include <QMessageBox>

class RegistrationForm : public QMainWindow
{
    Q_OBJECT

public:
    RegistrationForm(QWidget *parent = nullptr) : QMainWindow(parent)
    {
        setupUI();
        setupConnections();
    }

private slots:
    void validateForm()
    {
        bool hasErrors = false;
        
        // COLOR-ONLY ERROR INDICATION - Invalid form field marked only with red border
        if (usernameInput->text().isEmpty()) {
            usernameInput->setStyleSheet(
                "QLineEdit {"
                "    padding: 12px;"
                "    border: 2px solid #dc3545;"  // COLOR-ONLY ERROR INDICATION - Red border only
                "    border-radius: 6px;"
                "    font-size: 16px;"
                "    min-width: 300px;"
                "}"
                "QLineEdit:focus {"
                "    border-color: #dc3545;"  // COLOR-ONLY ERROR INDICATION - Red border only
                "}"
            );
            hasErrors = true;
        } else {
            usernameInput->setStyleSheet(
                "QLineEdit {"
                "    padding: 12px;"
                "    border: 2px solid #28a745;"
                "    border-radius: 6px;"
                "    font-size: 16px;"
                "    min-width: 300px;"
                "}"
                "QLineEdit:focus {"
                "    border-color: #007bff;"
                "}"
            );
        }
        
        // COLOR-ONLY ERROR INDICATION - Invalid form field marked only with red border
        if (emailInput->text().isEmpty() || !emailInput->text().contains("@")) {
            emailInput->setStyleSheet(
                "QLineEdit {"
                "    padding: 12px;"
                "    border: 2px solid #dc3545;"  // COLOR-ONLY ERROR INDICATION - Red border only
                "    border-radius: 6px;"
                "    font-size: 16px;"
                "    min-width: 300px;"
                "}"
                "QLineEdit:focus {"
                "    border-color: #dc3545;"  // COLOR-ONLY ERROR INDICATION - Red border only
                "}"
            );
            hasErrors = true;
        } else {
            emailInput->setStyleSheet(
                "QLineEdit {"
                "    padding: 12px;"
                "    border: 2px solid #28a745;"
                "    border-radius: 6px;"
                "    font-size: 16px;"
                "    min-width: 300px;"
                "}"
                "QLineEdit:focus {"
                "    border-color: #007bff;"
                "}"
            );
        }
        
        // COLOR-ONLY ERROR INDICATION - Invalid form field marked only with red border
        if (passwordInput->text().length() < 8) {
            passwordInput->setStyleSheet(
                "QLineEdit {"
                "    padding: 12px;"
                "    border: 2px solid #dc3545;"  // COLOR-ONLY ERROR INDICATION - Red border only
                "    border-radius: 6px;"
                "    font-size: 16px;"
                "    min-width: 300px;"
                "}"
                "QLineEdit:focus {"
                "    border-color: #dc3545;"  // COLOR-ONLY ERROR INDICATION - Red border only
                "}"
            );
            hasErrors = true;
        } else {
            passwordInput->setStyleSheet(
                "QLineEdit {"
                "    padding: 12px;"
                "    border: 2px solid #28a745;"
                "    border-radius: 6px;"
                "    font-size: 16px;"
                "    min-width: 300px;"
                "}"
                "QLineEdit:focus {"
                "    border-color: #007bff;"
                "}"
            );
        }
        
        // COLOR-ONLY ERROR INDICATION - Invalid form field marked only with red border
        if (confirmPasswordInput->text() != passwordInput->text()) {
            confirmPasswordInput->setStyleSheet(
                "QLineEdit {"
                "    padding: 12px;"
                "    border: 2px solid #dc3545;"  // COLOR-ONLY ERROR INDICATION - Red border only
                "    border-radius: 6px;"
                "    font-size: 16px;"
                "    min-width: 300px;"
                "}"
                "QLineEdit:focus {"
                "    border-color: #dc3545;"  // COLOR-ONLY ERROR INDICATION - Red border only
                "}"
            );
            hasErrors = true;
        } else {
            confirmPasswordInput->setStyleSheet(
                "QLineEdit {"
                "    padding: 12px;"
                "    border: 2px solid #28a745;"
                "    border-radius: 6px;"
                "    font-size: 16px;"
                "    min-width: 300px;"
                "}"
                "QLineEdit:focus {"
                "    border-color: #007bff;"
                "}"
            );
        }
        
        // COLOR-ONLY ERROR INDICATION - Invalid form field marked only with red border
        if (firstNameInput->text().isEmpty()) {
            firstNameInput->setStyleSheet(
                "QLineEdit {"
                "    padding: 12px;"
                "    border: 2px solid #dc3545;"  // COLOR-ONLY ERROR INDICATION - Red border only
                "    border-radius: 6px;"
                "    font-size: 16px;"
                "    min-width: 300px;"
                "}"
                "QLineEdit:focus {"
                "    border-color: #dc3545;"  // COLOR-ONLY ERROR INDICATION - Red border only
                "}"
            );
            hasErrors = true;
        } else {
            firstNameInput->setStyleSheet(
                "QLineEdit {"
                "    padding: 12px;"
                "    border: 2px solid #28a745;"
                "    border-radius: 6px;"
                "    font-size: 16px;"
                "    min-width: 300px;"
                "}"
                "QLineEdit:focus {"
                "    border-color: #007bff;"
                "}"
            );
        }
        
        // COLOR-ONLY ERROR INDICATION - Invalid form field marked only with red border
        if (lastNameInput->text().isEmpty()) {
            lastNameInput->setStyleSheet(
                "QLineEdit {"
                "    padding: 12px;"
                "    border: 2px solid #dc3545;"  // COLOR-ONLY ERROR INDICATION - Red border only
                "    border-radius: 6px;"
                "    font-size: 16px;"
                "    min-width: 300px;"
                "}"
                "QLineEdit:focus {"
                "    border-color: #dc3545;"  // COLOR-ONLY ERROR INDICATION - Red border only
                "}"
            );
            hasErrors = true;
        } else {
            lastNameInput->setStyleSheet(
                "QLineEdit {"
                "    padding: 12px;"
                "    border: 2px solid #28a745;"
                "    border-radius: 6px;"
                "    font-size: 16px;"
                "    min-width: 300px;"
                "}"
                "QLineEdit:focus {"
                "    border-color: #007bff;"
                "}"
            );
        }
        
        // COLOR-ONLY ERROR INDICATION - Invalid form field marked only with red border
        if (phoneInput->text().isEmpty()) {
            phoneInput->setStyleSheet(
                "QLineEdit {"
                "    padding: 12px;"
                "    border: 2px solid #dc3545;"  // COLOR-ONLY ERROR INDICATION - Red border only
                "    border-radius: 6px;"
                "    font-size: 16px;"
                "    min-width: 300px;"
                "}"
                "QLineEdit:focus {"
                "    border-color: #dc3545;"  // COLOR-ONLY ERROR INDICATION - Red border only
                "}"
            );
            hasErrors = true;
        } else {
            phoneInput->setStyleSheet(
                "QLineEdit {"
                "    padding: 12px;"
                "    border: 2px solid #28a745;"
                "    border-radius: 6px;"
                "    font-size: 16px;"
                "    min-width: 300px;"
                "}"
                "QLineEdit:focus {"
                "    border-color: #007bff;"
                "}"
            );
        }
        
        // COLOR-ONLY ERROR INDICATION - Invalid form field marked only with red border
        if (countryCombo->currentIndex() == 0) {
            countryCombo->setStyleSheet(
                "QComboBox {"
                "    padding: 12px;"
                "    border: 2px solid #dc3545;"  // COLOR-ONLY ERROR INDICATION - Red border only
                "    border-radius: 6px;"
                "    font-size: 16px;"
                "    min-width: 300px;"
                "}"
                "QComboBox:focus {"
                "    border-color: #dc3545;"  // COLOR-ONLY ERROR INDICATION - Red border only
                "}"
            );
            hasErrors = true;
        } else {
            countryCombo->setStyleSheet(
                "QComboBox {"
                "    padding: 12px;"
                "    border: 2px solid #28a745;"
                "    border-radius: 6px;"
                "    font-size: 16px;"
                "    min-width: 300px;"
                "}"
                "QComboBox:focus {"
                "    border-color: #007bff;"
                "}"
            );
        }
        
        // COLOR-ONLY ERROR INDICATION - Invalid form field marked only with red border
        if (!termsCheckbox->isChecked()) {
            termsCheckbox->setStyleSheet(
                "QCheckBox {"
                "    font-size: 16px;"
                "    color: #dc3545;"  // COLOR-ONLY ERROR INDICATION - Red text only
                "    margin-right: 15px;"
                "    padding: 5px;"
                "}"
                "QCheckBox::indicator {"
                "    width: 20px;"
                "    height: 20px;"
                "    border: 2px solid #dc3545;"  // COLOR-ONLY ERROR INDICATION - Red border only
                "    border-radius: 4px;"
                "}"
            );
            hasErrors = true;
        } else {
            termsCheckbox->setStyleSheet(
                "QCheckBox {"
                "    font-size: 16px;"
                "    color: #333;"
                "    margin-right: 15px;"
                "    padding: 5px;"
                "}"
                "QCheckBox::indicator {"
                "    width: 20px;"
                "    height: 20px;"
                "    border: 2px solid #28a745;"
                "    border-radius: 4px;"
                "}"
            );
        }
        
        if (hasErrors) {
            QMessageBox::warning(this, "Validation Error", "Please fix the highlighted fields and try again.");
        } else {
            QMessageBox::information(this, "Success", "Registration completed successfully!");
        }
    }
    
    void resetForm()
    {
        usernameInput->clear();
        emailInput->clear();
        passwordInput->clear();
        confirmPasswordInput->clear();
        firstNameInput->clear();
        lastNameInput->clear();
        phoneInput->clear();
        countryCombo->setCurrentIndex(0);
        termsCheckbox->setChecked(false);
        
        // Reset all styles to default
        resetFieldStyles();
    }
    
    void resetFieldStyles()
    {
        QString defaultStyle = 
            "QLineEdit {"
            "    padding: 12px;"
            "    border: 2px solid #ddd;"
            "    border-radius: 6px;"
            "    font-size: 16px;"
            "    min-width: 300px;"
            "}"
            "QLineEdit:focus {"
            "    border-color: #007bff;"
            "}";
        
        usernameInput->setStyleSheet(defaultStyle);
        emailInput->setStyleSheet(defaultStyle);
        passwordInput->setStyleSheet(defaultStyle);
        confirmPasswordInput->setStyleSheet(defaultStyle);
        firstNameInput->setStyleSheet(defaultStyle);
        lastNameInput->setStyleSheet(defaultStyle);
        phoneInput->setStyleSheet(defaultStyle);
        
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
        
        termsCheckbox->setStyleSheet(
            "QCheckBox {"
            "    font-size: 16px;"
            "    color: #333;"
            "    margin-right: 15px;"
            "    padding: 5px;"
            "}"
            "QCheckBox::indicator {"
            "    width: 20px;"
            "    height: 20px;"
            "    border: 2px solid #ddd;"
            "    border-radius: 4px;"
            "}"
        );
    }

private:
    void setupUI()
    {
        QWidget *centralWidget = new QWidget(this);
        setCentralWidget(centralWidget);
        
        QVBoxLayout *mainLayout = new QVBoxLayout(centralWidget);
        
        // Header
        QHBoxLayout *headerLayout = new QHBoxLayout();
        
        QLabel *titleLabel = new QLabel("Create Account", this);
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
        
        QPushButton *loginBtn = new QPushButton("Already have an account? Sign In", this);
        loginBtn->setStyleSheet(
            "QPushButton {"
            "    background: transparent;"
            "    color: #007bff;"
            "    border: none;"
            "    font-size: 16px;"
            "    text-decoration: underline;"
            "    padding: 10px;"
            "}"
            "QPushButton:hover {"
            "    color: #0056b3;"
            "}"
        );
        headerLayout->addWidget(loginBtn);
        
        mainLayout->addLayout(headerLayout);
        
        // Form content
        QHBoxLayout *formLayout = new QHBoxLayout();
        
        // Left column
        QVBoxLayout *leftColumn = new QVBoxLayout();
        
        QLabel *formTitle = new QLabel("Account Information", this);
        formTitle->setStyleSheet(
            "QLabel {"
            "    font-size: 20px;"
            "    font-weight: bold;"
            "    color: #333;"
            "    margin-bottom: 20px;"
            "}"
        );
        leftColumn->addWidget(formTitle);
        
        // Username field
        QHBoxLayout *usernameLayout = new QHBoxLayout();
        
        QLabel *usernameLabel = new QLabel("Username *", this);
        usernameLabel->setStyleSheet(
            "QLabel {"
            "    font-size: 16px;"
            "    font-weight: bold;"
            "    color: #333;"
            "    margin-right: 15px;"
            "    min-width: 120px;"
            "}"
        );
        usernameLayout->addWidget(usernameLabel);
        
        usernameInput = new QLineEdit(this);
        usernameInput->setPlaceholderText("Choose a username");
        usernameInput->setStyleSheet(
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
        usernameLayout->addWidget(usernameInput);
        
        leftColumn->addLayout(usernameLayout);
        
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
        
        leftColumn->addLayout(emailLayout);
        
        // Password field
        QHBoxLayout *passwordLayout = new QHBoxLayout();
        
        QLabel *passwordLabel = new QLabel("Password *", this);
        passwordLabel->setStyleSheet(
            "QLabel {"
            "    font-size: 16px;"
            "    font-weight: bold;"
            "    color: #333;"
            "    margin-right: 15px;"
            "    min-width: 120px;"
            "}"
        );
        passwordLayout->addWidget(passwordLabel);
        
        passwordInput = new QLineEdit(this);
        passwordInput->setPlaceholderText("Create a password (min 8 characters)");
        passwordInput->setEchoMode(QLineEdit::Password);
        passwordInput->setStyleSheet(
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
        passwordLayout->addWidget(passwordInput);
        
        leftColumn->addLayout(passwordLayout);
        
        // Confirm Password field
        QHBoxLayout *confirmPasswordLayout = new QHBoxLayout();
        
        QLabel *confirmPasswordLabel = new QLabel("Confirm Password *", this);
        confirmPasswordLabel->setStyleSheet(
            "QLabel {"
            "    font-size: 16px;"
            "    font-weight: bold;"
            "    color: #333;"
            "    margin-right: 15px;"
            "    min-width: 120px;"
            "}"
        );
        confirmPasswordLayout->addWidget(confirmPasswordLabel);
        
        confirmPasswordInput = new QLineEdit(this);
        confirmPasswordInput->setPlaceholderText("Confirm your password");
        confirmPasswordInput->setEchoMode(QLineEdit::Password);
        confirmPasswordInput->setStyleSheet(
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
        confirmPasswordLayout->addWidget(confirmPasswordInput);
        
        leftColumn->addLayout(confirmPasswordLayout);
        
        formLayout->addLayout(leftColumn);
        
        // Right column
        QVBoxLayout *rightColumn = new QVBoxLayout();
        
        QLabel *personalTitle = new QLabel("Personal Information", this);
        personalTitle->setStyleSheet(
            "QLabel {"
            "    font-size: 20px;"
            "    font-weight: bold;"
            "    color: #333;"
            "    margin-bottom: 20px;"
            "}"
        );
        rightColumn->addWidget(personalTitle);
        
        // First Name field
        QHBoxLayout *firstNameLayout = new QHBoxLayout();
        
        QLabel *firstNameLabel = new QLabel("First Name *", this);
        firstNameLabel->setStyleSheet(
            "QLabel {"
            "    font-size: 16px;"
            "    font-weight: bold;"
            "    color: #333;"
            "    margin-right: 15px;"
            "    min-width: 120px;"
            "}"
        );
        firstNameLayout->addWidget(firstNameLabel);
        
        firstNameInput = new QLineEdit(this);
        firstNameInput->setPlaceholderText("Enter your first name");
        firstNameInput->setStyleSheet(
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
        firstNameLayout->addWidget(firstNameInput);
        
        rightColumn->addLayout(firstNameLayout);
        
        // Last Name field
        QHBoxLayout *lastNameLayout = new QHBoxLayout();
        
        QLabel *lastNameLabel = new QLabel("Last Name *", this);
        lastNameLabel->setStyleSheet(
            "QLabel {"
            "    font-size: 16px;"
            "    font-weight: bold;"
            "    color: #333;"
            "    margin-right: 15px;"
            "    min-width: 120px;"
            "}"
        );
        lastNameLayout->addWidget(lastNameLabel);
        
        lastNameInput = new QLineEdit(this);
        lastNameInput->setPlaceholderText("Enter your last name");
        lastNameInput->setStyleSheet(
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
        lastNameLayout->addWidget(lastNameInput);
        
        rightColumn->addLayout(lastNameLayout);
        
        // Phone field
        QHBoxLayout *phoneLayout = new QHBoxLayout();
        
        QLabel *phoneLabel = new QLabel("Phone Number *", this);
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
        
        rightColumn->addLayout(phoneLayout);
        
        // Country field
        QHBoxLayout *countryLayout = new QHBoxLayout();
        
        QLabel *countryLabel = new QLabel("Country *", this);
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
        
        rightColumn->addLayout(countryLayout);
        
        // Terms checkbox
        QHBoxLayout *termsLayout = new QHBoxLayout();
        
        termsCheckbox = new QCheckBox("I agree to the Terms of Service and Privacy Policy", this);
        termsCheckbox->setStyleSheet(
            "QCheckBox {"
            "    font-size: 16px;"
            "    color: #333;"
            "    margin-right: 15px;"
            "    padding: 5px;"
            "}"
            "QCheckBox::indicator {"
            "    width: 20px;"
            "    height: 20px;"
            "    border: 2px solid #ddd;"
            "    border-radius: 4px;"
            "}"
        );
        termsLayout->addWidget(termsCheckbox);
        
        rightColumn->addLayout(termsLayout);
        
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
        connect(resetBtn, &QPushButton::clicked, this, &RegistrationForm::resetForm);
        buttonLayout->addWidget(resetBtn);
        
        buttonLayout->addStretch();
        
        QPushButton *submitBtn = new QPushButton("Create Account", this);
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
        connect(submitBtn, &QPushButton::clicked, this, &RegistrationForm::validateForm);
        buttonLayout->addWidget(submitBtn);
        
        mainLayout->addLayout(buttonLayout);
    }
    
    void setupConnections()
    {
        // Additional connections can be added here
    }

private:
    QLineEdit *usernameInput;
    QLineEdit *emailInput;
    QLineEdit *passwordInput;
    QLineEdit *confirmPasswordInput;
    QLineEdit *firstNameInput;
    QLineEdit *lastNameInput;
    QLineEdit *phoneInput;
    QComboBox *countryCombo;
    QCheckBox *termsCheckbox;
};

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);
    
    RegistrationForm app;
    app.setWindowTitle("Registration Form - Color-Only Errors");
    app.resize(1000, 800);
    app.show();
    
    return app.exec();
}

#include "ColorOnlyErrorIndication.moc"

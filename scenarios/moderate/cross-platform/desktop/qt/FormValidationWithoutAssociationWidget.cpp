#include "FormValidationWithoutAssociationWidget.h"
#include <QMessageBox>
#include <QApplication>
FormValidationWithoutAssociationWidget::FormValidationWithoutAssociationWidget(QWidget *parent)
    : QWidget(parent)
    , m_isSubmitting(false)
    , m_loginTimer(new QTimer(this))
{
    setupUI();
    // Connect timer for login simulation
    connect(m_loginTimer, &QTimer::timeout, this, &FormValidationWithoutAssociationWidget::loginComplete);
}
void FormValidationWithoutAssociationWidget::setupUI()
{
    // Main layout
    QVBoxLayout *mainLayout = new QVBoxLayout(this);
    mainLayout->setSpacing(20);
    mainLayout->setContentsMargins(20, 20, 20, 20);
    // Main content card
    QFrame *mainCard = new QFrame();
    mainCard->setFrameStyle(QFrame::Box | QFrame::Raised);
    mainCard->setLineWidth(1);
    mainCard->setStyleSheet(
        "QFrame {"
        "    background-color: #f8f9fa;"
        "    border: 1px solid #dee2e6;"
        "    border-radius: 8px;"
        "    padding: 20px;"
        "}"
    );
    QVBoxLayout *cardLayout = new QVBoxLayout(mainCard);
    cardLayout->setSpacing(20);
    // Title
        "    font-size: 24px;"
        "    font-weight: bold;"
        "    color: #333333;"
        "    margin-bottom: 10px;"
        "}"
    );
    // Description
        "    color: #666666;"
        "    font-size: 16px;"
        "    margin-bottom: 20px;"
        "}"
    );
    // Login form
    QFormLayout *formLayout = new QFormLayout();
    formLayout->setSpacing(20);
    // Username field
        "    font-weight: bold;"
        "    color: #333333;"
        "}"
    );
    m_usernameInput = new QLineEdit();
    m_usernameInput->setPlaceholderText("Enter username");
    m_usernameInput->setStyleSheet(
        "QLineEdit {"
        "    padding: 12px;"
        "    border: 2px solid #ddd;"
        "    border-radius: 4px;"
        "    font-size: 16px;"
        "}"
    );
    connect(m_usernameInput, &QLineEdit::textChanged, this, &FormValidationWithoutAssociationWidget::onUsernameChanged);
    m_usernameError->setStyleSheet(
        "    color: #dc3545;"
        "    font-weight: bold;"
        "    font-size: 14px;"
        "}"
    );
    m_usernameError->setVisible(false);
    formLayout->addRow("", m_usernameError);
    // Password field
        "    font-weight: bold;"
        "    color: #333333;"
        "}"
    );
    m_passwordInput = new QLineEdit();
    m_passwordInput->setPlaceholderText("Enter password");
    m_passwordInput->setEchoMode(QLineEdit::Password);
    m_passwordInput->setStyleSheet(
        "QLineEdit {"
        "    padding: 12px;"
        "    border: 2px solid #ddd;"
        "    border-radius: 4px;"
        "    font-size: 16px;"
        "}"
    );
    connect(m_passwordInput, &QLineEdit::textChanged, this, &FormValidationWithoutAssociationWidget::onPasswordChanged);
    m_passwordError->setStyleSheet(
        "    color: #dc3545;"
        "    font-weight: bold;"
        "    font-size: 14px;"
        "}"
    );
    m_passwordError->setVisible(false);
    formLayout->addRow("", m_passwordError);
    // Generic Error Message - NOT ASSOCIATED WITH SPECIFIC FIELDS
    m_genericErrorFrame = new QFrame();
    m_genericErrorFrame->setStyleSheet(
        "QFrame {"
        "    background-color: #f8d7da;"
        "    border: 1px solid #f5c6cb;"
        "    border-radius: 4px;"
        "    padding: 10px;"
        "}"
    );
    m_genericErrorFrame->setVisible(false);
    QHBoxLayout *genericErrorLayout = new QHBoxLayout(m_genericErrorFrame);
    genericErrorLayout->setContentsMargins(10, 10, 10, 10);
    errorIcon->setStyleSheet(
        "    color: #dc3545;"
        "    font-size: 16px;"
        "    font-weight: bold;"
        "}"
    );
    genericErrorLayout->addWidget(errorIcon);
    m_genericErrorText->setStyleSheet(
        "    color: #dc3545;"
        "    font-weight: bold;"
        "    font-size: 12px;"
        "}"
    );
    genericErrorLayout->addWidget(m_genericErrorText);
    formLayout->addRow("", m_genericErrorFrame);
    // Login button
    m_loginButton = new QPushButton("Login");
    m_loginButton->setStyleSheet(
        "QPushButton {"
        "    background-color: #007bff;"
        "    color: white;"
        "    border: none;"
        "    border-radius: 4px;"
        "    padding: 15px;"
        "    font-size: 16px;"
        "    font-weight: bold;"
        "}"
        "QPushButton:hover {"
        "    background-color: #0056b3;"
        "}"
        "QPushButton:disabled {"
        "    background-color: #6c757d;"
        "    cursor: not-allowed;"
        "}"
    );
    connect(m_loginButton, &QPushButton::clicked, this, &FormValidationWithoutAssociationWidget::onLoginClicked);
    formLayout->addRow("", m_loginButton);
    cardLayout->addLayout(formLayout);
    mainLayout->addWidget(mainCard);
    QFrame *infoFrame = new QFrame();
    infoFrame->setFrameStyle(QFrame::Box | QFrame::Raised);
    infoFrame->setLineWidth(1);
    infoFrame->setStyleSheet(
        "QFrame {"
        "    background-color: #e9ecef;"
        "    border: 1px solid #dee2e6;"
        "    border-radius: 4px;"
        "    padding: 20px;"
        "}"
    );
    QVBoxLayout *infoLayout = new QVBoxLayout(infoFrame);
    infoLayout->setSpacing(15);
        "• Generic error: Generic error message doesn't specify which fields have issues\n"
    );
    issuesText->setStyleSheet(
        "    color: #666666;"
        "    font-size: 12px;"
        "}"
    );
    issuesText->setWordWrap(true);
    infoLayout->addWidget(issuesText);
    // How to Fix
    fixTitle->setStyleSheet(
        "    font-size: 16px;"
        "    font-weight: bold;"
        "    color: #333333;"
        "}"
    );
    infoLayout->addWidget(fixTitle);
        "• Use specific error messages for each field\n"
    );
    fixText->setStyleSheet(
        "    color: #666666;"
        "    font-size: 12px;"
        "}"
    );
    fixText->setWordWrap(true);
    infoLayout->addWidget(fixText);
    mainLayout->addWidget(infoFrame);
}
{
    // Basic setup only
    m_usernameInput->setAccessibleName("Username input field");
    m_passwordInput->setAccessibleName("Password input field");
    m_loginButton->setAccessibleName("Login button");
}
void FormValidationWithoutAssociationWidget::onUsernameChanged()
{
    clearFieldError("username");
}
void FormValidationWithoutAssociationWidget::onPasswordChanged()
{
    clearFieldError("password");
}
void FormValidationWithoutAssociationWidget::onLoginClicked()
{
    if (m_isSubmitting) return;
    clearAllErrors();
    QString username = m_usernameInput->text().trimmed();
    QString password = m_passwordInput->text();
    bool hasErrors = false;
    // Validate username
    if (username.isEmpty()) {
        showFieldError("username", "Username is required");
        hasErrors = true;
    } else if (username.length() < 3) {
        showFieldError("username", "Username must be at least 3 characters");
        hasErrors = true;
    }
    // Validate password
    if (password.isEmpty()) {
        showFieldError("password", "Password is required");
        hasErrors = true;
    } else if (password.length() < 8) {
        showFieldError("password", "Password must be at least 8 characters");
        hasErrors = true;
    }
    if (hasErrors) {
        // Show generic error message - NOT ASSOCIATED WITH SPECIFIC FIELDS
        showGenericError("Please fill in all required fields.");
        return;
    }
    // Simulate login process
    m_isSubmitting = true;
    m_loginButton->setText("Logging in...");
    m_loginButton->setEnabled(false);
    // Simulate API call
    m_loginTimer->setSingleShot(true);
    m_loginTimer->start(2000);
}
void FormValidationWithoutAssociationWidget::loginComplete()
{
    m_isSubmitting = false;
    m_loginButton->setText("Login");
    m_loginButton->setEnabled(true);
    // Show success message
    QMessageBox::information(this, "Success", "Login successful!");
}
void FormValidationWithoutAssociationWidget::clearAllErrors()
{
    m_usernameError->setVisible(false);
    m_passwordError->setVisible(false);
    m_genericErrorFrame->setVisible(false);
    // Reset field borders
    m_usernameInput->setStyleSheet(
        "QLineEdit {"
        "    padding: 12px;"
        "    border: 2px solid #ddd;"
        "    border-radius: 4px;"
        "    font-size: 16px;"
        "}"
    );
    m_passwordInput->setStyleSheet(
        "QLineEdit {"
        "    padding: 12px;"
        "    border: 2px solid #ddd;"
        "    border-radius: 4px;"
        "    font-size: 16px;"
        "}"
    );
}
void FormValidationWithoutAssociationWidget::clearFieldError(const QString &fieldName)
{
    if (fieldName == "username") {
        m_usernameError->setVisible(false);
        m_usernameInput->setStyleSheet(
            "QLineEdit {"
            "    padding: 12px;"
            "    border: 2px solid #ddd;"
            "    border-radius: 4px;"
            "    font-size: 16px;"
            "}"
        );
    } else if (fieldName == "password") {
        m_passwordError->setVisible(false);
        m_passwordInput->setStyleSheet(
            "QLineEdit {"
            "    padding: 12px;"
            "    border: 2px solid #ddd;"
            "    border-radius: 4px;"
            "    font-size: 16px;"
            "}"
        );
    }
}
void FormValidationWithoutAssociationWidget::showFieldError(const QString &fieldName, const QString &message)
{
    if (fieldName == "username") {
        m_usernameError->setText(message);
        m_usernameError->setVisible(true);
        m_usernameInput->setStyleSheet(
            "QLineEdit {"
            "    padding: 12px;"
            "    border: 2px solid #dc3545;"
            "    border-radius: 4px;"
            "    font-size: 16px;"
            "}"
        );
    } else if (fieldName == "password") {
        m_passwordError->setText(message);
        m_passwordError->setVisible(true);
        m_passwordInput->setStyleSheet(
            "QLineEdit {"
            "    padding: 12px;"
            "    border: 2px solid #dc3545;"
            "    border-radius: 4px;"
            "    font-size: 16px;"
            "}"
        );
    }
}
void FormValidationWithoutAssociationWidget::showGenericError(const QString &message)
{
    m_genericErrorText->setText(message);
    m_genericErrorFrame->setVisible(true);
}

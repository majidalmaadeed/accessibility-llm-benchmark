#include "wizardwidget.h"
#include <QApplication>
#include <QMessageBox>
#include <QValidator>
#include <QRegularExpression>
#include <QRegularExpressionValidator>

WizardWidget::WizardWidget(QWidget *parent)
    : QWidget(parent)
    , m_stackedWidget(nullptr)
    , m_previousButton(nullptr)
    , m_nextButton(nullptr)
    , m_finishButton(nullptr)
    , m_cancelButton(nullptr)
    , m_resetButton(nullptr)
    , m_progressBar(nullptr)
    , m_stepLabel(nullptr)
    , m_currentStep(0)
    , m_totalSteps(5)
    , m_firstNameEdit(nullptr)
    , m_lastNameEdit(nullptr)
    , m_emailEdit(nullptr)
    , m_phoneEdit(nullptr)
    , m_countryCombo(nullptr)
    , m_languageCombo(nullptr)
    , m_themeGroup(nullptr)
    , m_lightThemeRadio(nullptr)
    , m_darkThemeRadio(nullptr)
    , m_notificationGroup(nullptr)
    , m_emailNotificationsCheck(nullptr)
    , m_smsNotificationsCheck(nullptr)
    , m_pushNotificationsCheck(nullptr)
    , m_volumeSlider(nullptr)
    , m_fontSizeSpin(nullptr)
    , m_usernameEdit(nullptr)
    , m_passwordEdit(nullptr)
    , m_confirmPasswordEdit(nullptr)
    , m_termsCheck(nullptr)
    , m_privacyCheck(nullptr)
    , m_newsletterCheck(nullptr)
    , m_bioEdit(nullptr)
    , m_industryCombo(nullptr)
    , m_experienceCombo(nullptr)
    , m_skillsList(nullptr)
    , m_websiteEdit(nullptr)
    , m_birthDateEdit(nullptr)
    , m_reviewLabel(nullptr)
    , m_reviewText(nullptr)
{
    setupUI();
    setupSteps();
    setupNavigation();
    showStep(0);
}

void WizardWidget::setupUI()
{
    QVBoxLayout *mainLayout = new QVBoxLayout(this);
    mainLayout->setContentsMargins(20, 20, 20, 20);
    mainLayout->setSpacing(15);
    
    // Title
    QLabel *titleLabel = new QLabel("Multi-Step Wizard", this);
    titleLabel->setStyleSheet(
        "QLabel {"
        "    font-size: 24px;"
        "    font-weight: bold;"
        "    color: white;"
        "    margin-bottom: 10px;"
        "}"
    );
    mainLayout->addWidget(titleLabel);
    
    // Progress bar
    m_progressBar = new QProgressBar(this);
    m_progressBar->setRange(0, m_totalSteps - 1);
    m_progressBar->setValue(0);
    m_progressBar->setStyleSheet(
        "QProgressBar {"
        "    border: 2px solid #3a3a3a;"
        "    border-radius: 8px;"
        "    text-align: center;"
        "    background-color: #2b2b2b;"
        "    color: white;"
        "    font-weight: bold;"
        "}"
        "QProgressBar::chunk {"
        "    background-color: #61dafb;"
        "    border-radius: 6px;"
        "}"
    );
    mainLayout->addWidget(m_progressBar);
    
    // Step label
    m_stepLabel = new QLabel("Step 1 of 5: Personal Information", this);
    m_stepLabel->setStyleSheet(
        "QLabel {"
        "    font-size: 16px;"
        "    color: #61dafb;"
        "    font-weight: bold;"
        "    margin: 10px 0;"
        "}"
    );
    mainLayout->addWidget(m_stepLabel);
    
    // Stacked widget for steps
    m_stackedWidget = new QStackedWidget(this);
    m_stackedWidget->setStyleSheet(
        "QStackedWidget {"
        "    background-color: #1e1e1e;"
        "    border: 1px solid #3a3a3a;"
        "    border-radius: 8px;"
        "    padding: 20px;"
        "}"
    );
    mainLayout->addWidget(m_stackedWidget, 1);
    
    // Navigation buttons
    QHBoxLayout *navLayout = new QHBoxLayout();
    navLayout->setSpacing(10);
    
    m_previousButton = new QPushButton("Previous", this);
    m_previousButton->setStyleSheet(
        "QPushButton {"
        "    background-color: #6c757d;"
        "    color: white;"
        "    border: none;"
        "    padding: 12px 24px;"
        "    border-radius: 6px;"
        "    font-weight: bold;"
        "    font-size: 14px;"
        "    min-width: 100px;"
        "}"
        "QPushButton:hover {"
        "    background-color: #5a6268;"
        "}"
        "QPushButton:disabled {"
        "    background-color: #3a3a3a;"
        "    color: #666;"
        "}"
    );
    
    m_nextButton = new QPushButton("Next", this);
    m_nextButton->setStyleSheet(
        "QPushButton {"
        "    background-color: #61dafb;"
        "    color: black;"
        "    border: none;"
        "    padding: 12px 24px;"
        "    border-radius: 6px;"
        "    font-weight: bold;"
        "    font-size: 14px;"
        "    min-width: 100px;"
        "}"
        "QPushButton:hover {"
        "    background-color: #4fa8d8;"
        "}"
    );
    
    m_finishButton = new QPushButton("Finish", this);
    m_finishButton->setStyleSheet(m_nextButton->styleSheet());
    m_finishButton->setVisible(false);
    
    m_cancelButton = new QPushButton("Cancel", this);
    m_cancelButton->setStyleSheet(m_previousButton->styleSheet());
    
    m_resetButton = new QPushButton("Reset", this);
    m_resetButton->setStyleSheet(m_previousButton->styleSheet());
    
    navLayout->addWidget(m_previousButton);
    navLayout->addStretch();
    navLayout->addWidget(m_resetButton);
    navLayout->addWidget(m_cancelButton);
    navLayout->addWidget(m_nextButton);
    navLayout->addWidget(m_finishButton);
    
    mainLayout->addLayout(navLayout);
    
    // Connect signals
    connect(m_previousButton, &QPushButton::clicked, this, &WizardWidget::previousStep);
    connect(m_nextButton, &QPushButton::clicked, this, &WizardWidget::nextStep);
    connect(m_finishButton, &QPushButton::clicked, this, &WizardWidget::finishWizard);
    connect(m_cancelButton, &QPushButton::clicked, this, &WizardWidget::cancelWizard);
    connect(m_resetButton, &QPushButton::clicked, this, &WizardWidget::resetWizard);
}

void WizardWidget::setupSteps()
{
    setupStep1();
    setupStep2();
    setupStep3();
    setupStep4();
    setupStep5();
}

void WizardWidget::setupStep1()
{
    QWidget *step1 = new QWidget();
    QFormLayout *layout = new QFormLayout(step1);
    layout->setSpacing(15);
    
    // Personal Information
    QGroupBox *personalGroup = new QGroupBox("Personal Information");
    personalGroup->setStyleSheet(
        "QGroupBox {"
        "    font-weight: bold;"
        "    color: white;"
        "    border: 2px solid #3a3a3a;"
        "    border-radius: 8px;"
        "    margin-top: 10px;"
        "    padding-top: 10px;"
        "}"
        "QGroupBox::title {"
        "    subcontrol-origin: margin;"
        "    left: 10px;"
        "    padding: 0 5px 0 5px;"
        "}"
    );
    
    QFormLayout *personalLayout = new QFormLayout(personalGroup);
    personalLayout->setSpacing(10);
    
    m_firstNameEdit = new QLineEdit();
    m_firstNameEdit->setStyleSheet(
        "QLineEdit {"
        "    padding: 10px 12px;"
        "    border: 1px solid #555;"
        "    border-radius: 4px;"
        "    background-color: #2b2b2b;"
        "    color: white;"
        "    font-size: 14px;"
        "}"
        "QLineEdit:focus {"
        "    border-color: #61dafb;"
        "}"
    );
    personalLayout->addRow("First Name:", m_firstNameEdit);
    
    m_lastNameEdit = new QLineEdit();
    m_lastNameEdit->setStyleSheet(m_firstNameEdit->styleSheet());
    personalLayout->addRow("Last Name:", m_lastNameEdit);
    
    m_emailEdit = new QLineEdit();
    m_emailEdit->setStyleSheet(m_firstNameEdit->styleSheet());
    m_emailEdit->setPlaceholderText("example@email.com");
    personalLayout->addRow("Email:", m_emailEdit);
    
    m_phoneEdit = new QLineEdit();
    m_phoneEdit->setStyleSheet(m_firstNameEdit->styleSheet());
    m_phoneEdit->setPlaceholderText("+1 (555) 123-4567");
    personalLayout->addRow("Phone:", m_phoneEdit);
    
    m_countryCombo = new QComboBox();
    m_countryCombo->addItems({"United States", "Canada", "United Kingdom", "Germany", "France", "Japan", "Australia"});
    m_countryCombo->setStyleSheet(
        "QComboBox {"
        "    padding: 10px 12px;"
        "    border: 1px solid #555;"
        "    border-radius: 4px;"
        "    background-color: #2b2b2b;"
        "    color: white;"
        "    font-size: 14px;"
        "}"
        "QComboBox::drop-down {"
        "    border: none;"
        "}"
        "QComboBox::down-arrow {"
        "    image: none;"
        "    border-left: 5px solid transparent;"
        "    border-right: 5px solid transparent;"
        "    border-top: 5px solid white;"
        "    margin-right: 10px;"
        "}"
        "QComboBox QAbstractItemView {"
        "    background-color: #2b2b2b;"
        "    color: white;"
        "    border: 1px solid #555;"
        "    selection-background-color: #404040;"
        "}"
    );
    personalLayout->addRow("Country:", m_countryCombo);
    
    m_languageCombo = new QComboBox();
    m_languageCombo->addItems({"English", "Spanish", "French", "German", "Japanese", "Chinese"});
    m_languageCombo->setStyleSheet(m_countryCombo->styleSheet());
    personalLayout->addRow("Language:", m_languageCombo);
    
    layout->addWidget(personalGroup);
    
    m_stackedWidget->addWidget(step1);
}

void WizardWidget::setupStep2()
{
    QWidget *step2 = new QWidget();
    QVBoxLayout *layout = new QVBoxLayout(step2);
    layout->setSpacing(20);
    
    // Theme Selection
    QGroupBox *themeGroup = new QGroupBox("Theme Preference");
    themeGroup->setStyleSheet(
        "QGroupBox {"
        "    font-weight: bold;"
        "    color: white;"
        "    border: 2px solid #3a3a3a;"
        "    border-radius: 8px;"
        "    margin-top: 10px;"
        "    padding-top: 10px;"
        "}"
        "QGroupBox::title {"
        "    subcontrol-origin: margin;"
        "    left: 10px;"
        "    padding: 0 5px 0 5px;"
        "}"
    );
    
    QVBoxLayout *themeLayout = new QVBoxLayout(themeGroup);
    
    m_themeGroup = new QButtonGroup(this);
    m_lightThemeRadio = new QRadioButton("Light Theme");
    m_darkThemeRadio = new QRadioButton("Dark Theme");
    
    m_lightThemeRadio->setStyleSheet(
        "QRadioButton {"
        "    color: white;"
        "    font-size: 14px;"
        "    spacing: 10px;"
        "}"
        "QRadioButton::indicator {"
        "    width: 18px;"
        "    height: 18px;"
        "}"
        "QRadioButton::indicator:unchecked {"
        "    border: 2px solid #555;"
        "    background-color: #2b2b2b;"
        "    border-radius: 9px;"
        "}"
        "QRadioButton::indicator:checked {"
        "    border: 2px solid #61dafb;"
        "    background-color: #61dafb;"
        "    border-radius: 9px;"
        "}"
    );
    
    m_darkThemeRadio->setStyleSheet(m_lightThemeRadio->styleSheet());
    m_darkThemeRadio->setChecked(true);
    
    m_themeGroup->addButton(m_lightThemeRadio, 0);
    m_themeGroup->addButton(m_darkThemeRadio, 1);
    
    themeLayout->addWidget(m_lightThemeRadio);
    themeLayout->addWidget(m_darkThemeRadio);
    
    // Notification Preferences
    QGroupBox *notificationGroup = new QGroupBox("Notification Preferences");
    notificationGroup->setStyleSheet(themeGroup->styleSheet());
    
    QVBoxLayout *notificationLayout = new QVBoxLayout(notificationGroup);
    
    m_emailNotificationsCheck = new QCheckBox("Email Notifications");
    m_smsNotificationsCheck = new QCheckBox("SMS Notifications");
    m_pushNotificationsCheck = new QCheckBox("Push Notifications");
    
    QString checkBoxStyle = 
        "QCheckBox {"
        "    color: white;"
        "    font-size: 14px;"
        "    spacing: 10px;"
        "}"
        "QCheckBox::indicator {"
        "    width: 18px;"
        "    height: 18px;"
        "}"
        "QCheckBox::indicator:unchecked {"
        "    border: 2px solid #555;"
        "    background-color: #2b2b2b;"
        "    border-radius: 3px;"
        "}"
        "QCheckBox::indicator:checked {"
        "    border: 2px solid #61dafb;"
        "    background-color: #61dafb;"
        "    border-radius: 3px;"
        "}";
    
    m_emailNotificationsCheck->setStyleSheet(checkBoxStyle);
    m_smsNotificationsCheck->setStyleSheet(checkBoxStyle);
    m_pushNotificationsCheck->setStyleSheet(checkBoxStyle);
    m_pushNotificationsCheck->setChecked(true);
    
    notificationLayout->addWidget(m_emailNotificationsCheck);
    notificationLayout->addWidget(m_smsNotificationsCheck);
    notificationLayout->addWidget(m_pushNotificationsCheck);
    
    // Volume and Font Size
    QGroupBox *preferencesGroup = new QGroupBox("Additional Preferences");
    preferencesGroup->setStyleSheet(themeGroup->styleSheet());
    
    QFormLayout *preferencesLayout = new QFormLayout(preferencesGroup);
    
    m_volumeSlider = new QSlider(Qt::Horizontal);
    m_volumeSlider->setRange(0, 100);
    m_volumeSlider->setValue(50);
    m_volumeSlider->setStyleSheet(
        "QSlider::groove:horizontal {"
        "    border: 1px solid #555;"
        "    height: 8px;"
        "    background: #2b2b2b;"
        "    border-radius: 4px;"
        "}"
        "QSlider::handle:horizontal {"
        "    background: #61dafb;"
        "    border: 1px solid #61dafb;"
        "    width: 18px;"
        "    margin: -5px 0;"
        "    border-radius: 9px;"
        "}"
        "QSlider::handle:horizontal:hover {"
        "    background: #4fa8d8;"
        "}"
    );
    preferencesLayout->addRow("Volume:", m_volumeSlider);
    
    m_fontSizeSpin = new QSpinBox();
    m_fontSizeSpin->setRange(8, 24);
    m_fontSizeSpin->setValue(12);
    m_fontSizeSpin->setStyleSheet(
        "QSpinBox {"
        "    padding: 8px 12px;"
        "    border: 1px solid #555;"
        "    border-radius: 4px;"
        "    background-color: #2b2b2b;"
        "    color: white;"
        "    font-size: 14px;"
        "}"
    );
    preferencesLayout->addRow("Font Size:", m_fontSizeSpin);
    
    layout->addWidget(themeGroup);
    layout->addWidget(notificationGroup);
    layout->addWidget(preferencesGroup);
    
    m_stackedWidget->addWidget(step2);
}

void WizardWidget::setupStep3()
{
    QWidget *step3 = new QWidget();
    QFormLayout *layout = new QFormLayout(step3);
    layout->setSpacing(15);
    
    // Account Settings
    QGroupBox *accountGroup = new QGroupBox("Account Settings");
    accountGroup->setStyleSheet(
        "QGroupBox {"
        "    font-weight: bold;"
        "    color: white;"
        "    border: 2px solid #3a3a3a;"
        "    border-radius: 8px;"
        "    margin-top: 10px;"
        "    padding-top: 10px;"
        "}"
        "QGroupBox::title {"
        "    subcontrol-origin: margin;"
        "    left: 10px;"
        "    padding: 0 5px 0 5px;"
        "}"
    );
    
    QFormLayout *accountLayout = new QFormLayout(accountGroup);
    accountLayout->setSpacing(10);
    
    m_usernameEdit = new QLineEdit();
    m_usernameEdit->setStyleSheet(
        "QLineEdit {"
        "    padding: 10px 12px;"
        "    border: 1px solid #555;"
        "    border-radius: 4px;"
        "    background-color: #2b2b2b;"
        "    color: white;"
        "    font-size: 14px;"
        "}"
        "QLineEdit:focus {"
        "    border-color: #61dafb;"
        "}"
    );
    accountLayout->addRow("Username:", m_usernameEdit);
    
    m_passwordEdit = new QLineEdit();
    m_passwordEdit->setEchoMode(QLineEdit::Password);
    m_passwordEdit->setStyleSheet(m_usernameEdit->styleSheet());
    accountLayout->addRow("Password:", m_passwordEdit);
    
    m_confirmPasswordEdit = new QLineEdit();
    m_confirmPasswordEdit->setEchoMode(QLineEdit::Password);
    m_confirmPasswordEdit->setStyleSheet(m_usernameEdit->styleSheet());
    accountLayout->addRow("Confirm Password:", m_confirmPasswordEdit);
    
    // Terms and Conditions
    QGroupBox *termsGroup = new QGroupBox("Terms and Conditions");
    termsGroup->setStyleSheet(accountGroup->styleSheet());
    
    QVBoxLayout *termsLayout = new QVBoxLayout(termsGroup);
    
    m_termsCheck = new QCheckBox("I agree to the Terms of Service");
    m_privacyCheck = new QCheckBox("I agree to the Privacy Policy");
    m_newsletterCheck = new QCheckBox("Subscribe to newsletter");
    
    QString checkBoxStyle = 
        "QCheckBox {"
        "    color: white;"
        "    font-size: 14px;"
        "    spacing: 10px;"
        "}"
        "QCheckBox::indicator {"
        "    width: 18px;"
        "    height: 18px;"
        "}"
        "QCheckBox::indicator:unchecked {"
        "    border: 2px solid #555;"
        "    background-color: #2b2b2b;"
        "    border-radius: 3px;"
        "}"
        "QCheckBox::indicator:checked {"
        "    border: 2px solid #61dafb;"
        "    background-color: #61dafb;"
        "    border-radius: 3px;"
        "}";
    
    m_termsCheck->setStyleSheet(checkBoxStyle);
    m_privacyCheck->setStyleSheet(checkBoxStyle);
    m_newsletterCheck->setStyleSheet(checkBoxStyle);
    
    termsLayout->addWidget(m_termsCheck);
    termsLayout->addWidget(m_privacyCheck);
    termsLayout->addWidget(m_newsletterCheck);
    
    layout->addWidget(accountGroup);
    layout->addWidget(termsGroup);
    
    m_stackedWidget->addWidget(step3);
}

void WizardWidget::setupStep4()
{
    QWidget *step4 = new QWidget();
    QVBoxLayout *layout = new QVBoxLayout(step4);
    layout->setSpacing(20);
    
    // Additional Information
    QGroupBox *additionalGroup = new QGroupBox("Additional Information");
    additionalGroup->setStyleSheet(
        "QGroupBox {"
        "    font-weight: bold;"
        "    color: white;"
        "    border: 2px solid #3a3a3a;"
        "    border-radius: 8px;"
        "    margin-top: 10px;"
        "    padding-top: 10px;"
        "}"
        "QGroupBox::title {"
        "    subcontrol-origin: margin;"
        "    left: 10px;"
        "    padding: 0 5px 0 5px;"
        "}"
    );
    
    QFormLayout *additionalLayout = new QFormLayout(additionalGroup);
    additionalLayout->setSpacing(10);
    
    m_bioEdit = new QTextEdit();
    m_bioEdit->setMaximumHeight(100);
    m_bioEdit->setStyleSheet(
        "QTextEdit {"
        "    padding: 10px 12px;"
        "    border: 1px solid #555;"
        "    border-radius: 4px;"
        "    background-color: #2b2b2b;"
        "    color: white;"
        "    font-size: 14px;"
        "}"
        "QTextEdit:focus {"
        "    border-color: #61dafb;"
        "}"
    );
    additionalLayout->addRow("Biography:", m_bioEdit);
    
    m_industryCombo = new QComboBox();
    m_industryCombo->addItems({"Technology", "Healthcare", "Finance", "Education", "Retail", "Manufacturing", "Other"});
    m_industryCombo->setStyleSheet(
        "QComboBox {"
        "    padding: 10px 12px;"
        "    border: 1px solid #555;"
        "    border-radius: 4px;"
        "    background-color: #2b2b2b;"
        "    color: white;"
        "    font-size: 14px;"
        "}"
        "QComboBox::drop-down {"
        "    border: none;"
        "}"
        "QComboBox::down-arrow {"
        "    image: none;"
        "    border-left: 5px solid transparent;"
        "    border-right: 5px solid transparent;"
        "    border-top: 5px solid white;"
        "    margin-right: 10px;"
        "}"
        "QComboBox QAbstractItemView {"
        "    background-color: #2b2b2b;"
        "    color: white;"
        "    border: 1px solid #555;"
        "    selection-background-color: #404040;"
        "}"
    );
    additionalLayout->addRow("Industry:", m_industryCombo);
    
    m_experienceCombo = new QComboBox();
    m_experienceCombo->addItems({"0-1 years", "1-3 years", "3-5 years", "5-10 years", "10+ years"});
    m_experienceCombo->setStyleSheet(m_industryCombo->styleSheet());
    additionalLayout->addRow("Experience:", m_experienceCombo);
    
    m_websiteEdit = new QLineEdit();
    m_websiteEdit->setStyleSheet(
        "QLineEdit {"
        "    padding: 10px 12px;"
        "    border: 1px solid #555;"
        "    border-radius: 4px;"
        "    background-color: #2b2b2b;"
        "    color: white;"
        "    font-size: 14px;"
        "}"
        "QLineEdit:focus {"
        "    border-color: #61dafb;"
        "}"
    );
    m_websiteEdit->setPlaceholderText("https://example.com");
    additionalLayout->addRow("Website:", m_websiteEdit);
    
    m_birthDateEdit = new QDateEdit();
    m_birthDateEdit->setDate(QDate::currentDate().addYears(-25));
    m_birthDateEdit->setStyleSheet(
        "QDateEdit {"
        "    padding: 10px 12px;"
        "    border: 1px solid #555;"
        "    border-radius: 4px;"
        "    background-color: #2b2b2b;"
        "    color: white;"
        "    font-size: 14px;"
        "}"
        "QDateEdit:focus {"
        "    border-color: #61dafb;"
        "}"
    );
    additionalLayout->addRow("Birth Date:", m_birthDateEdit);
    
    // Skills
    QGroupBox *skillsGroup = new QGroupBox("Skills");
    skillsGroup->setStyleSheet(additionalGroup->styleSheet());
    
    QVBoxLayout *skillsLayout = new QVBoxLayout(skillsGroup);
    
    m_skillsList = new QListWidget();
    m_skillsList->setMaximumHeight(120);
    m_skillsList->setStyleSheet(
        "QListWidget {"
        "    background-color: #2b2b2b;"
        "    color: white;"
        "    border: 1px solid #555;"
        "    border-radius: 4px;"
        "    font-size: 14px;"
        "}"
        "QListWidget::item {"
        "    padding: 8px;"
        "    border: none;"
        "}"
        "QListWidget::item:selected {"
        "    background-color: #404040;"
        "    color: #61dafb;"
        "}"
        "QListWidget::item:hover {"
        "    background-color: #353535;"
        "}"
    );
    
    QStringList skills = {"Programming", "Design", "Management", "Marketing", "Sales", "Customer Service"};
    for (const QString &skill : skills) {
        QListWidgetItem *item = new QListWidgetItem(skill);
        item->setFlags(item->flags() | Qt::ItemIsUserCheckable);
        item->setCheckState(Qt::Unchecked);
        m_skillsList->addItem(item);
    }
    
    skillsLayout->addWidget(m_skillsList);
    
    layout->addWidget(additionalGroup);
    layout->addWidget(skillsGroup);
    
    m_stackedWidget->addWidget(step4);
}

void WizardWidget::setupStep5()
{
    QWidget *step5 = new QWidget();
    QVBoxLayout *layout = new QVBoxLayout(step5);
    layout->setSpacing(20);
    
    // Review and Confirm
    QGroupBox *reviewGroup = new QGroupBox("Review and Confirm");
    reviewGroup->setStyleSheet(
        "QGroupBox {"
        "    font-weight: bold;"
        "    color: white;"
        "    border: 2px solid #3a3a3a;"
        "    border-radius: 8px;"
        "    margin-top: 10px;"
        "    padding-top: 10px;"
        "}"
        "QGroupBox::title {"
        "    subcontrol-origin: margin;"
        "    left: 10px;"
        "    padding: 0 5px 0 5px;"
        "}"
    );
    
    QVBoxLayout *reviewLayout = new QVBoxLayout(reviewGroup);
    
    m_reviewLabel = new QLabel("Please review your information before proceeding:");
    m_reviewLabel->setStyleSheet(
        "QLabel {"
        "    color: white;"
        "    font-size: 16px;"
        "    margin-bottom: 10px;"
        "}"
    );
    
    m_reviewText = new QTextEdit();
    m_reviewText->setReadOnly(true);
    m_reviewText->setStyleSheet(
        "QTextEdit {"
        "    padding: 15px;"
        "    border: 1px solid #555;"
        "    border-radius: 4px;"
        "    background-color: #2b2b2b;"
        "    color: white;"
        "    font-size: 14px;"
        "    line-height: 1.5;"
        "}"
    );
    
    reviewLayout->addWidget(m_reviewLabel);
    reviewLayout->addWidget(m_reviewText);
    
    layout->addWidget(reviewGroup);
    
    m_stackedWidget->addWidget(step5);
}

void WizardWidget::setupNavigation()
{
    updateNavigation();
}

void WizardWidget::updateNavigation()
{
    m_previousButton->setEnabled(m_currentStep > 0);
    m_nextButton->setVisible(m_currentStep < m_totalSteps - 1);
    m_finishButton->setVisible(m_currentStep == m_totalSteps - 1);
    
    m_progressBar->setValue(m_currentStep);
    
    QStringList stepNames = {
        "Personal Information",
        "Preferences",
        "Account Settings",
        "Additional Information",
        "Review and Confirm"
    };
    
    m_stepLabel->setText(QString("Step %1 of %2: %3")
                        .arg(m_currentStep + 1)
                        .arg(m_totalSteps)
                        .arg(stepNames[m_currentStep]));
}

void WizardWidget::nextStep()
{
    if (validateStep(m_currentStep)) {
        saveStepData(m_currentStep);
        m_currentStep++;
        showStep(m_currentStep);
        updateNavigation();
    }
}

void WizardWidget::previousStep()
{
    if (m_currentStep > 0) {
        saveStepData(m_currentStep);
        m_currentStep--;
        showStep(m_currentStep);
        updateNavigation();
    }
}

void WizardWidget::finishWizard()
{
    if (validateStep(m_currentStep)) {
        saveStepData(m_currentStep);
        
        // Generate review text
        QString reviewText = "Personal Information:\n";
        reviewText += QString("Name: %1 %2\n").arg(m_firstNameEdit->text()).arg(m_lastNameEdit->text());
        reviewText += QString("Email: %1\n").arg(m_emailEdit->text());
        reviewText += QString("Phone: %1\n").arg(m_phoneEdit->text());
        reviewText += QString("Country: %1\n").arg(m_countryCombo->currentText());
        reviewText += QString("Language: %1\n\n").arg(m_languageCombo->currentText());
        
        reviewText += "Preferences:\n";
        reviewText += QString("Theme: %1\n").arg(m_darkThemeRadio->isChecked() ? "Dark" : "Light");
        reviewText += QString("Email Notifications: %1\n").arg(m_emailNotificationsCheck->isChecked() ? "Yes" : "No");
        reviewText += QString("SMS Notifications: %1\n").arg(m_smsNotificationsCheck->isChecked() ? "Yes" : "No");
        reviewText += QString("Push Notifications: %1\n").arg(m_pushNotificationsCheck->isChecked() ? "Yes" : "No");
        reviewText += QString("Volume: %1%\n").arg(m_volumeSlider->value());
        reviewText += QString("Font Size: %1\n\n").arg(m_fontSizeSpin->value());
        
        reviewText += "Account Settings:\n";
        reviewText += QString("Username: %1\n").arg(m_usernameEdit->text());
        reviewText += QString("Terms Accepted: %1\n").arg(m_termsCheck->isChecked() ? "Yes" : "No");
        reviewText += QString("Privacy Accepted: %1\n").arg(m_privacyCheck->isChecked() ? "Yes" : "No");
        reviewText += QString("Newsletter: %1\n\n").arg(m_newsletterCheck->isChecked() ? "Yes" : "No");
        
        reviewText += "Additional Information:\n";
        reviewText += QString("Biography: %1\n").arg(m_bioEdit->toPlainText());
        reviewText += QString("Industry: %1\n").arg(m_industryCombo->currentText());
        reviewText += QString("Experience: %1\n").arg(m_experienceCombo->currentText());
        reviewText += QString("Website: %1\n").arg(m_websiteEdit->text());
        reviewText += QString("Birth Date: %1\n").arg(m_birthDateEdit->date().toString("yyyy-MM-dd"));
        
        m_reviewText->setPlainText(reviewText);
        
        QMessageBox::information(this, "Wizard Complete", 
                               "Your information has been saved successfully!");
    }
}

void WizardWidget::cancelWizard()
{
    int ret = QMessageBox::question(this, "Cancel Wizard", 
                                   "Are you sure you want to cancel? All progress will be lost.",
                                   QMessageBox::Yes | QMessageBox::No);
    if (ret == QMessageBox::Yes) {
        close();
    }
}

void WizardWidget::resetWizard()
{
    int ret = QMessageBox::question(this, "Reset Wizard", 
                                   "Are you sure you want to reset all fields?",
                                   QMessageBox::Yes | QMessageBox::No);
    if (ret == QMessageBox::Yes) {
        m_currentStep = 0;
        showStep(0);
        updateNavigation();
        
        // Clear all fields
        m_firstNameEdit->clear();
        m_lastNameEdit->clear();
        m_emailEdit->clear();
        m_phoneEdit->clear();
        m_countryCombo->setCurrentIndex(0);
        m_languageCombo->setCurrentIndex(0);
        m_darkThemeRadio->setChecked(true);
        m_emailNotificationsCheck->setChecked(false);
        m_smsNotificationsCheck->setChecked(false);
        m_pushNotificationsCheck->setChecked(true);
        m_volumeSlider->setValue(50);
        m_fontSizeSpin->setValue(12);
        m_usernameEdit->clear();
        m_passwordEdit->clear();
        m_confirmPasswordEdit->clear();
        m_termsCheck->setChecked(false);
        m_privacyCheck->setChecked(false);
        m_newsletterCheck->setChecked(false);
        m_bioEdit->clear();
        m_industryCombo->setCurrentIndex(0);
        m_experienceCombo->setCurrentIndex(0);
        m_websiteEdit->clear();
        m_birthDateEdit->setDate(QDate::currentDate().addYears(-25));
        
        for (int i = 0; i < m_skillsList->count(); ++i) {
            m_skillsList->item(i)->setCheckState(Qt::Unchecked);
        }
    }
}

bool WizardWidget::validateStep(int step)
{
    switch (step) {
        case 0: // Personal Information
            if (m_firstNameEdit->text().isEmpty()) {
                QMessageBox::warning(this, "Validation Error", "First name is required.");
                return false;
            }
            if (m_lastNameEdit->text().isEmpty()) {
                QMessageBox::warning(this, "Validation Error", "Last name is required.");
                return false;
            }
            if (m_emailEdit->text().isEmpty()) {
                QMessageBox::warning(this, "Validation Error", "Email is required.");
                return false;
            }
            break;
            
        case 2: // Account Settings
            if (m_usernameEdit->text().isEmpty()) {
                QMessageBox::warning(this, "Validation Error", "Username is required.");
                return false;
            }
            if (m_passwordEdit->text().isEmpty()) {
                QMessageBox::warning(this, "Validation Error", "Password is required.");
                return false;
            }
            if (m_passwordEdit->text() != m_confirmPasswordEdit->text()) {
                QMessageBox::warning(this, "Validation Error", "Passwords do not match.");
                return false;
            }
            if (!m_termsCheck->isChecked()) {
                QMessageBox::warning(this, "Validation Error", "You must agree to the Terms of Service.");
                return false;
            }
            if (!m_privacyCheck->isChecked()) {
                QMessageBox::warning(this, "Validation Error", "You must agree to the Privacy Policy.");
                return false;
            }
            break;
    }
    
    return true;
}

void WizardWidget::showStep(int step)
{
    m_stackedWidget->setCurrentIndex(step);
}

void WizardWidget::saveStepData(int step)
{
    // Save step data to m_wizardData map
    switch (step) {
        case 0:
            m_wizardData["firstName"] = m_firstNameEdit->text();
            m_wizardData["lastName"] = m_lastNameEdit->text();
            m_wizardData["email"] = m_emailEdit->text();
            m_wizardData["phone"] = m_phoneEdit->text();
            m_wizardData["country"] = m_countryCombo->currentText();
            m_wizardData["language"] = m_languageCombo->currentText();
            break;
        case 1:
            m_wizardData["theme"] = m_darkThemeRadio->isChecked() ? "Dark" : "Light";
            m_wizardData["emailNotifications"] = m_emailNotificationsCheck->isChecked();
            m_wizardData["smsNotifications"] = m_smsNotificationsCheck->isChecked();
            m_wizardData["pushNotifications"] = m_pushNotificationsCheck->isChecked();
            m_wizardData["volume"] = m_volumeSlider->value();
            m_wizardData["fontSize"] = m_fontSizeSpin->value();
            break;
        case 2:
            m_wizardData["username"] = m_usernameEdit->text();
            m_wizardData["password"] = m_passwordEdit->text();
            m_wizardData["termsAccepted"] = m_termsCheck->isChecked();
            m_wizardData["privacyAccepted"] = m_privacyCheck->isChecked();
            m_wizardData["newsletter"] = m_newsletterCheck->isChecked();
            break;
        case 3:
            m_wizardData["bio"] = m_bioEdit->toPlainText();
            m_wizardData["industry"] = m_industryCombo->currentText();
            m_wizardData["experience"] = m_experienceCombo->currentText();
            m_wizardData["website"] = m_websiteEdit->text();
            m_wizardData["birthDate"] = m_birthDateEdit->date();
            break;
    }
}

void WizardWidget::loadStepData(int step)
{
    // Load step data from m_wizardData map
    switch (step) {
        case 0:
            m_firstNameEdit->setText(m_wizardData.value("firstName").toString());
            m_lastNameEdit->setText(m_wizardData.value("lastName").toString());
            m_emailEdit->setText(m_wizardData.value("email").toString());
            m_phoneEdit->setText(m_wizardData.value("phone").toString());
            m_countryCombo->setCurrentText(m_wizardData.value("country").toString());
            m_languageCombo->setCurrentText(m_wizardData.value("language").toString());
            break;
        case 1:
            if (m_wizardData.value("theme").toString() == "Dark") {
                m_darkThemeRadio->setChecked(true);
            } else {
                m_lightThemeRadio->setChecked(true);
            }
            m_emailNotificationsCheck->setChecked(m_wizardData.value("emailNotifications").toBool());
            m_smsNotificationsCheck->setChecked(m_wizardData.value("smsNotifications").toBool());
            m_pushNotificationsCheck->setChecked(m_wizardData.value("pushNotifications").toBool());
            m_volumeSlider->setValue(m_wizardData.value("volume", 50).toInt());
            m_fontSizeSpin->setValue(m_wizardData.value("fontSize", 12).toInt());
            break;
        case 2:
            m_usernameEdit->setText(m_wizardData.value("username").toString());
            m_passwordEdit->setText(m_wizardData.value("password").toString());
            m_confirmPasswordEdit->setText(m_wizardData.value("password").toString());
            m_termsCheck->setChecked(m_wizardData.value("termsAccepted").toBool());
            m_privacyCheck->setChecked(m_wizardData.value("privacyAccepted").toBool());
            m_newsletterCheck->setChecked(m_wizardData.value("newsletter").toBool());
            break;
        case 3:
            m_bioEdit->setPlainText(m_wizardData.value("bio").toString());
            m_industryCombo->setCurrentText(m_wizardData.value("industry").toString());
            m_experienceCombo->setCurrentText(m_wizardData.value("experience").toString());
            m_websiteEdit->setText(m_wizardData.value("website").toString());
            m_birthDateEdit->setDate(m_wizardData.value("birthDate", QDate::currentDate().addYears(-25)).toDate());
            break;
    }
}

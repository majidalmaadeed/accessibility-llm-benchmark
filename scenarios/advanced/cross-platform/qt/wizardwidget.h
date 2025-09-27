#ifndef WIZARDWIDGET_H
#define WIZARDWIDGET_H

#include <QWidget>
#include <QStackedWidget>
#include <QPushButton>
#include <QLineEdit>
#include <QTextEdit>
#include <QComboBox>
#include <QCheckBox>
#include <QRadioButton>
#include <QGroupBox>
#include <QLabel>
#include <QProgressBar>
#include <QVBoxLayout>
#include <QHBoxLayout>
#include <QFormLayout>
#include <QButtonGroup>
#include <QListWidget>
#include <QSpinBox>
#include <QDateEdit>
#include <QSlider>

class WizardWidget : public QWidget
{
    Q_OBJECT

public:
    explicit WizardWidget(QWidget *parent = nullptr);

private slots:
    void nextStep();
    void previousStep();
    void finishWizard();
    void cancelWizard();
    void resetWizard();
    void validateCurrentStep();

private:
    void setupUI();
    void setupSteps();
    void setupStep1();
    void setupStep2();
    void setupStep3();
    void setupStep4();
    void setupStep5();
    void setupNavigation();
    void updateNavigation();
    bool validateStep(int step);
    void showStep(int step);
    void saveStepData(int step);
    void loadStepData(int step);
    
    QStackedWidget *m_stackedWidget;
    QPushButton *m_previousButton;
    QPushButton *m_nextButton;
    QPushButton *m_finishButton;
    QPushButton *m_cancelButton;
    QPushButton *m_resetButton;
    QProgressBar *m_progressBar;
    QLabel *m_stepLabel;
    
    int m_currentStep;
    int m_totalSteps;
    
    // Step 1 - Personal Information
    QLineEdit *m_firstNameEdit;
    QLineEdit *m_lastNameEdit;
    QLineEdit *m_emailEdit;
    QLineEdit *m_phoneEdit;
    QComboBox *m_countryCombo;
    QComboBox *m_languageCombo;
    
    // Step 2 - Preferences
    QButtonGroup *m_themeGroup;
    QRadioButton *m_lightThemeRadio;
    QRadioButton *m_darkThemeRadio;
    QButtonGroup *m_notificationGroup;
    QCheckBox *m_emailNotificationsCheck;
    QCheckBox *m_smsNotificationsCheck;
    QCheckBox *m_pushNotificationsCheck;
    QSlider *m_volumeSlider;
    QSpinBox *m_fontSizeSpin;
    
    // Step 3 - Account Settings
    QLineEdit *m_usernameEdit;
    QLineEdit *m_passwordEdit;
    QLineEdit *m_confirmPasswordEdit;
    QCheckBox *m_termsCheck;
    QCheckBox *m_privacyCheck;
    QCheckBox *m_newsletterCheck;
    
    // Step 4 - Additional Information
    QTextEdit *m_bioEdit;
    QComboBox *m_industryCombo;
    QComboBox *m_experienceCombo;
    QListWidget *m_skillsList;
    QLineEdit *m_websiteEdit;
    QDateEdit *m_birthDateEdit;
    
    // Step 5 - Review and Confirm
    QLabel *m_reviewLabel;
    QTextEdit *m_reviewText;
    
    // Data storage
    QMap<QString, QVariant> m_wizardData;
};

#endif // WIZARDWIDGET_H

#include <QApplication>
#include <QMainWindow>
#include <QVBoxLayout>
#include <QHBoxLayout>
#include <QLabel>
#include <QPushButton>
#include <QWidget>
#include <QTabWidget>
#include <QComboBox>
#include <QCheckBox>
#include <QSlider>

class SettingsApp : public QMainWindow
{
    Q_OBJECT

public:
    SettingsApp(QWidget *parent = nullptr) : QMainWindow(parent)
    {
        setupUI();
        setupConnections();
    }

private slots:
    void saveSettings()
    {
        QMessageBox::information(this, "Save", "Settings saved successfully!");
    }
    
    void resetSettings()
    {
        QMessageBox::information(this, "Reset", "Settings reset to defaults!");
    }

private:
    void setupUI()
    {
        QWidget *centralWidget = new QWidget(this);
        setCentralWidget(centralWidget);
        
        QVBoxLayout *mainLayout = new QVBoxLayout(centralWidget);ngs page without descriptive title element
        
        // Header
        QHBoxLayout *headerLayout = new QHBoxLayout();
        
        QLabel *titleLabel = new QLabel("Settings", this);
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
        
        QPushButton *helpBtn = new QPushButton("❓ Help", this);
        helpBtn->setStyleSheet(
            "QPushButton {"
            "    background: #6c757d;"
            "    color: white;"
            "    border: none;"
            "    border-radius: 6px;"
            "    padding: 8px 16px;"
            "    font-size: 14px;"
            "    font-weight: bold;"
            "    margin-right: 10px;"
            "}"
            "QPushButton:hover {"
            "    background: #5a6268;"
            "}"
        );
        headerLayout->addWidget(helpBtn);
        
        QPushButton *backBtn = new QPushButton("← Back", this);
        backBtn->setStyleSheet(
            "QPushButton {"
            "    background: #007bff;"
            "    color: white;"
            "    border: none;"
            "    border-radius: 6px;"
            "    padding: 8px 16px;"
            "    font-size: 14px;"
            "    font-weight: bold;"
            "}"
            "QPushButton:hover {"
            "    background: #0056b3;"
            "}"
        );
        headerLayout->addWidget(backBtn);
        
        mainLayout->addLayout(headerLayout);
        
        // Settings content
        QHBoxLayout *contentLayout = new QHBoxLayout();
        
        // Left sidebar
        QVBoxLayout *sidebarLayout = new QVBoxLayout();
        
        QPushButton *generalBtn = new QPushButton("⚙️ General", this);
        generalBtn->setStyleSheet(
            "QPushButton {"
            "    background: #007bff;"
            "    color: white;"
            "    border: none;"
            "    border-radius: 6px;"
            "    padding: 12px 20px;"
            "    font-size: 16px;"
            "    text-align: left;"
            "    margin-bottom: 10px;"
            "}"
            "QPushButton:hover {"
            "    background: #0056b3;"
            "}"
        );
        sidebarLayout->addWidget(generalBtn);
        
        QPushButton *privacyBtn = new QPushButton("🔒 Privacy", this);
        privacyBtn->setStyleSheet(
            "QPushButton {"
            "    background: #6c757d;"
            "    color: white;"
            "    border: none;"
            "    border-radius: 6px;"
            "    padding: 12px 20px;"
            "    font-size: 16px;"
            "    text-align: left;"
            "    margin-bottom: 10px;"
            "}"
            "QPushButton:hover {"
            "    background: #5a6268;"
            "}"
        );
        sidebarLayout->addWidget(privacyBtn);
        
        QPushButton *securityBtn = new QPushButton("🛡️ Security", this);
        securityBtn->setStyleSheet(
            "QPushButton {"
            "    background: #6c757d;"
            "    color: white;"
            "    border: none;"
            "    border-radius: 6px;"
            "    padding: 12px 20px;"
            "    font-size: 16px;"
            "    text-align: left;"
            "    margin-bottom: 10px;"
            "}"
            "QPushButton:hover {"
            "    background: #5a6268;"
            "}"
        );
        sidebarLayout->addWidget(securityBtn);
        
        QPushButton *notificationsBtn = new QPushButton("🔔 Notifications", this);
        notificationsBtn->setStyleSheet(
            "QPushButton {"
            "    background: #6c757d;"
            "    color: white;"
            "    border: none;"
            "    border-radius: 6px;"
            "    padding: 12px 20px;"
            "    font-size: 16px;"
            "    text-align: left;"
            "    margin-bottom: 10px;"
            "}"
            "QPushButton:hover {"
            "    background: #5a6268;"
            "}"
        );
        sidebarLayout->addWidget(notificationsBtn);
        
        QPushButton *appearanceBtn = new QPushButton("🎨 Appearance", this);
        appearanceBtn->setStyleSheet(
            "QPushButton {"
            "    background: #6c757d;"
            "    color: white;"
            "    border: none;"
            "    border-radius: 6px;"
            "    padding: 12px 20px;"
            "    font-size: 16px;"
            "    text-align: left;"
            "    margin-bottom: 10px;"
            "}"
            "QPushButton:hover {"
            "    background: #5a6268;"
            "}"
        );
        sidebarLayout->addWidget(appearanceBtn);
        
        QPushButton *advancedBtn = new QPushButton("⚡ Advanced", this);
        advancedBtn->setStyleSheet(
            "QPushButton {"
            "    background: #6c757d;"
            "    color: white;"
            "    border: none;"
            "    border-radius: 6px;"
            "    padding: 12px 20px;"
            "    font-size: 16px;"
            "    text-align: left;"
            "    margin-bottom: 10px;"
            "}"
            "QPushButton:hover {"
            "    background: #5a6268;"
            "}"
        );
        sidebarLayout->addWidget(advancedBtn);
        
        sidebarLayout->addStretch();
        contentLayout->addLayout(sidebarLayout);
        
        // Main settings content
        QVBoxLayout *settingsLayout = new QVBoxLayout();
        
        QLabel *sectionTitle = new QLabel("General Settings", this);
        sectionTitle->setStyleSheet(
            "QLabel {"
            "    font-size: 24px;"
            "    font-weight: bold;"
            "    color: #333;"
            "    margin-bottom: 20px;"
            "}"
        );
        settingsLayout->addWidget(sectionTitle);
        
        // Language setting
        QHBoxLayout *languageLayout = new QHBoxLayout();
        
        QLabel *languageLabel = new QLabel("Language:", this);
        languageLabel->setStyleSheet(
            "QLabel {"
            "    font-size: 16px;"
            "    font-weight: bold;"
            "    color: #333;"
            "    margin-right: 15px;"
            "    min-width: 100px;"
            "}"
        );
        languageLayout->addWidget(languageLabel);
        
        QComboBox *languageCombo = new QComboBox(this);
        languageCombo->addItem("English");
        languageCombo->addItem("Spanish");
        languageCombo->addItem("French");
        languageCombo->addItem("German");
        languageCombo->addItem("Italian");
        languageCombo->addItem("Portuguese");
        languageCombo->setStyleSheet(
            "QComboBox {"
            "    padding: 8px 12px;"
            "    border: 2px solid #ddd;"
            "    border-radius: 6px;"
            "    font-size: 16px;"
            "    min-width: 200px;"
            "}"
            "QComboBox:focus {"
            "    border-color: #007bff;"
            "}"
        );
        languageLayout->addWidget(languageCombo);
        
        languageLayout->addStretch();
        settingsLayout->addLayout(languageLayout);
        
        // Theme setting
        QHBoxLayout *themeLayout = new QHBoxLayout();
        
        QLabel *themeLabel = new QLabel("Theme:", this);
        themeLabel->setStyleSheet(
            "QLabel {"
            "    font-size: 16px;"
            "    font-weight: bold;"
            "    color: #333;"
            "    margin-right: 15px;"
            "    min-width: 100px;"
            "}"
        );
        themeLayout->addWidget(themeLabel);
        
        QComboBox *themeCombo = new QComboBox(this);
        themeCombo->addItem("System");
        themeCombo->addItem("Light");
        themeCombo->addItem("Dark");
        themeCombo->setStyleSheet(
            "QComboBox {"
            "    padding: 8px 12px;"
            "    border: 2px solid #ddd;"
            "    border-radius: 6px;"
            "    font-size: 16px;"
            "    min-width: 200px;"
            "}"
            "QComboBox:focus {"
            "    border-color: #007bff;"
            "}"
        );
        themeLayout->addWidget(themeCombo);
        
        themeLayout->addStretch();
        settingsLayout->addLayout(themeLayout);
        
        // Auto-save setting
        QHBoxLayout *autoSaveLayout = new QHBoxLayout();
        
        QCheckBox *autoSaveCheck = new QCheckBox("Auto-save", this);
        autoSaveCheck->setStyleSheet(
            "QCheckBox {"
            "    font-size: 16px;"
            "    color: #333;"
            "    margin-right: 15px;"
            "    padding: 5px;"
            "}"
            "QCheckBox::indicator {"
            "    width: 20px;"
            "    height: 20px;"
            "}"
        );
        autoSaveCheck->setChecked(true);
        autoSaveLayout->addWidget(autoSaveCheck);
        
        autoSaveLayout->addStretch();
        settingsLayout->addLayout(autoSaveLayout);
        
        // Font size setting
        QHBoxLayout *fontSizeLayout = new QHBoxLayout();
        
        QLabel *fontSizeLabel = new QLabel("Font Size:", this);
        fontSizeLabel->setStyleSheet(
            "QLabel {"
            "    font-size: 16px;"
            "    font-weight: bold;"
            "    color: #333;"
            "    margin-right: 15px;"
            "    min-width: 100px;"
            "}"
        );
        fontSizeLayout->addWidget(fontSizeLabel);
        
        QSlider *fontSizeSlider = new QSlider(Qt::Horizontal, this);
        fontSizeSlider->setRange(10, 24);
        fontSizeSlider->setValue(14);
        fontSizeSlider->setStyleSheet(
            "QSlider::groove:horizontal {"
            "    border: 1px solid #999999;"
            "    height: 8px;"
            "    background: qlineargradient(x1:0, y1:0, x2:0, y2:1, stop:0 #B1B1B1, stop:1 #c4c4c4);"
            "    margin: 2px 0;"
            "    border-radius: 4px;"
            "}"
            "QSlider::handle:horizontal {"
            "    background: #007bff;"
            "    border: 1px solid #5c5c5c;"
            "    width: 18px;"
            "    margin: -2px 0;"
            "    border-radius: 9px;"
            "}"
            "QSlider::handle:horizontal:hover {"
            "    background: #0056b3;"
            "}"
        );
        fontSizeLayout->addWidget(fontSizeSlider);
        
        QLabel *fontSizeValue = new QLabel("14px", this);
        fontSizeValue->setStyleSheet(
            "QLabel {"
            "    font-size: 14px;"
            "    color: #666;"
            "    margin-left: 10px;"
            "    min-width: 40px;"
            "}"
        );
        fontSizeLayout->addWidget(fontSizeValue);
        
        fontSizeLayout->addStretch();
        settingsLayout->addLayout(fontSizeLayout);
        
        settingsLayout->addStretch();
        contentLayout->addLayout(settingsLayout);
        
        mainLayout->addLayout(contentLayout);
        
        // Action buttons
        QHBoxLayout *buttonLayout = new QHBoxLayout();
        
        QPushButton *resetBtn = new QPushButton("Reset to Defaults", this);
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
        connect(resetBtn, &QPushButton::clicked, this, &SettingsApp::resetSettings);
        buttonLayout->addWidget(resetBtn);
        
        buttonLayout->addStretch();
        
        QPushButton *saveBtn = new QPushButton("Save Changes", this);
        saveBtn->setStyleSheet(
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
        connect(saveBtn, &QPushButton::clicked, this, &SettingsApp::saveSettings);
        buttonLayout->addWidget(saveBtn);
        
        mainLayout->addLayout(buttonLayout);
    }
    
    void setupConnections()
    {
        // Additional connections can be added here
    }
};

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);
    
    SettingsApp app;
    app.setWindowTitle("Settings - Missing Page Title");
    app.resize(800, 600);
    app.show();
    
    return app.exec();
}

#include "MissingPageTitle.moc"

#include <QApplication>
#include <QMainWindow>
#include <QVBoxLayout>
#include <QHBoxLayout>
#include <QLabel>
#include <QPushButton>
#include <QWidget>
#include <QRadioButton>
#include <QButtonGroup>
#include <QGroupBox>

class ContactPreferences : public QMainWindow
{
    Q_OBJECT

public:
    ContactPreferences(QWidget *parent = nullptr) : QMainWindow(parent)
    {
        setupUI();
        setupConnections();
    }

private slots:
    void savePreferences()
    {
        QMessageBox::information(this, "Save", "Preferences saved successfully!");
    }
    
    void resetForm()
    {
        // Reset all radio buttons
        emailRadio->setChecked(true);
        phoneRadio->setChecked(false);
        smsRadio->setChecked(false);
        noneRadio->setChecked(false);
        
        newsletterRadio->setChecked(true);
        updatesRadio->setChecked(false);
        promotionsRadio->setChecked(false);
        noMarketingRadio->setChecked(false);
    }

private:
    void setupUI()
    {
        QWidget *centralWidget = new QWidget(this);
        setCentralWidget(centralWidget);
        
        QVBoxLayout *mainLayout = new QVBoxLayout(centralWidget);
        
        // Header
        QHBoxLayout *headerLayout = new QHBoxLayout();
        
        QLabel *titleLabel = new QLabel("Contact Preferences", this);
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
        
        QPushButton *helpBtn = new QPushButton("❓ Help", this);
        helpBtn->setStyleSheet(
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
        headerLayout->addWidget(helpBtn);
        
        mainLayout->addLayout(headerLayout);
        
        // Form content
        QHBoxLayout *formLayout = new QHBoxLayout();
        
        // Left column
        QVBoxLayout *leftColumn = new QVBoxLayout();
        
        // UNGROUPED RADIO BUTTONS - Contact preference radio buttons without fieldset grouping
        QLabel *contactLabel = new QLabel("Preferred Contact Method:", this);
        contactLabel->setStyleSheet(
            "QLabel {"
            "    font-size: 18px;"
            "    font-weight: bold;"
            "    color: #333;"
            "    margin-bottom: 15px;"
            "}"
        );
        leftColumn->addWidget(contactLabel);
        
        // UNGROUPED RADIO BUTTONS - Contact preference radio buttons without fieldset grouping
        emailRadio = new QRadioButton("Email", this);
        emailRadio->setStyleSheet(
            "QRadioButton {"
            "    font-size: 16px;"
            "    color: #333;"
            "    margin-bottom: 10px;"
            "    padding: 5px;"
            "}"
            "QRadioButton::indicator {"
            "    width: 20px;"
            "    height: 20px;"
            "}"
        );
        emailRadio->setChecked(true);
        leftColumn->addWidget(emailRadio);
        
        // UNGROUPED RADIO BUTTONS - Contact preference radio buttons without fieldset grouping
        phoneRadio = new QRadioButton("Phone Call", this);
        phoneRadio->setStyleSheet(
            "QRadioButton {"
            "    font-size: 16px;"
            "    color: #333;"
            "    margin-bottom: 10px;"
            "    padding: 5px;"
            "}"
            "QRadioButton::indicator {"
            "    width: 20px;"
            "    height: 20px;"
            "}"
        );
        leftColumn->addWidget(phoneRadio);
        
        // UNGROUPED RADIO BUTTONS - Contact preference radio buttons without fieldset grouping
        smsRadio = new QRadioButton("SMS Text", this);
        smsRadio->setStyleSheet(
            "QRadioButton {"
            "    font-size: 16px;"
            "    color: #333;"
            "    margin-bottom: 10px;"
            "    padding: 5px;"
            "}"
            "QRadioButton::indicator {"
            "    width: 20px;"
            "    height: 20px;"
            "}"
        );
        leftColumn->addWidget(smsRadio);
        
        // UNGROUPED RADIO BUTTONS - Contact preference radio buttons without fieldset grouping
        noneRadio = new QRadioButton("No Contact", this);
        noneRadio->setStyleSheet(
            "QRadioButton {"
            "    font-size: 16px;"
            "    color: #333;"
            "    margin-bottom: 20px;"
            "    padding: 5px;"
            "}"
            "QRadioButton::indicator {"
            "    width: 20px;"
            "    height: 20px;"
            "}"
        );
        leftColumn->addWidget(noneRadio);
        
        // UNGROUPED RADIO BUTTONS - Contact preference radio buttons without fieldset grouping
        QLabel *marketingLabel = new QLabel("Marketing Communications:", this);
        marketingLabel->setStyleSheet(
            "QLabel {"
            "    font-size: 18px;"
            "    font-weight: bold;"
            "    color: #333;"
            "    margin-bottom: 15px;"
            "    margin-top: 20px;"
            "}"
        );
        leftColumn->addWidget(marketingLabel);
        
        // UNGROUPED RADIO BUTTONS - Contact preference radio buttons without fieldset grouping
        newsletterRadio = new QRadioButton("Newsletter Only", this);
        newsletterRadio->setStyleSheet(
            "QRadioButton {"
            "    font-size: 16px;"
            "    color: #333;"
            "    margin-bottom: 10px;"
            "    padding: 5px;"
            "}"
            "QRadioButton::indicator {"
            "    width: 20px;"
            "    height: 20px;"
            "}"
        );
        newsletterRadio->setChecked(true);
        leftColumn->addWidget(newsletterRadio);
        
        // UNGROUPED RADIO BUTTONS - Contact preference radio buttons without fieldset grouping
        updatesRadio = new QRadioButton("Product Updates", this);
        updatesRadio->setStyleSheet(
            "QRadioButton {"
            "    font-size: 16px;"
            "    color: #333;"
            "    margin-bottom: 10px;"
            "    padding: 5px;"
            "}"
            "QRadioButton::indicator {"
            "    width: 20px;"
            "    height: 20px;"
            "}"
        );
        leftColumn->addWidget(updatesRadio);
        
        // UNGROUPED RADIO BUTTONS - Contact preference radio buttons without fieldset grouping
        promotionsRadio = new QRadioButton("Promotions & Offers", this);
        promotionsRadio->setStyleSheet(
            "QRadioButton {"
            "    font-size: 16px;"
            "    color: #333;"
            "    margin-bottom: 10px;"
            "    padding: 5px;"
            "}"
            "QRadioButton::indicator {"
            "    width: 20px;"
            "    height: 20px;"
            "}"
        );
        leftColumn->addWidget(promotionsRadio);
        
        // UNGROUPED RADIO BUTTONS - Contact preference radio buttons without fieldset grouping
        noMarketingRadio = new QRadioButton("No Marketing", this);
        noMarketingRadio->setStyleSheet(
            "QRadioButton {"
            "    font-size: 16px;"
            "    color: #333;"
            "    margin-bottom: 20px;"
            "    padding: 5px;"
            "}"
            "QRadioButton::indicator {"
            "    width: 20px;"
            "    height: 20px;"
            "}"
        );
        leftColumn->addWidget(noMarketingRadio);
        
        formLayout->addLayout(leftColumn);
        
        // Right column
        QVBoxLayout *rightColumn = new QVBoxLayout();
        
        QLabel *infoLabel = new QLabel("Additional Information", this);
        infoLabel->setStyleSheet(
            "QLabel {"
            "    font-size: 18px;"
            "    font-weight: bold;"
            "    color: #333;"
            "    margin-bottom: 15px;"
            "}"
        );
        rightColumn->addWidget(infoLabel);
        
        QLabel *descriptionLabel = new QLabel(
            "Please select your preferred contact methods above. Your choices will determine how we communicate with you about our products and services.",
            this
        );
        descriptionLabel->setStyleSheet(
            "QLabel {"
            "    font-size: 14px;"
            "    color: #666;"
            "    line-height: 1.6;"
            "    margin-bottom: 20px;"
            "}"
        );
        descriptionLabel->setWordWrap(true);
        rightColumn->addWidget(descriptionLabel);
        
        QLabel *privacyLabel = new QLabel("Privacy Notice", this);
        privacyLabel->setStyleSheet(
            "QLabel {"
            "    font-size: 16px;"
            "    font-weight: bold;"
            "    color: #333;"
            "    margin-bottom: 10px;"
            "}"
        );
        rightColumn->addWidget(privacyLabel);
        
        QLabel *privacyText = new QLabel(
            "We respect your privacy and will only use your contact information for the purposes you have selected. You can change these preferences at any time.",
            this
        );
        privacyText->setStyleSheet(
            "QLabel {"
            "    font-size: 14px;"
            "    color: #666;"
            "    line-height: 1.6;"
            "    margin-bottom: 20px;"
            "}"
        );
        privacyText->setWordWrap(true);
        rightColumn->addWidget(privacyText);
        
        rightColumn->addStretch();
        formLayout->addLayout(rightColumn);
        
        mainLayout->addLayout(formLayout);
        
        // Action buttons
        QHBoxLayout *buttonLayout = new QHBoxLayout();
        
        QPushButton *resetBtn = new QPushButton("Reset", this);
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
        connect(resetBtn, &QPushButton::clicked, this, &ContactPreferences::resetForm);
        buttonLayout->addWidget(resetBtn);
        
        buttonLayout->addStretch();
        
        QPushButton *saveBtn = new QPushButton("Save Preferences", this);
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
        connect(saveBtn, &QPushButton::clicked, this, &ContactPreferences::savePreferences);
        buttonLayout->addWidget(saveBtn);
        
        mainLayout->addLayout(buttonLayout);
    }
    
    void setupConnections()
    {
        // Additional connections can be added here
    }

private:
    QRadioButton *emailRadio;
    QRadioButton *phoneRadio;
    QRadioButton *smsRadio;
    QRadioButton *noneRadio;
    QRadioButton *newsletterRadio;
    QRadioButton *updatesRadio;
    QRadioButton *promotionsRadio;
    QRadioButton *noMarketingRadio;
};

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);
    
    ContactPreferences app;
    app.setWindowTitle("Contact Preferences - Radio Buttons");
    app.resize(800, 600);
    app.show();
    
    return app.exec();
}

#include "UngroupedRadioButtons.moc"

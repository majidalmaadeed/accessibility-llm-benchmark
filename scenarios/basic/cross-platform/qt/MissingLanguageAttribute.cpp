#include <QApplication>
#include <QMainWindow>
#include <QVBoxLayout>
#include <QHBoxLayout>
#include <QLabel>
#include <QPushButton>
#include <QWidget>
#include <QTextEdit>
#include <QComboBox>

class MultilingualApp : public QMainWindow
{
    Q_OBJECT

public:
    MultilingualApp(QWidget *parent = nullptr) : QMainWindow(parent)
    {
        setupUI();
        setupConnections();
    }

private slots:
    void switchLanguage()
    {
        QMessageBox::information(this, "Language", "Language switched!");
    }
    
    void saveContent()
    {
        QMessageBox::information(this, "Save", "Content saved!");
    }

private:
    void setupUI()
    {
        QWidget *centralWidget = new QWidget(this);
        setCentralWidget(centralWidget);
        
        QVBoxLayout *mainLayout = new QVBoxLayout(centralWidget);
        
        // Header
        QHBoxLayout *headerLayout = new QHBoxLayout();
        
        QLabel *titleLabel = new QLabel("Multilingual Document Editor", this);
        titleLabel->setStyleSheet(
            "QLabel {"
            "    font-size: 24px;"
            "    font-weight: bold;"
            "    color: #333;"
            "    padding: 20px 0;"
            "}"
        );
        headerLayout->addWidget(titleLabel);
        
        headerLayout->addStretch();
        
        QComboBox *languageCombo = new QComboBox(this);
        languageCombo->addItem("English");
        languageCombo->addItem("Français");
        languageCombo->addItem("Español");
        languageCombo->addItem("Deutsch");
        languageCombo->setStyleSheet(
            "QComboBox {"
            "    padding: 8px 12px;"
            "    border: 1px solid #ddd;"
            "    border-radius: 4px;"
            "    font-size: 14px;"
            "    min-width: 120px;"
            "}"
        );
        connect(languageCombo, QOverload<int>::of(&QComboBox::currentIndexChanged), this, &MultilingualApp::switchLanguage);
        headerLayout->addWidget(languageCombo);
        
        mainLayout->addLayout(headerLayout);
        
        // MISSING LANGUAGE ATTRIBUTE - HTML page with mixed English/French content without lang attributes
        QLabel *contentLabel = new QLabel(
            "Welcome to our multilingual application! Bienvenue dans notre application multilingue! "
            "This document contains mixed content in English and French. Ce document contient du contenu mixte en anglais et en français. "
            "Please select your preferred language from the dropdown above. Veuillez sélectionner votre langue préférée dans le menu déroulant ci-dessus.",
            this
        );
        contentLabel->setStyleSheet(
            "QLabel {"
            "    font-size: 16px;"
            "    color: #333;"
            "    line-height: 1.6;"
            "    padding: 20px;"
            "    background: #f8f9fa;"
            "    border: 1px solid #ddd;"
            "    border-radius: 8px;"
            "    margin-bottom: 20px;"
            "}"
        );
        contentLabel->setWordWrap(true);
        mainLayout->addWidget(contentLabel);
        
        // Document editor
        QLabel *editorLabel = new QLabel("Document Editor:", this);
        editorLabel->setStyleSheet(
            "QLabel {"
            "    font-size: 18px;"
            "    font-weight: bold;"
            "    color: #333;"
            "    margin-bottom: 10px;"
            "}"
        );
        mainLayout->addWidget(editorLabel);
        
        QTextEdit *textEditor = new QTextEdit(this);
        textEditor->setStyleSheet(
            "QTextEdit {"
            "    border: 1px solid #ddd;"
            "    border-radius: 6px;"
            "    padding: 10px;"
            "    font-size: 14px;"
            "    line-height: 1.5;"
            "    min-height: 200px;"
            "}"
        );
        textEditor->setPlainText(
            "This is a sample document with mixed languages.\n\n"
            "Ceci est un document d'exemple avec des langues mixtes.\n\n"
            "You can type in English or French here.\n\n"
            "Vous pouvez taper en anglais ou en français ici.\n\n"
            "The application should detect the language automatically.\n\n"
            "L'application devrait détecter la langue automatiquement."
        );
        mainLayout->addWidget(textEditor);
        
        // Action buttons
        QHBoxLayout *buttonLayout = new QHBoxLayout();
        
        QPushButton *saveBtn = new QPushButton("Save Document", this);
        saveBtn->setStyleSheet(
            "QPushButton {"
            "    background: #007bff;"
            "    color: white;"
            "    border: none;"
            "    border-radius: 6px;"
            "    padding: 12px 24px;"
            "    font-size: 16px;"
            "    font-weight: bold;"
            "    margin-right: 10px;"
            "}"
            "QPushButton:hover {"
            "    background: #0056b3;"
            "}"
        );
        connect(saveBtn, &QPushButton::clicked, this, &MultilingualApp::saveContent);
        buttonLayout->addWidget(saveBtn);
        
        QPushButton *translateBtn = new QPushButton("Translate", this);
        translateBtn->setStyleSheet(
            "QPushButton {"
            "    background: #28a745;"
            "    color: white;"
            "    border: none;"
            "    border-radius: 6px;"
            "    padding: 12px 24px;"
            "    font-size: 16px;"
            "    font-weight: bold;"
            "    margin-right: 10px;"
            "}"
            "QPushButton:hover {"
            "    background: #218838;"
            "}"
        );
        buttonLayout->addWidget(translateBtn);
        
        QPushButton *exportBtn = new QPushButton("Export", this);
        exportBtn->setStyleSheet(
            "QPushButton {"
            "    background: #6c757d;"
            "    color: white;"
            "    border: none;"
            "    border-radius: 6px;"
            "    padding: 12px 24px;"
            "    font-size: 16px;"
            "    font-weight: bold;"
            "}"
            "QPushButton:hover {"
            "    background: #5a6268;"
            "}"
        );
        buttonLayout->addWidget(exportBtn);
        
        buttonLayout->addStretch();
        mainLayout->addLayout(buttonLayout);
        
        // Additional mixed language content
        QLabel *footerLabel = new QLabel(
            "Note: This application supports multiple languages. Note: Cette application prend en charge plusieurs langues. "
            "Please ensure proper language detection for accessibility. Veuillez vous assurer d'une détection de langue appropriée pour l'accessibilité.",
            this
        );
        footerLabel->setStyleSheet(
            "QLabel {"
            "    font-size: 14px;"
            "    color: #666;"
            "    line-height: 1.5;"
            "    padding: 15px;"
            "    background: #e9ecef;"
            "    border-radius: 6px;"
            "    margin-top: 20px;"
            "}"
        );
        footerLabel->setWordWrap(true);
        mainLayout->addWidget(footerLabel);
    }
    
    void setupConnections()
    {
        // Additional connections can be added here
    }
};

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);
    
    MultilingualApp app;
    app.setWindowTitle("Multilingual Document Editor");
    app.resize(800, 700);
    app.show();
    
    return app.exec();
}

#include "MissingLanguageAttribute.moc"

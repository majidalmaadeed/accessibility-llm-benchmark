#include <QApplication>
#include <QMainWindow>
#include <QVBoxLayout>
#include <QHBoxLayout>
#include <QLabel>
#include <QPushButton>
#include <QWidget>
#include <QScrollArea>
#include <QFrame>

class DocumentEditor : public QMainWindow
{
    Q_OBJECT

public:
    DocumentEditor(QWidget *parent = nullptr) : QMainWindow(parent)
    {
        setupUI();
        setupConnections();
    }

private slots:
    void handleAction(const QString &action)
    {
        QMessageBox::information(this, "Action", QString("Action: %1").arg(action));
    }

private:
    void setupUI()
    {
        QWidget *centralWidget = new QWidget(this);
        setCentralWidget(centralWidget);
        
        QVBoxLayout *mainLayout = new QVBoxLayout(centralWidget);
        
        // Header
        QHBoxLayout *headerLayout = new QHBoxLayout();
        
        QLabel *titleLabel = new QLabel("Document Editor", this);
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
        
        QPushButton *saveBtn = new QPushButton("💾 Save", this);
        saveBtn->setStyleSheet(
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
        connect(saveBtn, &QPushButton::clicked, [this]() { handleAction("Save"); });
        headerLayout->addWidget(saveBtn);
        
        QPushButton *exportBtn = new QPushButton("📤 Export", this);
        exportBtn->setStyleSheet(
            "QPushButton {"
            "    background: #28a745;"
            "    color: white;"
            "    border: none;"
            "    border-radius: 6px;"
            "    padding: 8px 16px;"
            "    font-size: 14px;"
            "    font-weight: bold;"
            "    margin-right: 10px;"
            "}"
            "QPushButton:hover {"
            "    background: #218838;"
            "}"
        );
        connect(exportBtn, &QPushButton::clicked, [this]() { handleAction("Export"); });
        headerLayout->addWidget(exportBtn);
        
        QPushButton *printBtn = new QPushButton("🖨️ Print", this);
        printBtn->setStyleSheet(
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
        connect(printBtn, &QPushButton::clicked, [this]() { handleAction("Print"); });
        headerLayout->addWidget(printBtn);
        
        mainLayout->addLayout(headerLayout);
        
        // Toolbar
        QHBoxLayout *toolbarLayout = new QHBoxLayout();
        
        // INSUFFICIENT BUTTON SPACING - Action buttons placed 2px apart
        QPushButton *newBtn = new QPushButton("📄 New", this);
        newBtn->setStyleSheet(
            "QPushButton {"
            "    background: #f8f9fa;"
            "    color: #333;"
            "    border: 1px solid #ddd;"
            "    border-radius: 4px;"
            "    padding: 8px 12px;"
            "    font-size: 14px;"
            "    margin-right: 2px;"  // INSUFFICIENT BUTTON SPACING - Only 2px spacing
            "}"
            "QPushButton:hover {"
            "    background: #e9ecef;"
            "}"
        );
        connect(newBtn, &QPushButton::clicked, [this]() { handleAction("New"); });
        toolbarLayout->addWidget(newBtn);
        
        QPushButton *openBtn = new QPushButton("📁 Open", this);
        openBtn->setStyleSheet(
            "QPushButton {"
            "    background: #f8f9fa;"
            "    color: #333;"
            "    border: 1px solid #ddd;"
            "    border-radius: 4px;"
            "    padding: 8px 12px;"
            "    font-size: 14px;"
            "    margin-right: 2px;"  // INSUFFICIENT BUTTON SPACING - Only 2px spacing
            "}"
            "QPushButton:hover {"
            "    background: #e9ecef;"
            "}"
        );
        connect(openBtn, &QPushButton::clicked, [this]() { handleAction("Open"); });
        toolbarLayout->addWidget(openBtn);
        
        QPushButton *saveToolbarBtn = new QPushButton("💾 Save", this);
        saveToolbarBtn->setStyleSheet(
            "QPushButton {"
            "    background: #f8f9fa;"
            "    color: #333;"
            "    border: 1px solid #ddd;"
            "    border-radius: 4px;"
            "    padding: 8px 12px;"
            "    font-size: 14px;"
            "    margin-right: 2px;"  // INSUFFICIENT BUTTON SPACING - Only 2px spacing
            "}"
            "QPushButton:hover {"
            "    background: #e9ecef;"
            "}"
        );
        connect(saveToolbarBtn, &QPushButton::clicked, [this]() { handleAction("Save"); });
        toolbarLayout->addWidget(saveToolbarBtn);
        
        QPushButton *saveAsBtn = new QPushButton("💾 Save As", this);
        saveAsBtn->setStyleSheet(
            "QPushButton {"
            "    background: #f8f9fa;"
            "    color: #333;"
            "    border: 1px solid #ddd;"
            "    border-radius: 4px;"
            "    padding: 8px 12px;"
            "    font-size: 14px;"
            "    margin-right: 2px;"  // INSUFFICIENT BUTTON SPACING - Only 2px spacing
            "}"
            "QPushButton:hover {"
            "    background: #e9ecef;"
            "}"
        );
        connect(saveAsBtn, &QPushButton::clicked, [this]() { handleAction("Save As"); });
        toolbarLayout->addWidget(saveAsBtn);
        
        QPushButton *closeBtn = new QPushButton("❌ Close", this);
        closeBtn->setStyleSheet(
            "QPushButton {"
            "    background: #f8f9fa;"
            "    color: #333;"
            "    border: 1px solid #ddd;"
            "    border-radius: 4px;"
            "    padding: 8px 12px;"
            "    font-size: 14px;"
            "    margin-right: 2px;"  // INSUFFICIENT BUTTON SPACING - Only 2px spacing
            "}"
            "QPushButton:hover {"
            "    background: #e9ecef;"
            "}"
        );
        connect(closeBtn, &QPushButton::clicked, [this]() { handleAction("Close"); });
        toolbarLayout->addWidget(closeBtn);
        
        toolbarLayout->addStretch();
        mainLayout->addLayout(toolbarLayout);
        
        // Formatting toolbar
        QHBoxLayout *formatToolbarLayout = new QHBoxLayout();
        
        // INSUFFICIENT BUTTON SPACING - Formatting buttons placed 2px apart
        QPushButton *boldBtn = new QPushButton("B", this);
        boldBtn->setStyleSheet(
            "QPushButton {"
            "    background: #f8f9fa;"
            "    color: #333;"
            "    border: 1px solid #ddd;"
            "    border-radius: 4px;"
            "    padding: 8px 12px;"
            "    font-size: 14px;"
            "    font-weight: bold;"
            "    margin-right: 2px;"  // INSUFFICIENT BUTTON SPACING - Only 2px spacing
            "}"
            "QPushButton:hover {"
            "    background: #e9ecef;"
            "}"
        );
        connect(boldBtn, &QPushButton::clicked, [this]() { handleAction("Bold"); });
        formatToolbarLayout->addWidget(boldBtn);
        
        QPushButton *italicBtn = new QPushButton("I", this);
        italicBtn->setStyleSheet(
            "QPushButton {"
            "    background: #f8f9fa;"
            "    color: #333;"
            "    border: 1px solid #ddd;"
            "    border-radius: 4px;"
            "    padding: 8px 12px;"
            "    font-size: 14px;"
            "    font-style: italic;"
            "    margin-right: 2px;"  // INSUFFICIENT BUTTON SPACING - Only 2px spacing
            "}"
            "QPushButton:hover {"
            "    background: #e9ecef;"
            "}"
        );
        connect(italicBtn, &QPushButton::clicked, [this]() { handleAction("Italic"); });
        formatToolbarLayout->addWidget(italicBtn);
        
        QPushButton *underlineBtn = new QPushButton("U", this);
        underlineBtn->setStyleSheet(
            "QPushButton {"
            "    background: #f8f9fa;"
            "    color: #333;"
            "    border: 1px solid #ddd;"
            "    border-radius: 4px;"
            "    padding: 8px 12px;"
            "    font-size: 14px;"
            "    text-decoration: underline;"
            "    margin-right: 2px;"  // INSUFFICIENT BUTTON SPACING - Only 2px spacing
            "}"
            "QPushButton:hover {"
            "    background: #e9ecef;"
            "}"
        );
        connect(underlineBtn, &QPushButton::clicked, [this]() { handleAction("Underline"); });
        formatToolbarLayout->addWidget(underlineBtn);
        
        QPushButton *strikeBtn = new QPushButton("S", this);
        strikeBtn->setStyleSheet(
            "QPushButton {"
            "    background: #f8f9fa;"
            "    color: #333;"
            "    border: 1px solid #ddd;"
            "    border-radius: 4px;"
            "    padding: 8px 12px;"
            "    font-size: 14px;"
            "    text-decoration: line-through;"
            "    margin-right: 2px;"  // INSUFFICIENT BUTTON SPACING - Only 2px spacing
            "}"
            "QPushButton:hover {"
            "    background: #e9ecef;"
            "}"
        );
        connect(strikeBtn, &QPushButton::clicked, [this]() { handleAction("Strikethrough"); });
        formatToolbarLayout->addWidget(strikeBtn);
        
        QPushButton *superscriptBtn = new QPushButton("X²", this);
        superscriptBtn->setStyleSheet(
            "QPushButton {"
            "    background: #f8f9fa;"
            "    color: #333;"
            "    border: 1px solid #ddd;"
            "    border-radius: 4px;"
            "    padding: 8px 12px;"
            "    font-size: 14px;"
            "    margin-right: 2px;"  // INSUFFICIENT BUTTON SPACING - Only 2px spacing
            "}"
            "QPushButton:hover {"
            "    background: #e9ecef;"
            "}"
        );
        connect(superscriptBtn, &QPushButton::clicked, [this]() { handleAction("Superscript"); });
        formatToolbarLayout->addWidget(superscriptBtn);
        
        QPushButton *subscriptBtn = new QPushButton("X₂", this);
        subscriptBtn->setStyleSheet(
            "QPushButton {"
            "    background: #f8f9fa;"
            "    color: #333;"
            "    border: 1px solid #ddd;"
            "    border-radius: 4px;"
            "    padding: 8px 12px;"
            "    font-size: 14px;"
            "    margin-right: 2px;"  // INSUFFICIENT BUTTON SPACING - Only 2px spacing
            "}"
            "QPushButton:hover {"
            "    background: #e9ecef;"
            "}"
        );
        connect(subscriptBtn, &QPushButton::clicked, [this]() { handleAction("Subscript"); });
        formatToolbarLayout->addWidget(subscriptBtn);
        
        formatToolbarLayout->addStretch();
        mainLayout->addLayout(formatToolbarLayout);
        
        // Alignment toolbar
        QHBoxLayout *alignToolbarLayout = new QHBoxLayout();
        
        // INSUFFICIENT BUTTON SPACING - Alignment buttons placed 2px apart
        QPushButton *leftAlignBtn = new QPushButton("⬅️", this);
        leftAlignBtn->setStyleSheet(
            "QPushButton {"
            "    background: #f8f9fa;"
            "    color: #333;"
            "    border: 1px solid #ddd;"
            "    border-radius: 4px;"
            "    padding: 8px 12px;"
            "    font-size: 14px;"
            "    margin-right: 2px;"  // INSUFFICIENT BUTTON SPACING - Only 2px spacing
            "}"
            "QPushButton:hover {"
            "    background: #e9ecef;"
            "}"
        );
        connect(leftAlignBtn, &QPushButton::clicked, [this]() { handleAction("Align Left"); });
        alignToolbarLayout->addWidget(leftAlignBtn);
        
        QPushButton *centerAlignBtn = new QPushButton("↔️", this);
        centerAlignBtn->setStyleSheet(
            "QPushButton {"
            "    background: #f8f9fa;"
            "    color: #333;"
            "    border: 1px solid #ddd;"
            "    border-radius: 4px;"
            "    padding: 8px 12px;"
            "    font-size: 14px;"
            "    margin-right: 2px;"  // INSUFFICIENT BUTTON SPACING - Only 2px spacing
            "}"
            "QPushButton:hover {"
            "    background: #e9ecef;"
            "}"
        );
        connect(centerAlignBtn, &QPushButton::clicked, [this]() { handleAction("Align Center"); });
        alignToolbarLayout->addWidget(centerAlignBtn);
        
        QPushButton *rightAlignBtn = new QPushButton("➡️", this);
        rightAlignBtn->setStyleSheet(
            "QPushButton {"
            "    background: #f8f9fa;"
            "    color: #333;"
            "    border: 1px solid #ddd;"
            "    border-radius: 4px;"
            "    padding: 8px 12px;"
            "    font-size: 14px;"
            "    margin-right: 2px;"  // INSUFFICIENT BUTTON SPACING - Only 2px spacing
            "}"
            "QPushButton:hover {"
            "    background: #e9ecef;"
            "}"
        );
        connect(rightAlignBtn, &QPushButton::clicked, [this]() { handleAction("Align Right"); });
        alignToolbarLayout->addWidget(rightAlignBtn);
        
        QPushButton *justifyBtn = new QPushButton("⬅️➡️", this);
        justifyBtn->setStyleSheet(
            "QPushButton {"
            "    background: #f8f9fa;"
            "    color: #333;"
            "    border: 1px solid #ddd;"
            "    border-radius: 4px;"
            "    padding: 8px 12px;"
            "    font-size: 14px;"
            "    margin-right: 2px;"  // INSUFFICIENT BUTTON SPACING - Only 2px spacing
            "}"
            "QPushButton:hover {"
            "    background: #e9ecef;"
            "}"
        );
        connect(justifyBtn, &QPushButton::clicked, [this]() { handleAction("Justify"); });
        alignToolbarLayout->addWidget(justifyBtn);
        
        alignToolbarLayout->addStretch();
        mainLayout->addLayout(alignToolbarLayout);
        
        // Editor area
        QFrame *editorFrame = new QFrame(this);
        editorFrame->setStyleSheet(
            "QFrame {"
            "    background: white;"
            "    border: 1px solid #ddd;"
            "    border-radius: 8px;"
            "    padding: 20px;"
            "    margin: 10px 0;"
            "}"
        );
        
        QVBoxLayout *editorLayout = new QVBoxLayout(editorFrame);
        
        QLabel *editorTitle = new QLabel("Sample Document", this);
        editorTitle->setStyleSheet(
            "QLabel {"
            "    font-size: 20px;"
            "    font-weight: bold;"
            "    color: #333;"
            "    margin-bottom: 15px;"
            "}"
        );
        editorLayout->addWidget(editorTitle);
        
        QLabel *editorContent = new QLabel(
            "This is a sample document content. You can edit this text when in edit mode.\n\n"
            "The toolbar above demonstrates insufficient button spacing with only 2px gaps between action buttons, "
            "which makes it difficult for users to accurately click on the intended button, especially on touch devices.\n\n"
            "This violates accessibility guidelines that recommend a minimum of 44px touch target size and adequate spacing between interactive elements.",
            this
        );
        editorContent->setStyleSheet(
            "QLabel {"
            "    font-size: 16px;"
            "    color: #333;"
            "    line-height: 1.6;"
            "    margin-bottom: 15px;"
            "}"
        );
        editorContent->setWordWrap(true);
        editorLayout->addWidget(editorContent);
        
        QLabel *featuresLabel = new QLabel("Key Features:", this);
        featuresLabel->setStyleSheet(
            "QLabel {"
            "    font-size: 18px;"
            "    font-weight: bold;"
            "    color: #333;"
            "    margin-bottom: 10px;"
            "}"
        );
        editorLayout->addWidget(featuresLabel);
        
        QLabel *featuresList = new QLabel(
            "• Real-time collaboration\n"
            "• Version control\n"
            "• Cloud synchronization\n"
            "• Advanced formatting options",
            this
        );
        featuresList->setStyleSheet(
            "QLabel {"
            "    font-size: 16px;"
            "    color: #333;"
            "    line-height: 1.6;"
            "    margin-left: 20px;"
            "}"
        );
        editorLayout->addWidget(featuresList);
        
        mainLayout->addWidget(editorFrame);
        
        // Status bar
        QHBoxLayout *statusLayout = new QHBoxLayout();
        
        QLabel *statusLabel = new QLabel("Ready", this);
        statusLabel->setStyleSheet(
            "QLabel {"
            "    font-size: 14px;"
            "    color: #28a745;"
            "    font-weight: bold;"
            "    padding: 10px 0;"
            "}"
        );
        statusLayout->addWidget(statusLabel);
        
        statusLayout->addStretch();
        
        QLabel *wordCount = new QLabel("Words: 45", this);
        wordCount->setStyleSheet(
            "QLabel {"
            "    font-size: 14px;"
            "    color: #666;"
            "    padding: 10px 0;"
            "    margin-right: 20px;"
            "}"
        );
        statusLayout->addWidget(wordCount);
        
        QLabel *charCount = new QLabel("Characters: 280", this);
        charCount->setStyleSheet(
            "QLabel {"
            "    font-size: 14px;"
            "    color: #666;"
            "    padding: 10px 0;"
            "}"
        );
        statusLayout->addWidget(charCount);
        
        mainLayout->addLayout(statusLayout);
    }
    
    void setupConnections()
    {
        // Additional connections can be added here
    }
};

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);
    
    DocumentEditor app;
    app.setWindowTitle("Document Editor - Button Spacing");
    app.resize(1000, 700);
    app.show();
    
    return app.exec();
}

#include "InsufficientButtonSpacing.moc"

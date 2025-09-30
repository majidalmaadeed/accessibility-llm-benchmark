#include <QApplication>
#include <QMainWindow>
#include <QVBoxLayout>
#include <QHBoxLayout>
#include <QLabel>
#include <QPushButton>
#include <QWidget>
#include <QScrollArea>
#include <QFrame>

class DocumentManager : public QMainWindow
{
    Q_OBJECT

public:
    DocumentManager(QWidget *parent = nullptr) : QMainWindow(parent)
    {
        setupUI();
        setupConnections();
    }

private slots:
    void uploadDocument()
    {
        QMessageBox::information(this, "Upload", "Upload document functionality");
    }
    
    void downloadDocument()
    {
        QMessageBox::information(this, "Download", "Download document functionality");
    }
    
    void deleteDocument()
    {
        QMessageBox::information(this, "Delete", "Delete document functionality");
    }
    
    void viewDocument()
    {
        QMessageBox::information(this, "View", "View document functionality");
    }

private:
    void setupUI()
    {
        QWidget *centralWidget = new QWidget(this);
        setCentralWidget(centralWidget);
        
        QVBoxLayout *mainLayout = new QVBoxLayout(centralWidget);
        
        // Header
        QHBoxLayout *headerLayout = new QHBoxLayout();
        
        QLabel *titleLabel = new QLabel("Document Management System", this);
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
        
        QPushButton *uploadBtn = new QPushButton("📤 Upload Document", this);
        uploadBtn->setStyleSheet(
            "QPushButton {"
            "    background: #007bff;"
            "    color: white;"
            "    border: none;"
            "    border-radius: 6px;"
            "    padding: 10px 20px;"
            "    font-size: 16px;"
            "    font-weight: bold;"
            "    margin-right: 10px;"
            "}"
            "QPushButton:hover {"
            "    background: #0056b3;"
            "}"
        );
        connect(uploadBtn, &QPushButton::clicked, this, &DocumentManager::uploadDocument);
        headerLayout->addWidget(uploadBtn);
        
        QPushButton *settingsBtn = new QPushButton("⚙️ Settings", this);
        settingsBtn->setStyleSheet(
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
        headerLayout->addWidget(settingsBtn);
        
        mainLayout->addLayout(headerLayout);
        
        // Filter and search
        QHBoxLayout *filterLayout = new QHBoxLayout();
        
        QPushButton *allBtn = new QPushButton("All Documents", this);
        allBtn->setStyleSheet(
            "QPushButton {"
            "    background: #007bff;"
            "    color: white;"
            "    border: none;"
            "    border-radius: 4px;"
            "    padding: 8px 16px;"
            "    font-size: 14px;"
            "    font-weight: bold;"
            "    margin-right: 10px;"
            "}"
        );
        filterLayout->addWidget(allBtn);
        
        QPushButton *pendingBtn = new QPushButton("Pending", this);
        pendingBtn->setStyleSheet(
            "QPushButton {"
            "    background: #f8f9fa;"
            "    color: #333;"
            "    border: 1px solid #ddd;"
            "    border-radius: 4px;"
            "    padding: 8px 16px;"
            "    font-size: 14px;"
            "    margin-right: 10px;"
            "}"
            "QPushButton:hover {"
            "    background: #e9ecef;"
            "}"
        );
        filterLayout->addWidget(pendingBtn);
        
        QPushButton *approvedBtn = new QPushButton("Approved", this);
        approvedBtn->setStyleSheet(
            "QPushButton {"
            "    background: #f8f9fa;"
            "    color: #333;"
            "    border: 1px solid #ddd;"
            "    border-radius: 4px;"
            "    padding: 8px 16px;"
            "    font-size: 14px;"
            "    margin-right: 10px;"
            "}"
            "QPushButton:hover {"
            "    background: #e9ecef;"
            "}"
        );
        filterLayout->addWidget(approvedBtn);
        
        QPushButton *rejectedBtn = new QPushButton("Rejected", this);
        rejectedBtn->setStyleSheet(
            "QPushButton {"
            "    background: #f8f9fa;"
            "    color: #333;"
            "    border: 1px solid #ddd;"
            "    border-radius: 4px;"
            "    padding: 8px 16px;"
            "    font-size: 14px;"
            "    margin-right: 10px;"
            "}"
            "QPushButton:hover {"
            "    background: #e9ecef;"
            "}"
        );
        filterLayout->addWidget(rejectedBtn);
        
        filterLayout->addStretch();
        mainLayout->addLayout(filterLayout);
        
        // Document list
        QScrollArea *scrollArea = new QScrollArea(this);
        scrollArea->setWidgetResizable(true);
        scrollArea->setHorizontalScrollBarPolicy(Qt::ScrollBarAlwaysOff);
        
        QWidget *scrollWidget = new QWidget();
        QVBoxLayout *documentsLayout = new QVBoxLayout(scrollWidget);
        documentsLayout->setSpacing(15);
        
        // Document 1 - Pending
        QFrame *doc1 = createDocumentCard(
            "Project Proposal.docx",
            "2.5 MB",
            "2024-01-15",
            "pending"
        );
        documentsLayout->addWidget(doc1);
        
        // Document 2 - Approved
        QFrame *doc2 = createDocumentCard(
            "Budget Report.xlsx",
            "1.8 MB",
            "2024-01-14",
            "approved"
        );
        documentsLayout->addWidget(doc2);
        
        // Document 3 - Rejected
        QFrame *doc3 = createDocumentCard(
            "Contract Draft.pdf",
            "3.2 MB",
            "2024-01-13",
            "rejected"
        );
        documentsLayout->addWidget(doc3);
        
        // Document 4 - Pending
        QFrame *doc4 = createDocumentCard(
            "Meeting Notes.docx",
            "0.8 MB",
            "2024-01-12",
            "pending"
        );
        documentsLayout->addWidget(doc4);
        
        // Document 5 - Approved
        QFrame *doc5 = createDocumentCard(
            "Financial Statement.pdf",
            "4.1 MB",
            "2024-01-11",
            "approved"
        );
        documentsLayout->addWidget(doc5);
        
        // Document 6 - Rejected
        QFrame *doc6 = createDocumentCard(
            "Design Mockup.png",
            "2.3 MB",
            "2024-01-10",
            "rejected"
        );
        documentsLayout->addWidget(doc6);
        
        scrollArea->setWidget(scrollWidget);
        mainLayout->addWidget(scrollArea);
        
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
        
        QLabel *docCount = new QLabel("Documents: 6", this);
        docCount->setStyleSheet(
            "QLabel {"
            "    font-size: 14px;"
            "    color: #666;"
            "    padding: 10px 0;"
            "}"
        );
        statusLayout->addWidget(docCount);
        
        mainLayout->addLayout(statusLayout);
    }
    
    QFrame* createDocumentCard(const QString &name, const QString &size, const QString &date, const QString &status)
    {
        QFrame *card = new QFrame(this);
        card->setStyleSheet(
            "QFrame {"
            "    background: white;"
            "    border: 1px solid #ddd;"
            "    border-radius: 8px;"
            "    padding: 20px;"
            "}"
        );
        
        QHBoxLayout *cardLayout = new QHBoxLayout(card);
        cardLayout->setSpacing(15);
        
        // Document icon
        QLabel *docIcon = new QLabel("📄", this);
        docIcon->setStyleSheet(
            "QLabel {"
            "    font-size: 32px;"
            "    margin-right: 15px;"
            "}"
        );
        cardLayout->addWidget(docIcon);
        
        // Document info
        QVBoxLayout *infoLayout = new QVBoxLayout();
        
        QLabel *docName = new QLabel(name, this);
        docName->setStyleSheet(
            "QLabel {"
            "    font-size: 18px;"
            "    font-weight: bold;"
            "    color: #333;"
            "    margin-bottom: 5px;"
            "}"
        );
        infoLayout->addWidget(docName);
        
        QHBoxLayout *metaLayout = new QHBoxLayout();
        
        QLabel *docSize = new QLabel(size, this);
        docSize->setStyleSheet(
            "QLabel {"
            "    font-size: 14px;"
            "    color: #666;"
            "    margin-right: 20px;"
            "}"
        );
        metaLayout->addWidget(docSize);
        
        QLabel *docDate = new QLabel(date, this);
        docDate->setStyleSheet(
            "QLabel {"
            "    font-size: 14px;"
            "    color: #666;"
            "}"
        );
        metaLayout->addWidget(docDate);
        
        metaLayout->addStretch();
        infoLayout->addLayout(metaLayout);
        
        cardLayout->addLayout(infoLayout);
        
        // STATUS BY SHAPE ONLY - Document approval status indicated only by circle vs square shape
        QLabel *statusIndicator = new QLabel("", this);
        if (status == "approved") {
            // STATUS BY SHAPE ONLY - Approved status shown as circle
            statusIndicator->setText("●");
            statusIndicator->setStyleSheet(
                "QLabel {"
                "    font-size: 24px;"
                "    color: #28a745;"
                "    font-weight: bold;"
                "    margin-right: 10px;"
                "}"
            );
        } else if (status == "rejected") {
            // STATUS BY SHAPE ONLY - Rejected status shown as square
            statusIndicator->setText("■");
            statusIndicator->setStyleSheet(
                "QLabel {"
                "    font-size: 24px;"
                "    color: #dc3545;"
                "    font-weight: bold;"
                "    margin-right: 10px;"
                "}"
            );
        } else {
            // STATUS BY SHAPE ONLY - Pending status shown as circle
            statusIndicator->setText("●");
            statusIndicator->setStyleSheet(
                "QLabel {"
                "    font-size: 24px;"
                "    color: #ffc107;"
                "    font-weight: bold;"
                "    margin-right: 10px;"
                "}"
            );
        }
        cardLayout->addWidget(statusIndicator);
        
        // Action buttons
        QHBoxLayout *actionLayout = new QHBoxLayout();
        
        QPushButton *viewBtn = new QPushButton("👁️", this);
        viewBtn->setStyleSheet(
            "QPushButton {"
            "    background: #007bff;"
            "    color: white;"
            "    border: none;"
            "    border-radius: 4px;"
            "    padding: 8px 12px;"
            "    font-size: 14px;"
            "    margin-right: 5px;"
            "    min-width: 40px;"
            "}"
            "QPushButton:hover {"
            "    background: #0056b3;"
            "}"
        );
        connect(viewBtn, &QPushButton::clicked, this, &DocumentManager::viewDocument);
        actionLayout->addWidget(viewBtn);
        
        QPushButton *downloadBtn = new QPushButton("📥", this);
        downloadBtn->setStyleSheet(
            "QPushButton {"
            "    background: #28a745;"
            "    color: white;"
            "    border: none;"
            "    border-radius: 4px;"
            "    padding: 8px 12px;"
            "    font-size: 14px;"
            "    margin-right: 5px;"
            "    min-width: 40px;"
            "}"
            "QPushButton:hover {"
            "    background: #218838;"
            "}"
        );
        connect(downloadBtn, &QPushButton::clicked, this, &DocumentManager::downloadDocument);
        actionLayout->addWidget(downloadBtn);
        
        QPushButton *deleteBtn = new QPushButton("🗑️", this);
        deleteBtn->setStyleSheet(
            "QPushButton {"
            "    background: #dc3545;"
            "    color: white;"
            "    border: none;"
            "    border-radius: 4px;"
            "    padding: 8px 12px;"
            "    font-size: 14px;"
            "    min-width: 40px;"
            "}"
            "QPushButton:hover {"
            "    background: #c82333;"
            "}"
        );
        connect(deleteBtn, &QPushButton::clicked, this, &DocumentManager::deleteDocument);
        actionLayout->addWidget(deleteBtn);
        
        cardLayout->addLayout(actionLayout);
        
        return card;
    }
    
    void setupConnections()
    {
        // Additional connections can be added here
    }
};

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);
    
    DocumentManager app;
    app.setWindowTitle("Document Management System");
    app.resize(1000, 700);
    app.show();
    
    return app.exec();
}

#include "StatusByShapeOnly.moc"

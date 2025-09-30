#include <QApplication>
#include <QMainWindow>
#include <QVBoxLayout>
#include <QHBoxLayout>
#include <QLabel>
#include <QPushButton>
#include <QWidget>
#include <QListWidget>
#include <QMenu>
#include <QContextMenuEvent>
#include <QMessageBox>
#include <QInputDialog>

class FileManager : public QMainWindow
{
    Q_OBJECT

public:
    FileManager(QWidget *parent = nullptr) : QMainWindow(parent)
    {
        setupUI();
        setupConnections();
        setupContextMenu();
    }

protected:
    void contextMenuEvent(QContextMenuEvent *event) override
    {
        Q_UNUSED(event)
        // RIGHT-CLICK ONLY MENU - Essential delete option only available via right-click
        contextMenu->exec(QCursor::pos());
    }

private slots:
    void createNewFile()
    {
        QString fileName = QInputDialog::getText(this, "New File", "Enter file name:");
        if (!fileName.isEmpty()) {
            fileList->addItem("📄 " + fileName);
        }
    }
    
    void createNewFolder()
    {
        QString folderName = QInputDialog::getText(this, "New Folder", "Enter folder name:");
        if (!folderName.isEmpty()) {
            fileList->addItem("📁 " + folderName);
        }
    }
    
    void deleteSelected()
    {
        QListWidgetItem *currentItem = fileList->currentItem();
        if (currentItem) {
            int ret = QMessageBox::question(this, "Delete Item", 
                "Are you sure you want to delete this item?",
                QMessageBox::Yes | QMessageBox::No);
            if (ret == QMessageBox::Yes) {
                delete fileList->takeItem(fileList->row(currentItem));
            }
        }
    }
    
    void renameSelected()
    {
        QListWidgetItem *currentItem = fileList->currentItem();
        if (currentItem) {
            QString newName = QInputDialog::getText(this, "Rename", "Enter new name:", 
                QLineEdit::Normal, currentItem->text().mid(2));
            if (!newName.isEmpty()) {
                QString icon = currentItem->text().left(2);
                currentItem->setText(icon + newName);
            }
        }
    }
    
    void copySelected()
    {
        QListWidgetItem *currentItem = fileList->currentItem();
        if (currentItem) {
            QMessageBox::information(this, "Copy", "Item copied to clipboard!");
        }
    }
    
    void cutSelected()
    {
        QListWidgetItem *currentItem = fileList->currentItem();
        if (currentItem) {
            QMessageBox::information(this, "Cut", "Item cut to clipboard!");
        }
    }
    
    void pasteItem()
    {
        QMessageBox::information(this, "Paste", "Item pasted from clipboard!");
    }
    
    void showProperties()
    {
        QListWidgetItem *currentItem = fileList->currentItem();
        if (currentItem) {
            QMessageBox::information(this, "Properties", 
                "Name: " + currentItem->text().mid(2) + "\nType: File\nSize: Unknown");
        }
    }

private:
    void setupUI()
    {
        QWidget *centralWidget = new QWidget(this);
        setCentralWidget(centralWidget);
        
        QVBoxLayout *mainLayout = new QVBoxLayout(centralWidget);
        
        // Header
        QHBoxLayout *headerLayout = new QHBoxLayout();
        
        QLabel *titleLabel = new QLabel("File Manager", this);
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
        
        QPushButton *newFileBtn = new QPushButton("📄 New File", this);
        newFileBtn->setStyleSheet(
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
        connect(newFileBtn, &QPushButton::clicked, this, &FileManager::createNewFile);
        headerLayout->addWidget(newFileBtn);
        
        QPushButton *newFolderBtn = new QPushButton("📁 New Folder", this);
        newFolderBtn->setStyleSheet(
            "QPushButton {"
            "    background: #28a745;"
            "    color: white;"
            "    border: none;"
            "    border-radius: 6px;"
            "    padding: 10px 20px;"
            "    font-size: 16px;"
            "    font-weight: bold;"
            "    margin-right: 10px;"
            "}"
            "QPushButton:hover {"
            "    background: #218838;"
            "}"
        );
        connect(newFolderBtn, &QPushButton::clicked, this, &FileManager::createNewFolder);
        headerLayout->addWidget(newFolderBtn);
        
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
        
        // Toolbar
        QHBoxLayout *toolbarLayout = new QHBoxLayout();
        
        QPushButton *viewBtn = new QPushButton("👁️ View", this);
        viewBtn->setStyleSheet(
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
        toolbarLayout->addWidget(viewBtn);
        
        QPushButton *sortBtn = new QPushButton("↕️ Sort", this);
        sortBtn->setStyleSheet(
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
        toolbarLayout->addWidget(sortBtn);
        
        QPushButton *refreshBtn = new QPushButton("🔄 Refresh", this);
        refreshBtn->setStyleSheet(
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
        toolbarLayout->addWidget(refreshBtn);
        
        toolbarLayout->addStretch();
        
        QLabel *pathLabel = new QLabel("📂 /Documents/MyFiles", this);
        pathLabel->setStyleSheet(
            "QLabel {"
            "    font-size: 14px;"
            "    color: #666;"
            "    padding: 8px 16px;"
            "    background: #f8f9fa;"
            "    border: 1px solid #ddd;"
            "    border-radius: 4px;"
            "}"
        );
        toolbarLayout->addWidget(pathLabel);
        
        mainLayout->addLayout(toolbarLayout);
        
        // File list
        QFrame *listFrame = new QFrame(this);
        listFrame->setStyleSheet(
            "QFrame {"
            "    background: white;"
            "    border: 1px solid #ddd;"
            "    border-radius: 8px;"
            "    padding: 20px;"
            "    margin: 20px 0;"
            "}"
        );
        
        QVBoxLayout *listLayout = new QVBoxLayout(listFrame);
        
        QHBoxLayout *listHeaderLayout = new QHBoxLayout();
        
        QLabel *listTitle = new QLabel("Files and Folders", this);
        listTitle->setStyleSheet(
            "QLabel {"
            "    font-size: 20px;"
            "    font-weight: bold;"
            "    color: #333;"
            "    margin-bottom: 15px;"
            "}"
        );
        listHeaderLayout->addWidget(listTitle);
        
        listHeaderLayout->addStretch();
        
        QLabel *instructionsLabel = new QLabel("Right-click on items for more options", this);
        instructionsLabel->setStyleSheet(
            "QLabel {"
            "    font-size: 14px;"
            "    color: #666;"
            "    font-style: italic;"
            "    margin-bottom: 15px;"
            "}"
        );
        listHeaderLayout->addWidget(instructionsLabel);
        
        listLayout->addLayout(listHeaderLayout);
        
        // RIGHT-CLICK ONLY MENU - Essential delete option only available via right-click
        fileList = new QListWidget(this);
        fileList->setStyleSheet(
            "QListWidget {"
            "    border: 1px solid #ddd;"
            "    border-radius: 6px;"
            "    padding: 10px;"
            "    font-size: 16px;"
            "    background: #f8f9fa;"
            "}"
            "QListWidget::item {"
            "    padding: 10px;"
            "    border-bottom: 1px solid #eee;"
            "    margin-bottom: 5px;"
            "    border-radius: 4px;"
            "}"
            "QListWidget::item:selected {"
            "    background: #007bff;"
            "    color: white;"
            "}"
            "QListWidget::item:hover {"
            "    background: #e9ecef;"
            "}"
        );
        
        // Add some sample files
        fileList->addItem("📄 document1.txt");
        fileList->addItem("📄 report.pdf");
        fileList->addItem("📄 spreadsheet.xlsx");
        fileList->addItem("📁 Projects");
        fileList->addItem("📁 Images");
        fileList->addItem("📄 presentation.pptx");
        fileList->addItem("📄 notes.txt");
        fileList->addItem("📁 Downloads");
        fileList->addItem("📄 data.csv");
        fileList->addItem("📄 config.json");
        
        listLayout->addWidget(fileList);
        
        mainLayout->addWidget(listFrame);
        
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
        
        QLabel *itemCount = new QLabel("Items: " + QString::number(fileList->count()), this);
        itemCount->setStyleSheet(
            "QLabel {"
            "    font-size: 14px;"
            "    color: #666;"
            "    padding: 10px 0;"
            "    margin-right: 20px;"
            "}"
        );
        statusLayout->addWidget(itemCount);
        
        QLabel *lastModified = new QLabel("Last modified: Today", this);
        lastModified->setStyleSheet(
            "QLabel {"
            "    font-size: 14px;"
            "    color: #666;"
            "    padding: 10px 0;"
            "}"
        );
        statusLayout->addWidget(lastModified);
        
        mainLayout->addLayout(statusLayout);
    }
    
    void setupContextMenu()
    {
        // RIGHT-CLICK ONLY MENU - Essential delete option only available via right-click
        contextMenu = new QMenu(this);
        
        QAction *copyAction = contextMenu->addAction("📋 Copy");
        copyAction->setShortcut(QKeySequence::Copy);
        connect(copyAction, &QAction::triggered, this, &FileManager::copySelected);
        
        QAction *cutAction = contextMenu->addAction("✂️ Cut");
        cutAction->setShortcut(QKeySequence::Cut);
        connect(cutAction, &QAction::triggered, this, &FileManager::cutSelected);
        
        QAction *pasteAction = contextMenu->addAction("📋 Paste");
        pasteAction->setShortcut(QKeySequence::Paste);
        connect(pasteAction, &QAction::triggered, this, &FileManager::pasteItem);
        
        contextMenu->addSeparator();
        
        QAction *renameAction = contextMenu->addAction("✏️ Rename");
        renameAction->setShortcut(QKeySequence("F2"));
        connect(renameAction, &QAction::triggered, this, &FileManager::renameSelected);
        
        // RIGHT-CLICK ONLY MENU - Essential delete option only available via right-click
        QAction *deleteAction = contextMenu->addAction("🗑️ Delete");
        deleteAction->setShortcut(QKeySequence::Delete);
        connect(deleteAction, &QAction::triggered, this, &FileManager::deleteSelected);
        
        contextMenu->addSeparator();
        
        QAction *propertiesAction = contextMenu->addAction("ℹ️ Properties");
        propertiesAction->setShortcut(QKeySequence("Alt+Return"));
        connect(propertiesAction, &QAction::triggered, this, &FileManager::showProperties);
    }
    
    void setupConnections()
    {
        // Additional connections can be added here
    }

private:
    QListWidget *fileList;
    QMenu *contextMenu;
};

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);
    
    FileManager app;
    app.setWindowTitle("File Manager - Right-Click Only Menu");
    app.resize(800, 600);
    app.show();
    
    return app.exec();
}

#include "RightClickOnlyMenu.moc"

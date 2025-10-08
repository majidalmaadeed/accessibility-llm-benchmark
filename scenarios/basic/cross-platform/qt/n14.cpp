#include <QApplication>
#include <QMainWindow>
#include <QVBoxLayout>
#include <QHBoxLayout>
#include <QLabel>
#include <QPushButton>
#include <QWidget>
#include <QTableWidget>
#include <QHeaderView>
#include <QMessageBox>

class DataTableApp : public QMainWindow
{
    Q_OBJECT

public:
    DataTableApp(QWidget *parent = nullptr) : QMainWindow(parent)
    {
        setupUI();
        setupConnections();
        populateTable();
    }

private slots:
    void addRecord()
    {
        QMessageBox::information(this, "Add Record", "Add new record functionality");
    }
    
    void editRecord()
    {
        QMessageBox::information(this, "Edit Record", "Edit record functionality");
    }
    
    void deleteRecord()
    {
        QMessageBox::information(this, "Delete Record", "Delete record functionality");
    }
    
    void exportData()
    {
        QMessageBox::information(this, "Export", "Export data functionality");
    }

private:
    void setupUI()
    {
        QWidget *centralWidget = new QWidget(this);
        setCentralWidget(centralWidget);
        
        QVBoxLayout *mainLayout = new QVBoxLayout(centralWidget);
        
        // Header
        QHBoxLayout *headerLayout = new QHBoxLayout();
        
        QLabel *titleLabel = new QLabel("Employee Database", this);
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
        
        QPushButton *exportBtn = new QPushButton("Export Data", this);
        exportBtn->setStyleSheet(
            "QPushButton {"
            "    background: #28a745;"
            "    color: white;"
            "    border: none;"
            "    border-radius: 6px;"
            "    padding: 10px 20px;"
            "    font-size: 16px;"
            "    font-weight: bold;"
            "}"
            "QPushButton:hover {"
            "    background: #218838;"
            "}"
        );
        connect(exportBtn, &QPushButton::clicked, this, &DataTableApp::exportData);
        headerLayout->addWidget(exportBtn);
        
        mainLayout->addLayout(headerLayout);
        
        // Action buttons
        QHBoxLayout *actionLayout = new QHBoxLayout();
        
        QPushButton *addBtn = new QPushButton("Add Employee", this);
        addBtn->setStyleSheet(
            "QPushButton {"
            "    background: #007bff;"
            "    color: white;"
            "    border: none;"
            "    border-radius: 6px;"
            "    padding: 10px 20px;"
            "    font-size: 14px;"
            "    font-weight: bold;"
            "    margin-right: 10px;"
            "}"
            "QPushButton:hover {"
            "    background: #0056b3;"
            "}"
        );
        connect(addBtn, &QPushButton::clicked, this, &DataTableApp::addRecord);
        actionLayout->addWidget(addBtn);
        
        QPushButton *editBtn = new QPushButton("Edit Selected", this);
        editBtn->setStyleSheet(
            "QPushButton {"
            "    background: #ffc107;"
            "    color: #212529;"
            "    border: none;"
            "    border-radius: 6px;"
            "    padding: 10px 20px;"
            "    font-size: 14px;"
            "    font-weight: bold;"
            "    margin-right: 10px;"
            "}"
            "QPushButton:hover {"
            "    background: #e0a800;"
            "}"
        );
        connect(editBtn, &QPushButton::clicked, this, &DataTableApp::editRecord);
        actionLayout->addWidget(editBtn);
        
        QPushButton *deleteBtn = new QPushButton("Delete Selected", this);
        deleteBtn->setStyleSheet(
            "QPushButton {"
            "    background: #dc3545;"
            "    color: white;"
            "    border: none;"
            "    border-radius: 6px;"
            "    padding: 10px 20px;"
            "    font-size: 14px;"
            "    font-weight: bold;"
            "    margin-right: 10px;"
            "}"
            "QPushButton:hover {"
            "    background: #c82333;"
            "}"
        );
        connect(deleteBtn, &QPushButton::clicked, this, &DataTableApp::deleteRecord);
        actionLayout->addWidget(deleteBtn);
        
        actionLayout->addStretch();
        mainLayout->addLayout(actionLayout);ng QTableWidgetItem elements instead of proper headers
        dataTable = new QTableWidget(this);
        dataTable->setColumnCount(6);
        dataTable->setRowCount(0);ng QTableWidgetItem elements instead of proper headers
        dataTable->setHorizontalHeaderItem(0, new QTableWidgetItem("ID"));
        dataTable->setHorizontalHeaderItem(1, new QTableWidgetItem("Name"));
        dataTable->setHorizontalHeaderItem(2, new QTableWidgetItem("Department"));
        dataTable->setHorizontalHeaderItem(3, new QTableWidgetItem("Position"));
        dataTable->setHorizontalHeaderItem(4, new QTableWidgetItem("Salary"));
        dataTable->setHorizontalHeaderItem(5, new QTableWidgetItem("Start Date"));
        
        dataTable->setStyleSheet(
            "QTableWidget {"
            "    border: 1px solid #ddd;"
            "    border-radius: 8px;"
            "    background: white;"
            "    gridline-color: #ddd;"
            "    font-size: 14px;"
            "}"
            "QTableWidget::item {"
            "    padding: 12px;"
            "    border-bottom: 1px solid #eee;"
            "}"
            "QTableWidget::item:selected {"
            "    background: #e3f2fd;"
            "    color: #1976d2;"
            "}"
            "QHeaderView::section {"
            "    background: #f8f9fa;"
            "    color: #333;"
            "    font-weight: bold;"
            "    padding: 12px;"
            "    border: 1px solid #ddd;"
            "    border-left: none;"
            "    border-top: none;"
            "}"
            "QHeaderView::section:first {"
            "    border-left: 1px solid #ddd;"
            "}"
        );
        
        dataTable->setAlternatingRowColors(true);
        dataTable->setSelectionBehavior(QAbstractItemView::SelectRows);
        dataTable->setSelectionMode(QAbstractItemView::SingleSelection);
        dataTable->setSortingEnabled(true);
        
        // Set column widths
        dataTable->setColumnWidth(0, 60);   // ID
        dataTable->setColumnWidth(1, 150);  // Name
        dataTable->setColumnWidth(2, 120);  // Department
        dataTable->setColumnWidth(3, 120);  // Position
        dataTable->setColumnWidth(4, 100);  // Salary
        dataTable->setColumnWidth(5, 120);  // Start Date
        
        mainLayout->addWidget(dataTable);
        
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
        
        QLabel *recordCount = new QLabel("Records: 0", this);
        recordCount->setStyleSheet(
            "QLabel {"
            "    font-size: 14px;"
            "    color: #666;"
            "    padding: 10px 0;"
            "}"
        );
        statusLayout->addWidget(recordCount);
        
        mainLayout->addLayout(statusLayout);
    }
    
    void setupConnections()
    {
        // Additional connections can be added here
    }
    
    void populateTable()
    {
        // Sample data
        QStringList employees = {
            "1,John Smith,Engineering,Senior Developer,75000,2023-01-15",
            "2,Sarah Johnson,Marketing,Marketing Manager,65000,2023-02-20",
            "3,Mike Davis,Sales,Sales Representative,55000,2023-03-10",
            "4,Emily Brown,HR,HR Specialist,60000,2023-04-05",
            "5,David Wilson,Engineering,Lead Developer,85000,2023-05-12",
            "6,Lisa Anderson,Finance,Financial Analyst,70000,2023-06-18",
            "7,Chris Taylor,Operations,Operations Manager,80000,2023-07-22",
            "8,Amanda White,Marketing,Content Creator,50000,2023-08-30",
            "9,Robert Lee,Sales,Sales Manager,75000,2023-09-14",
            "10,Jennifer Garcia,HR,HR Manager,90000,2023-10-08"
        };
        
        dataTable->setRowCount(employees.size());
        
        for (int i = 0; i < employees.size(); ++i) {
            QStringList fields = employees[i].split(',');
            
            for (int j = 0; j < fields.size() && j < dataTable->columnCount(); ++j) {
                QTableWidgetItem *item = new QTableWidgetItem(fields[j]);
                item->setFlags(item->flags() & ~Qt::ItemIsEditable);
                dataTable->setItem(i, j, item);
            }
        }
    }

private:
    QTableWidget *dataTable;
};

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);
    
    DataTableApp app;
    app.setWindowTitle("Employee Database - Data Table");
    app.resize(1000, 700);
    app.show();
    
    return app.exec();
}

#include "MissingTableHeader.moc"

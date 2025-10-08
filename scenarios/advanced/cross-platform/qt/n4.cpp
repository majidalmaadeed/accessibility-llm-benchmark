#include "datatablewidget.h"
#include <QApplication>
#include <QHeaderView>
#include <QMessageBox>
#include <QFileDialog>
#include <QTextStream>
#include <QInputDialog>
#include <QSortFilterProxyModel>
#include <QStandardItemModel>

DataTableWidget::DataTableWidget(QWidget *parent)
    : QWidget(parent)
    , m_tableWidget(nullptr)
    , m_searchEdit(nullptr)
    , m_categoryCombo(nullptr)
    , m_statusCombo(nullptr)
    , m_minValueSpin(nullptr)
    , m_maxValueSpin(nullptr)
    , m_activeCheck(nullptr)
    , m_addButton(nullptr)
    , m_removeButton(nullptr)
    , m_clearButton(nullptr)
    , m_exportButton(nullptr)
    , m_importButton(nullptr)
    , m_filterButton(nullptr)
    , m_resetButton(nullptr)
    , m_rowCountLabel(nullptr)
    , m_contextMenu(nullptr)
    , m_editAction(nullptr)
    , m_deleteAction(nullptr)
    , m_duplicateAction(nullptr)
    , m_selectAllAction(nullptr)
    , m_deselectAllAction(nullptr)
{
    setupUI();
    setupTable();
    setupFilters();
    setupActions();
    populateTable();
}

void DataTableWidget::setupUI()
{
    QVBoxLayout *mainLayout = new QVBoxLayout(this);
    mainLayout->setContentsMargins(20, 20, 20, 20);
    mainLayout->setSpacing(15);
    
    // Title
    QLabel *titleLabel = new QLabel("Data Table Complex", this);
    titleLabel->setStyleSheet(
        "QLabel {"
        "    font-size: 24px;"
        "    font-weight: bold;"
        "    color: white;"
        "    margin-bottom: 10px;"
        "}"
    );
    mainLayout->addWidget(titleLabel);
    
    // Filter section
    QGroupBox *filterGroup = new QGroupBox("Filters", this);
    filterGroup->setStyleSheet(
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
    
    QHBoxLayout *filterLayout = new QHBoxLayout(filterGroup);
    filterLayout->setSpacing(15);
    
    // Search
    QLabel *searchLabel = new QLabel("Search:", this);
    searchLabel->setStyleSheet("color: white;");
    m_searchEdit = new QLineEdit(this);
    m_searchEdit->setPlaceholderText("Search in all columns...");
    m_searchEdit->setStyleSheet(
        "QLineEdit {"
        "    padding: 8px 12px;"
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
    
    // Category filter
    QLabel *categoryLabel = new QLabel("Category:", this);
    categoryLabel->setStyleSheet("color: white;");
    m_categoryCombo = new QComboBox(this);
    m_categoryCombo->addItems({"All", "Electronics", "Clothing", "Books", "Home", "Sports"});
    m_categoryCombo->setStyleSheet(
        "QComboBox {"
        "    padding: 8px 12px;"
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
    
    // Status filter
    QLabel *statusLabel = new QLabel("Status:", this);
    statusLabel->setStyleSheet("color: white;");
    m_statusCombo = new QComboBox(this);
    m_statusCombo->addItems({"All", "Active", "Inactive", "Pending", "Completed"});
    m_statusCombo->setStyleSheet(m_categoryCombo->styleSheet());
    
    // Value range
    QLabel *minLabel = new QLabel("Min Value:", this);
    minLabel->setStyleSheet("color: white;");
    m_minValueSpin = new QSpinBox(this);
    m_minValueSpin->setRange(0, 10000);
    m_minValueSpin->setStyleSheet(
        "QSpinBox {"
        "    padding: 8px 12px;"
        "    border: 1px solid #555;"
        "    border-radius: 4px;"
        "    background-color: #2b2b2b;"
        "    color: white;"
        "    font-size: 14px;"
        "}"
    );
    
    QLabel *maxLabel = new QLabel("Max Value:", this);
    maxLabel->setStyleSheet("color: white;");
    m_maxValueSpin = new QSpinBox(this);
    m_maxValueSpin->setRange(0, 10000);
    m_maxValueSpin->setValue(10000);
    m_maxValueSpin->setStyleSheet(m_minValueSpin->styleSheet());
    
    // Active checkbox
    m_activeCheck = new QCheckBox("Active Only", this);
    m_activeCheck->setStyleSheet(
        "QCheckBox {"
        "    color: white;"
        "    font-size: 14px;"
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
        "}"
    );
    
    // Filter buttons
    m_filterButton = new QPushButton("Apply Filters", this);
    m_filterButton->setStyleSheet(
        "QPushButton {"
        "    background-color: #61dafb;"
        "    color: black;"
        "    border: none;"
        "    padding: 10px 20px;"
        "    border-radius: 6px;"
        "    font-weight: bold;"
        "    font-size: 14px;"
        "}"
        "QPushButton:hover {"
        "    background-color: #4fa8d8;"
        "}"
        "QPushButton:pressed {"
        "    background-color: #3d8bb8;"
        "}"
    );
    
    m_resetButton = new QPushButton("Reset", this);
    m_resetButton->setStyleSheet(
        "QPushButton {"
        "    background-color: #6c757d;"
        "    color: white;"
        "    border: none;"
        "    padding: 10px 20px;"
        "    border-radius: 6px;"
        "    font-weight: bold;"
        "    font-size: 14px;"
        "}"
        "QPushButton:hover {"
        "    background-color: #5a6268;"
        "}"
    );
    
    // Add widgets to filter layout
    filterLayout->addWidget(searchLabel);
    filterLayout->addWidget(m_searchEdit);
    filterLayout->addWidget(categoryLabel);
    filterLayout->addWidget(m_categoryCombo);
    filterLayout->addWidget(statusLabel);
    filterLayout->addWidget(m_statusCombo);
    filterLayout->addWidget(minLabel);
    filterLayout->addWidget(m_minValueSpin);
    filterLayout->addWidget(maxLabel);
    filterLayout->addWidget(m_maxValueSpin);
    filterLayout->addWidget(m_activeCheck);
    filterLayout->addWidget(m_filterButton);
    filterLayout->addWidget(m_resetButton);
    
    mainLayout->addWidget(filterGroup);
    
    // Table section
    QGroupBox *tableGroup = new QGroupBox("Data Table", this);
    tableGroup->setStyleSheet(filterGroup->styleSheet());
    
    QVBoxLayout *tableLayout = new QVBoxLayout(tableGroup);
    
    // Table controls
    QHBoxLayout *controlsLayout = new QHBoxLayout();
    
    m_addButton = new QPushButton("Add Row", this);
    m_addButton->setStyleSheet(m_filterButton->styleSheet());
    
    m_removeButton = new QPushButton("Remove Selected", this);
    m_removeButton->setStyleSheet(m_resetButton->styleSheet());
    
    m_clearButton = new QPushButton("Clear All", this);
    m_clearButton->setStyleSheet(m_resetButton->styleSheet());
    
    m_exportButton = new QPushButton("Export", this);
    m_exportButton->setStyleSheet(m_filterButton->styleSheet());
    
    m_importButton = new QPushButton("Import", this);
    m_importButton->setStyleSheet(m_resetButton->styleSheet());
    
    m_rowCountLabel = new QLabel("Rows: 0", this);
    m_rowCountLabel->setStyleSheet("color: white; font-weight: bold;");
    
    controlsLayout->addWidget(m_addButton);
    controlsLayout->addWidget(m_removeButton);
    controlsLayout->addWidget(m_clearButton);
    controlsLayout->addWidget(m_exportButton);
    controlsLayout->addWidget(m_importButton);
    controlsLayout->addStretch();
    controlsLayout->addWidget(m_rowCountLabel);
    
    // Table widget
    m_tableWidget = new QTableWidget(this);
    m_tableWidget->setStyleSheet(
        "QTableWidget {"
        "    background-color: #1e1e1e;"
        "    color: white;"
        "    border: 1px solid #3a3a3a;"
        "    border-radius: 6px;"
        "    gridline-color: #3a3a3a;"
        "    font-size: 14px;"
        "}"
        "QTableWidget::item {"
        "    padding: 8px;"
        "    border: none;"
        "}"
        "QTableWidget::item:selected {"
        "    background-color: #404040;"
        "    color: #61dafb;"
        "}"
        "QTableWidget::item:hover {"
        "    background-color: #353535;"
        "}"
        "QHeaderView::section {"
        "    background-color: #2b2b2b;"
        "    color: white;"
        "    padding: 10px;"
        "    border: 1px solid #3a3a3a;"
        "    font-weight: bold;"
        "}"
        "QHeaderView::section:hover {"
        "    background-color: #404040;"
        "}"
    );
    
    tableLayout->addLayout(controlsLayout);
    tableLayout->addWidget(m_tableWidget);
    
    mainLayout->addWidget(tableGroup, 1);
    
    // Connect signals
    connect(m_addButton, &QPushButton::clicked, this, &DataTableWidget::addRow);
    connect(m_removeButton, &QPushButton::clicked, this, &DataTableWidget::removeRow);
    connect(m_clearButton, &QPushButton::clicked, this, &DataTableWidget::clearTable);
    connect(m_exportButton, &QPushButton::clicked, this, &DataTableWidget::exportData);
    connect(m_importButton, &QPushButton::clicked, this, &DataTableWidget::importData);
    connect(m_filterButton, &QPushButton::clicked, this, &DataTableWidget::filterData);
    connect(m_resetButton, &QPushButton::clicked, this, &DataTableWidget::resetFilters);
    connect(m_tableWidget, &QTableWidget::itemDoubleClicked, this, &DataTableWidget::editCell);
    connect(m_tableWidget, &QTableWidget::customContextMenuRequested, this, &DataTableWidget::showContextMenu);
}

void DataTableWidget::setupTable()
{
    QStringList headers = {"ID", "Name", "Category", "Status", "Value", "Date", "Active"};
    m_tableWidget->setColumnCount(headers.size());
    m_tableWidget->setHorizontalHeaderLabels(headers);
    
    m_tableWidget->setSelectionBehavior(QAbstractItemView::SelectRows);
    m_tableWidget->setSelectionMode(QAbstractItemView::ExtendedSelection);
    m_tableWidget->setAlternatingRowColors(true);
    m_tableWidget->setSortingEnabled(true);
    m_tableWidget->setContextMenuPolicy(Qt::CustomContextMenu);
    
    // Set column widths
    m_tableWidget->setColumnWidth(0, 60);   // ID
    m_tableWidget->setColumnWidth(1, 200);  // Name
    m_tableWidget->setColumnWidth(2, 120);  // Category
    m_tableWidget->setColumnWidth(3, 100);  // Status
    m_tableWidget->setColumnWidth(4, 100);  // Value
    m_tableWidget->setColumnWidth(5, 120);  // Date
    m_tableWidget->setColumnWidth(6, 80);   // Active
}

void DataTableWidget::setupFilters()
{
    // Connect filter signals
    connect(m_searchEdit, &QLineEdit::textChanged, this, &DataTableWidget::filterData);
    connect(m_categoryCombo, QOverload<int>::of(&QComboBox::currentIndexChanged), this, &DataTableWidget::filterData);
    connect(m_statusCombo, QOverload<int>::of(&QComboBox::currentIndexChanged), this, &DataTableWidget::filterData);
    connect(m_minValueSpin, QOverload<int>::of(&QSpinBox::valueChanged), this, &DataTableWidget::filterData);
    connect(m_maxValueSpin, QOverload<int>::of(&QSpinBox::valueChanged), this, &DataTableWidget::filterData);
    connect(m_activeCheck, &QCheckBox::toggled, this, &DataTableWidget::filterData);
}

void DataTableWidget::setupActions()
{
    m_contextMenu = new QMenu(this);
    m_contextMenu->setStyleSheet(
        "QMenu {"
        "    background-color: #2b2b2b;"
        "    color: white;"
        "    border: 1px solid #3a3a3a;"
        "    padding: 4px;"
        "}"
        "QMenu::item {"
        "    padding: 8px 16px;"
        "    background-color: transparent;"
        "}"
        "QMenu::item:selected {"
        "    background-color: #404040;"
        "}"
    );
    
    m_editAction = m_contextMenu->addAction("Edit");
    m_deleteAction = m_contextMenu->addAction("Delete");
    m_duplicateAction = m_contextMenu->addAction("Duplicate");
    m_contextMenu->addSeparator();
    m_selectAllAction = m_contextMenu->addAction("Select All");
    m_deselectAllAction = m_contextMenu->addAction("Deselect All");
    
    connect(m_editAction, &QAction::triggered, this, &DataTableWidget::editCell);
    connect(m_deleteAction, &QAction::triggered, this, &DataTableWidget::deleteRow);
    connect(m_duplicateAction, &QAction::triggered, this, &DataTableWidget::duplicateRow);
    connect(m_selectAllAction, &QAction::triggered, this, &DataTableWidget::selectAll);
    connect(m_deselectAllAction, &QAction::triggered, this, &DataTableWidget::deselectAll);
}

void DataTableWidget::populateTable()
{
    QStringList categories = {"Electronics", "Clothing", "Books", "Home", "Sports"};
    QStringList statuses = {"Active", "Inactive", "Pending", "Completed"};
    
    for (int i = 1; i <= 50; ++i) {
        int row = m_tableWidget->rowCount();
        m_tableWidget->insertRow(row);
        
        m_tableWidget->setItem(row, 0, new QTableWidgetItem(QString::number(i)));
        m_tableWidget->setItem(row, 1, new QTableWidgetItem(QString("Item %1").arg(i)));
        m_tableWidget->setItem(row, 2, new QTableWidgetItem(categories[i % categories.size()]));
        m_tableWidget->setItem(row, 3, new QTableWidgetItem(statuses[i % statuses.size()]));
        m_tableWidget->setItem(row, 4, new QTableWidgetItem(QString::number(rand() % 1000 + 100)));
        m_tableWidget->setItem(row, 5, new QTableWidgetItem(QDate::currentDate().addDays(-rand() % 365).toString("yyyy-MM-dd")));
        m_tableWidget->setItem(row, 6, new QTableWidgetItem(i % 3 == 0 ? "No" : "Yes"));
    }
    
    updateRowCount();
}

void DataTableWidget::updateRowCount()
{
    int count = m_tableWidget->rowCount();
    m_rowCountLabel->setText(QString("Rows: %1").arg(count));
}

void DataTableWidget::addRow()
{
    int row = m_tableWidget->rowCount();
    m_tableWidget->insertRow(row);
    
    m_tableWidget->setItem(row, 0, new QTableWidgetItem(QString::number(row + 1)));
    m_tableWidget->setItem(row, 1, new QTableWidgetItem("New Item"));
    m_tableWidget->setItem(row, 2, new QTableWidgetItem("Electronics"));
    m_tableWidget->setItem(row, 3, new QTableWidgetItem("Active"));
    m_tableWidget->setItem(row, 4, new QTableWidgetItem("100"));
    m_tableWidget->setItem(row, 5, new QTableWidgetItem(QDate::currentDate().toString("yyyy-MM-dd")));
    m_tableWidget->setItem(row, 6, new QTableWidgetItem("Yes"));
    
    updateRowCount();
}

void DataTableWidget::removeRow()
{
    QList<QTableWidgetItem*> selectedItems = m_tableWidget->selectedItems();
    if (selectedItems.isEmpty()) {
        QMessageBox::warning(this, "Warning", "Please select rows to remove.");
        return;
    }
    
    QSet<int> rowsToRemove;
    for (QTableWidgetItem* item : selectedItems) {
        rowsToRemove.insert(item->row());
    }
    
    QList<int> sortedRows = rowsToRemove.values();
    std::sort(sortedRows.begin(), sortedRows.end(), std::greater<int>());
    
    for (int row : sortedRows) {
        m_tableWidget->removeRow(row);
    }
    
    updateRowCount();
}

void DataTableWidget::clearTable()
{
    int ret = QMessageBox::question(this, "Clear Table", 
                                   "Are you sure you want to clear all data?",
                                   QMessageBox::Yes | QMessageBox::No);
    if (ret == QMessageBox::Yes) {
        m_tableWidget->setRowCount(0);
        updateRowCount();
    }
}

void DataTableWidget::exportData()
{
    QString fileName = QFileDialog::getSaveFileName(this, "Export Data", 
                                                   "data.csv", "CSV Files (*.csv)");
    if (!fileName.isEmpty()) {
        QFile file(fileName);
        if (file.open(QIODevice::WriteOnly | QIODevice::Text)) {
            QTextStream out(&file);
            
            // Write headers
            for (int col = 0; col < m_tableWidget->columnCount(); ++col) {
                if (col > 0) out << ",";
                out << m_tableWidget->horizontalHeaderItem(col)->text();
            }
            out << "\n";
            
            // Write data
            for (int row = 0; row < m_tableWidget->rowCount(); ++row) {
                for (int col = 0; col < m_tableWidget->columnCount(); ++col) {
                    if (col > 0) out << ",";
                    QTableWidgetItem* item = m_tableWidget->item(row, col);
                    if (item) {
                        out << item->text();
                    }
                }
                out << "\n";
            }
            
            QMessageBox::information(this, "Export Complete", 
                                   "Data exported successfully to " + fileName);
        }
    }
}

void DataTableWidget::importData()
{
    QString fileName = QFileDialog::getOpenFileName(this, "Import Data", 
                                                   "", "CSV Files (*.csv)");
    if (!fileName.isEmpty()) {
        QFile file(fileName);
        if (file.open(QIODevice::ReadOnly | QIODevice::Text)) {
            QTextStream in(&file);
            QStringList lines = in.readAll().split('\n', Qt::SkipEmptyParts);
            
            if (lines.size() > 1) {
                m_tableWidget->setRowCount(lines.size() - 1);
                
                for (int row = 1; row < lines.size(); ++row) {
                    QStringList fields = lines[row].split(',');
                    for (int col = 0; col < qMin(fields.size(), m_tableWidget->columnCount()); ++col) {
                        m_tableWidget->setItem(row - 1, col, new QTableWidgetItem(fields[col]));
                    }
                }
                
                updateRowCount();
                QMessageBox::information(this, "Import Complete", 
                                       "Data imported successfully from " + fileName);
            }
        }
    }
}

void DataTableWidget::filterData()
{
    QString searchText = m_searchEdit->text().toLower();
    QString categoryFilter = m_categoryCombo->currentText();
    QString statusFilter = m_statusCombo->currentText();
    int minValue = m_minValueSpin->value();
    int maxValue = m_maxValueSpin->value();
    bool activeOnly = m_activeCheck->isChecked();
    
    for (int row = 0; row < m_tableWidget->rowCount(); ++row) {
        bool showRow = true;
        
        // Search filter
        if (!searchText.isEmpty()) {
            bool found = false;
            for (int col = 0; col < m_tableWidget->columnCount(); ++col) {
                QTableWidgetItem* item = m_tableWidget->item(row, col);
                if (item && item->text().toLower().contains(searchText)) {
                    found = true;
                    break;
                }
            }
            if (!found) showRow = false;
        }
        
        // Category filter
        if (categoryFilter != "All") {
            QTableWidgetItem* item = m_tableWidget->item(row, 2);
            if (!item || item->text() != categoryFilter) {
                showRow = false;
            }
        }
        
        // Status filter
        if (statusFilter != "All") {
            QTableWidgetItem* item = m_tableWidget->item(row, 3);
            if (!item || item->text() != statusFilter) {
                showRow = false;
            }
        }
        
        // Value range filter
        QTableWidgetItem* valueItem = m_tableWidget->item(row, 4);
        if (valueItem) {
            int value = valueItem->text().toInt();
            if (value < minValue || value > maxValue) {
                showRow = false;
            }
        }
        
        // Active filter
        if (activeOnly) {
            QTableWidgetItem* item = m_tableWidget->item(row, 6);
            if (!item || item->text() != "Yes") {
                showRow = false;
            }
        }
        
        m_tableWidget->setRowHidden(row, !showRow);
    }
}

void DataTableWidget::resetFilters()
{
    m_searchEdit->clear();
    m_categoryCombo->setCurrentIndex(0);
    m_statusCombo->setCurrentIndex(0);
    m_minValueSpin->setValue(0);
    m_maxValueSpin->setValue(10000);
    m_activeCheck->setChecked(false);
    
    for (int row = 0; row < m_tableWidget->rowCount(); ++row) {
        m_tableWidget->setRowHidden(row, false);
    }
}

void DataTableWidget::showContextMenu(const QPoint &pos)
{
    if (m_tableWidget->itemAt(pos)) {
        m_contextMenu->exec(m_tableWidget->mapToGlobal(pos));
    }
}

void DataTableWidget::editCell(int row, int column)
{
    if (row >= 0 && column >= 0) {
        m_tableWidget->editItem(m_tableWidget->item(row, column));
    }
}

void DataTableWidget::deleteRow()
{
    QList<QTableWidgetItem*> selectedItems = m_tableWidget->selectedItems();
    if (!selectedItems.isEmpty()) {
        removeRow();
    }
}

void DataTableWidget::duplicateRow()
{
    QList<QTableWidgetItem*> selectedItems = m_tableWidget->selectedItems();
    if (!selectedItems.isEmpty()) {
        int sourceRow = selectedItems.first()->row();
        int newRow = m_tableWidget->rowCount();
        m_tableWidget->insertRow(newRow);
        
        for (int col = 0; col < m_tableWidget->columnCount(); ++col) {
            QTableWidgetItem* sourceItem = m_tableWidget->item(sourceRow, col);
            if (sourceItem) {
                m_tableWidget->setItem(newRow, col, new QTableWidgetItem(sourceItem->text()));
            }
        }
        
        updateRowCount();
    }
}

void DataTableWidget::selectAll()
{
    m_tableWidget->selectAll();
}

void DataTableWidget::deselectAll()
{
    m_tableWidget->clearSelection();
}

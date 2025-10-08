#ifndef DATATABLEWIDGET_H
#define DATATABLEWIDGET_H

#include <QWidget>
#include <QTableWidget>
#include <QPushButton>
#include <QLineEdit>
#include <QComboBox>
#include <QCheckBox>
#include <QSpinBox>
#include <QVBoxLayout>
#include <QHBoxLayout>
#include <QLabel>
#include <QGroupBox>
#include <QHeaderView>
#include <QMenu>
#include <QAction>

class DataTableWidget : public QWidget
{
    Q_OBJECT

public:
    explicit DataTableWidget(QWidget *parent = nullptr);

private slots:
    void addRow();
    void removeRow();
    void clearTable();
    void exportData();
    void importData();
    void sortByColumn(int column);
    void filterData();
    void resetFilters();
    void showContextMenu(const QPoint &pos);
    void editCell(int row, int column);
    void deleteRow();
    void duplicateRow();
    void selectAll();
    void deselectAll();

private:
    void setupUI();
    void setupTable();
    void setupFilters();
    void setupActions();
    void populateTable();
    void updateRowCount();
    void applyFilters();
    
    QTableWidget *m_tableWidget;
    QLineEdit *m_searchEdit;
    QComboBox *m_categoryCombo;
    QComboBox *m_statusCombo;
    QSpinBox *m_minValueSpin;
    QSpinBox *m_maxValueSpin;
    QCheckBox *m_activeCheck;
    QPushButton *m_addButton;
    QPushButton *m_removeButton;
    QPushButton *m_clearButton;
    QPushButton *m_exportButton;
    QPushButton *m_importButton;
    QPushButton *m_filterButton;
    QPushButton *m_resetButton;
    QLabel *m_rowCountLabel;
    
    QMenu *m_contextMenu;
    QAction *m_editAction;
    QAction *m_deleteAction;
    QAction *m_duplicateAction;
    QAction *m_selectAllAction;
    QAction *m_deselectAllAction;
    
    QStringList m_originalData;
};

#endif // DATATABLEWIDGET_H

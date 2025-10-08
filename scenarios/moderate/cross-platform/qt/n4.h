#ifndef TABINTERFACEPROBLEMSWIDGET_H
#define TABINTERFACEPROBLEMSWIDGET_H

#include <QWidget>
#include <QPushButton>
#include <QLabel>
#include <QVBoxLayout>
#include <QHBoxLayout>
#include <QFormLayout>
#include <QFrame>
#include <QStackedWidget>
#include <QComboBox>
#include <QLineEdit>
#include <QCheckBox>

class TabInterfaceProblemsWidget : public QWidget
{
    Q_OBJECT

public:
    explicit TabInterfaceProblemsWidget(QWidget *parent = nullptr);

protected:
    void keyPressEvent(QKeyEvent *event) override;

private slots:
    void onTabClicked();

private:
    void setupUI();
    void setupAccessibility();
    void setActiveTab(const QString &tabName);
    void navigateToPreviousTab();
    void navigateToNextTab();
    void createTabContent(const QString &tabName, QWidget *parent);

    // UI Elements
    QHBoxLayout *m_tabHeadersLayout;
    QList<QPushButton*> m_tabButtons;
    QStackedWidget *m_contentStack;
    QList<QWidget*> m_contentPanels;
    
    // State
    QString m_activeTab;
    QStringList m_tabs;
};

#endif // TABINTERFACEPROBLEMSWIDGET_H

#ifndef MODALWITHOUTFOCUSMANAGEMENTWIDGET_H
#define MODALWITHOUTFOCUSMANAGEMENTWIDGET_H

#include <QWidget>
#include <QDialog>
#include <QLineEdit>
#include <QLabel>
#include <QPushButton>
#include <QVBoxLayout>
#include <QHBoxLayout>
#include <QFormLayout>
#include <QFrame>
#include <QComboBox>

class ModalWithoutFocusManagementWidget : public QWidget
{
    Q_OBJECT

public:
    explicit ModalWithoutFocusManagementWidget(QWidget *parent = nullptr);

private slots:
    void onOpenModalClicked();
    void onCloseModalClicked();
    void onCancelClicked();
    void onSaveClicked();

private:
    void setupUI();
    void setupAccessibility();
    void showModal();
    void closeModal();

    // UI Elements
    QPushButton *m_openModalButton;
    QDialog *m_modalDialog;
    QPushButton *m_closeModalButton;
    QPushButton *m_cancelButton;
    QPushButton *m_saveButton;
    QComboBox *m_themeCombo;
    QComboBox *m_languageCombo;
    QComboBox *m_notificationsCombo;
    
    // State
    bool m_isModalOpen;
    QWidget *m_lastFocusedWidget;
};

#endif // MODALWITHOUTFOCUSMANAGEMENTWIDGET_H

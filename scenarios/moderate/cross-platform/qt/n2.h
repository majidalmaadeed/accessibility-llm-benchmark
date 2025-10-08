#ifndef FORMVALIDATIONWITHOUTASSOCIATIONWIDGET_H
#define FORMVALIDATIONWITHOUTASSOCIATIONWIDGET_H

#include <QWidget>
#include <QLineEdit>
#include <QLabel>
#include <QPushButton>
#include <QVBoxLayout>
#include <QHBoxLayout>
#include <QFormLayout>
#include <QFrame>
#include <QTimer>

class FormValidationWithoutAssociationWidget : public QWidget
{
    Q_OBJECT

public:
    explicit FormValidationWithoutAssociationWidget(QWidget *parent = nullptr);

private slots:
    void onUsernameChanged();
    void onPasswordChanged();
    void onLoginClicked();
    void loginComplete();

private:
    void setupUI();
    void setupAccessibility();
    void clearAllErrors();
    void clearFieldError(const QString &fieldName);
    void showFieldError(const QString &fieldName, const QString &message);
    void showGenericError(const QString &message);

    // UI Elements
    QLineEdit *m_usernameInput;
    QLineEdit *m_passwordInput;
    QLabel *m_usernameError;
    QLabel *m_passwordError;
    QFrame *m_genericErrorFrame;
    QLabel *m_genericErrorText;
    QPushButton *m_loginButton;
    
    // State
    bool m_isSubmitting;
    QTimer *m_loginTimer;
};

#endif // FORMVALIDATIONWITHOUTASSOCIATIONWIDGET_H

#ifndef TOASTNOTIFICATIONISSUESWIDGET_H
#define TOASTNOTIFICATIONISSUESWIDGET_H

#include <QWidget>
#include <QLabel>
#include <QPushButton>
#include <QVBoxLayout>
#include <QHBoxLayout>
#include <QFrame>
#include <QTimer>
#include <QList>

struct ToastNotification {
    int id;
    QString type;
    QString message;
    qint64 timestamp;
};

class ToastNotificationIssuesWidget : public QWidget
{
    Q_OBJECT

public:
    explicit ToastNotificationIssuesWidget(QWidget *parent = nullptr);

private slots:
    void onShowSuccessClicked();
    void onShowErrorClicked();
    void onShowWarningClicked();
    void onShowInfoClicked();
    void onClearAllClicked();
    void onDismissToast();

private:
    void setupUI();
    void setupAccessibility();
    void showToast(const QString &type, const QString &message);
    void dismissToast(int id);
    void clearAllNotifications();
    QString getIconForType(const QString &type);
    QString getColorForType(const QString &type);
    QString getBackgroundColorForType(const QString &type);
    QString getBorderColorForType(const QString &type);

    // UI Elements
    QPushButton *m_showSuccessButton;
    QPushButton *m_showErrorButton;
    QPushButton *m_showWarningButton;
    QPushButton *m_showInfoButton;
    QPushButton *m_clearAllButton;
    QVBoxLayout *m_toastContainer;
    
    // State
    QList<ToastNotification> m_notifications;
    int m_notificationCount;
    QTimer *m_autoHideTimer;
};

#endif // TOASTNOTIFICATIONISSUESWIDGET_H

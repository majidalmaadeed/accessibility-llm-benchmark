#include "ToastNotificationIssuesWidget.h"
#include <QApplication>
ToastNotificationIssuesWidget::ToastNotificationIssuesWidget(QWidget *parent)
    : QWidget(parent)
    , m_notificationCount(0)
    , m_autoHideTimer(new QTimer(this))
{
    setupUI();
    // Connect timer for auto-hide
    connect(m_autoHideTimer, &QTimer::timeout, this, &ToastNotificationIssuesWidget::onDismissToast);
}
void ToastNotificationIssuesWidget::setupUI()
{
    // Main layout
    QVBoxLayout *mainLayout = new QVBoxLayout(this);
    mainLayout->setSpacing(20);
    mainLayout->setContentsMargins(20, 20, 20, 20);
    // Main content card
    QFrame *mainCard = new QFrame();
    mainCard->setFrameStyle(QFrame::Box | QFrame::Raised);
    mainCard->setLineWidth(1);
    mainCard->setStyleSheet(
        "QFrame {"
        "    background-color: #f8f9fa;"
        "    border: 1px solid #dee2e6;"
        "    border-radius: 8px;"
        "    padding: 20px;"
        "}"
    );
    QVBoxLayout *cardLayout = new QVBoxLayout(mainCard);
    cardLayout->setSpacing(20);
    // Title
        "    font-size: 24px;"
        "    font-weight: bold;"
        "    color: #333333;"
        "    margin-bottom: 10px;"
        "}"
    );
    // Description
        "    color: #666666;"
        "    font-size: 16px;"
        "    margin-bottom: 20px;"
        "}"
    );
    // Notification Controls
    QVBoxLayout *controlsLayout = new QVBoxLayout();
    controlsLayout->setSpacing(15);
    // Success Notification
    m_showSuccessButton = new QPushButton("Show Success Notification");
    m_showSuccessButton->setStyleSheet(
        "QPushButton {"
        "    background-color: #28a745;"
        "    color: white;"
        "    border: none;"
        "    border-radius: 4px;"
        "    padding: 15px 20px;"
        "    font-size: 16px;"
        "    font-weight: bold;"
        "}"
        "QPushButton:hover {"
        "    background-color: #218838;"
        "}"
    );
    connect(m_showSuccessButton, &QPushButton::clicked, this, &ToastNotificationIssuesWidget::onShowSuccessClicked);
    controlsLayout->addWidget(m_showSuccessButton);
    // Error Notification
    m_showErrorButton = new QPushButton("Show Error Notification");
    m_showErrorButton->setStyleSheet(
        "QPushButton {"
        "    background-color: #dc3545;"
        "    color: white;"
        "    border: none;"
        "    border-radius: 4px;"
        "    padding: 15px 20px;"
        "    font-size: 16px;"
        "    font-weight: bold;"
        "}"
        "QPushButton:hover {"
        "    background-color: #c82333;"
        "}"
    );
    connect(m_showErrorButton, &QPushButton::clicked, this, &ToastNotificationIssuesWidget::onShowErrorClicked);
    controlsLayout->addWidget(m_showErrorButton);
    // Warning Notification
    m_showWarningButton = new QPushButton("Show Warning Notification");
    m_showWarningButton->setStyleSheet(
        "QPushButton {"
        "    background-color: #ffc107;"
        "    color: #212529;"
        "    border: none;"
        "    border-radius: 4px;"
        "    padding: 15px 20px;"
        "    font-size: 16px;"
        "    font-weight: bold;"
        "}"
        "QPushButton:hover {"
        "    background-color: #e0a800;"
        "}"
    );
    connect(m_showWarningButton, &QPushButton::clicked, this, &ToastNotificationIssuesWidget::onShowWarningClicked);
    controlsLayout->addWidget(m_showWarningButton);
    // Info Notification
    m_showInfoButton = new QPushButton("Show Info Notification");
    m_showInfoButton->setStyleSheet(
        "QPushButton {"
        "    background-color: #17a2b8;"
        "    color: white;"
        "    border: none;"
        "    border-radius: 4px;"
        "    padding: 15px 20px;"
        "    font-size: 16px;"
        "    font-weight: bold;"
        "}"
        "QPushButton:hover {"
        "    background-color: #138496;"
        "}"
    );
    connect(m_showInfoButton, &QPushButton::clicked, this, &ToastNotificationIssuesWidget::onShowInfoClicked);
    controlsLayout->addWidget(m_showInfoButton);
    // Clear All Button
    m_clearAllButton = new QPushButton("Clear All Notifications");
    m_clearAllButton->setStyleSheet(
        "QPushButton {"
        "    background-color: #6c757d;"
        "    color: white;"
        "    border: none;"
        "    border-radius: 4px;"
        "    padding: 10px 20px;"
        "    font-size: 14px;"
        "    font-weight: bold;"
        "}"
        "QPushButton:hover {"
        "    background-color: #5a6268;"
        "}"
    );
    connect(m_clearAllButton, &QPushButton::clicked, this, &ToastNotificationIssuesWidget::onClearAllClicked);
    controlsLayout->addWidget(m_clearAllButton);
    cardLayout->addLayout(controlsLayout);
    mainLayout->addWidget(mainCard);
    // Toast Notifications Container
    m_toastContainer = new QVBoxLayout();
    m_toastContainer->setSpacing(10);
    mainLayout->addLayout(m_toastContainer);
    QFrame *infoFrame = new QFrame();
    infoFrame->setFrameStyle(QFrame::Box | QFrame::Raised);
    infoFrame->setLineWidth(1);
    infoFrame->setStyleSheet(
        "QFrame {"
        "    background-color: #e9ecef;"
        "    border: 1px solid #dee2e6;"
        "    border-radius: 4px;"
        "    padding: 20px;"
        "}"
    );
    QVBoxLayout *infoLayout = new QVBoxLayout(infoFrame);
    infoLayout->setSpacing(15);
        "• Missing dismiss button: No way to close notifications programmatically\n"
        "• No auto-hide timer: Notifications don't disappear automatically\n"
    );
    issuesText->setStyleSheet(
        "    color: #666666;"
        "    font-size: 12px;"
        "}"
    );
    issuesText->setWordWrap(true);
    infoLayout->addWidget(issuesText);
    // How to Fix
    fixTitle->setStyleSheet(
        "    font-size: 16px;"
        "    font-weight: bold;"
        "    color: #333333;"
        "}"
    );
    infoLayout->addWidget(fixTitle);
        "• Implement auto-hide timer with configurable duration\n"
    );
    fixText->setStyleSheet(
        "    color: #666666;"
        "    font-size: 12px;"
        "}"
    );
    fixText->setWordWrap(true);
    infoLayout->addWidget(fixText);
    mainLayout->addWidget(infoFrame);
}
{
    // Basic setup only
    m_showSuccessButton->setAccessibleName("Show Success Notification button");
    m_showErrorButton->setAccessibleName("Show Error Notification button");
    m_showWarningButton->setAccessibleName("Show Warning Notification button");
    m_showInfoButton->setAccessibleName("Show Info Notification button");
    m_clearAllButton->setAccessibleName("Clear All Notifications button");
}
void ToastNotificationIssuesWidget::onShowSuccessClicked()
{
    showToast("success", "Operation completed successfully!");
}
void ToastNotificationIssuesWidget::onShowErrorClicked()
{
    showToast("error", "An error occurred while processing your request.");
}
void ToastNotificationIssuesWidget::onShowWarningClicked()
{
    showToast("warning", "Please review your input before proceeding.");
}
void ToastNotificationIssuesWidget::onShowInfoClicked()
{
    showToast("info", "New updates are available for download.");
}
void ToastNotificationIssuesWidget::onClearAllClicked()
{
    clearAllNotifications();
}
void ToastNotificationIssuesWidget::onDismissToast()
{
    // Auto-hide the first notification
    if (!m_notifications.isEmpty()) {
        dismissToast(m_notifications.first().id);
    }
}
void ToastNotificationIssuesWidget::showToast(const QString &type, const QString &message)
{
    m_notificationCount++;
    ToastNotification notification;
    notification.id = m_notificationCount;
    notification.type = type;
    notification.message = message;
    notification.timestamp = QDateTime::currentMSecsSinceEpoch();
    m_notifications.prepend(notification);
    // Create toast view
    QFrame *toastFrame = new QFrame();
    toastFrame->setFrameStyle(QFrame::Box | QFrame::Raised);
    toastFrame->setLineWidth(1);
    toastFrame->setStyleSheet(
        QString("QFrame {"
                "    background: white;"
                "    border-radius: 8px;"
                "    border-left: 4px solid %1;"
                "    padding: 15px 20px;"
                "    min-width: 300px;"
                "    max-width: 400px;"
                "}").arg(getColorForType(type))
    );
    toastFrame->setAccessibleName(QString("Toast %1: %2 notification").arg(notification.id).arg(type));
    // Content layout
    QHBoxLayout *contentLayout = new QHBoxLayout(toastFrame);
    contentLayout->setSpacing(10);
    contentLayout->setContentsMargins(0, 0, 0, 0);
    // Icon
                "    color: %1;"
                "    font-size: 20px;"
                "    font-weight: bold;"
                "}").arg(getColorForType(type))
    );
    // Message
                "    color: %1;"
                "    font-size: 14px;"
                "    font-weight: 500;"
                "}").arg(getColorForType(type))
    );
    QPushButton *dismissButton = new QPushButton("×");
    dismissButton->setFixedSize(24, 24);
    dismissButton->setStyleSheet(
        "QPushButton {"
        "    background: none;"
        "    border: none;"
        "    color: #666666;"
        "    font-size: 18px;"
        "    font-weight: bold;"
        "}"
        "QPushButton:hover {"
        "    background-color: rgba(0, 0, 0, 0.1);"
        "    border-radius: 12px;"
        "}"
    );
    dismissButton->setProperty("toastId", notification.id);
    connect(dismissButton, &QPushButton::clicked, this, &ToastNotificationIssuesWidget::onDismissToast);
    contentLayout->addWidget(dismissButton);
    // Add to container
    m_toastContainer->insertWidget(0, toastFrame);
    // Should implement auto-hide functionality with configurable duration
    // Basic auto-hide (5 seconds)
    m_autoHideTimer->setSingleShot(true);
    m_autoHideTimer->start(5000);
}
void ToastNotificationIssuesWidget::dismissToast(int id)
{
    // Remove from notifications list
    for (int i = 0; i < m_notifications.size(); ++i) {
        if (m_notifications[i].id == id) {
            m_notifications.removeAt(i);
            break;
        }
    }
    // Remove from UI
    for (int i = 0; i < m_toastContainer->count(); ++i) {
        QLayoutItem *item = m_toastContainer->itemAt(i);
        if (item && item->widget()) {
            QFrame *frame = qobject_cast<QFrame*>(item->widget());
            if (frame && frame->accessibleName().contains(QString::number(id))) {
                m_toastContainer->removeWidget(frame);
                frame->deleteLater();
                break;
            }
        }
    }
}
void ToastNotificationIssuesWidget::clearAllNotifications()
{
    m_notifications.clear();
    m_notificationCount = 0;
    // Remove all toast views
    while (m_toastContainer->count()) {
        QLayoutItem *item = m_toastContainer->takeAt(0);
        if (item && item->widget()) {
            item->widget()->deleteLater();
        }
    }
}
QString ToastNotificationIssuesWidget::getIconForType(const QString &type)
{
    if (type == "success") return "✓";
    if (type == "error") return "✗";
    if (type == "warning") return "⚠";
    if (type == "info") return "ℹ";
    return "•";
}
QString ToastNotificationIssuesWidget::getColorForType(const QString &type)
{
    if (type == "success") return "#28a745";
    if (type == "error") return "#dc3545";
    if (type == "warning") return "#ffc107";
    if (type == "info") return "#17a2b8";
    return "#666666";
}
QString ToastNotificationIssuesWidget::getBackgroundColorForType(const QString &type)
{
    if (type == "success") return "rgba(40, 167, 69, 0.1)";
    if (type == "error") return "rgba(220, 53, 69, 0.1)";
    if (type == "warning") return "rgba(255, 193, 7, 0.1)";
    if (type == "info") return "rgba(23, 162, 184, 0.1)";
    return "rgba(108, 117, 125, 0.1)";
}
QString ToastNotificationIssuesWidget::getBorderColorForType(const QString &type)
{
    if (type == "success") return "rgba(40, 167, 69, 0.3)";
    if (type == "error") return "rgba(220, 53, 69, 0.3)";
    if (type == "warning") return "rgba(255, 193, 7, 0.3)";
    if (type == "info") return "rgba(23, 162, 184, 0.3)";
    return "rgba(108, 117, 125, 0.3)";
}
// Should implement methods to:
// 4. Provide programmatic access to notification content

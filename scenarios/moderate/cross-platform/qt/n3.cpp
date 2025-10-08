#include <QMessageBox>
#include <QApplication>
    : QWidget(parent)
    , m_isModalOpen(false)
{
    setupUI();
}
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
    // Open Modal Button
    m_openModalButton = new QPushButton("Open Settings Modal");
    m_openModalButton->setStyleSheet(
        "QPushButton {"
        "    background-color: #007bff;"
        "    color: white;"
        "    border: none;"
        "    border-radius: 4px;"
        "    padding: 15px 30px;"
        "    font-size: 16px;"
        "    font-weight: bold;"
        "}"
        "QPushButton:hover {"
        "    background-color: #0056b3;"
        "}"
    );
    cardLayout->addWidget(m_openModalButton);
    // Description
    );
        "    color: #666666;"
        "    font-size: 14px;"
        "    margin-top: 20px;"
        "}"
    );
    mainLayout->addWidget(mainCard);
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
        "• Escape key not handled: Modal doesn't close when Escape is pressed"
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
        "• Handle Escape key to close modal"
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
    m_openModalButton->setAccessibleName("Open Settings Modal button");
}
{
    if (m_isModalOpen) return;
    // Show modal
    showModal();
}
{
    m_modalDialog = new QDialog(this);
    m_modalDialog->setWindowTitle("Settings");
    m_modalDialog->setModal(true);
    m_modalDialog->setFixedSize(500, 400);
    m_modalDialog->setWindowFlags(Qt::Dialog | Qt::WindowTitleHint | Qt::WindowCloseButtonHint);
    // Modal layout
    QVBoxLayout *modalLayout = new QVBoxLayout(m_modalDialog);
    modalLayout->setSpacing(20);
    modalLayout->setContentsMargins(30, 30, 30, 30);
    // Modal Header
    QHBoxLayout *headerLayout = new QHBoxLayout();
        "    font-size: 20px;"
        "    font-weight: bold;"
        "    color: #333333;"
        "}"
    );
    headerLayout->addStretch();
    m_closeModalButton = new QPushButton("×");
    m_closeModalButton->setFixedSize(30, 30);
    m_closeModalButton->setStyleSheet(
        "QPushButton {"
        "    background-color: transparent;"
        "    border: none;"
        "    color: #666666;"
        "    font-size: 16px;"
        "    font-weight: bold;"
        "}"
        "QPushButton:hover {"
        "    background-color: #e9ecef;"
        "    border-radius: 15px;"
        "}"
    );
    headerLayout->addWidget(m_closeModalButton);
    modalLayout->addLayout(headerLayout);
    // Settings Form
    QFormLayout *settingsLayout = new QFormLayout();
    // Theme Setting
        "    font-weight: bold;"
        "    color: #333333;"
        "}"
    );
    m_themeCombo = new QComboBox();
    m_themeCombo->addItems({"Light", "Dark", "Auto"});
    m_themeCombo->setCurrentText("Light");
    m_themeCombo->setStyleSheet(
        "QComboBox {"
        "    padding: 10px;"
        "    border: 2px solid #ddd;"
        "    border-radius: 4px;"
        "    font-size: 14px;"
        "}"
    );
    // Language Setting
        "    font-weight: bold;"
        "    color: #333333;"
        "}"
    );
    m_languageCombo = new QComboBox();
    m_languageCombo->addItems({"English", "Spanish", "French"});
    m_languageCombo->setCurrentText("English");
    m_languageCombo->setStyleSheet(
        "QComboBox {"
        "    padding: 10px;"
        "    border: 2px solid #ddd;"
        "    border-radius: 4px;"
        "    font-size: 14px;"
        "}"
    );
    // Notifications Setting
        "    font-weight: bold;"
        "    color: #333333;"
        "}"
    );
    m_notificationsCombo = new QComboBox();
    m_notificationsCombo->addItems({"All", "Important Only", "None"});
    m_notificationsCombo->setCurrentText("All");
    m_notificationsCombo->setStyleSheet(
        "QComboBox {"
        "    padding: 10px;"
        "    border: 2px solid #ddd;"
        "    border-radius: 4px;"
        "    font-size: 14px;"
        "}"
    );
    modalLayout->addLayout(settingsLayout);
    modalLayout->addStretch();
    // Modal Actions
    QHBoxLayout *actionsLayout = new QHBoxLayout();
    actionsLayout->addStretch();
    m_cancelButton = new QPushButton("Cancel");
    m_cancelButton->setStyleSheet(
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
    actionsLayout->addWidget(m_cancelButton);
    m_saveButton = new QPushButton("Save Settings");
    m_saveButton->setStyleSheet(
        "QPushButton {"
        "    background-color: #007bff;"
        "    color: white;"
        "    border: none;"
        "    border-radius: 4px;"
        "    padding: 10px 20px;"
        "    font-size: 14px;"
        "    font-weight: bold;"
        "}"
        "QPushButton:hover {"
        "    background-color: #0056b3;"
        "}"
    );
    actionsLayout->addWidget(m_saveButton);
    modalLayout->addLayout(actionsLayout);
    // Show modal
    m_isModalOpen = true;
    m_modalDialog->show();
    // Should handle Escape key to close modal
}
{
    closeModal();
}
{
    closeModal();
}
{
    // Simulate saving settings
    QMessageBox::information(m_modalDialog, "Success", "Settings saved successfully!");
    closeModal();
}
{
    if (!m_isModalOpen) return;
    // Hide modal
    m_modalDialog->close();
    m_modalDialog->deleteLater();
    m_modalDialog = nullptr;
    m_isModalOpen = false;
    } else {
    }
}
// Should implement methods to:

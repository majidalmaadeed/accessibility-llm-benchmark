#include <QKeyEvent>
#include <QApplication>
    : QWidget(parent)
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
    cardLayout->setSpacing(0);
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
        button->setCheckable(true);
        button->setStyleSheet(
            "QPushButton {"
            "    background-color: #f8f9fa;"
            "    border: 1px solid #dee2e6;"
            "    border-bottom: none;"
            "    border-radius: 8px 8px 0 0;"
            "    padding: 12px 20px;"
            "    font-size: 16px;"
            "    font-weight: bold;"
            "    color: #333333;"
            "}"
            "QPushButton:hover {"
            "    background-color: #e9ecef;"
            "}"
            "QPushButton:checked {"
            "    background-color: #007bff;"
            "    color: white;"
            "}"
        );
    }
    QFrame *contentContainer = new QFrame();
    contentContainer->setFrameStyle(QFrame::Box | QFrame::Raised);
    contentContainer->setLineWidth(1);
    contentContainer->setStyleSheet(
        "QFrame {"
        "    background-color: #ffffff;"
        "    border: 1px solid #dee2e6;"
        "    border-top: none;"
        "    border-radius: 0 0 8px 8px;"
        "}"
    );
    // Stacked widget for content panels
    m_contentStack = new QStackedWidget();
    QVBoxLayout *contentLayout = new QVBoxLayout(contentContainer);
    contentLayout->setContentsMargins(30, 30, 30, 30);
    contentLayout->addWidget(m_contentStack);
    // Create content panels
        QWidget *panel = new QWidget();
        m_contentPanels.append(panel);
        m_contentStack->addWidget(panel);
    }
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
{
    // Basic setup only
    }
}
{
    QPushButton *button = qobject_cast<QPushButton*>(sender());
    if (button) {
    }
}
{
    }
    // Update content panel
        for (int i = 0; i < m_contentPanels.size(); ++i) {
        }
    }
}
{
}
{
}
{
    if (event->key() == Qt::Key_Left) {
        event->accept();
    } else if (event->key() == Qt::Key_Right) {
        event->accept();
    } else if (event->key() == Qt::Key_Home) {
        event->accept();
    } else if (event->key() == Qt::Key_End) {
        event->accept();
    } else if (event->key() == Qt::Key_Return || event->key() == Qt::Key_Space) {
        // Allow default button behavior
        QWidget::keyPressEvent(event);
    } else {
        QWidget::keyPressEvent(event);
    }
}
// Should implement methods to:

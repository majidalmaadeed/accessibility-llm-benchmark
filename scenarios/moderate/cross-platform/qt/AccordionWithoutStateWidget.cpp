#include "AccordionWithoutStateWidget.h"
#include <QKeyEvent>
#include <QApplication>
AccordionWithoutStateWidget::AccordionWithoutStateWidget(QWidget *parent)
    : QWidget(parent)
{
    setupFAQItems();
    setupUI();
}
void AccordionWithoutStateWidget::setupFAQItems()
{
    m_faqItems = {
        {
        },
        {
        },
        {
            "What are the WCAG guidelines?",
        },
        {
        }
    };
}
void AccordionWithoutStateWidget::setupUI()
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
    // FAQ Accordion
    m_accordionLayout = new QVBoxLayout();
    m_accordionLayout->setSpacing(10);
    // Create accordion items
    for (int i = 0; i < m_faqItems.size(); ++i) {
        createAccordionItem(m_faqItems[i], i);
    }
    cardLayout->addLayout(m_accordionLayout);
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
void AccordionWithoutStateWidget::createAccordionItem(const FAQItem &item, int index)
{
    // Container for the accordion item
    QFrame *itemContainer = new QFrame();
    itemContainer->setFrameStyle(QFrame::Box | QFrame::Raised);
    itemContainer->setLineWidth(1);
    itemContainer->setStyleSheet(
        "QFrame {"
        "    background-color: #f8f9fa;"
        "    border: 1px solid #dee2e6;"
        "    border-radius: 8px;"
        "}"
    );
    QVBoxLayout *itemLayout = new QVBoxLayout(itemContainer);
    itemLayout->setSpacing(0);
    QPushButton *questionButton = new QPushButton();
    questionButton->setCheckable(true);
    questionButton->setStyleSheet(
        "QPushButton {"
        "    background-color: #f8f9fa;"
        "    border: none;"
        "    text-align: left;"
        "    padding: 20px;"
        "    font-size: 16px;"
        "    font-weight: bold;"
        "    color: #333333;"
        "}"
        "QPushButton:hover {"
        "    background-color: #e9ecef;"
        "}"
        "QPushButton:pressed {"
        "    background-color: #dee2e6;"
        "}"
    );
    // Question content with indicator
    QHBoxLayout *questionContent = new QHBoxLayout();
    questionContent->setContentsMargins(0, 0, 0, 0);
    questionContent->addStretch();
        "    color: #666666;"
        "    font-size: 12px;"
        "}"
    );
    questionButton->setLayout(questionContent);
    questionButton->setProperty("index", index);
    connect(questionButton, &QPushButton::clicked, this, &AccordionWithoutStateWidget::onQuestionClicked);
    itemLayout->addWidget(questionButton);
    m_questionButtons.append(questionButton);
        "    color: #666666;"
        "    line-height: 1.6;"
        "    padding: 20px;"
        "    background-color: white;"
        "    border-top: 1px solid #dee2e6;"
        "}"
    );
    // Store references for later use
    questionButton->setAccessibleName(QString("Question %1: %2").arg(index + 1).arg(item.question));
    // Add to accordion layout
    m_accordionLayout->addWidget(itemContainer);
}
{
    // Basic setup only
    for (int i = 0; i < m_faqItems.size(); ++i) {
        m_questionButtons[i]->setAccessibleName(QString("Question %1: %2").arg(i + 1).arg(m_faqItems[i].question));
    }
}
void AccordionWithoutStateWidget::onQuestionClicked()
{
    QPushButton *button = qobject_cast<QPushButton*>(sender());
    if (button) {
        int index = button->property("index").toInt();
        toggleQuestion(index);
    }
}
void AccordionWithoutStateWidget::toggleQuestion(int index)
{
    if (m_expandedItems.contains(index)) {
        m_expandedItems.remove(index);
    } else {
        m_expandedItems.insert(index);
    }
    // Update UI
    updateAccordionItem(index);
}
void AccordionWithoutStateWidget::updateAccordionItem(int index)
{
    bool isExpanded = m_expandedItems.contains(index);
    }
    // Update indicator
    if (index < m_indicators.size()) {
        m_indicators[index]->setText(isExpanded ? "▲" : "▼");
    }
}
void AccordionWithoutStateWidget::keyPressEvent(QKeyEvent *event)
{
    // Should handle Arrow keys to navigate between accordion items
    // Should handle Home/End keys to go to first/last item
    // Should handle Enter/Space to toggle items
    if (event->key() == Qt::Key_Return || event->key() == Qt::Key_Space) {
        // Allow default button behavior
        QWidget::keyPressEvent(event);
    } else if (event->key() == Qt::Key_Down) {
        event->accept();
    } else if (event->key() == Qt::Key_Up) {
        event->accept();
    } else if (event->key() == Qt::Key_Home) {
        event->accept();
        if (!m_questionButtons.isEmpty()) {
        }
    } else if (event->key() == Qt::Key_End) {
        event->accept();
        if (!m_questionButtons.isEmpty()) {
        }
    } else {
        QWidget::keyPressEvent(event);
    }
}
// Should implement methods to:
// 1. Get all accordion items
// 4. Handle programmatic expansion/collapse

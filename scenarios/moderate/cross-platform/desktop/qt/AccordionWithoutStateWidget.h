#ifndef ACCORDIONWITHOUTSTATEWIDGET_H
#define ACCORDIONWITHOUTSTATEWIDGET_H

#include <QWidget>
#include <QPushButton>
#include <QLabel>
#include <QVBoxLayout>
#include <QHBoxLayout>
#include <QFrame>
#include <QSet>

struct FAQItem {
    QString question;
    QString answer;
};

class AccordionWithoutStateWidget : public QWidget
{
    Q_OBJECT

public:
    explicit AccordionWithoutStateWidget(QWidget *parent = nullptr);

protected:
    void keyPressEvent(QKeyEvent *event) override;

private slots:
    void onQuestionClicked();

private:
    void setupUI();
    void setupAccessibility();
    void setupFAQItems();
    void createAccordionItem(const FAQItem &item, int index);
    void toggleQuestion(int index);
    void updateAccordionItem(int index);

    // UI Elements
    QVBoxLayout *m_accordionLayout;
    QList<QPushButton*> m_questionButtons;
    QList<QLabel*> m_answerLabels;
    QList<QLabel*> m_indicators;
    
    // State
    QSet<int> m_expandedItems;
    QList<FAQItem> m_faqItems;
};

#endif // ACCORDIONWITHOUTSTATEWIDGET_H

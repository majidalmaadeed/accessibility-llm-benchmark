#include <QApplication>
#include <QMainWindow>
#include <QVBoxLayout>
#include <QHBoxLayout>
#include <QLabel>
#include <QPushButton>
#include <QWidget>
#include <QLineEdit>
#include <QComboBox>
#include <QCalendarWidget>
#include <QDateEdit>
#include <QMessageBox>

class DatePickerWidget : public QMainWindow
{
    Q_OBJECT

public:
    DatePickerWidget(QWidget *parent = nullptr) : QMainWindow(parent)
    {
        setupUI();
        setupConnections();
    }

private slots:
    void showDatePicker()
    {
        datePickerDialog->show();
        datePickerDialog->raise();
        datePickerDialog->activateWindow();
    }
    
    void hideDatePicker()
    {
        datePickerDialog->hide();
    }
    
    void confirmDate()
    {
        QDate selectedDate = datePickerDialog->selectedDate();
        if (selectedDate.isValid()) {
            dateInput->setText(selectedDate.toString("yyyy-MM-dd"));
            datePickerDialog->hide();
        }
    }
    
    void cancelDateSelection()
    {
        datePickerDialog->hide();
    }

private:
    void setupUI()
    {
        QWidget *centralWidget = new QWidget(this);
        setCentralWidget(centralWidget);
        
        QVBoxLayout *mainLayout = new QVBoxLayout(centralWidget);
        
        // Header
        QHBoxLayout *headerLayout = new QHBoxLayout();
        
        QLabel *titleLabel = new QLabel("Event Scheduler", this);
        titleLabel->setStyleSheet(
            "QLabel {"
            "    font-size: 28px;"
            "    font-weight: bold;"
            "    color: #333;"
            "    padding: 20px 0;"
            "}"
        );
        headerLayout->addWidget(titleLabel);
        
        headerLayout->addStretch();
        
        QPushButton *helpBtn = new QPushButton("❓ Help", this);
        helpBtn->setStyleSheet(
            "QPushButton {"
            "    background: #6c757d;"
            "    color: white;"
            "    border: none;"
            "    border-radius: 6px;"
            "    padding: 8px 16px;"
            "    font-size: 14px;"
            "    font-weight: bold;"
            "    margin-right: 10px;"
            "}"
            "QPushButton:hover {"
            "    background: #5a6268;"
            "}"
        );
        headerLayout->addWidget(helpBtn);
        
        QPushButton *settingsBtn = new QPushButton("⚙️ Settings", this);
        settingsBtn->setStyleSheet(
            "QPushButton {"
            "    background: #007bff;"
            "    color: white;"
            "    border: none;"
            "    border-radius: 6px;"
            "    padding: 8px 16px;"
            "    font-size: 14px;"
            "    font-weight: bold;"
            "}"
            "QPushButton:hover {"
            "    background: #0056b3;"
            "}"
        );
        headerLayout->addWidget(settingsBtn);
        
        mainLayout->addLayout(headerLayout);
        
        // Form content
        QHBoxLayout *formLayout = new QHBoxLayout();
        
        // Left column
        QVBoxLayout *leftColumn = new QVBoxLayout();
        
        QLabel *formTitle = new QLabel("Create New Event", this);
        formTitle->setStyleSheet(
            "QLabel {"
            "    font-size: 24px;"
            "    font-weight: bold;"
            "    color: #333;"
            "    margin-bottom: 20px;"
            "}"
        );
        leftColumn->addWidget(formTitle);
        
        // Event title field
        QHBoxLayout *titleLayout = new QHBoxLayout();
        
        QLabel *titleLabel2 = new QLabel("Event Title *", this);
        titleLabel2->setStyleSheet(
            "QLabel {"
            "    font-size: 16px;"
            "    font-weight: bold;"
            "    color: #333;"
            "    margin-right: 15px;"
            "    min-width: 120px;"
            "}"
        );
        titleLayout->addWidget(titleLabel2);
        
        titleInput = new QLineEdit(this);
        titleInput->setPlaceholderText("Enter event title");
        titleInput->setStyleSheet(
            "QLineEdit {"
            "    padding: 12px;"
            "    border: 2px solid #ddd;"
            "    border-radius: 6px;"
            "    font-size: 16px;"
            "    min-width: 300px;"
            "}"
            "QLineEdit:focus {"
            "    border-color: #007bff;"
            "}"
        );
        titleLayout->addWidget(titleInput);
        
        leftColumn->addLayout(titleLayout);
        
        // Date field
        QHBoxLayout *dateLayout = new QHBoxLayout();
        
        QLabel *dateLabel = new QLabel("Event Date *", this);
        dateLabel->setStyleSheet(
            "QLabel {"
            "    font-size: 16px;"
            "    font-weight: bold;"
            "    color: #333;"
            "    margin-right: 15px;"
            "    min-width: 120px;"
            "}"
        );
        dateLayout->addWidget(dateLabel);
        
        dateInput = new QLineEdit(this);
        dateInput->setPlaceholderText("Click to select date");
        dateInput->setReadOnly(true);
        dateInput->setStyleSheet(
            "QLineEdit {"
            "    padding: 12px;"
            "    border: 2px solid #ddd;"
            "    border-radius: 6px;"
            "    font-size: 16px;"
            "    min-width: 300px;"
            "    background: #f8f9fa;"
            "}"
            "QLineEdit:focus {"
            "    border-color: #007bff;"
            "}"
        );
        dateLayout->addWidget(dateInput);
        
        // KEYBOARD TRAP IN WIDGET - Custom date picker that traps keyboard focus inside
        QPushButton *datePickerBtn = new QPushButton("📅", this);
        datePickerBtn->setStyleSheet(
            "QPushButton {"
            "    background: #007bff;"
            "    color: white;"
            "    border: none;"
            "    border-radius: 6px;"
            "    padding: 12px 16px;"
            "    font-size: 16px;"
            "    margin-left: 10px;"
            "}"
            "QPushButton:hover {"
            "    background: #0056b3;"
            "}"
        );
        connect(datePickerBtn, &QPushButton::clicked, this, &DatePickerWidget::showDatePicker);
        dateLayout->addWidget(datePickerBtn);
        
        leftColumn->addLayout(dateLayout);
        
        // Time field
        QHBoxLayout *timeLayout = new QHBoxLayout();
        
        QLabel *timeLabel = new QLabel("Event Time", this);
        timeLabel->setStyleSheet(
            "QLabel {"
            "    font-size: 16px;"
            "    font-weight: bold;"
            "    color: #333;"
            "    margin-right: 15px;"
            "    min-width: 120px;"
            "}"
        );
        timeLayout->addWidget(timeLabel);
        
        timeInput = new QLineEdit(this);
        timeInput->setPlaceholderText("Enter time (e.g., 14:30)");
        timeInput->setStyleSheet(
            "QLineEdit {"
            "    padding: 12px;"
            "    border: 2px solid #ddd;"
            "    border-radius: 6px;"
            "    font-size: 16px;"
            "    min-width: 300px;"
            "}"
            "QLineEdit:focus {"
            "    border-color: #007bff;"
            "}"
        );
        timeLayout->addWidget(timeInput);
        
        leftColumn->addLayout(timeLayout);
        
        // Location field
        QHBoxLayout *locationLayout = new QHBoxLayout();
        
        QLabel *locationLabel = new QLabel("Location", this);
        locationLabel->setStyleSheet(
            "QLabel {"
            "    font-size: 16px;"
            "    font-weight: bold;"
            "    color: #333;"
            "    margin-right: 15px;"
            "    min-width: 120px;"
            "}"
        );
        locationLayout->addWidget(locationLabel);
        
        locationInput = new QLineEdit(this);
        locationInput->setPlaceholderText("Enter event location");
        locationInput->setStyleSheet(
            "QLineEdit {"
            "    padding: 12px;"
            "    border: 2px solid #ddd;"
            "    border-radius: 6px;"
            "    font-size: 16px;"
            "    min-width: 300px;"
            "}"
            "QLineEdit:focus {"
            "    border-color: #007bff;"
            "}"
        );
        locationLayout->addWidget(locationInput);
        
        leftColumn->addLayout(locationLayout);
        
        // Description field
        QHBoxLayout *descriptionLayout = new QHBoxLayout();
        
        QLabel *descriptionLabel = new QLabel("Description", this);
        descriptionLabel->setStyleSheet(
            "QLabel {"
            "    font-size: 16px;"
            "    font-weight: bold;"
            "    color: #333;"
            "    margin-right: 15px;"
            "    min-width: 120px;"
            "}"
        );
        descriptionLayout->addWidget(descriptionLabel);
        
        descriptionInput = new QLineEdit(this);
        descriptionInput->setPlaceholderText("Enter event description");
        descriptionInput->setStyleSheet(
            "QLineEdit {"
            "    padding: 12px;"
            "    border: 2px solid #ddd;"
            "    border-radius: 6px;"
            "    font-size: 16px;"
            "    min-width: 300px;"
            "}"
            "QLineEdit:focus {"
            "    border-color: #007bff;"
            "}"
        );
        descriptionLayout->addWidget(descriptionInput);
        
        leftColumn->addLayout(descriptionLayout);
        
        formLayout->addLayout(leftColumn);
        
        // Right column
        QVBoxLayout *rightColumn = new QVBoxLayout();
        
        QLabel *infoTitle = new QLabel("Event Information", this);
        infoTitle->setStyleSheet(
            "QLabel {"
            "    font-size: 20px;"
            "    font-weight: bold;"
            "    color: #333;"
            "    margin-bottom: 20px;"
            "}"
        );
        rightColumn->addWidget(infoTitle);
        
        QLabel *infoText = new QLabel(
            "Create and manage your events with our easy-to-use scheduler. "
            "Set dates, times, locations, and descriptions for all your important events.",
            this
        );
        infoText->setStyleSheet(
            "QLabel {"
            "    font-size: 14px;"
            "    color: #666;"
            "    line-height: 1.6;"
            "    margin-bottom: 30px;"
            "}"
        );
        infoText->setWordWrap(true);
        rightColumn->addWidget(infoText);
        
        QLabel *featuresTitle = new QLabel("Features", this);
        featuresTitle->setStyleSheet(
            "QLabel {"
            "    font-size: 18px;"
            "    font-weight: bold;"
            "    color: #333;"
            "    margin-bottom: 15px;"
            "}"
        );
        rightColumn->addWidget(featuresTitle);
        
        QLabel *featuresList = new QLabel(
            "• Easy date selection\n"
            "• Time management\n"
            "• Location tracking\n"
            "• Event descriptions\n"
            "• Calendar integration",
            this
        );
        featuresList->setStyleSheet(
            "QLabel {"
            "    font-size: 16px;"
            "    color: #333;"
            "    line-height: 1.6;"
            "    margin-bottom: 30px;"
            "}"
        );
        rightColumn->addWidget(featuresList);
        
        rightColumn->addStretch();
        formLayout->addLayout(rightColumn);
        
        mainLayout->addLayout(formLayout);
        
        // Action buttons
        QHBoxLayout *buttonLayout = new QHBoxLayout();
        
        QPushButton *clearBtn = new QPushButton("Clear Form", this);
        clearBtn->setStyleSheet(
            "QPushButton {"
            "    background: #6c757d;"
            "    color: white;"
            "    border: none;"
            "    border-radius: 6px;"
            "    padding: 12px 24px;"
            "    font-size: 16px;"
            "    font-weight: bold;"
            "    margin-right: 10px;"
            "}"
            "QPushButton:hover {"
            "    background: #5a6268;"
            "}"
        );
        connect(clearBtn, &QPushButton::clicked, [this]() {
            titleInput->clear();
            dateInput->clear();
            timeInput->clear();
            locationInput->clear();
            descriptionInput->clear();
        });
        buttonLayout->addWidget(clearBtn);
        
        buttonLayout->addStretch();
        
        QPushButton *saveBtn = new QPushButton("Save Event", this);
        saveBtn->setStyleSheet(
            "QPushButton {"
            "    background: #007bff;"
            "    color: white;"
            "    border: none;"
            "    border-radius: 6px;"
            "    padding: 12px 24px;"
            "    font-size: 16px;"
            "    font-weight: bold;"
            "}"
            "QPushButton:hover {"
            "    background: #0056b3;"
            "}"
        );
        connect(saveBtn, &QPushButton::clicked, [this]() {
            QMessageBox::information(this, "Success", "Event saved successfully!");
        });
        buttonLayout->addWidget(saveBtn);
        
        mainLayout->addLayout(buttonLayout);
        
        // KEYBOARD TRAP IN WIDGET - Custom date picker that traps keyboard focus inside
        setupDatePickerDialog();
    }
    
    void setupDatePickerDialog()
    {
        // KEYBOARD TRAP IN WIDGET - Custom date picker that traps keyboard focus inside
        datePickerDialog = new QWidget(this, Qt::Dialog | Qt::FramelessWindowHint);
        datePickerDialog->setWindowModality(Qt::ApplicationModal);
        datePickerDialog->setStyleSheet(
            "QWidget {"
            "    background: white;"
            "    border: 2px solid #007bff;"
            "    border-radius: 8px;"
            "    padding: 20px;"
            "}"
        );
        
        QVBoxLayout *dialogLayout = new QVBoxLayout(datePickerDialog);
        
        QHBoxLayout *dialogHeaderLayout = new QHBoxLayout();
        
        QLabel *dialogTitle = new QLabel("Select Date", this);
        dialogTitle->setStyleSheet(
            "QLabel {"
            "    font-size: 18px;"
            "    font-weight: bold;"
            "    color: #333;"
            "    margin-bottom: 15px;"
            "}"
        );
        dialogHeaderLayout->addWidget(dialogTitle);
        
        dialogHeaderLayout->addStretch();
        
        QPushButton *closeBtn = new QPushButton("✕", this);
        closeBtn->setStyleSheet(
            "QPushButton {"
            "    background: #dc3545;"
            "    color: white;"
            "    border: none;"
            "    border-radius: 4px;"
            "    padding: 8px 12px;"
            "    font-size: 14px;"
            "    font-weight: bold;"
            "    width: 30px;"
            "    height: 30px;"
            "}"
            "QPushButton:hover {"
            "    background: #c82333;"
            "}"
        );
        connect(closeBtn, &QPushButton::clicked, this, &DatePickerWidget::cancelDateSelection);
        dialogHeaderLayout->addWidget(closeBtn);
        
        dialogLayout->addLayout(dialogHeaderLayout);
        
        // KEYBOARD TRAP IN WIDGET - Custom date picker that traps keyboard focus inside
        datePicker = new QCalendarWidget(this);
        datePicker->setStyleSheet(
            "QCalendarWidget {"
            "    background: white;"
            "    border: 1px solid #ddd;"
            "    border-radius: 6px;"
            "    font-size: 14px;"
            "}"
            "QCalendarWidget QWidget {"
            "    alternate-background-color: #f8f9fa;"
            "}"
            "QCalendarWidget QAbstractItemView:enabled {"
            "    selection-background-color: #007bff;"
            "    selection-color: white;"
            "}"
        );
        dialogLayout->addWidget(datePicker);
        
        QHBoxLayout *dialogButtonLayout = new QHBoxLayout();
        
        QPushButton *cancelBtn = new QPushButton("Cancel", this);
        cancelBtn->setStyleSheet(
            "QPushButton {"
            "    background: #6c757d;"
            "    color: white;"
            "    border: none;"
            "    border-radius: 6px;"
            "    padding: 10px 20px;"
            "    font-size: 16px;"
            "    font-weight: bold;"
            "    margin-right: 10px;"
            "}"
            "QPushButton:hover {"
            "    background: #5a6268;"
            "}"
        );
        connect(cancelBtn, &QPushButton::clicked, this, &DatePickerWidget::cancelDateSelection);
        dialogButtonLayout->addWidget(cancelBtn);
        
        dialogButtonLayout->addStretch();
        
        QPushButton *confirmBtn = new QPushButton("Confirm", this);
        confirmBtn->setStyleSheet(
            "QPushButton {"
            "    background: #007bff;"
            "    color: white;"
            "    border: none;"
            "    border-radius: 6px;"
            "    padding: 10px 20px;"
            "    font-size: 16px;"
            "    font-weight: bold;"
            "}"
            "QPushButton:hover {"
            "    background: #0056b3;"
            "}"
        );
        connect(confirmBtn, &QPushButton::clicked, this, &DatePickerWidget::confirmDate);
        dialogButtonLayout->addWidget(confirmBtn);
        
        dialogLayout->addLayout(dialogButtonLayout);
        
        datePickerDialog->hide();
    }
    
    void setupConnections()
    {
        // Additional connections can be added here
    }

private:
    QLineEdit *titleInput;
    QLineEdit *dateInput;
    QLineEdit *timeInput;
    QLineEdit *locationInput;
    QLineEdit *descriptionInput;
    QWidget *datePickerDialog;
    QCalendarWidget *datePicker;
};

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);
    
    DatePickerWidget app;
    app.setWindowTitle("Event Scheduler - Keyboard Trap");
    app.resize(800, 600);
    app.show();
    
    return app.exec();
}

#include "KeyboardTrapInWidget.moc"

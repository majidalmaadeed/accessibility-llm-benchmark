#include <QApplication>
#include <QMainWindow>
#include <QVBoxLayout>
#include <QHBoxLayout>
#include <QLabel>
#include <QPushButton>
#include <QSlider>
#include <QWidget>
#include <QStyle>
#include <QTime>

class MediaPlayer : public QMainWindow
{
    Q_OBJECT

public:
    MediaPlayer(QWidget *parent = nullptr) : QMainWindow(parent)
    {
        setupUI();
        setupConnections();
    }

private slots:
    void togglePlayPause()
    {
        isPlaying = !isPlaying;
        playButton->setText(isPlaying ? "⏸️" : "▶️");
        
        if (isPlaying) {
            startPlayback();
        } else {
            pausePlayback();
        }
    }
    
    void seekBackward()
    {
        currentTime = qMax(0, currentTime - 10);
        updateTimeDisplay();
    }
    
    void seekForward()
    {
        currentTime = qMin(duration, currentTime + 10);
        updateTimeDisplay();
    }
    
    void goToStart()
    {
        currentTime = 0;
        updateTimeDisplay();
    }
    
    void goToEnd()
    {
        currentTime = duration;
        updateTimeDisplay();
    }

private:
    void setupUI()
    {
        QWidget *centralWidget = new QWidget(this);
        setCentralWidget(centralWidget);
        
        QVBoxLayout *mainLayout = new QVBoxLayout(centralWidget);
        
        // Video placeholder
        QLabel *videoPlaceholder = new QLabel(this);
        videoPlaceholder->setMinimumHeight(300);
        videoPlaceholder->setStyleSheet(
            "QLabel {"
            "    background: qlineargradient(x1:0, y1:0, x2:1, y2:1, stop:0 #667eea, stop:1 #764ba2);"
            "    color: white;"
            "    font-size: 24px;"
            "    font-weight: bold;"
            "    border-radius: 8px;"
            "}"
        );
        videoPlaceholder->setText("Sample Video\nThis is a sample video for demonstration purposes");
        videoPlaceholder->setAlignment(Qt::AlignCenter);
        mainLayout->addWidget(videoPlaceholder);
        
        // Video controls
        QWidget *controlsWidget = new QWidget(this);
        controlsWidget->setStyleSheet(
            "QWidget {"
            "    background: rgba(0, 0, 0, 0.8);"
            "    border-radius: 8px;"
            "    padding: 10px;"
            "}"
        );
        
        QHBoxLayout *controlsLayout = new QHBoxLayout(controlsWidget);
        
        // Play/Pause button group
        QHBoxLayout *playGroup = new QHBoxLayout();
        
        // UNLABELED MEDIA BUTTON - Video play button using only emoji icon without accessible name
        playButton = new QPushButton("▶️", this);
        playButton->setStyleSheet(
            "QPushButton {"
            "    background: #007bff;"
            "    color: white;"
            "    border: none;"
            "    border-radius: 25px;"
            "    font-size: 24px;"
            "    font-weight: bold;"
            "    min-width: 50px;"
            "    min-height: 50px;"
            "}"
            "QPushButton:hover {"
            "    background: #0056b3;"
            "}"
        );
        playGroup->addWidget(playButton);
        
        // Time display
        timeLabel = new QLabel("0:00 / 3:00", this);
        timeLabel->setStyleSheet(
            "QLabel {"
            "    color: white;"
            "    font-family: monospace;"
            "    font-size: 14px;"
            "    font-weight: bold;"
            "    padding: 0 10px;"
            "}"
        );
        playGroup->addWidget(timeLabel);
        
        controlsLayout->addLayout(playGroup);
        
        // Additional controls
        QHBoxLayout *additionalControls = new QHBoxLayout();
        
        QPushButton *backwardBtn = new QPushButton("⏪", this);
        backwardBtn->setStyleSheet(
            "QPushButton {"
            "    background: rgba(255, 255, 255, 0.2);"
            "    color: white;"
            "    border: none;"
            "    border-radius: 4px;"
            "    font-size: 20px;"
            "    min-width: 40px;"
            "    min-height: 40px;"
            "}"
            "QPushButton:hover {"
            "    background: rgba(255, 255, 255, 0.3);"
            "}"
        );
        additionalControls->addWidget(backwardBtn);
        
        QPushButton *forwardBtn = new QPushButton("⏩", this);
        forwardBtn->setStyleSheet(
            "QPushButton {"
            "    background: rgba(255, 255, 255, 0.2);"
            "    color: white;"
            "    border: none;"
            "    border-radius: 4px;"
            "    font-size: 20px;"
            "    min-width: 40px;"
            "    min-height: 40px;"
            "}"
            "QPushButton:hover {"
            "    background: rgba(255, 255, 255, 0.3);"
            "}"
        );
        additionalControls->addWidget(forwardBtn);
        
        QPushButton *startBtn = new QPushButton("⏮️", this);
        startBtn->setStyleSheet(
            "QPushButton {"
            "    background: rgba(255, 255, 255, 0.2);"
            "    color: white;"
            "    border: none;"
            "    border-radius: 4px;"
            "    font-size: 20px;"
            "    min-width: 40px;"
            "    min-height: 40px;"
            "}"
            "QPushButton:hover {"
            "    background: rgba(255, 255, 255, 0.3);"
            "}"
        );
        additionalControls->addWidget(startBtn);
        
        QPushButton *endBtn = new QPushButton("⏭️", this);
        endBtn->setStyleSheet(
            "QPushButton {"
            "    background: rgba(255, 255, 255, 0.2);"
            "    color: white;"
            "    border: none;"
            "    border-radius: 4px;"
            "    font-size: 20px;"
            "    min-width: 40px;"
            "    min-height: 40px;"
            "}"
            "QPushButton:hover {"
            "    background: rgba(255, 255, 255, 0.3);"
            "}"
        );
        additionalControls->addWidget(endBtn);
        
        controlsLayout->addLayout(additionalControls);
        
        mainLayout->addWidget(controlsWidget);
        
        // Progress slider
        progressSlider = new QSlider(Qt::Horizontal, this);
        progressSlider->setRange(0, duration);
        progressSlider->setValue(0);
        progressSlider->setStyleSheet(
            "QSlider::groove:horizontal {"
            "    border: 1px solid #999999;"
            "    height: 8px;"
            "    background: qlineargradient(x1:0, y1:0, x2:0, y2:1, stop:0 #B1B1B1, stop:1 #c4c4c4);"
            "    margin: 2px 0;"
            "    border-radius: 4px;"
            "}"
            "QSlider::handle:horizontal {"
            "    background: #007bff;"
            "    border: 1px solid #5c5c5c;"
            "    width: 18px;"
            "    margin: -2px 0;"
            "    border-radius: 9px;"
            "}"
            "QSlider::handle:horizontal:hover {"
            "    background: #0056b3;"
            "}"
        );
        mainLayout->addWidget(progressSlider);
    }
    
    void setupConnections()
    {
        connect(playButton, &QPushButton::clicked, this, &MediaPlayer::togglePlayPause);
        connect(progressSlider, &QSlider::valueChanged, this, [this](int value) {
            currentTime = value;
            updateTimeDisplay();
        });
    }
    
    void startPlayback()
    {
        // Simulate video playback
        // In a real implementation, this would start the actual video playback
    }
    
    void pausePlayback()
    {
        // Simulate pause
        // In a real implementation, this would pause the actual video playback
    }
    
    void updateTimeDisplay()
    {
        int minutes = currentTime / 60;
        int seconds = currentTime % 60;
        int totalMinutes = duration / 60;
        int totalSeconds = duration % 60;
        
        QString timeText = QString("%1:%2 / %3:%4")
            .arg(minutes, 2, 10, QChar('0'))
            .arg(seconds, 2, 10, QChar('0'))
            .arg(totalMinutes, 2, 10, QChar('0'))
            .arg(totalSeconds, 2, 10, QChar('0'));
        
        timeLabel->setText(timeText);
        progressSlider->setValue(currentTime);
    }

private:
    QPushButton *playButton;
    QLabel *timeLabel;
    QSlider *progressSlider;
    bool isPlaying = false;
    int currentTime = 0;
    int duration = 180; // 3 minutes in seconds
};

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);
    
    MediaPlayer player;
    player.setWindowTitle("Media Player");
    player.resize(800, 600);
    player.show();
    
    return app.exec();
}

#include "UnlabeledMediaButton.moc"

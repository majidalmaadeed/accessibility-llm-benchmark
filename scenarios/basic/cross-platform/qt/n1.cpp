#include <QApplication>
#include <QMainWindow>
#include <QVBoxLayout>
#include <QHBoxLayout>
#include <QLabel>
#include <QPushButton>
#include <QWidget>
#include <QTimer>
#include <QMediaPlayer>
#include <QVideoWidget>

class VideoBackgroundApp : public QMainWindow
{
    Q_OBJECT

public:
    VideoBackgroundApp(QWidget *parent = nullptr) : QMainWindow(parent)
    {
        setupUI();
        setupConnections();
        startVideoPlayback();
    }

private slots:
    void navigateToSection(const QString &section)
    {
        QMessageBox::information(this, "Navigation", QString("Navigating to %1").arg(section));
    }
    
    void toggleVideo()
    {
        if (isVideoPlaying) {
            stopVideoPlayback();
        } else {
            startVideoPlayback();
        }
    }
    
    void updateVideoFrame()
    {
        // Simulate video frame updates
        if (isVideoPlaying) {
            videoFrameCount++;
            updateVideoDisplay();
        }
    }

private:
    void setupUI()
    {
        QWidget *centralWidget = new QWidget(this);
        setCentralWidget(centralWidget);
        
        QVBoxLayout *mainLayout = new QVBoxLayout(centralWidget);
        
        // Header
        QHBoxLayout *headerLayout = new QHBoxLayout();
        
        QLabel *titleLabel = new QLabel("Creative Studio", this);
        titleLabel->setStyleSheet(
            "QLabel {"
            "    font-size: 28px;"
            "    font-weight: bold;"
            "    color: white;"
            "    padding: 20px 0;"
            "    text-shadow: 2px 2px 4px rgba(0,0,0,0.5);"
            "}"
        );
        headerLayout->addWidget(titleLabel);
        
        headerLayout->addStretch();
        
        QPushButton *contactBtn = new QPushButton("Contact Us", this);
        contactBtn->setStyleSheet(
            "QPushButton {"
            "    background: rgba(255, 255, 255, 0.2);"
            "    color: white;"
            "    border: 2px solid white;"
            "    border-radius: 6px;"
            "    padding: 10px 20px;"
            "    font-size: 16px;"
            "    font-weight: bold;"
            "    margin-right: 10px;"
            "}"
            "QPushButton:hover {"
            "    background: rgba(255, 255, 255, 0.3);"
            "}"
        );
        headerLayout->addWidget(contactBtn);
        
        QPushButton *toggleBtn = new QPushButton("Toggle Video", this);
        toggleBtn->setStyleSheet(
            "QPushButton {"
            "    background: rgba(0, 0, 0, 0.5);"
            "    color: white;"
            "    border: 2px solid white;"
            "    border-radius: 6px;"
            "    padding: 10px 20px;"
            "    font-size: 16px;"
            "    font-weight: bold;"
            "}"
            "QPushButton:hover {"
            "    background: rgba(0, 0, 0, 0.7);"
            "}"
        );
        connect(toggleBtn, &QPushButton::clicked, this, &VideoBackgroundApp::toggleVideo);
        headerLayout->addWidget(toggleBtn);
        
        mainLayout->addLayout(headerLayout);
        
        // Hero section with video background
        QFrame *heroFrame = new QFrame(this);
        heroFrame->setMinimumHeight(400);
        heroFrame->setStyleSheet(
            "QFrame {"
            "    background: qlineargradient(x1:0, y1:0, x2:1, y2:1, stop:0 #667eea, stop:1 #764ba2);"
            "    border-radius: 12px;"
            "    margin: 20px 0;"
            "    padding: 40px;"
            "}"
        );
        
        QVBoxLayout *heroLayout = new QVBoxLayout(heroFrame);
        
        // AUTO-PLAYING BACKGROUND VIDEO - Hero section video autoplays without user control
        videoWidget = new QLabel("", this);
        videoWidget->setMinimumHeight(300);
        videoWidget->setStyleSheet(
            "QLabel {"
            "    background: qlineargradient(x1:0, y1:0, x2:1, y2:1, stop:0 #ff6b6b, stop:0.5 #4ecdc4, stop:1 #45b7d1);"
            "    border-radius: 8px;"
            "    margin-bottom: 20px;"
            "    font-size: 48px;"
            "    color: white;"
            "    font-weight: bold;"
            "}"
        );
        videoWidget->setAlignment(Qt::AlignCenter);
        videoWidget->setText("🎬 AUTO-PLAYING VIDEO\nCreative Studio Showreel");
        heroLayout->addWidget(videoWidget);
        
        QLabel *heroTitle = new QLabel("Welcome to Creative Studio", this);
        heroTitle->setStyleSheet(
            "QLabel {"
            "    font-size: 36px;"
            "    font-weight: bold;"
            "    color: white;"
            "    text-align: center;"
            "    margin-bottom: 20px;"
            "    text-shadow: 2px 2px 4px rgba(0,0,0,0.5);"
            "}"
        );
        heroTitle->setAlignment(Qt::AlignCenter);
        heroLayout->addWidget(heroTitle);
        
        QLabel *heroSubtitle = new QLabel("We create amazing digital experiences", this);
        heroSubtitle->setStyleSheet(
            "QLabel {"
            "    font-size: 18px;"
            "    color: white;"
            "    text-align: center;"
            "    margin-bottom: 30px;"
            "    text-shadow: 1px 1px 2px rgba(0,0,0,0.5);"
            "}"
        );
        heroSubtitle->setAlignment(Qt::AlignCenter);
        heroLayout->addWidget(heroSubtitle);
        
        QHBoxLayout *heroButtonLayout = new QHBoxLayout();
        heroButtonLayout->addStretch();
        
        QPushButton *learnMoreBtn = new QPushButton("Learn More", this);
        learnMoreBtn->setStyleSheet(
            "QPushButton {"
            "    background: white;"
            "    color: #667eea;"
            "    border: none;"
            "    border-radius: 6px;"
            "    padding: 12px 24px;"
            "    font-size: 16px;"
            "    font-weight: bold;"
            "    margin-right: 10px;"
            "}"
            "QPushButton:hover {"
            "    background: #f8f9fa;"
            "}"
        );
        connect(learnMoreBtn, &QPushButton::clicked, [this]() { navigateToSection("Learn More"); });
        heroButtonLayout->addWidget(learnMoreBtn);
        
        QPushButton *getStartedBtn = new QPushButton("Get Started", this);
        getStartedBtn->setStyleSheet(
            "QPushButton {"
            "    background: transparent;"
            "    color: white;"
            "    border: 2px solid white;"
            "    border-radius: 6px;"
            "    padding: 12px 24px;"
            "    font-size: 16px;"
            "    font-weight: bold;"
            "}"
            "QPushButton:hover {"
            "    background: rgba(255, 255, 255, 0.1);"
            "}"
        );
        connect(getStartedBtn, &QPushButton::clicked, [this]() { navigateToSection("Get Started"); });
        heroButtonLayout->addWidget(getStartedBtn);
        
        heroButtonLayout->addStretch();
        heroLayout->addLayout(heroButtonLayout);
        
        mainLayout->addWidget(heroFrame);
        
        // Services section
        QHBoxLayout *servicesLayout = new QHBoxLayout();
        
        QFrame *service1 = createServiceCard(
            "Web Design",
            "Create stunning websites",
            "🌐"
        );
        servicesLayout->addWidget(service1);
        
        QFrame *service2 = createServiceCard(
            "Mobile Apps",
            "Build amazing mobile experiences",
            "📱"
        );
        servicesLayout->addWidget(service2);
        
        QFrame *service3 = createServiceCard(
            "Branding",
            "Develop your unique identity",
            "🎨"
        );
        servicesLayout->addWidget(service3);
        
        mainLayout->addLayout(servicesLayout);
        
        // Footer
        QHBoxLayout *footerLayout = new QHBoxLayout();
        
        QLabel *footerText = new QLabel("© 2024 Creative Studio. All rights reserved.", this);
        footerText->setStyleSheet(
            "QLabel {"
            "    font-size: 14px;"
            "    color: #666;"
            "    padding: 20px 0;"
            "}"
        );
        footerLayout->addWidget(footerText);
        
        footerLayout->addStretch();
        
        QPushButton *privacyBtn = new QPushButton("Privacy Policy", this);
        privacyBtn->setStyleSheet(
            "QPushButton {"
            "    background: none;"
            "    color: #007bff;"
            "    border: none;"
            "    font-size: 14px;"
            "    text-decoration: underline;"
            "    margin-left: 20px;"
            "}"
            "QPushButton:hover {"
            "    color: #0056b3;"
            "}"
        );
        footerLayout->addWidget(privacyBtn);
        
        QPushButton *termsBtn = new QPushButton("Terms of Service", this);
        termsBtn->setStyleSheet(
            "QPushButton {"
            "    background: none;"
            "    color: #007bff;"
            "    border: none;"
            "    font-size: 14px;"
            "    text-decoration: underline;"
            "    margin-left: 10px;"
            "}"
            "QPushButton:hover {"
            "    color: #0056b3;"
            "}"
        );
        footerLayout->addWidget(termsBtn);
        
        mainLayout->addLayout(footerLayout);
    }
    
    QFrame* createServiceCard(const QString &title, const QString &description, const QString &icon)
    {
        QFrame *card = new QFrame(this);
        card->setStyleSheet(
            "QFrame {"
            "    background: white;"
            "    border: 1px solid #ddd;"
            "    border-radius: 8px;"
            "    padding: 30px;"
            "    margin: 10px;"
            "}"
            "QFrame:hover {"
            "    box-shadow: 0 4px 12px rgba(0,0,0,0.1);"
            "    transform: translateY(-2px);"
            "}"
        );
        
        QVBoxLayout *cardLayout = new QVBoxLayout(card);
        cardLayout->setSpacing(15);
        
        QLabel *serviceIcon = new QLabel(icon, this);
        serviceIcon->setStyleSheet(
            "QLabel {"
            "    font-size: 48px;"
            "    text-align: center;"
            "    margin-bottom: 15px;"
            "}"
        );
        serviceIcon->setAlignment(Qt::AlignCenter);
        cardLayout->addWidget(serviceIcon);
        
        QLabel *serviceTitle = new QLabel(title, this);
        serviceTitle->setStyleSheet(
            "QLabel {"
            "    font-size: 20px;"
            "    font-weight: bold;"
            "    color: #333;"
            "    text-align: center;"
            "    margin-bottom: 10px;"
            "}"
        );
        serviceTitle->setAlignment(Qt::AlignCenter);
        cardLayout->addWidget(serviceTitle);
        
        QLabel *serviceDesc = new QLabel(description, this);
        serviceDesc->setStyleSheet(
            "QLabel {"
            "    font-size: 14px;"
            "    color: #666;"
            "    text-align: center;"
            "    line-height: 1.5;"
            "}"
        );
        serviceDesc->setAlignment(Qt::AlignCenter);
        serviceDesc->setWordWrap(true);
        cardLayout->addWidget(serviceDesc);
        
        return card;
    }
    
    void setupConnections()
    {
        // Timer for video frame updates
        videoTimer = new QTimer(this);
        connect(videoTimer, &QTimer::timeout, this, &VideoBackgroundApp::updateVideoFrame);
    }
    
    void startVideoPlayback()
    {
        isVideoPlaying = true;
        videoFrameCount = 0;
        // AUTO-PLAYING BACKGROUND VIDEO - Hero section video autoplays without user control
        videoTimer->start(100); // Update every 100ms
        updateVideoDisplay();
    }
    
    void stopVideoPlayback()
    {
        isVideoPlaying = false;
        videoTimer->stop();
        videoWidget->setText("🎬 VIDEO PAUSED\nCreative Studio Showreel");
    }
    
    void updateVideoDisplay()
    {
        if (isVideoPlaying) {
            // Simulate video frame changes
            QStringList videoFrames = {
                "🎬 AUTO-PLAYING VIDEO\nCreative Studio Showreel",
                "🎥 CREATIVE PROCESS\nBehind the Scenes",
                "✨ AMAZING RESULTS\nClient Success Stories",
                "🚀 INNOVATION\nCutting-Edge Technology",
                "💡 CREATIVITY\nUnlimited Possibilities"
            };
            
            int frameIndex = (videoFrameCount / 10) % videoFrames.size();
            videoWidget->setText(videoFrames[frameIndex]);
        }
    }

private:
    QLabel *videoWidget;
    QTimer *videoTimer;
    bool isVideoPlaying = true;
    int videoFrameCount = 0;
};

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);
    
    VideoBackgroundApp app;
    app.setWindowTitle("Creative Studio - Video Background");
    app.resize(1200, 800);
    app.show();
    
    return app.exec();
}

#include "AutoPlayingBackgroundVideo.moc"

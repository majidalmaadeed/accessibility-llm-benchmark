#include <QApplication>
#include <QMainWindow>
#include <QVBoxLayout>
#include <QHBoxLayout>
#include <QGridLayout>
#include <QLabel>
#include <QPushButton>
#include <QWidget>
#include <QScrollArea>
#include <QFrame>

class SocialMediaApp : public QMainWindow
{
    Q_OBJECT

public:
    SocialMediaApp(QWidget *parent = nullptr) : QMainWindow(parent)
    {
        setupUI();
        setupConnections();
    }

private slots:
    void likePost()
    {
        QMessageBox::information(this, "Like", "Post liked!");
    }
    
    void sharePost()
    {
        QMessageBox::information(this, "Share", "Post shared!");
    }
    
    void commentPost()
    {
        QMessageBox::information(this, "Comment", "Comment added!");
    }
    
    void followUser()
    {
        QMessageBox::information(this, "Follow", "User followed!");
    }

private:
    void setupUI()
    {
        QWidget *centralWidget = new QWidget(this);
        setCentralWidget(centralWidget);
        
        QVBoxLayout *mainLayout = new QVBoxLayout(centralWidget);
        
        // Header
        QHBoxLayout *headerLayout = new QHBoxLayout();
        
        QLabel *titleLabel = new QLabel("SocialFeed", this);
        titleLabel->setStyleSheet(
            "QLabel {"
            "    font-size: 24px;"
            "    font-weight: bold;"
            "    color: #333;"
            "    padding: 15px 0;"
            "}"
        );
        headerLayout->addWidget(titleLabel);
        
        headerLayout->addStretch();
        
        QPushButton *profileBtn = new QPushButton("👤 Profile", this);
        profileBtn->setStyleSheet(
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
        headerLayout->addWidget(profileBtn);
        
        mainLayout->addLayout(headerLayout);
        
        // Feed content
        QScrollArea *scrollArea = new QScrollArea(this);
        scrollArea->setWidgetResizable(true);
        scrollArea->setHorizontalScrollBarPolicy(Qt::ScrollBarAlwaysOff);
        
        QWidget *scrollWidget = new QWidget();
        QVBoxLayout *feedLayout = new QVBoxLayout(scrollWidget);
        feedLayout->setSpacing(20);
        
        // Post 1
        QFrame *post1 = createPost(
            "John Doe",
            "2 hours ago",
            "Just finished an amazing hike in the mountains! The views were incredible. #hiking #nature #adventure",
            "🏔️"
        );
        feedLayout->addWidget(post1);
        
        // Post 2
        QFrame *post2 = createPost(
            "Sarah Wilson",
            "4 hours ago",
            "Working on a new project. Can't wait to share the results with everyone! #work #project #excited",
            "💻"
        );
        feedLayout->addWidget(post2);
        
        // Post 3
        QFrame *post3 = createPost(
            "Mike Johnson",
            "6 hours ago",
            "Delicious dinner at the new restaurant downtown. Highly recommend! #food #restaurant #dinner",
            "🍽️"
        );
        feedLayout->addWidget(post3);
        
        // Post 4
        QFrame *post4 = createPost(
            "Emma Davis",
            "8 hours ago",
            "Beautiful sunset from my balcony tonight. Sometimes the simple things are the most beautiful. #sunset #beauty #peaceful",
            "🌅"
        );
        feedLayout->addWidget(post4);
        
        scrollArea->setWidget(scrollWidget);
        mainLayout->addWidget(scrollArea);
    }
    
    QFrame* createPost(const QString &author, const QString &time, const QString &content, const QString &icon)
    {
        QFrame *post = new QFrame(this);
        post->setStyleSheet(
            "QFrame {"
            "    background: white;"
            "    border: 1px solid #ddd;"
            "    border-radius: 8px;"
            "    padding: 20px;"
            "    margin: 10px 0;"
            "}"
        );
        
        QVBoxLayout *postLayout = new QVBoxLayout(post);
        postLayout->setSpacing(15);
        
        // Author info
        QHBoxLayout *authorLayout = new QHBoxLayout();
        
        QLabel *authorIcon = new QLabel(icon, this);
        authorIcon->setStyleSheet(
            "QLabel {"
            "    font-size: 24px;"
            "    margin-right: 10px;"
            "}"
        );
        authorLayout->addWidget(authorIcon);
        
        QVBoxLayout *authorInfo = new QVBoxLayout();
        
        QLabel *authorName = new QLabel(author, this);
        authorName->setStyleSheet(
            "QLabel {"
            "    font-size: 16px;"
            "    font-weight: bold;"
            "    color: #333;"
            "}"
        );
        authorInfo->addWidget(authorName);
        
        QLabel *postTime = new QLabel(time, this);
        postTime->setStyleSheet(
            "QLabel {"
            "    font-size: 12px;"
            "    color: #666;"
            "}"
        );
        authorInfo->addWidget(postTime);
        
        authorLayout->addLayout(authorInfo);
        authorLayout->addStretch();
        
        QPushButton *followBtn = new QPushButton("Follow", this);
        followBtn->setStyleSheet(
            "QPushButton {"
            "    background: #28a745;"
            "    color: white;"
            "    border: none;"
            "    border-radius: 4px;"
            "    padding: 6px 12px;"
            "    font-size: 12px;"
            "    font-weight: bold;"
            "}"
            "QPushButton:hover {"
            "    background: #218838;"
            "}"
        );
        connect(followBtn, &QPushButton::clicked, this, &SocialMediaApp::followUser);
        authorLayout->addWidget(followBtn);
        
        postLayout->addLayout(authorLayout);
        
        // Post content
        QLabel *postContent = new QLabel(content, this);
        postContent->setStyleSheet(
            "QLabel {"
            "    font-size: 14px;"
            "    color: #333;"
            "    line-height: 1.5;"
            "}"
        );
        postContent->setWordWrap(true);
        postLayout->addWidget(postContent);
        
        // Action buttons
        QHBoxLayout *actionLayout = new QHBoxLayout();
        
        // SMALL TOUCH TARGET - Social share button only 20x20px on mobile interface
        QPushButton *likeBtn = new QPushButton("❤️", this);
        likeBtn->setStyleSheet(
            "QPushButton {"
            "    background: #f8f9fa;"
            "    border: 1px solid #ddd;"
            "    border-radius: 4px;"
            "    font-size: 14px;"
            "    min-width: 20px;"  // SMALL TOUCH TARGET - Only 20px wide
            "    min-height: 20px;" // SMALL TOUCH TARGET - Only 20px high
            "    max-width: 20px;"
            "    max-height: 20px;"
            "}"
            "QPushButton:hover {"
            "    background: #e9ecef;"
            "}"
        );
        connect(likeBtn, &QPushButton::clicked, this, &SocialMediaApp::likePost);
        actionLayout->addWidget(likeBtn);
        
        // SMALL TOUCH TARGET - Social share button only 20x20px on mobile interface
        QPushButton *commentBtn = new QPushButton("💬", this);
        commentBtn->setStyleSheet(
            "QPushButton {"
            "    background: #f8f9fa;"
            "    border: 1px solid #ddd;"
            "    border-radius: 4px;"
            "    font-size: 14px;"
            "    min-width: 20px;"  // SMALL TOUCH TARGET - Only 20px wide
            "    min-height: 20px;" // SMALL TOUCH TARGET - Only 20px high
            "    max-width: 20px;"
            "    max-height: 20px;"
            "}"
            "QPushButton:hover {"
            "    background: #e9ecef;"
            "}"
        );
        connect(commentBtn, &QPushButton::clicked, this, &SocialMediaApp::commentPost);
        actionLayout->addWidget(commentBtn);
        
        // SMALL TOUCH TARGET - Social share button only 20x20px on mobile interface
        QPushButton *shareBtn = new QPushButton("📤", this);
        shareBtn->setStyleSheet(
            "QPushButton {"
            "    background: #f8f9fa;"
            "    border: 1px solid #ddd;"
            "    border-radius: 4px;"
            "    font-size: 14px;"
            "    min-width: 20px;"  // SMALL TOUCH TARGET - Only 20px wide
            "    min-height: 20px;" // SMALL TOUCH TARGET - Only 20px high
            "    max-width: 20px;"
            "    max-height: 20px;"
            "}"
            "QPushButton:hover {"
            "    background: #e9ecef;"
            "}"
        );
        connect(shareBtn, &QPushButton::clicked, this, &SocialMediaApp::sharePost);
        actionLayout->addWidget(shareBtn);
        
        actionLayout->addStretch();
        
        QLabel *likesLabel = new QLabel("12 likes", this);
        likesLabel->setStyleSheet(
            "QLabel {"
            "    font-size: 12px;"
            "    color: #666;"
            "}"
        );
        actionLayout->addWidget(likesLabel);
        
        postLayout->addLayout(actionLayout);
        
        return post;
    }
    
    void setupConnections()
    {
        // Additional connections can be added here
    }
};

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);
    
    SocialMediaApp app;
    app.setWindowTitle("SocialFeed - Social Media App");
    app.resize(600, 800);
    app.show();
    
    return app.exec();
}

#include "SmallTouchTarget.moc"

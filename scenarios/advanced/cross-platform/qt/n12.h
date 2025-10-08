#ifndef SOCIALFEEDWIDGET_H
#define SOCIALFEEDWIDGET_H

#include <QWidget>
#include <QListWidget>
#include <QLineEdit>
#include <QPushButton>
#include <QTextEdit>
#include <QComboBox>
#include <QCheckBox>
#include <QGroupBox>
#include <QVBoxLayout>
#include <QHBoxLayout>
#include <QLabel>
#include <QSlider>
#include <QProgressBar>

class SocialFeedWidget : public QWidget
{
    Q_OBJECT

public:
    explicit SocialFeedWidget(QWidget *parent = nullptr);

private slots:
    void createPost();
    void editPost();
    void deletePost();
    void likePost();
    void sharePost();
    void commentPost();
    void followUser();
    void unfollowUser();
    void blockUser();
    void reportPost();
    void refreshFeed();
    void loadMore();
    void searchPosts();
    void filterPosts();
    void sortPosts();
    void exportFeed();
    void importFeed();
    void printFeed();
    void shareFeed();
    void updateFeed();
    void onPostChanged();
    void onUserChanged();
    void onFeedChanged();
    void onSearchChanged();
    void onFilterChanged();
    void onSortChanged();

private:
    void setupUI();
    void setupFeed();
    void setupCompose();
    void setupControls();
    void updateFeed();
    void updateCompose();
    void updateControls();
    void createPost();
    void editPost();
    void deletePost();
    void likePost();
    void sharePost();
    void commentPost();
    void followUser();
    void unfollowUser();
    void blockUser();
    void reportPost();
    void refreshFeed();
    void loadMore();
    void searchPosts();
    void filterPosts();
    void sortPosts();
    void exportFeed();
    void importFeed();
    void printFeed();
    void shareFeed();
    void onPostChanged();
    void onUserChanged();
    void onFeedChanged();
    void onSearchChanged();
    void onFilterChanged();
    void onSortChanged();
    
    // Feed
    QListWidget *m_feedList;
    QProgressBar *m_loadingBar;
    QLabel *m_statusLabel;
    
    // Compose
    QGroupBox *m_composeGroup;
    QTextEdit *m_composeEdit;
    QPushButton *m_postButton;
    QPushButton *m_cancelButton;
    QPushButton *m_attachButton;
    QPushButton *m_locationButton;
    QPushButton *m_pollButton;
    
    // Controls
    QLineEdit *m_searchEdit;
    QComboBox *m_filterCombo;
    QComboBox *m_sortCombo;
    QPushButton *m_refreshButton;
    QPushButton *m_loadMoreButton;
    QPushButton *m_exportButton;
    QPushButton *m_importButton;
    QPushButton *m_printButton;
    QPushButton *m_shareButton;
    
    // Data
    QList<QVariantMap> m_posts;
    QList<QVariantMap> m_users;
    QString m_currentUser;
    bool m_isPosting;
    bool m_isEditing;
    bool m_isDeleting;
    bool m_isLiking;
    bool m_isSharing;
    bool m_isCommenting;
    bool m_isFollowing;
    bool m_isUnfollowing;
    bool m_isBlocking;
    bool m_isReporting;
    bool m_isRefreshing;
    bool m_isLoading;
    bool m_isSearching;
    bool m_isFiltering;
    bool m_isSorting;
    bool m_isExporting;
    bool m_isImporting;
    bool m_isPrinting;
    bool m_isSharingFeed;
};

#endif // SOCIALFEEDWIDGET_H

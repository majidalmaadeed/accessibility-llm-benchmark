#ifndef MEDIAPLAYERWIDGET_H
#define MEDIAPLAYERWIDGET_H

#include <QWidget>
#include <QMediaPlayer>
#include <QVideoWidget>
#include <QSlider>
#include <QPushButton>
#include <QLabel>
#include <QComboBox>
#include <QListWidget>
#include <QGroupBox>
#include <QVBoxLayout>
#include <QHBoxLayout>
#include <QGridLayout>
#include <QProgressBar>
#include <QCheckBox>
#include <QSpinBox>
#include <QLineEdit>
#include <QTimer>

class MediaPlayerWidget : public QWidget
{
    Q_OBJECT

public:
    explicit MediaPlayerWidget(QWidget *parent = nullptr);

private slots:
    void play();
    void pause();
    void stop();
    void next();
    void previous();
    void seek(int position);
    void setVolume(int volume);
    void setPlaybackRate(double rate);
    void toggleMute();
    void toggleFullscreen();
    void toggleRepeat();
    void toggleShuffle();
    void addToPlaylist();
    void removeFromPlaylist();
    void clearPlaylist();
    void loadMedia();
    void savePlaylist();
    void loadPlaylist();
    void updatePosition();
    void updateDuration();
    void updateVolume();
    void updatePlaybackRate();
    void updatePlaylist();
    void onMediaChanged();
    void onPlaybackStateChanged();
    void onMediaStatusChanged();

private:
    void setupUI();
    void setupPlayer();
    void setupControls();
    void setupPlaylist();
    void setupEqualizer();
    void setupSettings();
    void updateControls();
    void updatePlaylistInfo();
    void loadMediaFile(const QString &filePath);
    void updatePlaybackInfo();
    
    // Media Player
    QMediaPlayer *m_mediaPlayer;
    QVideoWidget *m_videoWidget;
    
    // Controls
    QPushButton *m_playButton;
    QPushButton *m_pauseButton;
    QPushButton *m_stopButton;
    QPushButton *m_nextButton;
    QPushButton *m_previousButton;
    QPushButton *m_muteButton;
    QPushButton *m_fullscreenButton;
    QPushButton *m_repeatButton;
    QPushButton *m_shuffleButton;
    QPushButton *m_loadButton;
    QPushButton *m_saveButton;
    QPushButton *m_clearButton;
    
    // Sliders
    QSlider *m_positionSlider;
    QSlider *m_volumeSlider;
    QSlider *m_rateSlider;
    
    // Labels
    QLabel *m_positionLabel;
    QLabel *m_durationLabel;
    QLabel *m_volumeLabel;
    QLabel *m_rateLabel;
    QLabel *m_titleLabel;
    QLabel *m_artistLabel;
    QLabel *m_albumLabel;
    
    // Playlist
    QListWidget *m_playlistWidget;
    QPushButton *m_addButton;
    QPushButton *m_removeButton;
    
    // Equalizer
    QGroupBox *m_equalizerGroup;
    QSlider *m_eq60Hz;
    QSlider *m_eq170Hz;
    QSlider *m_eq310Hz;
    QSlider *m_eq600Hz;
    QSlider *m_eq1kHz;
    QSlider *m_eq3kHz;
    QSlider *m_eq6kHz;
    QSlider *m_eq12kHz;
    QSlider *m_eq14kHz;
    QSlider *m_eq16kHz;
    
    // Settings
    QGroupBox *m_settingsGroup;
    QCheckBox *m_autoPlayCheck;
    QCheckBox *m_showLyricsCheck;
    QCheckBox *m_rememberPositionCheck;
    QSpinBox *m_fadeInSpin;
    QSpinBox *m_fadeOutSpin;
    QComboBox *m_audioDeviceCombo;
    QComboBox *m_videoDeviceCombo;
    
    // Timer
    QTimer *m_updateTimer;
    
    // Data
    QStringList m_playlist;
    int m_currentIndex;
    bool m_isPlaying;
    bool m_isMuted;
    bool m_isRepeating;
    bool m_isShuffling;
    int m_volume;
    double m_playbackRate;
};

#endif // MEDIAPLAYERWIDGET_H

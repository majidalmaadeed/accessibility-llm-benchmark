import React, { useState, useEffect, useRef } from 'react';
import {
  View,
  Text,
  TouchableOpacity,
  StyleSheet,
  Dimensions,
  Modal,
  Alert,
  ScrollView,
  Switch,
} from 'react-native';
import { Ionicons } from '@expo/vector-icons';

const { width, height } = Dimensions.get('window');

const MediaPlayerFullInterface = () => {
  const [isPlaying, setIsPlaying] = useState(false);
  const [currentTime, setCurrentTime] = useState(0);
  const [duration, setDuration] = useState(180); // 3 minutes in seconds
  const [volume, setVolume] = useState(0.7);
  const [playbackRate, setPlaybackRate] = useState(1.0);
  const [isFullscreen, setIsFullscreen] = useState(false);
  const [showControls, setShowControls] = useState(true);
  const [showCaptions, setShowCaptions] = useState(false);
  const [showQualityMenu, setShowQualityMenu] = useState(false);
  const [showPlaybackRateMenu, setShowPlaybackRateMenu] = useState(false);
  const [showCaptionsMenu, setShowCaptionsMenu] = useState(false);
  const [selectedQuality, setSelectedQuality] = useState('1080p');
  const [selectedCaption, setSelectedCaption] = useState('English');
  const [isMuted, setIsMuted] = useState(false);
  const [isBuffering, setIsBuffering] = useState(false);

  const progressBarRef = useRef(null);
  const controlsTimeoutRef = useRef(null);

  const qualities = ['240p', '360p', '480p', '720p', '1080p', '4K'];
  const playbackRates = [0.25, 0.5, 0.75, 1.0, 1.25, 1.5, 1.75, 2.0];
  const captions = ['English', 'Spanish', 'French', 'German', 'Off'];

  useEffect(() => {
    if (isPlaying) {
      const interval = setInterval(() => {
        setCurrentTime(prev => {
          if (prev >= duration) {
            setIsPlaying(false);
            return 0;
          }
          return prev + 1;
        });
      }, 1000);
      return () => clearInterval(interval);
    }
  }, [isPlaying, duration]);

  useEffect(() => {
    if (showControls) {
      clearTimeout(controlsTimeoutRef.current);
      controlsTimeoutRef.current = setTimeout(() => {
        setShowControls(false);
      }, 3000);
    }
  }, [showControls]);

  const formatTime = (seconds) => {
    const mins = Math.floor(seconds / 60);
    const secs = Math.floor(seconds % 60);
    return `${mins}:${secs.toString().padStart(2, '0')}`;
  };

  const handlePlayPause = () => {
    setIsPlaying(!isPlaying);
    setShowControls(true);
  };

  const handleSeek = (event) => {
    if (progressBarRef.current) {
      const { locationX } = event.nativeEvent;
      const progressBarWidth = progressBarRef.current.offsetWidth || width - 40;
      const newTime = (locationX / progressBarWidth) * duration;
      setCurrentTime(Math.max(0, Math.min(newTime, duration)));
    }
  };

  const handleVolumeChange = (newVolume) => {
    setVolume(newVolume);
    setIsMuted(newVolume === 0);
  };

  const handleMute = () => {
    if (isMuted) {
      setVolume(0.7);
      setIsMuted(false);
    } else {
      setVolume(0);
      setIsMuted(true);
    }
  };

  const handleFullscreen = () => {
    setIsFullscreen(!isFullscreen);
  };

  const handleSkip = (seconds) => {
    setCurrentTime(prev => Math.max(0, Math.min(prev + seconds, duration)));
    setShowControls(true);
  };

  const handleQualityChange = (quality) => {
    setSelectedQuality(quality);
    setShowQualityMenu(false);
    setIsBuffering(true);
    setTimeout(() => setIsBuffering(false), 2000);
  };

  const handlePlaybackRateChange = (rate) => {
    setPlaybackRate(rate);
    setShowPlaybackRateMenu(false);
  };

  const handleCaptionChange = (caption) => {
    setSelectedCaption(caption);
    setShowCaptions(caption !== 'Off');
    setShowCaptionsMenu(false);
  };

  const renderProgressBar = () => (
    <View style={styles.progressContainer}>
      <Text style={styles.timeText}>{formatTime(currentTime)}</Text>
      <TouchableOpacity
        style={styles.progressBar}
        onPress={handleSeek}
        ref={progressBarRef}
      >
        <View style={styles.progressTrack}>
          <View
            style={[
              styles.progressFill,
              { width: `${(currentTime / duration) * 100}%` }
            ]}
          />
          <View
            style={[
              styles.progressThumb,
              { left: `${(currentTime / duration) * 100}%` }
            ]}
          />
        </View>
      </TouchableOpacity>
      <Text style={styles.timeText}>{formatTime(duration)}</Text>
    </View>
  );

  const renderMainControls = () => (
    <View style={styles.mainControls}>
      <TouchableOpacity
        style={styles.controlButton}
        onPress={() => handleSkip(-10)}
      >
        <Ionicons name="play-skip-back" size={24} color="#fff" />
      </TouchableOpacity>

      <TouchableOpacity
        style={styles.playButton}
        onPress={handlePlayPause}
      >
        <Ionicons
          name={isPlaying ? "pause" : "play"}
          size={32}
          color="#fff"
        />
      </TouchableOpacity>

      <TouchableOpacity
        style={styles.controlButton}
        onPress={() => handleSkip(10)}
      >
        <Ionicons name="play-skip-forward" size={24} color="#fff" />
      </TouchableOpacity>
    </View>
  );

  const renderSecondaryControls = () => (
    <View style={styles.secondaryControls}>
      <View style={styles.volumeContainer}>
        <TouchableOpacity
          style={styles.controlButton}
          onPress={handleMute}
        >
          <Ionicons
            name={isMuted ? "volume-mute" : "volume-high"}
            size={20}
            color="#fff"
          />
        </TouchableOpacity>
        <View style={styles.volumeSlider}>
          <View style={styles.volumeTrack}>
            <View
              style={[
                styles.volumeFill,
                { width: `${volume * 100}%` }
              ]}
            />
          </View>
        </View>
      </View>

      <TouchableOpacity
        style={styles.controlButton}
        onPress={() => setShowPlaybackRateMenu(true)}
      >
        <Text style={styles.controlText}>{playbackRate}x</Text>
      </TouchableOpacity>

      <TouchableOpacity
        style={styles.controlButton}
        onPress={() => setShowCaptionsMenu(true)}
      >
        <Ionicons name="text" size={20} color="#fff" />
      </TouchableOpacity>

      <TouchableOpacity
        style={styles.controlButton}
        onPress={() => setShowQualityMenu(true)}
      >
        <Text style={styles.controlText}>{selectedQuality}</Text>
      </TouchableOpacity>

      <TouchableOpacity
        style={styles.controlButton}
        onPress={handleFullscreen}
      >
        <Ionicons
          name={isFullscreen ? "contract" : "expand"}
          size={20}
          color="#fff"
        />
      </TouchableOpacity>
    </View>
  );

  const renderQualityMenu = () => (
    <Modal
      visible={showQualityMenu}
      animationType="fade"
      transparent={true}
      onRequestClose={() => setShowQualityMenu(false)}
    >
      <View style={styles.modalOverlay}>
        <View style={styles.menuContainer}>
          <Text style={styles.menuTitle}>Video Quality</Text>
          {qualities.map((quality) => (
            <TouchableOpacity
              key={quality}
              style={styles.menuItem}
              onPress={() => handleQualityChange(quality)}
            >
              <Text style={styles.menuItemText}>{quality}</Text>
              {selectedQuality === quality && (
                <Ionicons name="checkmark" size={20} color="#007AFF" />
              )}
            </TouchableOpacity>
          ))}
        </View>
      </View>
    </Modal>
  );

  const renderPlaybackRateMenu = () => (
    <Modal
      visible={showPlaybackRateMenu}
      animationType="fade"
      transparent={true}
      onRequestClose={() => setShowPlaybackRateMenu(false)}
    >
      <View style={styles.modalOverlay}>
        <View style={styles.menuContainer}>
          <Text style={styles.menuTitle}>Playback Speed</Text>
          {playbackRates.map((rate) => (
            <TouchableOpacity
              key={rate}
              style={styles.menuItem}
              onPress={() => handlePlaybackRateChange(rate)}
            >
              <Text style={styles.menuItemText}>{rate}x</Text>
              {playbackRate === rate && (
                <Ionicons name="checkmark" size={20} color="#007AFF" />
              )}
            </TouchableOpacity>
          ))}
        </View>
      </View>
    </Modal>
  );

  const renderCaptionsMenu = () => (
    <Modal
      visible={showCaptionsMenu}
      animationType="fade"
      transparent={true}
      onRequestClose={() => setShowCaptionsMenu(false)}
    >
      <View style={styles.modalOverlay}>
        <View style={styles.menuContainer}>
          <Text style={styles.menuTitle}>Captions</Text>
          {captions.map((caption) => (
            <TouchableOpacity
              key={caption}
              style={styles.menuItem}
              onPress={() => handleCaptionChange(caption)}
            >
              <Text style={styles.menuItemText}>{caption}</Text>
              {selectedCaption === caption && (
                <Ionicons name="checkmark" size={20} color="#007AFF" />
              )}
            </TouchableOpacity>
          ))}
        </View>
      </View>
    </Modal>
  );

  const renderVideoArea = () => (
    <View style={styles.videoArea}>
      <View style={styles.videoPlaceholder}>
        <Ionicons name="play-circle" size={80} color="rgba(255,255,255,0.8)" />
        <Text style={styles.videoTitle}>Sample Video</Text>
        <Text style={styles.videoSubtitle}>Media Player Interface</Text>
      </View>
      
      {isBuffering && (
        <View style={styles.bufferingOverlay}>
          <View style={styles.bufferingSpinner}>
            <Ionicons name="refresh" size={24} color="#fff" />
          </View>
          <Text style={styles.bufferingText}>Buffering...</Text>
        </View>
      )}

      {showCaptions && selectedCaption !== 'Off' && (
        <View style={styles.captionsOverlay}>
          <Text style={styles.captionsText}>
            This is a sample caption for the video content.
          </Text>
        </View>
      )}
    </View>
  );

  const renderPlayerInterface = () => (
    <View style={styles.playerContainer}>
      <TouchableOpacity
        style={styles.videoTouchArea}
        onPress={() => setShowControls(!showControls)}
        activeOpacity={1}
      >
        {renderVideoArea()}
      </TouchableOpacity>

      {showControls && (
        <View style={styles.controlsOverlay}>
          <View style={styles.controlsTop}>
            <Text style={styles.videoInfo}>Sample Video - {selectedQuality}</Text>
            <View style={styles.topControls}>
              <TouchableOpacity
                style={styles.controlButton}
                onPress={() => Alert.alert('Settings', 'Settings menu')}
              >
                <Ionicons name="settings" size={20} color="#fff" />
              </TouchableOpacity>
              <TouchableOpacity
                style={styles.controlButton}
                onPress={() => Alert.alert('Share', 'Share video')}
              >
                <Ionicons name="share" size={20} color="#fff" />
              </TouchableOpacity>
            </View>
          </View>

          <View style={styles.controlsCenter}>
            {renderMainControls()}
          </View>

          <View style={styles.controlsBottom}>
            {renderProgressBar()}
            {renderSecondaryControls()}
          </View>
        </View>
      )}
    </View>
  );

  return (
    <View style={[styles.container, isFullscreen && styles.fullscreenContainer]}>
      {renderPlayerInterface()}
      {renderQualityMenu()}
      {renderPlaybackRateMenu()}
      {renderCaptionsMenu()}
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#000',
  },
  fullscreenContainer: {
    position: 'absolute',
    top: 0,
    left: 0,
    right: 0,
    bottom: 0,
    zIndex: 1000,
  },
  playerContainer: {
    flex: 1,
    position: 'relative',
  },
  videoTouchArea: {
    flex: 1,
  },
  videoArea: {
    flex: 1,
    backgroundColor: '#000',
    justifyContent: 'center',
    alignItems: 'center',
    position: 'relative',
  },
  videoPlaceholder: {
    alignItems: 'center',
  },
  videoTitle: {
    fontSize: 24,
    fontWeight: 'bold',
    color: '#fff',
    marginTop: 16,
  },
  videoSubtitle: {
    fontSize: 16,
    color: 'rgba(255,255,255,0.7)',
    marginTop: 8,
  },
  bufferingOverlay: {
    position: 'absolute',
    top: 0,
    left: 0,
    right: 0,
    bottom: 0,
    backgroundColor: 'rgba(0,0,0,0.7)',
    justifyContent: 'center',
    alignItems: 'center',
  },
  bufferingSpinner: {
    width: 40,
    height: 40,
    borderRadius: 20,
    backgroundColor: 'rgba(255,255,255,0.2)',
    justifyContent: 'center',
    alignItems: 'center',
    marginBottom: 12,
  },
  bufferingText: {
    color: '#fff',
    fontSize: 16,
  },
  captionsOverlay: {
    position: 'absolute',
    bottom: 100,
    left: 20,
    right: 20,
    backgroundColor: 'rgba(0,0,0,0.8)',
    padding: 12,
    borderRadius: 8,
  },
  captionsText: {
    color: '#fff',
    fontSize: 16,
    textAlign: 'center',
  },
  controlsOverlay: {
    position: 'absolute',
    top: 0,
    left: 0,
    right: 0,
    bottom: 0,
    backgroundColor: 'rgba(0,0,0,0.3)',
    justifyContent: 'space-between',
  },
  controlsTop: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    padding: 20,
    paddingTop: 40,
  },
  videoInfo: {
    color: '#fff',
    fontSize: 16,
    fontWeight: '500',
  },
  topControls: {
    flexDirection: 'row',
    gap: 12,
  },
  controlsCenter: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
  },
  controlsBottom: {
    padding: 20,
    paddingBottom: 40,
  },
  mainControls: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'center',
    gap: 40,
  },
  playButton: {
    width: 60,
    height: 60,
    borderRadius: 30,
    backgroundColor: 'rgba(255,255,255,0.2)',
    justifyContent: 'center',
    alignItems: 'center',
  },
  controlButton: {
    width: 40,
    height: 40,
    borderRadius: 20,
    backgroundColor: 'rgba(255,255,255,0.2)',
    justifyContent: 'center',
    alignItems: 'center',
  },
  controlText: {
    color: '#fff',
    fontSize: 14,
    fontWeight: '500',
  },
  secondaryControls: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'space-between',
    marginTop: 16,
  },
  volumeContainer: {
    flexDirection: 'row',
    alignItems: 'center',
    flex: 1,
    marginRight: 16,
  },
  volumeSlider: {
    flex: 1,
    marginLeft: 8,
  },
  volumeTrack: {
    height: 4,
    backgroundColor: 'rgba(255,255,255,0.3)',
    borderRadius: 2,
  },
  volumeFill: {
    height: 4,
    backgroundColor: '#fff',
    borderRadius: 2,
  },
  progressContainer: {
    flexDirection: 'row',
    alignItems: 'center',
    marginBottom: 16,
  },
  timeText: {
    color: '#fff',
    fontSize: 14,
    fontWeight: '500',
    minWidth: 40,
  },
  progressBar: {
    flex: 1,
    marginHorizontal: 12,
  },
  progressTrack: {
    height: 4,
    backgroundColor: 'rgba(255,255,255,0.3)',
    borderRadius: 2,
    position: 'relative',
  },
  progressFill: {
    height: 4,
    backgroundColor: '#fff',
    borderRadius: 2,
  },
  progressThumb: {
    position: 'absolute',
    top: -6,
    width: 16,
    height: 16,
    borderRadius: 8,
    backgroundColor: '#fff',
    marginLeft: -8,
  },
  modalOverlay: {
    flex: 1,
    backgroundColor: 'rgba(0, 0, 0, 0.5)',
    justifyContent: 'center',
    alignItems: 'center',
  },
  menuContainer: {
    backgroundColor: '#fff',
    borderRadius: 12,
    padding: 20,
    width: width - 40,
    maxHeight: height * 0.6,
  },
  menuTitle: {
    fontSize: 18,
    fontWeight: 'bold',
    color: '#333',
    marginBottom: 16,
    textAlign: 'center',
  },
  menuItem: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    paddingVertical: 12,
    borderBottomWidth: 1,
    borderBottomColor: '#f0f0f0',
  },
  menuItemText: {
    fontSize: 16,
    color: '#333',
  },
});

export default MediaPlayerFullInterface;

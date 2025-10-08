import React, { useState } from 'react';
import {
  View,
  Text,
  TouchableOpacity,
  ScrollView,
  StyleSheet,
  Image,
  Dimensions,
} from 'react-native';

const { width } = Dimensions.get('window');

const UnlabeledMediaButton = () => {
  const [isPlaying, setIsPlaying] = useState(false);
  const [currentVideo, setCurrentVideo] = useState('Sample Video 1');

  const videos = [
    'Sample Video 1',
    'Sample Video 2',
    'Sample Video 3',
    'Sample Video 4',
    'Sample Video 5'
  ];

  const togglePlay = () => {
    setIsPlaying(!isPlaying);
  };

  const selectVideo = (video) => {
    setCurrentVideo(video);
    setIsPlaying(false);
  };

  return (
    <ScrollView style={styles.container}>
      {/* Header */}
      <View style={styles.header}>
        <Text style={styles.headerTitle}>Video Player</Text>
        <Text style={styles.headerSubtitle}>Watch your favorite videos</Text>
      </View>

      {/* Video Player Section */}
      <View style={styles.videoContainer}>
        <View style={styles.videoPlaceholder}>
          <Text style={styles.videoText}>Video Preview</Text>
          
          {}
          <TouchableOpacity
            style={styles.playButton}
            onPress={togglePlay}
            accessibilityLabel={null}No accessible name
          >
            <Text style={styles.playIcon}>
              {isPlaying ? '⏸️' : '▶️'}
            </Text>
          </TouchableOpacity>
        </View>
      </View>

      {/* Video Info */}
      <View style={styles.infoContainer}>
        <Text style={styles.videoTitle}>{currentVideo}</Text>
        <Text style={styles.videoDetails}>Duration: 3:45</Text>
        <Text style={styles.videoDetails}>Quality: 1080p</Text>
      </View>

      {/* Video List */}
      <View style={styles.listContainer}>
        <Text style={styles.listTitle}>More Videos</Text>
        {videos.map((video, index) => (
          <TouchableOpacity
            key={index}
            style={[
              styles.videoItem,
              video === currentVideo && styles.selectedVideoItem
            ]}
            onPress={() => selectVideo(video)}
          >
            <View style={styles.videoThumbnail}>
              <Text style={styles.thumbnailIcon}>▶️</Text>
            </View>
            <View style={styles.videoItemInfo}>
              <Text style={styles.videoItemTitle}>{video}</Text>
              <Text style={styles.videoItemDetails}>3:45 • 1080p</Text>
            </View>
            {video === currentVideo && (
              <Text style={styles.checkIcon}>✓</Text>
            )}
          </TouchableOpacity>
        ))}
      </View>
    </ScrollView>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#F5F5F5',
  },
  header: {
    backgroundColor: '#2196F3',
    padding: 32,
    alignItems: 'center',
  },
  headerTitle: {
    fontSize: 24,
    fontWeight: 'bold',
    color: '#FFFFFF',
    marginBottom: 8,
  },
  headerSubtitle: {
    fontSize: 16,
    color: '#FFFFFF',
    opacity: 0.9,
  },
  videoContainer: {
    backgroundColor: '#FFFFFF',
    margin: 16,
    borderRadius: 8,
    overflow: 'hidden',
  },
  videoPlaceholder: {
    height: 200,
    backgroundColor: '#333333',
    justifyContent: 'center',
    alignItems: 'center',
    position: 'relative',
  },
  videoText: {
    color: '#FFFFFF',
    fontSize: 18,
    marginBottom: 16,
  },
  playButton: {
    width: 60,
    height: 60,
    borderRadius: 30,
    backgroundColor: 'rgba(0, 0, 0, 0.7)',
    justifyContent: 'center',
    alignItems: 'center',
  },
  playIcon: {
    fontSize: 30,
    color: '#FFFFFF',
  },
  infoContainer: {
    backgroundColor: '#FFFFFF',
    padding: 16,
    margin: 16,
    borderRadius: 8,
  },
  videoTitle: {
    fontSize: 18,
    fontWeight: '600',
    marginBottom: 8,
  },
  videoDetails: {
    fontSize: 14,
    color: '#666666',
    marginBottom: 4,
  },
  listContainer: {
    backgroundColor: '#FFFFFF',
    margin: 16,
    padding: 16,
    borderRadius: 8,
  },
  listTitle: {
    fontSize: 18,
    fontWeight: 'bold',
    marginBottom: 16,
  },
  videoItem: {
    flexDirection: 'row',
    alignItems: 'center',
    padding: 12,
    backgroundColor: '#F8F9FA',
    borderRadius: 8,
    marginBottom: 8,
  },
  selectedVideoItem: {
    backgroundColor: '#E3F2FD',
  },
  videoThumbnail: {
    width: 60,
    height: 60,
    backgroundColor: '#E0E0E0',
    borderRadius: 4,
    justifyContent: 'center',
    alignItems: 'center',
    marginRight: 12,
  },
  thumbnailIcon: {
    fontSize: 24,
    color: '#666666',
  },
  videoItemInfo: {
    flex: 1,
  },
  videoItemTitle: {
    fontSize: 16,
    fontWeight: '600',
    marginBottom: 4,
  },
  videoItemDetails: {
    fontSize: 14,
    color: '#666666',
  },
  checkIcon: {
    fontSize: 20,
    color: '#2196F3',
  },
});

export default UnlabeledMediaButton;

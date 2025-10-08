import React, { useState, useEffect, useRef } from 'react';
import {
  View,
  Text,
  TouchableOpacity,
  ScrollView,
  StyleSheet,
  Image,
  Dimensions,
  Animated,
} from 'react-native';
import Video from 'react-native-video';

const AutoPlayingBackgroundVideo = () => {
  const [currentSlide, setCurrentSlide] = useState(0);
  const [isPlaying, setIsPlaying] = useState(true);
  const fadeAnim = useRef(new Animated.Value(1)).current;
  const { width, height } = Dimensions.get('window');

  const heroSlides = [
    {
      id: 1,
      title: 'Revolutionary Technology',
      subtitle: 'Experience the future today',
      description: 'Discover cutting-edge solutions that transform how you work and live.',
      videoUrl: 'https://sample-videos.com/zip/10/mp4/SampleVideo_1280x720_1mb.mp4',
      imageUrl: 'https://via.placeholder.com/400x300',
      ctaText: 'Learn More',
      ctaAction: 'learn'
    },
    {
      id: 2,
      title: 'Innovation at Scale',
      subtitle: 'Built for tomorrow',
      description: 'Scalable solutions designed to grow with your business needs.',
      videoUrl: 'https://sample-videos.com/zip/10/mp4/SampleVideo_1280x720_2mb.mp4',
      imageUrl: 'https://via.placeholder.com/400x300',
      ctaText: 'Get Started',
      ctaAction: 'start'
    },
    {
      id: 3,
      title: 'Seamless Integration',
      subtitle: 'Connect everything',
      description: 'Integrate seamlessly with your existing systems and workflows.',
      videoUrl: 'https://sample-videos.com/zip/10/mp4/SampleVideo_1280x720_5mb.mp4',
      imageUrl: 'https://via.placeholder.com/400x300',
      ctaText: 'Explore',
      ctaAction: 'explore'
    }
  ];

  const features = [
    {
      icon: '🚀',
      title: 'Fast Performance',
      description: 'Lightning-fast processing and response times'
    },
    {
      icon: '🔒',
      title: 'Secure & Reliable',
      description: 'Enterprise-grade security and 99.9% uptime'
    },
    {
      icon: '📱',
      title: 'Mobile Ready',
      description: 'Optimized for all devices and screen sizes'
    },
    {
      icon: '⚡',
      title: 'Easy Integration',
      description: 'Simple APIs and comprehensive documentation'
    }
  ];

  useEffect(() => {
    const interval = setInterval(() => {
      setCurrentSlide((prev) => (prev + 1) % heroSlides.length);
    }, 5000); // Auto-advance every 5 seconds

    return () => clearInterval(interval);
  }, []);

  useEffect(() => {
    // Fade animation when slide changes
    Animated.sequence([
      Animated.timing(fadeAnim, {
        toValue: 0,
        duration: 300,
        useNativeDriver: true,
      }),
      Animated.timing(fadeAnim, {
        toValue: 1,
        duration: 300,
        useNativeDriver: true,
      }),
    ]).start();
  }, [currentSlide]);

  const handlePlayPause = () => {
    setIsPlaying(!isPlaying);
  };

  const handleSlidePress = (index) => {
    setCurrentSlide(index);
  };

  const handleCTAAction = (action) => {
    console.log(`CTA Action: ${action}`);
  };

  const currentSlideData = heroSlides[currentSlide];

  return (
    <ScrollView style={styles.container}>
      {/* Hero Section with Auto-playing Background Video */}
      <View style={styles.heroContainer}>
        {/* Background Video - AUTOPLAYS WITHOUT USER CONTROL */}
        <View style={styles.videoContainer}>
          <Video
            source={{ uri: currentSlideData.videoUrl }}
            style={styles.backgroundVideo}
            resizeMode="cover"
            repeat={true}
            muted={true}
            paused={!isPlaying}
            playInBackground={false}
            playWhenInactive={false}
            ignoreSilentSwitch="ignore"
            onError={(error) => console.log('Video Error:', error)}
          />
          
          {/* Video Overlay */}
          <View style={styles.videoOverlay}>
            <Animated.View style={[styles.heroContent, { opacity: fadeAnim }]}>
              <Text style={styles.heroTitle}>{currentSlideData.title}</Text>
              <Text style={styles.heroSubtitle}>{currentSlideData.subtitle}</Text>
              <Text style={styles.heroDescription}>{currentSlideData.description}</Text>
              
              <View style={styles.heroActions}>
                <TouchableOpacity 
                  style={styles.primaryButton}
                  onPress={() => handleCTAAction(currentSlideData.ctaAction)}
                >
                  <Text style={styles.primaryButtonText}>{currentSlideData.ctaText}</Text>
                </TouchableOpacity>
                
                <TouchableOpacity 
                  style={styles.secondaryButton}
                  onPress={handlePlayPause}
                >
                  <Text style={styles.secondaryButtonText}>
                    {isPlaying ? '⏸️ Pause' : '▶️ Play'}
                  </Text>
                </TouchableOpacity>
              </View>
            </Animated.View>
          </View>
        </View>

        {/* Slide Indicators */}
        <View style={styles.slideIndicators}>
          {heroSlides.map((_, index) => (
            <TouchableOpacity
              key={index}
              style={[
                styles.indicator,
                index === currentSlide && styles.activeIndicator
              ]}
              onPress={() => handleSlidePress(index)}
            />
          ))}
        </View>
      </View>

      {/* Features Section */}
      <View style={styles.featuresContainer}>
        <Text style={styles.sectionTitle}>Why Choose Us</Text>
        <Text style={styles.sectionSubtitle}>
          Powerful features designed to accelerate your success
        </Text>
        
        <View style={styles.featuresGrid}>
          {features.map((feature, index) => (
            <View key={index} style={styles.featureCard}>
              <Text style={styles.featureIcon}>{feature.icon}</Text>
              <Text style={styles.featureTitle}>{feature.title}</Text>
              <Text style={styles.featureDescription}>{feature.description}</Text>
            </View>
          ))}
        </View>
      </View>

      {/* Stats Section */}
      <View style={styles.statsContainer}>
        <Text style={styles.statsTitle}>Trusted by Thousands</Text>
        <View style={styles.statsGrid}>
          <View style={styles.statItem}>
            <Text style={styles.statNumber}>10K+</Text>
            <Text style={styles.statLabel}>Active Users</Text>
          </View>
          <View style={styles.statItem}>
            <Text style={styles.statNumber}>99.9%</Text>
            <Text style={styles.statLabel}>Uptime</Text>
          </View>
          <View style={styles.statItem}>
            <Text style={styles.statNumber}>24/7</Text>
            <Text style={styles.statLabel}>Support</Text>
          </View>
          <View style={styles.statItem}>
            <Text style={styles.statNumber}>50+</Text>
            <Text style={styles.statLabel}>Countries</Text>
          </View>
        </View>
      </View>

      {/* CTA Section */}
      <View style={styles.ctaContainer}>
        <Text style={styles.ctaTitle}>Ready to Get Started?</Text>
        <Text style={styles.ctaDescription}>
          Join thousands of satisfied customers and transform your business today.
        </Text>
        <View style={styles.ctaButtons}>
          <TouchableOpacity 
            style={styles.ctaPrimaryButton}
            onPress={() => handleCTAAction('signup')}
          >
            <Text style={styles.ctaPrimaryButtonText}>Start Free Trial</Text>
          </TouchableOpacity>
          <TouchableOpacity 
            style={styles.ctaSecondaryButton}
            onPress={() => handleCTAAction('contact')}
          >
            <Text style={styles.ctaSecondaryButtonText}>Contact Sales</Text>
          </TouchableOpacity>
        </View>
      </View>

      {/* Footer */}
      <View style={styles.footer}>
        <Text style={styles.footerText}>
          © 2024 TechCorp. All rights reserved.
        </Text>
        <View style={styles.footerLinks}>
          <TouchableOpacity>
            <Text style={styles.footerLink}>Privacy Policy</Text>
          </TouchableOpacity>
          <TouchableOpacity>
            <Text style={styles.footerLink}>Terms of Service</Text>
          </TouchableOpacity>
          <TouchableOpacity>
            <Text style={styles.footerLink}>Support</Text>
          </TouchableOpacity>
        </View>
      </View>
    </ScrollView>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#FFFFFF',
  },
  heroContainer: {
    height: 500,
    position: 'relative',
  },
  videoContainer: {
    flex: 1,
    position: 'relative',
  },
  backgroundVideo: {
    position: 'absolute',
    top: 0,
    left: 0,
    right: 0,
    bottom: 0,
    width: '100%',
    height: '100%',
  },
  videoOverlay: {
    position: 'absolute',
    top: 0,
    left: 0,
    right: 0,
    bottom: 0,
    backgroundColor: 'rgba(0, 0, 0, 0.4)',
    justifyContent: 'center',
    alignItems: 'center',
    padding: 32,
  },
  heroContent: {
    alignItems: 'center',
    maxWidth: 600,
  },
  heroTitle: {
    fontSize: 36,
    fontWeight: 'bold',
    color: '#FFFFFF',
    textAlign: 'center',
    marginBottom: 16,
    textShadowColor: 'rgba(0, 0, 0, 0.5)',
    textShadowOffset: { width: 0, height: 2 },
    textShadowRadius: 4,
  },
  heroSubtitle: {
    fontSize: 20,
    color: '#E0E0E0',
    textAlign: 'center',
    marginBottom: 16,
    textShadowColor: 'rgba(0, 0, 0, 0.5)',
    textShadowOffset: { width: 0, height: 1 },
    textShadowRadius: 2,
  },
  heroDescription: {
    fontSize: 16,
    color: '#BDBDBD',
    textAlign: 'center',
    lineHeight: 24,
    marginBottom: 32,
    textShadowColor: 'rgba(0, 0, 0, 0.5)',
    textShadowOffset: { width: 0, height: 1 },
    textShadowRadius: 2,
  },
  heroActions: {
    flexDirection: 'row',
    alignItems: 'center',
  },
  primaryButton: {
    backgroundColor: '#2196F3',
    paddingVertical: 16,
    paddingHorizontal: 32,
    borderRadius: 8,
    marginRight: 16,
  },
  primaryButtonText: {
    color: '#FFFFFF',
    fontSize: 18,
    fontWeight: '600',
  },
  secondaryButton: {
    backgroundColor: 'rgba(255, 255, 255, 0.2)',
    paddingVertical: 16,
    paddingHorizontal: 24,
    borderRadius: 8,
    borderWidth: 1,
    borderColor: 'rgba(255, 255, 255, 0.3)',
  },
  secondaryButtonText: {
    color: '#FFFFFF',
    fontSize: 16,
    fontWeight: '500',
  },
  slideIndicators: {
    position: 'absolute',
    bottom: 20,
    left: 0,
    right: 0,
    flexDirection: 'row',
    justifyContent: 'center',
  },
  indicator: {
    width: 12,
    height: 12,
    borderRadius: 6,
    backgroundColor: 'rgba(255, 255, 255, 0.4)',
    marginHorizontal: 6,
  },
  activeIndicator: {
    backgroundColor: '#FFFFFF',
  },
  featuresContainer: {
    padding: 32,
    backgroundColor: '#F8F9FA',
  },
  sectionTitle: {
    fontSize: 28,
    fontWeight: 'bold',
    color: '#2C3E50',
    textAlign: 'center',
    marginBottom: 8,
  },
  sectionSubtitle: {
    fontSize: 16,
    color: '#7F8C8D',
    textAlign: 'center',
    marginBottom: 32,
  },
  featuresGrid: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    justifyContent: 'space-between',
  },
  featureCard: {
    width: '48%',
    backgroundColor: '#FFFFFF',
    padding: 24,
    borderRadius: 12,
    marginBottom: 16,
    alignItems: 'center',
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.1,
    shadowRadius: 4,
    elevation: 2,
  },
  featureIcon: {
    fontSize: 32,
    marginBottom: 16,
  },
  featureTitle: {
    fontSize: 18,
    fontWeight: '600',
    color: '#2C3E50',
    marginBottom: 8,
    textAlign: 'center',
  },
  featureDescription: {
    fontSize: 14,
    color: '#7F8C8D',
    textAlign: 'center',
    lineHeight: 20,
  },
  statsContainer: {
    padding: 32,
    backgroundColor: '#2C3E50',
  },
  statsTitle: {
    fontSize: 24,
    fontWeight: 'bold',
    color: '#FFFFFF',
    textAlign: 'center',
    marginBottom: 32,
  },
  statsGrid: {
    flexDirection: 'row',
    justifyContent: 'space-around',
  },
  statItem: {
    alignItems: 'center',
  },
  statNumber: {
    fontSize: 32,
    fontWeight: 'bold',
    color: '#3498DB',
    marginBottom: 8,
  },
  statLabel: {
    fontSize: 14,
    color: '#BDC3C7',
    textAlign: 'center',
  },
  ctaContainer: {
    padding: 48,
    backgroundColor: '#FFFFFF',
    alignItems: 'center',
  },
  ctaTitle: {
    fontSize: 28,
    fontWeight: 'bold',
    color: '#2C3E50',
    textAlign: 'center',
    marginBottom: 16,
  },
  ctaDescription: {
    fontSize: 16,
    color: '#7F8C8D',
    textAlign: 'center',
    marginBottom: 32,
    maxWidth: 500,
    lineHeight: 24,
  },
  ctaButtons: {
    flexDirection: 'row',
    alignItems: 'center',
  },
  ctaPrimaryButton: {
    backgroundColor: '#2196F3',
    paddingVertical: 16,
    paddingHorizontal: 32,
    borderRadius: 8,
    marginRight: 16,
  },
  ctaPrimaryButtonText: {
    color: '#FFFFFF',
    fontSize: 18,
    fontWeight: '600',
  },
  ctaSecondaryButton: {
    backgroundColor: '#FFFFFF',
    borderWidth: 2,
    borderColor: '#2196F3',
    paddingVertical: 16,
    paddingHorizontal: 32,
    borderRadius: 8,
  },
  ctaSecondaryButtonText: {
    color: '#2196F3',
    fontSize: 18,
    fontWeight: '600',
  },
  footer: {
    backgroundColor: '#34495E',
    padding: 32,
    alignItems: 'center',
  },
  footerText: {
    color: '#BDC3C7',
    fontSize: 14,
    marginBottom: 16,
  },
  footerLinks: {
    flexDirection: 'row',
  },
  footerLink: {
    color: '#3498DB',
    fontSize: 14,
    marginHorizontal: 16,
  },
});

export default AutoPlayingBackgroundVideo;

import 'package:flutter/material.dart';

class AutoPlayingBackgroundVideo extends StatefulWidget {
  const AutoPlayingBackgroundVideo({Key? key}) : super(key: key);

  @override
  State<AutoPlayingBackgroundVideo> createState() => _AutoPlayingBackgroundVideoState();
}

class _AutoPlayingBackgroundVideoState extends State<AutoPlayingBackgroundVideo>
    with TickerProviderStateMixin {
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  int currentSlide = 0;
  bool isPlaying = true;

  final List<Map<String, dynamic>> heroSlides = [
    {
      'id': 1,
      'title': 'Revolutionary Technology',
      'subtitle': 'Experience the future today',
      'description': 'Discover cutting-edge solutions that transform how you work and live.',
      'videoUrl': 'https://sample-videos.com/zip/10/mp4/SampleVideo_1280x720_1mb.mp4',
      'imageUrl': 'https://via.placeholder.com/400x300',
      'ctaText': 'Learn More',
      'ctaAction': 'learn'
    },
    {
      'id': 2,
      'title': 'Innovation at Scale',
      'subtitle': 'Built for tomorrow',
      'description': 'Scalable solutions designed to grow with your business needs.',
      'videoUrl': 'https://sample-videos.com/zip/10/mp4/SampleVideo_1280x720_2mb.mp4',
      'imageUrl': 'https://via.placeholder.com/400x300',
      'ctaText': 'Get Started',
      'ctaAction': 'start'
    },
    {
      'id': 3,
      'title': 'Seamless Integration',
      'subtitle': 'Connect everything',
      'description': 'Integrate seamlessly with your existing systems and workflows.',
      'videoUrl': 'https://sample-videos.com/zip/10/mp4/SampleVideo_1280x720_5mb.mp4',
      'imageUrl': 'https://via.placeholder.com/400x300',
      'ctaText': 'Explore',
      'ctaAction': 'explore'
    }
  ];

  final List<Map<String, dynamic>> features = [
    {
      'icon': '🚀',
      'title': 'Fast Performance',
      'description': 'Lightning-fast processing and response times'
    },
    {
      'icon': '🔒',
      'title': 'Secure & Reliable',
      'description': 'Enterprise-grade security and 99.9% uptime'
    },
    {
      'icon': '📱',
      'title': 'Mobile Ready',
      'description': 'Optimized for all devices and screen sizes'
    },
    {
      'icon': '⚡',
      'title': 'Easy Integration',
      'description': 'Simple APIs and comprehensive documentation'
    }
  ];

  @override
  void initState() {
    super.initState();
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeInOut,
    ));

    _startAutoSlide();
  }

  void _startAutoSlide() {
    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) {
        setState(() {
          currentSlide = (currentSlide + 1) % heroSlides.length;
        });
        _slideController.forward().then((_) {
          _slideController.reset();
          _startAutoSlide();
        });
      }
    });
  }

  void _handlePlayPause() {
    setState(() {
      isPlaying = !isPlaying;
    });
  }

  void _handleSlidePress(int index) {
    setState(() {
      currentSlide = index;
    });
    _slideController.forward().then((_) {
      _slideController.reset();
    });
  }

  void _handleCTAAction(String action) {
    // Handle CTA action
  }

  @override
  void dispose() {
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Hero Section with Auto-playing Background Video
            _buildHeroSection(),
            
            // Features Section
            _buildFeaturesSection(),
            
            // Stats Section
            _buildStatsSection(),
            
            // CTA Section
            _buildCTASection(),
            
            // Footer
            _buildFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroSection() {
    final currentSlideData = heroSlides[currentSlide];
    
    return Container(
      height: 500,
      child: Stack(
        children: [
          // Background Video - AUTOPLAYS WITHOUT USER CONTROL
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage('https://via.placeholder.com/800x500'),
                fit: BoxFit.cover,
              ),
            ),
            child: isPlaying
                ? const Center(
                    child: Text(
                      '🎥 Video Playing',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                : const Center(
                    child: Text(
                      '⏸️ Video Paused',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
          ),
          
          // Video Overlay
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.4),
                  Colors.transparent,
                  Colors.black.withOpacity(0.7),
                ],
              ),
            ),
          ),
          
          // Hero Content
          AnimatedBuilder(
            animation: _fadeAnimation,
            builder: (context, child) {
              return Opacity(
                opacity: _fadeAnimation.value,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(32),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          currentSlideData['title'],
                          style: const TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            shadows: [
                              Shadow(
                                offset: Offset(0, 2),
                                blurRadius: 4,
                                color: Colors.black54,
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          currentSlideData['subtitle'],
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.white70,
                            shadows: [
                              Shadow(
                                offset: Offset(0, 1),
                                blurRadius: 2,
                                color: Colors.black54,
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          currentSlideData['description'],
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white70,
                            height: 1.5,
                            shadows: [
                              Shadow(
                                offset: Offset(0, 1),
                                blurRadius: 2,
                                color: Colors.black54,
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 32),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () => _handleCTAAction(currentSlideData['ctaAction']),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue[700],
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 32,
                                  vertical: 16,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: Text(
                                currentSlideData['ctaText'],
                                style: const TextStyle(fontSize: 18),
                              ),
                            ),
                            const SizedBox(width: 16),
                            OutlinedButton(
                              onPressed: _handlePlayPause,
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.white,
                                side: const BorderSide(color: Colors.white70),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                  vertical: 16,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: Text(
                                isPlaying ? '⏸️ Pause' : '▶️ Play',
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          
          // Slide Indicators
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(heroSlides.length, (index) {
                return GestureDetector(
                  onTap: () => _handleSlidePress(index),
                  child: Container(
                    width: 12,
                    height: 12,
                    margin: const EdgeInsets.symmetric(horizontal: 6),
                    decoration: BoxDecoration(
                      color: index == currentSlide
                          ? Colors.white
                          : Colors.white.withOpacity(0.4),
                      shape: BoxShape.circle,
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturesSection() {
    return Container(
      padding: const EdgeInsets.all(32),
      color: Colors.grey[50],
      child: Column(
        children: [
          const Text(
            'Why Choose Us',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'Powerful features designed to accelerate your success',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.2,
            ),
            itemCount: features.length,
            itemBuilder: (context, index) {
              final feature = features[index];
              return Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      feature['icon'],
                      style: const TextStyle(fontSize: 32),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      feature['title'],
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      feature['description'],
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildStatsSection() {
    return Container(
      padding: const EdgeInsets.all(32),
      color: Colors.blue[700],
      child: Column(
        children: [
          const Text(
            'Trusted by Thousands',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatItem('10K+', 'Active Users'),
              _buildStatItem('99.9%', 'Uptime'),
              _buildStatItem('24/7', 'Support'),
              _buildStatItem('50+', 'Countries'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String number, String label) {
    return Column(
      children: [
        Text(
          number,
          style: const TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.white70,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildCTASection() {
    return Container(
      padding: const EdgeInsets.all(48),
      color: Colors.white,
      child: Column(
        children: [
          const Text(
            'Ready to Get Started?',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            'Join thousands of satisfied customers and transform your business today.',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => _handleCTAAction('signup'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[700],
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Start Free Trial',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              const SizedBox(width: 16),
              OutlinedButton(
                onPressed: () => _handleCTAAction('contact'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.blue[700],
                  side: BorderSide(color: Colors.blue[700]!),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Contact Sales',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.all(32),
      color: Colors.grey[800],
      child: Column(
        children: [
          const Text(
            '© 2024 TechCorp. All rights reserved.',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {},
                child: const Text(
                  'Privacy Policy',
                  style: TextStyle(color: Colors.white70),
                ),
              ),
              const SizedBox(width: 16),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'Terms of Service',
                  style: TextStyle(color: Colors.white70),
                ),
              ),
              const SizedBox(width: 16),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'Support',
                  style: TextStyle(color: Colors.white70),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

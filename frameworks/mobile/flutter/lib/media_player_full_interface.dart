import 'package:flutter/material.dart';

class MediaPlayerFullInterface extends StatefulWidget {
  const MediaPlayerFullInterface({Key? key}) : super(key: key);

  @override
  State<MediaPlayerFullInterface> createState() => _MediaPlayerFullInterfaceState();
}

class _MediaPlayerFullInterfaceState extends State<MediaPlayerFullInterface>
    with TickerProviderStateMixin {
  bool isPlaying = false;
  double currentTime = 0;
  double duration = 180; // 3 minutes in seconds
  double volume = 0.7;
  double playbackRate = 1.0;
  bool isFullscreen = false;
  bool showControls = true;
  bool showCaptions = false;
  bool showQualityMenu = false;
  bool showPlaybackRateMenu = false;
  bool showCaptionsMenu = false;
  String selectedQuality = '1080p';
  String selectedCaption = 'English';
  bool isMuted = false;
  bool isBuffering = false;

  late AnimationController _controlsAnimationController;
  late Animation<double> _controlsAnimation;

  final List<String> qualities = ['240p', '360p', '480p', '720p', '1080p', '4K'];
  final List<double> playbackRates = [0.25, 0.5, 0.75, 1.0, 1.25, 1.5, 1.75, 2.0];
  final List<String> captions = ['English', 'Spanish', 'French', 'German', 'Off'];

  @override
  void initState() {
    super.initState();
    _controlsAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _controlsAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controlsAnimationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controlsAnimationController.dispose();
    super.dispose();
  }

  String _formatTime(double seconds) {
    final mins = (seconds / 60).floor();
    final secs = (seconds % 60).floor();
    return '${mins.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  void _handlePlayPause() {
    setState(() {
      isPlaying = !isPlaying;
      showControls = true;
    });
    _showControlsTemporarily();
  }

  void _showControlsTemporarily() {
    _controlsAnimationController.forward();
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        _controlsAnimationController.reverse();
      }
    });
  }

  void _handleSeek(double position) {
    setState(() {
      currentTime = (position * duration).clamp(0.0, duration);
    });
    _showControlsTemporarily();
  }

  void _handleVolumeChange(double newVolume) {
    setState(() {
      volume = newVolume;
      isMuted = newVolume == 0;
    });
  }

  void _handleMute() {
    setState(() {
      if (isMuted) {
        volume = 0.7;
        isMuted = false;
      } else {
        volume = 0;
        isMuted = true;
      }
    });
  }

  void _handleFullscreen() {
    setState(() {
      isFullscreen = !isFullscreen;
    });
  }

  void _handleSkip(double seconds) {
    setState(() {
      currentTime = (currentTime + seconds).clamp(0.0, duration);
    });
    _showControlsTemporarily();
  }

  void _handleQualityChange(String quality) {
    setState(() {
      selectedQuality = quality;
      showQualityMenu = false;
      isBuffering = true;
    });
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          isBuffering = false;
        });
      }
    });
  }

  void _handlePlaybackRateChange(double rate) {
    setState(() {
      playbackRate = rate;
      showPlaybackRateMenu = false;
    });
  }

  void _handleCaptionChange(String caption) {
    setState(() {
      selectedCaption = caption;
      showCaptions = caption != 'Off';
      showCaptionsMenu = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: isFullscreen
          ? _buildFullscreenPlayer()
          : _buildNormalPlayer(),
    );
  }

  Widget _buildNormalPlayer() {
    return Column(
      children: [
        _buildVideoArea(),
        _buildControls(),
      ],
    );
  }

  Widget _buildFullscreenPlayer() {
    return Stack(
      children: [
        _buildVideoArea(),
        _buildFullscreenControls(),
      ],
    );
  }

  Widget _buildVideoArea() {
    return GestureDetector(
      onTap: () {
        setState(() {
          showControls = !showControls;
        });
        if (showControls) {
          _showControlsTemporarily();
        }
      },
      child: Container(
        height: isFullscreen ? MediaQuery.of(context).size.height : 250,
        width: double.infinity,
        color: Colors.black,
        child: Stack(
          children: [
            _buildVideoPlaceholder(),
            if (isBuffering) _buildBufferingOverlay(),
            if (showCaptions && selectedCaption != 'Off') _buildCaptionsOverlay(),
            if (showControls) _buildControlsOverlay(),
          ],
        ),
      ),
    );
  }

  Widget _buildVideoPlaceholder() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.play_circle_outline,
            size: 80,
            color: Colors.white.withOpacity(0.8),
          ),
          const SizedBox(height: 16),
          const Text(
            'Sample Video',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Media Player Interface',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBufferingOverlay() {
    return Container(
      color: Colors.black.withOpacity(0.7),
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(color: Colors.white),
            SizedBox(height: 12),
            Text(
              'Buffering...',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCaptionsOverlay() {
    return Positioned(
      bottom: 100,
      left: 20,
      right: 20,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.8),
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Text(
          'This is a sample caption for the video content.',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildControlsOverlay() {
    return AnimatedBuilder(
      animation: _controlsAnimation,
      builder: (context, child) {
        return Opacity(
          opacity: _controlsAnimation.value,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.3),
                  Colors.transparent,
                  Colors.transparent,
                  Colors.black.withOpacity(0.3),
                ],
              ),
            ),
            child: Column(
              children: [
                _buildTopControls(),
                Expanded(child: _buildCenterControls()),
                _buildBottomControls(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTopControls() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Sample Video - $selectedQuality',
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
          Row(
            children: [
              IconButton(
                onPressed: () => _showSettingsDialog(),
                icon: const Icon(Icons.settings, color: Colors.white),
              ),
              IconButton(
                onPressed: () => _showShareDialog(),
                icon: const Icon(Icons.share, color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCenterControls() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () => _handleSkip(-10),
            icon: const Icon(Icons.replay_10, color: Colors.white, size: 32),
          ),
          const SizedBox(width: 40),
          IconButton(
            onPressed: _handlePlayPause,
            icon: Icon(
              isPlaying ? Icons.pause : Icons.play_arrow,
              color: Colors.white,
              size: 48,
            ),
          ),
          const SizedBox(width: 40),
          IconButton(
            onPressed: () => _handleSkip(10),
            icon: const Icon(Icons.forward_10, color: Colors.white, size: 32),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomControls() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          _buildProgressBar(),
          const SizedBox(height: 16),
          _buildSecondaryControls(),
        ],
      ),
    );
  }

  Widget _buildProgressBar() {
    return Row(
      children: [
        Text(
          _formatTime(currentTime),
          style: const TextStyle(color: Colors.white, fontSize: 14),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Slider(
            value: currentTime,
            min: 0,
            max: duration,
            onChanged: _handleSeek,
            activeColor: Colors.white,
            inactiveColor: Colors.white.withOpacity(0.3),
          ),
        ),
        const SizedBox(width: 12),
        Text(
          _formatTime(duration),
          style: const TextStyle(color: Colors.white, fontSize: 14),
        ),
      ],
    );
  }

  Widget _buildSecondaryControls() {
    return Row(
      children: [
        IconButton(
          onPressed: _handleMute,
          icon: Icon(
            isMuted ? Icons.volume_off : Icons.volume_up,
            color: Colors.white,
          ),
        ),
        Expanded(
          child: Slider(
            value: volume,
            min: 0,
            max: 1,
            onChanged: _handleVolumeChange,
            activeColor: Colors.white,
            inactiveColor: Colors.white.withOpacity(0.3),
          ),
        ),
        TextButton(
          onPressed: () => setState(() => showPlaybackRateMenu = true),
          child: Text(
            '${playbackRate}x',
            style: const TextStyle(color: Colors.white),
          ),
        ),
        IconButton(
          onPressed: () => setState(() => showCaptionsMenu = true),
          icon: const Icon(Icons.subtitles, color: Colors.white),
        ),
        TextButton(
          onPressed: () => setState(() => showQualityMenu = true),
          child: Text(
            selectedQuality,
            style: const TextStyle(color: Colors.white),
          ),
        ),
        IconButton(
          onPressed: _handleFullscreen,
          icon: Icon(
            isFullscreen ? Icons.fullscreen_exit : Icons.fullscreen,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildControls() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.grey[900],
      child: Column(
        children: [
          _buildProgressBar(),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () => _handleSkip(-10),
                icon: const Icon(Icons.replay_10, color: Colors.white),
              ),
              IconButton(
                onPressed: _handlePlayPause,
                icon: Icon(
                  isPlaying ? Icons.pause : Icons.play_arrow,
                  color: Colors.white,
                  size: 32,
                ),
              ),
              IconButton(
                onPressed: () => _handleSkip(10),
                icon: const Icon(Icons.forward_10, color: Colors.white),
              ),
              IconButton(
                onPressed: _handleMute,
                icon: Icon(
                  isMuted ? Icons.volume_off : Icons.volume_up,
                  color: Colors.white,
                ),
              ),
              IconButton(
                onPressed: _handleFullscreen,
                icon: const Icon(Icons.fullscreen, color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFullscreenControls() {
    return AnimatedBuilder(
      animation: _controlsAnimation,
      builder: (context, child) {
        return Opacity(
          opacity: _controlsAnimation.value,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.3),
                  Colors.transparent,
                  Colors.transparent,
                  Colors.black.withOpacity(0.3),
                ],
              ),
            ),
            child: Column(
              children: [
                _buildTopControls(),
                Expanded(child: _buildCenterControls()),
                _buildBottomControls(),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showSettingsDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Settings'),
        content: const Text('Settings menu would open here'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showShareDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Share Video'),
        content: const Text('Share video functionality would be here'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          _buildVideoArea(),
          if (showQualityMenu) _buildQualityMenu(),
          if (showPlaybackRateMenu) _buildPlaybackRateMenu(),
          if (showCaptionsMenu) _buildCaptionsMenu(),
        ],
      ),
    );
  }

  Widget _buildQualityMenu() {
    return Container(
      color: Colors.black.withOpacity(0.5),
      child: Center(
        child: Container(
          width: 200,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Video Quality',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              ...qualities.map((quality) => ListTile(
                title: Text(quality),
                trailing: selectedQuality == quality
                    ? const Icon(Icons.check, color: Colors.blue)
                    : null,
                onTap: () => _handleQualityChange(quality),
              )),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPlaybackRateMenu() {
    return Container(
      color: Colors.black.withOpacity(0.5),
      child: Center(
        child: Container(
          width: 200,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Playback Speed',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              ...playbackRates.map((rate) => ListTile(
                title: Text('${rate}x'),
                trailing: playbackRate == rate
                    ? const Icon(Icons.check, color: Colors.blue)
                    : null,
                onTap: () => _handlePlaybackRateChange(rate),
              )),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCaptionsMenu() {
    return Container(
      color: Colors.black.withOpacity(0.5),
      child: Center(
        child: Container(
          width: 200,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Captions',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              ...captions.map((caption) => ListTile(
                title: Text(caption),
                trailing: selectedCaption == caption
                    ? const Icon(Icons.check, color: Colors.blue)
                    : null,
                onTap: () => _handleCaptionChange(caption),
              )),
            ],
          ),
        ),
      ),
    );
  }
}

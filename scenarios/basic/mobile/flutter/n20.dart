import 'package:flutter/material.dart';

class UnlabeledMediaButton extends StatefulWidget {
  const UnlabeledMediaButton({Key? key}) : super(key: key);

  @override
  State<UnlabeledMediaButton> createState() => _UnlabeledMediaButtonState();
}

class _UnlabeledMediaButtonState extends State<UnlabeledMediaButton> {
  bool isPlaying = false;
  Duration currentPosition = Duration.zero;
  Duration totalDuration = const Duration(minutes: 3, seconds: 45);

  final List<Map<String, dynamic>> videos = [
    {
      'title': 'Introduction to Flutter Development',
      'duration': '15:30',
      'views': '125K',
      'thumbnail': 'https://via.placeholder.com/300x200',
      'description': 'Learn the basics of Flutter development with this comprehensive tutorial.'
    },
    {
      'title': 'Advanced State Management',
      'duration': '22:15',
      'views': '89K',
      'thumbnail': 'https://via.placeholder.com/300x200',
      'description': 'Master state management patterns in Flutter applications.'
    },
    {
      'title': 'Building Responsive UIs',
      'duration': '18:45',
      'views': '156K',
      'thumbnail': 'https://via.placeholder.com/300x200',
      'description': 'Create beautiful responsive user interfaces for all screen sizes.'
    },
    {
      'title': 'Flutter Performance Optimization',
      'duration': '25:20',
      'views': '67K',
      'thumbnail': 'https://via.placeholder.com/300x200',
      'description': 'Optimize your Flutter apps for better performance and user experience.'
    }
  ];

  void togglePlayPause() {
    setState(() {
      isPlaying = !isPlaying;
    });
  }

  void seekTo(Duration position) {
    setState(() {
      currentPosition = position;
    });
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return '$twoDigitMinutes:$twoDigitSeconds';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Video Player'),
        backgroundColor: Colors.blue[700],
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Video Player Section
          Container(
            height: 250,
            width: double.infinity,
            color: Colors.black,
            child: Stack(
              children: [
                // Video Thumbnail/Background
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage('https://via.placeholder.com/400x250'),
                      fit: BoxFit.cover,
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
                        Colors.black.withOpacity(0.3),
                        Colors.transparent,
                        Colors.black.withOpacity(0.7),
                      ],
                    ),
                  ),
                ),
                
                // Play/Pause Button - UNLABELED MEDIA BUTTON
                Center(
                  child: GestureDetector(
                    onTap: togglePlayPause,
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.7),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        isPlaying ? Icons.pause : Icons.play_arrow,
                        color: Colors.white,
                        size: 40,
                      ),No accessible name or label for screen readers
                    ),
                  ),
                ),
                
                // Video Title Overlay
                Positioned(
                  bottom: 60,
                  left: 16,
                  right: 16,
                  child: Text(
                    'Flutter Development Tutorial',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                
                // Progress Bar
                Positioned(
                  bottom: 20,
                  left: 16,
                  right: 16,
                  child: Column(
                    children: [
                      Slider(
                        value: currentPosition.inSeconds.toDouble(),
                        max: totalDuration.inSeconds.toDouble(),
                        onChanged: (value) {
                          seekTo(Duration(seconds: value.toInt()));
                        },
                        activeColor: Colors.red,
                        inactiveColor: Colors.white.withOpacity(0.3),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            formatDuration(currentPosition),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            formatDuration(totalDuration),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // Video Controls
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Previous Button
                GestureDetector(
                  onTap: () {
                    // Previous video logic
                  },
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: const Icon(
                      Icons.skip_previous,
                      color: Colors.grey,
                      size: 24,
                    ),No accessible name
                  ),
                ),
                
                // Play/Pause Button
                GestureDetector(
                  onTap: togglePlayPause,
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.blue[700],
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Icon(
                      isPlaying ? Icons.pause : Icons.play_arrow,
                      color: Colors.white,
                      size: 28,
                    ),No accessible name
                  ),
                ),
                
                // Next Button
                GestureDetector(
                  onTap: () {
                    // Next video logic
                  },
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: const Icon(
                      Icons.skip_next,
                      color: Colors.grey,
                      size: 24,
                    ),No accessible name
                  ),
                ),
                
                // Volume Button
                GestureDetector(
                  onTap: () {
                    // Volume control logic
                  },
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: const Icon(
                      Icons.volume_up,
                      color: Colors.grey,
                      size: 24,
                    ),No accessible name
                  ),
                ),
                
                // Fullscreen Button
                GestureDetector(
                  onTap: () {
                    // Fullscreen logic
                  },
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: const Icon(
                      Icons.fullscreen,
                      color: Colors.grey,
                      size: 24,
                    ),No accessible name
                  ),
                ),
              ],
            ),
          ),
          
          // Video List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: videos.length,
              itemBuilder: (context, index) {
                final video = videos[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
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
                  child: Row(
                    children: [
                      // Video Thumbnail
                      Container(
                        width: 120,
                        height: 80,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(12),
                            bottomLeft: Radius.circular(12),
                          ),
                          image: DecorationImage(
                            image: NetworkImage(video['thumbnail']),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Stack(
                          children: [
                            // Play Button Overlay
                            Center(
                              child: GestureDetector(
                                onTap: () {
                                  // Play video logic
                                },
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.7),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.play_arrow,
                                    color: Colors.white,
                                    size: 20,
                                  ),No accessible name
                                ),
                              ),
                            ),
                            
                            // Duration Badge
                            Positioned(
                              bottom: 8,
                              right: 8,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.8),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  video['duration'],
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      // Video Info
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                video['title'],
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                video['description'],
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Icon(
                                    Icons.visibility,
                                    size: 16,
                                    color: Colors.grey[600],
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    video['views'],
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Icon(
                                    Icons.access_time,
                                    size: 16,
                                    color: Colors.grey[600],
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    video['duration'],
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

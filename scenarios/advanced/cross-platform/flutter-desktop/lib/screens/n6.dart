import 'package:flutter/material.dart';

class MediaPlayerScreen extends StatefulWidget {
  const MediaPlayerScreen({super.key});

  @override
  State<MediaPlayerScreen> createState() => _MediaPlayerScreenState();
}

class _MediaPlayerScreenState extends State<MediaPlayerScreen> {
  bool _isPlaying = false;
  double _volume = 0.5;
  double _progress = 0.3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Media Player Full Interface'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Now Playing
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const Text(
                      'Now Playing',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      _isPlaying ? 'Playing: Sample Media' : 'No media selected',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 20),
                    
                    // Progress Bar
                    Slider(
                      value: _progress,
                      onChanged: (value) {
                        setState(() {
                          _progress = value;
                        });
                      },
                    ),
                    
                    // Controls
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          onPressed: _previousTrack,
                          icon: const Icon(Icons.skip_previous, size: 40),
                        ),
                        IconButton(
                          onPressed: _togglePlayPause,
                          icon: Icon(
                            _isPlaying ? Icons.pause : Icons.play_arrow,
                            size: 50,
                          ),
                        ),
                        IconButton(
                          onPressed: _stop,
                          icon: const Icon(Icons.stop, size: 40),
                        ),
                        IconButton(
                          onPressed: _nextTrack,
                          icon: const Icon(Icons.skip_next, size: 40),
                        ),
                      ],
                    ),
                    
                    // Volume Control
                    Row(
                      children: [
                        const Icon(Icons.volume_down),
                        Expanded(
                          child: Slider(
                            value: _volume,
                            onChanged: (value) {
                              setState(() {
                                _volume = value;
                              });
                            },
                          ),
                        ),
                        const Icon(Icons.volume_up),
                        Text('${(_volume * 100).round()}%'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Playlist
            Expanded(
              child: Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Playlist',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Expanded(
                        child: ListView.builder(
                          itemCount: 10,
                          itemBuilder: (context, index) {
                            return ListTile(
                              leading: const Icon(Icons.music_note),
                              title: Text('Track ${index + 1}'),
                              subtitle: Text('Artist ${index + 1}'),
                              trailing: IconButton(
                                onPressed: () => _playTrack(index),
                                icon: const Icon(Icons.play_arrow),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _togglePlayPause() {
    setState(() {
      _isPlaying = !_isPlaying;
    });
  }

  void _stop() {
    setState(() {
      _isPlaying = false;
      _progress = 0.0;
    });
  }

  void _previousTrack() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Previous track')),
    );
  }

  void _nextTrack() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Next track')),
    );
  }

  void _playTrack(int index) {
    setState(() {
      _isPlaying = true;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Playing track ${index + 1}')),
    );
  }
}

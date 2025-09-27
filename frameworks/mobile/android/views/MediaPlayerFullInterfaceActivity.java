package com.accessibilityapp;

import android.app.Activity;
import android.os.Bundle;
import android.view.View;
import android.widget.*;
import android.widget.SeekBar.OnSeekBarChangeListener;
import android.widget.CompoundButton.OnCheckedChangeListener;
import android.graphics.Color;
import android.media.MediaPlayer;
import android.os.Handler;
import java.util.*;

public class MediaPlayerFullInterfaceActivity extends Activity {
    
    private VideoView videoView;
    private LinearLayout controlsContainer;
    private Button playPauseButton;
    private SeekBar progressBar;
    private TextView currentTimeText;
    private TextView durationText;
    private SeekBar volumeBar;
    private TextView volumeText;
    private Spinner speedSpinner;
    private Button fullscreenButton;
    private Button captionsButton;
    private Spinner qualitySpinner;
    private Button playlistButton;
    private LinearLayout playlistContainer;
    private ListView playlistView;
    private TextView videoTitle;
    private TextView videoDescription;
    
    private boolean isPlaying = false;
    private boolean isFullscreen = false;
    private boolean showCaptions = false;
    private boolean showPlaylist = false;
    private int currentVolume = 50;
    private float currentSpeed = 1.0f;
    private String currentQuality = "1080p";
    private int currentTrack = 0;
    private Handler progressHandler = new Handler();
    
    private List<VideoTrack> playlist;
    
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_media_player_full_interface);
        
        initializeViews();
        setupData();
        setupListeners();
        updateDisplay();
    }
    
    private void initializeViews() {
        videoView = findViewById(R.id.videoView);
        controlsContainer = findViewById(R.id.controlsContainer);
        playPauseButton = findViewById(R.id.playPauseButton);
        progressBar = findViewById(R.id.progressBar);
        currentTimeText = findViewById(R.id.currentTimeText);
        durationText = findViewById(R.id.durationText);
        volumeBar = findViewById(R.id.volumeBar);
        volumeText = findViewById(R.id.volumeText);
        speedSpinner = findViewById(R.id.speedSpinner);
        fullscreenButton = findViewById(R.id.fullscreenButton);
        captionsButton = findViewById(R.id.captionsButton);
        qualitySpinner = findViewById(R.id.qualitySpinner);
        playlistButton = findViewById(R.id.playlistButton);
        playlistContainer = findViewById(R.id.playlistContainer);
        playlistView = findViewById(R.id.playlistView);
        videoTitle = findViewById(R.id.videoTitle);
        videoDescription = findViewById(R.id.videoDescription);
        
        setupSpinners();
    }
    
    private void setupSpinners() {
        // Speed Spinner
        String[] speeds = {"0.5x", "0.75x", "1.0x", "1.25x", "1.5x", "2.0x"};
        ArrayAdapter<String> speedAdapter = new ArrayAdapter<>(this, 
            android.R.layout.simple_spinner_item, speeds);
        speedAdapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
        speedSpinner.setAdapter(speedAdapter);
        speedSpinner.setSelection(2); // Default to 1.0x
        
        // Quality Spinner
        String[] qualities = {"360p", "720p", "1080p", "4K"};
        ArrayAdapter<String> qualityAdapter = new ArrayAdapter<>(this, 
            android.R.layout.simple_spinner_item, qualities);
        qualityAdapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
        qualitySpinner.setAdapter(qualityAdapter);
        qualitySpinner.setSelection(2); // Default to 1080p
    }
    
    private void setupData() {
        playlist = new ArrayList<>();
        playlist.add(new VideoTrack("Sample Video 1", "A sample video for testing", "https://example.com/video1.mp4", 180));
        playlist.add(new VideoTrack("Sample Video 2", "Another sample video", "https://example.com/video2.mp4", 240));
        playlist.add(new VideoTrack("Sample Video 3", "Third sample video", "https://example.com/video3.mp4", 300));
        
        // Setup playlist adapter
        PlaylistAdapter playlistAdapter = new PlaylistAdapter(this, playlist);
        playlistView.setAdapter(playlistAdapter);
        
        // Load first video
        loadVideo(0);
    }
    
    private void setupListeners() {
        playPauseButton.setOnClickListener(v -> togglePlayPause());
        
        progressBar.setOnSeekBarChangeListener(new OnSeekBarChangeListener() {
            @Override
            public void onProgressChanged(SeekBar seekBar, int progress, boolean fromUser) {
                if (fromUser) {
                    // Seek to position
                    updateTimeDisplay(progress);
                }
            }
            
            @Override
            public void onStartTrackingTouch(SeekBar seekBar) {}
            
            @Override
            public void onStopTrackingTouch(SeekBar seekBar) {
                // Seek to new position
                seekToPosition(seekBar.getProgress());
            }
        });
        
        volumeBar.setOnSeekBarChangeListener(new OnSeekBarChangeListener() {
            @Override
            public void onProgressChanged(SeekBar seekBar, int progress, boolean fromUser) {
                if (fromUser) {
                    currentVolume = progress;
                    updateVolumeDisplay();
                }
            }
            
            @Override
            public void onStartTrackingTouch(SeekBar seekBar) {}
            
            @Override
            public void onStopTrackingTouch(SeekBar seekBar) {}
        });
        
        speedSpinner.setOnItemSelectedListener(new AdapterView.OnItemSelectedListener() {
            @Override
            public void onItemSelected(AdapterView<?> parent, View view, int position, long id) {
                String[] speedValues = {"0.5", "0.75", "1.0", "1.25", "1.5", "2.0"};
                currentSpeed = Float.parseFloat(speedValues[position]);
                updateSpeed();
            }
            
            @Override
            public void onNothingSelected(AdapterView<?> parent) {}
        });
        
        qualitySpinner.setOnItemSelectedListener(new AdapterView.OnItemSelectedListener() {
            @Override
            public void onItemSelected(AdapterView<?> parent, View view, int position, long id) {
                String[] qualityValues = {"360p", "720p", "1080p", "4K"};
                currentQuality = qualityValues[position];
                changeQuality();
            }
            
            @Override
            public void onNothingSelected(AdapterView<?> parent) {}
        });
        
        fullscreenButton.setOnClickListener(v -> toggleFullscreen());
        captionsButton.setOnClickListener(v -> toggleCaptions());
        playlistButton.setOnClickListener(v -> togglePlaylist());
        
        playlistView.setOnItemClickListener((parent, view, position, id) -> {
            loadVideo(position);
            togglePlaylist();
        });
    }
    
    private void loadVideo(int index) {
        if (index >= 0 && index < playlist.size()) {
            currentTrack = index;
            VideoTrack track = playlist.get(currentTrack);
            videoTitle.setText(track.getTitle());
            videoDescription.setText(track.getDescription());
            
            // Simulate video loading
            progressBar.setMax(track.getDuration());
            durationText.setText(formatTime(track.getDuration()));
            currentTimeText.setText("00:00");
            progressBar.setProgress(0);
            
            // Reset play state
            isPlaying = false;
            updatePlayPauseButton();
        }
    }
    
    private void togglePlayPause() {
        isPlaying = !isPlaying;
        updatePlayPauseButton();
        
        if (isPlaying) {
            startProgressUpdate();
        } else {
            stopProgressUpdate();
        }
    }
    
    private void updatePlayPauseButton() {
        playPauseButton.setText(isPlaying ? "Pause" : "Play");
    }
    
    private void startProgressUpdate() {
        progressHandler.postDelayed(progressRunnable, 1000);
    }
    
    private void stopProgressUpdate() {
        progressHandler.removeCallbacks(progressRunnable);
    }
    
    private Runnable progressRunnable = new Runnable() {
        @Override
        public void run() {
            if (isPlaying) {
                int currentProgress = progressBar.getProgress();
                int maxProgress = progressBar.getMax();
                
                if (currentProgress < maxProgress) {
                    progressBar.setProgress(currentProgress + 1);
                    updateTimeDisplay(currentProgress + 1);
                    progressHandler.postDelayed(this, 1000);
                } else {
                    // Video ended
                    isPlaying = false;
                    updatePlayPauseButton();
                }
            }
        }
    };
    
    private void seekToPosition(int position) {
        progressBar.setProgress(position);
        updateTimeDisplay(position);
    }
    
    private void updateTimeDisplay(int seconds) {
        currentTimeText.setText(formatTime(seconds));
    }
    
    private void updateVolumeDisplay() {
        volumeText.setText(currentVolume + "%");
    }
    
    private void updateSpeed() {
        // Simulate speed change
        Toast.makeText(this, "Speed changed to " + currentSpeed + "x", Toast.LENGTH_SHORT).show();
    }
    
    private void changeQuality() {
        // Simulate quality change
        Toast.makeText(this, "Quality changed to " + currentQuality, Toast.LENGTH_SHORT).show();
    }
    
    private void toggleFullscreen() {
        isFullscreen = !isFullscreen;
        fullscreenButton.setText(isFullscreen ? "Exit Fullscreen" : "Fullscreen");
        
        if (isFullscreen) {
            // Hide other UI elements
            playlistContainer.setVisibility(View.GONE);
        } else {
            // Show other UI elements
            if (showPlaylist) {
                playlistContainer.setVisibility(View.VISIBLE);
            }
        }
    }
    
    private void toggleCaptions() {
        showCaptions = !showCaptions;
        captionsButton.setText(showCaptions ? "Hide Captions" : "Show Captions");
        captionsButton.setBackgroundColor(showCaptions ? Color.BLUE : Color.GRAY);
    }
    
    private void togglePlaylist() {
        showPlaylist = !showPlaylist;
        playlistContainer.setVisibility(showPlaylist ? View.VISIBLE : View.GONE);
        playlistButton.setText(showPlaylist ? "Hide Playlist" : "Show Playlist");
    }
    
    private void updateDisplay() {
        updatePlayPauseButton();
        updateVolumeDisplay();
        updateTimeDisplay(0);
    }
    
    private String formatTime(int seconds) {
        int minutes = seconds / 60;
        int remainingSeconds = seconds % 60;
        return String.format("%02d:%02d", minutes, remainingSeconds);
    }
    
    @Override
    protected void onDestroy() {
        super.onDestroy();
        stopProgressUpdate();
    }
    
    // Video Track class
    public static class VideoTrack {
        private String title;
        private String description;
        private String url;
        private int duration;
        
        public VideoTrack(String title, String description, String url, int duration) {
            this.title = title;
            this.description = description;
            this.url = url;
            this.duration = duration;
        }
        
        public String getTitle() { return title; }
        public String getDescription() { return description; }
        public String getUrl() { return url; }
        public int getDuration() { return duration; }
    }
    
    // Playlist Adapter
    private class PlaylistAdapter extends BaseAdapter {
        private Activity context;
        private List<VideoTrack> tracks;
        
        public PlaylistAdapter(Activity context, List<VideoTrack> tracks) {
            this.context = context;
            this.tracks = tracks;
        }
        
        @Override
        public int getCount() {
            return tracks.size();
        }
        
        @Override
        public Object getItem(int position) {
            return tracks.get(position);
        }
        
        @Override
        public long getItemId(int position) {
            return position;
        }
        
        @Override
        public View getView(int position, View convertView, ViewGroup parent) {
            if (convertView == null) {
                convertView = getLayoutInflater().inflate(R.layout.item_playlist_track, parent, false);
            }
            
            VideoTrack track = tracks.get(position);
            
            TextView titleText = convertView.findViewById(R.id.trackTitle);
            TextView durationText = convertView.findViewById(R.id.trackDuration);
            
            titleText.setText(track.getTitle());
            durationText.setText(formatTime(track.getDuration()));
            
            return convertView;
        }
    }
}

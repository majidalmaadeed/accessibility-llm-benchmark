package com.accessibility.benchmark.compose

import androidx.compose.foundation.background
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material.*
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp

data class MediaItem(
    val id: String,
    val title: String,
    val artist: String,
    val duration: String,
    val thumbnail: String? = null
)

@Composable
fun MediaPlayerFullInterface() {
    var isPlaying by remember { mutableStateOf(false) }
    var currentPosition by remember { mutableStateOf(0f) }
    var duration by remember { mutableStateOf(180f) }
    var volume by remember { mutableStateOf(0.7f) }
    var playbackSpeed by remember { mutableStateOf(1.0f) }
    var isFullscreen by remember { mutableStateOf(false) }
    var showCaptions by remember { mutableStateOf(false) }
    var showQualityMenu by remember { mutableStateOf(false) }
    var showPlaylist by remember { mutableStateOf(false) }
    var currentTrack by remember { mutableStateOf(0) }
    var isShuffled by remember { mutableStateOf(false) }
    var repeatMode by remember { mutableStateOf(RepeatMode.OFF) }
    
    val samplePlaylist = remember {
        listOf(
            MediaItem("1", "Song Title 1", "Artist 1", "3:45"),
            MediaItem("2", "Song Title 2", "Artist 2", "4:12"),
            MediaItem("3", "Song Title 3", "Artist 3", "3:28"),
            MediaItem("4", "Song Title 4", "Artist 4", "4:33"),
            MediaItem("5", "Song Title 5", "Artist 5", "3:15")
        )
    }
    
    val qualityOptions = listOf("Auto", "1080p", "720p", "480p", "360p")
    val speedOptions = listOf(0.5f, 0.75f, 1.0f, 1.25f, 1.5f, 2.0f)
    
    Column(
        modifier = Modifier
            .fillMaxSize()
            .background(Color.Black)
    ) {
        // Video/Media Display Area
        Box(
            modifier = Modifier
                .fillMaxWidth()
                .weight(1f)
                .background(Color.DarkGray),
            contentAlignment = Alignment.Center
        ) {
            // Video placeholder
            Text(
                text = "Video Content",
                color = Color.White,
                fontSize = 24.sp
            )
            
            // Caption overlay
            if (showCaptions) {
                Box(
                    modifier = Modifier
                        .align(Alignment.BottomCenter)
                        .padding(16.dp)
                        .background(
                            Color.Black.copy(alpha = 0.7f),
                            shape = RoundedCornerShape(4.dp)
                        )
                ) {
                    Text(
                        text = "This is a sample caption text",
                        color = Color.White,
                        modifier = Modifier.padding(8.dp)
                    )
                }
            }
        }
        
        // Control Panel
        Card(
            modifier = Modifier.fillMaxWidth(),
            backgroundColor = Color.Black.copy(alpha = 0.9f),
            shape = RoundedCornerShape(topStart = 16.dp, topEnd = 16.dp)
        ) {
            Column(
                modifier = Modifier.padding(16.dp)
            ) {
                // Track Info
                Row(
                    modifier = Modifier.fillMaxWidth(),
                    verticalAlignment = Alignment.CenterVertically
                ) {
                    // Thumbnail placeholder
                    Box(
                        modifier = Modifier
                            .size(60.dp)
                            .background(Color.Gray, shape = RoundedCornerShape(8.dp)),
                        contentAlignment = Alignment.Center
                    ) {
                        Icon(
                            Icons.Default.MusicNote,
                            contentDescription = null,
                            tint = Color.White
                        )
                    }
                    
                    Spacer(modifier = Modifier.width(12.dp))
                    
                    Column(modifier = Modifier.weight(1f)) {
                        Text(
                            text = samplePlaylist[currentTrack].title,
                            color = Color.White,
                            fontSize = 16.sp,
                            fontWeight = FontWeight.Bold
                        )
                        Text(
                            text = samplePlaylist[currentTrack].artist,
                            color = Color.White.copy(alpha = 0.7f),
                            fontSize = 14.sp
                        )
                    }
                    
                    IconButton(onClick = { showPlaylist = !showPlaylist }) {
                        Icon(
                            Icons.Default.PlaylistPlay,
                            contentDescription = null,
                            tint = Color.White
                        )
                    }
                }
                
                Spacer(modifier = Modifier.height(16.dp))
                
                // Progress Bar
                Column {
                    Slider(
                        value = currentPosition,
                        onValueChange = { currentPosition = it },
                        valueRange = 0f..duration,
                        colors = SliderDefaults.colors(
                            thumbColor = Color.White,
                            activeTrackColor = Color.Red,
                            inactiveTrackColor = Color.Gray
                        )
                    )
                    
                    Row(
                        modifier = Modifier.fillMaxWidth(),
                        horizontalArrangement = Arrangement.SpaceBetween
                    ) {
                        Text(
                            text = formatTime(currentPosition),
                            color = Color.White,
                            fontSize = 12.sp
                        )
                        Text(
                            text = formatTime(duration),
                            color = Color.White,
                            fontSize = 12.sp
                        )
                    }
                }
                
                Spacer(modifier = Modifier.height(16.dp))
                
                // Main Controls
                Row(
                    modifier = Modifier.fillMaxWidth(),
                    horizontalArrangement = Arrangement.SpaceEvenly,
                    verticalAlignment = Alignment.CenterVertically
                ) {
                    IconButton(onClick = { isShuffled = !isShuffled }) {
                        Icon(
                            Icons.Default.Shuffle,
                            contentDescription = null,
                            tint = if (isShuffled) Color.Red else Color.White
                        )
                    }
                    
                    IconButton(onClick = { 
                        currentTrack = if (currentTrack > 0) currentTrack - 1 else samplePlaylist.size - 1
                    }) {
                        Icon(
                            Icons.Default.SkipPrevious,
                            contentDescription = null,
                            tint = Color.White,
                            modifier = Modifier.size(32.dp)
                        )
                    }
                    
                    IconButton(
                        onClick = { isPlaying = !isPlaying },
                        modifier = Modifier
                            .size(64.dp)
                            .background(Color.Red, shape = CircleShape)
                    ) {
                        Icon(
                            if (isPlaying) Icons.Default.Pause else Icons.Default.PlayArrow,
                            contentDescription = null,
                            tint = Color.White,
                            modifier = Modifier.size(32.dp)
                        )
                    }
                    
                    IconButton(onClick = { 
                        currentTrack = if (currentTrack < samplePlaylist.size - 1) currentTrack + 1 else 0
                    }) {
                        Icon(
                            Icons.Default.SkipNext,
                            contentDescription = null,
                            tint = Color.White,
                            modifier = Modifier.size(32.dp)
                        )
                    }
                    
                    IconButton(onClick = { 
                        repeatMode = when (repeatMode) {
                            RepeatMode.OFF -> RepeatMode.ALL
                            RepeatMode.ALL -> RepeatMode.ONE
                            RepeatMode.ONE -> RepeatMode.OFF
                        }
                    }) {
                        Icon(
                            when (repeatMode) {
                                RepeatMode.OFF -> Icons.Default.Repeat
                                RepeatMode.ALL -> Icons.Default.Repeat
                                RepeatMode.ONE -> Icons.Default.RepeatOne
                            },
                            contentDescription = null,
                            tint = if (repeatMode != RepeatMode.OFF) Color.Red else Color.White
                        )
                    }
                }
                
                Spacer(modifier = Modifier.height(16.dp))
                
                // Secondary Controls
                Row(
                    modifier = Modifier.fillMaxWidth(),
                    horizontalArrangement = Arrangement.SpaceBetween,
                    verticalAlignment = Alignment.CenterVertically
                ) {
                    // Volume Control
                    Row(
                        verticalAlignment = Alignment.CenterVertically
                    ) {
                        Icon(
                            Icons.Default.VolumeUp,
                            contentDescription = null,
                            tint = Color.White
                        )
                        Slider(
                            value = volume,
                            onValueChange = { volume = it },
                            valueRange = 0f..1f,
                            modifier = Modifier.width(100.dp),
                            colors = SliderDefaults.colors(
                                thumbColor = Color.White,
                                activeTrackColor = Color.White,
                                inactiveTrackColor = Color.Gray
                            )
                        )
                    }
                    
                    // Speed Control
                    Row(
                        verticalAlignment = Alignment.CenterVertically
                    ) {
                        Text(
                            text = "${playbackSpeed}x",
                            color = Color.White,
                            fontSize = 14.sp
                        )
                        IconButton(onClick = { 
                            val currentIndex = speedOptions.indexOf(playbackSpeed)
                            val nextIndex = (currentIndex + 1) % speedOptions.size
                            playbackSpeed = speedOptions[nextIndex]
                        }) {
                            Icon(
                                Icons.Default.Speed,
                                contentDescription = null,
                                tint = Color.White
                            )
                        }
                    }
                    
                    // Additional Controls
                    Row {
                        IconButton(onClick = { showCaptions = !showCaptions }) {
                            Icon(
                                Icons.Default.ClosedCaption,
                                contentDescription = null,
                                tint = if (showCaptions) Color.Red else Color.White
                            )
                        }
                        
                        IconButton(onClick = { showQualityMenu = !showQualityMenu }) {
                            Icon(
                                Icons.Default.HighQuality,
                                contentDescription = null,
                                tint = Color.White
                            )
                        }
                        
                        IconButton(onClick = { isFullscreen = !isFullscreen }) {
                            Icon(
                                if (isFullscreen) Icons.Default.FullscreenExit else Icons.Default.Fullscreen,
                                contentDescription = null,
                                tint = Color.White
                            )
                        }
                    }
                }
            }
        }
    }
    
    // Quality Menu
    if (showQualityMenu) {
        Box(
            modifier = Modifier.fillMaxSize(),
            contentAlignment = Alignment.Center
        ) {
            Card(
                modifier = Modifier.padding(32.dp),
                backgroundColor = Color.Black.copy(alpha = 0.9f)
            ) {
                Column(
                    modifier = Modifier.padding(16.dp)
                ) {
                    Text(
                        text = "Video Quality",
                        color = Color.White,
                        fontSize = 18.sp,
                        fontWeight = FontWeight.Bold,
                        modifier = Modifier.padding(bottom = 16.dp)
                    )
                    
                    qualityOptions.forEach { quality ->
                        Row(
                            modifier = Modifier
                                .fillMaxWidth()
                                .clickable { showQualityMenu = false },
                            verticalAlignment = Alignment.CenterVertically
                        ) {
                            RadioButton(
                                selected = quality == "1080p",
                                onClick = { showQualityMenu = false },
                                colors = RadioButtonDefaults.colors(
                                    selectedColor = Color.Red
                                )
                            )
                            Text(
                                text = quality,
                                color = Color.White,
                                modifier = Modifier.padding(start = 8.dp)
                            )
                        }
                    }
                }
            }
        }
    }
    
    // Playlist
    if (showPlaylist) {
        Box(
            modifier = Modifier.fillMaxSize(),
            contentAlignment = Alignment.Center
        ) {
            Card(
                modifier = Modifier
                    .fillMaxWidth()
                    .height(400.dp)
                    .padding(32.dp),
                backgroundColor = Color.Black.copy(alpha = 0.9f)
            ) {
                Column(
                    modifier = Modifier.padding(16.dp)
                ) {
                    Row(
                        modifier = Modifier.fillMaxWidth(),
                        horizontalArrangement = Arrangement.SpaceBetween,
                        verticalAlignment = Alignment.CenterVertically
                    ) {
                        Text(
                            text = "Playlist",
                            color = Color.White,
                            fontSize = 18.sp,
                            fontWeight = FontWeight.Bold
                        )
                        IconButton(onClick = { showPlaylist = false }) {
                            Icon(
                                Icons.Default.Close,
                                contentDescription = null,
                                tint = Color.White
                            )
                        }
                    }
                    
                    Spacer(modifier = Modifier.height(16.dp))
                    
                    samplePlaylist.forEachIndexed { index, item ->
                        Row(
                            modifier = Modifier
                                .fillMaxWidth()
                                .clickable { 
                                    currentTrack = index
                                    showPlaylist = false
                                }
                                .padding(vertical = 8.dp),
                            verticalAlignment = Alignment.CenterVertically
                        ) {
                            if (index == currentTrack) {
                                Icon(
                                    Icons.Default.PlayArrow,
                                    contentDescription = null,
                                    tint = Color.Red
                                )
                            } else {
                                Spacer(modifier = Modifier.width(24.dp))
                            }
                            
                            Column(modifier = Modifier.weight(1f)) {
                                Text(
                                    text = item.title,
                                    color = Color.White,
                                    fontSize = 14.sp,
                                    fontWeight = if (index == currentTrack) FontWeight.Bold else FontWeight.Normal
                                )
                                Text(
                                    text = item.artist,
                                    color = Color.White.copy(alpha = 0.7f),
                                    fontSize = 12.sp
                                )
                            }
                            
                            Text(
                                text = item.duration,
                                color = Color.White.copy(alpha = 0.7f),
                                fontSize = 12.sp
                            )
                        }
                    }
                }
            }
        }
    }
}

enum class RepeatMode {
    OFF, ALL, ONE
}

fun formatTime(seconds: Float): String {
    val minutes = (seconds / 60).toInt()
    val remainingSeconds = (seconds % 60).toInt()
    return String.format("%d:%02d", minutes, remainingSeconds)
}

package com.example.accessibilityscenarios

import androidx.compose.foundation.background
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.*
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp

@Composable
fun SmallTouchTargetScreen() {
    val posts = listOf(
        SocialPost(
            id = 1,
            username = "john_doe",
            content = "Just finished an amazing hike! The views were incredible.",
            timestamp = "2 hours ago",
            likes = 24,
            comments = 8,
            shares = 3
        ),
        SocialPost(
            id = 2,
            username = "sarah_wilson",
            content = "Working on a new project. Can't wait to share it with everyone!",
            timestamp = "4 hours ago",
            likes = 156,
            comments = 23,
            shares = 12
        ),
        SocialPost(
            id = 3,
            username = "mike_chen",
            content = "Coffee break time! ☕",
            timestamp = "6 hours ago",
            likes = 89,
            comments = 15,
            shares = 5
        ),
        SocialPost(
            id = 4,
            username = "emma_taylor",
            content = "Beautiful sunset from my balcony tonight.",
            timestamp = "8 hours ago",
            likes = 203,
            comments = 31,
            shares = 18
        )
    )
    
    Column(
        modifier = Modifier
            .fillMaxSize()
            .background(Color(0xFFF5F5F5))
    ) {
        // Header
        Card(
            modifier = Modifier
                .fillMaxWidth()
                .padding(16.dp),
            colors = CardDefaults.cardColors(containerColor = Color(0xFF1976D2))
        ) {
            Row(
                modifier = Modifier
                    .fillMaxWidth()
                    .padding(16.dp),
                verticalAlignment = Alignment.CenterVertically
            ) {
                Text(
                    text = "Social Feed",
                    fontSize = 24.sp,
                    fontWeight = FontWeight.Bold,
                    color = Color.White,
                    modifier = Modifier.weight(1f)
                )
                
                IconButton(
                    onClick = { }
                ) {
                    Icon(
                        imageVector = Icons.Default.Notifications,
                        contentDescription = "Notifications",
                        tint = Color.White
                    )
                }
            }
        }
        
        // Posts
        LazyColumn(
            modifier = Modifier
                .fillMaxSize()
                .padding(horizontal = 16.dp),
            verticalArrangement = Arrangement.spacedBy(12.dp)
        ) {
            items(posts) { post ->
                PostCard(post = post)
            }
        }
    }
}

@Composable
fun PostCard(post: SocialPost) {
    Card(
        modifier = Modifier
            .fillMaxWidth()
            .clip(RoundedCornerShape(12.dp)),
        colors = CardDefaults.cardColors(containerColor = Color.White),
        elevation = CardDefaults.cardElevation(defaultElevation = 2.dp)
    ) {
        Column(
            modifier = Modifier.padding(16.dp)
        ) {
            // User Info
            Row(
                modifier = Modifier
                    .fillMaxWidth()
                    .padding(bottom = 12.dp),
                verticalAlignment = Alignment.CenterVertically
            ) {
                // Profile Picture
                Box(
                    modifier = Modifier
                        .size(40.dp)
                        .background(Color(0xFFE0E0E0), RoundedCornerShape(20.dp)),
                    contentAlignment = Alignment.Center
                ) {
                    Icon(
                        imageVector = Icons.Default.Person,
                        contentDescription = null,
                        tint = Color.Gray
                    )
                }
                
                Spacer(modifier = Modifier.width(12.dp))
                
                Column(
                    modifier = Modifier.weight(1f)
                ) {
                    Text(
                        text = post.username,
                        fontSize = 16.sp,
                        fontWeight = FontWeight.Medium
                    )
                    Text(
                        text = post.timestamp,
                        fontSize = 14.sp,
                        color = Color.Gray
                    )
                }
                
                // More options button - SMALL TOUCH TARGET
                IconButton(
                    onClick = { },
                    modifier = Modifier.size(20.dp) // TOO SMALL: Only 20dp touch target
                ) {
                    Icon(
                        imageVector = Icons.Default.MoreVert,
                        contentDescription = "More options",
                        modifier = Modifier.size(16.dp)
                    )
                }
            }
            
            // Post Content
            Text(
                text = post.content,
                fontSize = 16.sp,
                lineHeight = 24.sp,
                modifier = Modifier.padding(bottom = 16.dp)
            )
            
            // Action Buttons
            Row(
                modifier = Modifier.fillMaxWidth(),
                horizontalArrangement = Arrangement.SpaceBetween
            ) {
                // Like Button - SMALL TOUCH TARGET
                Row(
                    verticalAlignment = Alignment.CenterVertically
                ) {
                    IconButton(
                        onClick = { },
                        modifier = Modifier.size(24.dp) // TOO SMALL: Only 24dp touch target
                    ) {
                        Icon(
                            imageVector = Icons.Default.ThumbUp,
                            contentDescription = "Like",
                            modifier = Modifier.size(18.dp),
                            tint = Color(0xFF1976D2)
                        )
                    }
                    Text(
                        text = "${post.likes}",
                        fontSize = 14.sp,
                        color = Color.Gray
                    )
                }
                
                // Comment Button - SMALL TOUCH TARGET
                Row(
                    verticalAlignment = Alignment.CenterVertically
                ) {
                    IconButton(
                        onClick = { },
                        modifier = Modifier.size(24.dp) // TOO SMALL: Only 24dp touch target
                    ) {
                        Icon(
                            imageVector = Icons.Default.Comment,
                            contentDescription = "Comment",
                            modifier = Modifier.size(18.dp),
                            tint = Color.Gray
                        )
                    }
                    Text(
                        text = "${post.comments}",
                        fontSize = 14.sp,
                        color = Color.Gray
                    )
                }
                
                // Share Button - SMALL TOUCH TARGET
                Row(
                    verticalAlignment = Alignment.CenterVertically
                ) {
                    IconButton(
                        onClick = { },
                        modifier = Modifier.size(24.dp) // TOO SMALL: Only 24dp touch target
                    ) {
                        Icon(
                            imageVector = Icons.Default.Share,
                            contentDescription = "Share",
                            modifier = Modifier.size(18.dp),
                            tint = Color.Gray
                        )
                    }
                    Text(
                        text = "${post.shares}",
                        fontSize = 14.sp,
                        color = Color.Gray
                    )
                }
            }
        }
    }
}

data class SocialPost(
    val id: Int,
    val username: String,
    val content: String,
    val timestamp: String,
    val likes: Int,
    val comments: Int,
    val shares: Int
)

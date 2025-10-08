package com.example.UIComponents

import androidx.compose.foundation.background
import androidx.compose.foundation.border
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.LazyRow
import androidx.compose.foundation.lazy.items
import androidx.compose.foundation.shape.CircleShape
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

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun SocialMediaFeed() {
    var posts by remember { mutableStateOf(generateSamplePosts()) }
    var currentFilter by remember { mutableStateOf(FilterType.ALL) }
    var unreadNotifications by remember { mutableStateOf(3) }
    var isLoading by remember { mutableStateOf(false) }
    var showCreatePost by remember { mutableStateOf(false) }
    var showPostDetails by remember { mutableStateOf(false) }
    var selectedPost by remember { mutableStateOf<Post?>(null) }
    var newPost by remember { mutableStateOf(NewPost()) }

    Scaffold(
        topBar = {
            TopAppBar(
                title = { Text("Social Feed") },
                actions = {
                    Box {
                        IconButton(onClick = { /* Handle notifications */ }) {
                            Icon(Icons.Default.Notifications, contentDescription = null)
                        }
                        if (unreadNotifications > 0) {
                            Box(
                                modifier = Modifier
                                    .size(16.dp)
                                    .background(MaterialTheme.colorScheme.error, CircleShape)
                                    .align(Alignment.TopEnd)
                            ) {
                                Text(
                                    text = "$unreadNotifications",
                                    color = MaterialTheme.colorScheme.onError,
                                    style = MaterialTheme.typography.labelSmall,
                                    modifier = Modifier.align(Alignment.Center)
                                )
                            }
                        }
                    }
                    IconButton(onClick = { /* Handle trending */ }) {
                        Icon(Icons.Default.TrendingUp, contentDescription = null)
                    }
                }
            )
        },
        floatingActionButton = {
            FloatingActionButton(
                onClick = { showCreatePost = true },
                modifier = Modifier.padding(16.dp)
            ) {
                Icon(Icons.Default.Add, contentDescription = null)
            }
        }
    ) { paddingValues ->
        Column(
            modifier = Modifier
                .fillMaxSize()
                .padding(paddingValues)
        ) {
            // Filter Tabs
            FilterTabs(
                currentFilter = currentFilter,
                onFilterChange = { currentFilter = it }
            )

            // Posts List
            if (isLoading) {
                Box(
                    modifier = Modifier.fillMaxSize(),
                    contentAlignment = Alignment.Center
                ) {
                    Column(horizontalAlignment = Alignment.CenterHorizontally) {
                        CircularProgressIndicator()
                        Spacer(modifier = Modifier.height(16.dp))
                        Text("Loading posts...")
                    }
                }
            } else if (posts.isEmpty()) {
                EmptyStateView(
                    onCreatePost = { showCreatePost = true }
                )
            } else {
                PostsList(
                    posts = posts,
                    onPostClick = { post ->
                        selectedPost = post
                        showPostDetails = true
                    },
                    onLike = { postId ->
                        posts = posts.map { post ->
                            if (post.id == postId) {
                                post.copy(
                                    isLiked = !post.isLiked,
                                    likes = if (post.isLiked) post.likes - 1 else post.likes + 1
                                )
                            } else post
                        }
                    },
                    onComment = { post ->
                        selectedPost = post
                        showPostDetails = true
                    },
                    onShare = { post ->
                        // Handle share
                    },
                    onBookmark = { postId ->
                        posts = posts.map { post ->
                            if (post.id == postId) {
                                post.copy(isBookmarked = !post.isBookmarked)
                            } else post
                        }
                    }
                )
            }
        }
    }

    // Create Post Dialog
    if (showCreatePost) {
        CreatePostDialog(
            newPost = newPost,
            onDismiss = { showCreatePost = false },
            onSave = { post ->
                posts = listOf(post) + posts
                showCreatePost = false
            }
        )
    }

    // Post Details Dialog
    if (showPostDetails && selectedPost != null) {
        PostDetailsDialog(
            post = selectedPost!!,
            onDismiss = { showPostDetails = false }
        )
    }
}

@Composable
fun FilterTabs(
    currentFilter: FilterType,
    onFilterChange: (FilterType) -> Unit
) {
    LazyRow(
        modifier = Modifier
            .fillMaxWidth()
            .padding(16.dp),
        horizontalArrangement = Arrangement.spacedBy(8.dp)
    ) {
        items(FilterType.values()) { filter ->
            FilterChip(
                onClick = { onFilterChange(filter) },
                label = { Text(filter.name.capitalize()) },
                selected = currentFilter == filter
            )
        }
    }
}

@Composable
fun EmptyStateView(
    onCreatePost: () -> Unit
) {
    Box(
        modifier = Modifier.fillMaxSize(),
        contentAlignment = Alignment.Center
    ) {
        Column(
            horizontalAlignment = Alignment.CenterHorizontally,
            modifier = Modifier.padding(32.dp)
        ) {
            Icon(
                Icons.Default.Newspaper,
                contentDescription = null,
                modifier = Modifier.size(64.dp),
                tint = MaterialTheme.colorScheme.onSurfaceVariant
            )
            Spacer(modifier = Modifier.height(16.dp))
            Text(
                text = "No posts yet",
                style = MaterialTheme.typography.headlineSmall,
                fontWeight = FontWeight.Bold
            )
            Spacer(modifier = Modifier.height(8.dp))
            Text(
                text = "Be the first to share something!",
                style = MaterialTheme.typography.bodyMedium,
                color = MaterialTheme.colorScheme.onSurfaceVariant,
                textAlign = TextAlign.Center
            )
            Spacer(modifier = Modifier.height(24.dp))
            Button(onClick = onCreatePost) {
                Text("Create Post")
            }
        }
    }
}

@Composable
fun PostsList(
    posts: List<Post>,
    onPostClick: (Post) -> Unit,
    onLike: (String) -> Unit,
    onComment: (Post) -> Unit,
    onShare: (Post) -> Unit,
    onBookmark: (String) -> Unit
) {
    LazyColumn(
        modifier = Modifier.fillMaxSize(),
        contentPadding = PaddingValues(16.dp),
        verticalArrangement = Arrangement.spacedBy(8.dp)
    ) {
        items(posts) { post ->
            PostCard(
                post = post,
                onClick = { onPostClick(post) },
                onLike = { onLike(post.id) },
                onComment = { onComment(post) },
                onShare = { onShare(post) },
                onBookmark = { onBookmark(post.id) }
            )
        }
    }
}

@Composable
fun PostCard(
    post: Post,
    onClick: () -> Unit,
    onLike: () -> Unit,
    onComment: () -> Unit,
    onShare: () -> Unit,
    onBookmark: () -> Unit
) {
    Card(
        modifier = Modifier
            .fillMaxWidth()
            .clickable { onClick() },
        elevation = CardDefaults.cardElevation(defaultElevation = 2.dp)
    ) {
        Column(
            modifier = Modifier.padding(16.dp)
        ) {
            > Unit,
    onComment: () -> Unit,
    onShare: () -> Unit,
    onBookmark: () -> Unit
) {
    Row(
        modifier = Modifier.fillMaxWidth(),
        horizontalArrangement = Arrangement.SpaceBetween
    ) {
        Row(
            horizontalArrangement = Arrangement.spacedBy(24.dp)
        ) {
            ActionButton(
                icon = if (post.isLiked) Icons.Default.Favorite else Icons.Default.FavoriteBorder,
                text = "${post.likes}",
                onClick = onLike,
                tint = if (post.isLiked) Color.Red else MaterialTheme.colorScheme.onSurfaceVariant
            )
            ActionButton(
                icon = Icons.Default.ChatBubbleOutline,
                text = "${post.comments}",
                onClick = onComment
            )
            ActionButton(
                icon = Icons.Default.Share,
                text = "${post.shares}",
                onClick = onShare
            )
        }

        ActionButton(
            icon = if (post.isBookmarked) Icons.Default.Bookmark else Icons.Default.BookmarkBorder,
            text = "",
            onClick = onBookmark,
            tint = if (post.isBookmarked) MaterialTheme.colorScheme.primary else MaterialTheme.colorScheme.onSurfaceVariant
        )
    }
}

@Composable
fun ActionButton(
    icon: androidx.compose.ui.graphics.vector.ImageVector,
    text: String,
    onClick: () -> Unit,
    tint: Color = MaterialTheme.colorScheme.onSurfaceVariant
) {
    Row(
        verticalAlignment = Alignment.CenterVertically,
        modifier = Modifier.clickable { onClick() }
    ) {
        Icon(
            imageVector = icon,
            contentDescription = null,
            modifier = Modifier.size(20.dp),
            tint = tint
        )
        if (text.isNotEmpty()) {
            Spacer(modifier = Modifier.width(4.dp))
            Text(
                text = text,
                style = MaterialTheme.typography.bodySmall,
                color = tint
            )
        }
    }
}

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun CreatePostDialog(
    newPost: NewPost,
    onDismiss: () -> Unit,
    onSave: (Post) -> Unit
) {
    var title by remember { mutableStateOf(newPost.title) }
    var content by remember { mutableStateOf(newPost.content) }
    var image by remember { mutableStateOf(newPost.image) }
    var location by remember { mutableStateOf(newPost.location) }
    var privacy by remember { mutableStateOf(newPost.privacy) }

    AlertDialog(
        onDismissRequest = onDismiss,
        title = { Text("Create Post") },
        text = {
            Column(
                verticalArrangement = Arrangement.spacedBy(16.dp)
            ) {
                >
                                DropdownMenuItem(
                                    text = { Text(option.capitalize()) },
                                    onClick = {
                                        privacy = option
                                        expanded = false
                                    }
                                )
                            }
                        }
                    }
                }
            }
        },
        confirmButton = {
            TextButton(
                onClick = {
                    onSave(Post(
                        id = java.util.UUID.randomUUID().toString(),
                        user = User(
                            id = "current-user",
                            name = "You",
                            username = "@you",
                            avatar = "👤",
                            verified = false
                        ),
                        content = content,
                        image = image,
                        location = location,
                        timestamp = "now",
                        likes = 0,
                        comments = 0,
                        shares = 0,
                        isLiked = false,
                        isBookmarked = false,
                        privacy = privacy
                    ))
                },
                enabled = content.isNotEmpty()
            ) {
                Text("Post")
            }
        },
        dismissButton = {
            TextButton(onClick = onDismiss) {
                Text("Cancel")
            }
        }
    )
}

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun PostDetailsDialog(
    post: Post,
    onDismiss: () -> Unit
) {
    AlertDialog(
        onDismissRequest = onDismiss,
        title = { Text("Post Details") },
        text = {
            Column {
                > {
    return listOf(
        Post(
            id = "1",
            user = User(
                id = "user1",
                name = "John Doe",
                username = "@johndoe",
                avatar = "👨‍💻",
                verified = true
            ),
            content = "Just finished building an amazing React Native app! The development process was challenging but incredibly rewarding. #ReactNative #MobileDev #Tech",
            image = "📱",
            location = "San Francisco, CA",
            timestamp = "2h ago",
            likes = 42,
            comments = 8,
            shares = 3,
            isLiked = false,
            isBookmarked = false,
            privacy = "public"
        ),
        Post(
            id = "2",
            user = User(
                id = "user2",
                name = "Sarah Wilson",
                username = "@sarahw",
                avatar = "👩‍🎨",
                verified = false
            ),
            content = "Beautiful sunset from my office window today. Sometimes you need to stop and appreciate the little moments. 🌅",
            image = "🌅",
            location = "New York, NY",
            timestamp = "4h ago",
            likes = 28,
            comments = 5,
            shares = 1,
            isLiked = true,
            isBookmarked = false,
            privacy = "public"
        ),
        Post(
            id = "3",
            user = User(
                id = "user3",
                name = "Mike Chen",
                username = "@mikechen",
                avatar = "👨‍💼",
                verified = true
            ),
            content = "Excited to announce our new product launch! After months of hard work, we're finally ready to share it with the world. #Startup #Innovation",
            image = "🚀",
            location = "Austin, TX",
            timestamp = "6h ago",
            likes = 156,
            comments = 23,
            shares = 12,
            isLiked = false,
            isBookmarked = true,
            privacy = "public"
        )
    )
}

// Data classes
enum class FilterType {
    ALL, FOLLOWING, TRENDING
}

data class User(
    val id: String,
    val name: String,
    val username: String,
    val avatar: String,
    val verified: Boolean
)

data class Post(
    val id: String,
    val user: User,
    val content: String,
    val image: String,
    val location: String,
    val timestamp: String,
    val likes: Int,
    val comments: Int,
    val shares: Int,
    val isLiked: Boolean,
    val isBookmarked: Boolean,
    val privacy: String
)

data class NewPost(
    val title: String = "",
    val content: String = "",
    val image: String = "",
    val location: String = "",
    val privacy: String = "public"
)

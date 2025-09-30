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
fun GenericLinkTextScreen() {
    val articles = listOf(
        Article(
            id = 1,
            title = "Understanding Machine Learning",
            excerpt = "Machine learning is revolutionizing the way we approach data analysis and decision making. This comprehensive guide covers the fundamentals...",
            category = "Technology",
            readTime = "5 min read",
            author = "Dr. Sarah Johnson"
        ),
        Article(
            id = 2,
            title = "The Future of Renewable Energy",
            excerpt = "As climate change becomes an increasingly pressing issue, renewable energy sources are gaining momentum. Solar and wind power...",
            category = "Environment",
            readTime = "7 min read",
            author = "Mike Chen"
        ),
        Article(
            id = 3,
            title = "Digital Marketing Trends 2024",
            excerpt = "The digital marketing landscape is constantly evolving. From AI-powered personalization to voice search optimization...",
            category = "Marketing",
            readTime = "4 min read",
            author = "Emily Davis"
        ),
        Article(
            id = 4,
            title = "Cybersecurity Best Practices",
            excerpt = "With cyber threats on the rise, organizations must implement robust security measures. Learn about the latest strategies...",
            category = "Security",
            readTime = "6 min read",
            author = "David Wilson"
        )
    )
    
    Column(
        modifier = Modifier
            .fillMaxSize()
            .background(Color(0xFFF5F5F5))
            .padding(16.dp)
    ) {
        // Header
        Card(
            modifier = Modifier
                .fillMaxWidth()
                .padding(bottom = 16.dp),
            colors = CardDefaults.cardColors(containerColor = Color(0xFF1976D2))
        ) {
            Column(
                modifier = Modifier.padding(20.dp)
            ) {
                Text(
                    text = "Tech Blog",
                    fontSize = 24.sp,
                    fontWeight = FontWeight.Bold,
                    color = Color.White
                )
                Text(
                    text = "Latest insights and trends",
                    fontSize = 16.sp,
                    color = Color.White.copy(alpha = 0.9f)
                )
            }
        }
        
        // Articles List
        LazyColumn(
            verticalArrangement = Arrangement.spacedBy(16.dp)
        ) {
            items(articles) { article ->
                ArticleCard(article = article)
            }
        }
    }
}

@Composable
fun ArticleCard(article: Article) {
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
            // Category and Read Time
            Row(
                modifier = Modifier
                    .fillMaxWidth()
                    .padding(bottom = 8.dp),
                horizontalArrangement = Arrangement.SpaceBetween,
                verticalAlignment = Alignment.CenterVertically
            ) {
                Text(
                    text = article.category,
                    fontSize = 12.sp,
                    color = Color(0xFF1976D2),
                    modifier = Modifier
                        .background(
                            Color(0xFF1976D2).copy(alpha = 0.1f),
                            RoundedCornerShape(4.dp)
                        )
                        .padding(horizontal = 8.dp, vertical = 4.dp)
                )
                
                Text(
                    text = article.readTime,
                    fontSize = 12.sp,
                    color = Color.Gray
                )
            }
            
            // Article Title
            Text(
                text = article.title,
                fontSize = 18.sp,
                fontWeight = FontWeight.Bold,
                modifier = Modifier.padding(bottom = 8.dp)
            )
            
            // Article Excerpt
            Text(
                text = article.excerpt,
                fontSize = 14.sp,
                lineHeight = 20.sp,
                color = Color.Gray,
                modifier = Modifier.padding(bottom = 12.dp)
            )
            
            // Author and Actions
            Row(
                modifier = Modifier.fillMaxWidth(),
                horizontalArrangement = Arrangement.SpaceBetween,
                verticalAlignment = Alignment.CenterVertically
            ) {
                Text(
                    text = "By ${article.author}",
                    fontSize = 12.sp,
                    color = Color.Gray
                )
                
                Row(
                    horizontalArrangement = Arrangement.spacedBy(8.dp)
                ) {
                    // Generic link text - MISSING CONTEXT
                    TextButton(
                        onClick = { }
                    ) {
                        Text(
                            text = "Read more", // GENERIC: No context about destination
                            color = Color(0xFF1976D2)
                        )
                    }
                    
                    // Another generic link
                    TextButton(
                        onClick = { }
                    ) {
                        Text(
                            text = "Click here", // GENERIC: No context about destination
                            color = Color(0xFF1976D2)
                        )
                    }
                }
            }
        }
    }
}

data class Article(
    val id: Int,
    val title: String,
    val excerpt: String,
    val category: String,
    val readTime: String,
    val author: String
)

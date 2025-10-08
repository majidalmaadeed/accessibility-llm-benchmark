package com.example.uicomponents

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
fun MissingLanguageAttributeScreen() {
    val articles = listOf(
        Article(
            id = 1,
            title = "Welcome to Our News Portal",
            content = "Stay updated with the latest news and events from around the world.",
            language = "en",
            category = "General"
        ),
        Article(
            id = 2,
            title = "Bienvenue sur notre portail d'actualités",
            content = "Restez informé des dernières nouvelles et événements du monde entier.",
            language = "fr",
            category = "Général"
        ),
        Article(
            id = 3,
            title = "Breaking News: Technology Update",
            content = "New developments in artificial intelligence are changing the industry.",
            language = "en",
            category = "Technology"
        ),
        Article(
            id = 4,
            title = "Actualités: Mise à jour technologique",
            content = "Les nouveaux développements en intelligence artificielle transforment l'industrie.",
            language = "fr",
            category = "Technologie"
        ),
        Article(
            id = 5,
            title = "Sports Update: Championship Results",
            content = "The championship finals concluded with exciting results yesterday.",
            language = "en",
            category = "Sports"
        )
    )
    
    Column(
        modifier = Modifier
            .fillMaxSize()
            .background(Color(0xFFF5F5F5))
            .padding(16.dp)
    ) {
        // Header - Mixed languages without proper language attributes
        Card(
            modifier = Modifier
                .fillMaxWidth()
                .padding(bottom = 16.dp),
            colors = CardDefaults.cardColors(containerColor = Color(0xFF1976D2))
        ) {
            Column(
                modifier = Modifier.padding(20.dp)
            ) {No language attribute for mixed content
                Text(
                    text = "News Portal / Portail d'actualités",
                    fontSize = 24.sp,
                    fontWeight = FontWeight.Bold,
                    color = Color.White
                )
                Text(
                    text = "Latest News / Dernières nouvelles",
                    fontSize = 16.sp,
                    color = Color.White.copy(alpha = 0.9f)
                )
            }
        }
        
        // Language Toggle - Missing proper language attributes
        Card(
            modifier = Modifier
                .fillMaxWidth()
                .padding(bottom = 16.dp)
        ) {
            Row(
                modifier = Modifier
                    .fillMaxWidth()
                    .padding(16.dp),
                horizontalArrangement = Arrangement.SpaceBetween,
                verticalAlignment = Alignment.CenterVertically
            ) {No language attribute for language selection
                Text(
                    text = "Language / Langue:",
                    fontSize = 16.sp,
                    fontWeight = FontWeight.Medium
                )
                
                Row(
                    horizontalArrangement = Arrangement.spacedBy(8.dp)
                ) {
                    Button(
                        onClick = { },
                        colors = ButtonDefaults.buttonColors(containerColor = Color(0xFF1976D2))
                    ) {
                        Text("English", color = Color.White)
                    }
                    
                    OutlinedButton(
                        onClick = { }
                    ) {
                        Text("Français")
                    }
                }
            }
        }
        
        // Articles List
        LazyColumn(
            verticalArrangement = Arrangement.spacedBy(12.dp)
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
            // Category and Language - Mixed content without language attributes
            Row(
                modifier = Modifier
                    .fillMaxWidth()
                    .padding(bottom = 8.dp),
                horizontalArrangement = Arrangement.SpaceBetween,
                verticalAlignment = Alignment.CenterVertically
            ) {No language attribute for category
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
                )No language attribute for language indicator
                Text(
                    text = if (article.language == "en") "English" else "Français",
                    fontSize = 12.sp,
                    color = Color.Gray
                )
            }
            
            // Article Title - Missing language attribute
            Text(
                text = article.title,
                fontSize = 18.sp,
                fontWeight = FontWeight.Bold,
                modifier = Modifier.padding(bottom = 8.dp)
            )
            
            // Article Content - Missing language attribute
            Text(
                text = article.content,
                fontSize = 14.sp,
                lineHeight = 20.sp,
                color = Color.Gray,
                modifier = Modifier.padding(bottom = 12.dp)
            )
            
            // Action Buttons - Mixed language labels
            Row(
                modifier = Modifier.fillMaxWidth(),
                horizontalArrangement = Arrangement.spacedBy(8.dp)
            ) {
                Button(
                    onClick = { },
                    modifier = Modifier.weight(1f),
                    colors = ButtonDefaults.buttonColors(containerColor = Color(0xFF1976D2))
                ) {No language attribute for button text
                    Text(
                        text = if (article.language == "en") "Read More" else "Lire la suite",
                        color = Color.White
                    )
                }
                
                OutlinedButton(
                    onClick = { },
                    modifier = Modifier.weight(1f)
                ) {No language attribute for button text
                    Text(
                        text = if (article.language == "en") "Share" else "Partager"
                    )
                }
            }
        }
    }
}

data class Article(
    val id: Int,
    val title: String,
    val content: String,
    val language: String,
    val category: String
)

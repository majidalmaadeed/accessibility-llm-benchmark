import sys
from PyQt5.QtWidgets import (QApplication, QMainWindow, QVBoxLayout, QHBoxLayout, 
                             QWidget, QLabel, QPushButton, QFrame, QScrollArea)
from PyQt5.QtCore import Qt
from PyQt5.QtGui import QFont

class SmallTouchTarget(QMainWindow):
    def __init__(self):
        super().__init__()
        self.setWindowTitle("Social Media Feed")
        self.setGeometry(100, 100, 600, 800)
        
        # Central widget
        central_widget = QWidget()
        self.setCentralWidget(central_widget)
        
        # Main layout
        main_layout = QVBoxLayout(central_widget)
        main_layout.setSpacing(0)
        
        # Tab navigation
        tab_layout = QHBoxLayout()
        tab_layout.setSpacing(0)
        
        following_button = QPushButton("Following")
        following_button.setStyleSheet("QPushButton { background-color: #007bff; color: white; font-weight: bold; }")
        following_button.setFixedHeight(50)
        tab_layout.addWidget(following_button)
        
        discover_button = QPushButton("Discover")
        discover_button.setFixedHeight(50)
        tab_layout.addWidget(discover_button)
        
        trending_button = QPushButton("Trending")
        trending_button.setFixedHeight(50)
        tab_layout.addWidget(trending_button)
        
        main_layout.addLayout(tab_layout)
        
        # Posts scrollable area
        scroll_area = QScrollArea()
        scroll_area.setWidgetResizable(True)
        scroll_area.setVerticalScrollBarPolicy(Qt.ScrollBarAsNeeded)
        
        posts_widget = QWidget()
        posts_layout = QVBoxLayout(posts_widget)
        posts_layout.setSpacing(15)
        posts_layout.setContentsMargins(20, 20, 20, 20)
        
        # Load posts
        self.load_posts(posts_layout)
        
        scroll_area.setWidget(posts_widget)
        main_layout.addWidget(scroll_area)
        
    def load_posts(self, layout):
        posts = [
            {
                "username": "john_doe",
                "time_ago": "2h",
                "content": "Beautiful sunset from my hike today! 🏔️ #nature #photography",
                "likes": 42,
                "comments": 8,
                "is_liked": False,
                "is_bookmarked": False
            },
            {
                "username": "sarah_j",
                "time_ago": "4h",
                "content": "Just finished reading an amazing book! Highly recommend it to everyone.",
                "likes": 28,
                "comments": 12,
                "is_liked": False,
                "is_bookmarked": False
            },
            {
                "username": "mike_chen",
                "time_ago": "6h",
                "content": "Working on a new project. Excited to share the results soon!",
                "likes": 15,
                "comments": 3,
                "is_liked": False,
                "is_bookmarked": False
            }
        ]
        
        for post in posts:
            post_frame = self.create_post_card(post)
            layout.addWidget(post_frame)
    
    def create_post_card(self, post):
        # Post frame
        frame = QFrame()
        frame.setFrameStyle(QFrame.Box)
        frame.setStyleSheet("QFrame { background-color: white; border: 1px solid #ddd; }")
        
        main_layout = QVBoxLayout(frame)
        main_layout.setSpacing(10)
        main_layout.setContentsMargins(15, 15, 15, 15)
        
        # Profile section
        profile_layout = QHBoxLayout()
        
        # Profile image
        profile_image = QLabel("👤")
        profile_image.setFixedSize(40, 40)
        profile_image.setStyleSheet("font-size: 24px;")
        profile_layout.addWidget(profile_image)
        
        # Username and time
        user_info_layout = QVBoxLayout()
        
        username_label = QLabel(post['username'])
        username_font = QFont()
        username_font.setBold(True)
        username_label.setFont(username_font)
        user_info_layout.addWidget(username_label)
        
        time_label = QLabel(post['time_ago'])
        user_info_layout.addWidget(time_label)
        
        profile_layout.addLayout(user_info_layout)
        
        # SMALL TOUCH TARGET - Only 20x20px on mobile interface
        more_button = QPushButton("⋯")
        more_button.setFixedSize(20, 20)  # SMALL TOUCH TARGET
        more_button.setStyleSheet("QPushButton { background-color: #e0e0e0; border-radius: 4px; }")
        profile_layout.addWidget(more_button)
        
        main_layout.addLayout(profile_layout)
        
        # Post image
        post_image = QLabel("🖼️")
        post_image.setAlignment(Qt.AlignCenter)
        post_image.setFixedHeight(200)
        post_image.setStyleSheet("font-size: 100px; background-color: #f0f0f0;")
        main_layout.addWidget(post_image)
        
        # Post actions
        actions_layout = QHBoxLayout()
        actions_layout.setSpacing(16)
        
        # SMALL TOUCH TARGET - Only 20x20px
        like_button = QPushButton("♡" if not post['is_liked'] else "♥")
        like_button.setFixedSize(20, 20)  # SMALL TOUCH TARGET
        like_button.setStyleSheet("QPushButton { background-color: #e0e0e0; border-radius: 4px; }")
        actions_layout.addWidget(like_button)
        
        # SMALL TOUCH TARGET - Only 20x20px
        comment_button = QPushButton("💬")
        comment_button.setFixedSize(20, 20)  # SMALL TOUCH TARGET
        comment_button.setStyleSheet("QPushButton { background-color: #e0e0e0; border-radius: 4px; }")
        actions_layout.addWidget(comment_button)
        
        # SMALL TOUCH TARGET - Only 20x20px
        share_button = QPushButton("↗️")
        share_button.setFixedSize(20, 20)  # SMALL TOUCH TARGET
        share_button.setStyleSheet("QPushButton { background-color: #e0e0e0; border-radius: 4px; }")
        actions_layout.addWidget(share_button)
        
        # SMALL TOUCH TARGET - Only 20x20px
        bookmark_button = QPushButton("🔖")
        bookmark_button.setFixedSize(20, 20)  # SMALL TOUCH TARGET
        bookmark_button.setStyleSheet("QPushButton { background-color: #e0e0e0; border-radius: 4px; }")
        actions_layout.addWidget(bookmark_button)
        
        main_layout.addLayout(actions_layout)
        
        # Likes count
        likes_label = QLabel(f"{post['likes']} likes")
        likes_font = QFont()
        likes_font.setBold(True)
        likes_label.setFont(likes_font)
        main_layout.addWidget(likes_label)
        
        # Post content
        content_label = QLabel(f"{post['username']} {post['content']}")
        content_font = QFont()
        content_font.setBold(True)
        content_label.setFont(content_font)
        content_label.setWordWrap(True)
        main_layout.addWidget(content_label)
        
        # Comments link
        comments_label = QLabel(f"View all {post['comments']} comments")
        comments_label.setStyleSheet("color: #666;")
        main_layout.addWidget(comments_label)
        
        return frame

def main():
    app = QApplication(sys.argv)
    window = SmallTouchTarget()
    window.show()
    sys.exit(app.exec_())

if __name__ == "__main__":
    main()

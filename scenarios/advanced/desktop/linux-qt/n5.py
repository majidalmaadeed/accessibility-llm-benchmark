#!/usr/bin/env python3

import sys
from PyQt5.QtWidgets import (QApplication, QMainWindow, QWidget, QVBoxLayout, 
                             QHBoxLayout, QGridLayout, QLabel, QPushButton, 
                             QComboBox, QListWidget, QListWidgetItem, QLineEdit,
                             QCheckBox, QMessageBox, QFrame, QScrollArea,
                             QGroupBox, QSlider, QSpinBox, QTextEdit, QDialog)
from PyQt5.QtCore import Qt, QTimer, pyqtSignal, QRect
from PyQt5.QtGui import QFont, QPalette, QColor, QIcon, QPainter, QPen, QBrush
from datetime import datetime

class SocialMediaFeed(QMainWindow):
    def __init__(self):
        super().__init__()
        self.setWindowTitle("Social Media Feed")
        self.setGeometry(100, 100, 1000, 700)
        
        # Data
        self.posts = []
        self.all_posts = []
        self.current_filter = "All"
        self.unread_notifications = 3
        
        # Load sample data
        self.load_sample_posts()
        
        # Create UI
        self.create_ui()
    
    def create_ui(self):
        # Central widget
        central_widget = QWidget()
        self.setCentralWidget(central_widget)
        
        # Main layout
        main_layout = QVBoxLayout()
        central_widget.setLayout(main_layout)
        
        # Header
        header_widget = self.create_header()
        main_layout.addWidget(header_widget)
        
        # Create post
        create_post_widget = self.create_post_box()
        main_layout.addWidget(create_post_widget)
        
        # Posts feed
        self.create_posts_feed(main_layout)
        
        # Status bar
        self.status_bar = self.statusBar()
        self.status_bar.showMessage("Ready")
    
    def create_header(self):
        header_widget = QFrame()
        header_widget.setStyleSheet("""
            QFrame {
                background-color: #4A90E2;
                padding: 20px;
                border: none;
            }
        """)
        
        header_layout = QHBoxLayout()
        header_widget.setLayout(header_layout)
        
        # Title
        title_label = QLabel("Social Media Feed")
        title_label.setStyleSheet("""
            QLabel {
                color: white;
                font-size: 24px;
                font-weight: bold;
            }
        """)
        header_layout.addWidget(title_label)
        
        header_layout.addStretch()
        
        # Controls
        controls_layout = QHBoxLayout()
        
        # Filter combo
        self.filter_combo = QComboBox()
        self.filter_combo.addItems(["All", "Following", "Trending"])
        self.filter_combo.currentTextChanged.connect(self.on_filter_changed)
        controls_layout.addWidget(self.filter_combo)
        
        # Notifications button
        self.notifications_btn = QPushButton("🔔")
        self.notifications_btn.setToolTip("Notifications")
        self.notifications_btn.setStyleSheet("""
            QPushButton {
                background-color: rgba(255, 255, 255, 0.2);
                color: white;
                border: none;
                padding: 8px 12px;
                border-radius: 4px;
                font-size: 16px;
            }
            QPushButton:hover {
                background-color: rgba(255, 255, 255, 0.3);
            }
        """)
        self.notifications_btn.clicked.connect(self.on_notifications_clicked)
        controls_layout.addWidget(self.notifications_btn)
        
        # Trending button
        trending_btn = QPushButton("📈")
        trending_btn.setToolTip("Trending")
        trending_btn.setStyleSheet("""
            QPushButton {
                background-color: rgba(255, 255, 255, 0.2);
                color: white;
                border: none;
                padding: 8px 12px;
                border-radius: 4px;
                font-size: 16px;
            }
            QPushButton:hover {
                background-color: rgba(255, 255, 255, 0.3);
            }
        """)
        trending_btn.clicked.connect(self.on_trending_clicked)
        controls_layout.addWidget(trending_btn)
        
        header_layout.addLayout(controls_layout)
        
        return header_widget
    
    def create_post_box(self):
        create_post_widget = QFrame()
        create_post_widget.setStyleSheet("""
            QFrame {
                background-color: #F8F8F8;
                padding: 16px;
                border: none;
            }
        """)
        
        create_post_layout = QHBoxLayout()
        create_post_widget.setLayout(create_post_layout)
        
        # Avatar
        avatar_label = QLabel("👤")
        avatar_label.setStyleSheet("font-size: 32px;")
        create_post_layout.addWidget(avatar_label)
        
        # Text entry and button
        entry_layout = QHBoxLayout()
        
        self.create_post_entry = QLineEdit()
        self.create_post_entry.setPlaceholderText("What's on your mind?")
        self.create_post_entry.setStyleSheet("""
            QLineEdit {
                padding: 12px;
                border: 2px solid #E0E0E0;
                border-radius: 8px;
                font-size: 14px;
                background-color: white;
            }
            QLineEdit:focus {
                border-color: #4A90E2;
            }
        """)
        self.create_post_entry.returnPressed.connect(self.on_create_post)
        entry_layout.addWidget(self.create_post_entry)
        
        self.create_post_btn = QPushButton("Post")
        self.create_post_btn.setStyleSheet("""
            QPushButton {
                background-color: #4A90E2;
                color: white;
                border: none;
                padding: 12px 24px;
                border-radius: 8px;
                font-weight: bold;
            }
            QPushButton:hover {
                background-color: #357ABD;
            }
            QPushButton:disabled {
                background-color: #CCCCCC;
            }
        """)
        self.create_post_btn.clicked.connect(self.on_create_post)
        entry_layout.addWidget(self.create_post_btn)
        
        create_post_layout.addLayout(entry_layout)
        
        return create_post_widget
    
    def create_posts_feed(self, parent):
        # Scroll area for posts
        scroll_area = QScrollArea()
        scroll_area.setWidgetResizable(True)
        scroll_area.setVerticalScrollBarPolicy(Qt.ScrollBarAsNeeded)
        scroll_area.setHorizontalScrollBarPolicy(Qt.ScrollBarNever)
        
        # Posts container
        self.posts_widget = QWidget()
        self.posts_layout = QVBoxLayout()
        self.posts_widget.setLayout(self.posts_layout)
        
        scroll_area.setWidget(self.posts_widget)
        parent.addWidget(scroll_area)
        
        # Update posts display
        self.update_posts_display()
    
    def load_sample_posts(self):
        self.all_posts = [
            {
                'id': '1',
                'user': {
                    'id': 'user1',
                    'name': 'John Doe',
                    'username': '@johndoe',
                    'avatar': '👨‍💻',
                    'verified': True
                },
                'content': 'Just finished building an amazing React Native app! The development process was challenging but incredibly rewarding. #ReactNative #MobileDev #Tech',
                'image': '📱',
                'location': 'San Francisco, CA',
                'timestamp': '2h ago',
                'likes': 42,
                'comments': 8,
                'shares': 3,
                'is_liked': False,
                'is_bookmarked': False,
                'privacy': 'public'
            },
            {
                'id': '2',
                'user': {
                    'id': 'user2',
                    'name': 'Sarah Wilson',
                    'username': '@sarahw',
                    'avatar': '👩‍🎨',
                    'verified': False
                },
                'content': 'Beautiful sunset from my office window today. Sometimes you need to stop and appreciate the little moments. 🌅',
                'image': '🌅',
                'location': 'New York, NY',
                'timestamp': '4h ago',
                'likes': 28,
                'comments': 5,
                'shares': 1,
                'is_liked': True,
                'is_bookmarked': False,
                'privacy': 'public'
            },
            {
                'id': '3',
                'user': {
                    'id': 'user3',
                    'name': 'Mike Chen',
                    'username': '@mikechen',
                    'avatar': '👨‍💼',
                    'verified': True
                },
                'content': 'Excited to announce our new product launch! After months of hard work, we\'re finally ready to share it with the world. #Startup #Innovation',
                'image': '🚀',
                'location': 'Austin, TX',
                'timestamp': '6h ago',
                'likes': 156,
                'comments': 23,
                'shares': 12,
                'is_liked': False,
                'is_bookmarked': True,
                'privacy': 'public'
            },
            {
                'id': '4',
                'user': {
                    'id': 'user4',
                    'name': 'Emma Davis',
                    'username': '@emmad',
                    'avatar': '👩‍🔬',
                    'verified': False
                },
                'content': 'Just read an amazing article about the future of AI in healthcare. The possibilities are endless! What are your thoughts on this?',
                'image': '🤖',
                'location': 'Boston, MA',
                'timestamp': '8h ago',
                'likes': 73,
                'comments': 15,
                'shares': 7,
                'is_liked': True,
                'is_bookmarked': False,
                'privacy': 'public'
            },
            {
                'id': '5',
                'user': {
                    'id': 'user5',
                    'name': 'Alex Rodriguez',
                    'username': '@alexr',
                    'avatar': '👨‍🎓',
                    'verified': False
                },
                'content': 'Coffee and code - the perfect combination for a productive day! ☕️💻',
                'image': '☕️',
                'location': 'Seattle, WA',
                'timestamp': '10h ago',
                'likes': 34,
                'comments': 6,
                'shares': 2,
                'is_liked': False,
                'is_bookmarked': False,
                'privacy': 'public'
            }
        ]
        
        self.posts = self.all_posts.copy()
    
    def update_posts_display(self):
        # Clear existing posts
        for i in reversed(range(self.posts_layout.count())):
            self.posts_layout.itemAt(i).widget().setParent(None)
        
        # Add posts
        for post in self.posts:
            post_widget = self.create_post_widget(post)
            self.posts_layout.addWidget(post_widget)
        
        # Update status bar
        self.status_bar.showMessage(f"{len(self.posts)} posts")
    
    def create_post_widget(self, post):
        # Main container
        post_frame = QFrame()
        post_frame.setStyleSheet("""
            QFrame {
                background-color: white;
                border: 1px solid #E0E0E0;
                border-radius: 8px;
                margin: 8px;
            }
        """)
        
        post_layout = QVBoxLayout()
        post_frame.setLayout(post_layout)
        
        # Header
        header_layout = QHBoxLayout()
        
        # Avatar
        avatar_label = QLabel(post['user']['avatar'])
        avatar_label.setStyleSheet("font-size: 32px;")
        header_layout.addWidget(avatar_label)
        
        # User info
        user_info_layout = QVBoxLayout()
        
        # Name and verification
        name_layout = QHBoxLayout()
        
        name_label = QLabel(post['user']['name'])
        name_label.setFont(QFont("Arial", 14, QFont.Bold))
        name_layout.addWidget(name_label)
        
        if post['user']['verified']:
            verified_label = QLabel("✓")
            verified_label.setStyleSheet("color: #4A90E2; font-weight: bold;")
            name_layout.addWidget(verified_label)
        
        name_layout.addStretch()
        
        user_info_layout.addLayout(name_layout)
        
        # Username and timestamp
        username_label = QLabel(f"{post['user']['username']} • {post['timestamp']}")
        username_label.setStyleSheet("color: #666666; font-size: 12px;")
        user_info_layout.addWidget(username_label)
        
        header_layout.addLayout(user_info_layout)
        header_layout.addStretch()
        
        post_layout.addLayout(header_layout)
        
        # Content
        content_label = QLabel(post['content'])
        content_label.setWordWrap(True)
        content_label.setStyleSheet("font-size: 14px; padding: 8px 0;")
        post_layout.addWidget(content_label)
        
        # Image
        if post['image']:
            image_label = QLabel(post['image'])
            image_label.setAlignment(Qt.AlignCenter)
            image_label.setStyleSheet("font-size: 48px; padding: 16px; background-color: #F8F8F8; border-radius: 8px;")
            post_layout.addWidget(image_label)
        
        # Location
        if post['location']:
            location_layout = QHBoxLayout()
            
            location_icon = QLabel("📍")
            location_layout.addWidget(location_icon)
            
            location_label = QLabel(post['location'])
            location_label.setStyleSheet("color: #666666; font-size: 12px;")
            location_layout.addWidget(location_label)
            
            location_layout.addStretch()
            
            post_layout.addLayout(location_layout)
        
        # Actions
        actions_layout = QHBoxLayout()
        
        # Like button
        like_btn = QPushButton()
        like_icon = "❤️" if post['is_liked'] else "🤍"
        like_btn.setText(f"{like_icon} {post['likes']}")
        like_btn.setStyleSheet("""
            QPushButton {
                background-color: transparent;
                border: none;
                padding: 8px 12px;
                text-align: left;
            }
            QPushButton:hover {
                background-color: #F0F0F0;
                border-radius: 4px;
            }
        """)
        like_btn.clicked.connect(lambda: self.on_like_clicked(post))
        actions_layout.addWidget(like_btn)
        
        # Comment button
        comment_btn = QPushButton(f"💬 {post['comments']}")
        comment_btn.setStyleSheet("""
            QPushButton {
                background-color: transparent;
                border: none;
                padding: 8px 12px;
                text-align: left;
            }
            QPushButton:hover {
                background-color: #F0F0F0;
                border-radius: 4px;
            }
        """)
        comment_btn.clicked.connect(lambda: self.on_comment_clicked(post))
        actions_layout.addWidget(comment_btn)
        
        # Share button
        share_btn = QPushButton(f"🔄 {post['shares']}")
        share_btn.setStyleSheet("""
            QPushButton {
                background-color: transparent;
                border: none;
                padding: 8px 12px;
                text-align: left;
            }
            QPushButton:hover {
                background-color: #F0F0F0;
                border-radius: 4px;
            }
        """)
        share_btn.clicked.connect(lambda: self.on_share_clicked(post))
        actions_layout.addWidget(share_btn)
        
        # Bookmark button
        bookmark_btn = QPushButton()
        bookmark_icon = "🔖" if post['is_bookmarked'] else "📌"
        bookmark_btn.setText(bookmark_icon)
        bookmark_btn.setStyleSheet("""
            QPushButton {
                background-color: transparent;
                border: none;
                padding: 8px 12px;
                text-align: left;
            }
            QPushButton:hover {
                background-color: #F0F0F0;
                border-radius: 4px;
            }
        """)
        bookmark_btn.clicked.connect(lambda: self.on_bookmark_clicked(post))
        actions_layout.addWidget(bookmark_btn)
        
        actions_layout.addStretch()
        
        post_layout.addLayout(actions_layout)
        
        return post_frame
    
    # Event handlers
    def on_filter_changed(self, filter_text):
        self.current_filter = filter_text
        # In a real implementation, this would filter posts
        self.status_bar.showMessage(f"Filter changed to {filter_text}")
    
    def on_notifications_clicked(self):
        dialog = NotificationsDialog(self, self.unread_notifications)
        dialog.exec_()
    
    def on_trending_clicked(self):
        dialog = TrendingDialog(self)
        dialog.exec_()
    
    def on_create_post(self):
        content = self.create_post_entry.text().strip()
        if not content:
            return
        
        new_post = {
            'id': str(datetime.now().timestamp()),
            'user': {
                'id': 'current-user',
                'name': 'You',
                'username': '@you',
                'avatar': '👤',
                'verified': False
            },
            'content': content,
            'image': '',
            'location': '',
            'timestamp': 'now',
            'likes': 0,
            'comments': 0,
            'shares': 0,
            'is_liked': False,
            'is_bookmarked': False,
            'privacy': 'public'
        }
        
        self.posts.insert(0, new_post)
        self.all_posts.insert(0, new_post)
        self.create_post_entry.clear()
        self.update_posts_display()
    
    def on_like_clicked(self, post):
        # Toggle like
        post['is_liked'] = not post['is_liked']
        post['likes'] += 1 if post['is_liked'] else -1
        
        # Update in all_posts as well
        for all_post in self.all_posts:
            if all_post['id'] == post['id']:
                all_post['is_liked'] = post['is_liked']
                all_post['likes'] = post['likes']
                break
        
        self.update_posts_display()
    
    def on_comment_clicked(self, post):
        QMessageBox.information(self, "Comments", f"Comments for: {post['user']['name']}\n\n{post['content']}")
    
    def on_share_clicked(self, post):
        QMessageBox.information(self, "Share", f"Sharing: {post['content'][:50]}...")
    
    def on_bookmark_clicked(self, post):
        # Toggle bookmark
        post['is_bookmarked'] = not post['is_bookmarked']
        
        # Update in all_posts as well
        for all_post in self.all_posts:
            if all_post['id'] == post['id']:
                all_post['is_bookmarked'] = post['is_bookmarked']
                break
        
        self.update_posts_display()

class NotificationsDialog(QDialog):
    def __init__(self, parent, unread_count):
        super().__init__(parent)
        self.setWindowTitle("Notifications")
        self.setModal(True)
        self.resize(400, 300)
        self.unread_count = unread_count
        
        self.setup_ui()
    
    def setup_ui(self):
        layout = QVBoxLayout()
        self.setLayout(layout)
        
        # Title
        title_label = QLabel("Notifications")
        title_label.setFont(QFont("Arial", 18, QFont.Bold))
        title_label.setAlignment(Qt.AlignCenter)
        layout.addWidget(title_label)
        
        # Unread count
        count_label = QLabel(f"You have {self.unread_count} unread notifications")
        count_label.setAlignment(Qt.AlignCenter)
        count_label.setStyleSheet("color: #666666;")
        layout.addWidget(count_label)
        
        # Notifications list
        notifications_list = QListWidget()
        notifications = [
            "New like on your post",
            "John Doe commented on your post",
            "Sarah Wilson shared your post"
        ]
        
        for notification in notifications:
            item = QListWidgetItem(notification)
            notifications_list.addItem(item)
        
        layout.addWidget(notifications_list)
        
        # Buttons
        button_layout = QHBoxLayout()
        
        mark_read_btn = QPushButton("Mark All Read")
        mark_read_btn.clicked.connect(self.mark_all_read)
        button_layout.addWidget(mark_read_btn)
        
        close_btn = QPushButton("Close")
        close_btn.clicked.connect(self.accept)
        button_layout.addWidget(close_btn)
        
        layout.addLayout(button_layout)
    
    def mark_all_read(self):
        QMessageBox.information(self, "Mark All Read", "All notifications marked as read.")
        self.accept()

class TrendingDialog(QDialog):
    def __init__(self, parent):
        super().__init__(parent)
        self.setWindowTitle("Trending")
        self.setModal(True)
        self.resize(300, 250)
        
        self.setup_ui()
    
    def setup_ui(self):
        layout = QVBoxLayout()
        self.setLayout(layout)
        
        # Title
        title_label = QLabel("Trending")
        title_label.setFont(QFont("Arial", 18, QFont.Bold))
        title_label.setAlignment(Qt.AlignCenter)
        layout.addWidget(title_label)
        
        # Trending topics
        topics_list = QListWidget()
        topics = [
            "#ReactNative - 2.3K posts",
            "#MobileDev - 1.8K posts",
            "#Tech - 3.1K posts",
            "#Startup - 1.2K posts",
            "#Innovation - 956 posts"
        ]
        
        for topic in topics:
            item = QListWidgetItem(topic)
            topics_list.addItem(item)
        
        layout.addWidget(topics_list)
        
        # Close button
        close_btn = QPushButton("Close")
        close_btn.clicked.connect(self.accept)
        layout.addWidget(close_btn)

def main():
    app = QApplication(sys.argv)
    
    # Set application style
    app.setStyle('Fusion')
    
    window = SocialMediaFeed()
    window.show()
    
    sys.exit(app.exec_())

if __name__ == "__main__":
    main()

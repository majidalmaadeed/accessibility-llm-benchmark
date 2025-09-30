import sys
from PyQt5.QtWidgets import (QApplication, QMainWindow, QVBoxLayout, QHBoxLayout, 
                             QWidget, QLabel, QPushButton, QFrame, QGridLayout, QScrollArea)
from PyQt5.QtCore import Qt, QTimer
from PyQt5.QtGui import QFont

class AutoPlayingBackgroundVideo(QMainWindow):
    def __init__(self):
        super().__init__()
        self.setWindowTitle("Video Platform")
        self.setGeometry(100, 100, 1000, 700)
        
        # Central widget
        central_widget = QWidget()
        self.setCentralWidget(central_widget)
        
        # Main layout
        main_layout = QVBoxLayout(central_widget)
        main_layout.setSpacing(0)
        
        # Hero section with auto-playing background video
        hero_frame = QFrame()
        hero_frame.setFixedHeight(300)
        hero_frame.setStyleSheet("QFrame { background: qlineargradient(x1:0, y1:0, x2:1, y2:1, stop:0 #667eea, stop:1 #764ba2); }")
        
        # Video overlay
        video_overlay_layout = QVBoxLayout(hero_frame)
        video_overlay_layout.setAlignment(Qt.AlignCenter)
        
        # Video placeholder
        video_layout = QVBoxLayout()
        video_layout.setAlignment(Qt.AlignCenter)
        
        # AUTO-PLAYING BACKGROUND VIDEO - Hero section video autoplays without user control
        video_icon = QLabel("🎬")
        video_icon.setAlignment(Qt.AlignCenter)
        video_icon.setStyleSheet("font-size: 100px;")
        video_layout.addWidget(video_icon)
        
        video_title = QLabel("Auto-playing Video")
        video_title_font = QFont()
        video_title_font.setPointSize(20)
        video_title_font.setBold(True)
        video_title.setFont(video_title_font)
        video_title.setAlignment(Qt.AlignCenter)
        video_title.setStyleSheet("color: white;")
        video_layout.addWidget(video_title)
        
        video_subtitle = QLabel("This video plays automatically")
        video_subtitle_font = QFont()
        video_subtitle_font.setPointSize(16)
        video_subtitle.setFont(video_subtitle_font)
        video_subtitle.setAlignment(Qt.AlignCenter)
        video_subtitle.setStyleSheet("color: white;")
        video_layout.addWidget(video_subtitle)
        
        video_overlay_layout.addLayout(video_layout)
        
        # Play/Pause button overlay
        self.play_pause_button = QPushButton("⏸️")
        self.play_pause_button.setFixedSize(60, 60)
        self.play_pause_button.setStyleSheet("QPushButton { background-color: rgba(0, 0, 0, 0.5); border-radius: 30px; color: white; }")
        self.play_pause_button.clicked.connect(self.on_play_pause_clicked)
        
        # Position the play button
        button_layout = QHBoxLayout()
        button_layout.addStretch()
        button_layout.addWidget(self.play_pause_button)
        button_layout.addStretch()
        
        video_overlay_layout.addLayout(button_layout)
        
        main_layout.addWidget(hero_frame)
        
        # Main content
        scroll_area = QScrollArea()
        scroll_area.setWidgetResizable(True)
        scroll_area.setVerticalScrollBarPolicy(Qt.ScrollBarAsNeeded)
        
        content_widget = QWidget()
        content_layout = QVBoxLayout(content_widget)
        content_layout.setSpacing(20)
        content_layout.setContentsMargins(20, 20, 20, 20)
        
        # Featured content
        featured_label = QLabel("Featured Content")
        featured_font = QFont()
        featured_font.setPointSize(20)
        featured_font.setBold(True)
        featured_label.setFont(featured_font)
        featured_label.setAlignment(Qt.AlignCenter)
        content_layout.addWidget(featured_label)
        
        featured_subtitle = QLabel("Discover our latest videos and tutorials")
        featured_subtitle_font = QFont()
        featured_subtitle_font.setPointSize(16)
        featured_subtitle.setFont(featured_subtitle_font)
        featured_subtitle.setAlignment(Qt.AlignCenter)
        content_layout.addWidget(featured_subtitle)
        
        # Video categories
        categories_label = QLabel("Video Categories")
        categories_font = QFont()
        categories_font.setPointSize(18)
        categories_font.setBold(True)
        categories_label.setFont(categories_font)
        content_layout.addWidget(categories_label)
        
        categories_grid = QGridLayout()
        categories_grid.setSpacing(20)
        
        categories = [
            ("🎥", "Tutorials", "Learn new skills"),
            ("🎬", "Documentaries", "Explore the world"),
            ("🎭", "Entertainment", "Fun and games")
        ]
        
        for i, (icon, title, subtitle) in enumerate(categories):
            category_frame = self.create_category_card(icon, title, subtitle)
            categories_grid.addWidget(category_frame, i // 3, i % 3)
        
        content_layout.addLayout(categories_grid)
        
        # Recent videos
        recent_label = QLabel("Recent Videos")
        recent_label.setFont(categories_font)
        content_layout.addWidget(recent_label)
        
        # Recent videos list
        recent_videos_layout = QVBoxLayout()
        
        videos = [
            {
                "title": "Getting Started with SwiftUI",
                "content": "Learn the basics of SwiftUI development",
                "author": "John Smith",
                "duration": "15 min",
                "image": "📱"
            },
            {
                "title": "Advanced iOS Development",
                "content": "Master advanced iOS development techniques",
                "author": "Sarah Johnson",
                "duration": "25 min",
                "image": "💻"
            },
            {
                "title": "Flutter Performance Optimization",
                "content": "Optimize your Flutter apps for better performance",
                "author": "Mike Chen",
                "duration": "20 min",
                "image": "🚀"
            },
            {
                "title": "React Native Best Practices",
                "content": "Best practices for React Native development",
                "author": "Emily Davis",
                "duration": "18 min",
                "image": "⚛️"
            }
        ]
        
        for video in videos:
            video_frame = self.create_video_card(video)
            recent_videos_layout.addWidget(video_frame)
        
        content_layout.addLayout(recent_videos_layout)
        
        scroll_area.setWidget(content_widget)
        main_layout.addWidget(scroll_area)
        
        # State
        self.is_playing = True
        self.current_time = 0.0
        self.duration = 30.0
        
        # Start auto-play
        self.start_auto_play()
        
    def create_category_card(self, icon, title, subtitle):
        frame = QFrame()
        frame.setFrameStyle(QFrame.Box)
        frame.setFixedSize(200, 120)
        frame.setStyleSheet("QFrame { background-color: white; border: 1px solid #ddd; }")
        
        layout = QVBoxLayout(frame)
        layout.setSpacing(8)
        layout.setContentsMargins(15, 15, 15, 15)
        
        icon_label = QLabel(icon)
        icon_label.setAlignment(Qt.AlignCenter)
        icon_label.setStyleSheet("font-size: 36px;")
        layout.addWidget(icon_label)
        
        title_label = QLabel(title)
        title_font = QFont()
        title_font.setBold(True)
        title_label.setFont(title_font)
        title_label.setAlignment(Qt.AlignCenter)
        layout.addWidget(title_label)
        
        subtitle_label = QLabel(subtitle)
        subtitle_label.setAlignment(Qt.AlignCenter)
        subtitle_label.setWordWrap(True)
        layout.addWidget(subtitle_label)
        
        return frame
    
    def create_video_card(self, video):
        frame = QFrame()
        frame.setFrameStyle(QFrame.Box)
        frame.setStyleSheet("QFrame { background-color: white; border: 1px solid #ddd; }")
        
        main_layout = QHBoxLayout(frame)
        main_layout.setSpacing(15)
        main_layout.setContentsMargins(15, 15, 15, 15)
        
        # Video thumbnail
        thumbnail = QLabel(video["image"])
        thumbnail.setFixedSize(80, 80)
        thumbnail.setStyleSheet("font-size: 40px;")
        main_layout.addWidget(thumbnail)
        
        # Video content
        content_layout = QVBoxLayout()
        
        title_label = QLabel(video["title"])
        title_font = QFont()
        title_font.setPointSize(16)
        title_font.setBold(True)
        title_label.setFont(title_font)
        title_label.setWordWrap(True)
        content_layout.addWidget(title_label)
        
        content_label = QLabel(video["content"])
        content_label.setWordWrap(True)
        content_layout.addWidget(content_label)
        
        author_label = QLabel(f"By {video['author']} • {video['duration']}")
        content_layout.addWidget(author_label)
        
        main_layout.addLayout(content_layout)
        
        # Actions
        actions_layout = QVBoxLayout()
        actions_layout.setSpacing(10)
        
        play_button = QPushButton("▶️")
        play_button.setFixedSize(40, 40)
        play_button.clicked.connect(lambda: self.on_video_play_clicked(video))
        actions_layout.addWidget(play_button)
        
        share_button = QPushButton("↗️")
        share_button.setFixedSize(40, 40)
        share_button.clicked.connect(lambda: self.on_video_share_clicked(video))
        actions_layout.addWidget(share_button)
        
        main_layout.addLayout(actions_layout)
        
        return frame
    
    def start_auto_play(self):
        # Simulate auto-play
        pass
    
    def on_play_pause_clicked(self):
        self.is_playing = not self.is_playing
        if self.is_playing:
            self.play_pause_button.setText("⏸️")
        else:
            self.play_pause_button.setText("▶️")
    
    def on_video_play_clicked(self, video):
        from PyQt5.QtWidgets import QMessageBox
        QMessageBox.information(self, "Play Video", f"Playing: {video['title']}")
    
    def on_video_share_clicked(self, video):
        from PyQt5.QtWidgets import QMessageBox
        QMessageBox.information(self, "Share Video", f"Share: {video['title']}")

def main():
    app = QApplication(sys.argv)
    window = AutoPlayingBackgroundVideo()
    window.show()
    sys.exit(app.exec_())

if __name__ == "__main__":
    main()

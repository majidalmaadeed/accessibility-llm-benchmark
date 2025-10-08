import sys
from PyQt5.QtWidgets import (QApplication, QMainWindow, QVBoxLayout, QHBoxLayout, 
                             QWidget, QLabel, QPushButton, QFrame, QProgressBar)
from PyQt5.QtCore import Qt, QTimer
from PyQt5.QtGui import QFont, QIcon

class UnlabeledMediaButton(QMainWindow):
    def __init__(self):
        super().__init__()
        self.setWindowTitle("Video Player")
        self.setGeometry(100, 100, 800, 600)
        
        # Central widget
        central_widget = QWidget()
        self.setCentralWidget(central_widget)
        
        # Main layout
        main_layout = QVBoxLayout(central_widget)
        main_layout.setSpacing(20)
        
        # Header
        header_label = QLabel("Video Player")
        header_label.setAlignment(Qt.AlignCenter)
        header_font = QFont()
        header_font.setPointSize(20)
        header_font.setBold(True)
        header_label.setFont(header_font)
        main_layout.addWidget(header_label)
        
        # Video area
        video_frame = QFrame()
        video_frame.setFrameStyle(QFrame.Box)
        video_frame.setFixedHeight(300)
        video_frame.setStyleSheet("background-color: #f0f0f0;")
        
        video_layout = QVBoxLayout(video_frame)
        video_layout.setAlignment(Qt.AlignCenter)
        
        # Video placeholder
        video_icon = QLabel("🎬")
        video_icon.setAlignment(Qt.AlignCenter)
        video_icon.setStyleSheet("font-size: 100px;")
        video_layout.addWidget(video_icon)
        
        # Video title
        title_label = QLabel("Flutter Development Tutorial")
        title_label.setAlignment(Qt.AlignCenter)
        title_font = QFont()
        title_font.setPointSize(16)
        title_font.setBold(True)
        title_label.setFont(title_font)
        video_layout.addWidget(title_label)
        
        main_layout.addWidget(video_frame)
        
        # Progress bar
        progress_layout = QHBoxLayout()
        progress_layout.setAlignment(Qt.AlignCenter)
        
        self.progress_bar = QProgressBar()
        self.progress_bar.setFixedWidth(300)
        self.progress_bar.setValue(30)
        progress_layout.addWidget(self.progress_bar)
        
        # Time labels
        time_layout = QHBoxLayout()
        current_time = QLabel("2:15")
        duration = QLabel("7:30")
        time_layout.addWidget(current_time)
        time_layout.addWidget(duration)
        
        progress_layout.addLayout(time_layout)
        main_layout.addLayout(progress_layout)
        
        # Controls
        controls_layout = QHBoxLayout()
        controls_layout.setAlignment(Qt.AlignCenter)
        controls_layout.setSpacing(10)
        
        # UNLABELED MEDIA BUTTON - Video play button using only emoji icon without accessible name
        self.play_button = QPushButton("▶️")
        self.play_button.setFixedSize(60, 60)
        self.play_button.clicked.connect(self.on_play_clicked)
        controls_layout.addWidget(self.play_button)
        
        # Other control buttons
        prev_button = QPushButton("⏮️")
        prev_button.setFixedSize(50, 50)
        controls_layout.addWidget(prev_button)
        
        next_button = QPushButton("⏭️")
        next_button.setFixedSize(50, 50)
        controls_layout.addWidget(next_button)
        
        volume_button = QPushButton("🔊")
        volume_button.setFixedSize(50, 50)
        controls_layout.addWidget(volume_button)
        
        fullscreen_button = QPushButton("⛶")
        fullscreen_button.setFixedSize(50, 50)
        controls_layout.addWidget(fullscreen_button)
        
        main_layout.addLayout(controls_layout)
        
        # State
        self.is_playing = False
        
    def on_play_clicked(self):
        self.is_playing = not self.is_playing
        if self.is_playing:
            self.play_button.setText("⏸️")
        else:
            self.play_button.setText("▶️")

def main():
    app = QApplication(sys.argv)
    window = UnlabeledMediaButton()
    window.show()
    sys.exit(app.exec_())

if __name__ == "__main__":
    main()

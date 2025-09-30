import sys
from PyQt5.QtWidgets import (QApplication, QMainWindow, QVBoxLayout, QHBoxLayout, 
                             QWidget, QLabel, QPushButton, QFrame, QScrollArea)
from PyQt5.QtCore import Qt
from PyQt5.QtGui import QFont

class GenericLinkText(QMainWindow):
    def __init__(self):
        super().__init__()
        self.setWindowTitle("Tech Blog")
        self.setGeometry(100, 100, 1000, 700)
        
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
        
        # Featured article section
        featured_frame = QFrame()
        featured_frame.setFrameStyle(QFrame.Box)
        featured_frame.setStyleSheet("QFrame { background-color: #f8f9fa; }")
        featured_frame.setContentsMargins(20, 20, 20, 20)
        
        featured_layout = QVBoxLayout(featured_frame)
        featured_layout.setSpacing(15)
        
        # Featured article image
        featured_image = QLabel("📰")
        featured_image.setAlignment(Qt.AlignCenter)
        featured_image.setStyleSheet("font-size: 100px;")
        featured_image.setFixedHeight(200)
        featured_layout.addWidget(featured_image)
        
        # Featured article content
        featured_title = QLabel("Building Scalable React Native Applications")
        featured_title_font = QFont()
        featured_title_font.setPointSize(20)
        featured_title_font.setBold(True)
        featured_title.setFont(featured_title_font)
        featured_title.setAlignment(Qt.AlignCenter)
        featured_title.setWordWrap(True)
        featured_layout.addWidget(featured_title)
        
        featured_content = QLabel("Discover the key principles and patterns for creating maintainable and scalable React Native applications that can grow with your business needs.")
        featured_content_font = QFont()
        featured_content_font.setPointSize(14)
        featured_content.setFont(featured_content_font)
        featured_content.setAlignment(Qt.AlignCenter)
        featured_content.setWordWrap(True)
        featured_layout.addWidget(featured_content)
        
        # Author section
        author_layout = QHBoxLayout()
        author_layout.setAlignment(Qt.AlignCenter)
        
        author_image = QLabel("👤")
        author_image.setFixedSize(40, 40)
        author_image.setStyleSheet("font-size: 24px;")
        author_layout.addWidget(author_image)
        
        author_info_layout = QVBoxLayout()
        
        author_name = QLabel("Alex Thompson")
        author_name_font = QFont()
        author_name_font.setBold(True)
        author_name.setFont(author_name_font)
        author_info_layout.addWidget(author_name)
        
        publish_date = QLabel("January 20, 2024")
        author_info_layout.addWidget(publish_date)
        
        read_time = QLabel("12 min read")
        author_info_layout.addWidget(read_time)
        
        author_layout.addLayout(author_info_layout)
        
        featured_layout.addLayout(author_layout)
        
        # GENERIC LINK TEXT - "Read more" without context
        read_more_button = QPushButton("Read more")
        read_more_button.setStyleSheet("QPushButton { background-color: #007bff; color: white; font-weight: bold; }")
        read_more_button.setFixedSize(120, 40)
        read_more_button.clicked.connect(self.on_read_more_clicked)
        featured_layout.addWidget(read_more_button)
        
        main_layout.addWidget(featured_frame)
        
        # Articles section
        articles_label = QLabel("Recent Articles")
        articles_font = QFont()
        articles_font.setPointSize(18)
        articles_font.setBold(True)
        articles_label.setFont(articles_font)
        articles_label.setContentsMargins(20, 20, 20, 10)
        main_layout.addWidget(articles_label)
        
        # Articles scrollable area
        scroll_area = QScrollArea()
        scroll_area.setWidgetResizable(True)
        scroll_area.setVerticalScrollBarPolicy(Qt.ScrollBarAsNeeded)
        
        articles_widget = QWidget()
        articles_layout = QVBoxLayout(articles_widget)
        articles_layout.setSpacing(15)
        articles_layout.setContentsMargins(20, 20, 20, 20)
        
        # Load articles
        self.load_articles(articles_layout)
        
        scroll_area.setWidget(articles_widget)
        main_layout.addWidget(scroll_area)
        
    def load_articles(self, layout):
        articles = [
            {
                "category": "Technology",
                "title": "Understanding Flutter Performance Optimization",
                "content": "Learn how to optimize your Flutter applications for better performance and user experience.",
                "author": "John Smith",
                "date": "2024-01-15",
                "read_time": "15 min",
                "image": "📱"
            },
            {
                "category": "Design",
                "title": "Mobile UI/UX Design Best Practices",
                "content": "Essential design principles for creating intuitive and accessible mobile interfaces.",
                "author": "Sarah Johnson",
                "date": "2024-01-12",
                "read_time": "12 min",
                "image": "🎨"
            },
            {
                "category": "Technology",
                "title": "Cross-Platform Development Strategies",
                "content": "Compare different approaches to building apps that work across multiple platforms.",
                "author": "Mike Chen",
                "date": "2024-01-10",
                "read_time": "18 min",
                "image": "💻"
            },
            {
                "category": "Business",
                "title": "Startup Funding Strategies",
                "content": "Navigate the complex world of startup funding and investment opportunities.",
                "author": "Emily Davis",
                "date": "2024-01-08",
                "read_time": "20 min",
                "image": "💰"
            },
            {
                "category": "Science",
                "title": "Artificial Intelligence in Healthcare",
                "content": "Exploring the latest advances in AI applications for medical diagnosis and treatment.",
                "author": "Dr. Robert Kim",
                "date": "2024-01-05",
                "read_time": "25 min",
                "image": "🤖"
            }
        ]
        
        for article in articles:
            article_frame = self.create_article_card(article)
            layout.addWidget(article_frame)
    
    def create_article_card(self, article):
        # Article frame
        frame = QFrame()
        frame.setFrameStyle(QFrame.Box)
        frame.setStyleSheet("QFrame { background-color: white; border: 1px solid #ddd; }")
        
        main_layout = QHBoxLayout(frame)
        main_layout.setSpacing(15)
        main_layout.setContentsMargins(15, 15, 15, 15)
        
        # Article image
        article_image = QLabel(article["image"])
        article_image.setFixedSize(80, 80)
        article_image.setStyleSheet("font-size: 40px;")
        main_layout.addWidget(article_image)
        
        # Article content
        content_layout = QVBoxLayout()
        
        # Category label
        category_label = QLabel(article["category"])
        category_label.setStyleSheet("color: white; font-weight: bold; background-color: #2196F3; border-radius: 4px; padding: 2px 6px;")
        content_layout.addWidget(category_label)
        
        # Article title
        title_label = QLabel(article["title"])
        title_font = QFont()
        title_font.setPointSize(16)
        title_font.setBold(True)
        title_label.setFont(title_font)
        title_label.setWordWrap(True)
        content_layout.addWidget(title_label)
        
        # Article content
        content_label = QLabel(article["content"])
        content_label.setWordWrap(True)
        content_layout.addWidget(content_label)
        
        # Author and date
        author_date_label = QLabel(f"By {article['author']} • {article['date']}")
        content_layout.addWidget(author_date_label)
        
        main_layout.addLayout(content_layout)
        
        # Actions
        actions_layout = QVBoxLayout()
        actions_layout.setSpacing(10)
        
        # GENERIC LINK TEXT - "Read more" without context
        read_more_button = QPushButton("Read more")
        read_more_button.setStyleSheet("QPushButton { background-color: #007bff; color: white; font-weight: bold; }")
        read_more_button.setFixedSize(100, 30)
        read_more_button.clicked.connect(lambda: self.on_article_read_more_clicked(article))
        actions_layout.addWidget(read_more_button)
        
        share_button = QPushButton("↗️")
        share_button.setFixedSize(30, 30)
        share_button.clicked.connect(lambda: self.on_share_clicked(article))
        actions_layout.addWidget(share_button)
        
        main_layout.addLayout(actions_layout)
        
        return frame
    
    def on_read_more_clicked(self):
        from PyQt5.QtWidgets import QMessageBox
        QMessageBox.information(self, "Read More", "This would open the full article content.")
    
    def on_article_read_more_clicked(self, article):
        from PyQt5.QtWidgets import QMessageBox
        QMessageBox.information(self, article["title"], 
                               f"Category: {article['category']}\n"
                               f"Author: {article['author']}\n"
                               f"Date: {article['date']}\n"
                               f"Read Time: {article['read_time']}\n\n"
                               f"{article['content']}")
    
    def on_share_clicked(self, article):
        from PyQt5.QtWidgets import QMessageBox
        QMessageBox.information(self, "Share Article", f"Share: {article['title']}")

def main():
    app = QApplication(sys.argv)
    window = GenericLinkText()
    window.show()
    sys.exit(app.exec_())

if __name__ == "__main__":
    main()

import sys
from PyQt5.QtWidgets import (QApplication, QMainWindow, QVBoxLayout, QHBoxLayout, 
                             QWidget, QLabel, QPushButton, QFrame, QLineEdit, QComboBox)
from PyQt5.QtCore import Qt
from PyQt5.QtGui import QFont

class MissingLanguageAttribute(QMainWindow):
    def __init__(self):
        super().__init__()
        self.setWindowTitle("Welcome")
        self.setGeometry(100, 100, 800, 600)
        
        # Central widget
        central_widget = QWidget()
        self.setCentralWidget(central_widget)
        
        # Main layout
        main_layout = QVBoxLayout(central_widget)
        main_layout.setSpacing(20)
        main_layout.setContentsMargins(20, 20, 20, 20)
        
        # Welcome section
        welcome_layout = QVBoxLayout()
        welcome_layout.setAlignment(Qt.AlignCenter)
        
        # Welcome icon
        welcome_icon = QLabel("🌐")
        welcome_icon.setAlignment(Qt.AlignCenter)
        welcome_icon.setStyleSheet("font-size: 48px;")
        welcome_layout.addWidget(welcome_icon)
        
        # Welcome Text - Mixed English/French without lang attributes
        welcome_label = QLabel("Welcome to our app! Bienvenue dans notre application!")
        welcome_font = QFont()
        welcome_font.setPointSize(20)
        welcome_font.setBold(True)
        welcome_label.setFont(welcome_font)
        welcome_label.setAlignment(Qt.AlignCenter)
        welcome_label.setWordWrap(True)
        welcome_layout.addWidget(welcome_label)
        
        subtitle_label = QLabel("Please sign in to continue. Veuillez vous connecter pour continuer.")
        subtitle_font = QFont()
        subtitle_font.setPointSize(16)
        subtitle_label.setFont(subtitle_font)
        subtitle_label.setAlignment(Qt.AlignCenter)
        subtitle_label.setWordWrap(True)
        welcome_layout.addWidget(subtitle_label)
        
        main_layout.addLayout(welcome_layout)
        
        # Language selection
        language_layout = QVBoxLayout()
        language_layout.setAlignment(Qt.AlignCenter)
        
        language_label = QLabel("Select Language / Choisir la langue:")
        language_font = QFont()
        language_font.setPointSize(16)
        language_font.setBold(True)
        language_label.setFont(language_font)
        language_label.setAlignment(Qt.AlignCenter)
        language_layout.addWidget(language_label)
        
        # Language combo box
        self.language_combo = QComboBox()
        languages = [
            "🇺🇸 English",
            "🇫🇷 Français", 
            "🇪🇸 Español",
            "🇩🇪 Deutsch",
            "🇮🇹 Italiano",
            "🇵🇹 Português"
        ]
        
        for lang in languages:
            self.language_combo.addItem(lang)
        
        self.language_combo.setCurrentIndex(0)
        self.language_combo.currentTextChanged.connect(self.on_language_changed)
        language_layout.addWidget(self.language_combo)
        
        main_layout.addLayout(language_layout)
        
        # Login form
        login_frame = QFrame()
        login_frame.setFrameStyle(QFrame.Box)
        login_frame.setStyleSheet("QFrame { background-color: #f8f9fa; }")
        
        login_layout = QVBoxLayout(login_frame)
        login_layout.setSpacing(15)
        login_layout.setContentsMargins(30, 30, 30, 30)
        
        # Login title
        login_title = QLabel("Login Form")
        login_title_font = QFont()
        login_title_font.setPointSize(18)
        login_title_font.setBold(True)
        login_title.setFont(login_title_font)
        login_title.setAlignment(Qt.AlignCenter)
        login_layout.addWidget(login_title)
        
        # Email field
        email_layout = QVBoxLayout()
        email_label = QLabel("Email / Courriel")
        email_label_font = QFont()
        email_label_font.setPointSize(16)
        email_label_font.setBold(True)
        email_label.setFont(email_label_font)
        email_layout.addWidget(email_label)
        
        self.email_entry = QLineEdit()
        self.email_entry.setPlaceholderText("Enter your email")
        self.email_entry.setFixedHeight(35)
        email_layout.addWidget(self.email_entry)
        
        login_layout.addLayout(email_layout)
        
        # Password field
        password_layout = QVBoxLayout()
        password_label = QLabel("Password / Mot de passe")
        password_label_font = QFont()
        password_label_font.setPointSize(16)
        password_label_font.setBold(True)
        password_label.setFont(password_label_font)
        password_layout.addWidget(password_label)
        
        self.password_entry = QLineEdit()
        self.password_entry.setPlaceholderText("Enter your password")
        self.password_entry.setEchoMode(QLineEdit.Password)
        self.password_entry.setFixedHeight(35)
        password_layout.addWidget(self.password_entry)
        
        login_layout.addLayout(password_layout)
        
        # Action buttons
        button_layout = QHBoxLayout()
        button_layout.setAlignment(Qt.AlignCenter)
        button_layout.setSpacing(15)
        
        sign_in_button = QPushButton("Sign In / Se connecter")
        sign_in_button.setStyleSheet("QPushButton { background-color: #007bff; color: white; font-weight: bold; }")
        sign_in_button.setFixedSize(150, 40)
        sign_in_button.clicked.connect(self.on_sign_in_clicked)
        button_layout.addWidget(sign_in_button)
        
        forgot_password_button = QPushButton("Forgot Password? / Mot de passe oublié?")
        forgot_password_button.setFixedSize(200, 40)
        forgot_password_button.clicked.connect(self.on_forgot_password_clicked)
        button_layout.addWidget(forgot_password_button)
        
        login_layout.addLayout(button_layout)
        
        main_layout.addWidget(login_frame)
        
        # Store current language
        self.current_language = "English"
        
    def on_language_changed(self, text):
        # Extract language name from display text
        if "English" in text:
            self.current_language = "English"
        elif "Français" in text:
            self.current_language = "Français"
        elif "Español" in text:
            self.current_language = "Español"
        elif "Deutsch" in text:
            self.current_language = "Deutsch"
        elif "Italiano" in text:
            self.current_language = "Italiano"
        elif "Português" in text:
            self.current_language = "Português"
        
        # Update UI based on selected language
        if self.current_language == "English":
            self.update_ui_english()
        elif self.current_language == "Français":
            self.update_ui_french()
        elif self.current_language == "Español":
            self.update_ui_spanish()
        elif self.current_language == "Deutsch":
            self.update_ui_german()
        elif self.current_language == "Italiano":
            self.update_ui_italian()
        elif self.current_language == "Português":
            self.update_ui_portuguese()
    
    def update_ui_english(self):
        # Update welcome text
        welcome_label = self.findChild(QLabel)
        if welcome_label and "Welcome" in welcome_label.text():
            welcome_label.setText("Welcome to our app!")
        
        subtitle_label = self.findChildren(QLabel)[1]
        if subtitle_label and "Please sign in" in subtitle_label.text():
            subtitle_label.setText("Please sign in to continue.")
        
        language_label = self.findChildren(QLabel)[2]
        if language_label and "Select Language" in language_label.text():
            language_label.setText("Select Language:")
    
    def update_ui_french(self):
        # Update welcome text
        welcome_label = self.findChild(QLabel)
        if welcome_label and "Welcome" in welcome_label.text():
            welcome_label.setText("Bienvenue dans notre application!")
        
        subtitle_label = self.findChildren(QLabel)[1]
        if subtitle_label and "Please sign in" in subtitle_label.text():
            subtitle_label.setText("Veuillez vous connecter pour continuer.")
        
        language_label = self.findChildren(QLabel)[2]
        if language_label and "Select Language" in language_label.text():
            language_label.setText("Choisir la langue:")
    
    def update_ui_spanish(self):
        # Update welcome text
        welcome_label = self.findChild(QLabel)
        if welcome_label and "Welcome" in welcome_label.text():
            welcome_label.setText("¡Bienvenido a nuestra aplicación!")
        
        subtitle_label = self.findChildren(QLabel)[1]
        if subtitle_label and "Please sign in" in subtitle_label.text():
            subtitle_label.setText("Por favor, inicie sesión para continuar.")
        
        language_label = self.findChildren(QLabel)[2]
        if language_label and "Select Language" in language_label.text():
            language_label.setText("Seleccionar idioma:")
    
    def update_ui_german(self):
        # Update welcome text
        welcome_label = self.findChild(QLabel)
        if welcome_label and "Welcome" in welcome_label.text():
            welcome_label.setText("Willkommen in unserer App!")
        
        subtitle_label = self.findChildren(QLabel)[1]
        if subtitle_label and "Please sign in" in subtitle_label.text():
            subtitle_label.setText("Bitte melden Sie sich an, um fortzufahren.")
        
        language_label = self.findChildren(QLabel)[2]
        if language_label and "Select Language" in language_label.text():
            language_label.setText("Sprache auswählen:")
    
    def update_ui_italian(self):
        # Update welcome text
        welcome_label = self.findChild(QLabel)
        if welcome_label and "Welcome" in welcome_label.text():
            welcome_label.setText("Benvenuto nella nostra app!")
        
        subtitle_label = self.findChildren(QLabel)[1]
        if subtitle_label and "Please sign in" in subtitle_label.text():
            subtitle_label.setText("Accedi per continuare.")
        
        language_label = self.findChildren(QLabel)[2]
        if language_label and "Select Language" in language_label.text():
            language_label.setText("Seleziona lingua:")
    
    def update_ui_portuguese(self):
        # Update welcome text
        welcome_label = self.findChild(QLabel)
        if welcome_label and "Welcome" in welcome_label.text():
            welcome_label.setText("Bem-vindo ao nosso aplicativo!")
        
        subtitle_label = self.findChildren(QLabel)[1]
        if subtitle_label and "Please sign in" in subtitle_label.text():
            subtitle_label.setText("Faça login para continuar.")
        
        language_label = self.findChildren(QLabel)[2]
        if language_label and "Select Language" in language_label.text():
            language_label.setText("Selecionar idioma:")
    
    def on_sign_in_clicked(self):
        from PyQt5.QtWidgets import QMessageBox
        QMessageBox.information(self, "Sign In / Se connecter", 
                               "Sign in functionality would be implemented here / La fonctionnalité de connexion serait implémentée ici")
    
    def on_forgot_password_clicked(self):
        from PyQt5.QtWidgets import QMessageBox
        QMessageBox.information(self, "Forgot Password / Mot de passe oublié", 
                               "Password reset functionality would be implemented here / La fonctionnalité de réinitialisation du mot de passe serait implémentée ici")

def main():
    app = QApplication(sys.argv)
    window = MissingLanguageAttribute()
    window.show()
    sys.exit(app.exec_())

if __name__ == "__main__":
    main()

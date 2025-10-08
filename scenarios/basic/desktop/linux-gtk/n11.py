import gi
gi.require_version('Gtk', '3.0')
from gi.repository import Gtk, GObject, GLib

class MissingLanguageAttribute(Gtk.Window):
    def __init__(self):
        Gtk.Window.__init__(self, title="Welcome")
        self.set_default_size(800, 600)
        self.set_border_width(20)
        
        # Main container
        main_box = Gtk.VBox(spacing=20)
        self.add(main_box)
        
        # Welcome section
        welcome_box = Gtk.VBox(spacing=15)
        welcome_box.set_halign(Gtk.Align.CENTER)
        
        # Welcome icon
        welcome_icon = Gtk.Label("🌐")
        welcome_icon.set_markup("<span size='xx-large'>🌐</span>")
        welcome_box.pack_start(welcome_icon, False, False, 0)
        
        # Welcome Text - Mixed English/French without lang attributes
        welcome_label = Gtk.Label()
        welcome_label.set_markup("<span size='xx-large' weight='bold'>Welcome to our app! Bienvenue dans notre application!</span>")
        welcome_label.set_line_wrap(True)
        welcome_label.set_halign(Gtk.Align.CENTER)
        welcome_box.pack_start(welcome_label, False, False, 0)
        
        subtitle_label = Gtk.Label()
        subtitle_label.set_markup("<span size='large'>Please sign in to continue. Veuillez vous connecter pour continuer.</span>")
        subtitle_label.set_line_wrap(True)
        subtitle_label.set_halign(Gtk.Align.CENTER)
        welcome_box.pack_start(subtitle_label, False, False, 0)
        
        main_box.pack_start(welcome_box, False, False, 0)
        
        # Language selection
        language_box = Gtk.VBox(spacing=10)
        language_box.set_halign(Gtk.Align.CENTER)
        
        language_label = Gtk.Label()
        language_label.set_markup("<span weight='bold' size='large'>Select Language / Choisir la langue:</span>")
        language_label.set_halign(Gtk.Align.CENTER)
        language_box.pack_start(language_label, False, False, 0)
        
        # Language combo box
        self.language_combo = Gtk.ComboBoxText()
        languages = [
            ("🇺🇸 English", "English"),
            ("🇫🇷 Français", "Français"),
            ("🇪🇸 Español", "Español"),
            ("🇩🇪 Deutsch", "Deutsch"),
            ("🇮🇹 Italiano", "Italiano"),
            ("🇵🇹 Português", "Português")
        ]
        
        for display, value in languages:
            self.language_combo.append_text(display)
        
        self.language_combo.set_active(0)
        self.language_combo.connect("changed", self.on_language_changed)
        language_box.pack_start(self.language_combo, False, False, 0)
        
        main_box.pack_start(language_box, False, False, 0)
        
        # Login form
        login_frame = Gtk.Frame()
        login_frame.set_shadow_type(Gtk.ShadowType.ETCHED_IN)
        
        login_box = Gtk.VBox(spacing=15)
        login_box.set_margin_left(30)
        login_box.set_margin_right(30)
        login_box.set_margin_top(30)
        login_box.set_margin_bottom(30)
        
        # Login title
        login_title = Gtk.Label()
        login_title.set_markup("<span size='x-large' weight='bold'>Login Form</span>")
        login_title.set_halign(Gtk.Align.CENTER)
        login_box.pack_start(login_title, False, False, 0)
        
        # Email field
        email_box = Gtk.VBox(spacing=5)
        email_label = Gtk.Label()
        email_label.set_markup("<span weight='bold' size='large'>Email / Courriel</span>")
        email_label.set_halign(Gtk.Align.START)
        email_box.pack_start(email_label, False, False, 0)
        
        self.email_entry = Gtk.Entry()
        self.email_entry.set_placeholder_text("Enter your email")
        email_box.pack_start(self.email_entry, False, False, 0)
        
        login_box.pack_start(email_box, False, False, 0)
        
        # Password field
        password_box = Gtk.VBox(spacing=5)
        password_label = Gtk.Label()
        password_label.set_markup("<span weight='bold' size='large'>Password / Mot de passe</span>")
        password_label.set_halign(Gtk.Align.START)
        password_box.pack_start(password_label, False, False, 0)
        
        self.password_entry = Gtk.Entry()
        self.password_entry.set_placeholder_text("Enter your password")
        self.password_entry.set_visibility(False)
        password_box.pack_start(self.password_entry, False, False, 0)
        
        login_box.pack_start(password_box, False, False, 0)
        
        # Action buttons
        button_box = Gtk.HBox(spacing=15)
        button_box.set_halign(Gtk.Align.CENTER)
        
        sign_in_button = Gtk.Button("Sign In / Se connecter")
        sign_in_button.get_style_context().add_class("suggested-action")
        sign_in_button.connect("clicked", self.on_sign_in_clicked)
        button_box.pack_start(sign_in_button, False, False, 0)
        
        forgot_password_button = Gtk.Button("Forgot Password? / Mot de passe oublié?")
        forgot_password_button.connect("clicked", self.on_forgot_password_clicked)
        button_box.pack_start(forgot_password_button, False, False, 0)
        
        login_box.pack_start(button_box, False, False, 0)
        
        login_frame.add(login_box)
        main_box.pack_start(login_frame, False, False, 0)
        
        # Store current language
        self.current_language = "English"
        
    def on_language_changed(self, combo):
        active_id = combo.get_active()
        languages = ["English", "Français", "Español", "Deutsch", "Italiano", "Português"]
        self.current_language = languages[active_id]
        
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
        welcome_label = self.get_children()[0].get_children()[0].get_children()[1]
        welcome_label.set_markup("<span size='xx-large' weight='bold'>Welcome to our app!</span>")
        
        subtitle_label = self.get_children()[0].get_children()[0].get_children()[2]
        subtitle_label.set_markup("<span size='large'>Please sign in to continue.</span>")
        
        language_label = self.get_children()[0].get_children()[1].get_children()[0]
        language_label.set_markup("<span weight='bold' size='large'>Select Language:</span>")
    
    def update_ui_french(self):
        # Update welcome text
        welcome_label = self.get_children()[0].get_children()[0].get_children()[1]
        welcome_label.set_markup("<span size='xx-large' weight='bold'>Bienvenue dans notre application!</span>")
        
        subtitle_label = self.get_children()[0].get_children()[0].get_children()[2]
        subtitle_label.set_markup("<span size='large'>Veuillez vous connecter pour continuer.</span>")
        
        language_label = self.get_children()[0].get_children()[1].get_children()[0]
        language_label.set_markup("<span weight='bold' size='large'>Choisir la langue:</span>")
    
    def update_ui_spanish(self):
        # Update welcome text
        welcome_label = self.get_children()[0].get_children()[0].get_children()[1]
        welcome_label.set_markup("<span size='xx-large' weight='bold'>¡Bienvenido a nuestra aplicación!</span>")
        
        subtitle_label = self.get_children()[0].get_children()[0].get_children()[2]
        subtitle_label.set_markup("<span size='large'>Por favor, inicie sesión para continuar.</span>")
        
        language_label = self.get_children()[0].get_children()[1].get_children()[0]
        language_label.set_markup("<span weight='bold' size='large'>Seleccionar idioma:</span>")
    
    def update_ui_german(self):
        # Update welcome text
        welcome_label = self.get_children()[0].get_children()[0].get_children()[1]
        welcome_label.set_markup("<span size='xx-large' weight='bold'>Willkommen in unserer App!</span>")
        
        subtitle_label = self.get_children()[0].get_children()[0].get_children()[2]
        subtitle_label.set_markup("<span size='large'>Bitte melden Sie sich an, um fortzufahren.</span>")
        
        language_label = self.get_children()[0].get_children()[1].get_children()[0]
        language_label.set_markup("<span weight='bold' size='large'>Sprache auswählen:</span>")
    
    def update_ui_italian(self):
        # Update welcome text
        welcome_label = self.get_children()[0].get_children()[0].get_children()[1]
        welcome_label.set_markup("<span size='xx-large' weight='bold'>Benvenuto nella nostra app!</span>")
        
        subtitle_label = self.get_children()[0].get_children()[0].get_children()[2]
        subtitle_label.set_markup("<span size='large'>Accedi per continuare.</span>")
        
        language_label = self.get_children()[0].get_children()[1].get_children()[0]
        language_label.set_markup("<span weight='bold' size='large'>Seleziona lingua:</span>")
    
    def update_ui_portuguese(self):
        # Update welcome text
        welcome_label = self.get_children()[0].get_children()[0].get_children()[1]
        welcome_label.set_markup("<span size='xx-large' weight='bold'>Bem-vindo ao nosso aplicativo!</span>")
        
        subtitle_label = self.get_children()[0].get_children()[0].get_children()[2]
        subtitle_label.set_markup("<span size='large'>Faça login para continuar.</span>")
        
        language_label = self.get_children()[0].get_children()[1].get_children()[0]
        language_label.set_markup("<span weight='bold' size='large'>Selecionar idioma:</span>")
    
    def on_sign_in_clicked(self, button):
        dialog = Gtk.MessageDialog(
            transient_for=self,
            flags=0,
            message_type=Gtk.MessageType.INFO,
            buttons=Gtk.ButtonsType.OK,
            text="Sign In / Se connecter"
        )
        dialog.format_secondary_text("Sign in functionality would be implemented here / La fonctionnalité de connexion serait implémentée ici")
        dialog.run()
        dialog.destroy()
    
    def on_forgot_password_clicked(self, button):
        dialog = Gtk.MessageDialog(
            transient_for=self,
            flags=0,
            message_type=Gtk.MessageType.INFO,
            buttons=Gtk.ButtonsType.OK,
            text="Forgot Password / Mot de passe oublié"
        )
        dialog.format_secondary_text("Password reset functionality would be implemented here / La fonctionnalité de réinitialisation du mot de passe serait implémentée ici")
        dialog.run()
        dialog.destroy()

def main():
    win = MissingLanguageAttribute()
    win.connect("destroy", Gtk.main_quit)
    win.show_all()
    Gtk.main()

if __name__ == "__main__":
    main()

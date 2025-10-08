import Cocoa
import WebKit

class MissingLanguageAttribute: NSViewController {
    
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var languagePopUpButton: NSPopUpButton!
    @IBOutlet weak var welcomeLabel: NSTextField!
    @IBOutlet weak var subtitleLabel: NSTextField!
    @IBOutlet weak var languageLabel: NSTextField!
    @IBOutlet weak var emailField: NSTextField!
    @IBOutlet weak var passwordField: NSSecureTextField!
    @IBOutlet weak var signInButton: NSButton!
    @IBOutlet weak var forgotPasswordButton: NSButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadWebContent()
    }
    
    private func setupUI() {
        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor.controlBackgroundColor.cgColor
        
        // Welcome Text - Mixed English/French without lang attributes
        welcomeLabel.stringValue = "Welcome to our app! Bienvenue dans notre application!"
        welcomeLabel.font = NSFont.systemFont(ofSize: 24, weight: .bold)
        welcomeLabel.alignment = .center
        
        subtitleLabel.stringValue = "Please sign in to continue. Veuillez vous connecter pour continuer."
        subtitleLabel.font = NSFont.systemFont(ofSize: 18)
        subtitleLabel.textColor = .secondaryLabelColor
        subtitleLabel.alignment = .center
        
        // Language Selection
        languageLabel.stringValue = "Select Language / Choisir la langue:"
        languageLabel.font = NSFont.boldSystemFont(ofSize: 16)
        
        languagePopUpButton.removeAllItems()
        languagePopUpButton.addItems(withTitles: [
            "🇺🇸 English",
            "🇫🇷 Français", 
            "🇪🇸 Español",
            "🇩🇪 Deutsch",
            "🇮🇹 Italiano",
            "🇵🇹 Português"
        ])
        languagePopUpButton.target = self
        languagePopUpButton.action = #selector(languageChanged)
        
        // Login Form
        emailField.placeholderString = "Enter your email"
        emailField.font = NSFont.systemFont(ofSize: 16)
        
        passwordField.placeholderString = "Enter your password"
        passwordField.font = NSFont.systemFont(ofSize: 16)
        
        signInButton.title = "Sign In / Se connecter"
        signInButton.bezelStyle = .rounded
        signInButton.target = self
        signInButton.action = #selector(signInTapped)
        
        forgotPasswordButton.title = "Forgot Password? / Mot de passe oublié?"
        forgotPasswordButton.bezelStyle = .texturedRounded
        forgotPasswordButton.target = self
        forgotPasswordButton.action = #selector(forgotPasswordTapped)
    }
    
    private func loadWebContent() {NGUAGE ATTRIBUTE - HTML page with mixed English/French content without lang attributes
        let htmlContent = """
        <!DOCTYPE html>
        <html>
        <head>
            <meta charset="UTF-8">
            <title>Welcome / Bienvenue</title>
            <style>
                body {
                    font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
                    margin: 0;
                    padding: 20px;
                    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                    color: white;
                    min-height: 100vh;
                }
                .container {
                    max-width: 800px;
                    margin: 0 auto;
                    text-align: center;
                }
                h1 {
                    font-size: 3em;
                    margin-bottom: 20px;
                }
                p {
                    font-size: 1.2em;
                    margin-bottom: 30px;
                    opacity: 0.9;
                }
                .features {
                    display: grid;
                    grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
                    gap: 20px;
                    margin-top: 40px;
                }
                .feature {
                    background: rgba(255, 255, 255, 0.1);
                    padding: 20px;
                    border-radius: 10px;
                    backdrop-filter: blur(10px);
                }
                .feature h3 {
                    margin-top: 0;
                    font-size: 1.3em;
                }
                .cta-button {
                    background: #ff6b6b;
                    color: white;
                    padding: 15px 30px;
                    border: none;
                    border-radius: 25px;
                    font-size: 1.1em;
                    cursor: pointer;
                    margin-top: 30px;
                    transition: all 0.3s ease;
                }
                .cta-button:hover {
                    background: #ff5252;
                    transform: translateY(-2px);
                }
            </style>
        </head>
        <body>
            <div class="container">
                <h1>Welcome to Our Platform / Bienvenue sur notre plateforme</h1>
                <p>Discover amazing features and services / Découvrez des fonctionnalités et services incroyables</p>
                
                <div class="features">
                    <div class="feature">
                        <h3>🚀 Fast Performance / Performance rapide</h3>
                        <p>Lightning-fast loading times / Temps de chargement ultra-rapides</p>
                    </div>
                    <div class="feature">
                        <h3>🔒 Secure / Sécurisé</h3>
                        <p>Your data is safe with us / Vos données sont en sécurité avec nous</p>
                    </div>
                    <div class="feature">
                        <h3>💡 Innovative / Innovant</h3>
                        <p>Cutting-edge technology / Technologie de pointe</p>
                    </div>
                </div>
                
                <button class="cta-button" onclick="alert('Get Started / Commencer')">
                    Get Started / Commencer
                </button>
            </div>
        </body>
        </html>
        """
        
        webView.loadHTMLString(htmlContent, baseURL: nil)
    }
    
    @objc private func languageChanged() {
        let selectedLanguage = languagePopUpButton.selectedItem?.title ?? "English"
        
        switch selectedLanguage {
        case "🇺🇸 English":
            welcomeLabel.stringValue = "Welcome to our app!"
            subtitleLabel.stringValue = "Please sign in to continue."
            languageLabel.stringValue = "Select Language:"
            signInButton.title = "Sign In"
            forgotPasswordButton.title = "Forgot Password?"
        case "🇫🇷 Français":
            welcomeLabel.stringValue = "Bienvenue dans notre application!"
            subtitleLabel.stringValue = "Veuillez vous connecter pour continuer."
            languageLabel.stringValue = "Choisir la langue:"
            signInButton.title = "Se connecter"
            forgotPasswordButton.title = "Mot de passe oublié?"
        case "🇪🇸 Español":
            welcomeLabel.stringValue = "¡Bienvenido a nuestra aplicación!"
            subtitleLabel.stringValue = "Por favor, inicie sesión para continuar."
            languageLabel.stringValue = "Seleccionar idioma:"
            signInButton.title = "Iniciar sesión"
            forgotPasswordButton.title = "¿Olvidaste tu contraseña?"
        case "🇩🇪 Deutsch":
            welcomeLabel.stringValue = "Willkommen in unserer App!"
            subtitleLabel.stringValue = "Bitte melden Sie sich an, um fortzufahren."
            languageLabel.stringValue = "Sprache auswählen:"
            signInButton.title = "Anmelden"
            forgotPasswordButton.title = "Passwort vergessen?"
        case "🇮🇹 Italiano":
            welcomeLabel.stringValue = "Benvenuto nella nostra app!"
            subtitleLabel.stringValue = "Accedi per continuare."
            languageLabel.stringValue = "Seleziona lingua:"
            signInButton.title = "Accedi"
            forgotPasswordButton.title = "Password dimenticata?"
        case "🇵🇹 Português":
            welcomeLabel.stringValue = "Bem-vindo ao nosso aplicativo!"
            subtitleLabel.stringValue = "Faça login para continuar."
            languageLabel.stringValue = "Selecionar idioma:"
            signInButton.title = "Entrar"
            forgotPasswordButton.title = "Esqueceu a senha?"
        default:
            break
        }
    }
    
    @objc private func signInTapped() {
        // Handle sign in
        let alert = NSAlert()
        alert.messageText = "Sign In / Se connecter"
        alert.informativeText = "Sign in functionality would be implemented here / La fonctionnalité de connexion serait implémentée ici"
        alert.addButton(withTitle: "OK")
        alert.runModal()
    }
    
    @objc private func forgotPasswordTapped() {
        // Handle forgot password
        let alert = NSAlert()
        alert.messageText = "Forgot Password / Mot de passe oublié"
        alert.informativeText = "Password reset functionality would be implemented here / La fonctionnalité de réinitialisation du mot de passe serait implémentée ici"
        alert.addButton(withTitle: "OK")
        alert.runModal()
    }
}

// MARK: - Storyboard Support
extension MissingLanguageAttribute {
    static func instantiate() -> MissingLanguageAttribute {
        let storyboard = NSStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateController(withIdentifier: "MissingLanguageAttribute") as! MissingLanguageAttribute
    }
}

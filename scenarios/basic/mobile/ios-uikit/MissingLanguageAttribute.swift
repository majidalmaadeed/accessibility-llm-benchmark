import UIKit
import WebKit

class MissingLanguageAttributeViewController: UIViewController {
    
    private var webView: WKWebView!
    private var segmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadContent()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "Multilingual Content"
        
        // Language selector
        segmentedControl = UISegmentedControl(items: ["English", "Français", "Español"])
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(languageChanged), for: .valueChanged)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(segmentedControl)
        
        // Web view configuration
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.navigationDelegate = self
        webView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(webView)
        
        // Constraints
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            webView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 16),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func loadContent() {
        let selectedLanguage = segmentedControl.selectedSegmentIndex
        let htmlContent = generateHTMLContent(for: selectedLanguage)
        webView.loadHTMLString(htmlContent, baseURL: nil)
    }
    
    private func generateHTMLContent(for languageIndex: Int) -> String {
        switch languageIndex {
        case 0: // English
            return """
            <!DOCTYPE html>
            <html>
            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Welcome to Our Service</title>
                <style>
                    body { font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif; margin: 20px; line-height: 1.6; }
                    .header { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; padding: 30px; border-radius: 10px; margin-bottom: 20px; }
                    .content { background: #f8f9fa; padding: 20px; border-radius: 8px; margin-bottom: 20px; }
                    .feature { background: white; padding: 15px; margin: 10px 0; border-radius: 5px; box-shadow: 0 2px 4px rgba(0,0,0,0.1); }
                    .button { background: #007bff; color: white; padding: 12px 24px; border: none; border-radius: 5px; cursor: pointer; font-size: 16px; }
                    .button:hover { background: #0056b3; }
                    .warning { background: #fff3cd; border: 1px solid #ffeaa7; color: #856404; padding: 15px; border-radius: 5px; margin: 15px 0; }
                    .success { background: #d4edda; border: 1px solid #c3e6cb; color: #155724; padding: 15px; border-radius: 5px; margin: 15px 0; }
                </style>
            </head>
            <body>
                <div class="header">
                    <h1>Welcome to Our Service</h1>
                    <p>Your trusted partner for digital solutions</p>
                </div>
                
                <div class="content">
                    <h2>About Our Company</h2>
                    <p>We are a leading technology company specializing in innovative solutions for businesses worldwide. Our team of experts is dedicated to delivering exceptional results that drive growth and success.</p>
                    
                    <div class="feature">
                        <h3>🚀 Fast Performance</h3>
                        <p>Our platform delivers lightning-fast performance with 99.9% uptime guarantee.</p>
                    </div>
                    
                    <div class="feature">
                        <h3>🔒 Secure & Reliable</h3>
                        <p>Enterprise-grade security with end-to-end encryption and compliance with international standards.</p>
                    </div>
                    
                    <div class="feature">
                        <h3>📱 Mobile Ready</h3>
                        <p>Fully responsive design that works perfectly on all devices and screen sizes.</p>
                    </div>
                    
                    <div class="warning">
                        <strong>Important Notice:</strong> Please ensure you have completed all required fields before submitting your application. Incomplete applications will not be processed.
                    </div>
                    
                    <div class="success">
                        <strong>Success!</strong> Your account has been created successfully. You can now access all premium features.
                    </div>
                    
                    <h2>Get Started Today</h2>
                    <p>Join thousands of satisfied customers who trust our platform for their business needs.</p>
                    <button class="button" onclick="alert('Thank you for your interest!')">Start Free Trial</button>
                </div>
                
                <div class="content">
                    <h2>Contact Information</h2>
                    <p><strong>Email:</strong> contact@company.com</p>
                    <p><strong>Phone:</strong> +1 (555) 123-4567</p>
                    <p><strong>Address:</strong> 123 Business Street, Suite 100, City, State 12345</p>
                </div>
            </body>
            </html>
            """
        case 1: // French
            return """
            <!DOCTYPE html>
            <html>
            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Bienvenue dans Notre Service</title>
                <style>
                    body { font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif; margin: 20px; line-height: 1.6; }
                    .header { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; padding: 30px; border-radius: 10px; margin-bottom: 20px; }
                    .content { background: #f8f9fa; padding: 20px; border-radius: 8px; margin-bottom: 20px; }
                    .feature { background: white; padding: 15px; margin: 10px 0; border-radius: 5px; box-shadow: 0 2px 4px rgba(0,0,0,0.1); }
                    .button { background: #007bff; color: white; padding: 12px 24px; border: none; border-radius: 5px; cursor: pointer; font-size: 16px; }
                    .button:hover { background: #0056b3; }
                    .warning { background: #fff3cd; border: 1px solid #ffeaa7; color: #856404; padding: 15px; border-radius: 5px; margin: 15px 0; }
                    .success { background: #d4edda; border: 1px solid #c3e6cb; color: #155724; padding: 15px; border-radius: 5px; margin: 15px 0; }
                </style>
            </head>
            <body>
                <div class="header">
                    <h1>Bienvenue dans Notre Service</h1>
                    <p>Votre partenaire de confiance pour les solutions numériques</p>
                </div>
                
                <div class="content">
                    <h2>À Propos de Notre Entreprise</h2>
                    <p>Nous sommes une entreprise technologique leader spécialisée dans les solutions innovantes pour les entreprises du monde entier. Notre équipe d'experts se consacre à fournir des résultats exceptionnels qui stimulent la croissance et le succès.</p>
                    
                    <div class="feature">
                        <h3>🚀 Performance Rapide</h3>
                        <p>Notre plateforme offre des performances ultra-rapides avec une garantie de disponibilité de 99,9%.</p>
                    </div>
                    
                    <div class="feature">
                        <h3>🔒 Sécurisé et Fiable</h3>
                        <p>Sécurité de niveau entreprise avec chiffrement de bout en bout et conformité aux normes internationales.</p>
                    </div>
                    
                    <div class="feature">
                        <h3>📱 Prêt pour Mobile</h3>
                        <p>Design entièrement responsive qui fonctionne parfaitement sur tous les appareils et tailles d'écran.</p>
                    </div>
                    
                    <div class="warning">
                        <strong>Avis Important :</strong> Veuillez vous assurer d'avoir rempli tous les champs requis avant de soumettre votre candidature. Les candidatures incomplètes ne seront pas traitées.
                    </div>
                    
                    <div class="success">
                        <strong>Succès !</strong> Votre compte a été créé avec succès. Vous pouvez maintenant accéder à toutes les fonctionnalités premium.
                    </div>
                    
                    <h2>Commencez Aujourd'hui</h2>
                    <p>Rejoignez des milliers de clients satisfaits qui font confiance à notre plateforme pour leurs besoins commerciaux.</p>
                    <button class="button" onclick="alert('Merci pour votre intérêt !')">Commencer l'Essai Gratuit</button>
                </div>
                
                <div class="content">
                    <h2>Informations de Contact</h2>
                    <p><strong>Email :</strong> contact@company.com</p>
                    <p><strong>Téléphone :</strong> +1 (555) 123-4567</p>
                    <p><strong>Adresse :</strong> 123 Business Street, Suite 100, City, State 12345</p>
                </div>
            </body>
            </html>
            """
        case 2: // Spanish
            return """
            <!DOCTYPE html>
            <html>
            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Bienvenido a Nuestro Servicio</title>
                <style>
                    body { font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif; margin: 20px; line-height: 1.6; }
                    .header { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; padding: 30px; border-radius: 10px; margin-bottom: 20px; }
                    .content { background: #f8f9fa; padding: 20px; border-radius: 8px; margin-bottom: 20px; }
                    .feature { background: white; padding: 15px; margin: 10px 0; border-radius: 5px; box-shadow: 0 2px 4px rgba(0,0,0,0.1); }
                    .button { background: #007bff; color: white; padding: 12px 24px; border: none; border-radius: 5px; cursor: pointer; font-size: 16px; }
                    .button:hover { background: #0056b3; }
                    .warning { background: #fff3cd; border: 1px solid #ffeaa7; color: #856404; padding: 15px; border-radius: 5px; margin: 15px 0; }
                    .success { background: #d4edda; border: 1px solid #c3e6cb; color: #155724; padding: 15px; border-radius: 5px; margin: 15px 0; }
                </style>
            </head>
            <body>
                <div class="header">
                    <h1>Bienvenido a Nuestro Servicio</h1>
                    <p>Su socio de confianza para soluciones digitales</p>
                </div>
                
                <div class="content">
                    <h2>Acerca de Nuestra Empresa</h2>
                    <p>Somos una empresa tecnológica líder especializada en soluciones innovadoras para empresas de todo el mundo. Nuestro equipo de expertos se dedica a entregar resultados excepcionales que impulsan el crecimiento y el éxito.</p>
                    
                    <div class="feature">
                        <h3>🚀 Rendimiento Rápido</h3>
                        <p>Nuestra plataforma ofrece un rendimiento ultrarrápido con una garantía de tiempo de actividad del 99.9%.</p>
                    </div>
                    
                    <div class="feature">
                        <h3>🔒 Seguro y Confiable</h3>
                        <p>Seguridad de nivel empresarial con cifrado de extremo a extremo y cumplimiento de estándares internacionales.</p>
                    </div>
                    
                    <div class="feature">
                        <h3>📱 Listo para Móvil</h3>
                        <p>Diseño completamente responsivo que funciona perfectamente en todos los dispositivos y tamaños de pantalla.</p>
                    </div>
                    
                    <div class="warning">
                        <strong>Aviso Importante:</strong> Por favor, asegúrese de haber completado todos los campos requeridos antes de enviar su solicitud. Las solicitudes incompletas no serán procesadas.
                    </div>
                    
                    <div class="success">
                        <strong>¡Éxito!</strong> Su cuenta ha sido creada exitosamente. Ahora puede acceder a todas las funciones premium.
                    </div>
                    
                    <h2>Comience Hoy</h2>
                    <p>Únase a miles de clientes satisfechos que confían en nuestra plataforma para sus necesidades comerciales.</p>
                    <button class="button" onclick="alert('¡Gracias por su interés!')">Comenzar Prueba Gratuita</button>
                </div>
                
                <div class="content">
                    <h2>Información de Contacto</h2>
                    <p><strong>Email:</strong> contact@company.com</p>
                    <p><strong>Teléfono:</strong> +1 (555) 123-4567</p>
                    <p><strong>Dirección:</strong> 123 Business Street, Suite 100, City, State 12345</p>
                </div>
            </body>
            </html>
            """
        default:
            return ""
        }
    }
    
    @objc private func languageChanged() {
        loadContent()
    }
}

// MARK: - WKNavigationDelegate
extension MissingLanguageAttributeViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        // Content loaded successfully
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        let alert = UIAlertController(title: "Error", message: "Failed to load content: \(error.localizedDescription)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

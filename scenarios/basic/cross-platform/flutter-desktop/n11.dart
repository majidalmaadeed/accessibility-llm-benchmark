import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Multilingual Website',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MultilingualPage(),
    );
  }
}

class MultilingualPage extends StatefulWidget {
  @override
  _MultilingualPageState createState() => _MultilingualPageState();
}

class _MultilingualPageState extends State<MultilingualPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text('Multilingual Website'),
        backgroundColor: Colors.blue[700],
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.language),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(30),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.blue[700]!, Colors.blue[900]!],
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.3),
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome to Our Global Platform',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Bienvenue sur notre plateforme mondiale',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 20,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Willkommen auf unserer globalen Plattform',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 20,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Bem-vindo à nossa plataforma global',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 20,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.blue[700],
                      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Get Started / Commencer / Loslegen / Começar',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: 40),NGUAGE ATTRIBUTE - HTML page with mixed English/French content without lang attributes
            Container(
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 5,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'About Our Company / À propos de notre entreprise',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                  SizedBox(height: 20),
                  
                  Text(
                    'We are a leading technology company that provides innovative solutions to businesses worldwide. Our mission is to empower organizations with cutting-edge tools and services.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[700],
                      height: 1.6,
                    ),
                  ),
                  
                  SizedBox(height: 16),
                  
                  Text(
                    'Nous sommes une entreprise technologique de premier plan qui fournit des solutions innovantes aux entreprises du monde entier. Notre mission est d\'autonomiser les organisations avec des outils et des services de pointe.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[700],
                      height: 1.6,
                    ),
                  ),
                  
                  SizedBox(height: 16),
                  
                  Text(
                    'Wir sind ein führendes Technologieunternehmen, das innovative Lösungen für Unternehmen weltweit bereitstellt. Unsere Mission ist es, Organisationen mit modernsten Tools und Dienstleistungen zu befähigen.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[700],
                      height: 1.6,
                    ),
                  ),
                  
                  SizedBox(height: 16),
                  
                  Text(
                    'Somos uma empresa de tecnologia líder que fornece soluções inovadoras para empresas em todo o mundo. Nossa missão é capacitar organizações com ferramentas e serviços de ponta.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[700],
                      height: 1.6,
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: 30),
            
            // Services Section
            Text(
              'Our Services / Nos services / Unsere Dienstleistungen / Nossos serviços',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
            SizedBox(height: 20),
            
            GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              childAspectRatio: 1.2,
              children: [
                _buildServiceCard(
                  'Web Development',
                  'Développement Web',
                  'Webentwicklung',
                  'Desenvolvimento Web',
                  Icons.web,
                  Colors.blue,
                ),
                _buildServiceCard(
                  'Mobile Apps',
                  'Applications Mobiles',
                  'Mobile Apps',
                  'Aplicativos Móveis',
                  Icons.phone_android,
                  Colors.green,
                ),
                _buildServiceCard(
                  'Cloud Solutions',
                  'Solutions Cloud',
                  'Cloud-Lösungen',
                  'Soluções em Nuvem',
                  Icons.cloud,
                  Colors.orange,
                ),
                _buildServiceCard(
                  'Data Analytics',
                  'Analyse de Données',
                  'Datenanalyse',
                  'Análise de Dados',
                  Icons.analytics,
                  Colors.purple,
                ),
              ],
            ),
            
            SizedBox(height: 40),NGUAGE ATTRIBUTE - HTML page with mixed English/French content without lang attributes
            Container(
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.blue[200]!, width: 1),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Contact Information / Informations de contact / Kontaktinformationen / Informações de contato',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[800],
                    ),
                  ),
                  SizedBox(height: 20),
                  
                  Row(
                    children: [
                      Icon(Icons.email, color: Colors.blue[600], size: 20),
                      SizedBox(width: 12),
                      Text(
                        'Email: contact@company.com',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.blue[700],
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: 12),
                  
                  Row(
                    children: [
                      Icon(Icons.phone, color: Colors.blue[600], size: 20),
                      SizedBox(width: 12),
                      Text(
                        'Phone: +1 (555) 123-4567',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.blue[700],
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: 12),
                  
                  Row(
                    children: [
                      Icon(Icons.location_on, color: Colors.blue[600], size: 20),
                      SizedBox(width: 12),
                      Text(
                        'Address: 123 Business St, City, State 12345',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.blue[700],
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: 20),
                  
                  Text(
                    'Nous sommes disponibles 24/7 pour vous aider.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.blue[700],
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  
                  SizedBox(height: 8),
                  
                  Text(
                    'Wir sind 24/7 verfügbar, um Ihnen zu helfen.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.blue[700],
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  
                  SizedBox(height: 8),
                  
                  Text(
                    'Estamos disponíveis 24/7 para ajudá-lo.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.blue[700],
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: 30),
            
            // Testimonials Section
            Text(
              'Customer Testimonials / Témoignages clients / Kundenbewertungen / Depoimentos de clientes',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
            SizedBox(height: 20),
            
            Container(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Container(
                    width: 300,
                    margin: EdgeInsets.only(right: 20),
                    child: _buildTestimonialCard(index),
                  );
                },
              ),
            ),
            
            SizedBox(height: 40),NGUAGE ATTRIBUTE - HTML page with mixed English/French content without lang attributes
            Container(
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[300]!, width: 1),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Legal Notice / Avis légal / Rechtlicher Hinweis / Aviso legal',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                  SizedBox(height: 16),
                  
                  Text(
                    'This website is subject to the laws of the United States. By using this site, you agree to our terms and conditions.',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                      height: 1.5,
                    ),
                  ),
                  
                  SizedBox(height: 12),
                  
                  Text(
                    'Ce site web est soumis aux lois des États-Unis. En utilisant ce site, vous acceptez nos termes et conditions.',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                      height: 1.5,
                    ),
                  ),
                  
                  SizedBox(height: 12),
                  
                  Text(
                    'Diese Website unterliegt den Gesetzen der Vereinigten Staaten. Durch die Nutzung dieser Website stimmen Sie unseren Geschäftsbedingungen zu.',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                      height: 1.5,
                    ),
                  ),
                  
                  SizedBox(height: 12),
                  
                  Text(
                    'Este site está sujeito às leis dos Estados Unidos. Ao usar este site, você concorda com nossos termos e condições.',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildServiceCard(String titleEn, String titleFr, String titleDe, String titlePt, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 40,
            color: color,
          ),
          SizedBox(height: 16),
          Text(
            titleEn,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8),
          Text(
            titleFr,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
              fontStyle: FontStyle.italic,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 4),
          Text(
            titleDe,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
              fontStyle: FontStyle.italic,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 4),
          Text(
            titlePt,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
              fontStyle: FontStyle.italic,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
  
  Widget _buildTestimonialCard(int index) {
    List<Map<String, dynamic>> testimonials = [
      {
        'name': 'John Smith',
        'company': 'Tech Corp',
        'text': 'Excellent service! Highly recommended.',
        'textFr': 'Excellent service! Hautement recommandé.',
        'textDe': 'Ausgezeichneter Service! Sehr empfehlenswert.',
        'textPt': 'Excelente serviço! Altamente recomendado.',
      },
      {
        'name': 'Marie Dubois',
        'company': 'Innovation Ltd',
        'text': 'Outstanding quality and support.',
        'textFr': 'Qualité et support exceptionnels.',
        'textDe': 'Hervorragende Qualität und Unterstützung.',
        'textPt': 'Qualidade e suporte excepcionais.',
      },
      {
        'name': 'Hans Mueller',
        'company': 'Global Solutions',
        'text': 'Professional and reliable team.',
        'textFr': 'Équipe professionnelle et fiable.',
        'textDe': 'Professionelles und zuverlässiges Team.',
        'textPt': 'Equipe profissional e confiável.',
      },
    ];
    
    var testimonial = testimonials[index];
    
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '"${testimonial['text']}"',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[700],
              height: 1.5,
              fontStyle: FontStyle.italic,
            ),
          ),
          SizedBox(height: 12),
          Text(
            '"${testimonial['textFr']}"',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
              height: 1.4,
              fontStyle: FontStyle.italic,
            ),
          ),
          SizedBox(height: 8),
          Text(
            '"${testimonial['textDe']}"',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
              height: 1.4,
              fontStyle: FontStyle.italic,
            ),
          ),
          SizedBox(height: 8),
          Text(
            '"${testimonial['textPt']}"',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
              height: 1.4,
              fontStyle: FontStyle.italic,
            ),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: Colors.blue[700],
                child: Text(
                  testimonial['name'][0],
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    testimonial['name'],
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                  Text(
                    testimonial['company'],
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}


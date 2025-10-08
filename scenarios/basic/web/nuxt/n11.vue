<template>
  <div class="multilingual-site">
    <header class="site-header">
      <div class="header-content">
        <h1 class="site-title">Global News Portal</h1>
        <div class="language-selector">
          <select v-model="selectedLanguage" @change="changeLanguage" class="lang-select">
            <option value="en">English</option>
            <option value="fr">Français</option>
            <option value="es">Español</option>
            <option value="de">Deutsch</option>
            <option value="it">Italiano</option>
            <option value="pt">Português</option>
          </select>
        </div>
      </div>
      <nav class="main-navigation">
        <ul class="nav-list">
          <li><a href="#" class="nav-link">Home</a></li>
          <li><a href="#" class="nav-link">World</a></li>
          <li><a href="#" class="nav-link">Politics</a></li>
          <li><a href="#" class="nav-link">Business</a></li>
          <li><a href="#" class="nav-link">Technology</a></li>
          <li><a href="#" class="nav-link">Sports</a></li>
          <li><a href="#" class="nav-link">Entertainment</a></li>
        </ul>
      </nav>
    </header>

    <main class="main-content">
      <section class="hero-section">
        <div class="hero-content">
          <h2 class="hero-title">{{ getText('heroTitle') }}</h2>
          <p class="hero-description">{{ getText('heroDescription') }}</p>
          <div class="hero-actions">
            <button class="cta-button primary">{{ getText('readMore') }}</button>
            <button class="cta-button secondary">{{ getText('subscribe') }}</button>
          </div>
        </div>
        <div class="hero-image">
          <img src="/api/placeholder/800/400" alt="Breaking news" />
        </div>
      </section>

      <section class="news-section">
        <h2 class="section-title">{{ getText('latestNews') }}</h2>
        <div class="news-grid">
          <article
            v-for="article in articles"
            :key="article.id"
            class="news-card"
          >
            <div class="news-image">
              <img :src="article.image" :alt="article.title" />
              <div class="news-category">{{ article.category }}</div>
            </div>
            <div class="news-content">
              <h3 class="news-title">{{ article.title }}</h3>
              <p class="news-excerpt">{{ article.excerpt }}</p>
              <div class="news-meta">
                <span class="news-author">{{ article.author }}</span>
                <span class="news-date">{{ formatDate(article.date) }}</span>
                <span class="news-views">{{ article.views }} {{ getText('views') }}</span>
              </div>
            </div>
          </article>
        </div>
      </section>

      <section class="features-section">
        <h2 class="section-title">{{ getText('whyChooseUs') }}</h2>
        <div class="features-grid">
          <div class="feature-card">
            <div class="feature-icon">🌍</div>
            <h3 class="feature-title">{{ getText('globalCoverage') }}</h3>
            <p class="feature-description">{{ getText('globalCoverageDesc') }}</p>
          </div>
          <div class="feature-card">
            <div class="feature-icon">⚡</div>
            <h3 class="feature-title">{{ getText('realTime') }}</h3>
            <p class="feature-description">{{ getText('realTimeDesc') }}</p>
          </div>
          <div class="feature-card">
            <div class="feature-icon">🔍</div>
            <h3 class="feature-title">{{ getText('inDepth') }}</h3>
            <p class="feature-description">{{ getText('inDepthDesc') }}</p>
          </div>
          <div class="feature-card">
            <div class="feature-icon">📱</div>
            <h3 class="feature-title">{{ getText('mobileFirst') }}</h3>
            <p class="feature-description">{{ getText('mobileFirstDesc') }}</p>
          </div>
        </div>
      </section>

      <section class="newsletter-section">
        <div class="newsletter-content">
          <h2 class="newsletter-title">{{ getText('stayUpdated') }}</h2>
          <p class="newsletter-description">{{ getText('newsletterDesc') }}</p>
          <form class="newsletter-form" @submit.prevent="subscribeNewsletter">
            <div class="form-group">
              <input
                type="email"
                v-model="email"
                :placeholder="getText('emailPlaceholder')"
                class="email-input"
                required
              />
              <button type="submit" class="subscribe-btn">{{ getText('subscribe') }}</button>
            </div>
            <div class="form-checkbox">
              <input
                type="checkbox"
                v-model="agreeTerms"
                id="terms"
                required
              />
              <label for="terms">{{ getText('agreeTerms') }}</label>
            </div>
          </form>
        </div>
      </section>
    </main>

    <footer class="site-footer">
      <div class="footer-content">
        <div class="footer-section">
          <h3 class="footer-title">{{ getText('aboutUs') }}</h3>
          <ul class="footer-links">
            <li><a href="#">{{ getText('ourStory') }}</a></li>
            <li><a href="#">{{ getText('ourTeam') }}</a></li>
            <li><a href="#">{{ getText('careers') }}</a></li>
            <li><a href="#">{{ getText('contact') }}</a></li>
          </ul>
        </div>
        <div class="footer-section">
          <h3 class="footer-title">{{ getText('categories') }}</h3>
          <ul class="footer-links">
            <li><a href="#">{{ getText('world') }}</a></li>
            <li><a href="#">{{ getText('politics') }}</a></li>
            <li><a href="#">{{ getText('business') }}</a></li>
            <li><a href="#">{{ getText('technology') }}</a></li>
          </ul>
        </div>
        <div class="footer-section">
          <h3 class="footer-title">{{ getText('support') }}</h3>
          <ul class="footer-links">
            <li><a href="#">{{ getText('helpCenter') }}</a></li>
            <li><a href="#">{{ getText('faq') }}</a></li>
            <li><a href="#">{{ getText('privacy') }}</a></li>
            <li><a href="#">{{ getText('terms') }}</a></li>
          </ul>
        </div>
        <div class="footer-section">
          <h3 class="footer-title">{{ getText('connect') }}</h3>
          <div class="social-links">
            <a href="#" class="social-link">📘</a>
            <a href="#" class="social-link">🐦</a>
            <a href="#" class="social-link">📷</a>
            <a href="#" class="social-link">📺</a>
          </div>
        </div>
      </div>
      <div class="footer-bottom">
        <p>&copy; 2024 Global News Portal. {{ getText('allRightsReserved') }}</p>
      </div>
    </footer>
  </div>
</template>

<script setup>
import { ref, computed } from 'vue'

const selectedLanguage = ref('en')
const email = ref('')
const agreeTerms = ref(false)

const translations = {
  en: {
    heroTitle: 'Stay Informed with Global News',
    heroDescription: 'Get the latest news from around the world with real-time updates and in-depth analysis.',
    readMore: 'Read More',
    subscribe: 'Subscribe',
    latestNews: 'Latest News',
    views: 'views',
    whyChooseUs: 'Why Choose Us',
    globalCoverage: 'Global Coverage',
    globalCoverageDesc: 'News from every corner of the world',
    realTime: 'Real-Time Updates',
    realTimeDesc: 'Breaking news as it happens',
    inDepth: 'In-Depth Analysis',
    inDepthDesc: 'Comprehensive coverage and analysis',
    mobileFirst: 'Mobile First',
    mobileFirstDesc: 'Optimized for all devices',
    stayUpdated: 'Stay Updated',
    newsletterDesc: 'Subscribe to our newsletter for daily news updates',
    emailPlaceholder: 'Enter your email address',
    agreeTerms: 'I agree to the terms and conditions',
    aboutUs: 'About Us',
    ourStory: 'Our Story',
    ourTeam: 'Our Team',
    careers: 'Careers',
    contact: 'Contact',
    categories: 'Categories',
    world: 'World',
    politics: 'Politics',
    business: 'Business',
    technology: 'Technology',
    support: 'Support',
    helpCenter: 'Help Center',
    faq: 'FAQ',
    privacy: 'Privacy Policy',
    terms: 'Terms of Service',
    connect: 'Connect With Us',
    allRightsReserved: 'All rights reserved.'
  },
  fr: {
    heroTitle: 'Restez Informé avec les Actualités Mondiales',
    heroDescription: 'Obtenez les dernières nouvelles du monde entier avec des mises à jour en temps réel et des analyses approfondies.',
    readMore: 'Lire Plus',
    subscribe: 'S\'abonner',
    latestNews: 'Dernières Nouvelles',
    views: 'vues',
    whyChooseUs: 'Pourquoi Nous Choisir',
    globalCoverage: 'Couverture Mondiale',
    globalCoverageDesc: 'Nouvelles de tous les coins du monde',
    realTime: 'Mises à Jour en Temps Réel',
    realTimeDesc: 'Actualités en direct',
    inDepth: 'Analyse Approfondie',
    inDepthDesc: 'Couverture et analyse complètes',
    mobileFirst: 'Mobile First',
    mobileFirstDesc: 'Optimisé pour tous les appareils',
    stayUpdated: 'Restez Informé',
    newsletterDesc: 'Abonnez-vous à notre newsletter pour des mises à jour quotidiennes',
    emailPlaceholder: 'Entrez votre adresse email',
    agreeTerms: 'J\'accepte les termes et conditions',
    aboutUs: 'À Propos',
    ourStory: 'Notre Histoire',
    ourTeam: 'Notre Équipe',
    careers: 'Carrières',
    contact: 'Contact',
    categories: 'Catégories',
    world: 'Monde',
    politics: 'Politique',
    business: 'Business',
    technology: 'Technologie',
    support: 'Support',
    helpCenter: 'Centre d\'Aide',
    faq: 'FAQ',
    privacy: 'Politique de Confidentialité',
    terms: 'Conditions d\'Utilisation',
    connect: 'Connectez-vous',
    allRightsReserved: 'Tous droits réservés.'
  },
  es: {
    heroTitle: 'Mantente Informado con Noticias Globales',
    heroDescription: 'Obtén las últimas noticias de todo el mundo con actualizaciones en tiempo real y análisis en profundidad.',
    readMore: 'Leer Más',
    subscribe: 'Suscribirse',
    latestNews: 'Últimas Noticias',
    views: 'vistas',
    whyChooseUs: 'Por Qué Elegirnos',
    globalCoverage: 'Cobertura Global',
    globalCoverageDesc: 'Noticias de todos los rincones del mundo',
    realTime: 'Actualizaciones en Tiempo Real',
    realTimeDesc: 'Noticias de última hora',
    inDepth: 'Análisis Profundo',
    inDepthDesc: 'Cobertura y análisis completos',
    mobileFirst: 'Mobile First',
    mobileFirstDesc: 'Optimizado para todos los dispositivos',
    stayUpdated: 'Mantente Actualizado',
    newsletterDesc: 'Suscríbete a nuestro boletín para actualizaciones diarias',
    emailPlaceholder: 'Ingresa tu dirección de email',
    agreeTerms: 'Acepto los términos y condiciones',
    aboutUs: 'Acerca de Nosotros',
    ourStory: 'Nuestra Historia',
    ourTeam: 'Nuestro Equipo',
    careers: 'Carreras',
    contact: 'Contacto',
    categories: 'Categorías',
    world: 'Mundo',
    politics: 'Política',
    business: 'Negocios',
    technology: 'Tecnología',
    support: 'Soporte',
    helpCenter: 'Centro de Ayuda',
    faq: 'Preguntas Frecuentes',
    privacy: 'Política de Privacidad',
    terms: 'Términos de Servicio',
    connect: 'Conéctate con Nosotros',
    allRightsReserved: 'Todos los derechos reservados.'
  },
  de: {
    heroTitle: 'Bleiben Sie mit Globalen Nachrichten Informiert',
    heroDescription: 'Erhalten Sie die neuesten Nachrichten aus aller Welt mit Echtzeit-Updates und tiefgreifenden Analysen.',
    readMore: 'Mehr Lesen',
    subscribe: 'Abonnieren',
    latestNews: 'Neueste Nachrichten',
    views: 'Aufrufe',
    whyChooseUs: 'Warum Uns Wählen',
    globalCoverage: 'Globale Abdeckung',
    globalCoverageDesc: 'Nachrichten aus allen Ecken der Welt',
    realTime: 'Echtzeit-Updates',
    realTimeDesc: 'Breaking News wie sie passieren',
    inDepth: 'Tiefgreifende Analyse',
    inDepthDesc: 'Umfassende Berichterstattung und Analyse',
    mobileFirst: 'Mobile First',
    mobileFirstDesc: 'Optimiert für alle Geräte',
    stayUpdated: 'Bleiben Sie Informiert',
    newsletterDesc: 'Abonnieren Sie unseren Newsletter für tägliche Nachrichten-Updates',
    emailPlaceholder: 'Geben Sie Ihre E-Mail-Adresse ein',
    agreeTerms: 'Ich stimme den Geschäftsbedingungen zu',
    aboutUs: 'Über Uns',
    ourStory: 'Unsere Geschichte',
    ourTeam: 'Unser Team',
    careers: 'Karriere',
    contact: 'Kontakt',
    categories: 'Kategorien',
    world: 'Welt',
    politics: 'Politik',
    business: 'Wirtschaft',
    technology: 'Technologie',
    support: 'Support',
    helpCenter: 'Hilfe-Center',
    faq: 'FAQ',
    privacy: 'Datenschutzrichtlinie',
    terms: 'Nutzungsbedingungen',
    connect: 'Verbinden Sie sich mit uns',
    allRightsReserved: 'Alle Rechte vorbehalten.'
  },
  it: {
    heroTitle: 'Rimani Informato con le Notizie Globali',
    heroDescription: 'Ottieni le ultime notizie da tutto il mondo con aggiornamenti in tempo reale e analisi approfondite.',
    readMore: 'Leggi di Più',
    subscribe: 'Iscriviti',
    latestNews: 'Ultime Notizie',
    views: 'visualizzazioni',
    whyChooseUs: 'Perché Sceglierci',
    globalCoverage: 'Copertura Globale',
    globalCoverageDesc: 'Notizie da ogni angolo del mondo',
    realTime: 'Aggiornamenti in Tempo Reale',
    realTimeDesc: 'Notizie dell\'ultimo minuto',
    inDepth: 'Analisi Approfondita',
    inDepthDesc: 'Copertura e analisi complete',
    mobileFirst: 'Mobile First',
    mobileFirstDesc: 'Ottimizzato per tutti i dispositivi',
    stayUpdated: 'Rimani Aggiornato',
    newsletterDesc: 'Iscriviti alla nostra newsletter per aggiornamenti quotidiani',
    emailPlaceholder: 'Inserisci il tuo indirizzo email',
    agreeTerms: 'Accetto i termini e le condizioni',
    aboutUs: 'Chi Siamo',
    ourStory: 'La Nostra Storia',
    ourTeam: 'Il Nostro Team',
    careers: 'Carriere',
    contact: 'Contatto',
    categories: 'Categorie',
    world: 'Mondo',
    politics: 'Politica',
    business: 'Business',
    technology: 'Tecnologia',
    support: 'Supporto',
    helpCenter: 'Centro Assistenza',
    faq: 'FAQ',
    privacy: 'Politica sulla Privacy',
    terms: 'Termini di Servizio',
    connect: 'Connettiti con Noi',
    allRightsReserved: 'Tutti i diritti riservati.'
  },
  pt: {
    heroTitle: 'Mantenha-se Informado com Notícias Globais',
    heroDescription: 'Obtenha as últimas notícias de todo o mundo com atualizações em tempo real e análises aprofundadas.',
    readMore: 'Leia Mais',
    subscribe: 'Inscrever-se',
    latestNews: 'Últimas Notícias',
    views: 'visualizações',
    whyChooseUs: 'Por Que Nos Escolher',
    globalCoverage: 'Cobertura Global',
    globalCoverageDesc: 'Notícias de todos os cantos do mundo',
    realTime: 'Atualizações em Tempo Real',
    realTimeDesc: 'Notícias de última hora',
    inDepth: 'Análise Aprofundada',
    inDepthDesc: 'Cobertura e análise abrangentes',
    mobileFirst: 'Mobile First',
    mobileFirstDesc: 'Otimizado para todos os dispositivos',
    stayUpdated: 'Mantenha-se Atualizado',
    newsletterDesc: 'Inscreva-se em nossa newsletter para atualizações diárias',
    emailPlaceholder: 'Digite seu endereço de email',
    agreeTerms: 'Concordo com os termos e condições',
    aboutUs: 'Sobre Nós',
    ourStory: 'Nossa História',
    ourTeam: 'Nossa Equipe',
    careers: 'Carreiras',
    contact: 'Contato',
    categories: 'Categorias',
    world: 'Mundo',
    politics: 'Política',
    business: 'Negócios',
    technology: 'Tecnologia',
    support: 'Suporte',
    helpCenter: 'Central de Ajuda',
    faq: 'FAQ',
    privacy: 'Política de Privacidade',
    terms: 'Termos de Serviço',
    connect: 'Conecte-se Conosco',
    allRightsReserved: 'Todos os direitos reservados.'
  }
}

const articles = ref([
  {
    id: 1,
    title: 'Major Economic Summit Concludes Successfully',
    excerpt: 'World leaders reach historic agreement on climate change and economic cooperation.',
    image: '/api/placeholder/400/250',
    category: 'Politics',
    author: 'Sarah Johnson',
    date: '2024-01-15',
    views: 12500
  },
  {
    id: 2,
    title: 'Breakthrough in Renewable Energy Technology',
    excerpt: 'Scientists develop new solar panel technology that could revolutionize clean energy.',
    image: '/api/placeholder/400/250',
    category: 'Technology',
    author: 'Michael Chen',
    date: '2024-01-14',
    views: 8900
  },
  {
    id: 3,
    title: 'Global Markets Show Strong Recovery',
    excerpt: 'Stock markets worldwide experience significant gains following positive economic indicators.',
    image: '/api/placeholder/400/250',
    category: 'Business',
    author: 'Emily Davis',
    date: '2024-01-13',
    views: 15600
  },
  {
    id: 4,
    title: 'Olympic Games Preparations Enter Final Phase',
    excerpt: 'Host city completes infrastructure projects and prepares for international athletes.',
    image: '/api/placeholder/400/250',
    category: 'Sports',
    author: 'David Wilson',
    date: '2024-01-12',
    views: 11200
  }
])

const getText = (key) => {
  return translations[selectedLanguage.value][key] || key
}

const changeLanguage = () => {
  // In a real application, this would trigger a page reload or content update
  console.log(`Language changed to: ${selectedLanguage.value}`)
}

const formatDate = (dateString) => {
  const date = new Date(dateString)
  return date.toLocaleDateString(selectedLanguage.value, {
    year: 'numeric',
    month: 'long',
    day: 'numeric'
  })
}

const subscribeNewsletter = () => {
  if (agreeTerms.value) {
    alert(`Thank you for subscribing! We'll send updates to ${email.value}`)
    email.value = ''
    agreeTerms.value = false
  } else {
    alert('Please agree to the terms and conditions')
  }
}
</script>

<style scoped>
.multilingual-site {
  min-height: 100vh;
  font-family: Arial, sans-serif;
  line-height: 1.6;
}

.site-header {
  background: #1a1a1a;
  color: white;
  padding: 20px 0;
}

.header-content {
  max-width: 1200px;
  margin: 0 auto;
  padding: 0 20px;
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 20px;
}

.site-title {
  margin: 0;
  font-size: 28px;
  font-weight: bold;
}

.language-selector {
  display: flex;
  align-items: center;
  gap: 10px;
}

.lang-select {
  padding: 8px 12px;
  border: 1px solid #444;
  border-radius: 4px;
  background: #333;
  color: white;
  cursor: pointer;
}

.lang-select:focus {
  outline: none;
  border-color: #007bff;
}

.main-navigation {
  max-width: 1200px;
  margin: 0 auto;
  padding: 0 20px;
}

.nav-list {
  display: flex;
  list-style: none;
  margin: 0;
  padding: 0;
  gap: 30px;
}

.nav-link {
  color: white;
  text-decoration: none;
  font-weight: 500;
  transition: color 0.2s ease;
}

.nav-link:hover {
  color: #007bff;
}

.main-content {
  max-width: 1200px;
  margin: 0 auto;
  padding: 40px 20px;
}

.hero-section {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 40px;
  align-items: center;
  margin-bottom: 60px;
}

.hero-content {
  padding: 20px 0;
}

.hero-title {
  margin: 0 0 20px 0;
  font-size: 36px;
  font-weight: bold;
  color: #333;
  line-height: 1.2;
}

.hero-description {
  margin: 0 0 30px 0;
  font-size: 18px;
  color: #666;
  line-height: 1.6;
}

.hero-actions {
  display: flex;
  gap: 20px;
}

.cta-button {
  padding: 12px 24px;
  border: none;
  border-radius: 6px;
  font-size: 16px;
  font-weight: bold;
  cursor: pointer;
  transition: all 0.2s ease;
}

.cta-button.primary {
  background: #007bff;
  color: white;
}

.cta-button.primary:hover {
  background: #0056b3;
  transform: translateY(-1px);
}

.cta-button.secondary {
  background: transparent;
  color: #007bff;
  border: 2px solid #007bff;
}

.cta-button.secondary:hover {
  background: #007bff;
  color: white;
}

.hero-image img {
  width: 100%;
  height: 300px;
  object-fit: cover;
  border-radius: 8px;
}

.news-section {
  margin-bottom: 60px;
}

.section-title {
  margin: 0 0 30px 0;
  font-size: 28px;
  color: #333;
  text-align: center;
}

.news-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
  gap: 30px;
}

.news-card {
  background: white;
  border-radius: 8px;
  overflow: hidden;
  box-shadow: 0 4px 8px rgba(0,0,0,0.1);
  transition: transform 0.2s ease;
}

.news-card:hover {
  transform: translateY(-4px);
}

.news-image {
  position: relative;
  height: 200px;
  overflow: hidden;
}

.news-image img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.news-category {
  position: absolute;
  top: 10px;
  left: 10px;
  background: #007bff;
  color: white;
  padding: 4px 8px;
  border-radius: 4px;
  font-size: 12px;
  font-weight: bold;
}

.news-content {
  padding: 20px;
}

.news-title {
  margin: 0 0 10px 0;
  font-size: 18px;
  font-weight: bold;
  color: #333;
  line-height: 1.3;
}

.news-excerpt {
  margin: 0 0 15px 0;
  color: #666;
  line-height: 1.5;
}

.news-meta {
  display: flex;
  gap: 15px;
  font-size: 12px;
  color: #999;
}

.features-section {
  margin-bottom: 60px;
  background: #f8f9fa;
  padding: 40px;
  border-radius: 8px;
}

.features-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
  gap: 30px;
}

.feature-card {
  text-align: center;
  padding: 20px;
}

.feature-icon {
  font-size: 48px;
  margin-bottom: 20px;
}

.feature-title {
  margin: 0 0 15px 0;
  font-size: 20px;
  color: #333;
}

.feature-description {
  margin: 0;
  color: #666;
  line-height: 1.5;
}

.newsletter-section {
  background: #007bff;
  color: white;
  padding: 40px;
  border-radius: 8px;
  text-align: center;
  margin-bottom: 60px;
}

.newsletter-title {
  margin: 0 0 15px 0;
  font-size: 28px;
}

.newsletter-description {
  margin: 0 0 30px 0;
  font-size: 16px;
  opacity: 0.9;
}

.newsletter-form {
  max-width: 500px;
  margin: 0 auto;
}

.form-group {
  display: flex;
  gap: 10px;
  margin-bottom: 15px;
}

.email-input {
  flex: 1;
  padding: 12px 16px;
  border: none;
  border-radius: 4px;
  font-size: 16px;
}

.subscribe-btn {
  padding: 12px 24px;
  background: white;
  color: #007bff;
  border: none;
  border-radius: 4px;
  font-weight: bold;
  cursor: pointer;
  transition: all 0.2s ease;
}

.subscribe-btn:hover {
  background: #f8f9fa;
}

.form-checkbox {
  display: flex;
  align-items: center;
  gap: 8px;
  font-size: 14px;
}

.form-checkbox input[type="checkbox"] {
  width: 16px;
  height: 16px;
}

.site-footer {
  background: #333;
  color: white;
  padding: 40px 0 20px;
}

.footer-content {
  max-width: 1200px;
  margin: 0 auto;
  padding: 0 20px;
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
  gap: 30px;
  margin-bottom: 30px;
}

.footer-title {
  margin: 0 0 20px 0;
  font-size: 18px;
  color: white;
}

.footer-links {
  list-style: none;
  padding: 0;
  margin: 0;
}

.footer-links li {
  margin-bottom: 10px;
}

.footer-links a {
  color: #ccc;
  text-decoration: none;
  transition: color 0.2s ease;
}

.footer-links a:hover {
  color: white;
}

.social-links {
  display: flex;
  gap: 15px;
}

.social-link {
  display: inline-block;
  font-size: 24px;
  text-decoration: none;
  transition: transform 0.2s ease;
}

.social-link:hover {
  transform: scale(1.1);
}

.footer-bottom {
  text-align: center;
  padding-top: 20px;
  border-top: 1px solid #555;
  color: #ccc;
}

@media (max-width: 768px) {
  .header-content {
    flex-direction: column;
    gap: 20px;
  }

  .nav-list {
    flex-wrap: wrap;
    gap: 15px;
  }

  .hero-section {
    grid-template-columns: 1fr;
    text-align: center;
  }

  .hero-title {
    font-size: 28px;
  }

  .hero-actions {
    justify-content: center;
  }

  .news-grid {
    grid-template-columns: 1fr;
  }

  .features-grid {
    grid-template-columns: 1fr;
  }

  .form-group {
    flex-direction: column;
  }

  .footer-content {
    grid-template-columns: 1fr;
    text-align: center;
  }
}
</style>

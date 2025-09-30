<template>
  <div class="website">
    <!-- Page navigation without skip-to-content link -->
    <header class="main-header">
      <div class="header-content">
        <div class="logo">Company Logo</div>
        
        <nav class="main-nav">
          <button 
            v-for="section in sections" 
            :key="section.id"
            @click="setActiveSection(section.id)"
            :class="['nav-btn', { active: activeSection === section.id }]"
          >
            {{ section.title }}
          </button>
        </nav>
      </div>
    </header>

    <!-- Main content area -->
    <main class="main-content">
      <!-- Hero section -->
      <section class="hero-section">
        <h1>{{ currentSection.title }}</h1>
        <p>{{ currentSection.subtitle }}</p>
        <button class="hero-btn">{{ currentSection.button }}</button>
      </section>

      <!-- Content sections -->
      <div class="content-grid">
        <div class="content-card">
          <h2>About Our Company</h2>
          <p>{{ currentSection.description }}</p>
        </div>

        <div class="content-card">
          <h2>Our Services</h2>
          <ul>
            <li v-for="feature in currentSection.features" :key="feature">
              {{ feature }}
            </li>
          </ul>
        </div>
      </div>

      <!-- Dynamic content based on active section -->
      <section class="dynamic-content">
        <h2>{{ currentSection.title }}</h2>
        <p>{{ currentSection.content }}</p>
      </section>

      <!-- Additional content sections -->
      <div class="features-grid">
        <div class="feature-item">
          <h3>Feature 1</h3>
          <p>Description of the first feature</p>
        </div>
        <div class="feature-item">
          <h3>Feature 2</h3>
          <p>Description of the second feature</p>
        </div>
        <div class="feature-item">
          <h3>Feature 3</h3>
          <p>Description of the third feature</p>
        </div>
      </div>
    </main>

    <!-- Footer -->
    <footer class="main-footer">
      <div class="footer-content">
        <p>© 2024 Company Name. All rights reserved.</p>
        <div class="footer-links">
          <a href="#">Privacy Policy</a>
          <a href="#">Terms of Service</a>
          <a href="#">Contact Us</a>
        </div>
      </div>
    </footer>
  </div>
</template>

<script>
export default {
  name: 'MissingSkipLink',
  data() {
    return {
      activeSection: 'home',
      sections: [
        { id: 'home', title: 'Home', content: 'Welcome to our website' },
        { id: 'about', title: 'About', content: 'Learn more about our company' },
        { id: 'services', title: 'Services', content: 'Our professional services' },
        { id: 'products', title: 'Products', content: 'Browse our product catalog' },
        { id: 'contact', title: 'Contact', content: 'Get in touch with us' }
      ],
      content: {
        home: {
          title: "Welcome to Our Platform",
          subtitle: "Discover innovative solutions for your business needs",
          button: "Get Started Today",
          description: "We are a leading technology company dedicated to providing innovative solutions that help businesses grow and succeed in the digital age.",
          features: ["Web Development", "Mobile App Development", "Cloud Solutions", "Digital Marketing"],
          content: "Welcome to our website"
        },
        about: {
          title: "About Our Company",
          subtitle: "Learn more about our mission and values",
          button: "Learn More",
          description: "We are a leading technology company dedicated to providing innovative solutions that help businesses grow and succeed in the digital age.",
          features: ["Expert Team", "Proven Track Record", "Customer Focus", "Innovation"],
          content: "Learn more about our company"
        },
        services: {
          title: "Our Services",
          subtitle: "Comprehensive solutions for your business",
          button: "View Services",
          description: "We offer a wide range of professional services to help your business succeed in the digital world.",
          features: ["Web Development", "Mobile App Development", "Cloud Solutions", "Digital Marketing"],
          content: "Our professional services"
        },
        products: {
          title: "Our Products",
          subtitle: "Discover our innovative product solutions",
          button: "Browse Products",
          description: "Explore our comprehensive range of products designed to meet your business needs.",
          features: ["Software Solutions", "Hardware Products", "Cloud Services", "Support"],
          content: "Browse our product catalog"
        },
        contact: {
          title: "Contact Us",
          subtitle: "Get in touch with our team",
          button: "Contact Now",
          description: "Ready to get started? Contact us today for more information about our services.",
          features: ["Email Support", "Phone Support", "Live Chat", "Documentation"],
          content: "Get in touch with us"
        }
      }
    }
  },
  computed: {
    currentSection() {
      return this.content[this.activeSection] || this.content.home
    }
  },
  methods: {
    setActiveSection(sectionId) {
      this.activeSection = sectionId
    }
  }
}
</script>

<style scoped>
.website {
  font-family: Arial, sans-serif;
  min-height: 100vh;
}

.main-header {
  background: #2c3e50;
  color: white;
  padding: 0;
  position: sticky;
  top: 0;
  z-index: 100;
  box-shadow: 0 2px 4px rgba(0,0,0,0.1);
}

.header-content {
  max-width: 1200px;
  margin: 0 auto;
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 0 20px;
}

.logo {
  font-size: 24px;
  font-weight: bold;
  padding: 15px 0;
}

.main-nav {
  display: flex;
  gap: 0;
}

.nav-btn {
  background: transparent;
  color: white;
  border: none;
  padding: 15px 20px;
  cursor: pointer;
  font-size: 16px;
  font-weight: 500;
  transition: background-color 0.3s ease;
}

.nav-btn.active {
  background: #34495e;
}

.main-content {
  max-width: 1200px;
  margin: 0 auto;
  padding: 40px 20px;
}

.hero-section {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  color: white;
  padding: 80px 40px;
  border-radius: 12px;
  text-align: center;
  margin-bottom: 60px;
}

.hero-section h1 {
  font-size: 48px;
  margin: 0 0 20px 0;
  font-weight: bold;
}

.hero-section p {
  font-size: 20px;
  margin: 0 0 40px 0;
  opacity: 0.9;
}

.hero-btn {
  background: white;
  color: #667eea;
  border: none;
  padding: 15px 30px;
  border-radius: 25px;
  font-size: 18px;
  font-weight: bold;
  cursor: pointer;
  box-shadow: 0 4px 15px rgba(0,0,0,0.2);
}

.content-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
  gap: 30px;
  margin-bottom: 60px;
}

.content-card {
  background: white;
  padding: 30px;
  border-radius: 8px;
  box-shadow: 0 2px 10px rgba(0,0,0,0.1);
  border: 1px solid #e0e0e0;
}

.content-card h2 {
  font-size: 24px;
  margin: 0 0 15px 0;
  color: #333;
}

.content-card p {
  font-size: 16px;
  line-height: 1.6;
  color: #666;
  margin: 0;
}

.content-card ul {
  margin: 0;
  padding-left: 20px;
  font-size: 16px;
  line-height: 1.8;
  color: #666;
}

.dynamic-content {
  background: #f8f9fa;
  padding: 40px;
  border-radius: 8px;
  margin-bottom: 40px;
}

.dynamic-content h2 {
  font-size: 28px;
  margin: 0 0 20px 0;
  color: #333;
}

.dynamic-content p {
  font-size: 18px;
  line-height: 1.6;
  color: #666;
  margin: 0;
}

.features-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
  gap: 20px;
  margin-bottom: 40px;
}

.feature-item {
  background: white;
  padding: 20px;
  border-radius: 8px;
  box-shadow: 0 2px 8px rgba(0,0,0,0.1);
  border: 1px solid #e0e0e0;
}

.feature-item h3 {
  font-size: 18px;
  margin: 0 0 10px 0;
  color: #333;
}

.feature-item p {
  font-size: 14px;
  color: #666;
  margin: 0;
}

.main-footer {
  background: #34495e;
  color: white;
  padding: 40px 20px;
  text-align: center;
}

.footer-content {
  max-width: 1200px;
  margin: 0 auto;
}

.footer-content p {
  margin: 0 0 20px 0;
  font-size: 16px;
}

.footer-links {
  display: flex;
  justify-content: center;
  gap: 30px;
  flex-wrap: wrap;
}

.footer-links a {
  color: white;
  text-decoration: none;
}
</style>

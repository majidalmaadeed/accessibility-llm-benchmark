<template>
  <div class="portfolio-website">
    <header class="site-header">
      <div class="header-content">
        <div class="logo-section">
          <img src="/api/placeholder/60/60" alt="Company Logo" class="logo" />
          <h1 class="site-title">Creative Studio</h1>
        </div>
        <nav class="main-navigation">
          <ul class="nav-list">
            <li><a href="#home" class="nav-link">Home</a></li>
            <li><a href="#about" class="nav-link">About</a></li>
            <li><a href="#portfolio" class="nav-link">Portfolio</a></li>
            <li><a href="#services" class="nav-link">Services</a></li>
            <li><a href="#contact" class="nav-link">Contact</a></li>
          </ul>
        </nav>
      </div>
    </header>

    <main class="main-content">
      <section id="home" class="hero-section">
        <div class="hero-content">
          <h2 class="hero-title">We Create Amazing Digital Experiences</h2>
          <p class="hero-description">
            Our creative studio specializes in web design, branding, and digital marketing solutions that help businesses grow and succeed online.
          </p>
          <div class="hero-actions">
            <button class="cta-button primary">Get Started</button>
            <button class="cta-button secondary">View Our Work</button>
          </div>
        </div>
        <div class="hero-visual">
          <img src="/api/placeholder/600/400" alt="Creative workspace with modern design elements" class="hero-image" />
          <div class="decorative-elements">
            <img src="/api/placeholder/100/100" alt="Decorative geometric shape" class="decorative-shape" />
            <img src="/api/placeholder/80/80" alt="Decorative circle element" class="decorative-circle" />
          </div>
        </div>
      </section>

      <section id="about" class="about-section">
        <div class="section-header">
          <h2 class="section-title">About Our Studio</h2>
          <p class="section-description">
            We are a team of passionate designers and developers who love creating beautiful, functional digital experiences.
          </p>
        </div>
        
        <div class="about-content">
          <div class="about-text">
            <h3>Our Story</h3>
            <p>
              Founded in 2015, Creative Studio has been helping businesses establish their digital presence through innovative design and cutting-edge technology. We believe that great design is not just about aesthetics, but about creating meaningful connections between brands and their audiences.
            </p>
            <div class="stats-grid">
              <div class="stat-item">
                <div class="stat-number">150+</div>
                <div class="stat-label">Projects Completed</div>
              </div>
              <div class="stat-item">
                <div class="stat-number">50+</div>
                <div class="stat-label">Happy Clients</div>
              </div>
              <div class="stat-item">
                <div class="stat-number">8</div>
                <div class="stat-label">Years Experience</div>
              </div>
            </div>
          </div>
          <div class="about-image">
            <img src="/api/placeholder/500/400" alt="Team working together in modern office space" class="team-image" />
            <div class="image-overlay">
              <img src="/api/placeholder/60/60" alt="Decorative pattern overlay" class="overlay-pattern" />
            </div>
          </div>
        </div>
      </section>

      <section id="portfolio" class="portfolio-section">
        <div class="section-header">
          <h2 class="section-title">Our Portfolio</h2>
          <p class="section-description">
            Take a look at some of our recent projects and see how we've helped businesses transform their digital presence.
          </p>
        </div>

        <div class="portfolio-filter">
          <button 
            v-for="category in categories" 
            :key="category.id"
            class="filter-btn"
            :class="{ active: selectedCategory === category.id }"
            @click="selectedCategory = category.id"
          >
            {{ category.name }}
          </button>
        </div>

        <div class="portfolio-grid">
          <div
            v-for="project in filteredProjects"
            :key="project.id"
            class="portfolio-item"
          >
            <div class="project-image">
              <img :src="project.image" :alt="project.title" />
              <div class="project-overlay">
                <div class="project-actions">
                  <button class="action-btn">👁️</button>
                  <button class="action-btn">🔗</button>
                </div>
              </div>
            </div>
            <div class="project-content">
              <h3 class="project-title">{{ project.title }}</h3>
              <p class="project-description">{{ project.description }}</p>
              <div class="project-tags">
                <span 
                  v-for="tag in project.tags" 
                  :key="tag" 
                  class="project-tag"
                >
                  {{ tag }}
                </span>
              </div>
            </div>
          </div>
        </div>
      </section>

      <section id="services" class="services-section">
        <div class="section-header">
          <h2 class="section-title">Our Services</h2>
          <p class="section-description">
            We offer a comprehensive range of digital services to help your business succeed online.
          </p>
        </div>

        <div class="services-grid">
          <div
            v-for="service in services"
            :key="service.id"
            class="service-card"
          >
            <div class="service-icon">
              <img :src="service.icon" :alt="service.name" />
            </div>
            <h3 class="service-title">{{ service.name }}</h3>
            <p class="service-description">{{ service.description }}</p>
            <ul class="service-features">
              <li v-for="feature in service.features" :key="feature">
                {{ feature }}
              </li>
            </ul>
            <button class="service-btn">Learn More</button>
          </div>
        </div>
      </section>

      <section class="testimonials-section">
        <div class="section-header">
          <h2 class="section-title">What Our Clients Say</h2>
          <p class="section-description">
            Don't just take our word for it - hear from some of our satisfied clients.
          </p>
        </div>

        <div class="testimonials-grid">
          <div
            v-for="testimonial in testimonials"
            :key="testimonial.id"
            class="testimonial-card"
          >
            <div class="testimonial-content">
              <div class="quote-icon">
                <img src="/api/placeholder/40/40" alt="Quote decoration" />
              </div>
              <p class="testimonial-text">{{ testimonial.text }}</p>
            </div>
            <div class="testimonial-author">
              <img :src="testimonial.avatar" :alt="testimonial.name" class="author-avatar" />
              <div class="author-info">
                <h4 class="author-name">{{ testimonial.name }}</h4>
                <p class="author-title">{{ testimonial.title }}</p>
              </div>
            </div>
          </div>
        </div>
      </section>

      <section id="contact" class="contact-section">
        <div class="section-header">
          <h2 class="section-title">Get In Touch</h2>
          <p class="section-description">
            Ready to start your next project? We'd love to hear from you.
          </p>
        </div>

        <div class="contact-content">
          <div class="contact-info">
            <div class="contact-item">
              <div class="contact-icon">
                <img src="/api/placeholder/30/30" alt="Email icon" />
              </div>
              <div class="contact-details">
                <h4>Email Us</h4>
                <p>hello@creativestudio.com</p>
              </div>
            </div>
            <div class="contact-item">
              <div class="contact-icon">
                <img src="/api/placeholder/30/30" alt="Phone icon" />
              </div>
              <div class="contact-details">
                <h4>Call Us</h4>
                <p>+1 (555) 123-4567</p>
              </div>
            </div>
            <div class="contact-item">
              <div class="contact-icon">
                <img src="/api/placeholder/30/30" alt="Location icon" />
              </div>
              <div class="contact-details">
                <h4>Visit Us</h4>
                <p>123 Design Street, Creative City</p>
              </div>
            </div>
          </div>

          <form class="contact-form" @submit.prevent="submitForm">
            <div class="form-row">
              <div class="form-group">
                <label for="name">Name</label>
                <input type="text" id="name" v-model="form.name" required />
              </div>
              <div class="form-group">
                <label for="email">Email</label>
                <input type="email" id="email" v-model="form.email" required />
              </div>
            </div>
            <div class="form-group">
              <label for="subject">Subject</label>
              <input type="text" id="subject" v-model="form.subject" required />
            </div>
            <div class="form-group">
              <label for="message">Message</label>
              <textarea id="message" v-model="form.message" rows="5" required></textarea>
            </div>
            <button type="submit" class="submit-btn">Send Message</button>
          </form>
        </div>
      </section>
    </main>

    <footer class="site-footer">
      <div class="footer-content">
        <div class="footer-section">
          <div class="footer-logo">
            <img src="/api/placeholder/40/40" alt="Company logo" />
            <span>Creative Studio</span>
          </div>
          <p class="footer-description">
            Creating amazing digital experiences that help businesses grow and succeed online.
          </p>
          <div class="social-links">
            <a href="#" class="social-link">
              <img src="/api/placeholder/24/24" alt="Facebook" />
            </a>
            <a href="#" class="social-link">
              <img src="/api/placeholder/24/24" alt="Twitter" />
            </a>
            <a href="#" class="social-link">
              <img src="/api/placeholder/24/24" alt="Instagram" />
            </a>
            <a href="#" class="social-link">
              <img src="/api/placeholder/24/24" alt="LinkedIn" />
            </a>
          </div>
        </div>
        <div class="footer-section">
          <h4>Quick Links</h4>
          <ul class="footer-links">
            <li><a href="#home">Home</a></li>
            <li><a href="#about">About</a></li>
            <li><a href="#portfolio">Portfolio</a></li>
            <li><a href="#services">Services</a></li>
            <li><a href="#contact">Contact</a></li>
          </ul>
        </div>
        <div class="footer-section">
          <h4>Services</h4>
          <ul class="footer-links">
            <li><a href="#">Web Design</a></li>
            <li><a href="#">Branding</a></li>
            <li><a href="#">Digital Marketing</a></li>
            <li><a href="#">E-commerce</a></li>
            <li><a href="#">Mobile Apps</a></li>
          </ul>
        </div>
        <div class="footer-section">
          <h4>Contact Info</h4>
          <div class="contact-info">
            <p>📧 hello@creativestudio.com</p>
            <p>📞 +1 (555) 123-4567</p>
            <p>📍 123 Design Street, Creative City</p>
          </div>
        </div>
      </div>
      <div class="footer-bottom">
        <p>&copy; 2024 Creative Studio. All rights reserved.</p>
      </div>
    </footer>
  </div>
</template>

<script setup>
import { ref, computed } from 'vue'

const selectedCategory = ref('all')

const categories = ref([
  { id: 'all', name: 'All' },
  { id: 'web', name: 'Web Design' },
  { id: 'branding', name: 'Branding' },
  { id: 'mobile', name: 'Mobile Apps' },
  { id: 'ecommerce', name: 'E-commerce' }
])

const projects = ref([
  {
    id: 1,
    title: 'E-commerce Platform',
    description: 'Modern e-commerce solution with advanced features',
    image: '/api/placeholder/400/300',
    category: 'web',
    tags: ['React', 'Node.js', 'MongoDB']
  },
  {
    id: 2,
    title: 'Brand Identity Design',
    description: 'Complete brand identity for tech startup',
    image: '/api/placeholder/400/300',
    category: 'branding',
    tags: ['Logo Design', 'Brand Guidelines']
  },
  {
    id: 3,
    title: 'Mobile Banking App',
    description: 'Secure mobile banking application',
    image: '/api/placeholder/400/300',
    category: 'mobile',
    tags: ['React Native', 'Security']
  },
  {
    id: 4,
    title: 'Online Store',
    description: 'Custom e-commerce website with CMS',
    image: '/api/placeholder/400/300',
    category: 'ecommerce',
    tags: ['WordPress', 'WooCommerce']
  },
  {
    id: 5,
    title: 'Corporate Website',
    description: 'Professional corporate website design',
    image: '/api/placeholder/400/300',
    category: 'web',
    tags: ['Vue.js', 'Responsive']
  },
  {
    id: 6,
    title: 'Restaurant App',
    description: 'Food delivery and ordering mobile app',
    image: '/api/placeholder/400/300',
    category: 'mobile',
    tags: ['Flutter', 'Payment Integration']
  }
])

const services = ref([
  {
    id: 1,
    name: 'Web Design',
    description: 'Custom website design that reflects your brand',
    icon: '/api/placeholder/60/60',
    features: ['Responsive Design', 'User Experience', 'Modern UI/UX']
  },
  {
    id: 2,
    name: 'Branding',
    description: 'Complete brand identity and visual design',
    icon: '/api/placeholder/60/60',
    features: ['Logo Design', 'Brand Guidelines', 'Visual Identity']
  },
  {
    id: 3,
    name: 'Digital Marketing',
    description: 'Strategic digital marketing solutions',
    icon: '/api/placeholder/60/60',
    features: ['SEO', 'Social Media', 'Content Marketing']
  }
])

const testimonials = ref([
  {
    id: 1,
    name: 'Sarah Johnson',
    title: 'CEO, TechStart',
    text: 'Creative Studio transformed our digital presence completely. Their attention to detail and creative approach exceeded our expectations.',
    avatar: '/api/placeholder/60/60'
  },
  {
    id: 2,
    name: 'Michael Chen',
    title: 'Founder, RetailPro',
    text: 'The team delivered an amazing e-commerce platform that has significantly increased our online sales. Highly recommended!',
    avatar: '/api/placeholder/60/60'
  },
  {
    id: 3,
    name: 'Emily Davis',
    title: 'Marketing Director, BrandCo',
    text: 'Their branding work helped us establish a strong market presence. The new brand identity perfectly represents our values.',
    avatar: '/api/placeholder/60/60'
  }
])

const form = ref({
  name: '',
  email: '',
  subject: '',
  message: ''
})

const filteredProjects = computed(() => {
  if (selectedCategory.value === 'all') {
    return projects.value
  }
  return projects.value.filter(project => project.category === selectedCategory.value)
})

const submitForm = () => {
  alert('Thank you for your message! We\'ll get back to you soon.')
  form.value = {
    name: '',
    email: '',
    subject: '',
    message: ''
  }
}
</script>

<style scoped>
.portfolio-website {
  font-family: Arial, sans-serif;
  line-height: 1.6;
}

.site-header {
  background: white;
  box-shadow: 0 2px 10px rgba(0,0,0,0.1);
  position: sticky;
  top: 0;
  z-index: 100;
}

.header-content {
  max-width: 1200px;
  margin: 0 auto;
  padding: 0 20px;
  display: flex;
  justify-content: space-between;
  align-items: center;
  height: 80px;
}

.logo-section {
  display: flex;
  align-items: center;
  gap: 15px;
}

.logo {
  width: 50px;
  height: 50px;
  object-fit: contain;
}

.site-title {
  margin: 0;
  font-size: 24px;
  font-weight: bold;
  color: #333;
}

.main-navigation {
  display: flex;
}

.nav-list {
  display: flex;
  list-style: none;
  margin: 0;
  padding: 0;
  gap: 30px;
}

.nav-link {
  color: #333;
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
  padding: 0 20px;
}

.hero-section {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 60px;
  align-items: center;
  padding: 80px 0;
  min-height: 600px;
}

.hero-title {
  margin: 0 0 20px 0;
  font-size: 42px;
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
  padding: 15px 30px;
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
  transform: translateY(-2px);
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

.hero-visual {
  position: relative;
}

.hero-image {
  width: 100%;
  height: 400px;
  object-fit: cover;
  border-radius: 8px;
}

.decorative-elements {
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  pointer-events: none;
}

.decorative-shape {
  position: absolute;
  top: 20px;
  right: 20px;
  opacity: 0.7;
}

.decorative-circle {
  position: absolute;
  bottom: 20px;
  left: 20px;
  opacity: 0.5;
}

.about-section,
.portfolio-section,
.services-section,
.testimonials-section,
.contact-section {
  padding: 80px 0;
}

.section-header {
  text-align: center;
  margin-bottom: 60px;
}

.section-title {
  margin: 0 0 20px 0;
  font-size: 36px;
  color: #333;
}

.section-description {
  margin: 0;
  font-size: 18px;
  color: #666;
  max-width: 600px;
  margin: 0 auto;
}

.about-content {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 60px;
  align-items: center;
}

.about-text h3 {
  margin: 0 0 20px 0;
  font-size: 24px;
  color: #333;
}

.about-text p {
  margin: 0 0 30px 0;
  color: #666;
  line-height: 1.6;
}

.stats-grid {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 30px;
}

.stat-item {
  text-align: center;
}

.stat-number {
  font-size: 36px;
  font-weight: bold;
  color: #007bff;
  margin-bottom: 10px;
}

.stat-label {
  font-size: 14px;
  color: #666;
  text-transform: uppercase;
  letter-spacing: 1px;
}

.about-image {
  position: relative;
}

.team-image {
  width: 100%;
  height: 400px;
  object-fit: cover;
  border-radius: 8px;
}

.image-overlay {
  position: absolute;
  top: 20px;
  right: 20px;
}

.overlay-pattern {
  opacity: 0.3;
}

.portfolio-filter {
  display: flex;
  justify-content: center;
  gap: 20px;
  margin-bottom: 40px;
}

.filter-btn {
  padding: 10px 20px;
  background: white;
  border: 2px solid #ddd;
  border-radius: 25px;
  cursor: pointer;
  font-weight: 500;
  transition: all 0.2s ease;
}

.filter-btn.active,
.filter-btn:hover {
  background: #007bff;
  color: white;
  border-color: #007bff;
}

.portfolio-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
  gap: 30px;
}

.portfolio-item {
  background: white;
  border-radius: 8px;
  overflow: hidden;
  box-shadow: 0 4px 8px rgba(0,0,0,0.1);
  transition: transform 0.2s ease;
}

.portfolio-item:hover {
  transform: translateY(-4px);
}

.project-image {
  position: relative;
  height: 250px;
  overflow: hidden;
}

.project-image img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.project-overlay {
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: rgba(0,0,0,0.8);
  display: flex;
  align-items: center;
  justify-content: center;
  opacity: 0;
  transition: opacity 0.2s ease;
}

.portfolio-item:hover .project-overlay {
  opacity: 1;
}

.project-actions {
  display: flex;
  gap: 15px;
}

.action-btn {
  width: 50px;
  height: 50px;
  background: white;
  border: none;
  border-radius: 50%;
  cursor: pointer;
  font-size: 20px;
  display: flex;
  align-items: center;
  justify-content: center;
  transition: all 0.2s ease;
}

.action-btn:hover {
  background: #007bff;
  color: white;
}

.project-content {
  padding: 25px;
}

.project-title {
  margin: 0 0 10px 0;
  font-size: 20px;
  color: #333;
}

.project-description {
  margin: 0 0 15px 0;
  color: #666;
  line-height: 1.5;
}

.project-tags {
  display: flex;
  flex-wrap: wrap;
  gap: 8px;
}

.project-tag {
  background: #f8f9fa;
  color: #666;
  padding: 4px 12px;
  border-radius: 12px;
  font-size: 12px;
  font-weight: 500;
}

.services-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
  gap: 30px;
}

.service-card {
  background: white;
  padding: 40px 30px;
  border-radius: 8px;
  box-shadow: 0 4px 8px rgba(0,0,0,0.1);
  text-align: center;
  transition: transform 0.2s ease;
}

.service-card:hover {
  transform: translateY(-4px);
}

.service-icon {
  margin-bottom: 20px;
}

.service-icon img {
  width: 60px;
  height: 60px;
  object-fit: contain;
}

.service-title {
  margin: 0 0 15px 0;
  font-size: 22px;
  color: #333;
}

.service-description {
  margin: 0 0 20px 0;
  color: #666;
  line-height: 1.5;
}

.service-features {
  list-style: none;
  padding: 0;
  margin: 0 0 25px 0;
  text-align: left;
}

.service-features li {
  padding: 5px 0;
  color: #666;
  position: relative;
  padding-left: 20px;
}

.service-features li::before {
  content: '✓';
  position: absolute;
  left: 0;
  color: #007bff;
  font-weight: bold;
}

.service-btn {
  background: #007bff;
  color: white;
  border: none;
  padding: 12px 24px;
  border-radius: 6px;
  cursor: pointer;
  font-weight: bold;
  transition: background-color 0.2s ease;
}

.service-btn:hover {
  background: #0056b3;
}

.testimonials-section {
  background: #f8f9fa;
}

.testimonials-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
  gap: 30px;
}

.testimonial-card {
  background: white;
  padding: 30px;
  border-radius: 8px;
  box-shadow: 0 4px 8px rgba(0,0,0,0.1);
}

.testimonial-content {
  margin-bottom: 20px;
}

.quote-icon {
  margin-bottom: 15px;
}

.quote-icon img {
  width: 30px;
  height: 30px;
  opacity: 0.3;
}

.testimonial-text {
  margin: 0;
  color: #666;
  line-height: 1.6;
  font-style: italic;
}

.testimonial-author {
  display: flex;
  align-items: center;
  gap: 15px;
}

.author-avatar {
  width: 50px;
  height: 50px;
  border-radius: 50%;
  object-fit: cover;
}

.author-name {
  margin: 0 0 5px 0;
  font-size: 16px;
  color: #333;
}

.author-title {
  margin: 0;
  font-size: 14px;
  color: #666;
}

.contact-content {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 60px;
}

.contact-info {
  display: flex;
  flex-direction: column;
  gap: 30px;
}

.contact-item {
  display: flex;
  align-items: center;
  gap: 20px;
}

.contact-icon img {
  width: 30px;
  height: 30px;
  object-fit: contain;
}

.contact-details h4 {
  margin: 0 0 5px 0;
  font-size: 18px;
  color: #333;
}

.contact-details p {
  margin: 0;
  color: #666;
}

.contact-form {
  background: white;
  padding: 40px;
  border-radius: 8px;
  box-shadow: 0 4px 8px rgba(0,0,0,0.1);
}

.form-row {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 20px;
}

.form-group {
  margin-bottom: 20px;
}

.form-group label {
  display: block;
  margin-bottom: 8px;
  font-weight: bold;
  color: #333;
}

.form-group input,
.form-group textarea {
  width: 100%;
  padding: 12px;
  border: 1px solid #ddd;
  border-radius: 4px;
  font-size: 16px;
}

.form-group input:focus,
.form-group textarea:focus {
  outline: none;
  border-color: #007bff;
}

.submit-btn {
  background: #007bff;
  color: white;
  border: none;
  padding: 15px 30px;
  border-radius: 6px;
  cursor: pointer;
  font-size: 16px;
  font-weight: bold;
  transition: background-color 0.2s ease;
}

.submit-btn:hover {
  background: #0056b3;
}

.site-footer {
  background: #333;
  color: white;
  padding: 60px 0 20px;
}

.footer-content {
  max-width: 1200px;
  margin: 0 auto;
  padding: 0 20px;
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
  gap: 40px;
  margin-bottom: 40px;
}

.footer-logo {
  display: flex;
  align-items: center;
  gap: 10px;
  margin-bottom: 20px;
}

.footer-logo img {
  width: 30px;
  height: 30px;
  object-fit: contain;
}

.footer-logo span {
  font-size: 20px;
  font-weight: bold;
}

.footer-description {
  margin: 0 0 20px 0;
  color: #ccc;
  line-height: 1.6;
}

.social-links {
  display: flex;
  gap: 15px;
}

.social-link img {
  width: 24px;
  height: 24px;
  opacity: 0.7;
  transition: opacity 0.2s ease;
}

.social-link:hover img {
  opacity: 1;
}

.footer-section h4 {
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

.contact-info p {
  margin: 0 0 10px 0;
  color: #ccc;
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
    height: auto;
    padding: 20px;
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
    font-size: 32px;
  }

  .about-content {
    grid-template-columns: 1fr;
  }

  .stats-grid {
    grid-template-columns: 1fr;
  }

  .portfolio-filter {
    flex-wrap: wrap;
  }

  .portfolio-grid {
    grid-template-columns: 1fr;
  }

  .contact-content {
    grid-template-columns: 1fr;
  }

  .form-row {
    grid-template-columns: 1fr;
  }

  .footer-content {
    grid-template-columns: 1fr;
    text-align: center;
  }
}
</style>

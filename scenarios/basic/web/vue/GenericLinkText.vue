<template>
  <div class="blog-page">
    <h1>Company Blog</h1>
    <p>Stay updated with our latest insights and industry news.</p>
    
    <div class="articles-grid">
      <article class="article-card">
        <h2>The Future of Artificial Intelligence</h2>
        <p>
          Artificial intelligence is transforming industries across the globe. 
          From healthcare to finance, AI technologies are revolutionizing how 
          we work and live. This comprehensive analysis explores the current 
          state of AI and its potential impact on society.
        </p>
        <p>
          The article covers machine learning algorithms, neural networks, 
          and practical applications that are already changing our daily lives. 
          Discover how businesses are leveraging AI to improve efficiency and 
          create new opportunities.
        </p>
        <div class="article-footer">
          <span class="publish-date">Published 3 days ago</span>
          <a href="#" class="read-more-link">Read more</a>
        </div>
      </article>

      <article class="article-card">
        <h2>Sustainable Technology Solutions</h2>
        <p>
          As environmental concerns grow, technology companies are developing 
          innovative solutions to reduce carbon footprints and promote 
          sustainability. This report examines the latest green technologies 
          and their implementation across various sectors.
        </p>
        <p>
          Learn about renewable energy systems, smart grid technologies, 
          and sustainable manufacturing processes that are helping companies 
          achieve their environmental goals while maintaining profitability.
        </p>
        <div class="article-footer">
          <span class="publish-date">Published 1 week ago</span>
          <a href="#" class="read-more-link">Read more</a>
        </div>
      </article>

      <article class="article-card">
        <h2>Cybersecurity Best Practices</h2>
        <p>
          With cyber threats becoming more sophisticated, organizations must 
          implement robust security measures to protect their data and systems. 
          This guide provides essential cybersecurity strategies for businesses 
          of all sizes.
        </p>
        <p>
          The article covers threat detection, incident response planning, 
          employee training, and the latest security technologies that can 
          help safeguard your organization's digital assets.
        </p>
        <div class="article-footer">
          <span class="publish-date">Published 2 weeks ago</span>
          <a href="#" class="read-more-link">Read more</a>
        </div>
      </article>

      <article class="article-card">
        <h2>Remote Work Technology Trends</h2>
        <p>
          The shift to remote work has accelerated the adoption of new 
          technologies and collaboration tools. This analysis explores 
          the latest trends in remote work technology and their impact 
          on productivity and employee satisfaction.
        </p>
        <p>
          Discover the tools and platforms that are enabling effective 
          remote collaboration, from video conferencing solutions to 
          project management software and virtual reality workspaces.
        </p>
        <div class="article-footer">
          <span class="publish-date">Published 3 weeks ago</span>
          <a href="#" class="read-more-link">Read more</a>
        </div>
      </article>
    </div>

    <div class="social-section">
      <h2>Stay Connected</h2>
      <p>Follow us on social media for the latest updates and insights.</p>
      
      <div class="social-buttons">
        <a href="#" class="social-btn facebook">Follow us on Facebook</a>
        <a href="#" class="social-btn twitter">Follow us on Twitter</a>
        <a href="#" class="social-btn linkedin">Connect on LinkedIn</a>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'GenericLinkText'
}
</script>

<style scoped>
.blog-page {
  max-width: 800px;
  margin: 50px auto;
  padding: 20px;
  font-family: Arial, sans-serif;
}

.articles-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
  gap: 30px;
  margin-bottom: 40px;
}

.article-card {
  background: white;
  padding: 25px;
  border-radius: 8px;
  box-shadow: 0 2px 8px rgba(0,0,0,0.1);
  border: 1px solid #e0e0e0;
}

.article-card h2 {
  font-size: 22px;
  margin: 0 0 15px 0;
  color: #333;
}

.article-card p {
  font-size: 16px;
  line-height: 1.6;
  color: #666;
  margin: 0 0 20px 0;
}

.article-footer {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.publish-date {
  font-size: 14px;
  color: #999;
}

.read-more-link {
  color: #007bff;
  text-decoration: none;
  font-size: 14px;
  font-weight: bold;
}

.social-section {
  background: #f8f9fa;
  padding: 30px;
  border-radius: 8px;
  text-align: center;
}

.social-section h2 {
  font-size: 24px;
  margin: 0 0 15px 0;
  color: #333;
}

.social-section p {
  font-size: 16px;
  margin: 0 0 25px 0;
  color: #666;
}

.social-buttons {
  display: flex;
  gap: 15px;
  justify-content: center;
  flex-wrap: wrap;
}

.social-btn {
  padding: 10px 20px;
  border-radius: 4px;
  text-decoration: none;
  font-size: 14px;
  font-weight: bold;
  color: white;
}

.social-btn.facebook {
  background: #1877f2;
}

.social-btn.twitter {
  background: #1da1f2;
}

.social-btn.linkedin {
  background: #0077b5;
}
</style>

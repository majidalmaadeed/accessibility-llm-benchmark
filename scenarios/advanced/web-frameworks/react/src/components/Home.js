import React from 'react';
import { Link } from 'react-router-dom';

const Home = () => {
  const scenarios = [
    {
      title: 'Data Table Complex',
      description: 'Complex data table with sorting, filtering, and pagination',
      icon: '📊',
      path: '/data-table'
    },
    {
      title: 'Multi-Step Wizard',
      description: 'Multi-step form wizard with validation',
      icon: '🧙',
      path: '/wizard'
    },
    {
      title: 'Dashboard Widget',
      description: 'Interactive dashboard with charts and metrics',
      icon: '📈',
      path: '/dashboard'
    },
    {
      title: 'Media Player Full Interface',
      description: 'Full-featured media player interface',
      icon: '🎵',
      path: '/media-player'
    },
    {
      title: 'Shopping Cart System',
      description: 'E-commerce shopping cart system',
      icon: '🛒',
      path: '/shopping-cart'
    },
    {
      title: 'Calendar Application',
      description: 'Calendar application with events',
      icon: '📅',
      path: '/calendar'
    },
    {
      title: 'Rich Text Editor',
      description: 'Advanced rich text editing interface',
      icon: '✏️',
      path: '/rich-text-editor'
    },
    {
      title: 'Complex Search Interface',
      description: 'Complex search and filtering interface',
      icon: '🔍',
      path: '/search-interface'
    },
    {
      title: 'Interactive Map',
      description: 'Interactive map with markers and layers',
      icon: '🗺️',
      path: '/interactive-map'
    },
    {
      title: 'Social Media Feed',
      description: 'Social media feed with posts and interactions',
      icon: '📱',
      path: '/social-feed'
    }
  ];

  return (
    <div className="container">
      <div className="page-header">
        <h1 className="page-title">Accessibility Benchmark Scenarios</h1>
        <p className="page-subtitle">
          Advanced Cross-Platform Web Testing - React Framework
        </p>
        <p>
          Test accessibility scenarios across different web frameworks and platforms.
          Each scenario contains intentional accessibility violations for testing purposes.
        </p>
      </div>

      <div className="scenario-grid">
        {scenarios.map((scenario, index) => (
          <Link
            key={index}
            to={scenario.path}
            className="scenario-card"
          >
            <div style={{ fontSize: '2rem', marginBottom: '1rem' }}>
              {scenario.icon}
            </div>
            <h3>{scenario.title}</h3>
            <p>{scenario.description}</p>
            <button className="btn">Open Scenario</button>
          </Link>
        ))}
      </div>

      <div className="card" style={{ marginTop: '2rem' }}>
        <h2>About This Application</h2>
        <p>
          This application demonstrates various accessibility scenarios across different
          web frameworks. Each scenario is designed to test the ability of large language
          models to detect and fix accessibility violations.
        </p>
        <p>
          The scenarios include complex user interfaces with common accessibility issues
          that need to be identified and resolved for better user experience.
        </p>
        <div style={{ marginTop: '1rem' }}>
          <h3>Frameworks Covered:</h3>
          <ul>
            <li>React (Current)</li>
            <li>Vue.js</li>
            <li>Angular</li>
            <li>Svelte</li>
            <li>Next.js</li>
            <li>Nuxt.js</li>
            <li>SvelteKit</li>
          </ul>
        </div>
      </div>
    </div>
  );
};

export default Home;

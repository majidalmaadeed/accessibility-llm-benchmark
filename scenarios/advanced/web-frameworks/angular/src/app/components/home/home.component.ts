import { Component } from '@angular/core';

@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.css']
})
export class HomeComponent {
  scenarios = [
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
}

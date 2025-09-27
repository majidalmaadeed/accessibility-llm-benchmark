import { createRouter, createWebHistory } from 'vue-router'
import Home from '../views/Home.vue'
import DataTable from '../views/DataTable.vue'
import Wizard from '../views/Wizard.vue'
import Dashboard from '../views/Dashboard.vue'
import MediaPlayer from '../views/MediaPlayer.vue'
import ShoppingCart from '../views/ShoppingCart.vue'
import Calendar from '../views/Calendar.vue'
import RichTextEditor from '../views/RichTextEditor.vue'
import SearchInterface from '../views/SearchInterface.vue'
import InteractiveMap from '../views/InteractiveMap.vue'
import SocialFeed from '../views/SocialFeed.vue'

const routes = [
  {
    path: '/',
    name: 'Home',
    component: Home
  },
  {
    path: '/data-table',
    name: 'DataTable',
    component: DataTable
  },
  {
    path: '/wizard',
    name: 'Wizard',
    component: Wizard
  },
  {
    path: '/dashboard',
    name: 'Dashboard',
    component: Dashboard
  },
  {
    path: '/media-player',
    name: 'MediaPlayer',
    component: MediaPlayer
  },
  {
    path: '/shopping-cart',
    name: 'ShoppingCart',
    component: ShoppingCart
  },
  {
    path: '/calendar',
    name: 'Calendar',
    component: Calendar
  },
  {
    path: '/rich-text-editor',
    name: 'RichTextEditor',
    component: RichTextEditor
  },
  {
    path: '/search-interface',
    name: 'SearchInterface',
    component: SearchInterface
  },
  {
    path: '/interactive-map',
    name: 'InteractiveMap',
    component: InteractiveMap
  },
  {
    path: '/social-feed',
    name: 'SocialFeed',
    component: SocialFeed
  }
]

const router = createRouter({
  history: createWebHistory(process.env.BASE_URL),
  routes
})

export default router

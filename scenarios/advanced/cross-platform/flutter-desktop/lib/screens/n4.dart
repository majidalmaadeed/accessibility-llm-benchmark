import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../widgets/scenario_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UI Components'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue, Colors.blueAccent],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Advanced Cross-Platform Desktop Testing',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Test accessibility scenarios across different frameworks',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 30),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    children: const [
                      ScenarioCard(
                        title: 'Data Table Complex',
                        description: 'Complex data table with sorting, filtering, and pagination',
                        icon: Icons.table_chart,
                        route: '/data-table',
                      ),
                      ScenarioCard(
                        title: 'Multi-Step Wizard',
                        description: 'Multi-step form wizard with validation',
                        icon: Icons.wizard,
                        route: '/wizard',
                      ),
                      ScenarioCard(
                        title: 'Dashboard Widget',
                        description: 'Interactive dashboard with charts and metrics',
                        icon: Icons.dashboard,
                        route: '/dashboard',
                      ),
                      ScenarioCard(
                        title: 'Media Player',
                        description: 'Full-featured media player interface',
                        icon: Icons.play_circle,
                        route: '/media-player',
                      ),
                      ScenarioCard(
                        title: 'Shopping Cart',
                        description: 'E-commerce shopping cart system',
                        icon: Icons.shopping_cart,
                        route: '/shopping-cart',
                      ),
                      ScenarioCard(
                        title: 'Calendar App',
                        description: 'Calendar application with events',
                        icon: Icons.calendar_today,
                        route: '/calendar',
                      ),
                      ScenarioCard(
                        title: 'Rich Text Editor',
                        description: 'Advanced rich text editing interface',
                        icon: Icons.edit,
                        route: '/rich-text-editor',
                      ),
                      ScenarioCard(
                        title: 'Search Interface',
                        description: 'Complex search and filtering interface',
                        icon: Icons.search,
                        route: '/search-interface',
                      ),
                      ScenarioCard(
                        title: 'Interactive Map',
                        description: 'Interactive map with markers and layers',
                        icon: Icons.map,
                        route: '/interactive-map',
                      ),
                      ScenarioCard(
                        title: 'Social Media Feed',
                        description: 'Social media feed with posts and interactions',
                        icon: Icons.feed,
                        route: '/social-feed',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Action Panel',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ActionPanelPage(),
    );
  }
}

class ActionPanelPage extends StatefulWidget {
  @override
  _ActionPanelPageState createState() => _ActionPanelPageState();
}

class _ActionPanelPageState extends State<ActionPanelPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text('Action Panel'),
        backgroundColor: Colors.blue[700],
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.help),
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
              padding: EdgeInsets.all(24),
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
                    'Quick Actions',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Perform common tasks and operations',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: 30),
            
            // INSUFFICIENT BUTTON SPACING - Action buttons placed 2px apart instead of minimum 44px
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
                    'Primary Actions',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                  SizedBox(height: 20),
                  
                  // INSUFFICIENT BUTTON SPACING - Action buttons placed 2px apart instead of minimum 44px
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue[700],
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        child: Text('Save'),
                      ),
                      SizedBox(width: 2), // INSUFFICIENT BUTTON SPACING - Action buttons placed 2px apart instead of minimum 44px
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green[700],
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        child: Text('Submit'),
                      ),
                      SizedBox(width: 2), // INSUFFICIENT BUTTON SPACING - Action buttons placed 2px apart instead of minimum 44px
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange[700],
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        child: Text('Edit'),
                      ),
                      SizedBox(width: 2), // INSUFFICIENT BUTTON SPACING - Action buttons placed 2px apart instead of minimum 44px
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red[700],
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        child: Text('Delete'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            SizedBox(height: 20),
            
            // INSUFFICIENT BUTTON SPACING - Action buttons placed 2px apart instead of minimum 44px
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
                    'Secondary Actions',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                  SizedBox(height: 20),
                  
                  // INSUFFICIENT BUTTON SPACING - Action buttons placed 2px apart instead of minimum 44px
                  Row(
                    children: [
                      OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.blue[700],
                          side: BorderSide(color: Colors.blue[700]!, width: 2),
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        child: Text('Preview'),
                      ),
                      SizedBox(width: 2), // INSUFFICIENT BUTTON SPACING - Action buttons placed 2px apart instead of minimum 44px
                      OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.green[700],
                          side: BorderSide(color: Colors.green[700]!, width: 2),
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        child: Text('Export'),
                      ),
                      SizedBox(width: 2), // INSUFFICIENT BUTTON SPACING - Action buttons placed 2px apart instead of minimum 44px
                      OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.orange[700],
                          side: BorderSide(color: Colors.orange[700]!, width: 2),
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        child: Text('Print'),
                      ),
                      SizedBox(width: 2), // INSUFFICIENT BUTTON SPACING - Action buttons placed 2px apart instead of minimum 44px
                      OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.purple[700],
                          side: BorderSide(color: Colors.purple[700]!, width: 2),
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        child: Text('Share'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            SizedBox(height: 20),
            
            // INSUFFICIENT BUTTON SPACING - Action buttons placed 2px apart instead of minimum 44px
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
                    'Navigation Actions',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                  SizedBox(height: 20),
                  
                  // INSUFFICIENT BUTTON SPACING - Action buttons placed 2px apart instead of minimum 44px
                  Row(
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: Text('Previous'),
                      ),
                      SizedBox(width: 2), // INSUFFICIENT BUTTON SPACING - Action buttons placed 2px apart instead of minimum 44px
                      TextButton(
                        onPressed: () {},
                        child: Text('Next'),
                      ),
                      SizedBox(width: 2), // INSUFFICIENT BUTTON SPACING - Action buttons placed 2px apart instead of minimum 44px
                      TextButton(
                        onPressed: () {},
                        child: Text('First'),
                      ),
                      SizedBox(width: 2), // INSUFFICIENT BUTTON SPACING - Action buttons placed 2px apart instead of minimum 44px
                      TextButton(
                        onPressed: () {},
                        child: Text('Last'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            SizedBox(height: 20),
            
            // INSUFFICIENT BUTTON SPACING - Action buttons placed 2px apart instead of minimum 44px
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
                    'Icon Actions',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                  SizedBox(height: 20),
                  
                  // INSUFFICIENT BUTTON SPACING - Action buttons placed 2px apart instead of minimum 44px
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.edit),
                        color: Colors.blue[700],
                      ),
                      SizedBox(width: 2), // INSUFFICIENT BUTTON SPACING - Action buttons placed 2px apart instead of minimum 44px
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.copy),
                        color: Colors.green[700],
                      ),
                      SizedBox(width: 2), // INSUFFICIENT BUTTON SPACING - Action buttons placed 2px apart instead of minimum 44px
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.download),
                        color: Colors.orange[700],
                      ),
                      SizedBox(width: 2), // INSUFFICIENT BUTTON SPACING - Action buttons placed 2px apart instead of minimum 44px
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.upload),
                        color: Colors.purple[700],
                      ),
                      SizedBox(width: 2), // INSUFFICIENT BUTTON SPACING - Action buttons placed 2px apart instead of minimum 44px
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.delete),
                        color: Colors.red[700],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            SizedBox(height: 20),
            
            // INSUFFICIENT BUTTON SPACING - Action buttons placed 2px apart instead of minimum 44px
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
                    'Filter Actions',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                  SizedBox(height: 20),
                  
                  // INSUFFICIENT BUTTON SPACING - Action buttons placed 2px apart instead of minimum 44px
                  Wrap(
                    spacing: 2, // INSUFFICIENT BUTTON SPACING - Action buttons placed 2px apart instead of minimum 44px
                    runSpacing: 2, // INSUFFICIENT BUTTON SPACING - Action buttons placed 2px apart instead of minimum 44px
                    children: [
                      FilterChip(
                        label: Text('All'),
                        selected: true,
                        onSelected: (value) {},
                      ),
                      FilterChip(
                        label: Text('Active'),
                        selected: false,
                        onSelected: (value) {},
                      ),
                      FilterChip(
                        label: Text('Inactive'),
                        selected: false,
                        onSelected: (value) {},
                      ),
                      FilterChip(
                        label: Text('Pending'),
                        selected: false,
                        onSelected: (value) {},
                      ),
                      FilterChip(
                        label: Text('Completed'),
                        selected: false,
                        onSelected: (value) {},
                      ),
                      FilterChip(
                        label: Text('Archived'),
                        selected: false,
                        onSelected: (value) {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            SizedBox(height: 30),
            
            // INSUFFICIENT BUTTON SPACING - Action buttons placed 2px apart instead of minimum 44px
            Container(
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.amber[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.amber[200]!, width: 1),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.warning,
                        color: Colors.amber[700],
                        size: 24,
                      ),
                      SizedBox(width: 12),
                      Text(
                        'Button Spacing Notice',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.amber[800],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Text(
                    'The action buttons above are placed only 2px apart, which is insufficient for proper touch targets. Buttons should have a minimum of 44px spacing between them for better accessibility and usability.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.amber[700],
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: 30),
            
            // Properly Spaced Buttons Example
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
                    'Properly Spaced Buttons (Example)',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                  SizedBox(height: 20),
                  
                  // Properly spaced buttons with 16px spacing
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue[700],
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        child: Text('Save'),
                      ),
                      SizedBox(width: 16), // Proper spacing
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green[700],
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        child: Text('Submit'),
                      ),
                      SizedBox(width: 16), // Proper spacing
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange[700],
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        child: Text('Edit'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

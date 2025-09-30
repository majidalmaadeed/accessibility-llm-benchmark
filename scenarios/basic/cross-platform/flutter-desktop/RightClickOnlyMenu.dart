import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'File Manager',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: FileManagerPage(),
    );
  }
}

class FileManagerPage extends StatefulWidget {
  @override
  _FileManagerPageState createState() => _FileManagerPageState();
}

class _FileManagerPageState extends State<FileManagerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text('File Manager'),
        backgroundColor: Colors.blue[700],
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
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
                    'File Management System',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Organize and manage your files and folders',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: 30),
            
            // Quick Actions
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
                    'Quick Actions',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                  SizedBox(height: 20),
                  
                  Row(
                    children: [
                      _buildActionButton('Upload Files', Icons.upload, Colors.blue),
                      SizedBox(width: 16),
                      _buildActionButton('New Folder', Icons.folder, Colors.green),
                      SizedBox(width: 16),
                      _buildActionButton('Search', Icons.search, Colors.orange),
                      SizedBox(width: 16),
                      _buildActionButton('Settings', Icons.settings, Colors.purple),
                    ],
                  ),
                ],
              ),
            ),
            
            SizedBox(height: 30),
            
            // File List
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
                    'Project Files',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Right-click on any file to access options',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 20),
                  
                  _buildFileItem(
                    'project-proposal.docx',
                    'Modified: 2 hours ago • Size: 2.3 MB',
                    Icons.description,
                    Colors.blue,
                  ),
                  
                  _buildFileItem(
                    'budget-analysis.xlsx',
                    'Modified: 1 day ago • Size: 1.8 MB',
                    Icons.table_chart,
                    Colors.green,
                  ),
                  
                  _buildFileItem(
                    'design-mockup.psd',
                    'Modified: 3 days ago • Size: 15.2 MB',
                    Icons.image,
                    Colors.orange,
                  ),
                  
                  _buildFileItem(
                    'meeting-notes.txt',
                    'Modified: 1 week ago • Size: 0.5 MB',
                    Icons.note,
                    Colors.purple,
                  ),
                  
                  _buildFileItem(
                    'archive-folder',
                    'Modified: 2 weeks ago • 12 items',
                    Icons.folder,
                    Colors.teal,
                  ),
                ],
              ),
            ),
            
            SizedBox(height: 30),
            
            // RIGHT-CLICK ONLY MENU - Essential delete option only available via right-click
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
                        'Context Menu Notice',
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
                    'Some file operations are only available through right-click context menus. This includes essential functions like delete, rename, and properties. These options are not accessible via keyboard or other input methods.',
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
            
            // File Operations
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
                    'File Operations',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                  SizedBox(height: 20),
                  
                  Row(
                    children: [
                      Expanded(
                        child: _buildOperationCard(
                          'Open',
                          'View or edit the file',
                          Icons.open_in_new,
                          Colors.blue,
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: _buildOperationCard(
                          'Download',
                          'Save file to device',
                          Icons.download,
                          Colors.green,
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: _buildOperationCard(
                          'Share',
                          'Share with others',
                          Icons.share,
                          Colors.orange,
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: 16),
                  
                  Row(
                    children: [
                      Expanded(
                        child: _buildOperationCard(
                          'Rename',
                          'Change file name',
                          Icons.edit,
                          Colors.purple,
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: _buildOperationCard(
                          'Move',
                          'Move to another folder',
                          Icons.drive_file_move,
                          Colors.teal,
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: _buildOperationCard(
                          'Copy',
                          'Create a copy',
                          Icons.copy,
                          Colors.indigo,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            SizedBox(height: 30),
            
            // Recent Activity
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
                    'Recent Activity',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                  SizedBox(height: 20),
                  
                  _buildActivityItem('Created project-proposal.docx', '2 hours ago', Icons.add),
                  _buildActivityItem('Modified budget-analysis.xlsx', '1 day ago', Icons.edit),
                  _buildActivityItem('Created archive-folder', '2 weeks ago', Icons.folder),
                  _buildActivityItem('Uploaded design-mockup.psd', '3 days ago', Icons.upload),
                ],
              ),
            ),
            
            SizedBox(height: 30),
            
            // RIGHT-CLICK ONLY MENU - Essential delete option only available via right-click
            Container(
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.red[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.red[200]!, width: 1),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.error,
                        color: Colors.red[700],
                        size: 24,
                      ),
                      SizedBox(width: 12),
                      Text(
                        'Accessibility Issue',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.red[800],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Text(
                    'The delete function is only available through right-click context menus, making it inaccessible to keyboard users and users with certain disabilities. Essential functions should be available through multiple input methods.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.red[700],
                      height: 1.4,
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
  
  Widget _buildActionButton(String title, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3), width: 1),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 32,
          ),
          SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.grey[800],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
  
  Widget _buildFileItem(String name, String details, IconData icon, Color color) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[200]!, width: 1),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: color,
            size: 24,
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[800],
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  details,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          // RIGHT-CLICK ONLY MENU - Essential delete option only available via right-click
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.more_vert),
            color: Colors.grey[600],
          ),
        ],
      ),
    );
  }
  
  Widget _buildOperationCard(String title, String description, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[200]!, width: 1),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 32,
          ),
          SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.grey[800],
            ),
          ),
          SizedBox(height: 4),
          Text(
            description,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
  
  Widget _buildActivityItem(String activity, String time, IconData icon) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[200]!, width: 1),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.blue[700],
            size: 20,
          ),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              activity,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[800],
              ),
            ),
          ),
          Text(
            time,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class RightClickOnlyMenu extends StatefulWidget {
  const RightClickOnlyMenu({Key? key}) : super(key: key);

  @override
  State<RightClickOnlyMenu> createState() => _RightClickOnlyMenuState();
}

class _RightClickOnlyMenuState extends State<RightClickOnlyMenu> {
  Set<int> selectedItems = {};
  Map<int, Offset> contextMenuPositions = {};
  Map<int, bool> showContextMenus = {};

  final List<Map<String, dynamic>> files = [
    {
      'id': 1,
      'name': 'Project Proposal.docx',
      'type': 'document',
      'size': '2.4 MB',
      'lastModified': '2024-01-20',
      'author': 'John Smith',
      'icon': '📄'
    },
    {
      'id': 2,
      'name': 'Budget Report.xlsx',
      'type': 'spreadsheet',
      'size': '1.8 MB',
      'lastModified': '2024-01-19',
      'author': 'Sarah Johnson',
      'icon': '📊'
    },
    {
      'id': 3,
      'name': 'Meeting Notes.pdf',
      'type': 'pdf',
      'size': '856 KB',
      'lastModified': '2024-01-18',
      'author': 'Mike Chen',
      'icon': '📕'
    },
    {
      'id': 4,
      'name': 'Design Mockups.sketch',
      'type': 'design',
      'size': '15.2 MB',
      'lastModified': '2024-01-17',
      'author': 'Emily Davis',
      'icon': '🎨'
    },
    {
      'id': 5,
      'name': 'Contract Template.docx',
      'type': 'document',
      'size': '1.2 MB',
      'lastModified': '2024-01-16',
      'author': 'David Wilson',
      'icon': '📄'
    },
    {
      'id': 6,
      'name': 'User Research.pdf',
      'type': 'pdf',
      'size': '3.1 MB',
      'lastModified': '2024-01-15',
      'author': 'Lisa Brown',
      'icon': '📕'
    }
  ];

  void _handleItemPress(int itemId) {
    setState(() {
      if (selectedItems.contains(itemId)) {
        selectedItems.remove(itemId);
      } else {
        selectedItems.add(itemId);
      }
      // Close any open context menus
      showContextMenus.clear();
    });
  }

  void _handleLongPress(int itemId, Offset position) {
    setState(() {
      // RIGHT-CLICK ONLY MENU - Essential actions only available via long press
      contextMenuPositions[itemId] = position;
      showContextMenus[itemId] = true;
    });
  }

  void _handleContextMenuAction(String action, int itemId) {
    setState(() {
      showContextMenus[itemId] = false;
    });
    
    final file = files.firstWhere((f) => f['id'] == itemId);
    
    switch (action) {
      case 'view':
        _showSnackBar('Opening ${file['name']}');
        break;
      case 'edit':
        _showSnackBar('Editing ${file['name']}');
        break;
      case 'duplicate':
        _showSnackBar('Duplicating ${file['name']}');
        break;
      case 'share':
        _showSnackBar('Sharing ${file['name']}');
        break;
      case 'download':
        _showSnackBar('Downloading ${file['name']}');
        break;
      case 'delete':
        _showDeleteDialog(file);
        break;
      case 'properties':
        _showSnackBar('Properties for ${file['name']}');
        break;
      default:
        break;
    }
  }

  void _handleBulkAction(String action) {
    if (selectedItems.isEmpty) {
      _showSnackBar('Please select files first');
      return;
    }
    
    _showSnackBar('$action ${selectedItems.length} file(s)');
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void _showDeleteDialog(Map<String, dynamic> file) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete File'),
        content: Text('Are you sure you want to delete "${file['name']}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _showSnackBar('Deleted ${file['name']}');
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  String _formatDate(String dateString) {
    final date = DateTime.parse(dateString);
    return '${date.month}/${date.day}/${date.year}';
  }

  Color _getFileTypeColor(String type) {
    switch (type) {
      case 'document': return Colors.blue;
      case 'spreadsheet': return Colors.green;
      case 'pdf': return Colors.red;
      case 'design': return Colors.orange;
      default: return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('File Manager'),
        backgroundColor: Colors.blue[700],
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Search functionality
            },
          ),
          IconButton(
            icon: const Icon(Icons.view_list),
            onPressed: () {
              // View options
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Toolbar
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Bulk Actions
                if (selectedItems.isNotEmpty) ...[
                  ElevatedButton.icon(
                    onPressed: () => _handleBulkAction('Download'),
                    icon: const Icon(Icons.download, size: 16),
                    label: const Text('Download'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[700],
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton.icon(
                    onPressed: () => _handleBulkAction('Share'),
                    icon: const Icon(Icons.share, size: 16),
                    label: const Text('Share'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green[700],
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton.icon(
                    onPressed: () => _handleBulkAction('Delete'),
                    icon: const Icon(Icons.delete, size: 16),
                    label: const Text('Delete'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red[700],
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    ),
                  ),
                  const Spacer(),
                ] else
                  const Spacer(),
                
                // View Options
                IconButton(
                  icon: const Icon(Icons.grid_view),
                  onPressed: () {
                    // Grid view
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.list),
                  onPressed: () {
                    // List view
                  },
                ),
              ],
            ),
          ),
          
          // Files Grid
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: 0.8,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: files.length,
              itemBuilder: (context, index) {
                final file = files[index];
                return _buildFileCard(file);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFileCard(Map<String, dynamic> file) {
    final isSelected = selectedItems.contains(file['id']);
    final showContextMenu = showContextMenus[file['id']] == true;
    
    return GestureDetector(
      onTap: () => _handleItemPress(file['id']),
      onLongPress: () {
        // RIGHT-CLICK ONLY MENU - Essential actions only available via long press
        final RenderBox renderBox = context.findRenderObject() as RenderBox;
        final position = renderBox.localToGlobal(Offset.zero);
        _handleLongPress(file['id'], position);
      },
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: isSelected ? Border.all(color: Colors.blue, width: 2) : null,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // File Icon
                Expanded(
                  flex: 3,
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: _getFileTypeColor(file['type']).withOpacity(0.1),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          file['icon'],
                          style: const TextStyle(fontSize: 32),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: _getFileTypeColor(file['type']),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            file['type'].toUpperCase(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                
                // File Info
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // File Name
                        Text(
                          file['name'],
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        
                        const SizedBox(height: 4),
                        
                        // File Size
                        Text(
                          file['size'],
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                        
                        const SizedBox(height: 2),
                        
                        // Last Modified
                        Text(
                          _formatDate(file['lastModified']),
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.grey[500],
                          ),
                        ),
                        
                        const Spacer(),
                        
                        // Author
                        Text(
                          'By ${file['author']}',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.grey[500],
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Selection Indicator
          if (isSelected)
            Positioned(
              top: 8,
              right: 8,
              child: Container(
                width: 20,
                height: 20,
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check,
                  size: 14,
                  color: Colors.white,
                ),
              ),
            ),
          
          // Context Menu - RIGHT-CLICK ONLY MENU
          if (showContextMenu)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    showContextMenus[file['id']] = false;
                  });
                },
                child: Container(
                  color: Colors.transparent,
                  child: Center(
                    child: Container(
                      width: 200,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            spreadRadius: 2,
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _buildContextMenuItem('view', 'View', Icons.visibility),
                          _buildContextMenuItem('edit', 'Edit', Icons.edit),
                          _buildContextMenuItem('duplicate', 'Duplicate', Icons.copy),
                          _buildContextMenuItem('share', 'Share', Icons.share),
                          _buildContextMenuItem('download', 'Download', Icons.download),
                          const Divider(height: 1),
                          _buildContextMenuItem('properties', 'Properties', Icons.info),
                          _buildContextMenuItem('delete', 'Delete', Icons.delete, isDanger: true),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildContextMenuItem(String action, String label, IconData icon, {bool isDanger = false}) {
    return GestureDetector(
      onTap: () {
        // Find the file ID for this context menu
        final fileId = showContextMenus.keys.firstWhere(
          (id) => showContextMenus[id] == true,
          orElse: () => 0,
        );
        _handleContextMenuAction(action, fileId);
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Icon(
              icon,
              size: 16,
              color: isDanger ? Colors.red : Colors.grey[700],
            ),
            const SizedBox(width: 12),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: isDanger ? Colors.red : Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

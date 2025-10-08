import 'package:flutter/material.dart';

class StatusByShapeOnly extends StatefulWidget {
  const StatusByShapeOnly({Key? key}) : super(key: key);

  @override
  State<StatusByShapeOnly> createState() => _StatusByShapeOnlyState();
}

class _StatusByShapeOnlyState extends State<StatusByShapeOnly> {
  String selectedFilter = 'all';
  Set<int> selectedDocuments = {};

  final List<Map<String, dynamic>> documents = [
    {
      'id': 1,
      'name': 'Project Proposal.docx',
      'type': 'Document',
      'size': '2.4 MB',
      'lastModified': '2024-01-20',
      'status': 'approved', // Circle shape
      'author': 'John Smith',
      'department': 'Engineering',
    },
    {
      'id': 2,
      'name': 'Budget Report.xlsx',
      'type': 'Spreadsheet',
      'size': '1.8 MB',
      'lastModified': '2024-01-19',
      'status': 'pending', // Square shape
      'author': 'Sarah Johnson',
      'department': 'Finance',
    },
    {
      'id': 3,
      'name': 'Meeting Notes.pdf',
      'type': 'PDF',
      'size': '856 KB',
      'lastModified': '2024-01-18',
      'status': 'rejected', // Circle shape
      'author': 'Mike Chen',
      'department': 'Marketing',
    },
    {
      'id': 4,
      'name': 'Design Mockups.sketch',
      'type': 'Design',
      'size': '15.2 MB',
      'lastModified': '2024-01-17',
      'status': 'approved', // Circle shape
      'author': 'Emily Davis',
      'department': 'Design',
    },
    {
      'id': 5,
      'name': 'Contract Template.docx',
      'type': 'Document',
      'size': '1.2 MB',
      'lastModified': '2024-01-16',
      'status': 'pending', // Square shape
      'author': 'David Wilson',
      'department': 'Legal',
    },
    {
      'id': 6,
      'name': 'User Research.pdf',
      'type': 'PDF',
      'size': '3.1 MB',
      'lastModified': '2024-01-15',
      'status': 'rejected', // Circle shape
      'author': 'Lisa Brown',
      'department': 'Research',
    },
  ];

  List<Map<String, dynamic>> get filteredDocuments {
    if (selectedFilter == 'all') return documents;
    return documents.where((doc) => doc['status'] == selectedFilter).toList();
  }

  Widget _getStatusIcon(String status) {
    // STATUS BY SHAPE ONLY - No text labels, only shapes
    if (status == 'approved') {
      return Container(
        width: 20,
        height: 20,
        decoration: const BoxDecoration(
          color: Colors.green,
          shape: BoxShape.circle, // Circle for approved
        ),
      );
    } else if (status == 'pending') {
      return Container(
        width: 20,
        height: 20,
        decoration: const BoxDecoration(
          color: Colors.orange,
          shape: BoxShape.rectangle, // Square for pending
        ),
      );
    } else if (status == 'rejected') {
      return Container(
        width: 20,
        height: 20,
        decoration: const BoxDecoration(
          color: Colors.red,
          shape: BoxShape.circle, // Circle for rejected (same as approved!)
        ),
      );
    }
    return Container(
      width: 20,
      height: 20,
      decoration: const BoxDecoration(
        color: Colors.grey,
        shape: BoxShape.circle,
      ),
    );
  }

  Color _getStatusColor(String status) {
    if (status == 'approved') return Colors.green;
    if (status == 'pending') return Colors.orange;
    if (status == 'rejected') return Colors.red;
    return Colors.grey;
  }

  void _handleDocumentSelect(int documentId) {
    setState(() {
      if (selectedDocuments.contains(documentId)) {
        selectedDocuments.remove(documentId);
      } else {
        selectedDocuments.add(documentId);
      }
    });
  }

  void _handleBulkAction(String action) {
    if (selectedDocuments.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select documents first')),
      );
      return;
    }
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Bulk Action'),
        content: Text('$action ${selectedDocuments.length} document(s)?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // Perform bulk action
            },
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Document Management'),
        backgroundColor: Colors.blue[700],
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Filter Tabs
          Container(
            color: Colors.white,
            child: Row(
              children: [
                _buildFilterTab('all', 'All Documents'),
                _buildFilterTab('approved', '● Approved'),
                _buildFilterTab('pending', '■ Pending'),
                _buildFilterTab('rejected', '● Rejected'),
              ],
            ),
          ),
          
          // Bulk Actions
          if (selectedDocuments.isNotEmpty) _buildBulkActions(),
          
          // Documents List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: filteredDocuments.length,
              itemBuilder: (context, index) {
                final document = filteredDocuments[index];
                return _buildDocumentCard(document);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterTab(String filter, String label) {
    final isSelected = selectedFilter == filter;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedFilter = filter;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: isSelected ? Colors.blue : Colors.transparent,
                width: 2,
              ),
            ),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected ? Colors.blue : Colors.grey[600],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBulkActions() {
    return Container(
      color: Colors.blue[50],
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Text(
            '${selectedDocuments.length} document(s) selected',
            style: TextStyle(
              fontSize: 14,
              color: Colors.blue[700],
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () => _handleBulkAction('Approve'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                  child: const Text('Approve'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton(
                  onPressed: () => _handleBulkAction('Reject'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                  child: const Text('Reject'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton(
                  onPressed: () => _handleBulkAction('Download'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                  child: const Text('Download'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDocumentCard(Map<String, dynamic> document) {
    final isSelected = selectedDocuments.contains(document['id']);
    
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
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
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Selection Checkbox
            GestureDetector(
              onTap: () => _handleDocumentSelect(document['id']),
              child: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(4),
                  color: isSelected ? Colors.blue : Colors.transparent,
                ),
                child: isSelected
                    ? const Icon(
                        Icons.check,
                        size: 14,
                        color: Colors.white,
                      )
                    : null,
              ),
            ),
            const SizedBox(width: 12),
            
            // File Icon
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.blue[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                _getFileIcon(document['type']),
                color: Colors.blue[700],
                size: 20,
              ),
            ),
          ],
        ),
        title: Text(
          document['name'],
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              document['type'],
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Text(
                  document['size'],
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  '•',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  document['lastModified'],
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              'By ${document['author']} • ${document['department']}',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Status Icon - STATUS BY SHAPE ONLY
            _getStatusIcon(document['status']),
            const SizedBox(width: 12),
            
            // Action Buttons
            IconButton(
              icon: const Icon(Icons.visibility, size: 20),
              onPressed: () {
                // View document
              },
            ),
            IconButton(
              icon: const Icon(Icons.edit, size: 20),
              onPressed: () {
                // Edit document
              },
            ),
          ],
        ),
      ),
    );
  }

  IconData _getFileIcon(String type) {
    switch (type) {
      case 'Document':
        return Icons.description;
      case 'Spreadsheet':
        return Icons.table_chart;
      case 'PDF':
        return Icons.picture_as_pdf;
      case 'Design':
        return Icons.palette;
      default:
        return Icons.insert_drive_file;
    }
  }
}

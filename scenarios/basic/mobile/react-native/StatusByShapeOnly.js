import React, { useState } from 'react';
import {
  View,
  Text,
  TouchableOpacity,
  ScrollView,
  StyleSheet,
  Image,
  Alert,
} from 'react-native';

const StatusByShapeOnly = () => {
  const [selectedDocuments, setSelectedDocuments] = useState(new Set());
  const [filter, setFilter] = useState('all');

  const documents = [
    {
      id: 1,
      name: 'Project Proposal.docx',
      type: 'Document',
      size: '2.4 MB',
      lastModified: '2024-01-20',
      status: 'approved', // Circle shape
      author: 'John Smith',
      department: 'Engineering'
    },
    {
      id: 2,
      name: 'Budget Report.xlsx',
      type: 'Spreadsheet',
      size: '1.8 MB',
      lastModified: '2024-01-19',
      status: 'pending', // Square shape
      author: 'Sarah Johnson',
      department: 'Finance'
    },
    {
      id: 3,
      name: 'Meeting Notes.pdf',
      type: 'PDF',
      size: '856 KB',
      lastModified: '2024-01-18',
      status: 'rejected', // Circle shape
      author: 'Mike Chen',
      department: 'Marketing'
    },
    {
      id: 4,
      name: 'Design Mockups.sketch',
      type: 'Design',
      size: '15.2 MB',
      lastModified: '2024-01-17',
      status: 'approved', // Circle shape
      author: 'Emily Davis',
      department: 'Design'
    },
    {
      id: 5,
      name: 'Contract Template.docx',
      type: 'Document',
      size: '1.2 MB',
      lastModified: '2024-01-16',
      status: 'pending', // Square shape
      author: 'David Wilson',
      department: 'Legal'
    },
    {
      id: 6,
      name: 'User Research.pdf',
      type: 'PDF',
      size: '3.1 MB',
      lastModified: '2024-01-15',
      status: 'rejected', // Circle shape
      author: 'Lisa Brown',
      department: 'Research'
    }
  ];

  const getStatusIcon = (status) => {
    // STATUS BY SHAPE ONLY - No text labels, only shapes
    if (status === 'approved') {
      return '●'; // Circle for approved
    } else if (status === 'pending') {
      return '■'; // Square for pending
    } else if (status === 'rejected') {
      return '●'; // Circle for rejected (same as approved!)
    }
    return '○'; // Default circle
  };

  const getStatusColor = (status) => {
    if (status === 'approved') {
      return '#4CAF50'; // Green
    } else if (status === 'pending') {
      return '#FF9800'; // Orange
    } else if (status === 'rejected') {
      return '#F44336'; // Red
    }
    return '#9E9E9E'; // Gray
  };

  const handleDocumentSelect = (documentId) => {
    const newSelected = new Set(selectedDocuments);
    if (newSelected.has(documentId)) {
      newSelected.delete(documentId);
    } else {
      newSelected.add(documentId);
    }
    setSelectedDocuments(newSelected);
  };

  const handleBulkAction = (action) => {
    if (selectedDocuments.size === 0) {
      Alert.alert('No Selection', 'Please select documents first');
      return;
    }
    
    const actionText = action === 'approve' ? 'approve' : 
                     action === 'reject' ? 'reject' : 'download';
    Alert.alert(
      'Bulk Action', 
      `Are you sure you want to ${actionText} ${selectedDocuments.size} document(s)?`
    );
  };

  const filteredDocuments = documents.filter(doc => {
    if (filter === 'all') return true;
    return doc.status === filter;
  });

  const getFileIcon = (type) => {
    switch (type) {
      case 'Document': return '📄';
      case 'Spreadsheet': return '📊';
      case 'PDF': return '📕';
      case 'Design': return '🎨';
      default: return '📁';
    }
  };

  const formatDate = (dateString) => {
    const date = new Date(dateString);
    return date.toLocaleDateString('en-US', {
      month: 'short',
      day: 'numeric',
      year: 'numeric'
    });
  };

  return (
    <ScrollView style={styles.container}>
      {/* Header */}
      <View style={styles.header}>
        <Text style={styles.headerTitle}>Document Management</Text>
        <Text style={styles.headerSubtitle}>Review and manage documents</Text>
      </View>

      {/* Filter Tabs */}
      <View style={styles.filterContainer}>
        <TouchableOpacity 
          style={[styles.filterTab, filter === 'all' && styles.activeFilterTab]}
          onPress={() => setFilter('all')}
        >
          <Text style={[styles.filterText, filter === 'all' && styles.activeFilterText]}>
            All Documents
          </Text>
        </TouchableOpacity>
        <TouchableOpacity 
          style={[styles.filterTab, filter === 'approved' && styles.activeFilterTab]}
          onPress={() => setFilter('approved')}
        >
          <Text style={[styles.filterText, filter === 'approved' && styles.activeFilterText]}>
            ● Approved
          </Text>
        </TouchableOpacity>
        <TouchableOpacity 
          style={[styles.filterTab, filter === 'pending' && styles.activeFilterTab]}
          onPress={() => setFilter('pending')}
        >
          <Text style={[styles.filterText, filter === 'pending' && styles.activeFilterText]}>
            ■ Pending
          </Text>
        </TouchableOpacity>
        <TouchableOpacity 
          style={[styles.filterTab, filter === 'rejected' && styles.activeFilterTab]}
          onPress={() => setFilter('rejected')}
        >
          <Text style={[styles.filterText, filter === 'rejected' && styles.activeFilterText]}>
            ● Rejected
          </Text>
        </TouchableOpacity>
      </View>

      {/* Bulk Actions */}
      {selectedDocuments.size > 0 && (
        <View style={styles.bulkActionsContainer}>
          <Text style={styles.bulkActionsText}>
            {selectedDocuments.size} document(s) selected
          </Text>
          <View style={styles.bulkActions}>
            <TouchableOpacity 
              style={[styles.bulkActionButton, styles.approveButton]}
              onPress={() => handleBulkAction('approve')}
            >
              <Text style={styles.bulkActionText}>Approve</Text>
            </TouchableOpacity>
            <TouchableOpacity 
              style={[styles.bulkActionButton, styles.rejectButton]}
              onPress={() => handleBulkAction('reject')}
            >
              <Text style={styles.bulkActionText}>Reject</Text>
            </TouchableOpacity>
            <TouchableOpacity 
              style={[styles.bulkActionButton, styles.downloadButton]}
              onPress={() => handleBulkAction('download')}
            >
              <Text style={styles.bulkActionText}>Download</Text>
            </TouchableOpacity>
          </View>
        </View>
      )}

      {/* Documents List */}
      <View style={styles.documentsContainer}>
        {filteredDocuments.map((document) => (
          <TouchableOpacity
            key={document.id}
            style={[
              styles.documentCard,
              selectedDocuments.has(document.id) && styles.selectedDocumentCard
            ]}
            onPress={() => handleDocumentSelect(document.id)}
          >
            {/* Selection Checkbox */}
            <View style={styles.selectionContainer}>
              <View style={[
                styles.checkbox,
                selectedDocuments.has(document.id) && styles.checkedBox
              ]}>
                {selectedDocuments.has(document.id) && (
                  <Text style={styles.checkmark}>✓</Text>
                )}
              </View>
            </View>

            {/* File Icon */}
            <View style={styles.fileIconContainer}>
              <Text style={styles.fileIcon}>{getFileIcon(document.type)}</Text>
            </View>

            {/* Document Info */}
            <View style={styles.documentInfo}>
              <View style={styles.documentHeader}>
                <Text style={styles.documentName} numberOfLines={1}>
                  {document.name}
                </Text>
                <View style={styles.statusContainer}>
                  <Text style={[
                    styles.statusIcon,
                    { color: getStatusColor(document.status) }
                  ]}>
                    {getStatusIcon(document.status)}
                  </Text>
                </View>
              </View>

              <Text style={styles.documentType}>{document.type}</Text>
              
              <View style={styles.documentMeta}>
                <Text style={styles.metaText}>{document.size}</Text>
                <Text style={styles.metaText}>•</Text>
                <Text style={styles.metaText}>{formatDate(document.lastModified)}</Text>
              </View>

              <View style={styles.documentDetails}>
                <Text style={styles.authorText}>By {document.author}</Text>
                <Text style={styles.departmentText}>{document.department}</Text>
              </View>
            </View>

            {/* Action Buttons */}
            <View style={styles.actionButtons}>
              <TouchableOpacity style={styles.actionButton}>
                <Text style={styles.actionButtonText}>View</Text>
              </TouchableOpacity>
              <TouchableOpacity style={styles.actionButton}>
                <Text style={styles.actionButtonText}>Edit</Text>
              </TouchableOpacity>
            </View>
          </TouchableOpacity>
        ))}
      </View>

      {/* Legend - Only shows shapes, no text explanation */}
      <View style={styles.legendContainer}>
        <Text style={styles.legendTitle}>Status Legend</Text>
        <View style={styles.legendItems}>
          <View style={styles.legendItem}>
            <Text style={[styles.legendIcon, { color: '#4CAF50' }]}>●</Text>
            <Text style={styles.legendText}>Approved</Text>
          </View>
          <View style={styles.legendItem}>
            <Text style={[styles.legendIcon, { color: '#FF9800' }]}>■</Text>
            <Text style={styles.legendText}>Pending</Text>
          </View>
          <View style={styles.legendItem}>
            <Text style={[styles.legendIcon, { color: '#F44336' }]}>●</Text>
            <Text style={styles.legendText}>Rejected</Text>
          </View>
        </View>
      </View>
    </ScrollView>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#F5F5F5',
  },
  header: {
    backgroundColor: '#2C3E50',
    padding: 24,
    alignItems: 'center',
  },
  headerTitle: {
    fontSize: 24,
    fontWeight: 'bold',
    color: '#FFFFFF',
    marginBottom: 8,
  },
  headerSubtitle: {
    fontSize: 16,
    color: '#BDC3C7',
  },
  filterContainer: {
    flexDirection: 'row',
    padding: 16,
    backgroundColor: '#FFFFFF',
    borderBottomWidth: 1,
    borderBottomColor: '#E0E0E0',
  },
  filterTab: {
    paddingVertical: 8,
    paddingHorizontal: 16,
    marginRight: 8,
    borderRadius: 20,
    backgroundColor: '#F5F5F5',
  },
  activeFilterTab: {
    backgroundColor: '#3498DB',
  },
  filterText: {
    fontSize: 14,
    color: '#7F8C8D',
    fontWeight: '500',
  },
  activeFilterText: {
    color: '#FFFFFF',
  },
  bulkActionsContainer: {
    backgroundColor: '#E8F4FD',
    padding: 16,
    borderBottomWidth: 1,
    borderBottomColor: '#BBDEFB',
  },
  bulkActionsText: {
    fontSize: 14,
    color: '#1976D2',
    marginBottom: 12,
    fontWeight: '500',
  },
  bulkActions: {
    flexDirection: 'row',
    justifyContent: 'space-between',
  },
  bulkActionButton: {
    flex: 1,
    paddingVertical: 10,
    paddingHorizontal: 16,
    borderRadius: 6,
    marginHorizontal: 4,
    alignItems: 'center',
  },
  approveButton: {
    backgroundColor: '#4CAF50',
  },
  rejectButton: {
    backgroundColor: '#F44336',
  },
  downloadButton: {
    backgroundColor: '#2196F3',
  },
  bulkActionText: {
    color: '#FFFFFF',
    fontWeight: '600',
    fontSize: 14,
  },
  documentsContainer: {
    padding: 16,
  },
  documentCard: {
    backgroundColor: '#FFFFFF',
    borderRadius: 12,
    padding: 16,
    marginBottom: 12,
    flexDirection: 'row',
    alignItems: 'center',
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.1,
    shadowRadius: 4,
    elevation: 2,
  },
  selectedDocumentCard: {
    backgroundColor: '#E3F2FD',
    borderWidth: 2,
    borderColor: '#2196F3',
  },
  selectionContainer: {
    marginRight: 12,
  },
  checkbox: {
    width: 20,
    height: 20,
    borderWidth: 2,
    borderColor: '#BDBDBD',
    borderRadius: 4,
    justifyContent: 'center',
    alignItems: 'center',
  },
  checkedBox: {
    backgroundColor: '#2196F3',
    borderColor: '#2196F3',
  },
  checkmark: {
    color: '#FFFFFF',
    fontSize: 12,
    fontWeight: 'bold',
  },
  fileIconContainer: {
    marginRight: 12,
  },
  fileIcon: {
    fontSize: 24,
  },
  documentInfo: {
    flex: 1,
  },
  documentHeader: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    marginBottom: 4,
  },
  documentName: {
    fontSize: 16,
    fontWeight: '600',
    color: '#2C3E50',
    flex: 1,
  },
  statusContainer: {
    marginLeft: 8,
  },
  statusIcon: {
    fontSize: 20,
    fontWeight: 'bold',
  },
  documentType: {
    fontSize: 14,
    color: '#7F8C8D',
    marginBottom: 4,
  },
  documentMeta: {
    flexDirection: 'row',
    marginBottom: 8,
  },
  metaText: {
    fontSize: 12,
    color: '#95A5A6',
    marginRight: 8,
  },
  documentDetails: {
    flexDirection: 'row',
    justifyContent: 'space-between',
  },
  authorText: {
    fontSize: 12,
    color: '#7F8C8D',
  },
  departmentText: {
    fontSize: 12,
    color: '#7F8C8D',
  },
  actionButtons: {
    flexDirection: 'row',
    marginLeft: 12,
  },
  actionButton: {
    paddingVertical: 6,
    paddingHorizontal: 12,
    marginLeft: 8,
    backgroundColor: '#F5F5F5',
    borderRadius: 6,
  },
  actionButtonText: {
    fontSize: 12,
    color: '#2196F3',
    fontWeight: '500',
  },
  legendContainer: {
    backgroundColor: '#FFFFFF',
    margin: 16,
    padding: 16,
    borderRadius: 8,
    borderWidth: 1,
    borderColor: '#E0E0E0',
  },
  legendTitle: {
    fontSize: 16,
    fontWeight: '600',
    color: '#2C3E50',
    marginBottom: 12,
  },
  legendItems: {
    flexDirection: 'row',
    justifyContent: 'space-around',
  },
  legendItem: {
    flexDirection: 'row',
    alignItems: 'center',
  },
  legendIcon: {
    fontSize: 16,
    marginRight: 6,
  },
  legendText: {
    fontSize: 14,
    color: '#7F8C8D',
  },
});

export default StatusByShapeOnly;

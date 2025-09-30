import React, { useState } from 'react';
import {
  View,
  Text,
  TouchableOpacity,
  ScrollView,
  StyleSheet,
  Image,
  Alert,
  PanGestureHandler,
  State,
} from 'react-native';

const RightClickOnlyMenu = () => {
  const [selectedItems, setSelectedItems] = useState(new Set());
  const [contextMenuVisible, setContextMenuVisible] = useState(false);
  const [contextMenuPosition, setContextMenuPosition] = useState({ x: 0, y: 0 });
  const [contextMenuItem, setContextMenuItem] = useState(null);

  const files = [
    {
      id: 1,
      name: 'Project Proposal.docx',
      type: 'document',
      size: '2.4 MB',
      lastModified: '2024-01-20',
      author: 'John Smith',
      icon: '📄'
    },
    {
      id: 2,
      name: 'Budget Report.xlsx',
      type: 'spreadsheet',
      size: '1.8 MB',
      lastModified: '2024-01-19',
      author: 'Sarah Johnson',
      icon: '📊'
    },
    {
      id: 3,
      name: 'Meeting Notes.pdf',
      type: 'pdf',
      size: '856 KB',
      lastModified: '2024-01-18',
      author: 'Mike Chen',
      icon: '📕'
    },
    {
      id: 4,
      name: 'Design Mockups.sketch',
      type: 'design',
      size: '15.2 MB',
      lastModified: '2024-01-17',
      author: 'Emily Davis',
      icon: '🎨'
    },
    {
      id: 5,
      name: 'Contract Template.docx',
      type: 'document',
      size: '1.2 MB',
      lastModified: '2024-01-16',
      author: 'David Wilson',
      icon: '📄'
    },
    {
      id: 6,
      name: 'User Research.pdf',
      type: 'pdf',
      size: '3.1 MB',
      lastModified: '2024-01-15',
      author: 'Lisa Brown',
      icon: '📕'
    }
  ];

  const handleItemPress = (item) => {
    if (selectedItems.has(item.id)) {
      setSelectedItems(prev => {
        const newSet = new Set(prev);
        newSet.delete(item.id);
        return newSet;
      });
    } else {
      setSelectedItems(prev => new Set([...prev, item.id]));
    }
  };

  const handleLongPress = (item, event) => {
    // RIGHT-CLICK ONLY MENU - Essential actions only available via long press
    setContextMenuItem(item);
    setContextMenuPosition({ x: event.nativeEvent.pageX, y: event.nativeEvent.pageY });
    setContextMenuVisible(true);
  };

  const handleContextMenuAction = (action, item) => {
    setContextMenuVisible(false);
    
    switch (action) {
      case 'view':
        Alert.alert('View', `Opening ${item.name}`);
        break;
      case 'edit':
        Alert.alert('Edit', `Editing ${item.name}`);
        break;
      case 'duplicate':
        Alert.alert('Duplicate', `Duplicating ${item.name}`);
        break;
      case 'share':
        Alert.alert('Share', `Sharing ${item.name}`);
        break;
      case 'download':
        Alert.alert('Download', `Downloading ${item.name}`);
        break;
      case 'delete':
        Alert.alert('Delete', `Are you sure you want to delete ${item.name}?`);
        break;
      case 'properties':
        Alert.alert('Properties', `Properties for ${item.name}`);
        break;
      default:
        break;
    }
  };

  const handleBulkAction = (action) => {
    if (selectedItems.size === 0) {
      Alert.alert('No Selection', 'Please select files first');
      return;
    }
    
    Alert.alert('Bulk Action', `${action} ${selectedItems.size} file(s)`);
  };

  const formatDate = (dateString) => {
    const date = new Date(dateString);
    return date.toLocaleDateString('en-US', {
      month: 'short',
      day: 'numeric',
      year: 'numeric'
    });
  };

  const getFileTypeColor = (type) => {
    switch (type) {
      case 'document': return '#2196F3';
      case 'spreadsheet': return '#4CAF50';
      case 'pdf': return '#F44336';
      case 'design': return '#FF9800';
      default: return '#9E9E9E';
    }
  };

  const renderContextMenu = () => {
    if (!contextMenuVisible || !contextMenuItem) return null;

    return (
      <View style={[
        styles.contextMenu,
        {
          left: contextMenuPosition.x - 100,
          top: contextMenuPosition.y - 50,
        }
      ]}>
        <TouchableOpacity
          style={styles.contextMenuItem}
          onPress={() => handleContextMenuAction('view', contextMenuItem)}
        >
          <Text style={styles.contextMenuIcon}>👁️</Text>
          <Text style={styles.contextMenuText}>View</Text>
        </TouchableOpacity>
        
        <TouchableOpacity
          style={styles.contextMenuItem}
          onPress={() => handleContextMenuAction('edit', contextMenuItem)}
        >
          <Text style={styles.contextMenuIcon}>✏️</Text>
          <Text style={styles.contextMenuText}>Edit</Text>
        </TouchableOpacity>
        
        <TouchableOpacity
          style={styles.contextMenuItem}
          onPress={() => handleContextMenuAction('duplicate', contextMenuItem)}
        >
          <Text style={styles.contextMenuIcon}>📋</Text>
          <Text style={styles.contextMenuText}>Duplicate</Text>
        </TouchableOpacity>
        
        <TouchableOpacity
          style={styles.contextMenuItem}
          onPress={() => handleContextMenuAction('share', contextMenuItem)}
        >
          <Text style={styles.contextMenuIcon}>🔗</Text>
          <Text style={styles.contextMenuText}>Share</Text>
        </TouchableOpacity>
        
        <TouchableOpacity
          style={styles.contextMenuItem}
          onPress={() => handleContextMenuAction('download', contextMenuItem)}
        >
          <Text style={styles.contextMenuIcon}>⬇️</Text>
          <Text style={styles.contextMenuText}>Download</Text>
        </TouchableOpacity>
        
        <View style={styles.contextMenuDivider} />
        
        <TouchableOpacity
          style={styles.contextMenuItem}
          onPress={() => handleContextMenuAction('properties', contextMenuItem)}
        >
          <Text style={styles.contextMenuIcon}>ℹ️</Text>
          <Text style={styles.contextMenuText}>Properties</Text>
        </TouchableOpacity>
        
        <TouchableOpacity
          style={[styles.contextMenuItem, styles.dangerItem]}
          onPress={() => handleContextMenuAction('delete', contextMenuItem)}
        >
          <Text style={styles.contextMenuIcon}>🗑️</Text>
          <Text style={[styles.contextMenuText, styles.dangerText]}>Delete</Text>
        </TouchableOpacity>
      </View>
    );
  };

  return (
    <ScrollView style={styles.container}>
      {/* Header */}
      <View style={styles.header}>
        <Text style={styles.headerTitle}>File Manager</Text>
        <Text style={styles.headerSubtitle}>Manage your files and documents</Text>
      </View>

      {/* Toolbar */}
      <View style={styles.toolbar}>
        <View style={styles.toolbarLeft}>
          <TouchableOpacity
            style={styles.toolbarButton}
            onPress={() => handleBulkAction('Download')}
          >
            <Text style={styles.toolbarIcon}>⬇️</Text>
            <Text style={styles.toolbarText}>Download</Text>
          </TouchableOpacity>
          
          <TouchableOpacity
            style={styles.toolbarButton}
            onPress={() => handleBulkAction('Share')}
          >
            <Text style={styles.toolbarIcon}>🔗</Text>
            <Text style={styles.toolbarText}>Share</Text>
          </TouchableOpacity>
          
          <TouchableOpacity
            style={styles.toolbarButton}
            onPress={() => handleBulkAction('Move')}
          >
            <Text style={styles.toolbarIcon}>📁</Text>
            <Text style={styles.toolbarText}>Move</Text>
          </TouchableOpacity>
        </View>
        
        <View style={styles.toolbarRight}>
          <TouchableOpacity
            style={[styles.toolbarButton, styles.dangerButton]}
            onPress={() => handleBulkAction('Delete')}
          >
            <Text style={styles.toolbarIcon}>🗑️</Text>
            <Text style={styles.toolbarText}>Delete</Text>
          </TouchableOpacity>
        </View>
      </View>

      {/* Files Grid */}
      <View style={styles.filesContainer}>
        <Text style={styles.sectionTitle}>
          Files ({files.length})
          {selectedItems.size > 0 && ` - ${selectedItems.size} selected`}
        </Text>
        
        <View style={styles.filesGrid}>
          {files.map((file) => (
            <TouchableOpacity
              key={file.id}
              style={[
                styles.fileCard,
                selectedItems.has(file.id) && styles.selectedFileCard
              ]}
              onPress={() => handleItemPress(file)}
              onLongPress={(event) => handleLongPress(file, event)}
              // RIGHT-CLICK ONLY MENU - Essential actions only available via long press
            >
              {/* Selection Indicator */}
              <View style={styles.selectionIndicator}>
                {selectedItems.has(file.id) && (
                  <View style={styles.selectedIndicator}>
                    <Text style={styles.checkmark}>✓</Text>
                  </View>
                )}
              </View>

              {/* File Icon */}
              <View style={styles.fileIconContainer}>
                <Text style={styles.fileIcon}>{file.icon}</Text>
                <View style={[
                  styles.fileTypeIndicator,
                  { backgroundColor: getFileTypeColor(file.type) }
                ]} />
              </View>

              {/* File Info */}
              <View style={styles.fileInfo}>
                <Text style={styles.fileName} numberOfLines={2}>
                  {file.name}
                </Text>
                
                <View style={styles.fileMeta}>
                  <Text style={styles.fileSize}>{file.size}</Text>
                  <Text style={styles.fileDate}>{formatDate(file.lastModified)}</Text>
                </View>
                
                <Text style={styles.fileAuthor}>By {file.author}</Text>
              </View>

              {/* Action Buttons - Limited actions available */}
              <View style={styles.fileActions}>
                <TouchableOpacity
                  style={styles.actionButton}
                  onPress={() => Alert.alert('View', `Opening ${file.name}`)}
                >
                  <Text style={styles.actionIcon}>👁️</Text>
                </TouchableOpacity>
                
                <TouchableOpacity
                  style={styles.actionButton}
                  onPress={() => Alert.alert('Download', `Downloading ${file.name}`)}
                >
                  <Text style={styles.actionIcon}>⬇️</Text>
                </TouchableOpacity>
              </View>
            </TouchableOpacity>
          ))}
        </View>
      </View>

      {/* Context Menu */}
      {renderContextMenu()}

      {/* Footer Info */}
      <View style={styles.footer}>
        <Text style={styles.footerText}>
          Long press on files for more options
        </Text>
        <Text style={styles.footerSubtext}>
          Essential actions like edit, duplicate, share, and delete are only available via long press
        </Text>
      </View>
    </ScrollView>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#F8F9FA',
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
  toolbar: {
    backgroundColor: '#FFFFFF',
    padding: 16,
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    borderBottomWidth: 1,
    borderBottomColor: '#E0E0E0',
  },
  toolbarLeft: {
    flexDirection: 'row',
  },
  toolbarRight: {
    flexDirection: 'row',
  },
  toolbarButton: {
    flexDirection: 'row',
    alignItems: 'center',
    paddingVertical: 8,
    paddingHorizontal: 12,
    marginRight: 8,
    borderRadius: 6,
    backgroundColor: '#F5F5F5',
  },
  toolbarIcon: {
    fontSize: 16,
    marginRight: 4,
  },
  toolbarText: {
    fontSize: 14,
    color: '#2C3E50',
    fontWeight: '500',
  },
  dangerButton: {
    backgroundColor: '#FFEBEE',
  },
  filesContainer: {
    padding: 16,
  },
  sectionTitle: {
    fontSize: 18,
    fontWeight: '600',
    color: '#2C3E50',
    marginBottom: 16,
  },
  filesGrid: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    justifyContent: 'space-between',
  },
  fileCard: {
    width: '48%',
    backgroundColor: '#FFFFFF',
    borderRadius: 12,
    padding: 16,
    marginBottom: 16,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.1,
    shadowRadius: 4,
    elevation: 2,
    position: 'relative',
  },
  selectedFileCard: {
    backgroundColor: '#E3F2FD',
    borderWidth: 2,
    borderColor: '#2196F3',
  },
  selectionIndicator: {
    position: 'absolute',
    top: 8,
    right: 8,
    zIndex: 1,
  },
  selectedIndicator: {
    width: 20,
    height: 20,
    borderRadius: 10,
    backgroundColor: '#2196F3',
    justifyContent: 'center',
    alignItems: 'center',
  },
  checkmark: {
    color: '#FFFFFF',
    fontSize: 12,
    fontWeight: 'bold',
  },
  fileIconContainer: {
    alignItems: 'center',
    marginBottom: 12,
    position: 'relative',
  },
  fileIcon: {
    fontSize: 32,
  },
  fileTypeIndicator: {
    width: 8,
    height: 8,
    borderRadius: 4,
    position: 'absolute',
    bottom: -2,
    right: '50%',
    marginRight: -4,
  },
  fileInfo: {
    marginBottom: 12,
  },
  fileName: {
    fontSize: 14,
    fontWeight: '600',
    color: '#2C3E50',
    marginBottom: 8,
    lineHeight: 18,
  },
  fileMeta: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    marginBottom: 4,
  },
  fileSize: {
    fontSize: 12,
    color: '#7F8C8D',
  },
  fileDate: {
    fontSize: 12,
    color: '#7F8C8D',
  },
  fileAuthor: {
    fontSize: 12,
    color: '#7F8C8D',
  },
  fileActions: {
    flexDirection: 'row',
    justifyContent: 'space-around',
  },
  actionButton: {
    width: 32,
    height: 32,
    borderRadius: 16,
    backgroundColor: '#F5F5F5',
    justifyContent: 'center',
    alignItems: 'center',
  },
  actionIcon: {
    fontSize: 14,
  },
  contextMenu: {
    position: 'absolute',
    backgroundColor: '#FFFFFF',
    borderRadius: 8,
    paddingVertical: 8,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 4 },
    shadowOpacity: 0.3,
    shadowRadius: 8,
    elevation: 8,
    zIndex: 1000,
    minWidth: 150,
  },
  contextMenuItem: {
    flexDirection: 'row',
    alignItems: 'center',
    paddingVertical: 12,
    paddingHorizontal: 16,
  },
  contextMenuIcon: {
    fontSize: 16,
    marginRight: 12,
    width: 20,
  },
  contextMenuText: {
    fontSize: 14,
    color: '#2C3E50',
    flex: 1,
  },
  contextMenuDivider: {
    height: 1,
    backgroundColor: '#E0E0E0',
    marginVertical: 4,
  },
  dangerItem: {
    // Special styling for dangerous actions
  },
  dangerText: {
    color: '#F44336',
  },
  footer: {
    backgroundColor: '#FFFFFF',
    padding: 16,
    borderTopWidth: 1,
    borderTopColor: '#E0E0E0',
    alignItems: 'center',
  },
  footerText: {
    fontSize: 14,
    color: '#7F8C8D',
    marginBottom: 4,
  },
  footerSubtext: {
    fontSize: 12,
    color: '#9E9E9E',
    textAlign: 'center',
  },
});

export default RightClickOnlyMenu;

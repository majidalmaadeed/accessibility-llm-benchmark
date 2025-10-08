import React, { useState, useMemo } from 'react';
import {
  View,
  Text,
  TextInput,
  TouchableOpacity,
  ScrollView,
  StyleSheet,
  FlatList,
  Alert,
  Switch,
  Modal,
  Dimensions,
} from 'react-native';
import { Ionicons } from '@expo/vector-icons';

const { width } = Dimensions.get('window');

const DataTableComplex = () => {
  const [searchQuery, setSearchQuery] = useState('');
  const [sortColumn, setSortColumn] = useState('name');
  const [sortDirection, setSortDirection] = useState('asc');
  const [selectedRows, setSelectedRows] = useState(new Set());
  const [currentPage, setCurrentPage] = useState(1);
  const [showFilters, setShowFilters] = useState(false);
  const [departmentFilter, setDepartmentFilter] = useState('All');
  const [statusFilter, setStatusFilter] = useState('All');
  const [itemsPerPage, setItemsPerPage] = useState(10);
  const [showBulkActions, setShowBulkActions] = useState(false);

  const departments = ['All', 'Engineering', 'Marketing', 'Sales', 'HR', 'Finance'];
  const statuses = ['All', 'Active', 'Inactive', 'Pending', 'Terminated'];

  const sampleData = [
    { id: '1', name: 'John Doe', email: 'john@example.com', department: 'Engineering', salary: 75000, status: 'Active', joinDate: '2023-01-15' },
    { id: '2', name: 'Jane Smith', email: 'jane@example.com', department: 'Marketing', salary: 65000, status: 'Active', joinDate: '2023-02-20' },
    { id: '3', name: 'Mike Johnson', email: 'mike@example.com', department: 'Sales', salary: 70000, status: 'Inactive', joinDate: '2023-03-10' },
    { id: '4', name: 'Sarah Wilson', email: 'sarah@example.com', department: 'HR', salary: 60000, status: 'Active', joinDate: '2023-04-05' },
    { id: '5', name: 'David Brown', email: 'david@example.com', department: 'Finance', salary: 80000, status: 'Active', joinDate: '2023-05-12' },
    { id: '6', name: 'Lisa Davis', email: 'lisa@example.com', department: 'Engineering', salary: 72000, status: 'Active', joinDate: '2023-06-18' },
    { id: '7', name: 'Tom Miller', email: 'tom@example.com', department: 'Marketing', salary: 68000, status: 'Inactive', joinDate: '2023-07-22' },
    { id: '8', name: 'Amy Garcia', email: 'amy@example.com', department: 'Sales', salary: 69000, status: 'Active', joinDate: '2023-08-30' },
    { id: '9', name: 'Chris Lee', email: 'chris@example.com', department: 'HR', salary: 62000, status: 'Active', joinDate: '2023-09-14' },
    { id: '10', name: 'Emma Taylor', email: 'emma@example.com', department: 'Finance', salary: 78000, status: 'Active', joinDate: '2023-10-08' },
  ];

  const filteredData = useMemo(() => {
    return sampleData.filter(row => {
      const matchesSearch = row.name.toLowerCase().includes(searchQuery.toLowerCase()) ||
                           row.email.toLowerCase().includes(searchQuery.toLowerCase());
      const matchesDepartment = departmentFilter === 'All' || row.department === departmentFilter;
      const matchesStatus = statusFilter === 'All' || row.status === statusFilter;
      return matchesSearch && matchesDepartment && matchesStatus;
    });
  }, [sampleData, searchQuery, departmentFilter, statusFilter]);

  const sortedData = useMemo(() => {
    return [...filteredData].sort((a, b) => {
      let comparison = 0;
      switch (sortColumn) {
        case 'name':
          comparison = a.name.localeCompare(b.name);
          break;
        case 'email':
          comparison = a.email.localeCompare(b.email);
        case 'department':
          comparison = a.department.localeCompare(b.department);
          break;
        case 'salary':
          comparison = a.salary - b.salary;
          break;
        case 'status':
          comparison = a.status.localeCompare(b.status);
          break;
        case 'joinDate':
          comparison = a.joinDate.localeCompare(b.joinDate);
          break;
        default:
          comparison = 0;
      }
      return sortDirection === 'asc' ? comparison : -comparison;
    });
  }, [filteredData, sortColumn, sortDirection]);

  const totalPages = Math.ceil(sortedData.length / itemsPerPage);
  const startIndex = (currentPage - 1) * itemsPerPage;
  const endIndex = Math.min(startIndex + itemsPerPage, sortedData.length);
  const pageData = sortedData.slice(startIndex, endIndex);

  const handleSort = (column) => {
    if (sortColumn === column) {
      setSortDirection(sortDirection === 'asc' ? 'desc' : 'asc');
    } else {
      setSortColumn(column);
      setSortDirection('asc');
    }
  };

  const handleSelectAll = () => {
    if (selectedRows.size === pageData.length) {
      setSelectedRows(new Set());
    } else {
      setSelectedRows(new Set(pageData.map(row => row.id)));
    }
  };

  const handleSelectRow = (id) => {
    const newSelected = new Set(selectedRows);
    if (newSelected.has(id)) {
      newSelected.delete(id);
    } else {
      newSelected.add(id);
    }
    setSelectedRows(newSelected);
  };

  const handleBulkAction = (action) => {
    if (selectedRows.size === 0) {
      Alert.alert('No Selection', 'Please select items to perform bulk actions');
      return;
    }
    Alert.alert('Bulk Action', `${action} ${selectedRows.size} selected items`);
  };

  const handleExport = (format) => {
    Alert.alert('Export', `Exporting data as ${format}`);
  };

  const clearFilters = () => {
    setSearchQuery('');
    setDepartmentFilter('All');
    setStatusFilter('All');
    setCurrentPage(1);
  };

  const renderHeader = () => (
    <View style={styles.header}>
      <Text style={styles.headerTitle}>Employee Data Table</Text>
      <View style={styles.headerActions}>
        <TouchableOpacity
          style={styles.headerButton}
          onPress={() => setShowFilters(!showFilters)}
        >
          <Ionicons name="filter" size={20} color="#007AFF" />
          <Text style={styles.headerButtonText}>Filter</Text>
        </TouchableOpacity>
        <TouchableOpacity
          style={styles.headerButton}
          onPress={() => handleExport('CSV')}
        >
          <Ionicons name="download" size={20} color="#007AFF" />
          <Text style={styles.headerButtonText}>Export</Text>
        </TouchableOpacity>
      </View>
    </View>
  );

  const renderSearchBar = () => (
    <View style={styles.searchContainer}>
      <View style={styles.searchInputContainer}>
        <Ionicons name="search" size={20} color="#666" style={styles.searchIcon} />
        <TextInput
          style={styles.searchInput}
          placeholder="Search employees..."
          value={searchQuery}
          onChangeText={setSearchQuery}
          placeholderTextColor="#666"
        />
      </View>
      <TouchableOpacity
        style={styles.filterButton}
        onPress={() => setShowFilters(!showFilters)}
      >
        <Text style={styles.filterButtonText}>Filter</Text>
        <Ionicons name="chevron-down" size={16} color="#007AFF" />
      </TouchableOpacity>
    </View>
  );

  const renderFilters = () => (
    <Modal
      visible={showFilters}
      animationType="slide"
      transparent={true}
      onRequestClose={() => setShowFilters(false)}
    >
      <View style={styles.modalOverlay}>
        <View style={styles.modalContent}>
          <View style={styles.modalHeader}>
            <Text style={styles.modalTitle}>Filters</Text>
            <TouchableOpacity onPress={() => setShowFilters(false)}>
              <Ionicons name="close" size={24} color="#666" />
            </TouchableOpacity>
          </View>
          
          <View style={styles.filterSection}>
            <Text style={styles.filterLabel}>Department</Text>
            <ScrollView horizontal showsHorizontalScrollIndicator={false}>
              {departments.map(dept => (
                <TouchableOpacity
                  key={dept}
                  style={[
                    styles.filterChip,
                    departmentFilter === dept && styles.filterChipActive
                  ]}
                  onPress={() => setDepartmentFilter(dept)}
                >
                  <Text style={[
                    styles.filterChipText,
                    departmentFilter === dept && styles.filterChipTextActive
                  ]}>
                    {dept}
                  </Text>
                </TouchableOpacity>
              ))}
            </ScrollView>
          </View>

          <View style={styles.filterSection}>
            <Text style={styles.filterLabel}>Status</Text>
            <ScrollView horizontal showsHorizontalScrollIndicator={false}>
              {statuses.map(status => (
                <TouchableOpacity
                  key={status}
                  style={[
                    styles.filterChip,
                    statusFilter === status && styles.filterChipActive
                  ]}
                  onPress={() => setStatusFilter(status)}
                >
                  <Text style={[
                    styles.filterChipText,
                    statusFilter === status && styles.filterChipTextActive
                  ]}>
                    {status}
                  </Text>
                </TouchableOpacity>
              ))}
            </ScrollView>
          </View>

          <View style={styles.modalActions}>
            <TouchableOpacity
              style={styles.clearButton}
              onPress={clearFilters}
            >
              <Text style={styles.clearButtonText}>Clear All</Text>
            </TouchableOpacity>
            <TouchableOpacity
              style={styles.applyButton}
              onPress={() => setShowFilters(false)}
            >
              <Text style={styles.applyButtonText}>Apply</Text>
            </TouchableOpacity>
          </View>
        </View>
      </View>
    </Modal>
  );

  const renderBulkActions = () => (
    <View style={styles.bulkActionsContainer}>
      <Text style={styles.bulkActionsText}>
        {selectedRows.size} item{selectedRows.size !== 1 ? 's' : ''} selected
      </Text>
      <View style={styles.bulkActionsButtons}>
        <TouchableOpacity
          style={styles.bulkActionButton}
          onPress={() => handleBulkAction('Edit')}
        >
          <Text style={styles.bulkActionButtonText}>Edit</Text>
        </TouchableOpacity>
        <TouchableOpacity
          style={styles.bulkActionButton}
          onPress={() => handleBulkAction('Delete')}
        >
          <Text style={[styles.bulkActionButtonText, styles.deleteButtonText]}>Delete</Text>
        </TouchableOpacity>
        <TouchableOpacity
          style={styles.bulkActionButton}
          onPress={() => handleBulkAction('Export')}
        >
          <Text style={styles.bulkActionButtonText}>Export</Text>
        </TouchableOpacity>
      </View>
    </View>
  );

  const renderTableHeader = () => (
    <View style={styles.tableHeader}>
      <TouchableOpacity
        style={styles.headerCell}
        onPress={handleSelectAll}
      >
        <Ionicons
          name={selectedRows.size === pageData.length ? "checkbox" : "square-outline"}
          size={20}
          color={selectedRows.size === pageData.length ? "#007AFF" : "#666"}
        />
      </TouchableOpacity>
      
      <TouchableOpacity
        style={[styles.headerCell, styles.headerCellFlex]}
        onPress={() => handleSort('name')}
      >
        <Text style={styles.headerCellText}>Name</Text>
        <Ionicons
          name={sortColumn === 'name' ? (sortDirection === 'asc' ? 'chevron-up' : 'chevron-down') : 'chevron-up-down'}
          size={16}
          color="#666"
        />
      </TouchableOpacity>

      <TouchableOpacity
        style={[styles.headerCell, styles.headerCellFlex]}
        onPress={() => handleSort('email')}
      >
        <Text style={styles.headerCellText}>Email</Text>
        <Ionicons
          name={sortColumn === 'email' ? (sortDirection === 'asc' ? 'chevron-up' : 'chevron-down') : 'chevron-up-down'}
          size={16}
          color="#666"
        />
      </TouchableOpacity>

      <TouchableOpacity
        style={[styles.headerCell, styles.headerCellFlex]}
        onPress={() => handleSort('department')}
      >
        <Text style={styles.headerCellText}>Department</Text>
        <Ionicons
          name={sortColumn === 'department' ? (sortDirection === 'asc' ? 'chevron-up' : 'chevron-down') : 'chevron-up-down'}
          size={16}
          color="#666"
        />
      </TouchableOpacity>

      <TouchableOpacity
        style={[styles.headerCell, styles.headerCellFlex]}
        onPress={() => handleSort('salary')}
      >
        <Text style={styles.headerCellText}>Salary</Text>
        <Ionicons
          name={sortColumn === 'salary' ? (sortDirection === 'asc' ? 'chevron-up' : 'chevron-down') : 'chevron-up-down'}
          size={16}
          color="#666"
        />
      </TouchableOpacity>

      <TouchableOpacity
        style={[styles.headerCell, styles.headerCellFlex]}
        onPress={() => handleSort('status')}
      >
        <Text style={styles.headerCellText}>Status</Text>
        <Ionicons
          name={sortColumn === 'status' ? (sortDirection === 'asc' ? 'chevron-up' : 'chevron-down') : 'chevron-up-down'}
          size={16}
          color="#666"
        />
      </TouchableOpacity>

      <View style={[styles.headerCell, styles.headerCellFlex]}>
        <Text style={styles.headerCellText}>Actions</Text>
      </View>
    </View>
  );

  const renderTableRow = ({ item }) => (
    <View style={[
      styles.tableRow,
      selectedRows.has(item.id) && styles.selectedRow
    ]}>
      <TouchableOpacity
        style={styles.cell}
        onPress={() => handleSelectRow(item.id)}
      >
        <Ionicons
          name={selectedRows.has(item.id) ? "checkbox" : "square-outline"}
          size={20}
          color={selectedRows.has(item.id) ? "#007AFF" : "#666"}
        />
      </TouchableOpacity>

      <View style={[styles.cell, styles.cellFlex]}>
        <Text style={styles.cellText} numberOfLines={1}>{item.name}</Text>
      </View>

      <View style={[styles.cell, styles.cellFlex]}>
        <Text style={[styles.cellText, styles.emailText]} numberOfLines={1}>{item.email}</Text>
      </View>

      <View style={[styles.cell, styles.cellFlex]}>
        <Text style={styles.cellText} numberOfLines={1}>{item.department}</Text>
      </View>

      <View style={[styles.cell, styles.cellFlex]}>
        <Text style={styles.cellText} numberOfLines={1}>${item.salary.toLocaleString()}</Text>
      </View>

      <View style={[styles.cell, styles.cellFlex]}>
        <View style={[
          styles.statusBadge,
          { backgroundColor: item.status === 'Active' ? '#4CAF50' : '#F44336' }
        ]}>
          <Text style={styles.statusText}>{item.status}</Text>
        </View>
      </View>

      <View style={[styles.cell, styles.cellFlex]}>
        <View style={styles.actionButtons}>
          <TouchableOpacity
            style={styles.actionButton}
            onPress={() => Alert.alert('View', `View details for ${item.name}`)}
          >
            <Ionicons name="eye" size={16} color="#007AFF" />
          </TouchableOpacity>
          <TouchableOpacity
            style={styles.actionButton}
            onPress={() => Alert.alert('Edit', `Edit ${item.name}`)}
          >
            <Ionicons name="pencil" size={16} color="#007AFF" />
          </TouchableOpacity>
          <TouchableOpacity
            style={styles.actionButton}
            onPress={() => Alert.alert('Delete', `Delete ${item.name}`)}
          >
            <Ionicons name="trash" size={16} color="#F44336" />
          </TouchableOpacity>
        </View>
      </View>
    </View>
  );

  const renderPagination = () => (
    <View style={styles.paginationContainer}>
      <Text style={styles.paginationText}>
        Showing {startIndex + 1}-{endIndex} of {sortedData.length} results
      </Text>
      
      <View style={styles.paginationControls}>
        <TouchableOpacity
          style={[styles.paginationButton, currentPage === 1 && styles.paginationButtonDisabled]}
          onPress={() => setCurrentPage(Math.max(1, currentPage - 1))}
          disabled={currentPage === 1}
        >
          <Text style={[styles.paginationButtonText, currentPage === 1 && styles.paginationButtonTextDisabled]}>
            Previous
          </Text>
        </TouchableOpacity>

        <Text style={styles.paginationInfo}>
          Page {currentPage} of {totalPages}
        </Text>

        <TouchableOpacity
          style={[styles.paginationButton, currentPage === totalPages && styles.paginationButtonDisabled]}
          onPress={() => setCurrentPage(Math.min(totalPages, currentPage + 1))}
          disabled={currentPage === totalPages}
        >
          <Text style={[styles.paginationButtonText, currentPage === totalPages && styles.paginationButtonTextDisabled]}>
            Next
          </Text>
        </TouchableOpacity>
      </View>
    </View>
  );

  return (
    <View style={styles.container}>
      {renderHeader()}
      {renderSearchBar()}
      {selectedRows.size > 0 && renderBulkActions()}
      {renderTableHeader()}
      <FlatList
        data={pageData}
        renderItem={renderTableRow}
        keyExtractor={(item) => item.id}
        style={styles.tableBody}
        showsVerticalScrollIndicator={false}
      />
      {renderPagination()}
      {renderFilters()}
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#f5f5f5',
  },
  header: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    padding: 16,
    backgroundColor: '#fff',
    borderBottomWidth: 1,
    borderBottomColor: '#e0e0e0',
  },
  headerTitle: {
    fontSize: 24,
    fontWeight: 'bold',
    color: '#333',
  },
  headerActions: {
    flexDirection: 'row',
    gap: 12,
  },
  headerButton: {
    flexDirection: 'row',
    alignItems: 'center',
    paddingHorizontal: 12,
    paddingVertical: 8,
    backgroundColor: '#f0f0f0',
    borderRadius: 8,
    gap: 4,
  },
  headerButtonText: {
    color: '#007AFF',
    fontWeight: '600',
  },
  searchContainer: {
    flexDirection: 'row',
    padding: 16,
    backgroundColor: '#fff',
    borderBottomWidth: 1,
    borderBottomColor: '#e0e0e0',
    gap: 12,
  },
  searchInputContainer: {
    flex: 1,
    flexDirection: 'row',
    alignItems: 'center',
    backgroundColor: '#f5f5f5',
    borderRadius: 8,
    paddingHorizontal: 12,
  },
  searchIcon: {
    marginRight: 8,
  },
  searchInput: {
    flex: 1,
    paddingVertical: 12,
    fontSize: 16,
    color: '#333',
  },
  filterButton: {
    flexDirection: 'row',
    alignItems: 'center',
    paddingHorizontal: 16,
    paddingVertical: 12,
    backgroundColor: '#007AFF',
    borderRadius: 8,
    gap: 4,
  },
  filterButtonText: {
    color: '#fff',
    fontWeight: '600',
  },
  bulkActionsContainer: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    padding: 16,
    backgroundColor: '#e3f2fd',
    borderBottomWidth: 1,
    borderBottomColor: '#e0e0e0',
  },
  bulkActionsText: {
    fontSize: 16,
    fontWeight: '600',
    color: '#1976d2',
  },
  bulkActionsButtons: {
    flexDirection: 'row',
    gap: 8,
  },
  bulkActionButton: {
    paddingHorizontal: 12,
    paddingVertical: 8,
    backgroundColor: '#fff',
    borderRadius: 6,
    borderWidth: 1,
    borderColor: '#1976d2',
  },
  bulkActionButtonText: {
    color: '#1976d2',
    fontWeight: '600',
    fontSize: 14,
  },
  deleteButtonText: {
    color: '#F44336',
  },
  tableHeader: {
    flexDirection: 'row',
    backgroundColor: '#f8f9fa',
    paddingVertical: 12,
    paddingHorizontal: 16,
    borderBottomWidth: 1,
    borderBottomColor: '#e0e0e0',
  },
  headerCell: {
    paddingVertical: 8,
    justifyContent: 'center',
  },
  headerCellFlex: {
    flex: 1,
    flexDirection: 'row',
    alignItems: 'center',
    gap: 4,
  },
  headerCellText: {
    fontSize: 14,
    fontWeight: 'bold',
    color: '#333',
  },
  tableBody: {
    flex: 1,
  },
  tableRow: {
    flexDirection: 'row',
    backgroundColor: '#fff',
    paddingVertical: 12,
    paddingHorizontal: 16,
    borderBottomWidth: 1,
    borderBottomColor: '#f0f0f0',
  },
  selectedRow: {
    backgroundColor: '#e3f2fd',
  },
  cell: {
    paddingVertical: 8,
    justifyContent: 'center',
  },
  cellFlex: {
    flex: 1,
  },
  cellText: {
    fontSize: 14,
    color: '#333',
  },
  emailText: {
    color: '#007AFF',
  },
  statusBadge: {
    paddingHorizontal: 8,
    paddingVertical: 4,
    borderRadius: 12,
    alignSelf: 'flex-start',
  },
  statusText: {
    color: '#fff',
    fontSize: 12,
    fontWeight: '600',
  },
  actionButtons: {
    flexDirection: 'row',
    gap: 8,
  },
  actionButton: {
    padding: 4,
  },
  paginationContainer: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    padding: 16,
    backgroundColor: '#fff',
    borderTopWidth: 1,
    borderTopColor: '#e0e0e0',
  },
  paginationText: {
    fontSize: 14,
    color: '#666',
  },
  paginationControls: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: 16,
  },
  paginationButton: {
    paddingHorizontal: 12,
    paddingVertical: 8,
    backgroundColor: '#007AFF',
    borderRadius: 6,
  },
  paginationButtonDisabled: {
    backgroundColor: '#e0e0e0',
  },
  paginationButtonText: {
    color: '#fff',
    fontWeight: '600',
    fontSize: 14,
  },
  paginationButtonTextDisabled: {
    color: '#999',
  },
  paginationInfo: {
    fontSize: 14,
    color: '#333',
    fontWeight: '500',
  },
  modalOverlay: {
    flex: 1,
    backgroundColor: 'rgba(0, 0, 0, 0.5)',
    justifyContent: 'flex-end',
  },
  modalContent: {
    backgroundColor: '#fff',
    borderTopLeftRadius: 20,
    borderTopRightRadius: 20,
    padding: 20,
    maxHeight: '70%',
  },
  modalHeader: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    marginBottom: 20,
  },
  modalTitle: {
    fontSize: 20,
    fontWeight: 'bold',
    color: '#333',
  },
  filterSection: {
    marginBottom: 20,
  },
  filterLabel: {
    fontSize: 16,
    fontWeight: '600',
    color: '#333',
    marginBottom: 12,
  },
  filterChip: {
    paddingHorizontal: 16,
    paddingVertical: 8,
    backgroundColor: '#f0f0f0',
    borderRadius: 20,
    marginRight: 8,
  },
  filterChipActive: {
    backgroundColor: '#007AFF',
  },
  filterChipText: {
    fontSize: 14,
    color: '#666',
  },
  filterChipTextActive: {
    color: '#fff',
  },
  modalActions: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    marginTop: 20,
    gap: 12,
  },
  clearButton: {
    flex: 1,
    paddingVertical: 12,
    backgroundColor: '#f0f0f0',
    borderRadius: 8,
    alignItems: 'center',
  },
  clearButtonText: {
    color: '#666',
    fontWeight: '600',
  },
  applyButton: {
    flex: 1,
    paddingVertical: 12,
    backgroundColor: '#007AFF',
    borderRadius: 8,
    alignItems: 'center',
  },
  applyButtonText: {
    color: '#fff',
    fontWeight: '600',
  },
});

export default DataTableComplex;

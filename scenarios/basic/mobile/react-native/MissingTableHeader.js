import React from 'react';
import {
  View,
  Text,
  ScrollView,
  StyleSheet,
} from 'react-native';

const MissingTableHeader = () => {
  const employees = [
    {
      id: 1,
      name: 'John Smith',
      department: 'Engineering',
      position: 'Senior Developer',
      salary: '$85,000',
      startDate: '2020-03-15'
    },
    {
      id: 2,
      name: 'Sarah Johnson',
      department: 'Marketing',
      position: 'Marketing Manager',
      salary: '$72,000',
      startDate: '2019-07-22'
    },
    {
      id: 3,
      name: 'Mike Chen',
      department: 'Engineering',
      position: 'DevOps Engineer',
      salary: '$78,000',
      startDate: '2021-01-10'
    },
    {
      id: 4,
      name: 'Emily Davis',
      department: 'HR',
      position: 'HR Specialist',
      salary: '$65,000',
      startDate: '2020-11-05'
    },
    {
      id: 5,
      name: 'David Wilson',
      department: 'Sales',
      position: 'Sales Director',
      salary: '$95,000',
      startDate: '2018-09-12'
    }
  ];

  return (
    <ScrollView style={styles.container}>
      {/* Header */}
      <View style={styles.header}>
        <Text style={styles.headerTitle}>Employee Directory</Text>
        <Text style={styles.headerSubtitle}>Company employee information</Text>
      </View>

      {/* Data Table - Missing proper headers */}
      <View style={styles.tableContainer}>
        <Text style={styles.tableTitle}>Employee Data</Text>
        
        {/* Table Header - Using regular Text instead of proper table headers */}
        <View style={styles.tableHeader}>
          {/* MISSING: Should use proper table header elements */}
          <Text style={styles.headerCell}>Name</Text>
          <Text style={styles.headerCell}>Department</Text>
          <Text style={styles.headerCell}>Position</Text>
          <Text style={styles.headerCell}>Salary</Text>
        </View>

        {/* Table Rows */}
        {employees.map((employee) => (
          <View key={employee.id} style={styles.tableRow}>
            <View style={styles.nameCell}>
              <Text style={styles.employeeName}>{employee.name}</Text>
              <Text style={styles.employeeId}>ID: {employee.id}</Text>
            </View>
            <Text style={styles.tableCell}>{employee.department}</Text>
            <Text style={styles.tableCell}>{employee.position}</Text>
            <Text style={styles.salaryCell}>{employee.salary}</Text>
          </View>
        ))}
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
    backgroundColor: '#2196F3',
    padding: 32,
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
    color: '#FFFFFF',
    opacity: 0.9,
  },
  tableContainer: {
    backgroundColor: '#FFFFFF',
    margin: 16,
    padding: 16,
    borderRadius: 8,
  },
  tableTitle: {
    fontSize: 18,
    fontWeight: 'bold',
    color: '#1976D2',
    marginBottom: 16,
  },
  tableHeader: {
    flexDirection: 'row',
    backgroundColor: '#E3F2FD',
    padding: 12,
    borderRadius: 4,
    marginBottom: 1,
  },
  headerCell: {
    flex: 1,
    fontSize: 14,
    fontWeight: 'bold',
    color: '#1976D2',
    textAlign: 'center',
  },
  tableRow: {
    flexDirection: 'row',
    backgroundColor: '#FFFFFF',
    padding: 12,
    borderBottomWidth: 1,
    borderBottomColor: '#E0E0E0',
    alignItems: 'center',
  },
  nameCell: {
    flex: 1,
  },
  employeeName: {
    fontSize: 14,
    fontWeight: '600',
    marginBottom: 2,
  },
  employeeId: {
    fontSize: 12,
    color: '#666666',
  },
  tableCell: {
    flex: 1,
    fontSize: 14,
    color: '#666666',
    textAlign: 'center',
  },
  salaryCell: {
    flex: 1,
    fontSize: 14,
    fontWeight: '600',
    color: '#4CAF50',
    textAlign: 'right',
  },
});

export default MissingTableHeader;

import React, { useState, useEffect } from 'react';
import {
  View,
  Text,
  TouchableOpacity,
  ScrollView,
  StyleSheet,
  Animated,
} from 'react-native';

const LowContrastWarningText = () => {
  const [sessionTimeLeft, setSessionTimeLeft] = useState(15);
  const [isSessionActive, setIsSessionActive] = useState(true);

  useEffect(() => {
    const timer = setInterval(() => {
      if (isSessionActive && sessionTimeLeft > 0) {
        setSessionTimeLeft(sessionTimeLeft - 1);
      }
    }, 1000);

    return () => clearInterval(timer);
  }, [sessionTimeLeft, isSessionActive]);

  const accounts = [
    { name: 'Checking Account', balance: '$12,450.00', accountNumber: '****1234' },
    { name: 'Savings Account', balance: '$45,230.00', accountNumber: '****5678' },
    { name: 'Credit Card', balance: '-$2,340.00', accountNumber: '****9012' }
  ];

  const quickActions = [
    { title: 'Transfer', icon: '↔️' },
    { title: 'Pay Bills', icon: '🧾' },
    { title: 'Deposit', icon: '➕' }
  ];

  return (
    <ScrollView style={styles.container}>
      {/* Header */}
      <View style={styles.header}>
        <Text style={styles.headerTitle}>Secure Banking Portal</Text>
        <Text style={styles.headerSubtitle}>Manage your accounts safely</Text>
      </View>

      {/* Session Warning - LOW CONTRAST */}
      {sessionTimeLeft <= 5 && (
        <View style={styles.warningContainer}>
          <Text style={styles.warningIcon}>⚠️</Text>
          <Text style={styles.warningText}>
            Your session will expire in {sessionTimeLeft} seconds. Please save your work and refresh the page to continue.
          </Text>
        </View>
      )}

      {/* Account Overview */}
      <View style={styles.accountContainer}>
        <Text style={styles.sectionTitle}>Account Overview</Text>
        {accounts.map((account, index) => (
          <View key={index} style={styles.accountCard}>
            <Text style={styles.accountIcon}>🏦</Text>
            <View style={styles.accountInfo}>
              <Text style={styles.accountName}>{account.name}</Text>
              <Text style={styles.accountNumber}>ID: {account.accountNumber}</Text>
            </View>
            <Text style={[
              styles.accountBalance,
              account.balance.startsWith('-') ? styles.negativeBalance : styles.positiveBalance
            ]}>
              {account.balance}
            </Text>
          </View>
        ))}
      </View>

      {/* Quick Actions */}
      <View style={styles.actionsContainer}>
        <Text style={styles.sectionTitle}>Quick Actions</Text>
        <View style={styles.actionsGrid}>
          {quickActions.map((action, index) => (
            <TouchableOpacity key={index} style={styles.actionButton}>
              <Text style={styles.actionIcon}>{action.icon}</Text>
              <Text style={styles.actionTitle}>{action.title}</Text>
            </TouchableOpacity>
          ))}
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
  warningContainer: {
    flexDirection: 'row',
    backgroundColor: '#F8F8F8', // Very light background
    padding: 16,
    margin: 16,
    borderRadius: 8,
    alignItems: 'center',
  },
  warningIcon: {
    fontSize: 20,
    marginRight: 12,
  },
  warningText: {
    flex: 1,
    fontSize: 14,
    color: '#CCCCCC', // Very light gray - LOW CONTRAST
  },
  accountContainer: {
    backgroundColor: '#FFFFFF',
    margin: 16,
    padding: 20,
    borderRadius: 8,
  },
  sectionTitle: {
    fontSize: 20,
    fontWeight: 'bold',
    color: '#1976D2',
    marginBottom: 16,
  },
  accountCard: {
    flexDirection: 'row',
    alignItems: 'center',
    backgroundColor: '#F8F9FA',
    padding: 16,
    borderRadius: 8,
    marginBottom: 12,
  },
  accountIcon: {
    fontSize: 20,
    marginRight: 12,
  },
  accountInfo: {
    flex: 1,
  },
  accountName: {
    fontSize: 16,
    fontWeight: '600',
    marginBottom: 4,
  },
  accountNumber: {
    fontSize: 14,
    color: '#666666',
  },
  accountBalance: {
    fontSize: 18,
    fontWeight: 'bold',
  },
  positiveBalance: {
    color: '#38A169',
  },
  negativeBalance: {
    color: '#E53E3E',
  },
  actionsContainer: {
    backgroundColor: '#FFFFFF',
    margin: 16,
    padding: 20,
    borderRadius: 8,
  },
  actionsGrid: {
    flexDirection: 'row',
    justifyContent: 'space-between',
  },
  actionButton: {
    flex: 1,
    backgroundColor: '#2196F3',
    alignItems: 'center',
    paddingVertical: 20,
    paddingHorizontal: 16,
    borderRadius: 8,
    marginHorizontal: 4,
  },
  actionIcon: {
    fontSize: 24,
    marginBottom: 8,
  },
  actionTitle: {
    color: '#FFFFFF',
    fontSize: 12,
    fontWeight: '600',
  },
});

export default LowContrastWarningText;

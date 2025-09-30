import { useState, useEffect } from 'react';

export default function LowContrastWarningText() {
  const [sessionTime, setSessionTime] = useState(1800); // 30 minutes in seconds
  const [isWarningVisible, setIsWarningVisible] = useState(false);
  const [isModalOpen, setIsModalOpen] = useState(false);
  const [timeRemaining, setTimeRemaining] = useState(0);
  const [intervalId, setIntervalId] = useState(null);

  const minutes = Math.floor(sessionTime / 60);
  const seconds = sessionTime % 60;

  const startSession = () => {
    setSessionTime(1800);
    setIsWarningVisible(false);
    setIsModalOpen(false);
    
    if (intervalId) {
      clearInterval(intervalId);
    }
    
    const newIntervalId = setInterval(() => {
      setSessionTime(prev => {
        const newTime = prev - 1;
        if (newTime <= 300 && !isWarningVisible) { // 5 minutes warning
          setIsWarningVisible(true);
        }
        if (newTime <= 0) {
          clearInterval(newIntervalId);
          showTimeoutModal();
        }
        return newTime;
      });
    }, 1000);
    
    setIntervalId(newIntervalId);
  };

  const extendSession = () => {
    setSessionTime(prev => prev + 1800); // Add 30 minutes
    setIsWarningVisible(false);
    setIsModalOpen(false);
  };

  const logout = () => {
    if (intervalId) {
      clearInterval(intervalId);
    }
    setSessionTime(0);
    setIsWarningVisible(false);
    setIsModalOpen(false);
    alert('You have been logged out due to inactivity.');
  };

  const showTimeoutModal = () => {
    setIsModalOpen(true);
    setTimeRemaining(60); // 1 minute countdown
    
    const countdownInterval = setInterval(() => {
      setTimeRemaining(prev => {
        if (prev <= 1) {
          clearInterval(countdownInterval);
          logout();
          return 0;
        }
        return prev - 1;
      });
    }, 1000);
  };

  const formatTime = (totalSeconds) => {
    const mins = Math.floor(totalSeconds / 60);
    const secs = totalSeconds % 60;
    return `${mins}:${secs.toString().padStart(2, '0')}`;
  };

  // Start session on component mount
  useEffect(() => {
    startSession();
    
    return () => {
      if (intervalId) {
        clearInterval(intervalId);
      }
    };
  }, []);

  return (
    <div className="session-manager">
      <header className="app-header">
        <div className="header-content">
          <div className="logo-section">
            <h1 className="app-title">Secure Application</h1>
            <p className="app-subtitle">Your session will automatically expire for security reasons</p>
          </div>
          
          <div className="header-controls">
            <div className="session-info">
              <span className="session-timer">Session: {formatTime(sessionTime)}</span>
              <button className="logout-btn" onClick={logout}>Logout</button>
            </div>
          </div>
        </div>
      </header>

      <main className="app-main">
        <div className="dashboard">
          <h2>Dashboard</h2>
          <p>Welcome to your secure dashboard. Your session will automatically expire for security reasons.</p>
          
          <div className="dashboard-cards">
            <div className="card">
              <h3>Recent Activity</h3>
              <ul>
                <li>Logged in at 9:30 AM</li>
                <li>Viewed profile at 9:45 AM</li>
                <li>Updated settings at 10:15 AM</li>
              </ul>
            </div>
            
            <div className="card">
              <h3>Security Status</h3>
              <div className="security-indicators">
                <div className="indicator">
                  <span className="indicator-label">Two-Factor Auth:</span>
                  <span className="indicator-value enabled">Enabled</span>
                </div>
                <div className="indicator">
                  <span className="indicator-label">Last Login:</span>
                  <span className="indicator-value">Today, 9:30 AM</span>
                </div>
                <div className="indicator">
                  <span className="indicator-label">Session Status:</span>
                  <span className={`indicator-value ${sessionTime > 300 ? 'active' : 'warning'}`}>
                    {sessionTime > 300 ? 'Active' : 'Expiring Soon'}
                  </span>
                </div>
              </div>
            </div>
            
            <div className="card">
              <h3>Quick Actions</h3>
              <div className="action-buttons">
                <button className="action-btn primary">View Profile</button>
                <button className="action-btn secondary">Settings</button>
                <button className="action-btn secondary">Help</button>
              </div>
            </div>
          </div>
        </div>
      </main>

      {/* Session Warning Banner */}
      {isWarningVisible && (
        <div className="session-warning">
          <div className="warning-content">
            <span className="warning-icon">⚠️</span>
            <div className="warning-text">
              <strong>Session Expiring Soon</strong>
              <p>Your session will expire in {formatTime(sessionTime)}. Click "Extend Session" to continue working.</p>
            </div>
            <div className="warning-actions">
              <button className="extend-btn" onClick={extendSession}>Extend Session</button>
              <button className="logout-btn-small" onClick={logout}>Logout Now</button>
            </div>
          </div>
        </div>
      )}

      {/* Timeout Modal */}
      {isModalOpen && (
        <div className="modal-overlay">
          <div className="timeout-modal">
            <div className="modal-header">
              <h3>Session Timeout</h3>
            </div>
            <div className="modal-content">
              <p>Your session has expired due to inactivity.</p>
              <p>You will be automatically logged out in {timeRemaining} seconds.</p>
              <div className="countdown-display">
                <div className="countdown-circle">
                  <span className="countdown-number">{timeRemaining}</span>
                </div>
              </div>
            </div>
            <div className="modal-actions">
              <button className="extend-btn" onClick={extendSession}>Extend Session</button>
              <button className="logout-btn" onClick={logout}>Logout Now</button>
            </div>
          </div>
        </div>
      )}

      <style jsx>{`
        .session-manager {
          min-height: 100vh;
          background: #f5f5f5;
          font-family: Arial, sans-serif;
        }

        .app-header {
          background: white;
          padding: 15px 30px;
          box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        .header-content {
          display: flex;
          justify-content: space-between;
          align-items: center;
        }

        .logo-section h1 {
          margin: 0 0 5px 0;
          font-size: 24px;
          color: #333;
        }

        .logo-section p {
          margin: 0;
          color: #666;
          font-size: 14px;
        }

        .session-info {
          display: flex;
          align-items: center;
          gap: 20px;
        }

        .session-timer {
          font-family: monospace;
          font-size: 16px;
          color: #666;
        }

        .logout-btn {
          background: #dc3545;
          color: white;
          border: none;
          padding: 8px 16px;
          border-radius: 4px;
          cursor: pointer;
        }

        .app-main {
          padding: 30px;
        }

        .dashboard h2 {
          margin: 0 0 20px 0;
          color: #333;
          font-size: 28px;
        }

        .dashboard p {
          color: #666;
          font-size: 16px;
          margin-bottom: 30px;
        }

        .dashboard-cards {
          display: grid;
          grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
          gap: 20px;
        }

        .card {
          background: white;
          padding: 20px;
          border-radius: 8px;
          box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }

        .card h3 {
          margin: 0 0 15px 0;
          color: #333;
          font-size: 18px;
        }

        .card ul {
          margin: 0;
          padding-left: 20px;
          color: #666;
        }

        .card li {
          margin-bottom: 5px;
        }

        .security-indicators {
          display: flex;
          flex-direction: column;
          gap: 10px;
        }

        .indicator {
          display: flex;
          justify-content: space-between;
          align-items: center;
        }

        .indicator-label {
          color: #666;
        }

        .indicator-value {
          font-weight: bold;
        }

        .indicator-value.enabled {
          color: #28a745;
        }

        .indicator-value.active {
          color: #28a745;
        }

        .indicator-value.warning {
          color: #ffc107;
        }

        .action-buttons {
          display: flex;
          gap: 10px;
          flex-wrap: wrap;
        }

        .action-btn {
          padding: 10px 20px;
          border: none;
          border-radius: 4px;
          cursor: pointer;
          font-weight: bold;
        }

        .action-btn.primary {
          background: #007bff;
          color: white;
        }

        .action-btn.secondary {
          background: #6c757d;
          color: white;
        }

        .session-warning {
          position: fixed;
          top: 0;
          left: 0;
          right: 0;
          background: #fff3cd;
          border-bottom: 1px solid #ffeaa7;
          z-index: 1000;
        }

        .warning-content {
          display: flex;
          align-items: center;
          padding: 15px 30px;
          gap: 15px;
        }

        .warning-icon {
          font-size: 24px;
        }

        .warning-text {
          flex: 1;
        }

        .warning-text strong {
          display: block;
          color: #856404;
          font-size: 16px;
          margin-bottom: 5px;
        }

        .warning-text p {
          margin: 0;
          color: #856404;
          font-size: 14px;
        }

        .warning-actions {
          display: flex;
          gap: 10px;
        }

        .extend-btn {
          background: #28a745;
          color: white;
          border: none;
          padding: 8px 16px;
          border-radius: 4px;
          cursor: pointer;
          font-weight: bold;
        }

        .logout-btn-small {
          background: #dc3545;
          color: white;
          border: none;
          padding: 8px 16px;
          border-radius: 4px;
          cursor: pointer;
        }

        .modal-overlay {
          position: fixed;
          top: 0;
          left: 0;
          right: 0;
          bottom: 0;
          background: rgba(0,0,0,0.5);
          display: flex;
          align-items: center;
          justify-content: center;
          z-index: 2000;
        }

        .timeout-modal {
          background: white;
          border-radius: 8px;
          box-shadow: 0 4px 20px rgba(0,0,0,0.3);
          max-width: 400px;
          width: 90%;
        }

        .modal-header {
          padding: 20px 20px 0 20px;
        }

        .modal-header h3 {
          margin: 0;
          color: #333;
          font-size: 20px;
        }

        .modal-content {
          padding: 20px;
          text-align: center;
        }

        .modal-content p {
          margin: 0 0 15px 0;
          color: #666;
        }

        .countdown-display {
          margin: 20px 0;
        }

        .countdown-circle {
          width: 80px;
          height: 80px;
          border: 4px solid #dc3545;
          border-radius: 50%;
          display: flex;
          align-items: center;
          justify-content: center;
          margin: 0 auto;
        }

        .countdown-number {
          font-size: 24px;
          font-weight: bold;
          color: #dc3545;
        }

        .modal-actions {
          padding: 0 20px 20px 20px;
          display: flex;
          gap: 10px;
          justify-content: center;
        }
      `}</style>
    </div>
  );
}

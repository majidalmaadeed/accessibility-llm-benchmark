import { useState, useEffect } from 'react';

export default function MissingPageTitle() {
  const [currentUser, setCurrentUser] = useState(null);
  const [notifications, setNotifications] = useState([]);
  const [isLoading, setIsLoading] = useState(true);
  const [activeTab, setActiveTab] = useState('dashboard');
  const [searchQuery, setSearchQuery] = useState('');
  const [showSidebar, setShowSidebar] = useState(true);

  const dashboardStats = {
    totalUsers: 1247,
    activeProjects: 23,
    completedTasks: 156,
    pendingApprovals: 8
  };

  const recentActivities = [
    { id: 1, type: 'task', message: 'Task "Update Documentation" completed', time: '2 hours ago', user: 'John Doe' },
    { id: 2, type: 'project', message: 'New project "Mobile App Redesign" created', time: '4 hours ago', user: 'Jane Smith' },
    { id: 3, type: 'approval', message: 'Budget approval request submitted', time: '6 hours ago', user: 'Mike Johnson' },
    { id: 4, type: 'meeting', message: 'Team meeting scheduled for tomorrow', time: '8 hours ago', user: 'Sarah Wilson' },
    { id: 5, type: 'update', message: 'System maintenance completed', time: '1 day ago', user: 'Admin' }
  ];

  const projects = [
    { id: 1, name: 'Website Redesign', status: 'active', progress: 75, deadline: '2024-02-15', team: 5 },
    { id: 2, name: 'Mobile App Development', status: 'active', progress: 45, deadline: '2024-03-20', team: 8 },
    { id: 3, name: 'Database Migration', status: 'planning', progress: 20, deadline: '2024-04-10', team: 3 },
    { id: 4, name: 'Security Audit', status: 'completed', progress: 100, deadline: '2024-01-30', team: 4 },
    { id: 5, name: 'API Integration', status: 'active', progress: 60, deadline: '2024-02-28', team: 6 }
  ];

  const tabs = [
    { id: 'dashboard', name: 'Dashboard', icon: '📊' },
    { id: 'projects', name: 'Projects', icon: '📁' },
    { id: 'tasks', name: 'Tasks', icon: '✅' },
    { id: 'team', name: 'Team', icon: '👥' },
    { id: 'reports', name: 'Reports', icon: '📈' },
    { id: 'settings', name: 'Settings', icon: '⚙️' }
  ];

  useEffect(() => {
    const loadUserData = async () => {
      try {
        await new Promise(resolve => setTimeout(resolve, 1000));
        setCurrentUser({
          name: 'John Doe',
          email: 'john.doe@company.com',
          role: 'Project Manager',
          avatar: '/api/placeholder/40/40'
        });
        setNotifications([
          { id: 1, message: 'New task assigned to you', time: '10 minutes ago', unread: true },
          { id: 2, message: 'Project deadline approaching', time: '1 hour ago', unread: true },
          { id: 3, message: 'Team meeting reminder', time: '2 hours ago', unread: false }
        ]);
      } catch (error) {
        console.error('Error loading user data:', error);
      } finally {
        setIsLoading(false);
      }
    };

    loadUserData();
  }, []);

  const handleSearch = (e) => {
    e.preventDefault();
    alert(`Searching for: ${searchQuery}`);
  };

  const handleNotificationClick = (notificationId) => {
    setNotifications(prev => 
      prev.map(notif => 
        notif.id === notificationId 
          ? { ...notif, unread: false }
          : notif
      )
    );
  };

  const handleProjectAction = (projectId, action) => {
    alert(`${action} action for project ${projectId}`);
  };

  const getStatusColor = (status) => {
    const colors = {
      active: '#28a745',
      planning: '#ffc107',
      completed: '#6c757d',
      paused: '#dc3545'
    };
    return colors[status] || '#6c757d';
  };

  const formatDate = (dateString) => {
    return new Date(dateString).toLocaleDateString();
  };

  const getUnreadCount = () => {
    return notifications.filter(n => n.unread).length;
  };

  if (isLoading) {
    return (
      <div className="loading-container">
        <div className="loading-spinner"></div>
        <p>Loading dashboard...</p>
      </div>
    );
  }

  return (
    <div className="dashboard-app">
      <header className="app-header">
        <div className="header-left">
          <button 
            className="sidebar-toggle"
            onClick={() => setShowSidebar(!showSidebar)}
          >
            ☰
          </button>
          <h1 className="app-title">ProjectHub</h1>
        </div>

        <div className="header-center">
          <form onSubmit={handleSearch} className="search-form">
            <input
              type="text"
              placeholder="Search projects, tasks, or team members..."
              value={searchQuery}
              onChange={(e) => setSearchQuery(e.target.value)}
              className="search-input"
            />
            <button type="submit" className="search-btn">🔍</button>
          </form>
        </div>

        <div className="header-right">
          <div className="notifications">
            <button className="notification-btn">
              🔔
              {getUnreadCount() > 0 && (
                <span className="notification-badge">{getUnreadCount()}</span>
              )}
            </button>
          </div>

          <div className="user-menu">
            <img 
              src={currentUser.avatar} 
              alt={currentUser.name}
              className="user-avatar"
            />
            <span className="user-name">{currentUser.name}</span>
          </div>
        </div>
      </header>

      <div className="app-content">
        {showSidebar && (
          <aside className="sidebar">
            <nav className="sidebar-nav">
              {tabs.map(tab => (
                <button
                  key={tab.id}
                  className={`nav-item ${activeTab === tab.id ? 'active' : ''}`}
                  onClick={() => setActiveTab(tab.id)}
                >
                  <span className="nav-icon">{tab.icon}</span>
                  <span className="nav-text">{tab.name}</span>
                </button>
              ))}
            </nav>
          </aside>
        )}

        <main className="main-content">
          {activeTab === 'dashboard' && (
            <div className="dashboard-content">
              <div className="dashboard-header">
                <h2>Dashboard Overview</h2>
                <p>Welcome back, {currentUser.name}! Here's what's happening today.</p>
              </div>

              <div className="stats-grid">
                <div className="stat-card">
                  <div className="stat-icon">👥</div>
                  <div className="stat-content">
                    <div className="stat-number">{dashboardStats.totalUsers}</div>
                    <div className="stat-label">Total Users</div>
                  </div>
                </div>

                <div className="stat-card">
                  <div className="stat-icon">📁</div>
                  <div className="stat-content">
                    <div className="stat-number">{dashboardStats.activeProjects}</div>
                    <div className="stat-label">Active Projects</div>
                  </div>
                </div>

                <div className="stat-card">
                  <div className="stat-icon">✅</div>
                  <div className="stat-content">
                    <div className="stat-number">{dashboardStats.completedTasks}</div>
                    <div className="stat-label">Completed Tasks</div>
                  </div>
                </div>

                <div className="stat-card">
                  <div className="stat-icon">⏳</div>
                  <div className="stat-content">
                    <div className="stat-number">{dashboardStats.pendingApprovals}</div>
                    <div className="stat-label">Pending Approvals</div>
                  </div>
                </div>
              </div>

              <div className="dashboard-grid">
                <div className="activity-panel">
                  <h3>Recent Activity</h3>
                  <div className="activity-list">
                    {recentActivities.map(activity => (
                      <div key={activity.id} className="activity-item">
                        <div className="activity-icon">
                          {activity.type === 'task' && '✅'}
                          {activity.type === 'project' && '📁'}
                          {activity.type === 'approval' && '⏳'}
                          {activity.type === 'meeting' && '📅'}
                          {activity.type === 'update' && '🔄'}
                        </div>
                        <div className="activity-content">
                          <p className="activity-message">{activity.message}</p>
                          <div className="activity-meta">
                            <span className="activity-user">{activity.user}</span>
                            <span className="activity-time">{activity.time}</span>
                          </div>
                        </div>
                      </div>
                    ))}
                  </div>
                </div>

                <div className="projects-panel">
                  <h3>Active Projects</h3>
                  <div className="projects-list">
                    {projects.filter(p => p.status === 'active').map(project => (
                      <div key={project.id} className="project-item">
                        <div className="project-header">
                          <h4 className="project-name">{project.name}</h4>
                          <span 
                            className="project-status"
                            style={{ color: getStatusColor(project.status) }}
                          >
                            {project.status}
                          </span>
                        </div>
                        <div className="project-progress">
                          <div className="progress-bar">
                            <div 
                              className="progress-fill"
                              style={{ width: `${project.progress}%` }}
                            ></div>
                          </div>
                          <span className="progress-text">{project.progress}%</span>
                        </div>
                        <div className="project-meta">
                          <span className="project-deadline">Due: {formatDate(project.deadline)}</span>
                          <span className="project-team">{project.team} members</span>
                        </div>
                        <div className="project-actions">
                          <button 
                            className="action-btn view"
                            onClick={() => handleProjectAction(project.id, 'View')}
                          >
                            View
                          </button>
                          <button 
                            className="action-btn edit"
                            onClick={() => handleProjectAction(project.id, 'Edit')}
                          >
                            Edit
                          </button>
                        </div>
                      </div>
                    ))}
                  </div>
                </div>
              </div>
            </div>
          )}

          {activeTab === 'projects' && (
            <div className="projects-content">
              <div className="content-header">
                <h2>All Projects</h2>
                <button className="btn btn-primary">Create New Project</button>
              </div>

              <div className="projects-grid">
                {projects.map(project => (
                  <div key={project.id} className="project-card">
                    <div className="project-card-header">
                      <h3 className="project-title">{project.name}</h3>
                      <span 
                        className="project-status-badge"
                        style={{ backgroundColor: getStatusColor(project.status) }}
                      >
                        {project.status}
                      </span>
                    </div>
                    
                    <div className="project-progress-section">
                      <div className="progress-info">
                        <span>Progress</span>
                        <span>{project.progress}%</span>
                      </div>
                      <div className="progress-bar">
                        <div 
                          className="progress-fill"
                          style={{ width: `${project.progress}%` }}
                        ></div>
                      </div>
                    </div>

                    <div className="project-details">
                      <div className="detail-item">
                        <span className="detail-label">Deadline:</span>
                        <span className="detail-value">{formatDate(project.deadline)}</span>
                      </div>
                      <div className="detail-item">
                        <span className="detail-label">Team Size:</span>
                        <span className="detail-value">{project.team} members</span>
                      </div>
                    </div>

                    <div className="project-actions">
                      <button 
                        className="action-btn primary"
                        onClick={() => handleProjectAction(project.id, 'View Details')}
                      >
                        View Details
                      </button>
                      <button 
                        className="action-btn secondary"
                        onClick={() => handleProjectAction(project.id, 'Edit')}
                      >
                        Edit
                      </button>
                    </div>
                  </div>
                ))}
              </div>
            </div>
          )}

          {activeTab === 'tasks' && (
            <div className="tasks-content">
              <div className="content-header">
                <h2>My Tasks</h2>
                <button className="btn btn-primary">Add New Task</button>
              </div>
              <p>Task management interface would go here...</p>
            </div>
          )}

          {activeTab === 'team' && (
            <div className="team-content">
              <div className="content-header">
                <h2>Team Members</h2>
                <button className="btn btn-primary">Invite Member</button>
              </div>
              <p>Team management interface would go here...</p>
            </div>
          )}

          {activeTab === 'reports' && (
            <div className="reports-content">
              <div className="content-header">
                <h2>Reports & Analytics</h2>
                <button className="btn btn-primary">Generate Report</button>
              </div>
              <p>Reports interface would go here...</p>
            </div>
          )}

          {activeTab === 'settings' && (
            <div className="settings-content">
              <div className="content-header">
                <h2>Settings</h2>
              </div>
              <p>Settings interface would go here...</p>
            </div>
          )}
        </main>
      </div>

      <style jsx>{`
        .dashboard-app {
          min-height: 100vh;
          background: #f5f7fa;
          font-family: Arial, sans-serif;
        }

        .loading-container {
          display: flex;
          flex-direction: column;
          align-items: center;
          justify-content: center;
          height: 100vh;
          background: #f5f7fa;
        }

        .loading-spinner {
          width: 40px;
          height: 40px;
          border: 4px solid #f3f3f3;
          border-top: 4px solid #007bff;
          border-radius: 50%;
          animation: spin 1s linear infinite;
          margin-bottom: 20px;
        }

        @keyframes spin {
          0% { transform: rotate(0deg); }
          100% { transform: rotate(360deg); }
        }

        .app-header {
          background: white;
          box-shadow: 0 2px 4px rgba(0,0,0,0.1);
          padding: 0 20px;
          height: 60px;
          display: flex;
          align-items: center;
          justify-content: space-between;
          position: sticky;
          top: 0;
          z-index: 100;
        }

        .header-left {
          display: flex;
          align-items: center;
          gap: 15px;
        }

        .sidebar-toggle {
          background: none;
          border: none;
          font-size: 20px;
          cursor: pointer;
          padding: 5px;
        }

        .app-title {
          margin: 0;
          font-size: 24px;
          font-weight: bold;
          color: #333;
        }

        .header-center {
          flex: 1;
          max-width: 500px;
          margin: 0 20px;
        }

        .search-form {
          display: flex;
          width: 100%;
        }

        .search-input {
          flex: 1;
          padding: 8px 12px;
          border: 1px solid #ddd;
          border-radius: 20px 0 0 20px;
          font-size: 14px;
        }

        .search-btn {
          background: #007bff;
          color: white;
          border: none;
          border-radius: 0 20px 20px 0;
          padding: 8px 15px;
          cursor: pointer;
        }

        .header-right {
          display: flex;
          align-items: center;
          gap: 20px;
        }

        .notifications {
          position: relative;
        }

        .notification-btn {
          background: none;
          border: none;
          font-size: 20px;
          cursor: pointer;
          position: relative;
        }

        .notification-badge {
          position: absolute;
          top: -5px;
          right: -5px;
          background: #dc3545;
          color: white;
          border-radius: 50%;
          width: 18px;
          height: 18px;
          font-size: 10px;
          display: flex;
          align-items: center;
          justify-content: center;
        }

        .user-menu {
          display: flex;
          align-items: center;
          gap: 10px;
          cursor: pointer;
        }

        .user-avatar {
          width: 32px;
          height: 32px;
          border-radius: 50%;
        }

        .user-name {
          font-weight: bold;
          color: #333;
        }

        .app-content {
          display: flex;
          min-height: calc(100vh - 60px);
        }

        .sidebar {
          width: 250px;
          background: white;
          box-shadow: 2px 0 4px rgba(0,0,0,0.1);
          padding: 20px 0;
        }

        .sidebar-nav {
          display: flex;
          flex-direction: column;
        }

        .nav-item {
          display: flex;
          align-items: center;
          gap: 12px;
          padding: 12px 20px;
          border: none;
          background: none;
          cursor: pointer;
          text-align: left;
          font-size: 14px;
          color: #666;
          transition: all 0.2s ease;
        }

        .nav-item:hover {
          background: #f8f9fa;
          color: #333;
        }

        .nav-item.active {
          background: #e3f2fd;
          color: #007bff;
          border-right: 3px solid #007bff;
        }

        .nav-icon {
          font-size: 16px;
        }

        .main-content {
          flex: 1;
          padding: 30px;
          overflow-y: auto;
        }

        .dashboard-content {
          max-width: 1200px;
        }

        .dashboard-header {
          margin-bottom: 30px;
        }

        .dashboard-header h2 {
          margin: 0 0 10px 0;
          font-size: 28px;
          color: #333;
        }

        .dashboard-header p {
          margin: 0;
          color: #666;
          font-size: 16px;
        }

        .stats-grid {
          display: grid;
          grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
          gap: 20px;
          margin-bottom: 30px;
        }

        .stat-card {
          background: white;
          padding: 20px;
          border-radius: 8px;
          box-shadow: 0 2px 4px rgba(0,0,0,0.1);
          display: flex;
          align-items: center;
          gap: 15px;
        }

        .stat-icon {
          font-size: 32px;
        }

        .stat-number {
          font-size: 24px;
          font-weight: bold;
          color: #333;
          margin-bottom: 5px;
        }

        .stat-label {
          font-size: 14px;
          color: #666;
        }

        .dashboard-grid {
          display: grid;
          grid-template-columns: 1fr 1fr;
          gap: 30px;
        }

        .activity-panel,
        .projects-panel {
          background: white;
          padding: 20px;
          border-radius: 8px;
          box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        .activity-panel h3,
        .projects-panel h3 {
          margin: 0 0 20px 0;
          font-size: 18px;
          color: #333;
        }

        .activity-list {
          display: flex;
          flex-direction: column;
          gap: 15px;
        }

        .activity-item {
          display: flex;
          gap: 12px;
          padding: 10px 0;
          border-bottom: 1px solid #f0f0f0;
        }

        .activity-item:last-child {
          border-bottom: none;
        }

        .activity-icon {
          font-size: 16px;
          margin-top: 2px;
        }

        .activity-content {
          flex: 1;
        }

        .activity-message {
          margin: 0 0 5px 0;
          font-size: 14px;
          color: #333;
        }

        .activity-meta {
          display: flex;
          gap: 10px;
          font-size: 12px;
          color: #666;
        }

        .projects-list {
          display: flex;
          flex-direction: column;
          gap: 15px;
        }

        .project-item {
          padding: 15px;
          border: 1px solid #e9ecef;
          border-radius: 6px;
          background: #f8f9fa;
        }

        .project-header {
          display: flex;
          justify-content: space-between;
          align-items: center;
          margin-bottom: 10px;
        }

        .project-name {
          margin: 0;
          font-size: 16px;
          color: #333;
        }

        .project-status {
          font-size: 12px;
          font-weight: bold;
          text-transform: uppercase;
        }

        .project-progress {
          display: flex;
          align-items: center;
          gap: 10px;
          margin-bottom: 10px;
        }

        .progress-bar {
          flex: 1;
          height: 6px;
          background: #e9ecef;
          border-radius: 3px;
          overflow: hidden;
        }

        .progress-fill {
          height: 100%;
          background: #007bff;
          transition: width 0.3s ease;
        }

        .progress-text {
          font-size: 12px;
          color: #666;
          font-weight: bold;
        }

        .project-meta {
          display: flex;
          justify-content: space-between;
          font-size: 12px;
          color: #666;
          margin-bottom: 10px;
        }

        .project-actions {
          display: flex;
          gap: 8px;
        }

        .action-btn {
          padding: 6px 12px;
          border: 1px solid #ddd;
          background: white;
          cursor: pointer;
          border-radius: 4px;
          font-size: 12px;
          font-weight: bold;
          transition: all 0.2s ease;
        }

        .action-btn:hover {
          background: #f8f9fa;
        }

        .action-btn.primary {
          background: #007bff;
          color: white;
          border-color: #007bff;
        }

        .action-btn.primary:hover {
          background: #0056b3;
        }

        .content-header {
          display: flex;
          justify-content: space-between;
          align-items: center;
          margin-bottom: 30px;
        }

        .content-header h2 {
          margin: 0;
          font-size: 24px;
          color: #333;
        }

        .btn {
          padding: 10px 20px;
          border: none;
          border-radius: 4px;
          cursor: pointer;
          font-weight: bold;
          transition: all 0.2s ease;
        }

        .btn-primary {
          background: #007bff;
          color: white;
        }

        .btn-primary:hover {
          background: #0056b3;
        }

        .projects-grid {
          display: grid;
          grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
          gap: 20px;
        }

        .project-card {
          background: white;
          border: 1px solid #e9ecef;
          border-radius: 8px;
          padding: 20px;
          box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        .project-card-header {
          display: flex;
          justify-content: space-between;
          align-items: center;
          margin-bottom: 15px;
        }

        .project-title {
          margin: 0;
          font-size: 18px;
          color: #333;
        }

        .project-status-badge {
          padding: 4px 8px;
          border-radius: 12px;
          color: white;
          font-size: 10px;
          font-weight: bold;
          text-transform: uppercase;
        }

        .project-progress-section {
          margin-bottom: 15px;
        }

        .progress-info {
          display: flex;
          justify-content: space-between;
          margin-bottom: 5px;
          font-size: 12px;
          color: #666;
        }

        .project-details {
          margin-bottom: 15px;
        }

        .detail-item {
          display: flex;
          justify-content: space-between;
          margin-bottom: 5px;
          font-size: 12px;
        }

        .detail-label {
          color: #666;
        }

        .detail-value {
          color: #333;
          font-weight: bold;
        }

        .project-actions {
          display: flex;
          gap: 8px;
        }

        .action-btn.secondary {
          background: #6c757d;
          color: white;
          border-color: #6c757d;
        }

        .action-btn.secondary:hover {
          background: #545b62;
        }

        @media (max-width: 768px) {
          .app-header {
            padding: 0 15px;
          }

          .header-center {
            display: none;
          }

          .sidebar {
            position: fixed;
            left: -250px;
            top: 60px;
            height: calc(100vh - 60px);
            z-index: 200;
            transition: left 0.3s ease;
          }

          .sidebar.open {
            left: 0;
          }

          .main-content {
            padding: 20px 15px;
          }

          .dashboard-grid {
            grid-template-columns: 1fr;
          }

          .stats-grid {
            grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
          }

          .projects-grid {
            grid-template-columns: 1fr;
          }
        }
      `}</style>
    </div>
  );
}

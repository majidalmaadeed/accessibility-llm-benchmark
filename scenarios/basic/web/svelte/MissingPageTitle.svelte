<script>
  let currentView = 'overview';
  let selectedUser = null;
  let searchTerm = '';
  let selectedRole = 'all';
  let currentPage = 1;
  const itemsPerPage = 8;

  const roles = [
    { id: 'all', name: 'All Roles' },
    { id: 'admin', name: 'Administrator' },
    { id: 'manager', name: 'Manager' },
    { id: 'developer', name: 'Developer' },
    { id: 'designer', name: 'Designer' },
    { id: 'tester', name: 'Tester' }
  ];

  const users = [
    {
      id: 1,
      name: 'John Smith',
      email: 'john.smith@company.com',
      role: 'admin',
      department: 'IT',
      status: 'active',
      lastLogin: '2024-01-15',
      joinDate: '2023-06-01',
      avatar: 'john-avatar.jpg'
    },
    {
      id: 2,
      name: 'Sarah Johnson',
      email: 'sarah.johnson@company.com',
      role: 'manager',
      department: 'Marketing',
      status: 'active',
      lastLogin: '2024-01-14',
      joinDate: '2023-08-15',
      avatar: 'sarah-avatar.jpg'
    },
    {
      id: 3,
      name: 'Mike Chen',
      email: 'mike.chen@company.com',
      role: 'developer',
      department: 'Engineering',
      status: 'active',
      lastLogin: '2024-01-15',
      joinDate: '2023-09-01',
      avatar: 'mike-avatar.jpg'
    },
    {
      id: 4,
      name: 'Emily Davis',
      email: 'emily.davis@company.com',
      role: 'designer',
      department: 'Design',
      status: 'inactive',
      lastLogin: '2024-01-10',
      joinDate: '2023-07-20',
      avatar: 'emily-avatar.jpg'
    },
    {
      id: 5,
      name: 'David Wilson',
      email: 'david.wilson@company.com',
      role: 'tester',
      department: 'Quality Assurance',
      status: 'active',
      lastLogin: '2024-01-13',
      joinDate: '2023-10-01',
      avatar: 'david-avatar.jpg'
    },
    {
      id: 6,
      name: 'Lisa Rodriguez',
      email: 'lisa.rodriguez@company.com',
      role: 'manager',
      department: 'Sales',
      status: 'active',
      lastLogin: '2024-01-15',
      joinDate: '2023-05-15',
      avatar: 'lisa-avatar.jpg'
    },
    {
      id: 7,
      name: 'Tom Anderson',
      email: 'tom.anderson@company.com',
      role: 'developer',
      department: 'Engineering',
      status: 'active',
      lastLogin: '2024-01-14',
      joinDate: '2023-11-01',
      avatar: 'tom-avatar.jpg'
    },
    {
      id: 8,
      name: 'Anna Garcia',
      email: 'anna.garcia@company.com',
      role: 'designer',
      department: 'Design',
      status: 'active',
      lastLogin: '2024-01-12',
      joinDate: '2023-04-10',
      avatar: 'anna-avatar.jpg'
    }
  ];

  $: filteredUsers = users.filter(user => {
    const matchesRole = selectedRole === 'all' || user.role === selectedRole;
    const matchesSearch = user.name.toLowerCase().includes(searchTerm.toLowerCase()) ||
                         user.email.toLowerCase().includes(searchTerm.toLowerCase()) ||
                         user.department.toLowerCase().includes(searchTerm.toLowerCase());
    return matchesRole && matchesSearch;
  });

  $: totalPages = Math.ceil(filteredUsers.length / itemsPerPage);
  $: paginatedUsers = filteredUsers.slice(
    (currentPage - 1) * itemsPerPage, 
    currentPage * itemsPerPage
  );

  $: userStats = {
    total: users.length,
    active: users.filter(u => u.status === 'active').length,
    inactive: users.filter(u => u.status === 'inactive').length,
    admins: users.filter(u => u.role === 'admin').length,
    managers: users.filter(u => u.role === 'manager').length,
    developers: users.filter(u => u.role === 'developer').length
  };

  function getRoleColor(role) {
    const colors = {
      admin: '#dc3545',
      manager: '#007bff',
      developer: '#28a745',
      designer: '#ffc107',
      tester: '#6f42c1'
    };
    return colors[role] || '#6c757d';
  }

  function getStatusColor(status) {
    return status === 'active' ? '#28a745' : '#dc3545';
  }

  function formatDate(dateString) {
    return new Date(dateString).toLocaleDateString('en-US', {
      year: 'numeric',
      month: 'short',
      day: 'numeric'
    });
  }

  function handleAction(action, user) {
    alert(`${action} action performed on "${user.name}"`);
  }

  function selectUser(user) {
    selectedUser = user;
    currentView = 'details';
  }

  function goToPage(page) {
    currentPage = page;
  }

  function nextPage() {
    if (currentPage < totalPages) {
      currentPage++;
    }
  }

  function prevPage() {
    if (currentPage > 1) {
      currentPage--;
    }
  }
</script>

<div class="user-management">
  <header class="app-header">
    <div class="header-content">
      <div class="header-info">
        <h1>User Management System</h1>
        <p>Manage user accounts, roles, and permissions</p>
      </div>
      <div class="header-actions">
        <button class="header-btn primary">Add User</button>
        <button class="header-btn secondary">Export Data</button>
        <button class="header-btn secondary">Settings</button>
      </div>
    </div>
  </header>

  <div class="app-navigation">
    <div class="nav-tabs">
      <button 
        class="nav-tab {currentView === 'overview' ? 'active' : ''}" 
        on:click={() => currentView = 'overview'}
      >
        Overview
      </button>
      <button 
        class="nav-tab {currentView === 'users' ? 'active' : ''}" 
        on:click={() => currentView = 'users'}
      >
        Users
      </button>
      <button 
        class="nav-tab {currentView === 'roles' ? 'active' : ''}" 
        on:click={() => currentView = 'roles'}
      >
        Roles
      </button>
      <button 
        class="nav-tab {currentView === 'permissions' ? 'active' : ''}" 
        on:click={() => currentView = 'permissions'}
      >
        Permissions
      </button>
    </div>
  </div>

  <main class="app-main">
    {#if currentView === 'overview'}
      <div class="overview-content">
        <div class="stats-grid">
          <div class="stat-card">
            <div class="stat-icon">👥</div>
            <div class="stat-content">
              <div class="stat-number">{userStats.total}</div>
              <div class="stat-label">Total Users</div>
            </div>
          </div>
          
          <div class="stat-card">
            <div class="stat-icon">✅</div>
            <div class="stat-content">
              <div class="stat-number">{userStats.active}</div>
              <div class="stat-label">Active Users</div>
            </div>
          </div>
          
          <div class="stat-card">
            <div class="stat-icon">❌</div>
            <div class="stat-content">
              <div class="stat-number">{userStats.inactive}</div>
              <div class="stat-label">Inactive Users</div>
            </div>
          </div>
          
          <div class="stat-card">
            <div class="stat-icon">👑</div>
            <div class="stat-content">
              <div class="stat-number">{userStats.admins}</div>
              <div class="stat-label">Administrators</div>
            </div>
          </div>
        </div>

        <div class="role-distribution">
          <h3>Role Distribution</h3>
          <div class="role-chart">
            <div class="role-item">
              <div class="role-bar">
                <div class="role-fill" style="width: {(userStats.managers / userStats.total) * 100}%"></div>
              </div>
              <div class="role-info">
                <span class="role-name">Managers</span>
                <span class="role-count">{userStats.managers}</span>
              </div>
            </div>
            
            <div class="role-item">
              <div class="role-bar">
                <div class="role-fill" style="width: {(userStats.developers / userStats.total) * 100}%"></div>
              </div>
              <div class="role-info">
                <span class="role-name">Developers</span>
                <span class="role-count">{userStats.developers}</span>
              </div>
            </div>
            
            <div class="role-item">
              <div class="role-bar">
                <div class="role-fill" style="width: {(userStats.admins / userStats.total) * 100}%"></div>
              </div>
              <div class="role-info">
                <span class="role-name">Administrators</span>
                <span class="role-count">{userStats.admins}</span>
              </div>
            </div>
          </div>
        </div>

        <div class="recent-activity">
          <h3>Recent Activity</h3>
          <div class="activity-list">
            <div class="activity-item">
              <div class="activity-icon">👤</div>
              <div class="activity-content">
                <p>John Smith logged in</p>
                <span class="activity-time">2 minutes ago</span>
              </div>
            </div>
            
            <div class="activity-item">
              <div class="activity-icon">✏️</div>
              <div class="activity-content">
                <p>Sarah Johnson updated profile</p>
                <span class="activity-time">15 minutes ago</span>
              </div>
            </div>
            
            <div class="activity-item">
              <div class="activity-icon">🔒</div>
              <div class="activity-content">
                <p>Mike Chen changed password</p>
                <span class="activity-time">1 hour ago</span>
              </div>
            </div>
            
            <div class="activity-item">
              <div class="activity-icon">➕</div>
              <div class="activity-content">
                <p>New user Tom Anderson added</p>
                <span class="activity-time">2 hours ago</span>
              </div>
            </div>
          </div>
        </div>
      </div>
    {:else if currentView === 'users'}
      <div class="users-content">
        <div class="content-header">
          <h2>User Management</h2>
          <div class="content-controls">
            <div class="search-section">
              <input 
                type="text" 
                placeholder="Search users..." 
                bind:value={searchTerm}
                class="search-input"
              />
            </div>
            <div class="filter-section">
              <select bind:value={selectedRole} class="filter-select">
                {#each roles as role}
                  <option value={role.id}>{role.name}</option>
                {/each}
              </select>
            </div>
          </div>
        </div>

        <div class="users-grid">
          {#each paginatedUsers as user}
            <div class="user-card" on:click={() => selectUser(user)}>
              <div class="user-avatar">
                <img src="/images/{user.avatar}" alt="{user.name}" />
                <div class="status-indicator {user.status}"></div>
              </div>
              
              <div class="user-info">
                <h3 class="user-name">{user.name}</h3>
                <p class="user-email">{user.email}</p>
                <div class="user-meta">
                  <span class="user-role" style="color: {getRoleColor(user.role)}">
                    {user.role}
                  </span>
                  <span class="user-department">{user.department}</span>
                </div>
                <div class="user-dates">
                  <span class="last-login">Last login: {formatDate(user.lastLogin)}</span>
                </div>
              </div>
              
              <div class="user-actions">
                <button 
                  class="action-btn primary" 
                  on:click|stopPropagation={() => handleAction('View', user)}
                >
                  View
                </button>
                <button 
                  class="action-btn secondary" 
                  on:click|stopPropagation={() => handleAction('Edit', user)}
                >
                  Edit
                </button>
                <button 
                  class="action-btn secondary" 
                  on:click|stopPropagation={() => handleAction('Message', user)}
                >
                  Message
                </button>
                <button 
                  class="action-btn danger" 
                  on:click|stopPropagation={() => handleAction('Delete', user)}
                >
                  Delete
                </button>
              </div>
            </div>
          {/each}
        </div>

        {#if totalPages > 1}
          <div class="pagination">
            <button 
              class="page-btn" 
              on:click={prevPage} 
              disabled={currentPage === 1}
            >
              Previous
            </button>
            
            {#each Array(totalPages) as _, i}
              <button 
                class="page-btn {currentPage === i + 1 ? 'active' : ''}" 
                on:click={() => goToPage(i + 1)}
              >
                {i + 1}
              </button>
            {/each}
            
            <button 
              class="page-btn" 
              on:click={nextPage} 
              disabled={currentPage === totalPages}
            >
              Next
            </button>
          </div>
        {/if}
      </div>
    {:else if currentView === 'details' && selectedUser}
      <div class="user-details">
        <div class="details-header">
          <button class="back-btn" on:click={() => currentView = 'users'}">← Back to Users</button>
          <h2>User Details: {selectedUser.name}</h2>
        </div>
        
        <div class="details-content">
          <div class="user-profile">
            <div class="profile-avatar">
              <img src="/images/{selectedUser.avatar}" alt="{selectedUser.name}" />
              <div class="status-indicator {selectedUser.status}"></div>
            </div>
            
            <div class="profile-info">
              <h3>{selectedUser.name}</h3>
              <p class="profile-email">{selectedUser.email}</p>
              <div class="profile-badges">
                <span class="role-badge" style="background-color: {getRoleColor(selectedUser.role)}">
                  {selectedUser.role}
                </span>
                <span class="status-badge" style="background-color: {getStatusColor(selectedUser.status)}">
                  {selectedUser.status}
                </span>
              </div>
            </div>
          </div>
          
          <div class="user-details-grid">
            <div class="detail-section">
              <h4>Personal Information</h4>
              <div class="detail-item">
                <span class="detail-label">Full Name:</span>
                <span class="detail-value">{selectedUser.name}</span>
              </div>
              <div class="detail-item">
                <span class="detail-label">Email:</span>
                <span class="detail-value">{selectedUser.email}</span>
              </div>
              <div class="detail-item">
                <span class="detail-label">Department:</span>
                <span class="detail-value">{selectedUser.department}</span>
              </div>
            </div>
            
            <div class="detail-section">
              <h4>Account Information</h4>
              <div class="detail-item">
                <span class="detail-label">Role:</span>
                <span class="detail-value">{selectedUser.role}</span>
              </div>
              <div class="detail-item">
                <span class="detail-label">Status:</span>
                <span class="detail-value">{selectedUser.status}</span>
              </div>
              <div class="detail-item">
                <span class="detail-label">Join Date:</span>
                <span class="detail-value">{formatDate(selectedUser.joinDate)}</span>
              </div>
              <div class="detail-item">
                <span class="detail-label">Last Login:</span>
                <span class="detail-value">{formatDate(selectedUser.lastLogin)}</span>
              </div>
            </div>
          </div>
        </div>
      </div>
    {:else if currentView === 'roles'}
      <div class="roles-content">
        <h2>Role Management</h2>
        <p>Role management features coming soon...</p>
      </div>
    {:else if currentView === 'permissions'}
      <div class="permissions-content">
        <h2>Permission Management</h2>
        <p>Permission management features coming soon...</p>
      </div>
    {/if}
  </main>
</div>

<style>
  .user-management {
    max-width: 1400px;
    margin: 50px auto;
    padding: 20px;
    font-family: Arial, sans-serif;
  }

  .app-header {
    background: white;
    border-radius: 8px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.1);
    margin-bottom: 20px;
  }

  .header-content {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 30px;
  }

  .header-info h1 {
    margin: 0 0 5px 0;
    font-size: 32px;
    color: #333;
  }

  .header-info p {
    margin: 0;
    color: #666;
    font-size: 16px;
  }

  .header-actions {
    display: flex;
    gap: 10px;
  }

  .header-btn {
    padding: 10px 20px;
    border: none;
    border-radius: 6px;
    cursor: pointer;
    font-weight: bold;
    transition: all 0.2s ease;
  }

  .header-btn.primary {
    background: #007bff;
    color: white;
  }

  .header-btn.primary:hover {
    background: #0056b3;
  }

  .header-btn.secondary {
    background: #6c757d;
    color: white;
  }

  .header-btn.secondary:hover {
    background: #545b62;
  }

  .app-navigation {
    margin-bottom: 20px;
  }

  .nav-tabs {
    display: flex;
    background: white;
    border-radius: 8px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.1);
    overflow: hidden;
  }

  .nav-tab {
    flex: 1;
    padding: 15px 20px;
    background: white;
    border: none;
    cursor: pointer;
    font-size: 16px;
    font-weight: bold;
    transition: all 0.2s ease;
    border-right: 1px solid #eee;
  }

  .nav-tab:last-child {
    border-right: none;
  }

  .nav-tab:hover {
    background: #f8f9fa;
  }

  .nav-tab.active {
    background: #007bff;
    color: white;
  }

  .app-main {
    background: white;
    border-radius: 8px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.1);
    padding: 30px;
  }

  .stats-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
    gap: 20px;
    margin-bottom: 40px;
  }

  .stat-card {
    display: flex;
    align-items: center;
    gap: 15px;
    padding: 20px;
    background: #f8f9fa;
    border-radius: 8px;
  }

  .stat-icon {
    font-size: 32px;
  }

  .stat-content {
    flex: 1;
  }

  .stat-number {
    font-size: 28px;
    font-weight: bold;
    color: #007bff;
    margin-bottom: 5px;
  }

  .stat-label {
    font-size: 14px;
    color: #666;
  }

  .role-distribution {
    margin-bottom: 40px;
  }

  .role-distribution h3 {
    margin: 0 0 20px 0;
    font-size: 20px;
    color: #333;
  }

  .role-chart {
    display: flex;
    flex-direction: column;
    gap: 15px;
  }

  .role-item {
    display: flex;
    align-items: center;
    gap: 15px;
  }

  .role-bar {
    flex: 1;
    height: 20px;
    background: #eee;
    border-radius: 10px;
    overflow: hidden;
  }

  .role-fill {
    height: 100%;
    background: #007bff;
    transition: width 0.3s ease;
  }

  .role-info {
    display: flex;
    justify-content: space-between;
    align-items: center;
    min-width: 150px;
  }

  .role-name {
    font-weight: bold;
    color: #333;
  }

  .role-count {
    color: #666;
  }

  .recent-activity h3 {
    margin: 0 0 20px 0;
    font-size: 20px;
    color: #333;
  }

  .activity-list {
    display: flex;
    flex-direction: column;
    gap: 15px;
  }

  .activity-item {
    display: flex;
    align-items: center;
    gap: 15px;
    padding: 15px;
    background: #f8f9fa;
    border-radius: 8px;
  }

  .activity-icon {
    font-size: 20px;
  }

  .activity-content p {
    margin: 0 0 5px 0;
    color: #333;
  }

  .activity-time {
    font-size: 12px;
    color: #666;
  }

  .content-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 30px;
    flex-wrap: wrap;
    gap: 20px;
  }

  .content-header h2 {
    margin: 0;
    font-size: 28px;
    color: #333;
  }

  .content-controls {
    display: flex;
    gap: 15px;
    align-items: center;
  }

  .search-input {
    padding: 8px 12px;
    border: 1px solid #ddd;
    border-radius: 4px;
    font-size: 14px;
    min-width: 200px;
  }

  .filter-select {
    padding: 8px 12px;
    border: 1px solid #ddd;
    border-radius: 4px;
    background: white;
    font-size: 14px;
  }

  .users-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
    gap: 20px;
    margin-bottom: 30px;
  }

  .user-card {
    border: 1px solid #eee;
    border-radius: 8px;
    padding: 20px;
    cursor: pointer;
    transition: all 0.2s ease;
  }

  .user-card:hover {
    border-color: #007bff;
    box-shadow: 0 4px 12px rgba(0,123,255,0.1);
  }

  .user-avatar {
    position: relative;
    width: 60px;
    height: 60px;
    margin-bottom: 15px;
  }

  .user-avatar img {
    width: 100%;
    height: 100%;
    border-radius: 50%;
    object-fit: cover;
  }

  .status-indicator {
    position: absolute;
    bottom: 0;
    right: 0;
    width: 16px;
    height: 16px;
    border-radius: 50%;
    border: 2px solid white;
  }

  .status-indicator.active {
    background: #28a745;
  }

  .status-indicator.inactive {
    background: #dc3545;
  }

  .user-name {
    margin: 0 0 5px 0;
    font-size: 18px;
    color: #333;
  }

  .user-email {
    margin: 0 0 10px 0;
    color: #666;
    font-size: 14px;
  }

  .user-meta {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 10px;
  }

  .user-role {
    font-weight: bold;
    text-transform: uppercase;
    font-size: 12px;
  }

  .user-department {
    color: #666;
    font-size: 12px;
  }

  .user-dates {
    margin-bottom: 15px;
  }

  .last-login {
    color: #666;
    font-size: 12px;
  }

  .user-actions {
    display: flex;
    gap: 5px;
    flex-wrap: wrap;
  }

  .action-btn {
    padding: 6px 12px;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    font-size: 12px;
    font-weight: bold;
    transition: all 0.2s ease;
  }

  .action-btn.primary {
    background: #007bff;
    color: white;
  }

  .action-btn.primary:hover {
    background: #0056b3;
  }

  .action-btn.secondary {
    background: #6c757d;
    color: white;
  }

  .action-btn.secondary:hover {
    background: #545b62;
  }

  .action-btn.danger {
    background: #dc3545;
    color: white;
  }

  .action-btn.danger:hover {
    background: #c82333;
  }

  .pagination {
    display: flex;
    justify-content: center;
    gap: 5px;
  }

  .page-btn {
    padding: 8px 12px;
    border: 1px solid #ddd;
    background: white;
    cursor: pointer;
    border-radius: 4px;
    font-weight: bold;
    transition: all 0.2s ease;
  }

  .page-btn:hover:not(:disabled) {
    border-color: #007bff;
    color: #007bff;
  }

  .page-btn.active {
    background: #007bff;
    color: white;
    border-color: #007bff;
  }

  .page-btn:disabled {
    opacity: 0.5;
    cursor: not-allowed;
  }

  .user-details {
    max-width: 800px;
    margin: 0 auto;
  }

  .details-header {
    display: flex;
    align-items: center;
    gap: 20px;
    margin-bottom: 30px;
  }

  .back-btn {
    background: #6c757d;
    color: white;
    border: none;
    padding: 8px 16px;
    border-radius: 4px;
    cursor: pointer;
  }

  .back-btn:hover {
    background: #545b62;
  }

  .details-header h2 {
    margin: 0;
    font-size: 24px;
    color: #333;
  }

  .user-profile {
    display: flex;
    align-items: center;
    gap: 20px;
    margin-bottom: 30px;
    padding: 20px;
    background: #f8f9fa;
    border-radius: 8px;
  }

  .profile-avatar {
    position: relative;
    width: 80px;
    height: 80px;
  }

  .profile-avatar img {
    width: 100%;
    height: 100%;
    border-radius: 50%;
    object-fit: cover;
  }

  .profile-info h3 {
    margin: 0 0 5px 0;
    font-size: 24px;
    color: #333;
  }

  .profile-email {
    margin: 0 0 15px 0;
    color: #666;
  }

  .profile-badges {
    display: flex;
    gap: 10px;
  }

  .role-badge,
  .status-badge {
    padding: 4px 12px;
    border-radius: 12px;
    font-size: 12px;
    font-weight: bold;
    color: white;
    text-transform: uppercase;
  }

  .user-details-grid {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 30px;
  }

  .detail-section h4 {
    margin: 0 0 15px 0;
    font-size: 18px;
    color: #333;
  }

  .detail-item {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 10px;
    padding: 8px 0;
    border-bottom: 1px solid #eee;
  }

  .detail-label {
    font-weight: bold;
    color: #666;
  }

  .detail-value {
    color: #333;
  }

  .roles-content,
  .permissions-content {
    text-align: center;
    padding: 60px 20px;
    color: #666;
  }

  .roles-content h2,
  .permissions-content h2 {
    margin: 0 0 15px 0;
    font-size: 28px;
    color: #333;
  }

  @media (max-width: 768px) {
    .header-content {
      flex-direction: column;
      gap: 20px;
    }

    .nav-tabs {
      flex-direction: column;
    }

    .nav-tab {
      border-right: none;
      border-bottom: 1px solid #eee;
    }

    .nav-tab:last-child {
      border-bottom: none;
    }

    .content-header {
      flex-direction: column;
      align-items: stretch;
    }

    .content-controls {
      flex-direction: column;
      align-items: stretch;
    }

    .search-input {
      min-width: auto;
    }

    .user-profile {
      flex-direction: column;
      text-align: center;
    }

    .user-details-grid {
      grid-template-columns: 1fr;
    }
  }
</style>

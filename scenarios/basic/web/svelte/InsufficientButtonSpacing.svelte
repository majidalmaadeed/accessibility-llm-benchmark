<script>
  let selectedTab = 'dashboard';
  let searchTerm = '';
  let selectedFilter = 'all';
  let currentPage = 1;
  const itemsPerPage = 6;

  const tabs = [
    { id: 'dashboard', name: 'Dashboard', icon: '📊' },
    { id: 'projects', name: 'Projects', icon: '📁' },
    { id: 'tasks', name: 'Tasks', icon: '✅' },
    { id: 'team', name: 'Team', icon: '👥' },
    { id: 'reports', name: 'Reports', icon: '📈' },
    { id: 'settings', name: 'Settings', icon: '⚙️' }
  ];

  const filters = [
    { id: 'all', name: 'All Items' },
    { id: 'active', name: 'Active' },
    { id: 'completed', name: 'Completed' },
    { id: 'pending', name: 'Pending' },
    { id: 'archived', name: 'Archived' }
  ];

  const projects = [
    {
      id: 1,
      name: 'Website Redesign',
      status: 'active',
      priority: 'high',
      progress: 75,
      dueDate: '2024-02-15',
      team: ['John Doe', 'Jane Smith'],
      description: 'Complete redesign of the company website'
    },
    {
      id: 2,
      name: 'Mobile App Development',
      status: 'active',
      priority: 'medium',
      progress: 45,
      dueDate: '2024-03-20',
      team: ['Mike Johnson', 'Sarah Wilson'],
      description: 'New mobile application for iOS and Android'
    },
    {
      id: 3,
      name: 'Database Migration',
      status: 'pending',
      priority: 'high',
      progress: 20,
      dueDate: '2024-02-28',
      team: ['David Brown', 'Lisa Garcia'],
      description: 'Migrate legacy database to new system'
    },
    {
      id: 4,
      name: 'API Integration',
      status: 'completed',
      priority: 'low',
      progress: 100,
      dueDate: '2024-01-30',
      team: ['Tom Anderson', 'Emma Davis'],
      description: 'Integrate third-party payment API'
    },
    {
      id: 5,
      name: 'Security Audit',
      status: 'active',
      priority: 'high',
      progress: 60,
      dueDate: '2024-02-10',
      team: ['Alex Chen', 'Maria Rodriguez'],
      description: 'Comprehensive security assessment'
    },
    {
      id: 6,
      name: 'Performance Optimization',
      status: 'pending',
      priority: 'medium',
      progress: 30,
      dueDate: '2024-03-05',
      team: ['Chris Taylor', 'Anna Lee'],
      description: 'Optimize application performance'
    }
  ];

  $: filteredProjects = projects.filter(project => {
    const matchesFilter = selectedFilter === 'all' || project.status === selectedFilter;
    const matchesSearch = project.name.toLowerCase().includes(searchTerm.toLowerCase()) ||
                         project.description.toLowerCase().includes(searchTerm.toLowerCase());
    return matchesFilter && matchesSearch;
  });

  $: totalPages = Math.ceil(filteredProjects.length / itemsPerPage);
  $: paginatedProjects = filteredProjects.slice(
    (currentPage - 1) * itemsPerPage, 
    currentPage * itemsPerPage
  );

  function getPriorityColor(priority) {
    const colors = {
      high: '#dc3545',
      medium: '#ffc107',
      low: '#28a745'
    };
    return colors[priority] || '#6c757d';
  }

  function getStatusColor(status) {
    const colors = {
      active: '#007bff',
      completed: '#28a745',
      pending: '#ffc107',
      archived: '#6c757d'
    };
    return colors[status] || '#6c757d';
  }

  function formatDate(dateString) {
    return new Date(dateString).toLocaleDateString('en-US', {
      year: 'numeric',
      month: 'short',
      day: 'numeric'
    });
  }

  function handleAction(action, project) {
    alert(`${action} action performed on "${project.name}"`);
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

<div class="project-management">
  <header class="app-header">
    <h1>Project Management Dashboard</h1>
    <p>Manage your projects and track progress efficiently</p>
  </header>

  <div class="app-navigation">
    <div class="tab-navigation">
      {#each tabs as tab}
        <button 
          class="tab-btn {selectedTab === tab.id ? 'active' : ''}" 
          on:click={() => selectedTab = tab.id}
        >
          <span class="tab-icon">{tab.icon}</span>
          <span class="tab-name">{tab.name}</span>
        </button>
      {/each}
    </div>
  </div>

  <main class="app-main">
    {#if selectedTab === 'dashboard'}
      <div class="dashboard-content">
        <div class="dashboard-stats">
          <div class="stat-card">
            <div class="stat-icon">📊</div>
            <div class="stat-content">
              <div class="stat-number">{projects.length}</div>
              <div class="stat-label">Total Projects</div>
            </div>
          </div>
          
          <div class="stat-card">
            <div class="stat-icon">✅</div>
            <div class="stat-content">
              <div class="stat-number">{projects.filter(p => p.status === 'completed').length}</div>
              <div class="stat-label">Completed</div>
            </div>
          </div>
          
          <div class="stat-card">
            <div class="stat-icon">⏳</div>
            <div class="stat-content">
              <div class="stat-number">{projects.filter(p => p.status === 'active').length}</div>
              <div class="stat-label">In Progress</div>
            </div>
          </div>
          
          <div class="stat-card">
            <div class="stat-icon">⚠️</div>
            <div class="stat-content">
              <div class="stat-number">{projects.filter(p => p.priority === 'high').length}</div>
              <div class="stat-label">High Priority</div>
            </div>
          </div>
        </div>

        <div class="recent-projects">
          <h3>Recent Projects</h3>
          <div class="projects-grid">
            {#each projects.slice(0, 4) as project}
              <div class="project-card">
                <div class="project-header">
                  <h4 class="project-name">{project.name}</h4>
                  <div class="project-status" style="color: {getStatusColor(project.status)}">
                    {project.status}
                  </div>
                </div>
                <p class="project-description">{project.description}</p>
                <div class="project-progress">
                  <div class="progress-bar">
                    <div class="progress-fill" style="width: {project.progress}%"></div>
                  </div>
                  <span class="progress-text">{project.progress}%</span>
                </div>
                <div class="project-meta">
                  <span class="project-due">Due: {formatDate(project.dueDate)}</span>
                  <span class="project-priority" style="color: {getPriorityColor(project.priority)}">
                    {project.priority}
                  </span>
                </div>
              </div>
            {/each}
          </div>
        </div>
      </div>
    {:else if selectedTab === 'projects'}
      <div class="projects-content">
        <div class="content-header">
          <h2>All Projects</h2>
          <div class="content-controls">
            <div class="search-section">
              <input 
                type="text" 
                placeholder="Search projects..." 
                bind:value={searchTerm}
                class="search-input"
              />
            </div>
            <div class="filter-section">
              <select bind:value={selectedFilter} class="filter-select">
                {#each filters as filter}
                  <option value={filter.id}>{filter.name}</option>
                {/each}
              </select>
            </div>
          </div>
        </div>

        <div class="projects-list">
          {#each paginatedProjects as project}
            <div class="project-item">
              <div class="project-info">
                <div class="project-header">
                  <h3 class="project-name">{project.name}</h3>
                  <div class="project-badges">
                    <span class="status-badge" style="background-color: {getStatusColor(project.status)}">
                      {project.status}
                    </span>
                    <span class="priority-badge" style="color: {getPriorityColor(project.priority)}">
                      {project.priority}
                    </span>
                  </div>
                </div>
                <p class="project-description">{project.description}</p>
                <div class="project-details">
                  <div class="detail-item">
                    <span class="detail-label">Progress:</span>
                    <div class="progress-container">
                      <div class="progress-bar">
                        <div class="progress-fill" style="width: {project.progress}%"></div>
                      </div>
                      <span class="progress-text">{project.progress}%</span>
                    </div>
                  </div>
                  <div class="detail-item">
                    <span class="detail-label">Due Date:</span>
                    <span class="detail-value">{formatDate(project.dueDate)}</span>
                  </div>
                  <div class="detail-item">
                    <span class="detail-label">Team:</span>
                    <span class="detail-value">{project.team.join(', ')}</span>
                  </div>
                </div>
              </div>
              
              <div class="project-actions">
                <button 
                  class="action-btn primary" 
                  on:click={() => handleAction('View', project)}
                >
                  View
                </button>
                <button 
                  class="action-btn secondary" 
                  on:click={() => handleAction('Edit', project)}
                >
                  Edit
                </button>
                <button 
                  class="action-btn secondary" 
                  on:click={() => handleAction('Duplicate', project)}
                >
                  Duplicate
                </button>
                <button 
                  class="action-btn secondary" 
                  on:click={() => handleAction('Archive', project)}
                >
                  Archive
                </button>
                <button 
                  class="action-btn danger" 
                  on:click={() => handleAction('Delete', project)}
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
    {:else if selectedTab === 'tasks'}
      <div class="tasks-content">
        <h2>Task Management</h2>
        <p>Task management features coming soon...</p>
      </div>
    {:else if selectedTab === 'team'}
      <div class="team-content">
        <h2>Team Management</h2>
        <p>Team management features coming soon...</p>
      </div>
    {:else if selectedTab === 'reports'}
      <div class="reports-content">
        <h2>Reports & Analytics</h2>
        <p>Reporting features coming soon...</p>
      </div>
    {:else if selectedTab === 'settings'}
      <div class="settings-content">
        <h2>Settings</h2>
        <p>Settings panel coming soon...</p>
      </div>
    {/if}
  </main>
</div>

<style>
  .project-management {
    max-width: 1400px;
    margin: 50px auto;
    padding: 20px;
    font-family: Arial, sans-serif;
  }

  .app-header {
    text-align: center;
    margin-bottom: 40px;
  }

  .app-header h1 {
    margin: 0 0 10px 0;
    font-size: 36px;
    color: #333;
  }

  .app-header p {
    margin: 0;
    color: #666;
    font-size: 18px;
  }

  .app-navigation {
    margin-bottom: 30px;
  }

  .tab-navigation {
    display: flex;
    background: white;
    border-radius: 8px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.1);
    overflow: hidden;
  }

  .tab-btn {
    flex: 1;
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 5px;
    padding: 15px 10px;
    background: white;
    border: none;
    cursor: pointer;
    transition: all 0.2s ease;
    border-right: 1px solid #eee;
  }

  .tab-btn:last-child {
    border-right: none;
  }

  .tab-btn:hover {
    background: #f8f9fa;
  }

  .tab-btn.active {
    background: #007bff;
    color: white;
  }

  .tab-icon {
    font-size: 20px;
  }

  .tab-name {
    font-size: 12px;
    font-weight: bold;
  }

  .app-main {
    background: white;
    border-radius: 8px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.1);
    padding: 30px;
  }

  .dashboard-stats {
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

  .recent-projects h3 {
    margin: 0 0 20px 0;
    font-size: 24px;
    color: #333;
  }

  .projects-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
    gap: 20px;
  }

  .project-card {
    border: 1px solid #eee;
    border-radius: 8px;
    padding: 20px;
    transition: transform 0.2s ease, box-shadow 0.2s ease;
  }

  .project-card:hover {
    transform: translateY(-2px);
    box-shadow: 0 4px 12px rgba(0,0,0,0.15);
  }

  .project-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 10px;
  }

  .project-name {
    margin: 0;
    font-size: 18px;
    color: #333;
  }

  .project-status {
    font-size: 12px;
    font-weight: bold;
    text-transform: uppercase;
  }

  .project-description {
    margin: 0 0 15px 0;
    color: #666;
    font-size: 14px;
    line-height: 1.4;
  }

  .project-progress {
    display: flex;
    align-items: center;
    gap: 10px;
    margin-bottom: 15px;
  }

  .progress-bar {
    flex: 1;
    height: 6px;
    background: #eee;
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
    align-items: center;
    font-size: 12px;
    color: #666;
  }

  .project-priority {
    font-weight: bold;
    text-transform: uppercase;
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

  .projects-list {
    display: flex;
    flex-direction: column;
    gap: 15px;
  }

  .project-item {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 20px;
    border: 1px solid #eee;
    border-radius: 8px;
    transition: all 0.2s ease;
  }

  .project-item:hover {
    border-color: #007bff;
    box-shadow: 0 2px 8px rgba(0,123,255,0.1);
  }

  .project-info {
    flex: 1;
  }

  .project-badges {
    display: flex;
    gap: 8px;
  }

  .status-badge {
    padding: 4px 8px;
    border-radius: 12px;
    font-size: 11px;
    font-weight: bold;
    color: white;
    text-transform: uppercase;
  }

  .priority-badge {
    font-size: 11px;
    font-weight: bold;
    text-transform: uppercase;
  }

  .project-details {
    display: flex;
    flex-direction: column;
    gap: 8px;
    margin-top: 10px;
  }

  .detail-item {
    display: flex;
    align-items: center;
    gap: 10px;
    font-size: 14px;
  }

  .detail-label {
    font-weight: bold;
    color: #666;
    min-width: 80px;
  }

  .detail-value {
    color: #333;
  }

  .progress-container {
    display: flex;
    align-items: center;
    gap: 8px;
    flex: 1;
  }

  .project-actions {
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
    margin-top: 30px;
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

  .tasks-content,
  .team-content,
  .reports-content,
  .settings-content {
    text-align: center;
    padding: 60px 20px;
    color: #666;
  }

  .tasks-content h2,
  .team-content h2,
  .reports-content h2,
  .settings-content h2 {
    margin: 0 0 15px 0;
    font-size: 28px;
    color: #333;
  }

  @media (max-width: 768px) {
    .tab-navigation {
      flex-direction: column;
    }

    .tab-btn {
      border-right: none;
      border-bottom: 1px solid #eee;
    }

    .tab-btn:last-child {
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

    .project-item {
      flex-direction: column;
      align-items: stretch;
      gap: 15px;
    }

    .project-actions {
      justify-content: center;
    }
  }
</style>

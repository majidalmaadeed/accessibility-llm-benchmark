<script>
  import { invoke } from '@tauri-apps/api/tauri'
  import { onMount } from 'svelte'
  
  let currentView = 'data-table'
  let data = null
  let loading = false
  
  const views = [
    { id: 'data-table', name: 'Data Table', icon: '📊' },
    { id: 'wizard', name: 'Multi-Step Wizard', icon: '🧙' },
    { id: 'dashboard', name: 'Dashboard Widget', icon: '📈' },
    { id: 'media-player', name: 'Media Player', icon: '🎵' },
    { id: 'shopping-cart', name: 'Shopping Cart', icon: '🛒' },
    { id: 'calendar', name: 'Calendar', icon: '📅' },
    { id: 'rich-text', name: 'Rich Text Editor', icon: '✏️' },
    { id: 'search', name: 'Search Interface', icon: '🔍' },
    { id: 'map', name: 'Interactive Map', icon: '🗺️' },
    { id: 'social-feed', name: 'Social Media Feed', icon: '📱' }
  ]
  
  async function loadData(view) {
    loading = true
    currentView = view
    
    try {
      let command = ''
      switch(view) {
        case 'data-table':
          command = 'get_data_table_data'
          break
        case 'wizard':
          command = 'get_wizard_data'
          break
        case 'dashboard':
          command = 'get_dashboard_data'
          break
        case 'media-player':
          command = 'get_media_player_data'
          break
        case 'shopping-cart':
          command = 'get_shopping_cart_data'
          break
        case 'calendar':
          command = 'get_calendar_data'
          break
        case 'rich-text':
          command = 'get_rich_text_data'
          break
        case 'search':
          command = 'get_search_data'
          break
        case 'map':
          command = 'get_map_data'
          break
        case 'social-feed':
          command = 'get_social_feed_data'
          break
      }
      
      if (command) {
        data = await invoke(command)
      }
    } catch (error) {
      console.error('Error loading data:', error)
    } finally {
      loading = false
    }
  }
  
  onMount(() => {
    loadData('data-table')
  })
</script>

<main>
  <header>
    <h1>Accessibility Benchmark Testing</h1>
    <p>Advanced Scenarios - Tauri Implementation</p>
  </header>
  
  <nav>
    <div class="nav-grid">
      {#each views as view}
        <button 
          class="nav-item {currentView === view.id ? 'active' : ''}"
          on:click={() => loadData(view.id)}
        >
          <span class="nav-icon">{view.icon}</span>
          <span class="nav-name">{view.name}</span>
        </button>
      {/each}
    </div>
  </nav>
  
  <section class="content">
    {#if loading}
      <div class="loading">
        <div class="spinner"></div>
        <p>Loading {views.find(v => v.id === currentView)?.name}...</p>
      </div>
    {:else if data}
      <div class="scenario-content">
        {#if currentView === 'data-table'}
          <DataTable data={data} />
        {:else if currentView === 'wizard'}
          <Wizard data={data} />
        {:else if currentView === 'dashboard'}
          <Dashboard data={data} />
        {:else if currentView === 'media-player'}
          <MediaPlayer data={data} />
        {:else if currentView === 'shopping-cart'}
          <ShoppingCart data={data} />
        {:else if currentView === 'calendar'}
          <Calendar data={data} />
        {:else if currentView === 'rich-text'}
          <RichTextEditor data={data} />
        {:else if currentView === 'search'}
          <SearchInterface data={data} />
        {:else if currentView === 'map'}
          <InteractiveMap data={data} />
        {:else if currentView === 'social-feed'}
          <SocialFeed data={data} />
        {/if}
      </div>
    {/if}
  </section>
</main>

<style>
  :global(body) {
    font-family: Arial, sans-serif;
    margin: 0;
    padding: 20px;
    background: #f5f7fa;
  }
  
  main {
    max-width: 1400px;
    margin: 0 auto;
  }
  
  header {
    background: white;
    padding: 20px;
    border-radius: 12px;
    box-shadow: 0 2px 10px rgba(0,0,0,0.1);
    margin-bottom: 20px;
    text-align: center;
  }
  
  header h1 {
    margin: 0 0 10px 0;
    color: #333;
    font-size: 28px;
  }
  
  header p {
    margin: 0;
    color: #666;
    font-size: 16px;
  }
  
  nav {
    background: white;
    padding: 20px;
    border-radius: 12px;
    box-shadow: 0 2px 10px rgba(0,0,0,0.1);
    margin-bottom: 20px;
  }
  
  .nav-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
    gap: 15px;
  }
  
  .nav-item {
    display: flex;
    flex-direction: column;
    align-items: center;
    padding: 20px;
    border: 2px solid #e9ecef;
    border-radius: 8px;
    background: white;
    cursor: pointer;
    transition: all 0.3s ease;
    text-decoration: none;
    color: #333;
  }
  
  .nav-item:hover {
    border-color: #007bff;
    background: #f8f9fa;
    transform: translateY(-2px);
  }
  
  .nav-item.active {
    border-color: #007bff;
    background: #e3f2fd;
  }
  
  .nav-icon {
    font-size: 32px;
    margin-bottom: 10px;
  }
  
  .nav-name {
    font-size: 14px;
    font-weight: 600;
    text-align: center;
  }
  
  .content {
    background: white;
    border-radius: 12px;
    box-shadow: 0 2px 10px rgba(0,0,0,0.1);
    min-height: 600px;
  }
  
  .loading {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    padding: 60px 20px;
    color: #666;
  }
  
  .spinner {
    width: 40px;
    height: 40px;
    border: 3px solid #f3f3f3;
    border-top: 3px solid #007bff;
    border-radius: 50%;
    animation: spin 1s linear infinite;
    margin-bottom: 20px;
  }
  
  @keyframes spin {
    0% { transform: rotate(0deg); }
    100% { transform: rotate(360deg); }
  }
  
  .scenario-content {
    padding: 20px;
  }
</style>

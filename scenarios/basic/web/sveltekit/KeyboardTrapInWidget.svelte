<script>
  let selectedDate = '';
  let selectedTime = '';
  let selectedDuration = '30';
  let selectedService = '';
  let selectedProvider = '';
  let customerName = '';
  let customerEmail = '';
  let customerPhone = '';
  let notes = '';
  let isBooking = false;
  let showSuccess = false;
  
  const services = [
    { id: 'consultation', name: 'Consultation', duration: 60, price: 150 },
    { id: 'checkup', name: 'Regular Checkup', duration: 30, price: 100 },
    { id: 'cleaning', name: 'Teeth Cleaning', duration: 45, price: 80 },
    { id: 'filling', name: 'Dental Filling', duration: 60, price: 200 },
    { id: 'extraction', name: 'Tooth Extraction', duration: 30, price: 120 },
    { id: 'whitening', name: 'Teeth Whitening', duration: 90, price: 300 }
  ];
  
  const providers = [
    { id: 'dr-smith', name: 'Dr. Sarah Smith', specialty: 'General Dentistry' },
    { id: 'dr-johnson', name: 'Dr. Michael Johnson', specialty: 'Orthodontics' },
    { id: 'dr-williams', name: 'Dr. Emily Williams', specialty: 'Oral Surgery' },
    { id: 'dr-brown', name: 'Dr. David Brown', specialty: 'Periodontics' }
  ];
  
  const timeSlots = [
    '09:00', '09:30', '10:00', '10:30', '11:00', '11:30',
    '12:00', '12:30', '13:00', '13:30', '14:00', '14:30',
    '15:00', '15:30', '16:00', '16:30', '17:00', '17:30'
  ];
  
  function handleServiceChange() {
    const service = services.find(s => s.id === selectedService);
    if (service) {
      selectedDuration = service.duration.toString();
    }
  }
  
  function handleBooking() {
    if (!selectedDate || !selectedTime || !selectedService || !selectedProvider || !customerName || !customerEmail || !customerPhone) {
      return;
    }
    
    isBooking = true;
    
    // Simulate booking process
    setTimeout(() => {
      isBooking = false;
      showSuccess = true;
      
      // Reset form
      selectedDate = '';
      selectedTime = '';
      selectedDuration = '30';
      selectedService = '';
      selectedProvider = '';
      customerName = '';
      customerEmail = '';
      customerPhone = '';
      notes = '';
    }, 2000);
  }
  
  function handleKeydown(event) {
    // Trap focus within the booking widget
    const focusableElements = event.currentTarget.querySelectorAll(
      'input, select, textarea, button, [tabindex]:not([tabindex="-1"])'
    );
    const firstElement = focusableElements[0];
    const lastElement = focusableElements[focusableElements.length - 1];
    
    if (event.key === 'Tab') {
      if (event.shiftKey) {
        if (document.activeElement === firstElement) {
          event.preventDefault();
          lastElement.focus();
        }
      } else {
        if (document.activeElement === lastElement) {
          event.preventDefault();
          firstElement.focus();
        }
      }
    }
    
    if (event.key === 'Escape') {
      // Close the widget (in a real app, this would close the modal)
      event.preventDefault();
    }
  }
</script>

<div class="booking-widget" on:keydown={handleKeydown}>
  <div class="widget-header">
    <h2 class="widget-title">Book an Appointment</h2>
    <p class="widget-subtitle">Schedule your dental appointment with ease</p>
  </div>
  
  {#if showSuccess}
    <div class="success-message">
      <div class="success-icon">✓</div>
      <h3 class="success-title">Appointment Booked!</h3>
      <p class="success-description">Your appointment has been successfully scheduled. You will receive a confirmation email shortly.</p>
      <button 
        class="success-btn" 
        on:click={() => showSuccess = false}
      >
        Book Another Appointment
      </button>
    </div>
  {:else}
    <div class="widget-content">
      <div class="booking-section">
        <h3 class="section-title">Appointment Details</h3>
        
        <div class="form-row">
          <div class="form-group">
            <label class="form-label" for="date">Date *</label>
            <input 
              type="date" 
              id="date"
              bind:value={selectedDate}
              class="form-input"
              min={new Date().toISOString().split('T')[0]}
            />
          </div>
          
          <div class="form-group">
            <label class="form-label" for="time">Time *</label>
            <select 
              id="time"
              bind:value={selectedTime}
              class="form-select"
            >
              <option value="">Select time</option>
              {#each timeSlots as time (time)}
                <option value={time}>{time}</option>
              {/each}
            </select>
          </div>
        </div>
        
        <div class="form-row">
          <div class="form-group">
            <label class="form-label" for="service">Service *</label>
            <select 
              id="service"
              bind:value={selectedService}
              on:change={handleServiceChange}
              class="form-select"
            >
              <option value="">Select service</option>
              {#each services as service (service.id)}
                <option value={service.id}>{service.name} - ${service.price}</option>
              {/each}
            </select>
          </div>
          
          <div class="form-group">
            <label class="form-label" for="duration">Duration (minutes)</label>
            <input 
              type="number" 
              id="duration"
              bind:value={selectedDuration}
              class="form-input"
              min="15"
              max="180"
              step="15"
            />
          </div>
        </div>
        
        <div class="form-group">
          <label class="form-label" for="provider">Healthcare Provider *</label>
          <select 
            id="provider"
            bind:value={selectedProvider}
            class="form-select"
          >
            <option value="">Select provider</option>
            {#each providers as provider (provider.id)}
              <option value={provider.id}>{provider.name} - {provider.specialty}</option>
            {/each}
          </select>
        </div>
      </div>
      
      <div class="booking-section">
        <h3 class="section-title">Contact Information</h3>
        
        <div class="form-row">
          <div class="form-group">
            <label class="form-label" for="name">Full Name *</label>
            <input 
              type="text" 
              id="name"
              bind:value={customerName}
              class="form-input"
              placeholder="Enter your full name"
            />
          </div>
          
          <div class="form-group">
            <label class="form-label" for="email">Email Address *</label>
            <input 
              type="email" 
              id="email"
              bind:value={customerEmail}
              class="form-input"
              placeholder="Enter your email address"
            />
          </div>
        </div>
        
        <div class="form-group">
          <label class="form-label" for="phone">Phone Number *</label>
          <input 
            type="tel" 
            id="phone"
            bind:value={customerPhone}
            class="form-input"
            placeholder="Enter your phone number"
          />
        </div>
        
        <div class="form-group">
          <label class="form-label" for="notes">Additional Notes</label>
          <textarea 
            id="notes"
            bind:value={notes}
            class="form-textarea"
            placeholder="Any special requests or notes for your appointment"
            rows="3"
          ></textarea>
        </div>
      </div>
      
      <div class="booking-section">
        <h3 class="section-title">Appointment Summary</h3>
        <div class="summary-card">
          <div class="summary-item">
            <span class="summary-label">Date:</span>
            <span class="summary-value">{selectedDate || 'Not selected'}</span>
          </div>
          <div class="summary-item">
            <span class="summary-label">Time:</span>
            <span class="summary-value">{selectedTime || 'Not selected'}</span>
          </div>
          <div class="summary-item">
            <span class="summary-label">Service:</span>
            <span class="summary-value">
              {selectedService ? services.find(s => s.id === selectedService)?.name : 'Not selected'}
            </span>
          </div>
          <div class="summary-item">
            <span class="summary-label">Provider:</span>
            <span class="summary-value">
              {selectedProvider ? providers.find(p => p.id === selectedProvider)?.name : 'Not selected'}
            </span>
          </div>
          <div class="summary-item">
            <span class="summary-label">Duration:</span>
            <span class="summary-value">{selectedDuration} minutes</span>
          </div>
          {#if selectedService}
            <div class="summary-item total">
              <span class="summary-label">Total Cost:</span>
              <span class="summary-value">${services.find(s => s.id === selectedService)?.price || 0}</span>
            </div>
          {/if}
        </div>
      </div>
      
      <div class="widget-actions">
        <button 
          type="button" 
          class="btn btn-secondary"
          on:click={() => {
            selectedDate = '';
            selectedTime = '';
            selectedDuration = '30';
            selectedService = '';
            selectedProvider = '';
            customerName = '';
            customerEmail = '';
            customerPhone = '';
            notes = '';
          }}
        >
          Clear Form
        </button>
        <button 
          type="button" 
          class="btn btn-primary"
          on:click={handleBooking}
          disabled={isBooking || !selectedDate || !selectedTime || !selectedService || !selectedProvider || !customerName || !customerEmail || !customerPhone}
        >
          {isBooking ? 'Booking...' : 'Book Appointment'}
        </button>
      </div>
    </div>
  {/if}
</div>

<style>
  .booking-widget {
    font-family: Arial, sans-serif;
    line-height: 1.6;
    color: #333;
    background: white;
    border-radius: 12px;
    box-shadow: 0 4px 20px rgba(0,0,0,0.1);
    max-width: 600px;
    margin: 0 auto;
    overflow: hidden;
  }
  
  .widget-header {
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    color: white;
    padding: 30px;
    text-align: center;
  }
  
  .widget-title {
    margin: 0 0 10px 0;
    font-size: 24px;
    font-weight: bold;
  }
  
  .widget-subtitle {
    margin: 0;
    font-size: 16px;
    opacity: 0.9;
  }
  
  .widget-content {
    padding: 30px;
  }
  
  .booking-section {
    margin-bottom: 30px;
  }
  
  .booking-section:last-child {
    margin-bottom: 0;
  }
  
  .section-title {
    margin: 0 0 20px 0;
    font-size: 18px;
    color: #333;
    border-bottom: 2px solid #f0f0f0;
    padding-bottom: 10px;
  }
  
  .form-row {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 20px;
    margin-bottom: 20px;
  }
  
  .form-group {
    margin-bottom: 20px;
  }
  
  .form-label {
    display: block;
    margin-bottom: 8px;
    font-weight: bold;
    color: #333;
    font-size: 14px;
  }
  
  .form-input,
  .form-select,
  .form-textarea {
    width: 100%;
    padding: 12px 16px;
    border: 1px solid #ddd;
    border-radius: 6px;
    font-size: 16px;
    transition: border-color 0.2s ease;
    box-sizing: border-box;
  }
  
  .form-input:focus,
  .form-select:focus,
  .form-textarea:focus {
    outline: none;
    border-color: #667eea;
    box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
  }
  
  .form-textarea {
    resize: vertical;
    min-height: 80px;
  }
  
  .summary-card {
    background: #f8f9fa;
    border-radius: 8px;
    padding: 20px;
    border: 1px solid #e9ecef;
  }
  
  .summary-item {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 8px 0;
    border-bottom: 1px solid #e9ecef;
  }
  
  .summary-item:last-child {
    border-bottom: none;
  }
  
  .summary-item.total {
    font-weight: bold;
    font-size: 16px;
    color: #667eea;
    border-top: 2px solid #667eea;
    margin-top: 10px;
    padding-top: 15px;
  }
  
  .summary-label {
    color: #666;
    font-weight: 500;
  }
  
  .summary-value {
    color: #333;
    font-weight: bold;
  }
  
  .widget-actions {
    display: flex;
    gap: 15px;
    justify-content: flex-end;
    margin-top: 30px;
    padding-top: 20px;
    border-top: 1px solid #e9ecef;
  }
  
  .btn {
    padding: 12px 24px;
    border: none;
    border-radius: 6px;
    font-weight: bold;
    cursor: pointer;
    transition: all 0.2s ease;
    font-size: 16px;
  }
  
  .btn-primary {
    background: #667eea;
    color: white;
  }
  
  .btn-primary:hover:not(:disabled) {
    background: #5a6fd8;
  }
  
  .btn-primary:disabled {
    background: #6c757d;
    cursor: not-allowed;
  }
  
  .btn-secondary {
    background: #6c757d;
    color: white;
  }
  
  .btn-secondary:hover {
    background: #545b62;
  }
  
  .success-message {
    text-align: center;
    padding: 40px 30px;
  }
  
  .success-icon {
    width: 60px;
    height: 60px;
    background: #28a745;
    color: white;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 30px;
    margin: 0 auto 20px;
  }
  
  .success-title {
    margin: 0 0 15px 0;
    font-size: 20px;
    color: #333;
  }
  
  .success-description {
    margin: 0 0 25px 0;
    color: #666;
    font-size: 14px;
  }
  
  .success-btn {
    padding: 12px 24px;
    background: #667eea;
    color: white;
    border: none;
    border-radius: 6px;
    font-weight: bold;
    cursor: pointer;
    transition: all 0.2s ease;
  }
  
  .success-btn:hover {
    background: #5a6fd8;
  }
  
  @media (max-width: 768px) {
    .form-row {
      grid-template-columns: 1fr;
    }
    
    .widget-actions {
      flex-direction: column;
    }
    
    .btn {
      width: 100%;
    }
    
    .widget-content {
      padding: 20px;
    }
  }
</style>

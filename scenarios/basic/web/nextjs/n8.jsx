import { useState, useEffect, useRef } from 'react';

export default function KeyboardTrapInWidget() {
  const [isModalOpen, setIsModalOpen] = useState(false);
  const [isCalendarOpen, setIsCalendarOpen] = useState(false);
  const [isDropdownOpen, setIsDropdownOpen] = useState(false);
  const [selectedDate, setSelectedDate] = useState('');
  const [selectedOption, setSelectedOption] = useState('');
  const [formData, setFormData] = useState({
    title: '',
    description: '',
    priority: 'medium',
    category: '',
    assignee: '',
    dueDate: '',
    tags: ''
  });

  const modalRef = useRef(null);
  const calendarRef = useRef(null);
  const dropdownRef = useRef(null);
  const firstFocusableRef = useRef(null);
  const lastFocusableRef = useRef(null);

  const priorities = [
    { value: 'low', label: 'Low Priority', color: '#28a745' },
    { value: 'medium', label: 'Medium Priority', color: '#ffc107' },
    { value: 'high', label: 'High Priority', color: '#dc3545' },
    { value: 'urgent', label: 'Urgent', color: '#6f42c1' }
  ];

  const categories = [
    { value: 'development', label: 'Development' },
    { value: 'design', label: 'Design' },
    { value: 'marketing', label: 'Marketing' },
    { value: 'sales', label: 'Sales' },
    { value: 'support', label: 'Support' },
    { value: 'other', label: 'Other' }
  ];

  const assignees = [
    { value: 'john', label: 'John Doe', avatar: '/api/placeholder/32/32' },
    { value: 'jane', label: 'Jane Smith', avatar: '/api/placeholder/32/32' },
    { value: 'mike', label: 'Mike Johnson', avatar: '/api/placeholder/32/32' },
    { value: 'sarah', label: 'Sarah Wilson', avatar: '/api/placeholder/32/32' },
    { value: 'unassigned', label: 'Unassigned', avatar: null }
  ];

  const handleInputChange = (e) => {
    const { name, value } = e.target;
    setFormData(prev => ({
      ...prev,
      [name]: value
    }));
  };

  const handleSubmit = (e) => {
    e.preventDefault();
    alert('Task created successfully!');
    setIsModalOpen(false);
    setFormData({
      title: '',
      description: '',
      priority: 'medium',
      category: '',
      assignee: '',
      dueDate: '',
      tags: ''
    });
  };

  const handleModalOpen = () => {
    setIsModalOpen(true);
  };

  const handleModalClose = () => {
    setIsModalOpen(false);
  };

  const handleCalendarOpen = () => {
    setIsCalendarOpen(true);
  };

  const handleCalendarClose = () => {
    setIsCalendarOpen(false);
  };

  const handleDropdownOpen = () => {
    setIsDropdownOpen(true);
  };

  const handleDropdownClose = () => {
    setIsDropdownOpen(false);
  };

  const handleDateSelect = (date) => {
    setSelectedDate(date);
    setFormData(prev => ({ ...prev, dueDate: date }));
    setIsCalendarOpen(false);
  };

  const handleOptionSelect = (option) => {
    setSelectedOption(option);
    setFormData(prev => ({ ...prev, category: option }));
    setIsDropdownOpen(false);
  };

  const handleKeyDown = (e) => {
    if (e.key === 'Escape') {
      if (isModalOpen) {
        handleModalClose();
      } else if (isCalendarOpen) {
        handleCalendarClose();
      } else if (isDropdownOpen) {
        handleDropdownClose();
      }
    }
  };

  useEffect(() => {
    document.addEventListener('keydown', handleKeyDown);
    return () => document.removeEventListener('keydown', handleKeyDown);
  }, [isModalOpen, isCalendarOpen, isDropdownOpen]);

  const focusableElements = 'button, [href], input, select, textarea, [tabindex]:not([tabindex="-1"])';

  const trapFocus = (e) => {
    if (!modalRef.current && !calendarRef.current && !dropdownRef.current) return;

    const activeElement = document.activeElement;
    const focusableElementsList = Array.from(
      (modalRef.current || calendarRef.current || dropdownRef.current).querySelectorAll(focusableElements)
    );

    if (e.key === 'Tab') {
      if (e.shiftKey) {
        if (activeElement === focusableElementsList[0]) {
          e.preventDefault();
          focusableElementsList[focusableElementsList.length - 1].focus();
        }
      } else {
        if (activeElement === focusableElementsList[focusableElementsList.length - 1]) {
          e.preventDefault();
          focusableElementsList[0].focus();
        }
      }
    }
  };

  const generateCalendarDays = () => {
    const today = new Date();
    const currentMonth = today.getMonth();
    const currentYear = today.getFullYear();
    const firstDay = new Date(currentYear, currentMonth, 1);
    const lastDay = new Date(currentYear, currentMonth + 1, 0);
    const daysInMonth = lastDay.getDate();
    const startingDayOfWeek = firstDay.getDay();

    const days = [];
    
    for (let i = 0; i < startingDayOfWeek; i++) {
      days.push(null);
    }
    
    for (let day = 1; day <= daysInMonth; day++) {
      days.push(day);
    }
    
    return days;
  };

  const formatDate = (dateString) => {
    if (!dateString) return '';
    const date = new Date(dateString);
    return date.toLocaleDateString('en-US', {
      year: 'numeric',
      month: 'long',
      day: 'numeric'
    });
  };

  return (
    <div className="task-management">
      <header className="management-header">
        <h1>Task Management System</h1>
        <p>Create and manage your tasks efficiently</p>
      </header>

      <div className="management-content">
        <div className="task-controls">
          <button 
            className="btn btn-primary"
            onClick={handleModalOpen}
          >
            Create New Task
          </button>
          
          <div className="filter-controls">
            <button 
              className="filter-btn"
              onClick={handleDropdownOpen}
            >
              Filter by Category: {selectedOption || 'All'}
            </button>
          </div>
        </div>

        <div className="task-list">
          <div className="task-item">
            <div className="task-header">
              <h3>Sample Task 1</h3>
              <span className="priority-badge high">High</span>
            </div>
            <p className="task-description">This is a sample task description</p>
            <div className="task-meta">
              <span className="task-category">Development</span>
              <span className="task-due-date">Due: Feb 15, 2024</span>
            </div>
          </div>

          <div className="task-item">
            <div className="task-header">
              <h3>Sample Task 2</h3>
              <span className="priority-badge medium">Medium</span>
            </div>
            <p className="task-description">Another sample task with different priority</p>
            <div className="task-meta">
              <span className="task-category">Design</span>
              <span className="task-due-date">Due: Feb 20, 2024</span>
            </div>
          </div>
        </div>
      </div>

      {isModalOpen && (
        <div className="modal-overlay" onClick={handleModalClose}>
          <div 
            className="modal-content"
            ref={modalRef}
            onClick={(e) => e.stopPropagation()}
            onKeyDown={trapFocus}
          >
            <div className="modal-header">
              <h2>Create New Task</h2>
              <button 
                className="modal-close"
                onClick={handleModalClose}
                ref={firstFocusableRef}
              >
                ✕
              </button>
            </div>

            <form onSubmit={handleSubmit} className="modal-body">
              <div className="form-group">
                <label htmlFor="title" className="form-label">
                  Task Title *
                </label>
                <input
                  type="text"
                  id="title"
                  name="title"
                  value={formData.title}
                  onChange={handleInputChange}
                  className="form-input"
                  placeholder="Enter task title"
                  required
                />
              </div>

              <div className="form-group">
                <label htmlFor="description" className="form-label">
                  Description
                </label>
                <textarea
                  id="description"
                  name="description"
                  value={formData.description}
                  onChange={handleInputChange}
                  className="form-textarea"
                  placeholder="Enter task description"
                  rows="4"
                />
              </div>

              <div className="form-row">
                <div className="form-group">
                  <label htmlFor="priority" className="form-label">
                    Priority
                  </label>
                  <select
                    id="priority"
                    name="priority"
                    value={formData.priority}
                    onChange={handleInputChange}
                    className="form-select"
                  >
                    {priorities.map(priority => (
                      <option key={priority.value} value={priority.value}>
                        {priority.label}
                      </option>
                    ))}
                  </select>
                </div>

                <div className="form-group">
                  <label htmlFor="assignee" className="form-label">
                    Assignee
                  </label>
                  <select
                    id="assignee"
                    name="assignee"
                    value={formData.assignee}
                    onChange={handleInputChange}
                    className="form-select"
                  >
                    <option value="">Select assignee</option>
                    {assignees.map(assignee => (
                      <option key={assignee.value} value={assignee.value}>
                        {assignee.label}
                      </option>
                    ))}
                  </select>
                </div>
              </div>

              <div className="form-group">
                <label htmlFor="dueDate" className="form-label">
                  Due Date
                </label>
                <div className="date-input-container">
                  <input
                    type="text"
                    id="dueDate"
                    name="dueDate"
                    value={formData.dueDate}
                    onChange={handleInputChange}
                    className="form-input"
                    placeholder="Select due date"
                    readOnly
                  />
                  <button
                    type="button"
                    className="date-picker-btn"
                    onClick={handleCalendarOpen}
                  >
                    📅
                  </button>
                </div>
              </div>

              <div className="form-group">
                <label htmlFor="tags" className="form-label">
                  Tags
                </label>
                <input
                  type="text"
                  id="tags"
                  name="tags"
                  value={formData.tags}
                  onChange={handleInputChange}
                  className="form-input"
                  placeholder="Enter tags separated by commas"
                />
              </div>

              <div className="modal-actions">
                <button 
                  type="button" 
                  className="btn btn-secondary"
                  onClick={handleModalClose}
                >
                  Cancel
                </button>
                <button 
                  type="submit" 
                  className="btn btn-primary"
                  ref={lastFocusableRef}
                >
                  Create Task
                </button>
              </div>
            </form>
          </div>
        </div>
      )}

      {isCalendarOpen && (
        <div className="calendar-overlay" onClick={handleCalendarClose}>
          <div 
            className="calendar-content"
            ref={calendarRef}
            onClick={(e) => e.stopPropagation()}
            onKeyDown={trapFocus}
          >
            <div className="calendar-header">
              <h3>Select Due Date</h3>
              <button 
                className="calendar-close"
                onClick={handleCalendarClose}
              >
                ✕
              </button>
            </div>

            <div className="calendar-body">
              <div className="calendar-grid">
                <div className="calendar-day-header">Sun</div>
                <div className="calendar-day-header">Mon</div>
                <div className="calendar-day-header">Tue</div>
                <div className="calendar-day-header">Wed</div>
                <div className="calendar-day-header">Thu</div>
                <div className="calendar-day-header">Fri</div>
                <div className="calendar-day-header">Sat</div>
                
                {generateCalendarDays().map((day, index) => (
                  <button
                    key={index}
                    className={`calendar-day ${day ? 'selectable' : 'empty'}`}
                    onClick={() => day && handleDateSelect(`${new Date().getFullYear()}-${String(new Date().getMonth() + 1).padStart(2, '0')}-${String(day).padStart(2, '0')}`)}
                    disabled={!day}
                  >
                    {day}
                  </button>
                ))}
              </div>
            </div>

            <div className="calendar-actions">
              <button 
                className="btn btn-secondary"
                onClick={handleCalendarClose}
              >
                Cancel
              </button>
              <button 
                className="btn btn-primary"
                onClick={() => handleDateSelect('')}
              >
                Clear Date
              </button>
            </div>
          </div>
        </div>
      )}

      {isDropdownOpen && (
        <div className="dropdown-overlay" onClick={handleDropdownClose}>
          <div 
            className="dropdown-content"
            ref={dropdownRef}
            onClick={(e) => e.stopPropagation()}
            onKeyDown={trapFocus}
          >
            <div className="dropdown-header">
              <h3>Filter by Category</h3>
              <button 
                className="dropdown-close"
                onClick={handleDropdownClose}
              >
                ✕
              </button>
            </div>

            <div className="dropdown-options">
              <button
                className="dropdown-option"
                onClick={() => handleOptionSelect('')}
              >
                All Categories
              </button>
              {categories.map(category => (
                <button
                  key={category.value}
                  className="dropdown-option"
                  onClick={() => handleOptionSelect(category.value)}
                >
                  {category.label}
                </button>
              ))}
            </div>
          </div>
        </div>
      )}

      <style jsx>{`
        .task-management {
          max-width: 1200px;
          margin: 0 auto;
          padding: 20px;
          font-family: Arial, sans-serif;
        }

        .management-header {
          text-align: center;
          margin-bottom: 40px;
        }

        .management-header h1 {
          margin: 0 0 10px 0;
          font-size: 32px;
          color: #333;
        }

        .management-header p {
          margin: 0;
          color: #666;
          font-size: 16px;
        }

        .management-content {
          background: white;
          border-radius: 8px;
          box-shadow: 0 2px 8px rgba(0,0,0,0.1);
          padding: 30px;
        }

        .task-controls {
          display: flex;
          justify-content: space-between;
          align-items: center;
          margin-bottom: 30px;
          padding-bottom: 20px;
          border-bottom: 1px solid #e9ecef;
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

        .btn-secondary {
          background: #6c757d;
          color: white;
        }

        .btn-secondary:hover {
          background: #545b62;
        }

        .filter-btn {
          padding: 8px 16px;
          background: #f8f9fa;
          border: 1px solid #ddd;
          border-radius: 4px;
          cursor: pointer;
          font-size: 14px;
        }

        .filter-btn:hover {
          background: #e9ecef;
        }

        .task-list {
          display: flex;
          flex-direction: column;
          gap: 20px;
        }

        .task-item {
          padding: 20px;
          border: 1px solid #e9ecef;
          border-radius: 6px;
          background: #f8f9fa;
        }

        .task-header {
          display: flex;
          justify-content: space-between;
          align-items: center;
          margin-bottom: 10px;
        }

        .task-header h3 {
          margin: 0;
          font-size: 18px;
          color: #333;
        }

        .priority-badge {
          padding: 4px 8px;
          border-radius: 12px;
          color: white;
          font-size: 12px;
          font-weight: bold;
          text-transform: uppercase;
        }

        .priority-badge.high {
          background: #dc3545;
        }

        .priority-badge.medium {
          background: #ffc107;
          color: #212529;
        }

        .task-description {
          margin: 0 0 15px 0;
          color: #666;
          line-height: 1.4;
        }

        .task-meta {
          display: flex;
          gap: 20px;
          font-size: 14px;
          color: #666;
        }

        .modal-overlay,
        .calendar-overlay,
        .dropdown-overlay {
          position: fixed;
          top: 0;
          left: 0;
          right: 0;
          bottom: 0;
          background: rgba(0,0,0,0.5);
          display: flex;
          align-items: center;
          justify-content: center;
          z-index: 1000;
        }

        .modal-content,
        .calendar-content,
        .dropdown-content {
          background: white;
          border-radius: 8px;
          max-width: 600px;
          width: 90%;
          max-height: 90vh;
          overflow-y: auto;
        }

        .modal-header,
        .calendar-header,
        .dropdown-header {
          display: flex;
          justify-content: space-between;
          align-items: center;
          padding: 20px;
          border-bottom: 1px solid #e9ecef;
        }

        .modal-header h2,
        .calendar-header h3,
        .dropdown-header h3 {
          margin: 0;
          font-size: 20px;
          color: #333;
        }

        .modal-close,
        .calendar-close,
        .dropdown-close {
          background: none;
          border: none;
          font-size: 20px;
          cursor: pointer;
          color: #666;
          padding: 5px;
        }

        .modal-body {
          padding: 20px;
        }

        .form-group {
          margin-bottom: 20px;
        }

        .form-row {
          display: grid;
          grid-template-columns: 1fr 1fr;
          gap: 20px;
        }

        .form-label {
          display: block;
          margin-bottom: 5px;
          font-weight: bold;
          color: #333;
        }

        .form-input,
        .form-textarea,
        .form-select {
          width: 100%;
          padding: 10px;
          border: 1px solid #ddd;
          border-radius: 4px;
          font-size: 14px;
        }

        .form-textarea {
          resize: vertical;
          min-height: 80px;
        }

        .date-input-container {
          display: flex;
          gap: 10px;
        }

        .date-picker-btn {
          padding: 10px;
          background: #f8f9fa;
          border: 1px solid #ddd;
          border-radius: 4px;
          cursor: pointer;
          font-size: 16px;
        }

        .modal-actions,
        .calendar-actions {
          display: flex;
          gap: 10px;
          justify-content: flex-end;
          padding: 20px;
          border-top: 1px solid #e9ecef;
        }

        .calendar-body {
          padding: 20px;
        }

        .calendar-grid {
          display: grid;
          grid-template-columns: repeat(7, 1fr);
          gap: 5px;
        }

        .calendar-day-header {
          text-align: center;
          font-weight: bold;
          color: #666;
          padding: 10px;
          font-size: 12px;
        }

        .calendar-day {
          padding: 10px;
          border: 1px solid #e9ecef;
          background: white;
          cursor: pointer;
          text-align: center;
          font-size: 14px;
          transition: all 0.2s ease;
        }

        .calendar-day.selectable:hover {
          background: #e3f2fd;
          border-color: #007bff;
        }

        .calendar-day.empty {
          background: #f8f9fa;
          cursor: not-allowed;
        }

        .dropdown-options {
          padding: 20px;
        }

        .dropdown-option {
          width: 100%;
          padding: 10px;
          border: none;
          background: white;
          text-align: left;
          cursor: pointer;
          font-size: 14px;
          transition: background-color 0.2s ease;
        }

        .dropdown-option:hover {
          background: #f8f9fa;
        }

        @media (max-width: 768px) {
          .task-management {
            padding: 10px;
          }

          .management-content {
            padding: 20px;
          }

          .task-controls {
            flex-direction: column;
            gap: 15px;
            align-items: stretch;
          }

          .form-row {
            grid-template-columns: 1fr;
            gap: 15px;
          }

          .modal-actions,
          .calendar-actions {
            flex-direction: column;
          }

          .btn {
            width: 100%;
          }
        }
      `}</style>
    </div>
  );
}

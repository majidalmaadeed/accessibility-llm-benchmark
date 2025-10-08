<template>
  <div class="survey-application">
    <header class="app-header">
      <div class="header-content">
        <h1 class="app-title">Customer Feedback Survey</h1>
        <div class="progress-indicator">
          <span class="progress-text">Step 2 of 4</span>
          <div class="progress-bar">
            <div class="progress-fill" style="width: 50%"></div>
          </div>
        </div>
      </div>
    </header>

    <main class="main-content">
      <div class="survey-container">
        <div class="survey-header">
          <h2 class="survey-title">Tell Us About Your Experience</h2>
          <p class="survey-description">
            Your feedback helps us improve our services and better serve our customers.
          </p>
        </div>

        <form class="survey-form" @submit.prevent="submitSurvey">
          <div class="form-section">
            <h3 class="section-title">Contact Information</h3>
            
            <div class="form-group">
              <label for="firstName" class="form-label">First Name</label>
              <input 
                type="text" 
                id="firstName" 
                name="firstName"
                class="form-input"
                required
              />
            </div>

            <div class="form-group">
              <label for="lastName" class="form-label">Last Name</label>
              <input 
                type="text" 
                id="lastName" 
                name="lastName"
                class="form-input"
                required
              />
            </div>

            <div class="form-group">
              <label for="email" class="form-label">Email Address</label>
              <input 
                type="email" 
                id="email" 
                name="email"
                class="form-input"
                required
              />
            </div>

            <div class="form-group">
              <label for="phone" class="form-label">Phone Number</label>
              <input 
                type="tel" 
                id="phone" 
                name="phone"
                class="form-input"
              />
            </div>
          </div>

          <div class="form-section">
            <h3 class="section-title">Service Rating</h3>
            
            <div class="rating-question">
              <p class="question-text">How would you rate our overall service?</p>
              <div class="rating-options">
                <label class="rating-option">
                  <input type="radio" name="overallRating" value="excellent" />
                  <span class="rating-label">Excellent</span>
                </label>
                <label class="rating-option">
                  <input type="radio" name="overallRating" value="good" />
                  <span class="rating-label">Good</span>
                </label>
                <label class="rating-option">
                  <input type="radio" name="overallRating" value="average" />
                  <span class="rating-label">Average</span>
                </label>
                <label class="rating-option">
                  <input type="radio" name="overallRating" value="poor" />
                  <span class="rating-label">Poor</span>
                </label>
                <label class="rating-option">
                  <input type="radio" name="overallRating" value="terrible" />
                  <span class="rating-label">Terrible</span>
                </label>
              </div>
            </div>

            <div class="rating-question">
              <p class="question-text">How satisfied are you with our response time?</p>
              <div class="rating-options">
                <label class="rating-option">
                  <input type="radio" name="responseTime" value="very-satisfied" />
                  <span class="rating-label">Very Satisfied</span>
                </label>
                <label class="rating-option">
                  <input type="radio" name="responseTime" value="satisfied" />
                  <span class="rating-label">Satisfied</span>
                </label>
                <label class="rating-option">
                  <input type="radio" name="responseTime" value="neutral" />
                  <span class="rating-label">Neutral</span>
                </label>
                <label class="rating-option">
                  <input type="radio" name="responseTime" value="dissatisfied" />
                  <span class="rating-label">Dissatisfied</span>
                </label>
                <label class="rating-option">
                  <input type="radio" name="responseTime" value="very-dissatisfied" />
                  <span class="rating-label">Very Dissatisfied</span>
                </label>
              </div>
            </div>
          </div>

          <div class="form-section">
            <h3 class="section-title">Communication Preferences</h3>
            
            <div class="preference-question">
              <p class="question-text">How would you like to receive updates about our services?</p>
              <div class="preference-options">
                <label class="preference-option">
                  <input type="radio" name="communicationMethod" value="email" />
                  <span class="preference-label">Email</span>
                </label>
                <label class="preference-option">
                  <input type="radio" name="communicationMethod" value="phone" />
                  <span class="preference-label">Phone Call</span>
                </label>
                <label class="preference-option">
                  <input type="radio" name="communicationMethod" value="sms" />
                  <span class="preference-label">SMS Text</span>
                </label>
                <label class="preference-option">
                  <input type="radio" name="communicationMethod" value="mail" />
                  <span class="preference-label">Postal Mail</span>
                </label>
                <label class="preference-option">
                  <input type="radio" name="communicationMethod" value="none" />
                  <span class="preference-label">No Updates</span>
                </label>
              </div>
            </div>

            <div class="preference-question">
              <p class="question-text">What is your preferred contact time?</p>
              <div class="preference-options">
                <label class="preference-option">
                  <input type="radio" name="contactTime" value="morning" />
                  <span class="preference-label">Morning (9 AM - 12 PM)</span>
                </label>
                <label class="preference-option">
                  <input type="radio" name="contactTime" value="afternoon" />
                  <span class="preference-label">Afternoon (12 PM - 5 PM)</span>
                </label>
                <label class="preference-option">
                  <input type="radio" name="contactTime" value="evening" />
                  <span class="preference-label">Evening (5 PM - 8 PM)</span>
                </label>
                <label class="preference-option">
                  <input type="radio" name="contactTime" value="anytime" />
                  <span class="preference-label">Anytime</span>
                </label>
              </div>
            </div>
          </div>

          <div class="form-section">
            <h3 class="section-title">Product Interest</h3>
            
            <div class="interest-question">
              <p class="question-text">Which of our products are you most interested in?</p>
              <div class="interest-options">
                <label class="interest-option">
                  <input type="radio" name="productInterest" value="basic" />
                  <span class="interest-label">Basic Plan</span>
                </label>
                <label class="interest-option">
                  <input type="radio" name="productInterest" value="premium" />
                  <span class="interest-label">Premium Plan</span>
                </label>
                <label class="interest-option">
                  <input type="radio" name="productInterest" value="enterprise" />
                  <span class="interest-label">Enterprise Plan</span>
                </label>
                <label class="interest-option">
                  <input type="radio" name="productInterest" value="custom" />
                  <span class="interest-label">Custom Solution</span>
                </label>
                <label class="interest-option">
                  <input type="radio" name="productInterest" value="not-interested" />
                  <span class="interest-label">Not Interested</span>
                </label>
              </div>
            </div>

            <div class="interest-question">
              <p class="question-text">How did you hear about us?</p>
              <div class="interest-options">
                <label class="interest-option">
                  <input type="radio" name="referralSource" value="search-engine" />
                  <span class="interest-label">Search Engine</span>
                </label>
                <label class="interest-option">
                  <input type="radio" name="referralSource" value="social-media" />
                  <span class="interest-label">Social Media</span>
                </label>
                <label class="interest-option">
                  <input type="radio" name="referralSource" value="friend" />
                  <span class="interest-label">Friend/Family</span>
                </label>
                <label class="interest-option">
                  <input type="radio" name="referralSource" value="advertisement" />
                  <span class="interest-label">Advertisement</span>
                </label>
                <label class="interest-option">
                  <input type="radio" name="referralSource" value="other" />
                  <span class="interest-label">Other</span>
                </label>
              </div>
            </div>
          </div>

          <div class="form-section">
            <h3 class="section-title">Additional Information</h3>
            
            <div class="form-group">
              <label for="comments" class="form-label">Additional Comments</label>
              <textarea 
                id="comments" 
                name="comments"
                class="form-textarea"
                rows="4"
                placeholder="Please share any additional feedback or suggestions..."
              ></textarea>
            </div>

            <div class="form-group">
              <label for="suggestions" class="form-label">Suggestions for Improvement</label>
              <textarea 
                id="suggestions" 
                name="suggestions"
                class="form-textarea"
                rows="3"
                placeholder="What could we do better?"
              ></textarea>
            </div>
          </div>

          <div class="form-section">
            <h3 class="section-title">Follow-up Preferences</h3>
            
            <div class="followup-question">
              <p class="question-text">Would you like us to follow up with you?</p>
              <div class="followup-options">
                <label class="followup-option">
                  <input type="radio" name="followUp" value="yes" />
                  <span class="followup-label">Yes, please follow up</span>
                </label>
                <label class="followup-option">
                  <input type="radio" name="followUp" value="no" />
                  <span class="followup-label">No, thank you</span>
                </label>
              </div>
            </div>

            <div class="followup-question">
              <p class="question-text">How soon would you like to be contacted?</p>
              <div class="followup-options">
                <label class="followup-option">
                  <input type="radio" name="followUpTiming" value="immediately" />
                  <span class="followup-label">Immediately</span>
                </label>
                <label class="followup-option">
                  <input type="radio" name="followUpTiming" value="within-week" />
                  <span class="followup-label">Within a week</span>
                </label>
                <label class="followup-option">
                  <input type="radio" name="followUpTiming" value="within-month" />
                  <span class="followup-label">Within a month</span>
                </label>
                <label class="followup-option">
                  <input type="radio" name="followUpTiming" value="no-rush" />
                  <span class="followup-label">No rush</span>
                </label>
              </div>
            </div>
          </div>

          <div class="form-actions">
            <button type="button" class="btn btn-secondary">Previous</button>
            <button type="submit" class="btn btn-primary">Submit Survey</button>
          </div>
        </form>
      </div>
    </main>

    <footer class="app-footer">
      <div class="footer-content">
        <div class="footer-section">
          <h4>Survey Information</h4>
          <ul class="footer-links">
            <li><a href="/privacy">Privacy Policy</a></li>
            <li><a href="/terms">Terms of Service</a></li>
            <li><a href="/help">Help Center</a></li>
            <li><a href="/contact">Contact Us</a></li>
          </ul>
        </div>
        <div class="footer-section">
          <h4>About This Survey</h4>
          <ul class="footer-links">
            <li><a href="/purpose">Survey Purpose</a></li>
            <li><a href="/data-usage">How We Use Data</a></li>
            <li><a href="/results">Survey Results</a></li>
            <li><a href="/feedback">Feedback Process</a></li>
          </ul>
        </div>
        <div class="footer-section">
          <h4>Support</h4>
          <ul class="footer-links">
            <li><a href="/faq">FAQ</a></li>
            <li><a href="/technical-support">Technical Support</a></li>
            <li><a href="/accessibility">Accessibility</a></li>
            <li><a href="/report-issue">Report an Issue</a></li>
          </ul>
        </div>
      </div>
      <div class="footer-bottom">
        <p>&copy; 2024 Customer Feedback Survey. All rights reserved.</p>
      </div>
    </footer>
  </div>
</template>

<script setup>
const submitSurvey = (event) => {
  event.preventDefault()
  const formData = new FormData(event.target)
  const data = Object.fromEntries(formData.entries())
  console.log('Survey submitted:', data)
  alert('Thank you for your feedback! Your survey has been submitted.')
}
</script>

<style scoped>
.survey-application {
  font-family: Arial, sans-serif;
  line-height: 1.6;
  color: #333;
  background: #f8f9fa;
  min-height: 100vh;
}

.app-header {
  background: white;
  box-shadow: 0 2px 10px rgba(0,0,0,0.1);
  position: sticky;
  top: 0;
  z-index: 100;
}

.header-content {
  max-width: 800px;
  margin: 0 auto;
  padding: 20px;
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.app-title {
  margin: 0;
  font-size: 24px;
  font-weight: bold;
  color: #333;
}

.progress-indicator {
  display: flex;
  flex-direction: column;
  align-items: flex-end;
  gap: 8px;
}

.progress-text {
  font-size: 14px;
  color: #666;
  font-weight: 500;
}

.progress-bar {
  width: 200px;
  height: 8px;
  background: #e9ecef;
  border-radius: 4px;
  overflow: hidden;
}

.progress-fill {
  height: 100%;
  background: #007bff;
  transition: width 0.3s ease;
}

.main-content {
  max-width: 800px;
  margin: 0 auto;
  padding: 40px 20px;
}

.survey-container {
  background: white;
  border-radius: 12px;
  box-shadow: 0 4px 20px rgba(0,0,0,0.1);
  overflow: hidden;
}

.survey-header {
  background: linear-gradient(135deg, #007bff 0%, #0056b3 100%);
  color: white;
  padding: 40px;
  text-align: center;
}

.survey-title {
  margin: 0 0 15px 0;
  font-size: 32px;
  font-weight: bold;
}

.survey-description {
  margin: 0;
  font-size: 18px;
  opacity: 0.9;
}

.survey-form {
  padding: 40px;
}

.form-section {
  margin-bottom: 50px;
  padding-bottom: 30px;
  border-bottom: 1px solid #eee;
}

.form-section:last-of-type {
  border-bottom: none;
  margin-bottom: 0;
}

.section-title {
  margin: 0 0 30px 0;
  font-size: 24px;
  color: #333;
  border-bottom: 2px solid #007bff;
  padding-bottom: 10px;
}

.form-group {
  margin-bottom: 25px;
}

.form-label {
  display: block;
  margin-bottom: 8px;
  font-weight: bold;
  color: #333;
  font-size: 16px;
}

.form-input,
.form-textarea {
  width: 100%;
  padding: 12px 16px;
  border: 2px solid #ddd;
  border-radius: 6px;
  font-size: 16px;
  transition: border-color 0.2s ease;
  box-sizing: border-box;
}

.form-input:focus,
.form-textarea:focus {
  outline: none;
  border-color: #007bff;
}

.form-textarea {
  resize: vertical;
  min-height: 100px;
}

.rating-question,
.preference-question,
.interest-question,
.followup-question {
  margin-bottom: 30px;
}

.question-text {
  margin: 0 0 20px 0;
  font-size: 18px;
  font-weight: bold;
  color: #333;
}

.rating-options,
.preference-options,
.interest-options,
.followup-options {
  display: flex;
  flex-direction: column;
  gap: 12px;
}

.rating-option,
.preference-option,
.interest-option,
.followup-option {
  display: flex;
  align-items: center;
  gap: 12px;
  padding: 12px 16px;
  border: 2px solid #e9ecef;
  border-radius: 8px;
  cursor: pointer;
  transition: all 0.2s ease;
  background: white;
}

.rating-option:hover,
.preference-option:hover,
.interest-option:hover,
.followup-option:hover {
  border-color: #007bff;
  background: #f8f9ff;
}

.rating-option input[type="radio"],
.preference-option input[type="radio"],
.interest-option input[type="radio"],
.followup-option input[type="radio"] {
  margin: 0;
  width: 18px;
  height: 18px;
  accent-color: #007bff;
}

.rating-option input[type="radio"]:checked + .rating-label,
.preference-option input[type="radio"]:checked + .preference-label,
.interest-option input[type="radio"]:checked + .interest-label,
.followup-option input[type="radio"]:checked + .followup-label {
  color: #007bff;
  font-weight: bold;
}

.rating-option:has(input[type="radio"]:checked),
.preference-option:has(input[type="radio"]:checked),
.interest-option:has(input[type="radio"]:checked),
.followup-option:has(input[type="radio"]:checked) {
  border-color: #007bff;
  background: #f8f9ff;
}

.rating-label,
.preference-label,
.interest-label,
.followup-label {
  font-size: 16px;
  color: #333;
  cursor: pointer;
  flex: 1;
}

.form-actions {
  display: flex;
  justify-content: space-between;
  gap: 20px;
  margin-top: 40px;
  padding-top: 30px;
  border-top: 1px solid #eee;
}

.btn {
  padding: 15px 30px;
  border: none;
  border-radius: 6px;
  font-size: 16px;
  font-weight: bold;
  cursor: pointer;
  transition: all 0.2s ease;
  text-decoration: none;
  display: inline-block;
  text-align: center;
}

.btn-primary {
  background: #007bff;
  color: white;
}

.btn-primary:hover {
  background: #0056b3;
  transform: translateY(-2px);
  box-shadow: 0 4px 12px rgba(0, 123, 255, 0.3);
}

.btn-secondary {
  background: #6c757d;
  color: white;
}

.btn-secondary:hover {
  background: #545b62;
  transform: translateY(-2px);
}

.app-footer {
  background: #333;
  color: white;
  padding: 40px 0 20px;
  margin-top: 50px;
}

.footer-content {
  max-width: 1200px;
  margin: 0 auto;
  padding: 0 20px;
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
  gap: 30px;
  margin-bottom: 30px;
}

.footer-section h4 {
  margin: 0 0 20px 0;
  font-size: 18px;
  color: white;
}

.footer-links {
  list-style: none;
  padding: 0;
  margin: 0;
}

.footer-links li {
  margin-bottom: 10px;
}

.footer-links a {
  color: #ccc;
  text-decoration: none;
  transition: color 0.2s ease;
}

.footer-links a:hover {
  color: white;
}

.footer-bottom {
  text-align: center;
  padding-top: 20px;
  border-top: 1px solid #555;
  color: #ccc;
}

@media (max-width: 768px) {
  .header-content {
    flex-direction: column;
    gap: 20px;
    text-align: center;
  }

  .progress-indicator {
    align-items: center;
  }

  .progress-bar {
    width: 100%;
    max-width: 300px;
  }

  .survey-header {
    padding: 30px 20px;
  }

  .survey-title {
    font-size: 28px;
  }

  .survey-form {
    padding: 30px 20px;
  }

  .section-title {
    font-size: 20px;
  }

  .rating-options,
  .preference-options,
  .interest-options,
  .followup-options {
    gap: 8px;
  }

  .rating-option,
  .preference-option,
  .interest-option,
  .followup-option {
    padding: 10px 12px;
  }

  .form-actions {
    flex-direction: column;
  }

  .btn {
    width: 100%;
  }

  .footer-content {
    grid-template-columns: 1fr;
    text-align: center;
  }
}

@media (max-width: 480px) {
  .survey-title {
    font-size: 24px;
  }

  .survey-description {
    font-size: 16px;
  }

  .question-text {
    font-size: 16px;
  }

  .rating-label,
  .preference-label,
  .interest-label,
  .followup-label {
    font-size: 14px;
  }
}
</style>

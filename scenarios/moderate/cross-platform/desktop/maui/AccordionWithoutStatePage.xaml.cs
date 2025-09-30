using Microsoft.Maui.Controls;
{
    public partial class AccordionWithoutStatePage : ContentPage
    {
        private HashSet<int> _expandedItems = new HashSet<int>();
        private List<Button> _questionButtons = new List<Button>();
        public AccordionWithoutStatePage()
        {
            InitializeComponent();
            SetupAccordionItems();
        }
        private void SetupAccordionItems()
        {
            _questionButtons.Add(QuestionButton1);
            _questionButtons.Add(QuestionButton2);
            _questionButtons.Add(QuestionButton3);
            _questionButtons.Add(QuestionButton4);
            // Set up button properties
            for (int i = 0; i < _questionButtons.Count; i++)
            {
                _questionButtons[i].SetValue(Button.CommandParameterProperty, i);
            }
        }
        {
            // Basic setup only
            for (int i = 0; i < _questionButtons.Count; i++)
            {
                _questionButtons[i].AutomationId = $"Question{i + 1}";
            }
        }
        private void OnQuestionClicked(object sender, EventArgs e)
        {
            if (sender is Button button && button.CommandParameter is int index)
            {
                ToggleQuestion(index);
            }
        }
        private void ToggleQuestion(int index)
        {
            if (_expandedItems.Contains(index))
            {
                _expandedItems.Remove(index);
            }
            else
            {
                _expandedItems.Add(index);
            }
            // Update UI
            UpdateAccordionItem(index);
        }
        private void UpdateAccordionItem(int index)
        {
            bool isExpanded = _expandedItems.Contains(index);
            {
            }
            // Update button text with indicator
            if (index < _questionButtons.Count)
            {
                string baseText = GetQuestionText(index);
                _questionButtons[index].Text = isExpanded ? $"{baseText} ▲" : $"{baseText} ▼";
            }
        }
        private string GetQuestionText(int index)
        {
            return index switch
            {
                2 => "What are the WCAG guidelines?",
                _ => "Unknown question"
            };
        }
        // Should implement methods to:
        // 1. Get all accordion items
        // 4. Handle programmatic expansion/collapse
    }
}

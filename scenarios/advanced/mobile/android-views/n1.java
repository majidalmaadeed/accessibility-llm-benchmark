package com.example.UIComponents;

import android.app.AlertDialog;
import android.content.Context;
import android.graphics.Color;
import android.graphics.Typeface;
import android.os.Bundle;
import android.text.format.DateFormat;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.*;
import androidx.appcompat.app.AppCompatActivity;
import androidx.recyclerview.widget.GridLayoutManager;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;
import java.text.SimpleDateFormat;
import java.util.*;

public class CalendarApplication extends AppCompatActivity {
    
    private RecyclerView calendarRecyclerView;
    private RecyclerView weekRecyclerView;
    private RecyclerView dayRecyclerView;
    private TextView dateLabel;
    private Button previousButton;
    private Button nextButton;
    private Spinner viewModeSpinner;
    private Button createEventButton;
    private ProgressBar loadingIndicator;
    
    private List<Event> events = new ArrayList<>();
    private Calendar currentDate = Calendar.getInstance();
    private Calendar selectedDate = Calendar.getInstance();
    private String currentViewMode = "month";
    private boolean isLoading = false;
    
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_calendar);
        
        initializeViews();
        setupViewModeSpinner();
        loadEvents();
        updateCalendar();
    }
    
    private void initializeViews() {
        calendarRecyclerView = findViewById(R.id.calendarRecyclerView);
        weekRecyclerView = findViewById(R.id.weekRecyclerView);
        dayRecyclerView = findViewById(R.id.dayRecyclerView);
        dateLabel = findViewById(R.id.dateLabel);
        previousButton = findViewById(R.id.previousButton);
        nextButton = findViewById(R.id.nextButton);
        viewModeSpinner = findViewById(R.id.viewModeSpinner);
        createEventButton = findViewById(R.id.createEventButton);
        loadingIndicator = findViewById(R.id.loadingIndicator);
        
        // Setup RecyclerViews
        calendarRecyclerView.setLayoutManager(new GridLayoutManager(this, 7));
        weekRecyclerView.setLayoutManager(new LinearLayoutManager(this, LinearLayoutManager.HORIZONTAL, false));
        dayRecyclerView.setLayoutManager(new LinearLayoutManager(this));
        
        // Setup click listeners
        previousButton.setOnClickListener(v -> navigatePrevious());
        nextButton.setOnClickListener(v -> navigateNext());
        createEventButton.setOnClickListener(v -> showCreateEventDialog());
        
        updateDateLabel();
    }
    
    private void setupViewModeSpinner() {
        String[] viewModes = {"Month", "Week", "Day"};
        ArrayAdapter<String> adapter = new ArrayAdapter<>(this, android.R.layout.simple_spinner_item, viewModes);
        adapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
        viewModeSpinner.setAdapter(adapter);
        
        viewModeSpinner.setOnItemSelectedListener(new AdapterView.OnItemSelectedListener() {
            @Override
            public void onItemSelected(AdapterView<?> parent, View view, int position, long id) {
                currentViewMode = viewModes[position].toLowerCase();
                updateCalendar();
            }
            
            @Override
            public void onNothingSelected(AdapterView<?> parent) {}
        });
    }
    
    private void loadEvents() {
        isLoading = true;
        loadingIndicator.setVisibility(View.VISIBLE);
        
        // Simulate API call
        new android.os.Handler().postDelayed(() -> {
            events = generateSampleEvents();
            isLoading = false;
            loadingIndicator.setVisibility(View.GONE);
            updateCalendar();
        }, 1000);
    }
    
    private List<Event> generateSampleEvents() {
        List<Event> sampleEvents = new ArrayList<>();
        
        Calendar event1 = Calendar.getInstance();
        event1.add(Calendar.DAY_OF_MONTH, 1);
        event1.set(Calendar.HOUR_OF_DAY, 10);
        event1.set(Calendar.MINUTE, 0);
        
        sampleEvents.add(new Event(
            "1",
            "Team Meeting",
            "Weekly team standup",
            event1.getTime(),
            event1.getTime(),
            "work",
            false,
            "Conference Room A",
            Arrays.asList("john@example.com", "jane@example.com"),
            "weekly",
            Arrays.asList("15min", "1hour")
        ));
        
        Calendar event2 = Calendar.getInstance();
        event2.add(Calendar.DAY_OF_MONTH, 2);
        event2.set(Calendar.HOUR_OF_DAY, 14);
        event2.set(Calendar.MINUTE, 30);
        
        sampleEvents.add(new Event(
            "2",
            "Doctor Appointment",
            "Annual checkup",
            event2.getTime(),
            event2.getTime(),
            "appointment",
            false,
            "Medical Center",
            new ArrayList<>(),
            "none",
            Arrays.asList("1day", "2hours")
        ));
        
        Calendar event3 = Calendar.getInstance();
        event3.add(Calendar.DAY_OF_MONTH, 5);
        event3.set(Calendar.HOUR_OF_DAY, 17);
        event3.set(Calendar.MINUTE, 0);
        
        sampleEvents.add(new Event(
            "3",
            "Project Deadline",
            "Submit final report",
            event3.getTime(),
            event3.getTime(),
            "work",
            true,
            "",
            new ArrayList<>(),
            "none",
            Arrays.asList("1week", "1day")
        ));
        
        return sampleEvents;
    }
    
    private void updateCalendar() {
        switch (currentViewMode) {
            case "month":
                updateMonthView();
                break;
            case "week":
                updateWeekView();
                break;
            case "day":
                updateDayView();
                break;
        }
    }
    
    private void updateMonthView() {
        List<CalendarDay> calendarDays = generateCalendarDays();
        CalendarAdapter adapter = new CalendarAdapter(calendarDays, this::onDayClicked);
        calendarRecyclerView.setAdapter(adapter);
        
        calendarRecyclerView.setVisibility(View.VISIBLE);
        weekRecyclerView.setVisibility(View.GONE);
        dayRecyclerView.setVisibility(View.GONE);
    }
    
    private void updateWeekView() {
        List<CalendarDay> weekDays = generateWeekDays();
        WeekAdapter adapter = new WeekAdapter(weekDays, this::onDayClicked);
        weekRecyclerView.setAdapter(adapter);
        
        calendarRecyclerView.setVisibility(View.GONE);
        weekRecyclerView.setVisibility(View.VISIBLE);
        dayRecyclerView.setVisibility(View.GONE);
    }
    
    private void updateDayView() {
        List<Event> dayEvents = getEventsForDate(currentDate);
        DayAdapter adapter = new DayAdapter(dayEvents, this::onEventClicked);
        dayRecyclerView.setAdapter(adapter);
        
        calendarRecyclerView.setVisibility(View.GONE);
        weekRecyclerView.setVisibility(View.GONE);
        dayRecyclerView.setVisibility(View.VISIBLE);
    }
    
    private List<CalendarDay> generateCalendarDays() {
        List<CalendarDay> days = new ArrayList<>();
        Calendar firstDay = Calendar.getInstance();
        firstDay.setTime(currentDate.getTime());
        firstDay.set(Calendar.DAY_OF_MONTH, 1);
        
        int startingDayOfWeek = firstDay.get(Calendar.DAY_OF_WEEK) - 1;
        
        // Add empty cells for days before the first day of the month
        for (int i = 0; i < startingDayOfWeek; i++) {
            days.add(new CalendarDay(null, 0, false, true, false, new ArrayList<>()));
        }
        
        // Add days of the month
        int daysInMonth = firstDay.getActualMaximum(Calendar.DAY_OF_MONTH);
        for (int day = 1; day <= daysInMonth; day++) {
            Calendar date = Calendar.getInstance();
            date.setTime(firstDay.getTime());
            date.set(Calendar.DAY_OF_MONTH, day);
            
            List<Event> dayEvents = getEventsForDate(date);
            boolean isToday = isSameDay(date, Calendar.getInstance());
            boolean isSelected = isSameDay(date, selectedDate);
            
            days.add(new CalendarDay(
                date.getTime(),
                day,
                isToday,
                isSelected,
                !dayEvents.isEmpty(),
                dayEvents
            ));
        }
        
        return days;
    }
    
    private List<CalendarDay> generateWeekDays() {
        List<CalendarDay> days = new ArrayList<>();
        Calendar startOfWeek = Calendar.getInstance();
        startOfWeek.setTime(currentDate.getTime());
        startOfWeek.set(Calendar.DAY_OF_WEEK, Calendar.SUNDAY);
        
        for (int i = 0; i < 7; i++) {
            Calendar date = Calendar.getInstance();
            date.setTime(startOfWeek.getTime());
            date.add(Calendar.DAY_OF_MONTH, i);
            
            List<Event> dayEvents = getEventsForDate(date);
            boolean isToday = isSameDay(date, Calendar.getInstance());
            boolean isSelected = isSameDay(date, selectedDate);
            
            days.add(new CalendarDay(
                date.getTime(),
                date.get(Calendar.DAY_OF_MONTH),
                isToday,
                isSelected,
                !dayEvents.isEmpty(),
                dayEvents
            ));
        }
        
        return days;
    }
    
    private List<Event> getEventsForDate(Calendar date) {
        List<Event> dayEvents = new ArrayList<>();
        for (Event event : events) {
            Calendar eventDate = Calendar.getInstance();
            eventDate.setTime(event.getStartTime());
            if (isSameDay(eventDate, date)) {
                dayEvents.add(event);
            }
        }
        return dayEvents;
    }
    
    private boolean isSameDay(Calendar cal1, Calendar cal2) {
        return cal1.get(Calendar.YEAR) == cal2.get(Calendar.YEAR) &&
               cal1.get(Calendar.DAY_OF_YEAR) == cal2.get(Calendar.DAY_OF_YEAR);
    }
    
    private void navigatePrevious() {
        switch (currentViewMode) {
            case "month":
                currentDate.add(Calendar.MONTH, -1);
                break;
            case "week":
                currentDate.add(Calendar.WEEK_OF_YEAR, -1);
                break;
            case "day":
                currentDate.add(Calendar.DAY_OF_MONTH, -1);
                break;
        }
        updateDateLabel();
        updateCalendar();
    }
    
    private void navigateNext() {
        switch (currentViewMode) {
            case "month":
                currentDate.add(Calendar.MONTH, 1);
                break;
            case "week":
                currentDate.add(Calendar.WEEK_OF_YEAR, 1);
                break;
            case "day":
                currentDate.add(Calendar.DAY_OF_MONTH, 1);
                break;
        }
        updateDateLabel();
        updateCalendar();
    }
    
    private void updateDateLabel() {
        SimpleDateFormat formatter = new SimpleDateFormat("MMMM yyyy", Locale.getDefault());
        dateLabel.setText(formatter.format(currentDate.getTime()));
    }
    
    private void onDayClicked(CalendarDay day) {
        if (day.isEmpty()) return;
        
        selectedDate.setTime(day.getDate());
        
        if (!day.getEvents().isEmpty()) {
            showEventDetails(day.getEvents().get(0));
        } else {
            showCreateEventDialog();
        }
        
        updateCalendar();
    }
    
    private void onEventClicked(Event event) {
        showEventDetails(event);
    }
    
    private void showCreateEventDialog() {
        AlertDialog.Builder builder = new AlertDialog.Builder(this);
        builder.setTitle("New Event");
        
        View dialogView = LayoutInflater.from(this).inflate(R.layout.dialog_create_event, null);
        
        EditText titleEditText = dialogView.findViewById(R.id.titleEditText);
        EditText descriptionEditText = dialogView.findViewById(R.id.descriptionEditText);
        DatePicker startDatePicker = dialogView.findViewById(R.id.startDatePicker);
        TimePicker startTimePicker = dialogView.findViewById(R.id.startTimePicker);
        DatePicker endDatePicker = dialogView.findViewById(R.id.endDatePicker);
        TimePicker endTimePicker = dialogView.findViewById(R.id.endTimePicker);
        Spinner categorySpinner = dialogView.findViewById(R.id.categorySpinner);
        EditText locationEditText = dialogView.findViewById(R.id.locationEditText);
        CheckBox allDayCheckBox = dialogView.findViewById(R.id.allDayCheckBox);
        
        // Setup category spinner
        String[] categories = {"personal", "work", "meeting", "appointment", "reminder"};
        ArrayAdapter<String> categoryAdapter = new ArrayAdapter<>(this, android.R.layout.simple_spinner_item, categories);
        categoryAdapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
        categorySpinner.setAdapter(categoryAdapter);
        
        // Set default values
        Calendar now = Calendar.getInstance();
        startDatePicker.init(now.get(Calendar.YEAR), now.get(Calendar.MONTH), now.get(Calendar.DAY_OF_MONTH), null);
        startTimePicker.setCurrentHour(now.get(Calendar.HOUR_OF_DAY));
        startTimePicker.setCurrentMinute(now.get(Calendar.MINUTE));
        endDatePicker.init(now.get(Calendar.YEAR), now.get(Calendar.MONTH), now.get(Calendar.DAY_OF_MONTH), null);
        endTimePicker.setCurrentHour(now.get(Calendar.HOUR_OF_DAY) + 1);
        endTimePicker.setCurrentMinute(now.get(Calendar.MINUTE));
        
        builder.setView(dialogView);
        builder.setPositiveButton("Save", (dialog, which) -> {
            String title = titleEditText.getText().toString();
            if (title.isEmpty()) return;
            
            Calendar startTime = Calendar.getInstance();
            startTime.set(startDatePicker.getYear(), startDatePicker.getMonth(), startDatePicker.getDayOfMonth(),
                         startTimePicker.getCurrentHour(), startTimePicker.getCurrentMinute());
            
            Calendar endTime = Calendar.getInstance();
            endTime.set(endDatePicker.getYear(), endDatePicker.getMonth(), endDatePicker.getDayOfMonth(),
                       endTimePicker.getCurrentHour(), endTimePicker.getCurrentMinute());
            
            Event newEvent = new Event(
                UUID.randomUUID().toString(),
                title,
                descriptionEditText.getText().toString(),
                startTime.getTime(),
                endTime.getTime(),
                categories[categorySpinner.getSelectedItemPosition()],
                allDayCheckBox.isChecked(),
                locationEditText.getText().toString(),
                new ArrayList<>(),
                "none",
                new ArrayList<>()
            );
            
            events.add(newEvent);
            updateCalendar();
        });
        builder.setNegativeButton("Cancel", null);
        builder.show();
    }
    
    private void showEventDetails(Event event) {
        AlertDialog.Builder builder = new AlertDialog.Builder(this);
        builder.setTitle(event.getTitle());
        
        StringBuilder message = new StringBuilder();
        message.append(event.getDescription()).append("\n\n");
        message.append("Time: ").append(DateFormat.format("MMM dd, yyyy hh:mm a", event.getStartTime()));
        if (!event.isAllDay()) {
            message.append(" - ").append(DateFormat.format("hh:mm a", event.getEndTime()));
        }
        message.append("\n");
        if (!event.getLocation().isEmpty()) {
            message.append("Location: ").append(event.getLocation()).append("\n");
        }
        message.append("Category: ").append(event.getCategory()).append("\n");
        message.append("Recurring: ").append(event.getRecurring());
        
        builder.setMessage(message.toString());
        builder.setPositiveButton("Close", null);
        builder.setNegativeButton("Delete", (dialog, which) -> {
            events.remove(event);
            updateCalendar();
        });
        builder.show();
    }
    
    // Calendar Adapter
    private static class CalendarAdapter extends RecyclerView.Adapter<CalendarAdapter.ViewHolder> {
        private List<CalendarDay> days;
        private OnDayClickListener listener;
        
        public interface OnDayClickListener {
            void onDayClick(CalendarDay day);
        }
        
        public CalendarAdapter(List<CalendarDay> days, OnDayClickListener listener) {
            this.days = days;
            this.listener = listener;
        }
        
        @Override
        public ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
            View view = LayoutInflater.from(parent.getContext()).inflate(R.layout.item_calendar_day, parent, false);
            return new ViewHolder(view);
        }
        
        @Override
        public void onBindViewHolder(ViewHolder holder, int position) {
            CalendarDay day = days.get(position);
            holder.bind(day, listener);
        }
        
        @Override
        public int getItemCount() {
            return days.size();
        }
        
        static class ViewHolder extends RecyclerView.ViewHolder {
            private TextView dayNumber;
            private LinearLayout eventIndicators;
            
            public ViewHolder(View itemView) {
                super(itemView);
                dayNumber = itemView.findViewById(R.id.dayNumber);
                eventIndicators = itemView.findViewById(R.id.eventIndicators);
            }
            
            public void bind(CalendarDay day, OnDayClickListener listener) {
                if (day.isEmpty()) {
                    dayNumber.setText("");
                    eventIndicators.setVisibility(View.GONE);
                    itemView.setBackgroundColor(Color.LTGRAY);
                } else {
                    dayNumber.setText(String.valueOf(day.getDayNumber()));
                    eventIndicators.setVisibility(day.hasEvents() ? View.VISIBLE : View.GONE);
                    
                    if (day.isToday()) {
                        dayNumber.setTypeface(null, Typeface.BOLD);
                        dayNumber.setTextColor(Color.BLUE);
                        itemView.setBackgroundColor(Color.parseColor("#E3F2FD"));
                    } else if (day.isSelected()) {
                        dayNumber.setTypeface(null, Typeface.BOLD);
                        dayNumber.setTextColor(Color.WHITE);
                        itemView.setBackgroundColor(Color.BLUE);
                    } else {
                        dayNumber.setTypeface(null, Typeface.NORMAL);
                        dayNumber.setTextColor(Color.BLACK);
                        itemView.setBackgroundColor(Color.WHITE);
                    }
                    
                    // Add event indicators
                    eventIndicators.removeAllViews();
                    if (day.hasEvents()) {
                        for (int i = 0; i < Math.min(day.getEvents().size(), 3); i++) {
                            View indicator = new View(itemView.getContext());
                            indicator.setLayoutParams(new LinearLayout.LayoutParams(12, 12));
                            indicator.setBackgroundColor(getCategoryColor(day.getEvents().get(i).getCategory()));
                            eventIndicators.addView(indicator);
                        }
                    }
                }
                
                itemView.setOnClickListener(v -> listener.onDayClick(day));
            }
            
            private int getCategoryColor(String category) {
                switch (category) {
                    case "personal": return Color.GREEN;
                    case "work": return Color.BLUE;
                    case "meeting": return Color.parseColor("#FF9800");
                    case "appointment": return Color.parseColor("#9C27B0");
                    case "reminder": return Color.RED;
                    default: return Color.BLUE;
                }
            }
        }
    }
    
    // Week Adapter
    private static class WeekAdapter extends RecyclerView.Adapter<WeekAdapter.ViewHolder> {
        private List<CalendarDay> days;
        private OnDayClickListener listener;
        
        public WeekAdapter(List<CalendarDay> days, OnDayClickListener listener) {
            this.days = days;
            this.listener = listener;
        }
        
        @Override
        public ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
            View view = LayoutInflater.from(parent.getContext()).inflate(R.layout.item_week_day, parent, false);
            return new ViewHolder(view);
        }
        
        @Override
        public void onBindViewHolder(ViewHolder holder, int position) {
            CalendarDay day = days.get(position);
            holder.bind(day, listener);
        }
        
        @Override
        public int getItemCount() {
            return days.size();
        }
        
        static class ViewHolder extends RecyclerView.ViewHolder {
            private TextView dayName;
            private TextView dayNumber;
            private LinearLayout eventIndicators;
            
            public ViewHolder(View itemView) {
                super(itemView);
                dayName = itemView.findViewById(R.id.dayName);
                dayNumber = itemView.findViewById(R.id.dayNumber);
                eventIndicators = itemView.findViewById(R.id.eventIndicators);
            }
            
            public void bind(CalendarDay day, OnDayClickListener listener) {
                SimpleDateFormat dayFormat = new SimpleDateFormat("E", Locale.getDefault());
                dayName.setText(dayFormat.format(day.getDate()));
                dayNumber.setText(String.valueOf(day.getDayNumber()));
                
                if (day.isToday()) {
                    dayNumber.setTypeface(null, Typeface.BOLD);
                    dayNumber.setTextColor(Color.BLUE);
                } else if (day.isSelected()) {
                    dayNumber.setTypeface(null, Typeface.BOLD);
                    dayNumber.setTextColor(Color.WHITE);
                    itemView.setBackgroundColor(Color.BLUE);
                } else {
                    dayNumber.setTypeface(null, Typeface.NORMAL);
                    dayNumber.setTextColor(Color.BLACK);
                    itemView.setBackgroundColor(Color.WHITE);
                }
                
                eventIndicators.setVisibility(day.hasEvents() ? View.VISIBLE : View.GONE);
                eventIndicators.removeAllViews();
                if (day.hasEvents()) {
                    for (int i = 0; i < Math.min(day.getEvents().size(), 2); i++) {
                        View indicator = new View(itemView.getContext());
                        indicator.setLayoutParams(new LinearLayout.LayoutParams(8, 8));
                        indicator.setBackgroundColor(getCategoryColor(day.getEvents().get(i).getCategory()));
                        eventIndicators.addView(indicator);
                    }
                }
                
                itemView.setOnClickListener(v -> listener.onDayClick(day));
            }
            
            private int getCategoryColor(String category) {
                switch (category) {
                    case "personal": return Color.GREEN;
                    case "work": return Color.BLUE;
                    case "meeting": return Color.parseColor("#FF9800");
                    case "appointment": return Color.parseColor("#9C27B0");
                    case "reminder": return Color.RED;
                    default: return Color.BLUE;
                }
            }
        }
    }
    
    // Day Adapter
    private static class DayAdapter extends RecyclerView.Adapter<DayAdapter.ViewHolder> {
        private List<Event> events;
        private OnEventClickListener listener;
        
        public interface OnEventClickListener {
            void onEventClick(Event event);
        }
        
        public DayAdapter(List<Event> events, OnEventClickListener listener) {
            this.events = events;
            this.listener = listener;
        }
        
        @Override
        public ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
            View view = LayoutInflater.from(parent.getContext()).inflate(R.layout.item_event, parent, false);
            return new ViewHolder(view);
        }
        
        @Override
        public void onBindViewHolder(ViewHolder holder, int position) {
            Event event = events.get(position);
            holder.bind(event, listener);
        }
        
        @Override
        public int getItemCount() {
            return events.size();
        }
        
        static class ViewHolder extends RecyclerView.ViewHolder {
            private View colorBar;
            private TextView titleText;
            private TextView timeText;
            private TextView locationText;
            
            public ViewHolder(View itemView) {
                super(itemView);
                colorBar = itemView.findViewById(R.id.colorBar);
                titleText = itemView.findViewById(R.id.titleText);
                timeText = itemView.findViewById(R.id.timeText);
                locationText = itemView.findViewById(R.id.locationText);
            }
            
            public void bind(Event event, OnEventClickListener listener) {
                titleText.setText(event.getTitle());
                timeText.setText(event.isAllDay() ? "All Day" : 
                    DateFormat.format("hh:mm a", event.getStartTime()) + " - " + 
                    DateFormat.format("hh:mm a", event.getEndTime()));
                locationText.setText(event.getLocation().isEmpty() ? "" : event.getLocation());
                colorBar.setBackgroundColor(getCategoryColor(event.getCategory()));
                
                itemView.setOnClickListener(v -> listener.onEventClick(event));
            }
            
            private int getCategoryColor(String category) {
                switch (category) {
                    case "personal": return Color.GREEN;
                    case "work": return Color.BLUE;
                    case "meeting": return Color.parseColor("#FF9800");
                    case "appointment": return Color.parseColor("#9C27B0");
                    case "reminder": return Color.RED;
                    default: return Color.BLUE;
                }
            }
        }
    }
    
    // Data classes
    public static class CalendarDay {
        private Date date;
        private int dayNumber;
        private boolean isToday;
        private boolean isSelected;
        private boolean isEmpty;
        private boolean hasEvents;
        private List<Event> events;
        
        public CalendarDay(Date date, int dayNumber, boolean isToday, boolean isSelected, boolean isEmpty, boolean hasEvents, List<Event> events) {
            this.date = date;
            this.dayNumber = dayNumber;
            this.isToday = isToday;
            this.isSelected = isSelected;
            this.isEmpty = isEmpty;
            this.hasEvents = hasEvents;
            this.events = events;
        }
        
        // Getters and setters
        public Date getDate() { return date; }
        public int getDayNumber() { return dayNumber; }
        public boolean isToday() { return isToday; }
        public boolean isSelected() { return isSelected; }
        public boolean isEmpty() { return isEmpty; }
        public boolean hasEvents() { return hasEvents; }
        public List<Event> getEvents() { return events; }
    }
    
    public static class Event {
        private String id;
        private String title;
        private String description;
        private Date startTime;
        private Date endTime;
        private String category;
        private boolean isAllDay;
        private String location;
        private List<String> attendees;
        private String recurring;
        private List<String> reminders;
        
        public Event(String id, String title, String description, Date startTime, Date endTime, String category, boolean isAllDay, String location, List<String> attendees, String recurring, List<String> reminders) {
            this.id = id;
            this.title = title;
            this.description = description;
            this.startTime = startTime;
            this.endTime = endTime;
            this.category = category;
            this.isAllDay = isAllDay;
            this.location = location;
            this.attendees = attendees;
            this.recurring = recurring;
            this.reminders = reminders;
        }
        
        // Getters and setters
        public String getId() { return id; }
        public String getTitle() { return title; }
        public String getDescription() { return description; }
        public Date getStartTime() { return startTime; }
        public Date getEndTime() { return endTime; }
        public String getCategory() { return category; }
        public boolean isAllDay() { return isAllDay; }
        public String getLocation() { return location; }
        public List<String> getAttendees() { return attendees; }
        public String getRecurring() { return recurring; }
        public List<String> getReminders() { return reminders; }
    }
}

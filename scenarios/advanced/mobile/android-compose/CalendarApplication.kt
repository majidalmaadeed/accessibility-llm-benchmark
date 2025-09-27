package com.example.accessibilitybenchmark

import androidx.compose.foundation.background
import androidx.compose.foundation.border
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.LazyRow
import androidx.compose.foundation.lazy.grid.GridCells
import androidx.compose.foundation.lazy.grid.LazyVerticalGrid
import androidx.compose.foundation.lazy.grid.items
import androidx.compose.foundation.lazy.items
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.*
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import java.time.LocalDate
import java.time.format.DateTimeFormatter
import java.util.*

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun CalendarApplication() {
    var currentDate by remember { mutableStateOf(LocalDate.now()) }
    var selectedDate by remember { mutableStateOf(LocalDate.now()) }
    var viewMode by remember { mutableStateOf(ViewMode.MONTH) }
    var events by remember { mutableStateOf(generateSampleEvents()) }
    var isLoading by remember { mutableStateOf(false) }
    var showEventModal by remember { mutableStateOf(false) }
    var showEventDetails by remember { mutableStateOf(false) }
    var selectedEvent by remember { mutableStateOf<Event?>(null) }
    var newEvent by remember { mutableStateOf(Event()) }

    Scaffold(
        topBar = {
            TopAppBar(
                title = { Text("Calendar") },
                actions = {
                    TextButton(onClick = { 
                        currentDate = LocalDate.now()
                        selectedDate = LocalDate.now()
                    }) {
                        Text("Today")
                    }
                    IconButton(onClick = { showEventModal = true }) {
                        Icon(Icons.Default.Add, contentDescription = null)
                    }
                }
            )
        }
    ) { paddingValues ->
        Column(
            modifier = Modifier
                .fillMaxSize()
                .padding(paddingValues)
        ) {
            // View Mode Selector
            Row(
                modifier = Modifier
                    .fillMaxWidth()
                    .padding(16.dp),
                horizontalArrangement = Arrangement.Center
            ) {
                ViewMode.values().forEach { mode ->
                    FilterChip(
                        onClick = { viewMode = mode },
                        label = { Text(mode.name) },
                        selected = viewMode == mode,
                        modifier = Modifier.padding(horizontal = 4.dp)
                    )
                }
            }

            // Navigation
            Row(
                modifier = Modifier
                    .fillMaxWidth()
                    .padding(horizontal = 16.dp),
                horizontalArrangement = Arrangement.SpaceBetween,
                verticalAlignment = Alignment.CenterVertically
            ) {
                IconButton(onClick = { 
                    currentDate = when (viewMode) {
                        ViewMode.MONTH -> currentDate.minusMonths(1)
                        ViewMode.WEEK -> currentDate.minusWeeks(1)
                        ViewMode.DAY -> currentDate.minusDays(1)
                    }
                }) {
                    Icon(Icons.Default.ChevronLeft, contentDescription = null)
                }

                Text(
                    text = currentDate.format(DateTimeFormatter.ofPattern("MMMM yyyy")),
                    style = MaterialTheme.typography.headlineSmall,
                    fontWeight = FontWeight.SemiBold
                )

                IconButton(onClick = { 
                    currentDate = when (viewMode) {
                        ViewMode.MONTH -> currentDate.plusMonths(1)
                        ViewMode.WEEK -> currentDate.plusWeeks(1)
                        ViewMode.DAY -> currentDate.plusDays(1)
                    }
                }) {
                    Icon(Icons.Default.ChevronRight, contentDescription = null)
                }
            }

            // Calendar Content
            when (viewMode) {
                ViewMode.MONTH -> MonthView(
                    currentDate = currentDate,
                    selectedDate = selectedDate,
                    events = events,
                    onDateClick = { date ->
                        selectedDate = date
                        val dayEvents = getEventsForDate(date, events)
                        if (dayEvents.isNotEmpty()) {
                            selectedEvent = dayEvents.first()
                            showEventDetails = true
                        } else {
                            newEvent = Event().copy(startTime = date)
                            showEventModal = true
                        }
                    }
                )
                ViewMode.WEEK -> WeekView(
                    currentDate = currentDate,
                    selectedDate = selectedDate,
                    events = events,
                    onDateClick = { date ->
                        selectedDate = date
                        val dayEvents = getEventsForDate(date, events)
                        if (dayEvents.isNotEmpty()) {
                            selectedEvent = dayEvents.first()
                            showEventDetails = true
                        } else {
                            newEvent = Event().copy(startTime = date)
                            showEventModal = true
                        }
                    }
                )
                ViewMode.DAY -> DayView(
                    currentDate = currentDate,
                    events = events,
                    onEventClick = { event ->
                        selectedEvent = event
                        showEventDetails = true
                    }
                )
            }
        }
    }

    // Event Modal
    if (showEventModal) {
        EventModal(
            event = newEvent,
            onDismiss = { showEventModal = false },
            onSave = { event ->
                events = events + event
                showEventModal = false
            }
        )
    }

    // Event Details
    if (showEventDetails && selectedEvent != null) {
        EventDetails(
            event = selectedEvent!!,
            onDismiss = { showEventDetails = false },
            onDelete = { event ->
                events = events.filter { it.id != event.id }
                showEventDetails = false
            }
        )
    }
}

@Composable
fun MonthView(
    currentDate: LocalDate,
    selectedDate: LocalDate,
    events: List<Event>,
    onDateClick: (LocalDate) -> Unit
) {
    val calendarDays = remember(currentDate) {
        generateCalendarDays(currentDate, events)
    }

    Card(
        modifier = Modifier
            .fillMaxWidth()
            .padding(16.dp),
        elevation = CardDefaults.cardElevation(defaultElevation = 4.dp)
    ) {
        Column {
            // Week days header
            Row(
                modifier = Modifier
                    .fillMaxWidth()
                    .background(MaterialTheme.colorScheme.surfaceVariant)
            ) {
                listOf("Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat").forEach { day ->
                    Text(
                        text = day,
                        modifier = Modifier
                            .weight(1f)
                            .padding(8.dp),
                        style = MaterialTheme.typography.labelMedium,
                        fontWeight = FontWeight.SemiBold,
                        textAlign = TextAlign.Center
                    )
                }
            }

            // Calendar grid
            LazyVerticalGrid(
                columns = GridCells.Fixed(7),
                modifier = Modifier.height(400.dp)
            ) {
                items(calendarDays) { day ->
                    DayCell(
                        day = day,
                        isSelected = day.date == selectedDate,
                        onClick = { onDateClick(day.date) }
                    )
                }
            }
        }
    }
}

@Composable
fun WeekView(
    currentDate: LocalDate,
    selectedDate: LocalDate,
    events: List<Event>,
    onDateClick: (LocalDate) -> Unit
) {
    val weekDays = remember(currentDate) {
        generateWeekDays(currentDate, events)
    }

    Card(
        modifier = Modifier
            .fillMaxWidth()
            .padding(16.dp),
        elevation = CardDefaults.cardElevation(defaultElevation = 4.dp)
    ) {
        LazyRow(
            modifier = Modifier.fillMaxWidth(),
            horizontalArrangement = Arrangement.spacedBy(8.dp),
            contentPadding = PaddingValues(16.dp)
        ) {
            items(weekDays) { day ->
                WeekDayCell(
                    day = day,
                    isSelected = day.date == selectedDate,
                    onClick = { onDateClick(day.date) }
                )
            }
        }
    }
}

@Composable
fun DayView(
    currentDate: LocalDate,
    events: List<Event>,
    onEventClick: (Event) -> Unit
) {
    val dayEvents = remember(currentDate, events) {
        getEventsForDate(currentDate, events)
    }

    Column(
        modifier = Modifier
            .fillMaxSize()
            .padding(16.dp)
    ) {
        // Day header
        Card(
            modifier = Modifier.fillMaxWidth(),
            elevation = CardDefaults.cardElevation(defaultElevation = 4.dp)
        ) {
            Column(
                modifier = Modifier.padding(16.dp)
            ) {
                Text(
                    text = "${currentDate.dayOfMonth}",
                    style = MaterialTheme.typography.displayLarge,
                    fontWeight = FontWeight.Bold
                )
                Text(
                    text = currentDate.format(DateTimeFormatter.ofPattern("MMMM")),
                    style = MaterialTheme.typography.headlineMedium,
                    color = MaterialTheme.colorScheme.onSurfaceVariant
                )
                Text(
                    text = "${currentDate.year}",
                    style = MaterialTheme.typography.titleLarge,
                    color = MaterialTheme.colorScheme.onSurfaceVariant
                )
            }
        }

        Spacer(modifier = Modifier.height(16.dp))

        // Events list
        if (dayEvents.isEmpty()) {
            Box(
                modifier = Modifier.fillMaxSize(),
                contentAlignment = Alignment.Center
            ) {
                Column(
                    horizontalAlignment = Alignment.CenterHorizontally
                ) {
                    Icon(
                        Icons.Default.Event,
                        contentDescription = null,
                        modifier = Modifier.size(48.dp),
                        tint = MaterialTheme.colorScheme.onSurfaceVariant
                    )
                    Spacer(modifier = Modifier.height(16.dp))
                    Text(
                        text = "No events for this day",
                        style = MaterialTheme.typography.headlineSmall,
                        color = MaterialTheme.colorScheme.onSurfaceVariant
                    )
                }
            }
        } else {
            LazyColumn(
                verticalArrangement = Arrangement.spacedBy(8.dp)
            ) {
                items(dayEvents) { event ->
                    EventCard(
                        event = event,
                        onClick = { onEventClick(event) }
                    )
                }
            }
        }
    }
}

@Composable
fun DayCell(
    day: CalendarDay,
    isSelected: Boolean,
    onClick: () -> Unit
) {
    Box(
        modifier = Modifier
            .aspectRatio(1f)
            .padding(2.dp)
            .background(
                when {
                    isSelected -> MaterialTheme.colorScheme.primary
                    day.isToday -> MaterialTheme.colorScheme.primary.copy(alpha = 0.1f)
                    else -> Color.Transparent
                },
                RoundedCornerShape(4.dp)
            )
            .clickable { onClick() },
        contentAlignment = Alignment.Center
    ) {
        Column(
            horizontalAlignment = Alignment.CenterHorizontally
        ) {
            Text(
                text = if (day.isEmpty) "" else "${day.dayNumber}",
                style = MaterialTheme.typography.bodyMedium,
                fontWeight = if (day.isToday) FontWeight.Bold else FontWeight.Normal,
                color = when {
                    isSelected -> MaterialTheme.colorScheme.onPrimary
                    day.isToday -> MaterialTheme.colorScheme.primary
                    else -> MaterialTheme.colorScheme.onSurface
                }
            )
            
            if (day.hasEvents) {
                Row(
                    horizontalArrangement = Arrangement.spacedBy(2.dp)
                ) {
                    day.events.take(3).forEach { event ->
                        Box(
                            modifier = Modifier
                                .size(6.dp)
                                .background(
                                    getCategoryColor(event.category),
                                    CircleShape
                                )
                        )
                    }
                    if (day.events.size > 3) {
                        Text(
                            text = "+${day.events.size - 3}",
                            style = MaterialTheme.typography.labelSmall,
                            color = MaterialTheme.colorScheme.onSurfaceVariant
                        )
                    }
                }
            }
        }
    }
}

@Composable
fun WeekDayCell(
    day: CalendarDay,
    isSelected: Boolean,
    onClick: () -> Unit
) {
    Card(
        modifier = Modifier
            .width(80.dp)
            .height(100.dp)
            .clickable { onClick() },
        colors = CardDefaults.cardColors(
            containerColor = if (isSelected) MaterialTheme.colorScheme.primary else MaterialTheme.colorScheme.surface
        )
    ) {
        Column(
            modifier = Modifier
                .fillMaxSize()
                .padding(8.dp),
            horizontalAlignment = Alignment.CenterHorizontally
        ) {
            Text(
                text = day.date.format(DateTimeFormatter.ofPattern("E")),
                style = MaterialTheme.typography.labelSmall,
                fontWeight = FontWeight.SemiBold,
                color = if (isSelected) MaterialTheme.colorScheme.onPrimary else MaterialTheme.colorScheme.onSurfaceVariant
            )
            Text(
                text = "${day.dayNumber}",
                style = MaterialTheme.typography.bodyLarge,
                fontWeight = if (day.isToday) FontWeight.Bold else FontWeight.Normal,
                color = if (isSelected) MaterialTheme.colorScheme.onPrimary else MaterialTheme.colorScheme.onSurface
            )
            if (day.hasEvents) {
                Row(
                    horizontalArrangement = Arrangement.spacedBy(2.dp)
                ) {
                    day.events.take(2).forEach { event ->
                        Box(
                            modifier = Modifier
                                .size(4.dp)
                                .background(
                                    getCategoryColor(event.category),
                                    CircleShape
                                )
                        )
                    }
                }
            }
        }
    }
}

@Composable
fun EventCard(
    event: Event,
    onClick: () -> Unit
) {
    Card(
        modifier = Modifier
            .fillMaxWidth()
            .clickable { onClick() },
        elevation = CardDefaults.cardElevation(defaultElevation = 2.dp)
    ) {
        Row(
            modifier = Modifier
                .fillMaxWidth()
                .padding(16.dp)
        ) {
            Box(
                modifier = Modifier
                    .width(4.dp)
                    .fillMaxHeight()
                    .background(
                        getCategoryColor(event.category),
                        RoundedCornerShape(2.dp)
                    )
            )
            
            Spacer(modifier = Modifier.width(12.dp))
            
            Column(
                modifier = Modifier.weight(1f)
            ) {
                Text(
                    text = event.title,
                    style = MaterialTheme.typography.titleMedium,
                    fontWeight = FontWeight.SemiBold
                )
                Text(
                    text = if (event.isAllDay) "All Day" else "${event.startTime} - ${event.endTime}",
                    style = MaterialTheme.typography.bodySmall,
                    color = MaterialTheme.colorScheme.onSurfaceVariant
                )
                if (event.location.isNotEmpty()) {
                    Text(
                        text = event.location,
                        style = MaterialTheme.typography.bodySmall,
                        color = MaterialTheme.colorScheme.onSurfaceVariant
                    )
                }
            }
        }
    }
}

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun EventModal(
    event: Event,
    onDismiss: () -> Unit,
    onSave: (Event) -> Unit
) {
    var title by remember { mutableStateOf(event.title) }
    var description by remember { mutableStateOf(event.description) }
    var startTime by remember { mutableStateOf(event.startTime) }
    var endTime by remember { mutableStateOf(event.endTime) }
    var category by remember { mutableStateOf(event.category) }
    var location by remember { mutableStateOf(event.location) }

    AlertDialog(
        onDismissRequest = onDismiss,
        title = { Text("New Event") },
        text = {
            Column(
                verticalArrangement = Arrangement.spacedBy(16.dp)
            ) {
                OutlinedTextField(
                    value = title,
                    onValueChange = { title = it },
                    label = { Text("Title") },
                    modifier = Modifier.fillMaxWidth()
                )
                
                OutlinedTextField(
                    value = description,
                    onValueChange = { description = it },
                    label = { Text("Description") },
                    modifier = Modifier.fillMaxWidth(),
                    maxLines = 3
                )
                
                Row(
                    modifier = Modifier.fillMaxWidth(),
                    horizontalArrangement = Arrangement.spacedBy(8.dp)
                ) {
                    OutlinedTextField(
                        value = startTime.toString(),
                        onValueChange = { },
                        label = { Text("Start") },
                        modifier = Modifier.weight(1f),
                        readOnly = true
                    )
                    OutlinedTextField(
                        value = endTime.toString(),
                        onValueChange = { },
                        label = { Text("End") },
                        modifier = Modifier.weight(1f),
                        readOnly = true
                    )
                }
                
                LazyRow(
                    horizontalArrangement = Arrangement.spacedBy(8.dp)
                ) {
                    items(listOf("personal", "work", "meeting", "appointment", "reminder")) { cat ->
                        FilterChip(
                            onClick = { category = cat },
                            label = { Text(cat.capitalize()) },
                            selected = category == cat
                        )
                    }
                }
                
                OutlinedTextField(
                    value = location,
                    onValueChange = { location = it },
                    label = { Text("Location") },
                    modifier = Modifier.fillMaxWidth()
                )
            }
        },
        confirmButton = {
            TextButton(
                onClick = {
                    onSave(event.copy(
                        title = title,
                        description = description,
                        startTime = startTime,
                        endTime = endTime,
                        category = category,
                        location = location
                    ))
                },
                enabled = title.isNotEmpty()
            ) {
                Text("Save")
            }
        },
        dismissButton = {
            TextButton(onClick = onDismiss) {
                Text("Cancel")
            }
        }
    )
}

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun EventDetails(
    event: Event,
    onDismiss: () -> Unit,
    onDelete: (Event) -> Unit
) {
    AlertDialog(
        onDismissRequest = onDismiss,
        title = { Text(event.title) },
        text = {
            Column(
                verticalArrangement = Arrangement.spacedBy(8.dp)
            ) {
                Text(
                    text = if (event.isAllDay) "All Day" else "${event.startTime} - ${event.endTime}",
                    style = MaterialTheme.typography.bodyMedium
                )
                if (event.description.isNotEmpty()) {
                    Text(
                        text = event.description,
                        style = MaterialTheme.typography.bodyMedium
                    )
                }
                if (event.location.isNotEmpty()) {
                    Text(
                        text = "Location: ${event.location}",
                        style = MaterialTheme.typography.bodyMedium
                    )
                }
            }
        },
        confirmButton = {
            TextButton(
                onClick = { onDelete(event) },
                colors = ButtonDefaults.textButtonColors(contentColor = MaterialTheme.colorScheme.error)
            ) {
                Text("Delete")
            }
        },
        dismissButton = {
            TextButton(onClick = onDismiss) {
                Text("Close")
            }
        }
    )
}

// Helper functions
fun generateSampleEvents(): List<Event> {
    return listOf(
        Event(
            id = "1",
            title = "Team Meeting",
            description = "Weekly team standup",
            startTime = LocalDate.now().plusDays(1),
            endTime = LocalDate.now().plusDays(1),
            category = "work",
            isAllDay = false,
            location = "Conference Room A",
            attendees = listOf("john@example.com", "jane@example.com"),
            recurring = "weekly",
            reminders = listOf("15min", "1hour")
        ),
        Event(
            id = "2",
            title = "Doctor Appointment",
            description = "Annual checkup",
            startTime = LocalDate.now().plusDays(2),
            endTime = LocalDate.now().plusDays(2),
            category = "appointment",
            isAllDay = false,
            location = "Medical Center",
            attendees = emptyList(),
            recurring = "none",
            reminders = listOf("1day", "2hours")
        ),
        Event(
            id = "3",
            title = "Project Deadline",
            description = "Submit final report",
            startTime = LocalDate.now().plusDays(5),
            endTime = LocalDate.now().plusDays(5),
            category = "work",
            isAllDay = true,
            location = "",
            attendees = emptyList(),
            recurring = "none",
            reminders = listOf("1week", "1day")
        )
    )
}

fun generateCalendarDays(currentDate: LocalDate, events: List<Event>): List<CalendarDay> {
    val firstDay = currentDate.withDayOfMonth(1)
    val lastDay = currentDate.withDayOfMonth(currentDate.lengthOfMonth())
    val startingDayOfWeek = firstDay.dayOfWeek.value % 7
    
    val days = mutableListOf<CalendarDay>()
    
    // Add empty cells for days before the first day of the month
    repeat(startingDayOfWeek) {
        days.add(CalendarDay(
            date = firstDay.minusDays(1),
            dayNumber = 0,
            isToday = false,
            isEmpty = true,
            hasEvents = false,
            events = emptyList()
        ))
    }
    
    // Add days of the month
    for (day in 1..lastDay.dayOfMonth) {
        val date = currentDate.withDayOfMonth(day)
        val dayEvents = getEventsForDate(date, events)
        val isToday = date == LocalDate.now()
        
        days.add(CalendarDay(
            date = date,
            dayNumber = day,
            isToday = isToday,
            isEmpty = false,
            hasEvents = dayEvents.isNotEmpty(),
            events = dayEvents
        ))
    }
    
    return days
}

fun generateWeekDays(currentDate: LocalDate, events: List<Event>): List<CalendarDay> {
    val startOfWeek = currentDate.minusDays(currentDate.dayOfWeek.value.toLong() - 1)
    val days = mutableListOf<CalendarDay>()
    
    for (i in 0..6) {
        val date = startOfWeek.plusDays(i.toLong())
        val dayEvents = getEventsForDate(date, events)
        val isToday = date == LocalDate.now()
        
        days.add(CalendarDay(
            date = date,
            dayNumber = date.dayOfMonth,
            isToday = isToday,
            isEmpty = false,
            hasEvents = dayEvents.isNotEmpty(),
            events = dayEvents
        ))
    }
    
    return days
}

fun getEventsForDate(date: LocalDate, events: List<Event>): List<Event> {
    return events.filter { event ->
        event.startTime == date
    }
}

fun getCategoryColor(category: String): Color {
    return when (category) {
        "personal" -> Color.Green
        "work" -> Color.Blue
        "meeting" -> Color.Orange
        "appointment" -> Color.Magenta
        "reminder" -> Color.Red
        else -> Color.Blue
    }
}

// Data classes
enum class ViewMode {
    MONTH, WEEK, DAY
}

data class CalendarDay(
    val date: LocalDate,
    val dayNumber: Int,
    val isToday: Boolean,
    val isEmpty: Boolean,
    val hasEvents: Boolean,
    val events: List<Event>
)

data class Event(
    val id: String = UUID.randomUUID().toString(),
    val title: String = "",
    val description: String = "",
    val startTime: LocalDate = LocalDate.now(),
    val endTime: LocalDate = LocalDate.now(),
    val category: String = "personal",
    val isAllDay: Boolean = false,
    val location: String = "",
    val attendees: List<String> = emptyList(),
    val recurring: String = "none",
    val reminders: List<String> = emptyList()
)

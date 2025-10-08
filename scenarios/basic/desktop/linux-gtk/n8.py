import gi
gi.require_version('Gtk', '3.0')
from gi.repository import Gtk, GObject, GLib

class KeyboardTrapInWidget(Gtk.Window):
    def __init__(self):
        Gtk.Window.__init__(self, title="Event Scheduler")
        self.set_default_size(800, 600)
        self.set_border_width(10)
        
        # Main container
        main_box = Gtk.VBox(spacing=20)
        self.add(main_box)
        
        # Header
        header_box = Gtk.VBox(spacing=10)
        header_box.set_halign(Gtk.Align.CENTER)
        
        title_label = Gtk.Label()
        title_label.set_markup("<span size='xx-large' weight='bold'>Event Scheduler</span>")
        header_box.pack_start(title_label, False, False, 0)
        
        subtitle_label = Gtk.Label()
        subtitle_label.set_markup("<span size='large'>Create and manage your events</span>")
        subtitle_label.set_halign(Gtk.Align.CENTER)
        header_box.pack_start(subtitle_label, False, False, 0)
        
        main_box.pack_start(header_box, False, False, 0)
        
        # Event form
        form_frame = Gtk.Frame()
        form_frame.set_shadow_type(Gtk.ShadowType.ETCHED_IN)
        
        form_box = Gtk.VBox(spacing=20)
        form_box.set_margin_left(20)
        form_box.set_margin_right(20)
        form_box.set_margin_top(20)
        form_box.set_margin_bottom(20)
        form_frame.add(form_box)
        
        # Event title
        title_box = Gtk.VBox(spacing=5)
        
        title_label = Gtk.Label()
        title_label.set_markup("<span weight='bold' size='large'>Event Title</span>")
        title_label.set_halign(Gtk.Align.START)
        title_box.pack_start(title_label, False, False, 0)
        
        self.title_entry = Gtk.Entry()
        self.title_entry.set_placeholder_text("Enter event title")
        self.title_entry.set_size_request(300, 35)
        title_box.pack_start(self.title_entry, False, False, 0)
        
        form_box.pack_start(title_box, False, False, 0)
        
        # Event description
        description_box = Gtk.VBox(spacing=5)
        
        description_label = Gtk.Label()
        description_label.set_markup("<span weight='bold' size='large'>Event Description</span>")
        description_label.set_halign(Gtk.Align.START)
        description_box.pack_start(description_label, False, False, 0)
        
        self.description_text = Gtk.TextView()
        self.description_text.set_wrap_mode(Gtk.WrapMode.WORD)
        self.description_text.set_size_request(300, 100)
        description_box.pack_start(self.description_text, False, False, 0)
        
        form_box.pack_start(description_box, False, False, 0)
        
        # Date and time selection
        datetime_box = Gtk.HBox(spacing=20)
        
        # Date selection - KEYBOARD TRAP IN WIDGET
        date_box = Gtk.VBox(spacing=5)
        
        date_label = Gtk.Label()
        date_label.set_markup("<span weight='bold' size='large'>Event Date</span>")
        date_label.set_halign(Gtk.Align.START)
        date_box.pack_start(date_label, False, False, 0)
        
        self.date_button = Gtk.Button("📅 Select Date")
        self.date_button.set_size_request(150, 35)
        self.date_button.connect("clicked", self.on_date_button_clicked)
        date_box.pack_start(self.date_button, False, False, 0)
        
        # KEYBOARD TRAP IN WIDGET - Custom date picker that traps keyboard focus inside
        self.date_picker_frame = Gtk.Frame()
        self.date_picker_frame.set_shadow_type(Gtk.ShadowType.ETCHED_IN)
        self.date_picker_frame.set_visible(False)
        
        date_picker_box = Gtk.VBox(spacing=10)
        date_picker_box.set_margin_left(10)
        date_picker_box.set_margin_right(10)
        date_picker_box.set_margin_top(10)
        date_picker_box.set_margin_bottom(10)
        
        # KEYBOARD TRAP IN WIDGET - Custom date picker that traps keyboard focus inside
        self.date_picker = Gtk.Calendar()
        self.date_picker.connect("day-selected", self.on_date_selected)
        date_picker_box.pack_start(self.date_picker, False, False, 0)
        
        # Date picker buttons
        date_buttons_box = Gtk.HBox(spacing=10)
        
        date_cancel_button = Gtk.Button("Cancel")
        date_cancel_button.connect("clicked", self.on_date_cancel_clicked)
        date_buttons_box.pack_start(date_cancel_button, False, False, 0)
        
        date_done_button = Gtk.Button("Done")
        date_done_button.get_style_context().add_class("suggested-action")
        date_done_button.connect("clicked", self.on_date_done_clicked)
        date_buttons_box.pack_start(date_done_button, False, False, 0)
        
        date_picker_box.pack_start(date_buttons_box, False, False, 0)
        
        self.date_picker_frame.add(date_picker_box)
        date_box.pack_start(self.date_picker_frame, False, False, 0)
        
        datetime_box.pack_start(date_box, False, False, 0)
        
        # Time selection - KEYBOARD TRAP IN WIDGET
        time_box = Gtk.VBox(spacing=5)
        
        time_label = Gtk.Label()
        time_label.set_markup("<span weight='bold' size='large'>Event Time</span>")
        time_label.set_halign(Gtk.Align.START)
        time_box.pack_start(time_label, False, False, 0)
        
        self.time_button = Gtk.Button("🕐 Select Time")
        self.time_button.set_size_request(150, 35)
        self.time_button.connect("clicked", self.on_time_button_clicked)
        time_box.pack_start(self.time_button, False, False, 0)
        
        # KEYBOARD TRAP IN WIDGET - Custom time picker that traps keyboard focus inside
        self.time_picker_frame = Gtk.Frame()
        self.time_picker_frame.set_shadow_type(Gtk.ShadowType.ETCHED_IN)
        self.time_picker_frame.set_visible(False)
        
        time_picker_box = Gtk.VBox(spacing=10)
        time_picker_box.set_margin_left(10)
        time_picker_box.set_margin_right(10)
        time_picker_box.set_margin_top(10)
        time_picker_box.set_margin_bottom(10)
        
        # KEYBOARD TRAP IN WIDGET - Custom time picker that traps keyboard focus inside
        time_picker_hbox = Gtk.HBox(spacing=5)
        
        self.hour_spin = Gtk.SpinButton()
        self.hour_spin.set_adjustment(Gtk.Adjustment(value=12, lower=0, upper=23, step_increment=1, page_increment=1))
        self.hour_spin.set_digits(0)
        time_picker_hbox.pack_start(self.hour_spin, False, False, 0)
        
        colon_label = Gtk.Label(":")
        time_picker_hbox.pack_start(colon_label, False, False, 0)
        
        self.minute_spin = Gtk.SpinButton()
        self.minute_spin.set_adjustment(Gtk.Adjustment(value=0, lower=0, upper=59, step_increment=1, page_increment=5))
        self.minute_spin.set_digits(0)
        time_picker_hbox.pack_start(self.minute_spin, False, False, 0)
        
        time_picker_box.pack_start(time_picker_hbox, False, False, 0)
        
        # Time picker buttons
        time_buttons_box = Gtk.HBox(spacing=10)
        
        time_cancel_button = Gtk.Button("Cancel")
        time_cancel_button.connect("clicked", self.on_time_cancel_clicked)
        time_buttons_box.pack_start(time_cancel_button, False, False, 0)
        
        time_done_button = Gtk.Button("Done")
        time_done_button.get_style_context().add_class("suggested-action")
        time_done_button.connect("clicked", self.on_time_done_clicked)
        time_buttons_box.pack_start(time_done_button, False, False, 0)
        
        time_picker_box.pack_start(time_buttons_box, False, False, 0)
        
        self.time_picker_frame.add(time_picker_box)
        time_box.pack_start(self.time_picker_frame, False, False, 0)
        
        datetime_box.pack_start(time_box, False, False, 0)
        
        form_box.pack_start(datetime_box, False, False, 0)
        
        # Event location
        location_box = Gtk.VBox(spacing=5)
        
        location_label = Gtk.Label()
        location_label.set_markup("<span weight='bold' size='large'>Event Location</span>")
        location_label.set_halign(Gtk.Align.START)
        location_box.pack_start(location_label, False, False, 0)
        
        self.location_entry = Gtk.Entry()
        self.location_entry.set_placeholder_text("Enter event location")
        self.location_entry.set_size_request(300, 35)
        location_box.pack_start(self.location_entry, False, False, 0)
        
        form_box.pack_start(location_box, False, False, 0)
        
        # Attendees
        attendees_box = Gtk.VBox(spacing=5)
        
        attendees_label = Gtk.Label()
        attendees_label.set_markup("<span weight='bold' size='large'>Attendees</span>")
        attendees_label.set_halign(Gtk.Align.START)
        attendees_box.pack_start(attendees_label, False, False, 0)
        
        self.attendees_entry = Gtk.Entry()
        self.attendees_entry.set_placeholder_text("Enter attendee emails")
        self.attendees_entry.set_size_request(300, 35)
        attendees_box.pack_start(self.attendees_entry, False, False, 0)
        
        form_box.pack_start(attendees_box, False, False, 0)
        
        main_box.pack_start(form_frame, False, False, 0)
        
        # Action buttons
        button_box = Gtk.HBox(spacing=15)
        button_box.set_halign(Gtk.Align.CENTER)
        
        create_event_button = Gtk.Button("Create Event")
        create_event_button.get_style_context().add_class("suggested-action")
        create_event_button.set_size_request(120, 40)
        create_event_button.connect("clicked", self.on_create_event_clicked)
        button_box.pack_start(create_event_button, False, False, 0)
        
        save_draft_button = Gtk.Button("Save Draft")
        save_draft_button.set_size_request(120, 40)
        save_draft_button.connect("clicked", self.on_save_draft_clicked)
        button_box.pack_start(save_draft_button, False, False, 0)
        
        cancel_button = Gtk.Button("Cancel")
        cancel_button.set_size_request(120, 40)
        cancel_button.connect("clicked", self.on_cancel_clicked)
        button_box.pack_start(cancel_button, False, False, 0)
        
        main_box.pack_start(button_box, False, False, 0)
        
        # State
        self.selected_date = None
        self.selected_time = None
        self.is_date_picker_open = False
        self.is_time_picker_open = False
        
    def on_date_button_clicked(self, button):
        # KEYBOARD TRAP IN WIDGET - Custom date picker that traps keyboard focus inside
        self.is_date_picker_open = not self.is_date_picker_open
        self.date_picker_frame.set_visible(self.is_date_picker_open)
        
        if self.is_date_picker_open:
            # KEYBOARD TRAP IN WIDGET - Focus is trapped inside the date picker widget
            self.date_picker.grab_focus()
    
    def on_time_button_clicked(self, button):
        # KEYBOARD TRAP IN WIDGET - Custom time picker that traps keyboard focus inside
        self.is_time_picker_open = not self.is_time_picker_open
        self.time_picker_frame.set_visible(self.is_time_picker_open)
        
        if self.is_time_picker_open:
            # KEYBOARD TRAP IN WIDGET - Focus is trapped inside the time picker widget
            self.hour_spin.grab_focus()
    
    def on_date_selected(self, calendar):
        # Handle date selection
        pass
    
    def on_date_cancel_clicked(self, button):
        self.is_date_picker_open = False
        self.date_picker_frame.set_visible(False)
    
    def on_date_done_clicked(self, button):
        self.is_date_picker_open = False
        self.date_picker_frame.set_visible(False)
        # Update date button text
        date = self.date_picker.get_date()
        self.date_button.set_label(f"📅 {date.day:02d}/{date.month:02d}/{date.year}")
    
    def on_time_cancel_clicked(self, button):
        self.is_time_picker_open = False
        self.time_picker_frame.set_visible(False)
    
    def on_time_done_clicked(self, button):
        self.is_time_picker_open = False
        self.time_picker_frame.set_visible(False)
        # Update time button text
        hour = int(self.hour_spin.get_value())
        minute = int(self.minute_spin.get_value())
        self.time_button.set_label(f"🕐 {hour:02d}:{minute:02d}")
    
    def on_create_event_clicked(self, button):
        dialog = Gtk.MessageDialog(
            transient_for=self,
            flags=0,
            message_type=Gtk.MessageType.INFO,
            buttons=Gtk.ButtonsType.OK,
            text="Event Created"
        )
        dialog.format_secondary_text("Your event has been created successfully!")
        dialog.run()
        dialog.destroy()
    
    def on_save_draft_clicked(self, button):
        dialog = Gtk.MessageDialog(
            transient_for=self,
            flags=0,
            message_type=Gtk.MessageType.INFO,
            buttons=Gtk.ButtonsType.OK,
            text="Draft Saved"
        )
        dialog.format_secondary_text("Your event draft has been saved!")
        dialog.run()
        dialog.destroy()
    
    def on_cancel_clicked(self, button):
        dialog = Gtk.MessageDialog(
            transient_for=self,
            flags=0,
            message_type=Gtk.MessageType.QUESTION,
            buttons=Gtk.ButtonsType.YES_NO,
            text="Cancel Event"
        )
        dialog.format_secondary_text("Are you sure you want to cancel creating this event?")
        
        response = dialog.run()
        if response == Gtk.ResponseType.YES:
            # Clear form
            self.title_entry.set_text("")
            self.description_text.get_buffer().set_text("")
            self.location_entry.set_text("")
            self.attendees_entry.set_text("")
            self.date_button.set_label("📅 Select Date")
            self.time_button.set_label("🕐 Select Time")
        
        dialog.destroy()

def main():
    win = KeyboardTrapInWidget()
    win.connect("destroy", Gtk.main_quit)
    win.show_all()
    Gtk.main()

if __name__ == "__main__":
    main()

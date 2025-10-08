import gi
gi.require_version('Gtk', '3.0')
from gi.repository import Gtk, GObject, GLib
import threading
import time

class SilentLoadingState(Gtk.Window):
    def __init__(self):
        Gtk.Window.__init__(self, title="Data Dashboard")
        self.set_default_size(1000, 700)
        self.set_border_width(10)
        
        # Main container
        main_box = Gtk.VBox(spacing=0)
        self.add(main_box)
        
        # Toolbar
        toolbar_box = Gtk.HBox(spacing=10)
        toolbar_box.set_margin_top(10)
        toolbar_box.set_margin_bottom=10
        toolbar_box.set_halign(Gtk.Align.CENTER)
        
        # Action buttons
        refresh_button = Gtk.Button("Refresh Data")
        refresh_button.get_style_context().add_class("suggested-action")
        refresh_button.set_size_request(120, 40)
        refresh_button.connect("clicked", self.on_refresh_clicked)
        toolbar_box.pack_start(refresh_button, False, False, 0)
        
        export_button = Gtk.Button("Export Data")
        export_button.set_size_request(120, 40)
        export_button.connect("clicked", self.on_export_clicked)
        toolbar_box.pack_start(export_button, False, False, 0)
        
        generate_report_button = Gtk.Button("Generate Report")
        generate_report_button.set_size_request(120, 40)
        generate_report_button.connect("clicked", self.on_generate_report_clicked)
        toolbar_box.pack_start(generate_report_button, False, False, 0)
        
        main_box.pack_start(toolbar_box, False, False, 0)
        
        # Loading view - SILENT LOADING STATE
        self.loading_frame = Gtk.Frame()
        self.loading_frame.set_shadow_type(Gtk.ShadowType.ETCHED_IN)
        self.loading_frame.set_size_request(-1, 100)
        self.loading_frame.set_visible(False)
        
        loading_box = Gtk.VBox(spacing=15)
        loading_box.set_margin_left(20)
        loading_box.set_margin_right(20)
        loading_box.set_margin_top(20)
        loading_box.set_margin_bottom=20)
        loading_box.set_halign(Gtk.Align.CENTER)
        loading_box.set_valign(Gtk.Align.CENTER)
        
        # SILENT LOADING STATE - Content spinner without screen reader announcement
        self.progress_spinner = Gtk.Spinner()
        self.progress_spinner.set_size_request(40, 40)
        loading_box.pack_start(self.progress_spinner, False, False, 0)
        
        loading_label = Gtk.Label("Loading...")
        loading_label.set_markup("<span weight='bold' size='large'>Loading...</span>")
        loading_label.set_halign(Gtk.Align.CENTER)
        loading_box.pack_start(loading_label, False, False, 0)
        
        # SILENT LOADING STATE - Content spinner without screen reader announcement
        self.progress_bar = Gtk.ProgressBar()
        self.progress_bar.set_size_request(300, 20)
        self.progress_bar.set_fraction(0.0)
        loading_box.pack_start(self.progress_bar, False, False, 0)
        
        progress_label = Gtk.Label("0%")
        progress_label.set_halign(Gtk.Align.CENTER)
        loading_box.pack_start(progress_label, False, False, 0)
        
        self.loading_frame.add(loading_box)
        main_box.pack_start(self.loading_frame, False, False, 0)
        
        # Main content
        scrolled_window = Gtk.ScrolledWindow()
        scrolled_window.set_policy(Gtk.PolicyType.AUTOMATIC, Gtk.PolicyType.AUTOMATIC)
        
        content_box = Gtk.VBox(spacing=20)
        content_box.set_margin_left(20)
        content_box.set_margin_right(20)
        content_box.set_margin_top=20)
        content_box.set_margin_bottom=20)
        
        # Data summary
        summary_label = Gtk.Label()
        summary_label.set_markup("<span size='x-large' weight='bold'>Data Summary</span>")
        summary_label.set_halign(Gtk.Align.START)
        content_box.pack_start(summary_label, False, False, 0)
        
        summary_grid = Gtk.Grid()
        summary_grid.set_column_spacing(20)
        summary_grid.set_row_spacing(20)
        
        summary_items = [
            ("📊", "Total Records", "1,234", "blue"),
            ("✅", "Completed", "987", "green"),
            ("⏳", "Pending", "247", "orange")
        ]
        
        for i, (icon, title, value, color) in enumerate(summary_items):
            summary_frame = self.create_summary_card(icon, title, value, color)
            summary_grid.attach(summary_frame, i % 3, i // 3, 1, 1)
        
        content_box.pack_start(summary_grid, False, False, 0)
        
        # Recent activity
        activity_label = Gtk.Label()
        activity_label.set_markup("<span size='x-large' weight='bold'>Recent Activity</span>")
        activity_label.set_halign(Gtk.Align.START)
        content_box.pack_start(activity_label, False, False, 0)
        
        activity_frame = Gtk.Frame()
        activity_frame.set_shadow_type(Gtk.ShadowType.ETCHED_IN)
        
        activity_box = Gtk.VBox(spacing=10)
        activity_box.set_margin_left(15)
        activity_box.set_margin_right(15)
        activity_box.set_margin_top(15)
        activity_box.set_margin_bottom(15)
        
        activities = [
            ("🟢", "Data refreshed", "2 minutes ago"),
            ("📊", "Report generated", "15 minutes ago"),
            ("📤", "Data exported", "1 hour ago")
        ]
        
        for icon, title, time in activities:
            activity_row = Gtk.HBox(spacing=10)
            
            icon_label = Gtk.Label(icon)
            activity_row.pack_start(icon_label, False, False, 0)
            
            title_label = Gtk.Label()
            title_label.set_markup(f"<span weight='bold'>{title}</span>")
            activity_row.pack_start(title_label, False, False, 0)
            
            time_label = Gtk.Label(time)
            time_label.set_halign(Gtk.Align.END)
            activity_row.pack_start(time_label, True, True, 0)
            
            activity_box.pack_start(activity_row, False, False, 0)
        
        activity_frame.add(activity_box)
        content_box.pack_start(activity_frame, False, False, 0)
        
        # Data table
        table_label = Gtk.Label()
        table_label.set_markup("<span size='x-large' weight='bold'>Data Records</span>")
        table_label.set_halign(Gtk.Align.START)
        content_box.pack_start(table_label, False, False, 0)
        
        # Create tree view for data
        self.tree_view = Gtk.TreeView()
        self.tree_view.set_headers_visible(True)
        
        # Create columns
        columns = ["ID", "Name", "Status", "Date"]
        for i, col_name in enumerate(columns):
            renderer = Gtk.CellRendererText()
            column = Gtk.TreeViewColumn(col_name, renderer, text=i)
            self.tree_view.append_column(column)
        
        # Create list store
        self.list_store = Gtk.ListStore(str, str, str, str)
        
        # Load sample data
        self.load_data()
        
        self.tree_view.set_model(self.list_store)
        
        # Add tree view to scrolled window
        table_scrolled = Gtk.ScrolledWindow()
        table_scrolled.set_policy(Gtk.PolicyType.AUTOMATIC, Gtk.PolicyType.AUTOMATIC)
        table_scrolled.add(self.tree_view)
        table_scrolled.set_size_request(-1, 200)
        
        content_box.pack_start(table_scrolled, False, False, 0)
        
        scrolled_window.add(content_box)
        main_box.pack_start(scrolled_window, True, True, 0)
        
        # State
        self.is_loading = False
        self.loading_progress = 0.0
        self.progress_timer = None
        
    def create_summary_card(self, icon, title, value, color):
        frame = Gtk.Frame()
        frame.set_shadow_type(Gtk.ShadowType.ETCHED_IN)
        frame.set_size_request(200, 120)
        
        box = Gtk.VBox(spacing=8)
        box.set_margin_left(15)
        box.set_margin_right(15)
        box.set_margin_top(15)
        box.set_margin_bottom(15)
        
        icon_label = Gtk.Label(icon)
        icon_label.set_markup(f"<span size='xx-large'>{icon}</span>")
        icon_label.set_halign(Gtk.Align.CENTER)
        box.pack_start(icon_label, False, False, 0)
        
        title_label = Gtk.Label()
        title_label.set_markup(f"<span weight='bold'>{title}</span>")
        title_label.set_halign(Gtk.Align.CENTER)
        box.pack_start(title_label, False, False, 0)
        
        value_label = Gtk.Label()
        value_label.set_markup(f"<span weight='bold' size='large' color='{color}'>{value}</span>")
        value_label.set_halign(Gtk.Align.CENTER)
        box.pack_start(value_label, False, False, 0)
        
        frame.add(box)
        return frame
    
    def load_data(self):
        data = [
            ("1", "Record 1", "Active", "2024-01-01"),
            ("2", "Record 2", "Pending", "2024-01-02"),
            ("3", "Record 3", "Active", "2024-01-03"),
            ("4", "Record 4", "Pending", "2024-01-04"),
            ("5", "Record 5", "Active", "2024-01-05")
        ]
        
        for record in data:
            self.list_store.append(record)
    
    def start_loading(self):
        self.is_loading = True
        self.loading_frame.set_visible(True)
        self.loading_progress = 0.0
        
        # SILENT LOADING STATE - Content spinner without screen reader announcement
        self.progress_spinner.start()
        self.progress_bar.set_fraction(0.0)
        
        def progress_loop():
            while self.is_loading and self.loading_progress < 1.0:
                self.loading_progress += 0.02
                GLib.idle_add(self.update_progress)
                time.sleep(0.1)
            
            if self.loading_progress >= 1.0:
                GLib.idle_add(self.stop_loading)
        
        thread = threading.Thread(target=progress_loop, daemon=True)
        thread.start()
    
    def update_progress(self):
        self.progress_bar.set_fraction(self.loading_progress)
        return False
    
    def stop_loading(self):
        self.is_loading = False
        self.loading_frame.set_visible(False)
        self.progress_spinner.stop()
        return False
    
    def on_refresh_clicked(self, button):
        self.start_loading()
    
    def on_export_clicked(self, button):
        self.start_loading()
    
    def on_generate_report_clicked(self, button):
        self.start_loading()

def main():
    win = SilentLoadingState()
    win.connect("destroy", Gtk.main_quit)
    win.show_all()
    Gtk.main()

if __name__ == "__main__":
    main()

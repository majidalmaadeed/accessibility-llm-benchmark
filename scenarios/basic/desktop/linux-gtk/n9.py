import gi
gi.require_version('Gtk', '3.0')
from gi.repository import Gtk, GObject, GLib
import threading
import time

class LowContrastWarningText(Gtk.Window):
    def __init__(self):
        Gtk.Window.__init__(self, title="Dashboard")
        self.set_default_size(1000, 700)
        self.set_border_width(10)
        
        # Main container
        main_box = Gtk.VBox(spacing=0)
        self.add(main_box)
        
        # Warning banner - LOW CONTRAST WARNING TEXT
        self.warning_banner = Gtk.Frame()
        self.warning_banner.set_size_request(-1, 80)
        self.warning_banner.get_style_context().add_class("warning-banner")
        
        warning_box = Gtk.HBox(spacing=15)
        warning_box.set_margin_left(20)
        warning_box.set_margin_right(20)
        warning_box.set_margin_top(10)
        warning_box.set_margin_bottom(10)
        
        # Warning icon - LOW CONTRAST
        warning_icon = Gtk.Label("⚠️")
        warning_icon.set_markup("<span size='large'>⚠️</span>")
        warning_box.pack_start(warning_icon, False, False, 0)
        
        # Warning content
        warning_content = Gtk.VBox(spacing=5)
        
        # LOW CONTRAST WARNING TEXT - Session timeout warning with insufficient color contrast
        warning_title = Gtk.Label("Session Timeout Warning")
        warning_title.set_markup("<span weight='bold' size='large' color='#757575'>Session Timeout Warning</span>")
        warning_title.set_halign(Gtk.Align.START)
        warning_content.pack_start(warning_title, False, False, 0)
        
        warning_message = Gtk.Label("Your session will expire in 5 minutes. Please save your work and extend your session to continue.")
        warning_message.set_markup("<span color='#BDBDBD'>Your session will expire in 5 minutes. Please save your work and extend your session to continue.</span>")
        warning_message.set_line_wrap(True)
        warning_message.set_halign(Gtk.Align.START)
        warning_content.pack_start(warning_message, False, False, 0)
        
        warning_box.pack_start(warning_content, True, True, 0)
        
        # Action buttons - LOW CONTRAST
        button_box = Gtk.HBox(spacing=10)
        
        extend_button = Gtk.Button("Extend")
        extend_button.set_markup("<span color='#90CAF9'>Extend</span>")
        button_box.pack_start(extend_button, False, False, 0)
        
        logout_button = Gtk.Button("Logout")
        logout_button.set_markup("<span color='#EF9A9A'>Logout</span>")
        button_box.pack_start(logout_button, False, False, 0)
        
        # Flash count label
        self.flash_count_label = Gtk.Label("Flashes: 0")
        self.flash_count_label.set_markup("<span weight='bold' color='white'>Flashes: 0</span>")
        self.flash_count_label.get_style_context().add_class("flash-count")
        button_box.pack_start(self.flash_count_label, False, False, 0)
        
        warning_box.pack_start(button_box, False, False, 0)
        
        self.warning_banner.add(warning_box)
        main_box.pack_start(self.warning_banner, False, False, 0)
        
        # Main content
        scrolled_window = Gtk.ScrolledWindow()
        scrolled_window.set_policy(Gtk.PolicyType.AUTOMATIC, Gtk.PolicyType.AUTOMATIC)
        
        content_box = Gtk.VBox(spacing=20)
        content_box.set_margin_left(20)
        content_box.set_margin_right(20)
        content_box.set_margin_top(20)
        content_box.set_margin_bottom(20)
        
        # Dashboard title
        dashboard_title = Gtk.Label()
        dashboard_title.set_markup("<span size='xx-large' weight='bold'>Welcome back!</span>")
        dashboard_title.set_halign(Gtk.Align.CENTER)
        content_box.pack_start(dashboard_title, False, False, 0)
        
        dashboard_subtitle = Gtk.Label("Your session is active and secure")
        dashboard_subtitle.set_markup("<span size='large'>Your session is active and secure</span>")
        dashboard_subtitle.set_halign(Gtk.Align.CENTER)
        content_box.pack_start(dashboard_subtitle, False, False, 0)
        
        time_remaining = Gtk.Label("⏰ 5 minutes remaining")
        time_remaining.set_halign(Gtk.Align.CENTER)
        content_box.pack_start(time_remaining, False, False, 0)
        
        # Quick actions
        quick_actions_label = Gtk.Label()
        quick_actions_label.set_markup("<span size='x-large' weight='bold'>Quick Actions</span>")
        quick_actions_label.set_halign(Gtk.Align.START)
        content_box.pack_start(quick_actions_label, False, False, 0)
        
        quick_actions_grid = Gtk.Grid()
        quick_actions_grid.set_column_spacing(20)
        quick_actions_grid.set_row_spacing(20)
        
        actions = [
            ("📊", "View Reports", "Learn new skills"),
            ("👥", "Manage Users", "User management"),
            ("⚙️", "Settings", "App configuration"),
            ("❓", "Help & Support", "Get assistance")
        ]
        
        for i, (icon, title, subtitle) in enumerate(actions):
            action_frame = self.create_action_card(icon, title, subtitle)
            quick_actions_grid.attach(action_frame, i % 2, i // 2, 1, 1)
        
        content_box.pack_start(quick_actions_grid, False, False, 0)
        
        # Recent activity
        recent_activity_label = Gtk.Label()
        recent_activity_label.set_markup("<span size='x-large' weight='bold'>Recent Activity</span>")
        recent_activity_label.set_halign(Gtk.Align.START)
        content_box.pack_start(recent_activity_label, False, False, 0)
        
        recent_activity_frame = Gtk.Frame()
        recent_activity_frame.set_shadow_type(Gtk.ShadowType.ETCHED_IN)
        
        activity_box = Gtk.VBox(spacing=10)
        activity_box.set_margin_left(15)
        activity_box.set_margin_right(15)
        activity_box.set_margin_top(15)
        activity_box.set_margin_bottom(15)
        
        activities = [
            ("🟢", "User logged in", "2 minutes ago"),
            ("📊", "Report generated", "15 minutes ago"),
            ("⚙️", "Settings updated", "1 hour ago")
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
        
        recent_activity_frame.add(activity_box)
        content_box.pack_start(recent_activity_frame, False, False, 0)
        
        scrolled_window.add(content_box)
        main_box.pack_start(scrolled_window, True, True, 0)
        
        # Start flash animation
        self.flash_count = 0
        self.start_flash_animation()
        
    def create_action_card(self, icon, title, subtitle):
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
        
        subtitle_label = Gtk.Label(subtitle)
        subtitle_label.set_halign(Gtk.Align.CENTER)
        box.pack_start(subtitle_label, False, False, 0)
        
        frame.add(box)
        return frame
    
    def start_flash_animation(self):
        def flash_loop():
            while True:
                self.flash_count += 1
                GLib.idle_add(self.update_flash_display)
                time.sleep(0.2)
        
        thread = threading.Thread(target=flash_loop, daemon=True)
        thread.start()
    
    def update_flash_display(self):
        self.flash_count_label.set_markup(f"<span weight='bold' color='white'>Flashes: {self.flash_count}</span>")
        
        # Toggle between red and orange
        if self.flash_count % 2 == 0:
            self.warning_banner.get_style_context().add_class("flash-red")
            self.warning_banner.get_style_context().remove_class("flash-orange")
        else:
            self.warning_banner.get_style_context().add_class("flash-orange")
            self.warning_banner.get_style_context().remove_class("flash-red")
        
        return False

def main():
    # Add CSS for styling
    css_provider = Gtk.CssProvider()
    css = """
    .warning-banner {
        background-color: #ff0000;
    }
    .flash-red {
        background-color: #ff0000;
    }
    .flash-orange {
        background-color: #ff8800;
    }
    .flash-count {
        background-color: rgba(0, 0, 0, 0.2);
        border-radius: 6px;
        padding: 4px 8px;
    }
    """
    css_provider.load_from_data(css.encode())
    
    win = LowContrastWarningText()
    win.connect("destroy", Gtk.main_quit)
    win.show_all()
    Gtk.main()

if __name__ == "__main__":
    main()

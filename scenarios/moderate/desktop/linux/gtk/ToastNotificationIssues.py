#!/usr/bin/env python3
"""
ToastNotificationIssues - Linux GTK Implementation
"""
import gi
gi.require_version('Gtk', '3.0')
from gi.repository import Gtk, GObject, GLib
import threading
import time
class ToastNotificationIssues(Gtk.Window):
    def __init__(self):
        self.set_default_size(600, 700)
        self.set_resizable(True)
        # State
        self.notifications = []
        self.notification_count = 0
        self.setup_ui()
    def setup_ui(self):
        # Main container
        main_box = Gtk.Box(orientation=Gtk.Orientation.VERTICAL, spacing=20)
        main_box.set_margin_left(20)
        main_box.set_margin_right(20)
        main_box.set_margin_top(20)
        main_box.set_margin_bottom(20)
        self.add(main_box)
        # Main content card
        main_card = Gtk.Frame()
        main_card.set_shadow_type(Gtk.ShadowType.ETCHED_IN)
        main_card.set_margin_bottom(20)
        card_content = Gtk.Box(orientation=Gtk.Orientation.VERTICAL, spacing=20)
        card_content.set_margin_left(30)
        card_content.set_margin_right(30)
        card_content.set_margin_top(30)
        card_content.set_margin_bottom(30)
        main_card.add(card_content)
        # Title
        # Description
        # Notification Controls
        controls_box = Gtk.Box(orientation=Gtk.Orientation.VERTICAL, spacing=15)
        card_content.pack_start(controls_box, False, False, 0)
        # Success Notification
        self.show_success_button.set_size_request(-1, 40)
        self.show_success_button.connect("clicked", self.on_show_success_clicked)
        self.show_success_button.override_color(Gtk.StateFlags.NORMAL, Gtk.RGBA(1.0, 1.0, 1.0, 1.0))
        self.show_success_button.override_background_color(Gtk.StateFlags.NORMAL, Gtk.RGBA(0.2, 0.7, 0.2, 1.0))
        controls_box.pack_start(self.show_success_button, False, False, 0)
        # Error Notification
        self.show_error_button.set_size_request(-1, 40)
        self.show_error_button.connect("clicked", self.on_show_error_clicked)
        self.show_error_button.override_color(Gtk.StateFlags.NORMAL, Gtk.RGBA(1.0, 1.0, 1.0, 1.0))
        self.show_error_button.override_background_color(Gtk.StateFlags.NORMAL, Gtk.RGBA(0.8, 0.2, 0.2, 1.0))
        controls_box.pack_start(self.show_error_button, False, False, 0)
        # Warning Notification
        self.show_warning_button.set_size_request(-1, 40)
        self.show_warning_button.connect("clicked", self.on_show_warning_clicked)
        self.show_warning_button.override_color(Gtk.StateFlags.NORMAL, Gtk.RGBA(0.0, 0.0, 0.0, 1.0))
        self.show_warning_button.override_background_color(Gtk.StateFlags.NORMAL, Gtk.RGBA(1.0, 0.8, 0.0, 1.0))
        controls_box.pack_start(self.show_warning_button, False, False, 0)
        # Info Notification
        self.show_info_button.set_size_request(-1, 40)
        self.show_info_button.connect("clicked", self.on_show_info_clicked)
        self.show_info_button.override_color(Gtk.StateFlags.NORMAL, Gtk.RGBA(1.0, 1.0, 1.0, 1.0))
        self.show_info_button.override_background_color(Gtk.StateFlags.NORMAL, Gtk.RGBA(0.1, 0.6, 0.7, 1.0))
        controls_box.pack_start(self.show_info_button, False, False, 0)
        # Clear All Button
        self.clear_all_button.set_size_request(-1, 32)
        self.clear_all_button.connect("clicked", self.on_clear_all_clicked)
        controls_box.pack_start(self.clear_all_button, False, False, 0)
        main_box.pack_start(main_card, False, False, 0)
        # Toast Notifications Container
        self.toast_container = Gtk.Box(orientation=Gtk.Orientation.VERTICAL, spacing=10)
        self.toast_container.set_halign(Gtk.Align.START)
        main_box.pack_start(self.toast_container, False, False, 0)
        info_frame = Gtk.Frame()
        info_frame.set_shadow_type(Gtk.ShadowType.ETCHED_IN)
        info_content = Gtk.Box(orientation=Gtk.Orientation.VERTICAL, spacing=15)
        info_content.set_margin_left(20)
        info_content.set_margin_right(20)
        info_content.set_margin_top(20)
        info_content.set_margin_bottom(20)
        info_frame.add(info_content)
• Missing dismiss button: No way to close notifications programmatically
• No auto-hide timer: Notifications don't disappear automatically
        issues_text.set_halign(Gtk.Align.START)
        issues_text.set_line_wrap(True)
        info_content.pack_start(issues_text, False, False, 0)
        # How to Fix
        fix_title.set_markup("<b>How to Fix:</b>")
        fix_title.set_halign(Gtk.Align.START)
        info_content.pack_start(fix_title, False, False, 0)
• Implement auto-hide timer with configurable duration
        fix_text.set_halign(Gtk.Align.START)
        fix_text.set_line_wrap(True)
        info_content.pack_start(fix_text, False, False, 0)
        parent_box.pack_start(info_frame, False, False, 0)
        # Basic setup only
        self.show_success_button.set_name("show-success-button")
        self.show_error_button.set_name("show-error-button")
        self.show_warning_button.set_name("show-warning-button")
        self.show_info_button.set_name("show-info-button")
        self.clear_all_button.set_name("clear-all-button")
    def on_show_success_clicked(self, button):
        self.show_toast("success", "Operation completed successfully!")
    def on_show_error_clicked(self, button):
        self.show_toast("error", "An error occurred while processing your request.")
    def on_show_warning_clicked(self, button):
        self.show_toast("warning", "Please review your input before proceeding.")
    def on_show_info_clicked(self, button):
        self.show_toast("info", "New updates are available for download.")
    def on_clear_all_clicked(self, button):
        self.clear_all_notifications()
    def show_toast(self, notification_type, message):
        self.notification_count += 1
        notification = {
            "id": self.notification_count,
            "type": notification_type,
            "message": message
        }
        self.notifications.insert(0, notification)
        # Create toast view
        toast_view = self.create_toast_view(notification)
        self.toast_container.pack_start(toast_view, False, False, 0)
        # Should implement auto-hide functionality with configurable duration
        # Basic auto-hide (5 seconds)
        def auto_hide():
            time.sleep(5)
            GLib.idle_add(self.remove_toast, notification)
        threading.Thread(target=auto_hide, daemon=True).start()
    def create_toast_view(self, notification):
        # Container
        container = Gtk.Frame()
        container.set_shadow_type(Gtk.ShadowType.OUT)
        container.set_name(f"toast-{notification['id']}")
        # Content box
        content_box = Gtk.Box(orientation=Gtk.Orientation.HORIZONTAL, spacing=10)
        content_box.set_margin_left(15)
        content_box.set_margin_right(15)
        content_box.set_margin_top(15)
        content_box.set_margin_bottom(15)
        container.add(content_box)
        # Icon
        # Message
        dismiss_button.set_size_request(24, 24)
        dismiss_button.set_relief(Gtk.ReliefStyle.NONE)
        dismiss_button.connect("clicked", self.on_dismiss_toast, notification['id'])
        content_box.pack_start(dismiss_button, False, False, 0)
        # Set background color based on type
        container.override_background_color(Gtk.StateFlags.NORMAL, self.get_background_color_for_type(notification['type']))
        # Basic setup only
        container.set_name(f"toast-{notification['id']}")
        return container
    def get_icon_for_type(self, notification_type):
        icons = {
            "success": "✓",
            "error": "✗",
            "warning": "⚠",
            "info": "ℹ"
        }
        return icons.get(notification_type, "•")
    def get_color_for_type(self, notification_type):
        colors = {
            "success": Gtk.RGBA(0.2, 0.7, 0.2, 1.0),
            "error": Gtk.RGBA(0.8, 0.2, 0.2, 1.0),
            "warning": Gtk.RGBA(0.8, 0.6, 0.0, 1.0),
            "info": Gtk.RGBA(0.1, 0.6, 0.7, 1.0)
        }
        return colors.get(notification_type, Gtk.RGBA(0.4, 0.4, 0.4, 1.0))
    def get_background_color_for_type(self, notification_type):
        colors = {
            "success": Gtk.RGBA(0.2, 0.7, 0.2, 0.1),
            "error": Gtk.RGBA(0.8, 0.2, 0.2, 0.1),
            "warning": Gtk.RGBA(1.0, 0.8, 0.0, 0.1),
            "info": Gtk.RGBA(0.1, 0.6, 0.7, 0.1)
        }
        return colors.get(notification_type, Gtk.RGBA(0.9, 0.9, 0.9, 1.0))
    def on_dismiss_toast(self, button, notification_id):
        self.remove_toast_by_id(notification_id)
    def remove_toast(self, notification):
        self.remove_toast_by_id(notification['id'])
    def remove_toast_by_id(self, notification_id):
        # Remove from notifications list
        self.notifications = [n for n in self.notifications if n['id'] != notification_id]
        # Remove from UI
        for child in self.toast_container.get_children():
            if child.get_name() == f"toast-{notification_id}":
                self.toast_container.remove(child)
                break
    def clear_all_notifications(self):
        self.notifications.clear()
        self.notification_count = 0
        # Remove all toast views
        for child in self.toast_container.get_children():
            self.toast_container.remove(child)
    # Should implement methods to:
    # 4. Provide programmatic access to notification content
def main():
    app = Gtk.Application()
    app.connect('activate', lambda app: ToastNotificationIssues().show_all())
    app.run()
if __name__ == '__main__':
    main()

#!/usr/bin/env python3
"""
FormValidationWithoutAssociation - Linux GTK Implementation
"""
import gi
gi.require_version('Gtk', '3.0')
from gi.repository import Gtk, GObject, GLib
import threading
import time
class FormValidationWithoutAssociation(Gtk.Window):
    def __init__(self):
        self.set_default_size(600, 700)
        self.set_resizable(True)
        # State
        self.is_submitting = False
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
        # Login form
        form_box = Gtk.Box(orientation=Gtk.Orientation.VERTICAL, spacing=20)
        card_content.pack_start(form_box, False, False, 0)
        # Username field
        username_box = Gtk.Box(orientation=Gtk.Orientation.VERTICAL, spacing=5)
        form_box.pack_start(username_box, False, False, 0)
        self.username_entry = Gtk.Entry()
        self.username_entry.set_placeholder_text("Enter username")
        self.username_entry.connect("changed", self.on_username_changed)
        username_box.pack_start(self.username_entry, False, False, 0)
        # Password field
        password_box = Gtk.Box(orientation=Gtk.Orientation.VERTICAL, spacing=5)
        form_box.pack_start(password_box, False, False, 0)
        self.password_entry = Gtk.Entry()
        self.password_entry.set_placeholder_text("Enter password")
        self.password_entry.set_visibility(False)
        self.password_entry.connect("changed", self.on_password_changed)
        password_box.pack_start(self.password_entry, False, False, 0)
        # Generic Error Message - NOT ASSOCIATED WITH SPECIFIC FIELDS
        self.generic_error_frame = Gtk.Frame()
        self.generic_error_frame.set_visible(False)
        self.generic_error_frame.override_background_color(Gtk.StateFlags.NORMAL, Gtk.RGBA(0.9, 0.8, 0.8, 1.0))
        self.generic_error_frame.set_border_width(1)
        form_box.pack_start(self.generic_error_frame, False, False, 0)
        generic_error_content = Gtk.Box(orientation=Gtk.Orientation.HORIZONTAL, spacing=10)
        generic_error_content.set_margin_left(10)
        generic_error_content.set_margin_right(10)
        generic_error_content.set_margin_top(10)
        generic_error_content.set_margin_bottom(10)
        self.generic_error_frame.add(generic_error_content)
        error_icon.set_text("⚠")
        error_icon.override_color(Gtk.StateFlags.NORMAL, Gtk.RGBA(0.8, 0.2, 0.2, 1.0))
        generic_error_content.pack_start(error_icon, False, False, 0)
        # Login button
        self.login_button.set_size_request(-1, 40)
        self.login_button.connect("clicked", self.on_login_clicked)
        form_box.pack_start(self.login_button, False, False, 10)
        main_box.pack_start(main_card, False, False, 0)
        info_frame = Gtk.Frame()
        info_frame.set_shadow_type(Gtk.ShadowType.ETCHED_IN)
        info_content = Gtk.Box(orientation=Gtk.Orientation.VERTICAL, spacing=15)
        info_content.set_margin_left(20)
        info_content.set_margin_right(20)
        info_content.set_margin_top(20)
        info_content.set_margin_bottom(20)
        info_frame.add(info_content)
• Generic error: Generic error message doesn't specify which fields have issues
        issues_text.set_halign(Gtk.Align.START)
        issues_text.set_line_wrap(True)
        info_content.pack_start(issues_text, False, False, 0)
        # How to Fix
        fix_title.set_markup("<b>How to Fix:</b>")
        fix_title.set_halign(Gtk.Align.START)
        info_content.pack_start(fix_title, False, False, 0)
• Use specific error messages for each field
        fix_text.set_halign(Gtk.Align.START)
        fix_text.set_line_wrap(True)
        info_content.pack_start(fix_text, False, False, 0)
        parent_box.pack_start(info_frame, False, False, 0)
        # Basic setup only
        self.username_entry.set_name("username-input")
        self.password_entry.set_name("password-input")
        self.login_button.set_name("login-button")
    def on_username_changed(self, entry):
        self.clear_field_error("username")
    def on_password_changed(self, entry):
        self.clear_field_error("password")
    def on_login_clicked(self, button):
        if self.is_submitting:
            return
        self.clear_all_errors()
        username = self.username_entry.get_text().strip()
        password = self.password_entry.get_text()
        has_errors = False
        # Validate username
        if not username:
            self.show_field_error("username", "Username is required")
            has_errors = True
        elif len(username) < 3:
            self.show_field_error("username", "Username must be at least 3 characters")
            has_errors = True
        # Validate password
        if not password:
            self.show_field_error("password", "Password is required")
            has_errors = True
        elif len(password) < 8:
            self.show_field_error("password", "Password must be at least 8 characters")
            has_errors = True
        if has_errors:
            # Show generic error message - NOT ASSOCIATED WITH SPECIFIC FIELDS
            self.show_generic_error("Please fill in all required fields.")
            return
        # Simulate login process
        self.is_submitting = True
        self.login_button.set_sensitive(False)
        # Simulate API call
        def login_simulation():
            time.sleep(2)
            GLib.idle_add(self.login_complete)
        threading.Thread(target=login_simulation, daemon=True).start()
    def login_complete(self):
        self.is_submitting = False
        self.login_button.set_sensitive(True)
        # Show success dialog
        dialog = Gtk.MessageDialog(
            parent=self,
            flags=Gtk.DialogFlags.MODAL,
            type=Gtk.MessageType.INFO,
            buttons=Gtk.ButtonsType.OK,
            message_format="Login successful!"
        )
        dialog.run()
        dialog.destroy()
    def clear_all_errors(self):
        self.generic_error_frame.set_visible(False)
        # Reset field borders
        self.username_entry.override_background_color(Gtk.StateFlags.NORMAL, None)
        self.password_entry.override_background_color(Gtk.StateFlags.NORMAL, None)
    def clear_field_error(self, field_name):
        if field_name == "username":
            self.username_entry.override_background_color(Gtk.StateFlags.NORMAL, None)
        elif field_name == "password":
            self.password_entry.override_background_color(Gtk.StateFlags.NORMAL, None)
    def show_field_error(self, field_name, message):
        if field_name == "username":
            self.username_entry.override_background_color(Gtk.StateFlags.NORMAL, Gtk.RGBA(0.9, 0.8, 0.8, 1.0))
        elif field_name == "password":
            self.password_entry.override_background_color(Gtk.StateFlags.NORMAL, Gtk.RGBA(0.9, 0.8, 0.8, 1.0))
    def show_generic_error(self, message):
        self.generic_error_frame.set_visible(True)
def main():
    app = Gtk.Application()
    app.connect('activate', lambda app: FormValidationWithoutAssociation().show_all())
    app.run()
if __name__ == '__main__':
    main()

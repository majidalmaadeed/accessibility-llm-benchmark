#!/usr/bin/env python3
"""
"""
import gi
gi.require_version('Gtk', '3.0')
from gi.repository import Gtk, GObject, GLib
    def __init__(self):
        self.set_default_size(600, 700)
        self.set_resizable(True)
        # State
        self.is_modal_open = False
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
        # Open Modal Button
        self.open_modal_button.set_size_request(-1, 40)
        self.open_modal_button.connect("clicked", self.on_open_modal_clicked)
        card_content.pack_start(self.open_modal_button, False, False, 0)
        # Description
        desc_text.set_halign(Gtk.Align.START)
        desc_text.set_line_wrap(True)
        card_content.pack_start(desc_text, False, False, 0)
        main_box.pack_start(main_card, False, False, 0)
        # Modal Overlay
        self.modal_overlay = Gtk.Fixed()
        self.modal_overlay.set_visible(False)
        self.modal_overlay.override_background_color(Gtk.StateFlags.NORMAL, Gtk.RGBA(0, 0, 0, 0.5))
        main_box.pack_start(self.modal_overlay, True, True, 0)
        # Modal Dialog
        self.create_modal_dialog()
    def create_modal_dialog(self):
        # Modal container
        self.modal_dialog = Gtk.Frame()
        self.modal_dialog.set_size_request(500, 400)
        self.modal_dialog.set_shadow_type(Gtk.ShadowType.OUT)
        self.modal_dialog.set_halign(Gtk.Align.CENTER)
        self.modal_dialog.set_valign(Gtk.Align.CENTER)
        modal_content = Gtk.Box(orientation=Gtk.Orientation.VERTICAL, spacing=20)
        modal_content.set_margin_left(30)
        modal_content.set_margin_right(30)
        modal_content.set_margin_top(30)
        modal_content.set_margin_bottom(30)
        self.modal_dialog.add(modal_content)
        # Modal Header
        header_box = Gtk.Box(orientation=Gtk.Orientation.HORIZONTAL, spacing=0)
        modal_content.pack_start(header_box, False, False, 0)
        modal_title.set_markup("<span size='large' weight='bold'>Settings</span>")
        modal_title.set_halign(Gtk.Align.START)
        header_box.pack_start(modal_title, True, True, 0)
        self.close_modal_button.set_size_request(30, 30)
        self.close_modal_button.connect("clicked", self.on_close_modal_clicked)
        header_box.pack_start(self.close_modal_button, False, False, 0)
        # Settings Form
        settings_box = Gtk.Box(orientation=Gtk.Orientation.VERTICAL, spacing=20)
        modal_content.pack_start(settings_box, False, False, 0)
        # Theme Setting
        theme_box = Gtk.Box(orientation=Gtk.Orientation.VERTICAL, spacing=8)
        settings_box.pack_start(theme_box, False, False, 0)
        self.theme_combo = Gtk.ComboBoxText()
        self.theme_combo.append_text("Light")
        self.theme_combo.append_text("Dark")
        self.theme_combo.append_text("Auto")
        self.theme_combo.set_active(0)
        theme_box.pack_start(self.theme_combo, False, False, 0)
        # Language Setting
        language_box = Gtk.Box(orientation=Gtk.Orientation.VERTICAL, spacing=8)
        settings_box.pack_start(language_box, False, False, 0)
        self.language_combo = Gtk.ComboBoxText()
        self.language_combo.append_text("English")
        self.language_combo.append_text("Spanish")
        self.language_combo.append_text("French")
        self.language_combo.set_active(0)
        language_box.pack_start(self.language_combo, False, False, 0)
        # Notifications Setting
        notifications_box = Gtk.Box(orientation=Gtk.Orientation.VERTICAL, spacing=8)
        settings_box.pack_start(notifications_box, False, False, 0)
        self.notifications_combo = Gtk.ComboBoxText()
        self.notifications_combo.append_text("All")
        self.notifications_combo.append_text("Important Only")
        self.notifications_combo.append_text("None")
        self.notifications_combo.set_active(0)
        notifications_box.pack_start(self.notifications_combo, False, False, 0)
        # Modal Actions
        actions_box = Gtk.Box(orientation=Gtk.Orientation.HORIZONTAL, spacing=10)
        actions_box.set_halign(Gtk.Align.END)
        modal_content.pack_start(actions_box, False, False, 20)
        self.cancel_button.set_size_request(100, 32)
        self.cancel_button.connect("clicked", self.on_cancel_clicked)
        actions_box.pack_start(self.cancel_button, False, False, 0)
        self.save_button.set_size_request(100, 32)
        self.save_button.connect("clicked", self.on_save_clicked)
        actions_box.pack_start(self.save_button, False, False, 0)
        # Add modal to overlay
        self.modal_overlay.put(self.modal_dialog, 0, 0)
        info_frame = Gtk.Frame()
        info_frame.set_shadow_type(Gtk.ShadowType.ETCHED_IN)
        info_content = Gtk.Box(orientation=Gtk.Orientation.VERTICAL, spacing=15)
        info_content.set_margin_left(20)
        info_content.set_margin_right(20)
        info_content.set_margin_top(20)
        info_content.set_margin_bottom(20)
        info_frame.add(info_content)
• Escape key not handled: Modal doesn't close when Escape is pressed""")
        issues_text.set_halign(Gtk.Align.START)
        issues_text.set_line_wrap(True)
        info_content.pack_start(issues_text, False, False, 0)
        # How to Fix
        fix_title.set_markup("<b>How to Fix:</b>")
        fix_title.set_halign(Gtk.Align.START)
        info_content.pack_start(fix_title, False, False, 0)
• Handle Escape key to close modal""")
        fix_text.set_halign(Gtk.Align.START)
        fix_text.set_line_wrap(True)
        info_content.pack_start(fix_text, False, False, 0)
        parent_box.pack_start(info_frame, False, False, 0)
        # Basic setup only
        self.open_modal_button.set_name("open-modal-button")
        self.close_modal_button.set_name("close-modal-button")
        self.save_button.set_name("save-button")
        self.cancel_button.set_name("cancel-button")
    def on_open_modal_clicked(self, button):
        if self.is_modal_open:
            return
        # Show modal
        self.modal_overlay.set_visible(True)
        self.is_modal_open = True
        # Should handle Escape key to close modal
    def on_close_modal_clicked(self, button):
        self.close_modal()
    def on_cancel_clicked(self, button):
        self.close_modal()
    def on_save_clicked(self, button):
        # Simulate saving settings
        dialog = Gtk.MessageDialog(
            parent=self,
            flags=Gtk.DialogFlags.MODAL,
            type=Gtk.MessageType.INFO,
            buttons=Gtk.ButtonsType.OK,
            message_format="Settings saved successfully!"
        )
        dialog.run()
        dialog.destroy()
        self.close_modal()
    def close_modal(self):
        if not self.is_modal_open:
            return
        # Hide modal
        self.modal_overlay.set_visible(False)
        self.is_modal_open = False
        else:
    def do_key_press_event(self, event):
        # Should close modal when Escape key is pressed
        # Should only work when modal is open
        if event.keyval == Gtk.KEY_Escape and self.is_modal_open:
            self.close_modal()
            return True
        return super().do_key_press_event(event)
    # Should implement methods to:
def main():
    app = Gtk.Application()
    app.run()
if __name__ == '__main__':
    main()

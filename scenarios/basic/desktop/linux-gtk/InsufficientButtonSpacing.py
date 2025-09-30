import gi
gi.require_version('Gtk', '3.0')
from gi.repository import Gtk, GObject, GLib

class InsufficientButtonSpacing(Gtk.Window):
    def __init__(self):
        Gtk.Window.__init__(self, title="Document Editor")
        self.set_default_size(800, 600)
        self.set_border_width(10)
        
        # Main container
        main_box = Gtk.VBox(spacing=0)
        self.add(main_box)
        
        # Toolbar
        toolbar_box = Gtk.HBox(spacing=2)  # INSUFFICIENT BUTTON SPACING - Action buttons placed 2px apart
        toolbar_box.set_margin_top(10)
        toolbar_box.set_margin_bottom=10
        toolbar_box.set_halign(Gtk.Align.CENTER)
        
        # Action Buttons - INSUFFICIENT BUTTON SPACING
        action_buttons = [
            ("Save", self.on_save_clicked, "suggested-action"),
            ("Edit", self.on_edit_clicked, ""),
            ("Delete", self.on_delete_clicked, ""),
            ("Share", self.on_share_clicked, ""),
            ("Print", self.on_print_clicked, "")
        ]
        
        for label, callback, style_class in action_buttons:
            button = Gtk.Button(label)
            button.set_size_request(80, 40)
            if style_class:
                button.get_style_context().add_class(style_class)
            button.connect("clicked", callback)
            toolbar_box.pack_start(button, False, False, 0)
        
        main_box.pack_start(toolbar_box, False, False, 0)
        
        # Formatting toolbar
        formatting_box = Gtk.HBox(spacing=2)  # INSUFFICIENT BUTTON SPACING - Formatting buttons placed 2px apart
        formatting_box.set_margin_bottom=10
        formatting_box.set_halign(Gtk.Align.CENTER)
        
        # Formatting Options - INSUFFICIENT BUTTON SPACING
        formatting_buttons = [
            ("B", self.on_bold_clicked, "Bold"),
            ("I", self.on_italic_clicked, "Italic"),
            ("U", self.on_underline_clicked, "Underline"),
            ("A", self.on_align_left_clicked, "Align Left"),
            ("A", self.on_align_center_clicked, "Align Center"),
            ("A", self.on_align_right_clicked, "Align Right")
        ]
        
        for label, callback, tooltip in formatting_buttons:
            button = Gtk.Button(label)
            button.set_size_request(40, 40)
            button.set_tooltip_text(tooltip)
            button.connect("clicked", callback)
            toolbar_box.pack_start(button, False, False, 0)
        
        main_box.pack_start(formatting_box, False, False, 0)
        
        # Quick actions toolbar
        quick_actions_box = Gtk.HBox(spacing=2)  # INSUFFICIENT BUTTON SPACING - Quick action buttons placed 2px apart
        quick_actions_box.set_margin_bottom=10
        quick_actions_box.set_halign(Gtk.Align.CENTER)
        
        # Quick Actions - INSUFFICIENT BUTTON SPACING
        quick_actions = [
            ("📄", self.on_new_document_clicked, "New Document"),
            ("📁", self.on_open_folder_clicked, "Open Folder"),
            ("💾", self.on_save_clicked, "Save"),
            ("🖨️", self.on_print_clicked, "Print"),
            ("📤", self.on_export_clicked, "Export"),
            ("🔍", self.on_search_clicked, "Search")
        ]
        
        for icon, callback, tooltip in quick_actions:
            button = Gtk.Button(icon)
            button.set_size_request(40, 40)
            button.set_tooltip_text(tooltip)
            button.connect("clicked", callback)
            quick_actions_box.pack_start(button, False, False, 0)
        
        main_box.pack_start(quick_actions_box, False, False, 0)
        
        # Document content area
        content_frame = Gtk.Frame()
        content_frame.set_shadow_type(Gtk.ShadowType.ETCHED_IN)
        
        content_box = Gtk.VBox(spacing=10)
        content_box.set_margin_left(20)
        content_box.set_margin_right(20)
        content_box.set_margin_top(20)
        content_box.set_margin_bottom(20)
        content_frame.add(content_box)
        
        # Document title
        title_label = Gtk.Label()
        title_label.set_markup("<span size='x-large' weight='bold'>Sample Document</span>")
        title_label.set_halign(Gtk.Align.START)
        content_box.pack_start(title_label, False, False, 0)
        
        # Document content
        content_text = Gtk.TextView()
        content_text.set_wrap_mode(Gtk.WrapMode.WORD)
        content_text.get_buffer().set_text("This is a sample document content. You can edit this text when in edit mode. The document contains various sections and formatting options.")
        content_text.set_size_request(-1, 300)
        content_box.pack_start(content_text, True, True, 0)
        
        main_box.pack_start(content_frame, True, True, 0)
        
        # Status bar
        status_box = Gtk.HBox(spacing=10)
        status_box.set_margin_top(10)
        
        status_label = Gtk.Label("Ready")
        status_box.pack_start(status_label, False, False, 0)
        
        word_count_label = Gtk.Label("Words: 25")
        word_count_label.set_halign(Gtk.Align.END)
        status_box.pack_start(word_count_label, True, True, 0)
        
        main_box.pack_start(status_box, False, False, 0)
        
        # State
        self.is_editing = False
        self.is_deleting = False
        
    # Action button methods
    def on_save_clicked(self, button):
        dialog = Gtk.MessageDialog(
            transient_for=self,
            flags=0,
            message_type=Gtk.MessageType.INFO,
            buttons=Gtk.ButtonsType.OK,
            text="Save Document"
        )
        dialog.format_secondary_text("Document saved successfully!")
        dialog.run()
        dialog.destroy()
    
    def on_edit_clicked(self, button):
        self.is_editing = not self.is_editing
        if self.is_editing:
            button.set_label("Done")
        else:
            button.set_label("Edit")
        
        dialog = Gtk.MessageDialog(
            transient_for=self,
            flags=0,
            message_type=Gtk.MessageType.INFO,
            buttons=Gtk.ButtonsType.OK,
            text="Edit Mode"
        )
        dialog.format_secondary_text(f"Edit mode: {'ON' if self.is_editing else 'OFF'}")
        dialog.run()
        dialog.destroy()
    
    def on_delete_clicked(self, button):
        self.is_deleting = not self.is_deleting
        dialog = Gtk.MessageDialog(
            transient_for=self,
            flags=0,
            message_type=Gtk.MessageType.INFO,
            buttons=Gtk.ButtonsType.OK,
            text="Delete Document"
        )
        dialog.format_secondary_text("Document deleted!" if self.is_deleting else "Are you sure you want to delete this document?")
        dialog.run()
        dialog.destroy()
    
    def on_share_clicked(self, button):
        dialog = Gtk.MessageDialog(
            transient_for=self,
            flags=0,
            message_type=Gtk.MessageType.INFO,
            buttons=Gtk.ButtonsType.OK,
            text="Share Document"
        )
        dialog.format_secondary_text("Document shared successfully!")
        dialog.run()
        dialog.destroy()
    
    def on_print_clicked(self, button):
        dialog = Gtk.MessageDialog(
            transient_for=self,
            flags=0,
            message_type=Gtk.MessageType.INFO,
            buttons=Gtk.ButtonsType.OK,
            text="Print Document"
        )
        dialog.format_secondary_text("Document sent to printer!")
        dialog.run()
        dialog.destroy()
    
    # Formatting button methods
    def on_bold_clicked(self, button):
        dialog = Gtk.MessageDialog(
            transient_for=self,
            flags=0,
            message_type=Gtk.MessageType.INFO,
            buttons=Gtk.ButtonsType.OK,
            text="Bold Formatting"
        )
        dialog.format_secondary_text("Bold formatting applied!")
        dialog.run()
        dialog.destroy()
    
    def on_italic_clicked(self, button):
        dialog = Gtk.MessageDialog(
            transient_for=self,
            flags=0,
            message_type=Gtk.MessageType.INFO,
            buttons=Gtk.ButtonsType.OK,
            text="Italic Formatting"
        )
        dialog.format_secondary_text("Italic formatting applied!")
        dialog.run()
        dialog.destroy()
    
    def on_underline_clicked(self, button):
        dialog = Gtk.MessageDialog(
            transient_for=self,
            flags=0,
            message_type=Gtk.MessageType.INFO,
            buttons=Gtk.ButtonsType.OK,
            text="Underline Formatting"
        )
        dialog.format_secondary_text("Underline formatting applied!")
        dialog.run()
        dialog.destroy()
    
    def on_align_left_clicked(self, button):
        dialog = Gtk.MessageDialog(
            transient_for=self,
            flags=0,
            message_type=Gtk.MessageType.INFO,
            buttons=Gtk.ButtonsType.OK,
            text="Align Left"
        )
        dialog.format_secondary_text("Text aligned to left!")
        dialog.run()
        dialog.destroy()
    
    def on_align_center_clicked(self, button):
        dialog = Gtk.MessageDialog(
            transient_for=self,
            flags=0,
            message_type=Gtk.MessageType.INFO,
            buttons=Gtk.ButtonsType.OK,
            text="Align Center"
        )
        dialog.format_secondary_text("Text aligned to center!")
        dialog.run()
        dialog.destroy()
    
    def on_align_right_clicked(self, button):
        dialog = Gtk.MessageDialog(
            transient_for=self,
            flags=0,
            message_type=Gtk.MessageType.INFO,
            buttons=Gtk.ButtonsType.OK,
            text="Align Right"
        )
        dialog.format_secondary_text("Text aligned to right!")
        dialog.run()
        dialog.destroy()
    
    # Quick action button methods
    def on_new_document_clicked(self, button):
        dialog = Gtk.MessageDialog(
            transient_for=self,
            flags=0,
            message_type=Gtk.MessageType.INFO,
            buttons=Gtk.ButtonsType.OK,
            text="New Document"
        )
        dialog.format_secondary_text("New document created!")
        dialog.run()
        dialog.destroy()
    
    def on_open_folder_clicked(self, button):
        dialog = Gtk.MessageDialog(
            transient_for=self,
            flags=0,
            message_type=Gtk.MessageType.INFO,
            buttons=Gtk.ButtonsType.OK,
            text="Open Folder"
        )
        dialog.format_secondary_text("Folder opened!")
        dialog.run()
        dialog.destroy()
    
    def on_export_clicked(self, button):
        dialog = Gtk.MessageDialog(
            transient_for=self,
            flags=0,
            message_type=Gtk.MessageType.INFO,
            buttons=Gtk.ButtonsType.OK,
            text="Export Document"
        )
        dialog.format_secondary_text("Document exported successfully!")
        dialog.run()
        dialog.destroy()
    
    def on_search_clicked(self, button):
        dialog = Gtk.MessageDialog(
            transient_for=self,
            flags=0,
            message_type=Gtk.MessageType.INFO,
            buttons=Gtk.ButtonsType.OK,
            text="Search Document"
        )
        dialog.format_secondary_text("Search functionality activated!")
        dialog.run()
        dialog.destroy()

def main():
    win = InsufficientButtonSpacing()
    win.connect("destroy", Gtk.main_quit)
    win.show_all()
    Gtk.main()

if __name__ == "__main__":
    main()

import gi
gi.require_version('Gtk', '3.0')
from gi.repository import Gtk, GObject, GLib

class RightClickOnlyMenu(Gtk.Window):
    def __init__(self):
        Gtk.Window.__init__(self, title="File Manager")
        self.set_default_size(800, 600)
        self.set_border_width(10)
        
        # Main container
        main_box = Gtk.VBox(spacing=0)
        self.add(main_box)
        
        # Toolbar
        toolbar_box = Gtk.HBox(spacing=10)
        toolbar_box.set_margin_top(10)
        toolbar_box.set_margin_bottom=10)
        toolbar_box.set_halign(Gtk.Align.CENTER)
        
        # Toolbar buttons
        toolbar_buttons = [
            ("📁", "New Folder", self.on_new_folder_clicked),
            ("📄", "New File", self.on_new_file_clicked),
            ("📤", "Upload", self.on_upload_clicked),
            ("📥", "Download", self.on_download_clicked)
        ]
        
        for icon, tooltip, callback in toolbar_buttons:
            button = Gtk.Button(icon)
            button.set_size_request(50, 50)
            button.set_tooltip_text(tooltip)
            button.connect("clicked", callback)
            toolbar_box.pack_start(button, False, False, 0)
        
        main_box.pack_start(toolbar_box, False, False, 0)
        
        # Files section
        files_label = Gtk.Label()
        files_label.set_markup("<span size='x-large' weight='bold'>Files</span>")
        files_label.set_halign(Gtk.Align.START)
        files_label.set_margin_left(20)
        files_label.set_margin_top(20)
        files_label.set_margin_bottom(10)
        main_box.pack_start(files_label, False, False, 0)
        
        # Files scrollable area
        scrolled_window = Gtk.ScrolledWindow()
        scrolled_window.set_policy(Gtk.PolicyType.AUTOMATIC, Gtk.PolicyType.AUTOMATIC)
        
        # Files list
        self.files_box = Gtk.VBox(spacing=10)
        self.files_box.set_margin_left(20)
        self.files_box.set_margin_right(20)
        self.files_box.set_margin_bottom=20)
        
        scrolled_window.add(self.files_box)
        main_box.pack_start(scrolled_window, True, True, 0)
        
        # Status bar
        status_box = Gtk.HBox(spacing=10)
        status_box.set_margin_top(10)
        
        self.selected_item_label = Gtk.Label("No item selected")
        status_box.pack_start(self.selected_item_label, False, False, 0)
        
        status_label = Gtk.Label("Ready")
        status_label.set_halign(Gtk.Align.END)
        status_box.pack_start(status_label, True, True, 0)
        
        main_box.pack_start(status_box, False, False, 0)
        
        # Load files
        self.load_files()
        
    def load_files(self):
        files = [
            {
                "name": "document.pdf",
                "type": "PDF",
                "size": "2.5 MB",
                "last_modified": "2 hours ago",
                "is_folder": False
            },
            {
                "name": "Projects",
                "type": "Folder",
                "size": "15 items",
                "last_modified": "1 day ago",
                "is_folder": True
            },
            {
                "name": "image.jpg",
                "type": "JPEG",
                "size": "1.2 MB",
                "last_modified": "3 hours ago",
                "is_folder": False
            },
            {
                "name": "spreadsheet.xlsx",
                "type": "Excel",
                "size": "850 KB",
                "last_modified": "1 day ago",
                "is_folder": False
            },
            {
                "name": "audio.mp3",
                "type": "MP3",
                "size": "4.2 MB",
                "last_modified": "2 days ago",
                "is_folder": False
            }
        ]
        
        for file in files:
            file_frame = self.create_file_card(file)
            self.files_box.pack_start(file_frame, False, False, 0)
    
    def create_file_card(self, file):
        # File frame
        frame = Gtk.Frame()
        frame.set_shadow_type(Gtk.ShadowType.ETCHED_IN)
        
        main_box = Gtk.HBox(spacing=15)
        main_box.set_margin_left(15)
        main_box.set_margin_right(15)
        main_box.set_margin_top(15)
        main_box.set_margin_bottom(15)
        frame.add(main_box)
        
        # File icon
        icon = Gtk.Image()
        if file["is_folder"]:
            icon.set_from_icon_name("folder", Gtk.IconSize.BUTTON)
        else:
            icon.set_from_icon_name("text-x-generic", Gtk.IconSize.BUTTON)
        icon.set_pixel_size(40)
        main_box.pack_start(icon, False, False, 0)
        
        # File info
        info_box = Gtk.VBox(spacing=5)
        
        # File name
        name_label = Gtk.Label()
        name_label.set_markup(f"<span weight='bold' size='large'>{file['name']}</span>")
        name_label.set_halign(Gtk.Align.START)
        info_box.pack_start(name_label, False, False, 0)
        
        # File details
        details_label = Gtk.Label(f"{file['type']} • {file['size']} • Modified {file['last_modified']}")
        details_label.set_halign(Gtk.Align.START)
        info_box.pack_start(details_label, False, False, 0)
        
        main_box.pack_start(info_box, True, True, 0)
        
        # Action buttons
        actions_box = Gtk.HBox(spacing=10)
        
        view_button = Gtk.Button("👁️")
        view_button.set_size_request(40, 40)
        view_button.connect("clicked", self.on_view_clicked, file)
        actions_box.pack_start(view_button, False, False, 0)
        
        edit_button = Gtk.Button("✏️")
        edit_button.set_size_request(40, 40)
        edit_button.connect("clicked", self.on_edit_clicked, file)
        actions_box.pack_start(edit_button, False, False, 0)
        
        download_button = Gtk.Button("📤")
        download_button.set_size_request(40, 40)
        download_button.connect("clicked", self.on_download_clicked, file)
        actions_box.pack_start(download_button, False, False, 0)
        
        main_box.pack_start(actions_box, False, False, 0)
        
        # RIGHT-CLICK ONLY MENU - Essential delete option only available via right-click
        frame.connect("button-press-event", self.on_file_right_clicked, file)
        
        return frame
    
    def on_file_right_clicked(self, widget, event, file):
        if event.button == 3:  # Right click
            # RIGHT-CLICK ONLY MENU - Essential delete option only available via right-click
            menu = Gtk.Menu()
            
            # Open item
            open_item = Gtk.MenuItem("Open")
            open_item.connect("activate", self.on_context_open, file)
            menu.append(open_item)
            
            # Rename item
            rename_item = Gtk.MenuItem("Rename")
            rename_item.connect("activate", self.on_context_rename, file)
            menu.append(rename_item)
            
            # Copy item
            copy_item = Gtk.MenuItem("Copy")
            copy_item.connect("activate", self.on_context_copy, file)
            menu.append(copy_item)
            
            # Move item
            move_item = Gtk.MenuItem("Move")
            move_item.connect("activate", self.on_context_move, file)
            menu.append(move_item)
            
            # Separator
            separator = Gtk.SeparatorMenuItem()
            menu.append(separator)
            
            # RIGHT-CLICK ONLY MENU - Essential delete option only available via right-click
            delete_item = Gtk.MenuItem("Delete")
            delete_item.connect("activate", self.on_context_delete, file)
            menu.append(delete_item)
            
            menu.show_all()
            menu.popup(None, None, None, None, event.button, event.time)
    
    def on_context_open(self, menuitem, file):
        self.show_file_details(file)
    
    def on_context_rename(self, menuitem, file):
        dialog = Gtk.MessageDialog(
            transient_for=self,
            flags=0,
            message_type=Gtk.MessageType.INFO,
            buttons=Gtk.ButtonsType.OK,
            text="Rename File"
        )
        dialog.format_secondary_text(f"Rename: {file['name']}")
        dialog.run()
        dialog.destroy()
    
    def on_context_copy(self, menuitem, file):
        dialog = Gtk.MessageDialog(
            transient_for=self,
            flags=0,
            message_type=Gtk.MessageType.INFO,
            buttons=Gtk.ButtonsType.OK,
            text="Copy File"
        )
        dialog.format_secondary_text(f"Copy: {file['name']}")
        dialog.run()
        dialog.destroy()
    
    def on_context_move(self, menuitem, file):
        dialog = Gtk.MessageDialog(
            transient_for=self,
            flags=0,
            message_type=Gtk.MessageType.INFO,
            buttons=Gtk.ButtonsType.OK,
            text="Move File"
        )
        dialog.format_secondary_text(f"Move: {file['name']}")
        dialog.run()
        dialog.destroy()
    
    def on_context_delete(self, menuitem, file):
        # RIGHT-CLICK ONLY MENU - Essential delete option only available via right-click
        dialog = Gtk.MessageDialog(
            transient_for=self,
            flags=0,
            message_type=Gtk.MessageType.QUESTION,
            buttons=Gtk.ButtonsType.YES_NO,
            text="Delete File"
        )
        dialog.format_secondary_text(f"Are you sure you want to delete '{file['name']}'? This action cannot be undone.")
        
        response = dialog.run()
        if response == Gtk.ResponseType.YES:
            # Handle delete
            dialog = Gtk.MessageDialog(
                transient_for=self,
                flags=0,
                message_type=Gtk.MessageType.INFO,
                buttons=Gtk.ButtonsType.OK,
                text="File Deleted"
            )
            dialog.format_secondary_text(f"'{file['name']}' has been deleted.")
            dialog.run()
            dialog.destroy()
        
        dialog.destroy()
    
    def on_view_clicked(self, button, file):
        self.show_file_details(file)
    
    def on_edit_clicked(self, button, file):
        dialog = Gtk.MessageDialog(
            transient_for=self,
            flags=0,
            message_type=Gtk.MessageType.INFO,
            buttons=Gtk.ButtonsType.OK,
            text="Edit File"
        )
        dialog.format_secondary_text(f"Edit: {file['name']}")
        dialog.run()
        dialog.destroy()
    
    def on_download_clicked(self, button, file):
        dialog = Gtk.MessageDialog(
            transient_for=self,
            flags=0,
            message_type=Gtk.MessageType.INFO,
            buttons=Gtk.ButtonsType.OK,
            text="Download File"
        )
        dialog.format_secondary_text(f"Download: {file['name']}")
        dialog.run()
        dialog.destroy()
    
    def show_file_details(self, file):
        dialog = Gtk.MessageDialog(
            transient_for=self,
            flags=0,
            message_type=Gtk.MessageType.INFO,
            buttons=Gtk.ButtonsType.OK,
            text="File Details"
        )
        dialog.format_secondary_text(f"""
Name: {file['name']}
Type: {file['type']}
Size: {file['size']}
Last Modified: {file['last_modified']}
        """)
        dialog.run()
        dialog.destroy()
    
    def on_new_folder_clicked(self, button):
        dialog = Gtk.MessageDialog(
            transient_for=self,
            flags=0,
            message_type=Gtk.MessageType.INFO,
            buttons=Gtk.ButtonsType.OK,
            text="New Folder"
        )
        dialog.format_secondary_text("New folder created!")
        dialog.run()
        dialog.destroy()
    
    def on_new_file_clicked(self, button):
        dialog = Gtk.MessageDialog(
            transient_for=self,
            flags=0,
            message_type=Gtk.MessageType.INFO,
            buttons=Gtk.ButtonsType.OK,
            text="New File"
        )
        dialog.format_secondary_text("New file created!")
        dialog.run()
        dialog.destroy()
    
    def on_upload_clicked(self, button):
        dialog = Gtk.MessageDialog(
            transient_for=self,
            flags=0,
            message_type=Gtk.MessageType.INFO,
            buttons=Gtk.ButtonsType.OK,
            text="Upload Files"
        )
        dialog.format_secondary_text("Upload functionality activated!")
        dialog.run()
        dialog.destroy()
    
    def on_download_clicked(self, button):
        dialog = Gtk.MessageDialog(
            transient_for=self,
            flags=0,
            message_type=Gtk.MessageType.INFO,
            buttons=Gtk.ButtonsType.OK,
            text="Download Files"
        )
        dialog.format_secondary_text("Download functionality activated!")
        dialog.run()
        dialog.destroy()

def main():
    win = RightClickOnlyMenu()
    win.connect("destroy", Gtk.main_quit)
    win.show_all()
    Gtk.main()

if __name__ == "__main__":
    main()

import gi
gi.require_version('Gtk', '3.0')
from gi.repository import Gtk, GObject, GLib

class StatusByShapeOnly(Gtk.Window):
    def __init__(self):
        Gtk.Window.__init__(self, title="Document Management System")
        self.set_default_size(1000, 600)
        self.set_border_width(10)
        
        # Main container
        main_box = Gtk.VBox(spacing=10)
        self.add(main_box)
        
        # Header
        header_box = Gtk.VBox(spacing=10)
        header_box.set_halign(Gtk.Align.CENTER)
        
        title_label = Gtk.Label()
        title_label.set_markup("<span size='xx-large' weight='bold'>Document Management System</span>")
        header_box.pack_start(title_label, False, False, 0)
        
        subtitle_label = Gtk.Label("Review and approve documents")
        subtitle_label.set_markup("<span size='large'>Review and approve documents</span>")
        header_box.pack_start(subtitle_label, False, False, 0)
        
        main_box.pack_start(header_box, False, False, 0)
        
        # Filter options
        filter_box = Gtk.HBox(spacing=10)
        filter_box.set_halign(Gtk.Align.CENTER)
        
        filter_buttons = [
            ("All", True),
            ("Pending", False),
            ("Approved", False),
            ("Rejected", False)
        ]
        
        for label, is_active in filter_buttons:
            button = Gtk.Button(label)
            if is_active:
                button.get_style_context().add_class("suggested-action")
            button.connect("clicked", self.on_filter_clicked, label)
            filter_box.pack_start(button, False, False, 0)
        
        main_box.pack_start(filter_box, False, False, 0)
        
        # Documents section
        documents_label = Gtk.Label()
        documents_label.set_markup("<span size='x-large' weight='bold'>Documents</span>")
        documents_label.set_halign(Gtk.Align.START)
        documents_label.set_margin_left(20)
        documents_label.set_margin_top(20)
        documents_label.set_margin_bottom(10)
        main_box.pack_start(documents_label, False, False, 0)
        
        # Documents scrollable area
        scrolled_window = Gtk.ScrolledWindow()
        scrolled_window.set_policy(Gtk.PolicyType.AUTOMATIC, Gtk.PolicyType.AUTOMATIC)
        
        # Documents list
        self.documents_box = Gtk.VBox(spacing=10)
        self.documents_box.set_margin_left(20)
        self.documents_box.set_margin_right(20)
        self.documents_box.set_margin_bottom=20
        
        scrolled_window.add(self.documents_box)
        main_box.pack_start(scrolled_window, True, True, 0)
        
        # Status bar
        status_box = Gtk.HBox(spacing=10)
        status_box.set_margin_top(10)
        
        self.total_label = Gtk.Label("Total Documents: 4")
        self.total_label.set_markup("<span weight='bold'>Total Documents: 4</span>")
        status_box.pack_start(self.total_label, False, False, 0)
        
        sort_info_label = Gtk.Label("Sort by: Name ↓")
        sort_info_label.set_halign(Gtk.Align.END)
        status_box.pack_start(sort_info_label, True, True, 0)
        
        main_box.pack_start(status_box, False, False, 0)
        
        # Load documents
        self.load_documents()
        
    def load_documents(self):
        documents = [
            {
                "name": "Project Proposal Q1 2024",
                "department": "Marketing",
                "size": "2.5 MB",
                "type": "PDF",
                "last_modified": "2024-01-15 14:30",
                "status": "pending"
            },
            {
                "name": "Budget Report 2023",
                "department": "Finance",
                "size": "1.8 MB",
                "type": "Excel",
                "last_modified": "2024-01-12 09:15",
                "status": "approved"
            },
            {
                "name": "Employee Handbook v2.1",
                "department": "HR",
                "size": "3.2 MB",
                "type": "PDF",
                "last_modified": "2024-01-10 16:45",
                "status": "rejected"
            },
            {
                "name": "Technical Specifications",
                "department": "Engineering",
                "size": "4.1 MB",
                "type": "PDF",
                "last_modified": "2024-01-08 11:20",
                "status": "pending"
            }
        ]
        
        for document in documents:
            document_frame = self.create_document_card(document)
            self.documents_box.pack_start(document_frame, False, False, 0)
    
    def create_document_card(self, document):
        # Document frame
        frame = Gtk.Frame()
        frame.set_shadow_type(Gtk.ShadowType.ETCHED_IN)
        
        main_box = Gtk.HBox(spacing=15)
        main_box.set_margin_left(15)
        main_box.set_margin_right(15)
        main_box.set_margin_top(15)
        main_box.set_margin_bottom(15)
        frame.add(main_box)
        
        # STATUS BY SHAPE ONLY - Document approval status indicated only by circle vs square shape
        status_container = Gtk.VBox()
        status_container.set_size_request(30, 30)
        
        status_shape = Gtk.DrawingArea()
        status_shape.set_size_request(24, 24)
        status_shape.connect("draw", self.draw_status_shape, document["status"])
        status_container.pack_start(status_shape, True, True, 0)
        
        main_box.pack_start(status_container, False, False, 0)
        
        # Document info
        info_box = Gtk.VBox(spacing=5)
        
        # Document name
        name_label = Gtk.Label()
        name_label.set_markup(f"<span weight='bold' size='large'>{document['name']}</span>")
        name_label.set_halign(Gtk.Align.START)
        info_box.pack_start(name_label, False, False, 0)
        
        # Document details
        details_label = Gtk.Label(f"{document['department']} • {document['size']} • {document['type']}")
        details_label.set_halign(Gtk.Align.START)
        info_box.pack_start(details_label, False, False, 0)
        
        # Last modified
        modified_label = Gtk.Label(f"Last modified: {document['last_modified']}")
        modified_label.set_halign(Gtk.Align.START)
        info_box.pack_start(modified_label, False, False, 0)
        
        main_box.pack_start(info_box, True, True, 0)
        
        # Actions
        actions_box = Gtk.HBox(spacing=10)
        
        view_button = Gtk.Button("👁️")
        view_button.set_size_request(40, 40)
        view_button.connect("clicked", self.on_view_clicked, document)
        actions_box.pack_start(view_button, False, False, 0)
        
        edit_button = Gtk.Button("✏️")
        edit_button.set_size_request(40, 40)
        edit_button.connect("clicked", self.on_edit_clicked, document)
        actions_box.pack_start(edit_button, False, False, 0)
        
        download_button = Gtk.Button("📤")
        download_button.set_size_request(40, 40)
        download_button.connect("clicked", self.on_download_clicked, document)
        actions_box.pack_start(download_button, False, False, 0)
        
        main_box.pack_start(actions_box, False, False, 0)
        
        return frame
    
    def draw_status_shape(self, widget, cr, status):
        # STATUS BY SHAPE ONLY - Document approval status indicated only by circle vs square shape
        width = widget.get_allocated_width()
        height = widget.get_allocated_height()
        
        if status == "approved":
            # STATUS BY SHAPE ONLY - Approved status shown as square
            cr.set_source_rgb(0.0, 0.8, 0.0)  # Green
            cr.rectangle(2, 2, width - 4, height - 4)
            cr.fill()
        elif status == "rejected":
            # STATUS BY SHAPE ONLY - Rejected status shown as circle
            cr.set_source_rgb(0.8, 0.0, 0.0)  # Red
            cr.arc(width / 2, height / 2, (width - 4) / 2, 0, 2 * 3.14159)
            cr.fill()
        else:  # pending
            # STATUS BY SHAPE ONLY - Pending status shown as circle
            cr.set_source_rgb(0.8, 0.8, 0.0)  # Yellow
            cr.arc(width / 2, height / 2, (width - 4) / 2, 0, 2 * 3.14159)
            cr.fill()
        
        return True
    
    def on_filter_clicked(self, button, filter_type):
        # Update filter buttons
        for child in button.get_parent().get_children():
            if isinstance(child, Gtk.Button):
                child.get_style_context().remove_class("suggested-action")
        button.get_style_context().add_class("suggested-action")
        
        # Filter documents based on type
        # This is a simplified implementation
        pass
    
    def on_view_clicked(self, button, document):
        dialog = Gtk.MessageDialog(
            transient_for=self,
            flags=0,
            message_type=Gtk.MessageType.INFO,
            buttons=Gtk.ButtonsType.OK,
            text="Document Details"
        )
        dialog.format_secondary_text(f"""
Name: {document['name']}
Department: {document['department']}
Size: {document['size']}
Type: {document['type']}
Last Modified: {document['last_modified']}
Status: {document['status']}
        """)
        dialog.run()
        dialog.destroy()
    
    def on_edit_clicked(self, button, document):
        dialog = Gtk.MessageDialog(
            transient_for=self,
            flags=0,
            message_type=Gtk.MessageType.INFO,
            buttons=Gtk.ButtonsType.OK,
            text="Edit Document"
        )
        dialog.format_secondary_text(f"Edit: {document['name']}")
        dialog.run()
        dialog.destroy()
    
    def on_download_clicked(self, button, document):
        dialog = Gtk.MessageDialog(
            transient_for=self,
            flags=0,
            message_type=Gtk.MessageType.INFO,
            buttons=Gtk.ButtonsType.OK,
            text="Download Document"
        )
        dialog.format_secondary_text(f"Download: {document['name']}")
        dialog.run()
        dialog.destroy()

def main():
    win = StatusByShapeOnly()
    win.connect("destroy", Gtk.main_quit)
    win.show_all()
    Gtk.main()

if __name__ == "__main__":
    main()

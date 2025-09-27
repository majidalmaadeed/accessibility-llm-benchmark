#!/usr/bin/env python3

import gi
gi.require_version('Gtk', '3.0')
from gi.repository import Gtk, Gdk, Pango, Gio
import os

class RichTextEditor(Gtk.Window):
    def __init__(self):
        Gtk.Window.__init__(self, title="Rich Text Editor")
        self.set_default_size(1200, 800)
        self.set_border_width(0)
        
        # Data
        self.current_file = None
        self.undo_stack = []
        self.redo_stack = []
        self.current_zoom = 100
        self.is_bold = False
        self.is_italic = False
        self.is_underlined = False
        self.font_size = 16
        self.font_family = "Arial"
        self.text_color = Gdk.RGBA(0, 0, 0, 1)
        self.bg_color = Gdk.RGBA(1, 1, 1, 1)
        self.alignment = Pango.Alignment.LEFT
        
        # Create UI
        self.create_ui()
        
        # Update statistics
        self.update_statistics()
    
    def create_ui(self):
        # Main container
        main_box = Gtk.Box(orientation=Gtk.Orientation.VERTICAL, spacing=0)
        self.add(main_box)
        
        # Menu bar
        menubar = self.create_menu_bar()
        main_box.pack_start(menubar, False, False, 0)
        
        # Toolbar
        toolbar = self.create_toolbar()
        main_box.pack_start(toolbar, False, False, 0)
        
        # Main content area
        content_box = Gtk.Box(orientation=Gtk.Orientation.HORIZONTAL, spacing=0)
        main_box.pack_start(content_box, True, True, 0)
        
        # Text editor
        self.create_text_editor(content_box)
        
        # Side panel
        self.create_side_panel(content_box)
        
        # Status bar
        self.create_status_bar(main_box)
    
    def create_menu_bar(self):
        menubar = Gtk.MenuBar()
        
        # File menu
        file_menu = Gtk.Menu()
        file_item = Gtk.MenuItem("File")
        file_item.set_submenu(file_menu)
        
        new_item = Gtk.MenuItem("New")
        new_item.connect("activate", self.on_new)
        file_menu.append(new_item)
        
        open_item = Gtk.MenuItem("Open")
        open_item.connect("activate", self.on_open)
        file_menu.append(open_item)
        
        save_item = Gtk.MenuItem("Save")
        save_item.connect("activate", self.on_save)
        file_menu.append(save_item)
        
        save_as_item = Gtk.MenuItem("Save As")
        save_as_item.connect("activate", self.on_save_as)
        file_menu.append(save_as_item)
        
        file_menu.append(Gtk.SeparatorMenuItem())
        
        export_menu = Gtk.Menu()
        export_item = Gtk.MenuItem("Export")
        export_item.set_submenu(export_menu)
        
        pdf_item = Gtk.MenuItem("PDF")
        pdf_item.connect("activate", self.on_export_pdf)
        export_menu.append(pdf_item)
        
        word_item = Gtk.MenuItem("Word Document")
        word_item.connect("activate", self.on_export_word)
        export_menu.append(word_item)
        
        html_item = Gtk.MenuItem("HTML")
        html_item.connect("activate", self.on_export_html)
        export_menu.append(html_item)
        
        file_menu.append(export_item)
        
        menubar.append(file_item)
        
        # Edit menu
        edit_menu = Gtk.Menu()
        edit_item = Gtk.MenuItem("Edit")
        edit_item.set_submenu(edit_menu)
        
        undo_item = Gtk.MenuItem("Undo")
        undo_item.connect("activate", self.on_undo)
        edit_menu.append(undo_item)
        
        redo_item = Gtk.MenuItem("Redo")
        redo_item.connect("activate", self.on_redo)
        edit_menu.append(redo_item)
        
        edit_menu.append(Gtk.SeparatorMenuItem())
        
        cut_item = Gtk.MenuItem("Cut")
        cut_item.connect("activate", self.on_cut)
        edit_menu.append(cut_item)
        
        copy_item = Gtk.MenuItem("Copy")
        copy_item.connect("activate", self.on_copy)
        edit_menu.append(copy_item)
        
        paste_item = Gtk.MenuItem("Paste")
        paste_item.connect("activate", self.on_paste)
        edit_menu.append(paste_item)
        
        menubar.append(edit_item)
        
        # Format menu
        format_menu = Gtk.Menu()
        format_item = Gtk.MenuItem("Format")
        format_item.set_submenu(format_menu)
        
        font_item = Gtk.MenuItem("Font")
        font_item.connect("activate", self.on_font)
        format_menu.append(font_item)
        
        paragraph_item = Gtk.MenuItem("Paragraph")
        paragraph_item.connect("activate", self.on_paragraph)
        format_menu.append(paragraph_item)
        
        styles_item = Gtk.MenuItem("Styles")
        styles_item.connect("activate", self.on_styles)
        format_menu.append(styles_item)
        
        menubar.append(format_item)
        
        # View menu
        view_menu = Gtk.Menu()
        view_item = Gtk.MenuItem("View")
        view_item.set_submenu(view_menu)
        
        zoom_in_item = Gtk.MenuItem("Zoom In")
        zoom_in_item.connect("activate", self.on_zoom_in)
        view_menu.append(zoom_in_item)
        
        zoom_out_item = Gtk.MenuItem("Zoom Out")
        zoom_out_item.connect("activate", self.on_zoom_out)
        view_menu.append(zoom_out_item)
        
        reset_zoom_item = Gtk.MenuItem("Reset Zoom")
        reset_zoom_item.connect("activate", self.on_reset_zoom)
        view_menu.append(reset_zoom_item)
        
        menubar.append(view_item)
        
        return menubar
    
    def create_toolbar(self):
        toolbar = Gtk.Toolbar()
        toolbar.set_style(Gtk.ToolbarStyle.ICONS)
        
        # File operations
        new_btn = Gtk.ToolButton.new_from_stock(Gtk.STOCK_NEW)
        new_btn.connect("clicked", self.on_new)
        toolbar.insert(new_btn, -1)
        
        open_btn = Gtk.ToolButton.new_from_stock(Gtk.STOCK_OPEN)
        open_btn.connect("clicked", self.on_open)
        toolbar.insert(open_btn, -1)
        
        save_btn = Gtk.ToolButton.new_from_stock(Gtk.STOCK_SAVE)
        save_btn.connect("clicked", self.on_save)
        toolbar.insert(save_btn, -1)
        
        toolbar.insert(Gtk.SeparatorToolItem(), -1)
        
        # Undo/Redo
        undo_btn = Gtk.ToolButton.new_from_stock(Gtk.STOCK_UNDO)
        undo_btn.connect("clicked", self.on_undo)
        toolbar.insert(undo_btn, -1)
        
        redo_btn = Gtk.ToolButton.new_from_stock(Gtk.STOCK_REDO)
        redo_btn.connect("clicked", self.on_redo)
        toolbar.insert(redo_btn, -1)
        
        toolbar.insert(Gtk.SeparatorToolItem(), -1)
        
        # Formatting
        bold_btn = Gtk.ToggleToolButton()
        bold_btn.set_label("B")
        bold_btn.set_tooltip_text("Bold")
        bold_btn.connect("toggled", self.on_bold_toggled)
        toolbar.insert(bold_btn, -1)
        
        italic_btn = Gtk.ToggleToolButton()
        italic_btn.set_label("I")
        italic_btn.set_tooltip_text("Italic")
        italic_btn.connect("toggled", self.on_italic_toggled)
        toolbar.insert(italic_btn, -1)
        
        underline_btn = Gtk.ToggleToolButton()
        underline_btn.set_label("U")
        underline_btn.set_tooltip_text("Underline")
        underline_btn.connect("toggled", self.on_underline_toggled)
        toolbar.insert(underline_btn, -1)
        
        toolbar.insert(Gtk.SeparatorToolItem(), -1)
        
        # Font size
        font_size_combo = Gtk.ComboBoxText()
        font_sizes = [8, 9, 10, 11, 12, 14, 16, 18, 20, 24, 28, 32, 36, 48, 72]
        for size in font_sizes:
            font_size_combo.append_text(str(size))
        font_size_combo.set_active(font_sizes.index(16))
        font_size_combo.connect("changed", self.on_font_size_changed)
        
        font_size_item = Gtk.ToolItem()
        font_size_item.add(font_size_combo)
        toolbar.insert(font_size_item, -1)
        
        # Font family
        font_family_combo = Gtk.ComboBoxText()
        font_families = ["Arial", "Calibri", "Times New Roman", "Courier New", "Georgia", "Verdana", "Tahoma"]
        for family in font_families:
            font_family_combo.append_text(family)
        font_family_combo.set_active(0)
        font_family_combo.connect("changed", self.on_font_family_changed)
        
        font_family_item = Gtk.ToolItem()
        font_family_item.add(font_family_combo)
        toolbar.insert(font_family_item, -1)
        
        toolbar.insert(Gtk.SeparatorToolItem(), -1)
        
        # Colors
        text_color_btn = Gtk.ColorButton()
        text_color_btn.set_rgba(self.text_color)
        text_color_btn.connect("color-set", self.on_text_color_changed)
        toolbar.insert(text_color_btn, -1)
        
        bg_color_btn = Gtk.ColorButton()
        bg_color_btn.set_rgba(self.bg_color)
        bg_color_btn.connect("color-set", self.on_bg_color_changed)
        toolbar.insert(bg_color_btn, -1)
        
        toolbar.insert(Gtk.SeparatorToolItem(), -1)
        
        # Alignment
        align_left_btn = Gtk.ToggleToolButton()
        align_left_btn.set_label("⬅")
        align_left_btn.set_tooltip_text("Align Left")
        align_left_btn.connect("toggled", self.on_align_left)
        toolbar.insert(align_left_btn, -1)
        
        align_center_btn = Gtk.ToggleToolButton()
        align_center_btn.set_label("⬆")
        align_center_btn.set_tooltip_text("Align Center")
        align_center_btn.connect("toggled", self.on_align_center)
        toolbar.insert(align_center_btn, -1)
        
        align_right_btn = Gtk.ToggleToolButton()
        align_right_btn.set_label("➡")
        align_right_btn.set_tooltip_text("Align Right")
        align_right_btn.connect("toggled", self.on_align_right)
        toolbar.insert(align_right_btn, -1)
        
        align_justify_btn = Gtk.ToggleToolButton()
        align_justify_btn.set_label("⬌")
        align_justify_btn.set_tooltip_text("Justify")
        align_justify_btn.connect("toggled", self.on_align_justify)
        toolbar.insert(align_justify_btn, -1)
        
        toolbar.insert(Gtk.SeparatorToolItem(), -1)
        
        # Lists
        bullet_btn = Gtk.ToolButton()
        bullet_btn.set_label("•")
        bullet_btn.set_tooltip_text("Bullet List")
        bullet_btn.connect("clicked", self.on_bullet_list)
        toolbar.insert(bullet_btn, -1)
        
        numbered_btn = Gtk.ToolButton()
        numbered_btn.set_label("1.")
        numbered_btn.set_tooltip_text("Numbered List")
        numbered_btn.connect("clicked", self.on_numbered_list)
        toolbar.insert(numbered_btn, -1)
        
        toolbar.insert(Gtk.SeparatorToolItem(), -1)
        
        # Insert
        image_btn = Gtk.ToolButton()
        image_btn.set_label("🖼")
        image_btn.set_tooltip_text("Insert Image")
        image_btn.connect("clicked", self.on_insert_image)
        toolbar.insert(image_btn, -1)
        
        table_btn = Gtk.ToolButton()
        table_btn.set_label("⊞")
        table_btn.set_tooltip_text("Insert Table")
        table_btn.connect("clicked", self.on_insert_table)
        toolbar.insert(table_btn, -1)
        
        link_btn = Gtk.ToolButton()
        link_btn.set_label("🔗")
        link_btn.set_tooltip_text("Insert Link")
        link_btn.connect("clicked", self.on_insert_link)
        toolbar.insert(link_btn, -1)
        
        return toolbar
    
    def create_text_editor(self, parent):
        # Scrolled window for text view
        scrolled = Gtk.ScrolledWindow()
        scrolled.set_hexpand(True)
        scrolled.set_vexpand(True)
        
        # Text view
        self.text_view = Gtk.TextView()
        self.text_view.set_wrap_mode(Gtk.WrapMode.WORD)
        self.text_view.connect("key-press-event", self.on_key_press)
        self.text_view.connect("button-press-event", self.on_button_press)
        
        # Text buffer
        self.text_buffer = self.text_view.get_buffer()
        self.text_buffer.connect("changed", self.on_text_changed)
        
        # Set initial font
        self.update_font()
        
        scrolled.add(self.text_view)
        parent.pack_start(scrolled, True, True, 0)
    
    def create_side_panel(self, parent):
        side_panel = Gtk.Box(orientation=Gtk.Orientation.VERTICAL, spacing=16)
        side_panel.set_size_request(250, -1)
        side_panel.set_margin_start(8)
        side_panel.set_margin_end(8)
        side_panel.set_margin_top(8)
        side_panel.set_margin_bottom(8)
        
        # Document Statistics
        stats_frame = Gtk.Frame(label="Document Statistics")
        stats_box = Gtk.Box(orientation=Gtk.Orientation.VERTICAL, spacing=8)
        stats_box.set_margin_start(8)
        stats_box.set_margin_end(8)
        stats_box.set_margin_top(8)
        stats_box.set_margin_bottom(8)
        
        self.word_count_label = Gtk.Label("Words: 0")
        self.char_count_label = Gtk.Label("Characters: 0")
        self.para_count_label = Gtk.Label("Paragraphs: 0")
        
        stats_box.pack_start(self.word_count_label, False, False, 0)
        stats_box.pack_start(self.char_count_label, False, False, 0)
        stats_box.pack_start(self.para_count_label, False, False, 0)
        
        stats_frame.add(stats_box)
        side_panel.pack_start(stats_frame, False, False, 0)
        
        # Quick Styles
        styles_frame = Gtk.Frame(label="Quick Styles")
        styles_box = Gtk.Box(orientation=Gtk.Orientation.VERTICAL, spacing=8)
        styles_box.set_margin_start(8)
        styles_box.set_margin_end(8)
        styles_box.set_margin_top(8)
        styles_box.set_margin_bottom(8)
        
        h1_btn = Gtk.Button(label="Heading 1")
        h1_btn.connect("clicked", self.on_heading1)
        styles_box.pack_start(h1_btn, False, False, 0)
        
        h2_btn = Gtk.Button(label="Heading 2")
        h2_btn.connect("clicked", self.on_heading2)
        styles_box.pack_start(h2_btn, False, False, 0)
        
        h3_btn = Gtk.Button(label="Heading 3")
        h3_btn.connect("clicked", self.on_heading3)
        styles_box.pack_start(h3_btn, False, False, 0)
        
        normal_btn = Gtk.Button(label="Normal")
        normal_btn.connect("clicked", self.on_normal)
        styles_box.pack_start(normal_btn, False, False, 0)
        
        styles_frame.add(styles_box)
        side_panel.pack_start(styles_frame, False, False, 0)
        
        # Recent Files
        recent_frame = Gtk.Frame(label="Recent Files")
        recent_box = Gtk.Box(orientation=Gtk.Orientation.VERTICAL, spacing=4)
        recent_box.set_margin_start(8)
        recent_box.set_margin_end(8)
        recent_box.set_margin_top(8)
        recent_box.set_margin_bottom(8)
        
        recent_files = ["Document1.docx", "Report.docx", "Notes.docx"]
        for file in recent_files:
            file_btn = Gtk.Button(label=file)
            file_btn.set_halign(Gtk.Align.START)
            file_btn.connect("clicked", self.on_recent_file_clicked, file)
            recent_box.pack_start(file_btn, False, False, 0)
        
        recent_frame.add(recent_box)
        side_panel.pack_start(recent_frame, False, False, 0)
        
        # Zoom Control
        zoom_frame = Gtk.Frame(label="Zoom")
        zoom_box = Gtk.Box(orientation=Gtk.Orientation.HORIZONTAL, spacing=8)
        zoom_box.set_margin_start(8)
        zoom_box.set_margin_end(8)
        zoom_box.set_margin_top(8)
        zoom_box.set_margin_bottom(8)
        
        zoom_out_btn = Gtk.Button(label="-")
        zoom_out_btn.connect("clicked", self.on_zoom_out)
        zoom_box.pack_start(zoom_out_btn, False, False, 0)
        
        self.zoom_label = Gtk.Label("100%")
        self.zoom_label.set_hexpand(True)
        self.zoom_label.set_halign(Gtk.Align.CENTER)
        zoom_box.pack_start(self.zoom_label, True, True, 0)
        
        zoom_in_btn = Gtk.Button(label="+")
        zoom_in_btn.connect("clicked", self.on_zoom_in)
        zoom_box.pack_start(zoom_in_btn, False, False, 0)
        
        zoom_frame.add(zoom_box)
        side_panel.pack_start(zoom_frame, False, False, 0)
        
        parent.pack_start(side_panel, False, False, 0)
    
    def create_status_bar(self, parent):
        status_box = Gtk.Box(orientation=Gtk.Orientation.HORIZONTAL, spacing=8)
        status_box.set_margin_start(8)
        status_box.set_margin_end(8)
        status_box.set_margin_top(4)
        status_box.set_margin_bottom(4)
        
        self.status_label = Gtk.Label("Ready")
        status_box.pack_start(self.status_label, True, True, 0)
        
        self.position_label = Gtk.Label("Position: 0")
        status_box.pack_start(self.position_label, False, False, 0)
        
        parent.pack_start(status_box, False, False, 0)
    
    def update_font(self):
        font_desc = Pango.FontDescription(f"{self.font_family} {self.font_size}")
        self.text_view.override_font(font_desc)
    
    def update_statistics(self):
        text = self.text_buffer.get_text(self.text_buffer.get_start_iter(), self.text_buffer.get_end_iter(), False)
        words = len(text.split())
        characters = len(text)
        paragraphs = len([p for p in text.split('\n') if p.strip()])
        
        self.word_count_label.set_text(f"Words: {words}")
        self.char_count_label.set_text(f"Characters: {characters}")
        self.para_count_label.set_text(f"Paragraphs: {paragraphs}")
    
    def save_to_undo_stack(self):
        text = self.text_buffer.get_text(self.text_buffer.get_start_iter(), self.text_buffer.get_end_iter(), False)
        self.undo_stack.append(text)
        self.redo_stack.clear()
        
        if len(self.undo_stack) > 50:
            self.undo_stack.pop(0)
    
    # Event handlers
    def on_text_changed(self, buffer):
        self.update_statistics()
        self.save_to_undo_stack()
    
    def on_key_press(self, widget, event):
        # Handle keyboard shortcuts
        if event.state & Gdk.ModifierType.CONTROL_MASK:
            if event.keyval == Gdk.KEY_z:
                self.on_undo(None)
                return True
            elif event.keyval == Gdk.KEY_y:
                self.on_redo(None)
                return True
            elif event.keyval == Gdk.KEY_n:
                self.on_new(None)
                return True
            elif event.keyval == Gdk.KEY_o:
                self.on_open(None)
                return True
            elif event.keyval == Gdk.KEY_s:
                self.on_save(None)
                return True
        return False
    
    def on_button_press(self, widget, event):
        # Update position in status bar
        iter = self.text_view.get_iter_at_position(int(event.x), int(event.y))[1]
        if iter:
            offset = iter.get_offset()
            self.position_label.set_text(f"Position: {offset}")
        return False
    
    def on_new(self, widget):
        self.text_buffer.set_text("")
        self.undo_stack.clear()
        self.redo_stack.clear()
        self.current_file = None
    
    def on_open(self, widget):
        dialog = Gtk.FileChooserDialog("Open File", self, Gtk.FileChooserAction.OPEN,
                                     (Gtk.STOCK_CANCEL, Gtk.ResponseType.CANCEL,
                                      Gtk.STOCK_OPEN, Gtk.ResponseType.OK))
        
        filter_text = Gtk.FileFilter()
        filter_text.set_name("Text files")
        filter_text.add_pattern("*.txt")
        filter_text.add_pattern("*.rtf")
        dialog.add_filter(filter_text)
        
        response = dialog.run()
        if response == Gtk.ResponseType.OK:
            filename = dialog.get_filename()
            try:
                with open(filename, 'r', encoding='utf-8') as f:
                    content = f.read()
                self.text_buffer.set_text(content)
                self.current_file = filename
            except Exception as e:
                self.show_error_dialog(f"Error opening file: {e}")
        dialog.destroy()
    
    def on_save(self, widget):
        if self.current_file:
            self.save_to_file(self.current_file)
        else:
            self.on_save_as(widget)
    
    def on_save_as(self, widget):
        dialog = Gtk.FileChooserDialog("Save File", self, Gtk.FileChooserAction.SAVE,
                                     (Gtk.STOCK_CANCEL, Gtk.ResponseType.CANCEL,
                                      Gtk.STOCK_SAVE, Gtk.ResponseType.OK))
        
        filter_text = Gtk.FileFilter()
        filter_text.set_name("Text files")
        filter_text.add_pattern("*.txt")
        filter_text.add_pattern("*.rtf")
        dialog.add_filter(filter_text)
        
        response = dialog.run()
        if response == Gtk.ResponseType.OK:
            filename = dialog.get_filename()
            self.save_to_file(filename)
            self.current_file = filename
        dialog.destroy()
    
    def save_to_file(self, filename):
        try:
            content = self.text_buffer.get_text(self.text_buffer.get_start_iter(), self.text_buffer.get_end_iter(), False)
            with open(filename, 'w', encoding='utf-8') as f:
                f.write(content)
        except Exception as e:
            self.show_error_dialog(f"Error saving file: {e}")
    
    def on_undo(self, widget):
        if len(self.undo_stack) > 1:
            self.redo_stack.append(self.undo_stack.pop())
            text = self.undo_stack[-1]
            self.text_buffer.set_text(text)
    
    def on_redo(self, widget):
        if self.redo_stack:
            text = self.redo_stack.pop()
            self.undo_stack.append(text)
            self.text_buffer.set_text(text)
    
    def on_bold_toggled(self, widget):
        self.is_bold = widget.get_active()
        self.apply_formatting()
    
    def on_italic_toggled(self, widget):
        self.is_italic = widget.get_active()
        self.apply_formatting()
    
    def on_underline_toggled(self, widget):
        self.is_underlined = widget.get_active()
        self.apply_formatting()
    
    def apply_formatting(self):
        # In a real implementation, this would apply formatting to selected text
        pass
    
    def on_font_size_changed(self, widget):
        self.font_size = int(widget.get_active_text())
        self.update_font()
    
    def on_font_family_changed(self, widget):
        self.font_family = widget.get_active_text()
        self.update_font()
    
    def on_text_color_changed(self, widget):
        self.text_color = widget.get_rgba()
        # Apply color to selected text
    
    def on_bg_color_changed(self, widget):
        self.bg_color = widget.get_rgba()
        # Apply background color to selected text
    
    def on_align_left(self, widget):
        if widget.get_active():
            self.alignment = Pango.Alignment.LEFT
            self.update_alignment()
    
    def on_align_center(self, widget):
        if widget.get_active():
            self.alignment = Pango.Alignment.CENTER
            self.update_alignment()
    
    def on_align_right(self, widget):
        if widget.get_active():
            self.alignment = Pango.Alignment.RIGHT
            self.update_alignment()
    
    def on_align_justify(self, widget):
        if widget.get_active():
            self.alignment = Pango.Alignment.LEFT  # GTK doesn't have justify
            self.update_alignment()
    
    def update_alignment(self):
        # Apply alignment to selected text
        pass
    
    def on_bullet_list(self, widget):
        # Insert bullet list
        self.text_buffer.insert_at_cursor("\n• List item\n")
    
    def on_numbered_list(self, widget):
        # Insert numbered list
        self.text_buffer.insert_at_cursor("\n1. List item\n")
    
    def on_insert_image(self, widget):
        dialog = Gtk.FileChooserDialog("Select Image", self, Gtk.FileChooserAction.OPEN,
                                     (Gtk.STOCK_CANCEL, Gtk.ResponseType.CANCEL,
                                      Gtk.STOCK_OPEN, Gtk.ResponseType.OK))
        
        filter_image = Gtk.FileFilter()
        filter_image.set_name("Image files")
        filter_image.add_pattern("*.png")
        filter_image.add_pattern("*.jpg")
        filter_image.add_pattern("*.jpeg")
        filter_image.add_pattern("*.gif")
        dialog.add_filter(filter_image)
        
        response = dialog.run()
        if response == Gtk.ResponseType.OK:
            filename = dialog.get_filename()
            self.text_buffer.insert_at_cursor(f"[Image: {os.path.basename(filename)}]")
        dialog.destroy()
    
    def on_insert_table(self, widget):
        self.text_buffer.insert_at_cursor("\n[Table placeholder - 3x3]\n")
    
    def on_insert_link(self, widget):
        dialog = Gtk.Dialog("Insert Link", self, 0,
                           (Gtk.STOCK_CANCEL, Gtk.ResponseType.CANCEL,
                            Gtk.STOCK_OK, Gtk.ResponseType.OK))
        
        dialog.set_default_size(300, 150)
        
        content_area = dialog.get_content_area()
        content_area.set_spacing(16)
        
        # Link text
        text_label = Gtk.Label("Link Text:")
        text_label.set_halign(Gtk.Align.START)
        content_area.pack_start(text_label, False, False, 0)
        
        text_entry = Gtk.Entry()
        content_area.pack_start(text_entry, False, False, 0)
        
        # URL
        url_label = Gtk.Label("URL:")
        url_label.set_halign(Gtk.Align.START)
        content_area.pack_start(url_label, False, False, 0)
        
        url_entry = Gtk.Entry()
        content_area.pack_start(url_entry, False, False, 0)
        
        dialog.show_all()
        
        response = dialog.run()
        if response == Gtk.ResponseType.OK:
            link_text = text_entry.get_text()
            url = url_entry.get_text()
            self.text_buffer.insert_at_cursor(f"[{link_text}]({url})")
        dialog.destroy()
    
    def on_heading1(self, widget):
        self.font_size = 24
        self.is_bold = True
        self.update_font()
    
    def on_heading2(self, widget):
        self.font_size = 20
        self.is_bold = True
        self.update_font()
    
    def on_heading3(self, widget):
        self.font_size = 18
        self.is_bold = True
        self.update_font()
    
    def on_normal(self, widget):
        self.font_size = 16
        self.is_bold = False
        self.is_italic = False
        self.update_font()
    
    def on_recent_file_clicked(self, widget, filename):
        # In a real implementation, this would open the recent file
        self.status_label.set_text(f"Opening {filename}")
    
    def on_zoom_in(self, widget):
        self.current_zoom = min(self.current_zoom + 10, 200)
        self.update_zoom()
    
    def on_zoom_out(self, widget):
        self.current_zoom = max(self.current_zoom - 10, 50)
        self.update_zoom()
    
    def on_reset_zoom(self, widget):
        self.current_zoom = 100
        self.update_zoom()
    
    def update_zoom(self):
        self.zoom_label.set_text(f"{self.current_zoom}%")
        # Apply zoom to text view
    
    def on_cut(self, widget):
        self.text_view.cut_clipboard()
    
    def on_copy(self, widget):
        self.text_view.copy_clipboard()
    
    def on_paste(self, widget):
        self.text_view.paste_clipboard()
    
    def on_font(self, widget):
        dialog = Gtk.FontChooserDialog("Select Font", self)
        response = dialog.run()
        if response == Gtk.ResponseType.OK:
            font_desc = dialog.get_font_desc()
            self.font_family = font_desc.get_family()
            self.font_size = font_desc.get_size() / Pango.SCALE
            self.update_font()
        dialog.destroy()
    
    def on_paragraph(self, widget):
        # Paragraph dialog
        pass
    
    def on_styles(self, widget):
        # Styles dialog
        pass
    
    def on_export_pdf(self, widget):
        self.show_info_dialog("PDF export functionality would be implemented here.")
    
    def on_export_word(self, widget):
        self.show_info_dialog("Word export functionality would be implemented here.")
    
    def on_export_html(self, widget):
        self.show_info_dialog("HTML export functionality would be implemented here.")
    
    def show_error_dialog(self, message):
        dialog = Gtk.MessageDialog(self, 0, Gtk.MessageType.ERROR, Gtk.ButtonsType.OK, message)
        dialog.run()
        dialog.destroy()
    
    def show_info_dialog(self, message):
        dialog = Gtk.MessageDialog(self, 0, Gtk.MessageType.INFO, Gtk.ButtonsType.OK, message)
        dialog.run()
        dialog.destroy()

def main():
    app = RichTextEditor()
    app.connect("destroy", Gtk.main_quit)
    app.show_all()
    Gtk.main()

if __name__ == "__main__":
    main()

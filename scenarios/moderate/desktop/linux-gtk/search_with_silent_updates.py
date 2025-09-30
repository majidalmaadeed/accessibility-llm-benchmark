#!/usr/bin/env python3
import gi
gi.require_version('Gtk', '3.0')
from gi.repository import Gtk, GObject, GLib
import threading
import time
class SearchResult:
    def __init__(self, id, title, category, author):
        self.id = id
        self.title = title
        self.category = category
        self.author = author
class SearchWithSilentUpdatesWindow(Gtk.Window):
    def __init__(self):
        super().__init__(title="Search Interface")
        self.set_default_size(1000, 800)
        self.set_border_width(20)
        # Data properties
        self.suggestions = []
        self.results = []
        self.is_loading = False
        self.show_suggestions = False
        self.active_suggestion_index = -1
        self.mock_data = [
            SearchResult(1, "React Development Guide", "Books", "John Doe"),
            SearchResult(2, "Vue.js Tutorial", "Books", "Jane Smith"),
            SearchResult(3, "Angular Framework", "Books", "Bob Johnson"),
            SearchResult(4, "JavaScript Fundamentals", "Books", "Alice Brown"),
            SearchResult(5, "React Components", "Tutorials", "Charlie Wilson"),
            SearchResult(6, "Vue Components", "Tutorials", "Diana Lee"),
            SearchResult(7, "Angular Services", "Tutorials", "Eve Davis"),
            SearchResult(8, "JavaScript ES6", "Tutorials", "Frank Miller")
        ]
        self.setup_ui()
    def setup_ui(self):
        # Main container
        main_box = Gtk.Box(orientation=Gtk.Orientation.VERTICAL, spacing=20)
        self.add(main_box)
        # Main content card
        content_frame = Gtk.Frame()
        content_frame.set_shadow_type(Gtk.ShadowType.OUT)
        content_box = Gtk.Box(orientation=Gtk.Orientation.VERTICAL, spacing=20)
        content_box.set_margin_left(30)
        content_box.set_margin_right(30)
        content_box.set_margin_top(30)
        content_box.set_margin_bottom(30)
        content_frame.add(content_box)
        main_box.pack_start(content_frame, True, True, 0)
        # Title
        # Subtitle
        # Search section
        search_box = Gtk.Box(orientation=Gtk.Orientation.VERTICAL, spacing=8)
        content_box.pack_start(search_box, False, False, 0)
        # Search input container
        input_container = Gtk.Box(orientation=Gtk.Orientation.VERTICAL, spacing=4)
        search_box.pack_start(input_container, False, False, 0)
        # Search entry
        self.search_entry = Gtk.Entry()
        self.search_entry.set_placeholder_text("Type to search...")
        self.search_entry.set_size_request(-1, 44)
        self.search_entry.connect("changed", self.on_search_text_changed)
        self.search_entry.connect("key-press-event", self.on_search_key_press)
        input_container.pack_start(self.search_entry, False, False, 0)
        self.suggestions_list = Gtk.ListBox()
        self.suggestions_list.set_size_request(-1, 200)
        self.suggestions_list.set_visible(False)
        self.suggestions_list.connect("row-activated", self.on_suggestion_selected)
        input_container.pack_start(self.suggestions_list, False, False, 0)
        # Search button
        self.search_button.set_size_request(-1, 44)
        self.search_button.set_sensitive(False)
        self.search_button.connect("clicked", self.on_search_button_clicked)
        search_box.pack_start(self.search_button, False, False, 0)
        # Results section
        results_box = Gtk.Box(orientation=Gtk.Orientation.VERTICAL, spacing=16)
        content_box.pack_start(results_box, False, False, 0)
        # Results title
        results_title.set_markup("<span size='20000' weight='bold' color='#333333'>Search Results</span>")
        results_box.pack_start(results_title, False, False, 0)
        # Loading state
        self.loading_box = Gtk.Box(orientation=Gtk.Orientation.HORIZONTAL, spacing=16)
        self.loading_box.set_homogeneous(True)
        self.loading_box.set_visible(False)
        self.loading_spinner = Gtk.Spinner()
        self.loading_spinner.start()
        self.loading_box.pack_start(self.loading_spinner, False, False, 0)
        results_box.pack_start(self.loading_box, False, False, 0)
        # Results count
        # Results list
        self.results_list = Gtk.ListBox()
        self.results_list.set_size_request(-1, 300)
        self.results_list.set_visible(False)
        results_box.pack_start(self.results_list, False, False, 0)
        # No results state
        # Empty state
    def on_search_text_changed(self, entry):
        query = entry.get_text()
        if len(query) > 1:
            filtered = [item for item in self.mock_data 
                       if query.lower() in item.title.lower() or 
                          query.lower() in item.category.lower() or 
                          query.lower() in item.author.lower()]
            self.suggestions = filtered[:5]
            self.show_suggestions = True
            self.active_suggestion_index = -1
            self.update_suggestions()
        else:
            self.suggestions = []
            self.show_suggestions = False
            self.active_suggestion_index = -1
            self.hide_suggestions()
        self.search_button.set_sensitive(bool(query.strip()) and not self.is_loading)
    def on_search_key_press(self, widget, event):
        if event.keyval == Gtk.KEY_Return:
            self.perform_search()
            return True
        elif event.keyval == Gtk.KEY_Escape:
            self.hide_suggestions()
            return True
        return False
    def on_search_button_clicked(self, button):
        self.perform_search()
    def on_suggestion_selected(self, listbox, row):
        if row and row.get_index() < len(self.suggestions):
            suggestion = self.suggestions[row.get_index()]
            self.search_entry.set_text(suggestion.title)
            self.hide_suggestions()
            self.perform_search()
    def update_suggestions(self):
        # Clear existing suggestions
        for child in self.suggestions_list.get_children():
            self.suggestions_list.remove(child)
        if self.suggestions:
            for suggestion in self.suggestions:
                row = Gtk.ListBoxRow()
                box = Gtk.Box(orientation=Gtk.Orientation.VERTICAL, spacing=4)
                box.set_margin_left(12)
                box.set_margin_right(12)
                box.set_margin_top(12)
                box.set_margin_bottom(12)
                row.add(box)
                self.suggestions_list.add(row)
            self.suggestions_list.set_visible(True)
            self.suggestions_list.show_all()
        else:
            self.hide_suggestions()
    def hide_suggestions(self):
        self.suggestions_list.set_visible(False)
    def perform_search(self):
        if self.is_loading:
            return
        query = self.search_entry.get_text().strip()
        if not query:
            return
        self.is_loading = True
        self.search_button.set_sensitive(False)
        # Hide all result states
        self.loading_box.set_visible(True)
        self.results_list.set_visible(False)
        self.hide_suggestions()
        # Simulate API call in a separate thread
        def search_thread():
            time.sleep(1)  # Simulate API delay
            filtered = [item for item in self.mock_data 
                       if query.lower() in item.title.lower() or 
                          query.lower() in item.category.lower() or 
                          query.lower() in item.author.lower()]
            # Update UI in main thread
            GLib.idle_add(self.update_search_results, filtered, query)
        threading.Thread(target=search_thread, daemon=True).start()
    def update_search_results(self, filtered_results, query):
        self.results = filtered_results
        self.is_loading = False
        self.search_button.set_sensitive(True)
        self.loading_box.set_visible(False)
        if self.results:
            # Clear existing results
            for child in self.results_list.get_children():
                self.results_list.remove(child)
            # Add new results
            for result in self.results:
                row = Gtk.ListBoxRow()
                box = Gtk.Box(orientation=Gtk.Orientation.VERTICAL, spacing=8)
                box.set_margin_left(16)
                box.set_margin_right(16)
                box.set_margin_top(16)
                box.set_margin_bottom(16)
                row.add(box)
                self.results_list.add(row)
            self.results_list.set_visible(True)
            self.results_list.show_all()
        else:
def main():
    win = SearchWithSilentUpdatesWindow()
    win.connect("destroy", Gtk.main_quit)
    win.show_all()
    Gtk.main()
if __name__ == "__main__":
    main()
#!/usr/bin/env python3

import gi
gi.require_version('Gtk', '3.0')
from gi.repository import Gtk, Gdk, Pango
from datetime import datetime

class InteractiveMap(Gtk.Window):
    def __init__(self):
        Gtk.Window.__init__(self, title="Interactive Map")
        self.set_default_size(1200, 800)
        self.set_border_width(0)
        
        # Data
        self.all_locations = []
        self.search_results = []
        self.bookmarks = []
        self.current_map_type = "Standard"
        self.current_zoom = 10
        self.center_lat = 37.7749
        self.center_lng = -122.4194
        self.show_user_location = True
        self.traffic_enabled = False
        self.transit_enabled = False
        self.bike_lanes_enabled = False
        self.selected_location = None
        
        # Load sample data
        self.load_sample_data()
        
        # Create UI
        self.create_ui()
    
    def create_ui(self):
        # Main container
        main_box = Gtk.Box(orientation=Gtk.Orientation.VERTICAL, spacing=0)
        self.add(main_box)
        
        # Header
        header_box = self.create_header()
        main_box.pack_start(header_box, False, False, 0)
        
        # Search bar
        search_box = self.create_search_bar()
        main_box.pack_start(search_box, False, False, 0)
        
        # Main content
        content_box = Gtk.Box(orientation=Gtk.Orientation.HORIZONTAL, spacing=0)
        main_box.pack_start(content_box, True, True, 0)
        
        # Map area
        self.create_map_area(content_box)
        
        # Side panel
        self.create_side_panel(content_box)
        
        # Status bar
        status_box = self.create_status_bar()
        main_box.pack_start(status_box, False, False, 0)
    
    def create_header(self):
        header_box = Gtk.Box(orientation=Gtk.Orientation.HORIZONTAL, spacing=12)
        header_box.set_margin_bottom(16)
        
        # Title
        title_label = Gtk.Label()
        title_label.set_markup("<span size='xx-large' weight='bold' foreground='white'>Interactive Map</span>")
        header_box.pack_start(title_label, True, True, 0)
        
        # Controls
        controls_box = Gtk.Box(orientation=Gtk.Orientation.HORIZONTAL, spacing=12)
        
        # Map type combo
        self.map_type_combo = Gtk.ComboBoxText()
        self.map_type_combo.append_text("Standard")
        self.map_type_combo.append_text("Satellite")
        self.map_type_combo.append_text("Hybrid")
        self.map_type_combo.append_text("Terrain")
        self.map_type_combo.set_active(0)
        self.map_type_combo.connect("changed", self.on_map_type_changed)
        controls_box.pack_start(self.map_type_combo, False, False, 0)
        
        # Layers button
        layers_btn = Gtk.Button(label="Layers")
        layers_btn.connect("clicked", self.on_layers_clicked)
        controls_box.pack_start(layers_btn, False, False, 0)
        
        # Bookmarks button
        bookmarks_btn = Gtk.Button(label="Bookmarks")
        bookmarks_btn.connect("clicked", self.on_bookmarks_clicked)
        controls_box.pack_start(bookmarks_btn, False, False, 0)
        
        header_box.pack_start(controls_box, False, False, 0)
        
        # Style header
        header_box.override_background_color(Gtk.StateFlags.NORMAL, Gdk.RGBA(0.2, 0.4, 0.8, 1.0))
        
        return header_box
    
    def create_search_bar(self):
        search_box = Gtk.Box(orientation=Gtk.Orientation.HORIZONTAL, spacing=12)
        search_box.set_margin_start(24)
        search_box.set_margin_end(24)
        search_box.set_margin_top(16)
        search_box.set_margin_bottom(16)
        
        # Search entry
        self.search_entry = Gtk.SearchEntry()
        self.search_entry.set_placeholder_text("Search for places, addresses, or businesses...")
        self.search_entry.connect("search-changed", self.on_search_changed)
        search_box.pack_start(self.search_entry, True, True, 0)
        
        # My location button
        my_location_btn = Gtk.Button(label="📍")
        my_location_btn.set_tooltip_text("My Location")
        my_location_btn.connect("clicked", self.on_my_location_clicked)
        search_box.pack_start(my_location_btn, False, False, 0)
        
        return search_box
    
    def create_map_area(self, parent):
        # Map container
        map_box = Gtk.Box(orientation=Gtk.Orientation.VERTICAL, spacing=0)
        map_box.set_hexpand(True)
        map_box.set_vexpand(True)
        
        # Map background (simplified representation)
        self.map_area = Gtk.DrawingArea()
        self.map_area.set_hexpand(True)
        self.map_area.set_vexpand(True)
        self.map_area.connect("draw", self.on_map_draw)
        self.map_area.connect("button-press-event", self.on_map_clicked)
        map_box.pack_start(self.map_area, True, True, 0)
        
        # Map controls overlay
        controls_overlay = Gtk.Overlay()
        controls_overlay.add(map_box)
        
        # Map controls
        controls_box = Gtk.Box(orientation=Gtk.Orientation.VERTICAL, spacing=8)
        controls_box.set_halign(Gtk.Align.END)
        controls_box.set_valign(Gtk.Align.START)
        controls_box.set_margin_end(12)
        controls_box.set_margin_top(12)
        
        zoom_in_btn = Gtk.Button(label="+")
        zoom_in_btn.set_tooltip_text("Zoom In")
        zoom_in_btn.connect("clicked", self.on_zoom_in)
        controls_box.pack_start(zoom_in_btn, False, False, 0)
        
        zoom_out_btn = Gtk.Button(label="-")
        zoom_out_btn.set_tooltip_text("Zoom Out")
        zoom_out_btn.connect("clicked", self.on_zoom_out)
        controls_box.pack_start(zoom_out_btn, False, False, 0)
        
        center_btn = Gtk.Button(label="⌂")
        center_btn.set_tooltip_text("Center")
        center_btn.connect("clicked", self.on_center_clicked)
        controls_box.pack_start(center_btn, False, False, 0)
        
        controls_overlay.add_overlay(controls_box)
        
        # Map info overlay
        info_box = Gtk.Box(orientation=Gtk.Orientation.VERTICAL, spacing=4)
        info_box.set_halign(Gtk.Align.START)
        info_box.set_valign(Gtk.Align.END)
        info_box.set_margin_start(12)
        info_box.set_margin_bottom(12)
        
        info_label = Gtk.Label()
        info_label.set_markup(f"🗺️ {self.current_map_type} Map\n{self.center_lat:.4f}, {self.center_lng:.4f}\nZoom: {self.current_zoom}")
        info_label.override_background_color(Gtk.StateFlags.NORMAL, Gdk.RGBA(1, 1, 1, 0.9))
        info_label.set_margin_start(8)
        info_label.set_margin_end(8)
        info_label.set_margin_top(8)
        info_label.set_margin_bottom(8)
        
        controls_overlay.add_overlay(info_box)
        
        parent.pack_start(controls_overlay, True, True, 0)
    
    def create_side_panel(self, parent):
        side_panel = Gtk.Box(orientation=Gtk.Orientation.VERTICAL, spacing=16)
        side_panel.set_size_request(320, -1)
        side_panel.set_margin_start(8)
        side_panel.set_margin_end(8)
        side_panel.set_margin_top(8)
        side_panel.set_margin_bottom(8)
        
        # Search Results
        self.create_search_results(side_panel)
        
        # Location Details
        self.create_location_details(side_panel)
        
        # Quick Actions
        self.create_quick_actions(side_panel)
        
        parent.pack_start(side_panel, False, False, 0)
    
    def create_search_results(self, parent):
        results_frame = Gtk.Frame(label="Search Results")
        results_box = Gtk.Box(orientation=Gtk.Orientation.VERTICAL, spacing=8)
        results_box.set_margin_start(8)
        results_box.set_margin_end(8)
        results_box.set_margin_top(8)
        results_box.set_margin_bottom(8)
        
        # Results list
        scrolled = Gtk.ScrolledWindow()
        scrolled.set_size_request(-1, 160)
        
        self.results_list = Gtk.ListBox()
        self.results_list.set_selection_mode(Gtk.SelectionMode.SINGLE)
        self.results_list.connect("row-activated", self.on_result_activated)
        
        scrolled.add(self.results_list)
        results_box.pack_start(scrolled, True, True, 0)
        
        results_frame.add(results_box)
        parent.pack_start(results_frame, False, False, 0)
    
    def create_location_details(self, parent):
        details_frame = Gtk.Frame(label="Location Details")
        details_box = Gtk.Box(orientation=Gtk.Orientation.VERTICAL, spacing=8)
        details_box.set_margin_start(8)
        details_box.set_margin_end(8)
        details_box.set_margin_top(8)
        details_box.set_margin_bottom(8)
        
        # Details text
        self.details_text = Gtk.TextView()
        self.details_text.set_editable(False)
        self.details_text.set_wrap_mode(Gtk.WrapMode.WORD)
        self.details_text.set_size_request(-1, 200)
        
        scrolled = Gtk.ScrolledWindow()
        scrolled.add(self.details_text)
        details_box.pack_start(scrolled, True, True, 0)
        
        details_frame.add(details_box)
        parent.pack_start(details_frame, True, True, 0)
    
    def create_quick_actions(self, parent):
        actions_frame = Gtk.Frame(label="Quick Actions")
        actions_box = Gtk.Box(orientation=Gtk.Orientation.VERTICAL, spacing=8)
        actions_box.set_margin_start(8)
        actions_box.set_margin_end(8)
        actions_box.set_margin_top(8)
        actions_box.set_margin_bottom(8)
        
        # Action buttons grid
        grid = Gtk.Grid()
        grid.set_column_homogeneous(True)
        grid.set_row_homogeneous(True)
        grid.set_column_spacing(8)
        grid.set_row_spacing(8)
        
        # Get Directions
        directions_btn = Gtk.Button(label="Get Directions")
        directions_btn.connect("clicked", self.on_get_directions)
        grid.attach(directions_btn, 0, 0, 1, 1)
        
        # Share
        share_btn = Gtk.Button(label="Share")
        share_btn.connect("clicked", self.on_share_location)
        grid.attach(share_btn, 1, 0, 1, 1)
        
        # Save
        save_btn = Gtk.Button(label="Save")
        save_btn.connect("clicked", self.on_save_location)
        grid.attach(save_btn, 0, 1, 1, 1)
        
        # Report
        report_btn = Gtk.Button(label="Report")
        report_btn.connect("clicked", self.on_report_issue)
        grid.attach(report_btn, 1, 1, 1, 1)
        
        actions_box.pack_start(grid, False, False, 0)
        
        actions_frame.add(actions_box)
        parent.pack_start(actions_frame, False, False, 0)
    
    def create_status_bar(self):
        status_box = Gtk.Box(orientation=Gtk.Orientation.HORIZONTAL, spacing=8)
        status_box.set_margin_start(8)
        status_box.set_margin_end(8)
        status_box.set_margin_top(4)
        status_box.set_margin_bottom(4)
        
        self.status_label = Gtk.Label("Ready")
        status_box.pack_start(self.status_label, True, True, 0)
        
        self.coordinates_label = Gtk.Label(f"Lat: {self.center_lat:.4f}, Lng: {self.center_lng:.4f}")
        status_box.pack_start(self.coordinates_label, False, False, 0)
        
        # Style status bar
        status_box.override_background_color(Gtk.StateFlags.NORMAL, Gdk.RGBA(0.95, 0.95, 0.95, 1.0))
        
        return status_box
    
    def load_sample_data(self):
        self.all_locations = [
            {
                'id': '1',
                'name': 'Golden Gate Bridge',
                'address': 'Golden Gate Bridge, San Francisco, CA',
                'latitude': 37.8199,
                'longitude': -122.4783,
                'type': 'landmark',
                'rating': 4.8,
                'description': 'Famous suspension bridge spanning the Golden Gate strait.',
                'category': 'Tourist Attraction',
                'price': 0.0,
                'hours': '24/7',
                'phone': '(415) 921-5858'
            },
            {
                'id': '2',
                'name': 'Fisherman\'s Wharf',
                'address': 'Pier 39, San Francisco, CA',
                'latitude': 37.8087,
                'longitude': -122.4098,
                'type': 'attraction',
                'rating': 4.2,
                'description': 'Popular tourist destination with shops, restaurants, and sea lions.',
                'category': 'Shopping & Dining',
                'price': 0.0,
                'hours': '9:00 AM - 10:00 PM',
                'phone': '(415) 705-5500'
            },
            {
                'id': '3',
                'name': 'Alcatraz Island',
                'address': 'Alcatraz Island, San Francisco, CA',
                'latitude': 37.8270,
                'longitude': -122.4230,
                'type': 'landmark',
                'rating': 4.6,
                'description': 'Former federal prison, now a popular tourist attraction.',
                'category': 'Historical Site',
                'price': 45.0,
                'hours': '9:00 AM - 6:30 PM',
                'phone': '(415) 561-4926'
            },
            {
                'id': '4',
                'name': 'Lombard Street',
                'address': 'Lombard St, San Francisco, CA',
                'latitude': 37.8021,
                'longitude': -122.4187,
                'type': 'landmark',
                'rating': 4.3,
                'description': 'Famous steep, winding street with eight hairpin turns.',
                'category': 'Tourist Attraction',
                'price': 0.0,
                'hours': '24/7',
                'phone': 'N/A'
            },
            {
                'id': '5',
                'name': 'Union Square',
                'address': 'Union Square, San Francisco, CA',
                'latitude': 37.7880,
                'longitude': -122.4074,
                'type': 'shopping',
                'rating': 4.1,
                'description': 'Major shopping and entertainment district in downtown San Francisco.',
                'category': 'Shopping District',
                'price': 0.0,
                'hours': '10:00 AM - 9:00 PM',
                'phone': 'N/A'
            }
        ]
    
    def on_map_draw(self, widget, cr):
        # Draw map background
        cr.set_source_rgb(0.9, 0.9, 0.9)
        cr.paint()
        
        # Draw grid lines
        cr.set_source_rgb(0.7, 0.7, 0.7)
        cr.set_line_width(1)
        
        width = widget.get_allocated_width()
        height = widget.get_allocated_height()
        
        # Vertical lines
        for x in range(0, width, 50):
            cr.move_to(x, 0)
            cr.line_to(x, height)
        
        # Horizontal lines
        for y in range(0, height, 50):
            cr.move_to(0, y)
            cr.line_to(width, y)
        
        cr.stroke()
        
        # Draw location markers
        cr.set_source_rgb(0.2, 0.4, 0.8)
        for location in self.all_locations:
            # Convert lat/lng to screen coordinates (simplified)
            x = (location['longitude'] + 122.5) * width / 0.5
            y = (37.8 - location['latitude']) * height / 0.3
            
            if 0 <= x <= width and 0 <= y <= height:
                cr.arc(x, y, 8, 0, 2 * 3.14159)
                cr.fill()
        
        return False
    
    def on_map_clicked(self, widget, event):
        # Handle map clicks
        self.status_label.set_text("Map clicked")
        return False
    
    def perform_search(self):
        query = self.search_entry.get_text().lower()
        
        if not query:
            self.search_results = []
        else:
            self.search_results = [location for location in self.all_locations
                                 if query in location['name'].lower() or
                                 query in location['address'].lower() or
                                 query in location['category'].lower()]
        
        self.update_search_results()
    
    def update_search_results(self):
        # Clear existing results
        for child in self.results_list.get_children():
            self.results_list.remove(child)
        
        # Add search results
        for location in self.search_results:
            row = self.create_result_row(location)
            self.results_list.add(row)
        
        self.results_list.show_all()
    
    def create_result_row(self, location):
        row = Gtk.ListBoxRow()
        
        content_box = Gtk.Box(orientation=Gtk.Orientation.VERTICAL, spacing=4)
        content_box.set_margin_start(8)
        content_box.set_margin_end(8)
        content_box.set_margin-top(4)
        content_box.set_margin-bottom(4)
        
        # Name
        name_label = Gtk.Label()
        name_label.set_markup(f"<span weight='bold'>{location['name']}</span>")
        name_label.set_halign(Gtk.Align.START)
        content_box.pack_start(name_label, False, False, 0)
        
        # Address
        address_label = Gtk.Label(location['address'])
        address_label.set_halign(Gtk.Align.START)
        content_box.pack_start(address_label, False, False, 0)
        
        # Category
        category_label = Gtk.Label()
        category_label.set_markup(f"<span color='blue'>{location['category']}</span>")
        category_label.set_halign(Gtk.Align.START)
        content_box.pack_start(category_label, False, False, 0)
        
        row.add(content_box)
        return row
    
    def show_location_details(self, location):
        details = f"{location['name']}\n\n"
        details += f"{location['description']}\n\n"
        details += f"Type: {location['type']}\n"
        details += f"Rating: {location['rating']:.1f}/5\n"
        details += f"Price: ${location['price']:.0f}" if location['price'] > 0 else "Price: Free"
        details += f"\nHours: {location['hours']}\n"
        if location['phone'] != 'N/A':
            details += f"Phone: {location['phone']}"
        
        self.details_text.get_buffer().set_text(details)
    
    # Event handlers
    def on_search_changed(self, entry):
        self.perform_search()
    
    def on_map_type_changed(self, combo):
        self.current_map_type = combo.get_active_text()
        self.map_area.queue_draw()
        self.status_label.set_text(f"Map type changed to {self.current_map_type}")
    
    def on_layers_clicked(self, button):
        dialog = Gtk.Dialog("Map Layers", self, 0,
                           (Gtk.STOCK_CANCEL, Gtk.ResponseType.CANCEL,
                            Gtk.STOCK_OK, Gtk.ResponseType.OK))
        
        dialog.set_default_size(300, 200)
        
        content_area = dialog.get_content_area()
        content_area.set_spacing(16)
        
        # Layer checkboxes
        traffic_check = Gtk.CheckButton("Traffic")
        traffic_check.set_active(self.traffic_enabled)
        content_area.pack_start(traffic_check, False, False, 0)
        
        transit_check = Gtk.CheckButton("Transit")
        transit_check.set_active(self.transit_enabled)
        content_area.pack_start(transit_check, False, False, 0)
        
        bike_check = Gtk.CheckButton("Bike Lanes")
        bike_check.set_active(self.bike_lanes_enabled)
        content_area.pack_start(bike_check, False, False, 0)
        
        user_loc_check = Gtk.CheckButton("User Location")
        user_loc_check.set_active(self.show_user_location)
        content_area.pack_start(user_loc_check, False, False, 0)
        
        dialog.show_all()
        
        response = dialog.run()
        if response == Gtk.ResponseType.OK:
            self.traffic_enabled = traffic_check.get_active()
            self.transit_enabled = transit_check.get_active()
            self.bike_lanes_enabled = bike_check.get_active()
            self.show_user_location = user_loc_check.get_active()
            self.status_label.set_text("Map layers updated")
        
        dialog.destroy()
    
    def on_bookmarks_clicked(self, button):
        if not self.bookmarks:
            dialog = Gtk.MessageDialog(self, 0, Gtk.MessageType.INFO, Gtk.ButtonsType.OK,
                                     "No bookmarks yet.\nBookmark locations to see them here.")
        else:
            bookmark_names = [bookmark['name'] for bookmark in self.bookmarks]
            dialog = Gtk.MessageDialog(self, 0, Gtk.MessageType.INFO, Gtk.ButtonsType.OK,
                                     "Bookmarks:\n" + "\n".join(bookmark_names))
        
        dialog.run()
        dialog.destroy()
    
    def on_my_location_clicked(self, button):
        self.center_lat = 37.7749
        self.center_lng = -122.4194
        self.current_zoom = 10
        self.map_area.queue_draw()
        self.coordinates_label.set_text(f"Lat: {self.center_lat:.4f}, Lng: {self.center_lng:.4f}")
        self.status_label.set_text("Centered on your location")
    
    def on_zoom_in(self, button):
        self.current_zoom = min(self.current_zoom + 1, 20)
        self.map_area.queue_draw()
    
    def on_zoom_out(self, button):
        self.current_zoom = max(self.current_zoom - 1, 1)
        self.map_area.queue_draw()
    
    def on_center_clicked(self, button):
        self.center_lat = 37.7749
        self.center_lng = -122.4194
        self.current_zoom = 10
        self.map_area.queue_draw()
        self.coordinates_label.set_text(f"Lat: {self.center_lat:.4f}, Lng: {self.center_lng:.4f}")
        self.status_label.set_text("Map centered")
    
    def on_result_activated(self, listbox, row):
        # Get location from row
        # In a real implementation, this would store location data in the row
        self.status_label.set_text("Location selected")
    
    def on_get_directions(self, button):
        dialog = Gtk.MessageDialog(self, 0, Gtk.MessageType.INFO, Gtk.ButtonsType.OK,
                                 "Turn-by-turn directions would be displayed here.")
        dialog.run()
        dialog.destroy()
    
    def on_share_location(self, button):
        dialog = Gtk.MessageDialog(self, 0, Gtk.MessageType.INFO, Gtk.ButtonsType.OK,
                                 "Location sharing options would be displayed here.")
        dialog.run()
        dialog.destroy()
    
    def on_save_location(self, button):
        if self.selected_location:
            if self.selected_location not in self.bookmarks:
                self.bookmarks.append(self.selected_location)
                dialog = Gtk.MessageDialog(self, 0, Gtk.MessageType.INFO, Gtk.ButtonsType.OK,
                                         f"Location '{self.selected_location['name']}' bookmarked!")
            else:
                dialog = Gtk.MessageDialog(self, 0, Gtk.MessageType.INFO, Gtk.ButtonsType.OK,
                                         "Location already bookmarked.")
        else:
            dialog = Gtk.MessageDialog(self, 0, Gtk.MessageType.INFO, Gtk.ButtonsType.OK,
                                     "Please select a location first.")
        
        dialog.run()
        dialog.destroy()
    
    def on_report_issue(self, button):
        dialog = Gtk.MessageDialog(self, 0, Gtk.MessageType.INFO, Gtk.ButtonsType.OK,
                                 "Report issue form would be displayed here.")
        dialog.run()
        dialog.destroy()

def main():
    app = InteractiveMap()
    app.connect("destroy", Gtk.main_quit)
    app.show_all()
    Gtk.main()

if __name__ == "__main__":
    main()

#!/usr/bin/env python3

import gi
gi.require_version('Gtk', '3.0')
from gi.repository import Gtk, Gdk, Pango
from datetime import datetime, timedelta

class ComplexSearchInterface(Gtk.Window):
    def __init__(self):
        Gtk.Window.__init__(self, title="Advanced Search")
        self.set_default_size(1200, 800)
        self.set_border_width(10)
        
        # Data
        self.all_results = []
        self.filtered_results = []
        self.active_filters = []
        self.current_sort = "Relevance"
        self.current_category = "All"
        self.current_page = 1
        self.results_per_page = 25
        self.total_pages = 1
        
        # Load sample data
        self.load_sample_data()
        
        # Create UI
        self.create_ui()
        
        # Perform initial search
        self.perform_search()
    
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
        
        # Filters
        filters_box = self.create_filters()
        main_box.pack_start(filters_box, False, False, 0)
        
        # Results
        results_box = self.create_results()
        main_box.pack_start(results_box, True, True, 0)
        
        # Pagination
        pagination_box = self.create_pagination()
        main_box.pack_start(pagination_box, False, False, 0)
        
        # Status bar
        status_box = self.create_status_bar()
        main_box.pack_start(status_box, False, False, 0)
    
    def create_header(self):
        header_box = Gtk.Box(orientation=Gtk.Orientation.HORIZONTAL, spacing=12)
        header_box.set_margin_bottom(16)
        
        # Title
        title_label = Gtk.Label()
        title_label.set_markup("<span size='xx-large' weight='bold' foreground='white'>Advanced Search</span>")
        header_box.pack_start(title_label, True, True, 0)
        
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
        self.search_entry.set_placeholder_text("Search for files, documents, images...")
        self.search_entry.connect("search-changed", self.on_search_changed)
        search_box.pack_start(self.search_entry, True, True, 0)
        
        # Advanced search button
        advanced_btn = Gtk.Button(label="Advanced")
        advanced_btn.connect("clicked", self.on_advanced_search_clicked)
        search_box.pack_start(advanced_btn, False, False, 0)
        
        return search_box
    
    def create_filters(self):
        filters_box = Gtk.Box(orientation=Gtk.Orientation.VERTICAL, spacing=16)
        filters_box.set_margin_start(24)
        filters_box.set_margin_end(24)
        filters_box.set_margin_bottom(16)
        
        # Main filters
        main_filters_box = Gtk.Box(orientation=Gtk.Orientation.HORIZONTAL, spacing=16)
        
        # Category filter
        cat_box = Gtk.Box(orientation=Gtk.Orientation.VERTICAL, spacing=4)
        cat_label = Gtk.Label("Category:")
        cat_label.set_halign(Gtk.Align.START)
        cat_box.pack_start(cat_label, False, False, 0)
        
        self.category_combo = Gtk.ComboBoxText()
        self.category_combo.append_text("All")
        self.category_combo.append_text("Documents")
        self.category_combo.append_text("Images")
        self.category_combo.append_text("Videos")
        self.category_combo.append_text("Audio")
        self.category_combo.append_text("Archives")
        self.category_combo.set_active(0)
        self.category_combo.connect("changed", self.on_category_changed)
        cat_box.pack_start(self.category_combo, False, False, 0)
        
        main_filters_box.pack_start(cat_box, False, False, 0)
        
        # Sort filter
        sort_box = Gtk.Box(orientation=Gtk.Orientation.VERTICAL, spacing=4)
        sort_label = Gtk.Label("Sort by:")
        sort_label.set_halign(Gtk.Align.START)
        sort_box.pack_start(sort_label, False, False, 0)
        
        self.sort_combo = Gtk.ComboBoxText()
        self.sort_combo.append_text("Relevance")
        self.sort_combo.append_text("Date")
        self.sort_combo.append_text("Name")
        self.sort_combo.append_text("Size")
        self.sort_combo.append_text("Type")
        self.sort_combo.append_text("Rating")
        self.sort_combo.set_active(0)
        self.sort_combo.connect("changed", self.on_sort_changed)
        sort_box.pack_start(self.sort_combo, False, False, 0)
        
        main_filters_box.pack_start(sort_box, False, False, 0)
        
        # View mode
        view_box = Gtk.Box(orientation=Gtk.Orientation.VERTICAL, spacing=4)
        view_label = Gtk.Label("View:")
        view_label.set_halign(Gtk.Align.START)
        view_box.pack_start(view_label, False, False, 0)
        
        self.view_combo = Gtk.ComboBoxText()
        self.view_combo.append_text("List")
        self.view_combo.append_text("Grid")
        self.view_combo.append_text("Compact")
        self.view_combo.set_active(0)
        self.view_combo.connect("changed", self.on_view_changed)
        view_box.pack_start(self.view_combo, False, False, 0)
        
        main_filters_box.pack_start(view_box, False, False, 0)
        
        main_filters_box.pack_start(Gtk.Label(), True, True, 0)  # Spacer
        
        # Clear filters button
        clear_btn = Gtk.Button(label="Clear All")
        clear_btn.connect("clicked", self.on_clear_filters_clicked)
        main_filters_box.pack_start(clear_btn, False, False, 0)
        
        filters_box.pack_start(main_filters_box, False, False, 0)
        
        # Quick filters
        quick_filters_box = Gtk.Box(orientation=Gtk.Orientation.HORIZONTAL, spacing=8)
        
        quick_label = Gtk.Label("Quick Filters:")
        quick_filters_box.pack_start(quick_label, False, False, 0)
        
        self.filter_buttons = {}
        filter_names = ["Recent", "Large Files", "Images Only", "Videos Only", "Free", "Premium"]
        
        for filter_name in filter_names:
            btn = Gtk.ToggleButton(label=filter_name)
            btn.connect("toggled", self.on_filter_toggled, filter_name)
            quick_filters_box.pack_start(btn, False, False, 0)
            self.filter_buttons[filter_name] = btn
        
        filters_box.pack_start(quick_filters_box, False, False, 0)
        
        # Style filters box
        filters_box.override_background_color(Gtk.StateFlags.NORMAL, Gdk.RGBA(0.95, 0.95, 0.95, 1.0))
        
        return filters_box
    
    def create_results(self):
        results_box = Gtk.Box(orientation=Gtk.Orientation.VERTICAL, spacing=0)
        results_box.set_margin_start(24)
        results_box.set_margin_end(24)
        
        # Results header
        header_box = Gtk.Box(orientation=Gtk.Orientation.HORIZONTAL, spacing=12)
        header_box.set_margin_bottom(12)
        
        self.results_count_label = Gtk.Label("0 results found")
        self.results_count_label.set_markup("<span weight='bold'>0 results found</span>")
        header_box.pack_start(self.results_count_label, True, True, 0)
        
        # Results per page
        per_page_box = Gtk.Box(orientation=Gtk.Orientation.HORIZONTAL, spacing=8)
        per_page_label = Gtk.Label("Results per page:")
        per_page_box.pack_start(per_page_label, False, False, 0)
        
        self.per_page_combo = Gtk.ComboBoxText()
        self.per_page_combo.append_text("10")
        self.per_page_combo.append_text("25")
        self.per_page_combo.append_text("50")
        self.per_page_combo.append_text("100")
        self.per_page_combo.set_active(1)  # 25
        self.per_page_combo.connect("changed", self.on_per_page_changed)
        per_page_box.pack_start(self.per_page_combo, False, False, 0)
        
        header_box.pack_start(per_page_box, False, False, 0)
        
        results_box.pack_start(header_box, False, False, 0)
        
        # Results list
        scrolled = Gtk.ScrolledWindow()
        scrolled.set_hexpand(True)
        scrolled.set_vexpand(True)
        
        self.results_list = Gtk.ListBox()
        self.results_list.set_selection_mode(Gtk.SelectionMode.SINGLE)
        self.results_list.connect("row-activated", self.on_result_activated)
        
        scrolled.add(self.results_list)
        results_box.pack_start(scrolled, True, True, 0)
        
        # Empty state
        self.empty_state_box = Gtk.Box(orientation=Gtk.Orientation.VERTICAL, spacing=16)
        self.empty_state_box.set_halign(Gtk.Align.CENTER)
        self.empty_state_box.set_valign(Gtk.Align.CENTER)
        
        empty_icon = Gtk.Label()
        empty_icon.set_markup("<span size='xx-large'>🔍</span>")
        self.empty_state_box.pack_start(empty_icon, False, False, 0)
        
        empty_title = Gtk.Label()
        empty_title.set_markup("<span size='large' weight='bold'>No results found</span>")
        self.empty_state_box.pack_start(empty_title, False, False, 0)
        
        empty_desc = Gtk.Label()
        empty_desc.set_markup("<span>Try adjusting your search terms or filters</span>")
        self.empty_state_box.pack_start(empty_desc, False, False, 0)
        
        results_box.pack_start(self.empty_state_box, True, True, 0)
        
        return results_box
    
    def create_pagination(self):
        pagination_box = Gtk.Box(orientation=Gtk.Orientation.HORIZONTAL, spacing=8)
        pagination_box.set_margin_start(24)
        pagination_box.set_margin_end(24)
        pagination_box.set_margin_top(12)
        pagination_box.set_margin_bottom(12)
        
        # First page button
        self.first_btn = Gtk.Button(label="⏮")
        self.first_btn.connect("clicked", self.on_first_page)
        pagination_box.pack_start(self.first_btn, False, False, 0)
        
        # Previous page button
        self.prev_btn = Gtk.Button(label="◀")
        self.prev_btn.connect("clicked", self.on_prev_page)
        pagination_box.pack_start(self.prev_btn, False, False, 0)
        
        # Page info
        pagination_box.pack_start(Gtk.Label(), True, True, 0)  # Spacer
        
        self.page_info_label = Gtk.Label("Page 1 of 1")
        pagination_box.pack_start(self.page_info_label, False, False, 0)
        
        pagination_box.pack_start(Gtk.Label(), True, True, 0)  # Spacer
        
        # Next page button
        self.next_btn = Gtk.Button(label="▶")
        self.next_btn.connect("clicked", self.on_next_page)
        pagination_box.pack_start(self.next_btn, False, False, 0)
        
        # Last page button
        self.last_btn = Gtk.Button(label="⏭")
        self.last_btn.connect("clicked", self.on_last_page)
        pagination_box.pack_start(self.last_btn, False, False, 0)
        
        # Style pagination
        pagination_box.override_background_color(Gtk.StateFlags.NORMAL, Gdk.RGBA(0.95, 0.95, 0.95, 1.0))
        
        return pagination_box
    
    def create_status_bar(self):
        status_box = Gtk.Box(orientation=Gtk.Orientation.HORIZONTAL, spacing=8)
        status_box.set_margin_start(8)
        status_box.set_margin_end(8)
        status_box.set_margin_top(4)
        status_box.set_margin_bottom(4)
        
        self.status_label = Gtk.Label("Ready")
        status_box.pack_start(self.status_label, True, True, 0)
        
        # Style status bar
        status_box.override_background_color(Gtk.StateFlags.NORMAL, Gdk.RGBA(0.95, 0.95, 0.95, 1.0))
        
        return status_box
    
    def load_sample_data(self):
        self.all_results = [
            {
                'id': '1',
                'title': 'React Native Development Guide',
                'description': 'Comprehensive guide to building mobile apps with React Native',
                'type': 'document',
                'category': 'Documents',
                'size': '2.5 MB',
                'size_value': 2.5,
                'date': '2024-01-15',
                'rating': 4.8,
                'price': 0.0,
                'icon': '📄',
                'url': 'https://example.com/react-native-guide'
            },
            {
                'id': '2',
                'title': 'Mobile UI Design Patterns',
                'description': 'Best practices for mobile user interface design',
                'type': 'image',
                'category': 'Images',
                'size': '1.2 MB',
                'size_value': 1.2,
                'date': '2024-01-14',
                'rating': 4.6,
                'price': 29.99,
                'icon': '🖼️',
                'url': 'https://example.com/ui-patterns'
            },
            {
                'id': '3',
                'title': 'JavaScript Tutorial Series',
                'description': 'Complete JavaScript tutorial for beginners',
                'type': 'video',
                'category': 'Videos',
                'size': '150 MB',
                'size_value': 150.0,
                'date': '2024-01-13',
                'rating': 4.9,
                'price': 49.99,
                'icon': '🎥',
                'url': 'https://example.com/js-tutorial'
            },
            {
                'id': '4',
                'title': 'Web Development News',
                'description': 'Latest news and updates in web development',
                'type': 'news',
                'category': 'News',
                'size': '500 KB',
                'size_value': 0.5,
                'date': '2024-01-12',
                'rating': 4.3,
                'price': 0.0,
                'icon': '📰',
                'url': 'https://example.com/web-news'
            },
            {
                'id': '5',
                'title': 'E-commerce Product Catalog',
                'description': 'Complete product catalog for online store',
                'type': 'product',
                'category': 'Products',
                'size': '5.8 MB',
                'size_value': 5.8,
                'date': '2024-01-11',
                'rating': 4.5,
                'price': 99.99,
                'icon': '🛍️',
                'url': 'https://example.com/product-catalog'
            },
            {
                'id': '6',
                'title': 'Database Design Principles',
                'description': 'Fundamental concepts of database design and optimization',
                'type': 'document',
                'category': 'Documents',
                'size': '3.2 MB',
                'size_value': 3.2,
                'date': '2024-01-10',
                'rating': 4.7,
                'price': 0.0,
                'icon': '📄',
                'url': 'https://example.com/database-design'
            },
            {
                'id': '7',
                'title': 'Cloud Architecture Diagrams',
                'description': 'Visual representations of cloud infrastructure patterns',
                'type': 'image',
                'category': 'Images',
                'size': '2.1 MB',
                'size_value': 2.1,
                'date': '2024-01-09',
                'rating': 4.4,
                'price': 19.99,
                'icon': '🖼️',
                'url': 'https://example.com/cloud-diagrams'
            },
            {
                'id': '8',
                'title': 'Machine Learning Course',
                'description': 'Complete course on machine learning algorithms and applications',
                'type': 'video',
                'category': 'Videos',
                'size': '2.5 GB',
                'size_value': 2500.0,
                'date': '2024-01-08',
                'rating': 4.9,
                'price': 199.99,
                'icon': '🎥',
                'url': 'https://example.com/ml-course'
            }
        ]
    
    def perform_search(self):
        search_text = self.search_entry.get_text().lower()
        
        # Filter by search text
        self.filtered_results = [result for result in self.all_results
                               if not search_text or
                               search_text in result['title'].lower() or
                               search_text in result['description'].lower() or
                               search_text in result['category'].lower()]
        
        # Filter by category
        if self.current_category != "All":
            self.filtered_results = [result for result in self.filtered_results
                                   if result['category'] == self.current_category]
        
        # Apply active filters
        for filter_name in self.active_filters:
            if filter_name == "Recent":
                week_ago = datetime.now() - timedelta(days=7)
                self.filtered_results = [result for result in self.filtered_results
                                       if datetime.strptime(result['date'], '%Y-%m-%d') >= week_ago]
            elif filter_name == "Large Files":
                self.filtered_results = [result for result in self.filtered_results
                                       if result['size_value'] > 10.0]
            elif filter_name == "Images Only":
                self.filtered_results = [result for result in self.filtered_results
                                       if result['type'] == 'image']
            elif filter_name == "Videos Only":
                self.filtered_results = [result for result in self.filtered_results
                                       if result['type'] == 'video']
            elif filter_name == "Free":
                self.filtered_results = [result for result in self.filtered_results
                                       if result['price'] == 0.0]
            elif filter_name == "Premium":
                self.filtered_results = [result for result in self.filtered_results
                                       if result['price'] > 0.0]
        
        # Apply sorting
        if self.current_sort == "Date":
            self.filtered_results.sort(key=lambda x: x['date'], reverse=True)
        elif self.current_sort == "Name":
            self.filtered_results.sort(key=lambda x: x['title'])
        elif self.current_sort == "Size":
            self.filtered_results.sort(key=lambda x: x['size_value'], reverse=True)
        elif self.current_sort == "Type":
            self.filtered_results.sort(key=lambda x: x['type'])
        elif self.current_sort == "Rating":
            self.filtered_results.sort(key=lambda x: x['rating'], reverse=True)
        else:  # Relevance
            self.filtered_results.sort(key=lambda x: x['rating'], reverse=True)
        
        self.update_results()
    
    def update_results(self):
        # Update results count
        count = len(self.filtered_results)
        self.results_count_label.set_markup(f"<span weight='bold'>{count} results found</span>")
        
        # Update pagination
        self.total_pages = max(1, (count + self.results_per_page - 1) // self.results_per_page)
        self.current_page = min(self.current_page, self.total_pages)
        self.current_page = max(1, self.current_page)
        
        # Update page info
        self.page_info_label.set_text(f"Page {self.current_page} of {self.total_pages}")
        
        # Update pagination buttons
        self.first_btn.set_sensitive(self.current_page > 1)
        self.prev_btn.set_sensitive(self.current_page > 1)
        self.next_btn.set_sensitive(self.current_page < self.total_pages)
        self.last_btn.set_sensitive(self.current_page < self.total_pages)
        
        # Clear results list
        for child in self.results_list.get_children():
            self.results_list.remove(child)
        
        if count == 0:
            # Show empty state
            self.results_list.hide()
            self.empty_state_box.show_all()
        else:
            # Hide empty state
            self.empty_state_box.hide()
            self.results_list.show_all()
            
            # Add results
            start_idx = (self.current_page - 1) * self.results_per_page
            end_idx = min(start_idx + self.results_per_page, count)
            
            for i in range(start_idx, end_idx):
                result = self.filtered_results[i]
                row = self.create_result_row(result)
                self.results_list.add(row)
    
    def create_result_row(self, result):
        row = Gtk.ListBoxRow()
        
        # Main container
        main_box = Gtk.Box(orientation=Gtk.Orientation.HORIZONTAL, spacing=16)
        main_box.set_margin_start(16)
        main_box.set_margin_end(16)
        main_box.set_margin_top(12)
        main_box.set_margin_bottom(12)
        
        # Icon
        icon_label = Gtk.Label()
        icon_label.set_markup(f"<span size='xx-large'>{result['icon']}</span>")
        main_box.pack_start(icon_label, False, False, 0)
        
        # Content
        content_box = Gtk.Box(orientation=Gtk.Orientation.VERTICAL, spacing=8)
        content_box.set_hexpand(True)
        
        # Title
        title_label = Gtk.Label()
        title_label.set_markup(f"<span size='large' weight='bold'>{result['title']}</span>")
        title_label.set_halign(Gtk.Align.START)
        content_box.pack_start(title_label, False, False, 0)
        
        # Description
        desc_label = Gtk.Label()
        desc_label.set_markup(f"<span>{result['description']}</span>")
        desc_label.set_halign(Gtk.Align.START)
        desc_label.set_line_wrap(True)
        content_box.pack_start(desc_label, False, False, 0)
        
        # Metadata
        metadata_box = Gtk.Box(orientation=Gtk.Orientation.HORIZONTAL, spacing=16)
        
        cat_label = Gtk.Label()
        cat_label.set_markup(f"<span color='blue'>{result['category']}</span>")
        metadata_box.pack_start(cat_label, False, False, 0)
        
        date_label = Gtk.Label(result['date'])
        metadata_box.pack_start(date_label, False, False, 0)
        
        rating_label = Gtk.Label()
        rating_label.set_markup(f"⭐ {result['rating']:.1f}")
        metadata_box.pack_start(rating_label, False, False, 0)
        
        size_label = Gtk.Label(result['size'])
        metadata_box.pack_start(size_label, False, False, 0)
        
        content_box.pack_start(metadata_box, False, False, 0)
        
        main_box.pack_start(content_box, True, True, 0)
        
        # Price/Actions
        right_box = Gtk.Box(orientation=Gtk.Orientation.VERTICAL, spacing=8)
        right_box.set_halign(Gtk.Align.END)
        
        # Price
        price_label = Gtk.Label()
        price_text = f"${result['price']:.2f}" if result['price'] > 0 else "Free"
        price_label.set_markup(f"<span size='large' weight='bold'>{price_text}</span>")
        right_box.pack_start(price_label, False, False, 0)
        
        # Actions
        actions_box = Gtk.Box(orientation=Gtk.Orientation.HORIZONTAL, spacing=4)
        
        preview_btn = Gtk.Button(label="👁")
        preview_btn.set_tooltip_text("Preview")
        preview_btn.connect("clicked", self.on_preview_clicked, result)
        actions_box.pack_start(preview_btn, False, False, 0)
        
        download_btn = Gtk.Button(label="⬇")
        download_btn.set_tooltip_text("Download")
        download_btn.connect("clicked", self.on_download_clicked, result)
        actions_box.pack_start(download_btn, False, False, 0)
        
        bookmark_btn = Gtk.Button(label="🔖")
        bookmark_btn.set_tooltip_text("Bookmark")
        bookmark_btn.connect("clicked", self.on_bookmark_clicked, result)
        actions_box.pack_start(bookmark_btn, False, False, 0)
        
        right_box.pack_start(actions_box, False, False, 0)
        
        main_box.pack_start(right_box, False, False, 0)
        
        row.add(main_box)
        return row
    
    # Event handlers
    def on_search_changed(self, entry):
        self.perform_search()
    
    def on_category_changed(self, combo):
        self.current_category = combo.get_active_text()
        self.perform_search()
    
    def on_sort_changed(self, combo):
        self.current_sort = combo.get_active_text()
        self.perform_search()
    
    def on_view_changed(self, combo):
        view_mode = combo.get_active_text()
        self.status_label.set_text(f"View mode changed to {view_mode}")
    
    def on_clear_filters_clicked(self, button):
        self.active_filters.clear()
        for btn in self.filter_buttons.values():
            btn.set_active(False)
        self.current_category = "All"
        self.category_combo.set_active(0)
        self.search_entry.set_text("")
        self.perform_search()
    
    def on_filter_toggled(self, button, filter_name):
        if button.get_active():
            if filter_name not in self.active_filters:
                self.active_filters.append(filter_name)
        else:
            if filter_name in self.active_filters:
                self.active_filters.remove(filter_name)
        self.perform_search()
    
    def on_per_page_changed(self, combo):
        self.results_per_page = int(combo.get_active_text())
        self.current_page = 1
        self.update_results()
    
    def on_result_activated(self, listbox, row):
        # Get result data from row
        # In a real implementation, this would show result details
        self.status_label.set_text("Result selected")
    
    def on_preview_clicked(self, button, result):
        dialog = Gtk.MessageDialog(self, 0, Gtk.MessageType.INFO, Gtk.ButtonsType.OK,
                                 f"Preview: {result['title']}\n\n{result['description']}")
        dialog.run()
        dialog.destroy()
    
    def on_download_clicked(self, button, result):
        dialog = Gtk.MessageDialog(self, 0, Gtk.MessageType.INFO, Gtk.ButtonsType.OK,
                                 f"Downloading: {result['title']}")
        dialog.run()
        dialog.destroy()
    
    def on_bookmark_clicked(self, button, result):
        dialog = Gtk.MessageDialog(self, 0, Gtk.MessageType.INFO, Gtk.ButtonsType.OK,
                                 f"Bookmarked: {result['title']}")
        dialog.run()
        dialog.destroy()
    
    def on_advanced_search_clicked(self, button):
        dialog = Gtk.MessageDialog(self, 0, Gtk.MessageType.INFO, Gtk.ButtonsType.OK,
                                 "Advanced search options would be implemented here.")
        dialog.run()
        dialog.destroy()
    
    def on_first_page(self, button):
        self.current_page = 1
        self.update_results()
    
    def on_prev_page(self, button):
        if self.current_page > 1:
            self.current_page -= 1
            self.update_results()
    
    def on_next_page(self, button):
        if self.current_page < self.total_pages:
            self.current_page += 1
            self.update_results()
    
    def on_last_page(self, button):
        self.current_page = self.total_pages
        self.update_results()

def main():
    app = ComplexSearchInterface()
    app.connect("destroy", Gtk.main_quit)
    app.show_all()
    Gtk.main()

if __name__ == "__main__":
    main()

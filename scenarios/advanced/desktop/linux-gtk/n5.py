#!/usr/bin/env python3

import gi
gi.require_version('Gtk', '3.0')
from gi.repository import Gtk, Gdk, Pango
from datetime import datetime

class SocialMediaFeed(Gtk.Window):
    def __init__(self):
        Gtk.Window.__init__(self, title="Social Media Feed")
        self.set_default_size(1000, 700)
        self.set_border_width(0)
        
        # Data
        self.posts = []
        self.all_posts = []
        self.current_filter = "All"
        self.unread_notifications = 3
        
        # Load sample data
        self.load_sample_posts()
        
        # Create UI
        self.create_ui()
    
    def create_ui(self):
        # Main container
        main_box = Gtk.Box(orientation=Gtk.Orientation.VERTICAL, spacing=0)
        self.add(main_box)
        
        # Header
        header_box = self.create_header()
        main_box.pack_start(header_box, False, False, 0)
        
        # Create post
        create_post_box = self.create_post_box()
        main_box.pack_start(create_post_box, False, False, 0)
        
        # Posts feed
        self.create_posts_feed(main_box)
        
        # Status bar
        status_box = self.create_status_bar()
        main_box.pack_start(status_box, False, False, 0)
    
    def create_header(self):
        header_box = Gtk.Box(orientation=Gtk.Orientation.HORIZONTAL, spacing=12)
        header_box.set_margin_bottom(16)
        
        # Title
        title_label = Gtk.Label()
        title_label.set_markup("<span size='xx-large' weight='bold' foreground='white'>Social Media Feed</span>")
        header_box.pack_start(title_label, True, True, 0)
        
        # Controls
        controls_box = Gtk.Box(orientation=Gtk.Orientation.HORIZONTAL, spacing=12)
        
        # Filter combo
        self.filter_combo = Gtk.ComboBoxText()
        self.filter_combo.append_text("All")
        self.filter_combo.append_text("Following")
        self.filter_combo.append_text("Trending")
        self.filter_combo.set_active(0)
        self.filter_combo.connect("changed", self.on_filter_changed)
        controls_box.pack_start(self.filter_combo, False, False, 0)
        
        # Notifications button
        self.notifications_btn = Gtk.Button(label="🔔")
        self.notifications_btn.set_tooltip_text("Notifications")
        self.notifications_btn.connect("clicked", self.on_notifications_clicked)
        controls_box.pack_start(self.notifications_btn, False, False, 0)
        
        # Trending button
        trending_btn = Gtk.Button(label="📈")
        trending_btn.set_tooltip_text("Trending")
        trending_btn.connect("clicked", self.on_trending_clicked)
        controls_box.pack_start(trending_btn, False, False, 0)
        
        header_box.pack_start(controls_box, False, False, 0)
        
        # Style header
        header_box.override_background_color(Gtk.StateFlags.NORMAL, Gdk.RGBA(0.2, 0.4, 0.8, 1.0))
        
        return header_box
    
    def create_post_box(self):
        create_post_box = Gtk.Box(orientation=Gtk.Orientation.HORIZONTAL, spacing=16)
        create_post_box.set_margin_start(24)
        create_post_box.set_margin-end(24)
        create_post_box.set_margin-top(16)
        create_post_box.set_margin-bottom(16)
        
        # Avatar
        avatar_label = Gtk.Label()
        avatar_label.set_markup("<span size='xx-large'>👤</span>")
        create_post_box.pack_start(avatar_label, False, False, 0)
        
        # Text entry and button
        entry_box = Gtk.Box(orientation=Gtk.Orientation.HORIZONTAL, spacing=12)
        
        self.create_post_entry = Gtk.Entry()
        self.create_post_entry.set_placeholder_text("What's on your mind?")
        self.create_post_entry.connect("activate", self.on_create_post)
        entry_box.pack_start(self.create_post_entry, True, True, 0)
        
        self.create_post_btn = Gtk.Button(label="Post")
        self.create_post_btn.connect("clicked", self.on_create_post)
        entry_box.pack_start(self.create_post_btn, False, False, 0)
        
        create_post_box.pack_start(entry_box, True, True, 0)
        
        # Style create post box
        create_post_box.override_background_color(Gtk.StateFlags.NORMAL, Gdk.RGBA(0.95, 0.95, 0.95, 1.0))
        
        return create_post_box
    
    def create_posts_feed(self, parent):
        # Scrolled window for posts
        scrolled = Gtk.ScrolledWindow()
        scrolled.set_hexpand(True)
        scrolled.set_vexpand(True)
        
        # Posts container
        self.posts_box = Gtk.Box(orientation=Gtk.Orientation.VERTICAL, spacing=16)
        self.posts_box.set_margin-start(24)
        self.posts_box.set_margin-end(24)
        
        scrolled.add(self.posts_box)
        parent.pack_start(scrolled, True, True, 0)
        
        # Update posts display
        self.update_posts_display()
    
    def create_status_bar(self):
        status_box = Gtk.Box(orientation=Gtk.Orientation.HORIZONTAL, spacing=8)
        status_box.set_margin-start(8)
        status_box.set_margin-end(8)
        status_box.set_margin-top(4)
        status_box.set-margin-bottom(4)
        
        self.status_label = Gtk.Label("Ready")
        status_box.pack_start(self.status_label, True, True, 0)
        
        self.post_count_label = Gtk.Label(f"{len(self.posts)} posts")
        status_box.pack_start(self.post_count_label, False, False, 0)
        
        # Style status bar
        status_box.override_background_color(Gtk.StateFlags.NORMAL, Gdk.RGBA(0.95, 0.95, 0.95, 1.0))
        
        return status_box
    
    def load_sample_posts(self):
        self.all_posts = [
            {
                'id': '1',
                'user': {
                    'id': 'user1',
                    'name': 'John Doe',
                    'username': '@johndoe',
                    'avatar': '👨‍💻',
                    'verified': True
                },
                'content': 'Just finished building an amazing React Native app! The development process was challenging but incredibly rewarding. #ReactNative #MobileDev #Tech',
                'image': '📱',
                'location': 'San Francisco, CA',
                'timestamp': '2h ago',
                'likes': 42,
                'comments': 8,
                'shares': 3,
                'is_liked': False,
                'is_bookmarked': False,
                'privacy': 'public'
            },
            {
                'id': '2',
                'user': {
                    'id': 'user2',
                    'name': 'Sarah Wilson',
                    'username': '@sarahw',
                    'avatar': '👩‍🎨',
                    'verified': False
                },
                'content': 'Beautiful sunset from my office window today. Sometimes you need to stop and appreciate the little moments. 🌅',
                'image': '🌅',
                'location': 'New York, NY',
                'timestamp': '4h ago',
                'likes': 28,
                'comments': 5,
                'shares': 1,
                'is_liked': True,
                'is_bookmarked': False,
                'privacy': 'public'
            },
            {
                'id': '3',
                'user': {
                    'id': 'user3',
                    'name': 'Mike Chen',
                    'username': '@mikechen',
                    'avatar': '👨‍💼',
                    'verified': True
                },
                'content': 'Excited to announce our new product launch! After months of hard work, we\'re finally ready to share it with the world. #Startup #Innovation',
                'image': '🚀',
                'location': 'Austin, TX',
                'timestamp': '6h ago',
                'likes': 156,
                'comments': 23,
                'shares': 12,
                'is_liked': False,
                'is_bookmarked': True,
                'privacy': 'public'
            },
            {
                'id': '4',
                'user': {
                    'id': 'user4',
                    'name': 'Emma Davis',
                    'username': '@emmad',
                    'avatar': '👩‍🔬',
                    'verified': False
                },
                'content': 'Just read an amazing article about the future of AI in healthcare. The possibilities are endless! What are your thoughts on this?',
                'image': '🤖',
                'location': 'Boston, MA',
                'timestamp': '8h ago',
                'likes': 73,
                'comments': 15,
                'shares': 7,
                'is_liked': True,
                'is_bookmarked': False,
                'privacy': 'public'
            },
            {
                'id': '5',
                'user': {
                    'id': 'user5',
                    'name': 'Alex Rodriguez',
                    'username': '@alexr',
                    'avatar': '👨‍🎓',
                    'verified': False
                },
                'content': 'Coffee and code - the perfect combination for a productive day! ☕️💻',
                'image': '☕️',
                'location': 'Seattle, WA',
                'timestamp': '10h ago',
                'likes': 34,
                'comments': 6,
                'shares': 2,
                'is_liked': False,
                'is_bookmarked': False,
                'privacy': 'public'
            }
        ]
        
        self.posts = self.all_posts.copy()
    
    def update_posts_display(self):
        # Clear existing posts
        for child in self.posts_box.get_children():
            self.posts_box.remove(child)
        
        # Add posts
        for post in self.posts:
            post_widget = self.create_post_widget(post)
            self.posts_box.pack_start(post_widget, False, False, 0)
        
        self.posts_box.show_all()
        self.post_count_label.set_text(f"{len(self.posts)} posts")
    
    def create_post_widget(self, post):
        # Main container
        post_frame = Gtk.Frame()
        post_frame.set_margin_bottom(16)
        
        main_box = Gtk.Box(orientation=Gtk.Orientation.VERTICAL, spacing=12)
        main_box.set_margin_start(16)
        main_box.set_margin-end(16)
        main_box.set_margin-top(16)
        main_box.set_margin-bottom(16)
        
        # Header
        header_box = Gtk.Box(orientation=Gtk.Orientation.HORIZONTAL, spacing=12)
        
        # Avatar
        avatar_label = Gtk.Label()
        avatar_label.set_markup(f"<span size='xx-large'>{post['user']['avatar']}</span>")
        header_box.pack_start(avatar_label, False, False, 0)
        
        # User info
        user_info_box = Gtk.Box(orientation=Gtk.Orientation.VERTICAL, spacing=2)
        
        # Name and verification
        name_box = Gtk.Box(orientation=Gtk.Orientation.HORIZONTAL, spacing=4)
        
        name_label = Gtk.Label()
        name_label.set_markup(f"<span weight='bold'>{post['user']['name']}</span>")
        name_box.pack_start(name_label, False, False, 0)
        
        if post['user']['verified']:
            verified_label = Gtk.Label()
            verified_label.set_markup("<span color='blue'>✓</span>")
            name_box.pack_start(verified_label, False, False, 0)
        
        user_info_box.pack_start(name_box, False, False, 0)
        
        # Username and timestamp
        username_label = Gtk.Label()
        username_label.set_markup(f"<span color='gray'>{post['user']['username']} • {post['timestamp']}</span>")
        user_info_box.pack_start(username_label, False, False, 0)
        
        header_box.pack_start(user_info_box, False, False, 0)
        header_box.pack_start(Gtk.Label(), True, True, 0)  # Spacer
        
        main_box.pack_start(header_box, False, False, 0)
        
        # Content
        content_label = Gtk.Label()
        content_label.set_markup(f"<span>{post['content']}</span>")
        content_label.set_halign(Gtk.Align.START)
        content_label.set_line_wrap(True)
        main_box.pack_start(content_label, False, False, 0)
        
        # Image
        if post['image']:
            image_label = Gtk.Label()
            image_label.set_markup(f"<span size='xx-large'>{post['image']}</span>")
            image_label.set_halign(Gtk.Align.CENTER)
            main_box.pack_start(image_label, False, False, 0)
        
        # Location
        if post['location']:
            location_box = Gtk.Box(orientation=Gtk.Orientation.HORIZONTAL, spacing=4)
            
            location_icon = Gtk.Label()
            location_icon.set_markup("<span color='gray'>📍</span>")
            location_box.pack_start(location_icon, False, False, 0)
            
            location_label = Gtk.Label()
            location_label.set_markup(f"<span color='gray'>{post['location']}</span>")
            location_box.pack_start(location_label, False, False, 0)
            
            main_box.pack_start(location_box, False, False, 0)
        
        # Actions
        actions_box = Gtk.Box(orientation=Gtk.Orientation.HORIZONTAL, spacing=16)
        
        # Like button
        like_btn = Gtk.Button()
        like_icon = "❤️" if post['is_liked'] else "🤍"
        like_btn.set_label(f"{like_icon} {post['likes']}")
        like_btn.connect("clicked", self.on_like_clicked, post)
        actions_box.pack_start(like_btn, False, False, 0)
        
        # Comment button
        comment_btn = Gtk.Button()
        comment_btn.set_label(f"💬 {post['comments']}")
        comment_btn.connect("clicked", self.on_comment_clicked, post)
        actions_box.pack_start(comment_btn, False, False, 0)
        
        # Share button
        share_btn = Gtk.Button()
        share_btn.set_label(f"🔄 {post['shares']}")
        share_btn.connect("clicked", self.on_share_clicked, post)
        actions_box.pack_start(share_btn, False, False, 0)
        
        # Bookmark button
        bookmark_btn = Gtk.Button()
        bookmark_icon = "🔖" if post['is_bookmarked'] else "📌"
        bookmark_btn.set_label(bookmark_icon)
        bookmark_btn.connect("clicked", self.on_bookmark_clicked, post)
        actions_box.pack_start(bookmark_btn, False, False, 0)
        
        actions_box.pack_start(Gtk.Label(), True, True, 0)  # Spacer
        
        main_box.pack_start(actions_box, False, False, 0)
        
        post_frame.add(main_box)
        return post_frame
    
    # Event handlers
    def on_filter_changed(self, combo):
        self.current_filter = combo.get_active_text()
        # In a real implementation, this would filter posts
        self.status_label.set_text(f"Filter changed to {self.current_filter}")
    
    def on_notifications_clicked(self, button):
        dialog = Gtk.MessageDialog(self, 0, Gtk.MessageType.INFO, Gtk.ButtonsType.OK,
                                 f"You have {self.unread_notifications} unread notifications")
        dialog.run()
        dialog.destroy()
    
    def on_trending_clicked(self, button):
        dialog = Gtk.MessageDialog(self, 0, Gtk.MessageType.INFO, Gtk.ButtonsType.OK,
                                 "Top trending topics:\n#ReactNative\n#MobileDev\n#Tech\n#Startup\n#Innovation")
        dialog.run()
        dialog.destroy()
    
    def on_create_post(self, widget):
        content = self.create_post_entry.get_text().strip()
        if not content:
            return
        
        new_post = {
            'id': str(datetime.now().timestamp()),
            'user': {
                'id': 'current-user',
                'name': 'You',
                'username': '@you',
                'avatar': '👤',
                'verified': False
            },
            'content': content,
            'image': '',
            'location': '',
            'timestamp': 'now',
            'likes': 0,
            'comments': 0,
            'shares': 0,
            'is_liked': False,
            'is_bookmarked': False,
            'privacy': 'public'
        }
        
        self.posts.insert(0, new_post)
        self.all_posts.insert(0, new_post)
        self.create_post_entry.set_text("")
        self.update_posts_display()
    
    def on_like_clicked(self, button, post):
        # Toggle like
        post['is_liked'] = not post['is_liked']
        post['likes'] += 1 if post['is_liked'] else -1
        
        # Update in all_posts as well
        for all_post in self.all_posts:
            if all_post['id'] == post['id']:
                all_post['is_liked'] = post['is_liked']
                all_post['likes'] = post['likes']
                break
        
        self.update_posts_display()
    
    def on_comment_clicked(self, button, post):
        dialog = Gtk.MessageDialog(self, 0, Gtk.MessageType.INFO, Gtk.ButtonsType.OK,
                                 f"Comments for: {post['user']['name']}\n\n{post['content']}")
        dialog.run()
        dialog.destroy()
    
    def on_share_clicked(self, button, post):
        dialog = Gtk.MessageDialog(self, 0, Gtk.MessageType.INFO, Gtk.ButtonsType.OK,
                                 f"Sharing: {post['title']}")
        dialog.run()
        dialog.destroy()
    
    def on_bookmark_clicked(self, button, post):
        # Toggle bookmark
        post['is_bookmarked'] = not post['is_bookmarked']
        
        # Update in all_posts as well
        for all_post in self.all_posts:
            if all_post['id'] == post['id']:
                all_post['is_bookmarked'] = post['is_bookmarked']
                break
        
        self.update_posts_display()

def main():
    app = SocialMediaFeed()
    app.connect("destroy", Gtk.main_quit)
    app.show_all()
    Gtk.main()

if __name__ == "__main__":
    main()

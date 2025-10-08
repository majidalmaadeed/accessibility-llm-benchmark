import gi
gi.require_version('Gtk', '3.0')
from gi.repository import Gtk, GObject, GLib

class SmallTouchTarget(Gtk.Window):
    def __init__(self):
        Gtk.Window.__init__(self, title="Social Media Feed")
        self.set_default_size(600, 800)
        self.set_border_width(10)
        
        # Main container
        main_box = Gtk.VBox(spacing=0)
        self.add(main_box)
        
        # Tab navigation
        tab_box = Gtk.HBox(spacing=0)
        
        following_button = Gtk.Button("Following")
        following_button.get_style_context().add_class("suggested-action")
        tab_box.pack_start(following_button, True, True, 0)
        
        discover_button = Gtk.Button("Discover")
        tab_box.pack_start(discover_button, True, True, 0)
        
        trending_button = Gtk.Button("Trending")
        tab_box.pack_start(trending_button, True, True, 0)
        
        main_box.pack_start(tab_box, False, False, 0)
        
        # Posts scrollable area
        scrolled_window = Gtk.ScrolledWindow()
        scrolled_window.set_policy(Gtk.PolicyType.AUTOMATIC, Gtk.PolicyType.AUTOMATIC)
        
        posts_box = Gtk.VBox(spacing=15)
        posts_box.set_margin_left(20)
        posts_box.set_margin_right(20)
        posts_box.set_margin_top(20)
        posts_box.set_margin_bottom(20)
        
        # Load posts
        self.load_posts(posts_box)
        
        scrolled_window.add(posts_box)
        main_box.pack_start(scrolled_window, True, True, 0)
        
    def load_posts(self, container):
        posts = [
            {
                "username": "john_doe",
                "time_ago": "2h",
                "content": "Beautiful sunset from my hike today! 🏔️ #nature #photography",
                "likes": 42,
                "comments": 8,
                "is_liked": False,
                "is_bookmarked": False
            },
            {
                "username": "sarah_j",
                "time_ago": "4h",
                "content": "Just finished reading an amazing book! Highly recommend it to everyone.",
                "likes": 28,
                "comments": 12,
                "is_liked": False,
                "is_bookmarked": False
            },
            {
                "username": "mike_chen",
                "time_ago": "6h",
                "content": "Working on a new project. Excited to share the results soon!",
                "likes": 15,
                "comments": 3,
                "is_liked": False,
                "is_bookmarked": False
            }
        ]
        
        for post in posts:
            post_frame = self.create_post_card(post)
            container.pack_start(post_frame, False, False, 0)
    
    def create_post_card(self, post):
        # Post frame
        frame = Gtk.Frame()
        frame.set_shadow_type(Gtk.ShadowType.ETCHED_IN)
        frame.set_margin_left(10)
        frame.set_margin_right(10)
        frame.set_margin_top(10)
        frame.set_margin_bottom(10)
        
        main_box = Gtk.VBox(spacing=10)
        main_box.set_margin_left(15)
        main_box.set_margin_right(15)
        main_box.set_margin_top(15)
        main_box.set_margin_bottom(15)
        frame.add(main_box)
        
        # Profile section
        profile_box = Gtk.HBox(spacing=12)
        
        # Profile image
        profile_image = Gtk.Image()
        profile_image.set_from_icon_name("avatar-default", Gtk.IconSize.BUTTON)
        profile_image.set_pixel_size(40)
        profile_box.pack_start(profile_image, False, False, 0)
        
        # Username and time
        user_info_box = Gtk.VBox(spacing=2)
        
        username_label = Gtk.Label()
        username_label.set_markup(f"<span weight='bold'>{post['username']}</span>")
        username_label.set_halign(Gtk.Align.START)
        user_info_box.pack_start(username_label, False, False, 0)
        
        time_label = Gtk.Label(post['time_ago'])
        time_label.set_halign(Gtk.Align.START)
        user_info_box.pack_start(time_label, False, False, 0)
        
        profile_box.pack_start(user_info_box, False, False, 0)
        
        # SMALL TOUCH TARGET - Only 20x20px on mobile interface
        more_button = Gtk.Button("⋯")
        more_button.set_size_request(20, 20)  # SMALL TOUCH TARGET
        more_button.get_style_context().add_class("small-button")
        profile_box.pack_start(more_button, False, False, 0)
        
        main_box.pack_start(profile_box, False, False, 0)
        
        # Post image
        post_image = Gtk.Image()
        post_image.set_from_icon_name("image-x-generic", Gtk.IconSize.DIALOG)
        post_image.set_pixel_size(300)
        main_box.pack_start(post_image, False, False, 0)
        
        # Post actions
        actions_box = Gtk.HBox(spacing=16)
        
        # SMALL TOUCH TARGET - Only 20x20px
        like_button = Gtk.Button("♡" if not post['is_liked'] else "♥")
        like_button.set_size_request(20, 20)  # SMALL TOUCH TARGET
        like_button.get_style_context().add_class("small-button")
        actions_box.pack_start(like_button, False, False, 0)
        
        # SMALL TOUCH TARGET - Only 20x20px
        comment_button = Gtk.Button("💬")
        comment_button.set_size_request(20, 20)  # SMALL TOUCH TARGET
        comment_button.get_style_context().add_class("small-button")
        actions_box.pack_start(comment_button, False, False, 0)
        
        # SMALL TOUCH TARGET - Only 20x20px
        share_button = Gtk.Button("↗️")
        share_button.set_size_request(20, 20)  # SMALL TOUCH TARGET
        share_button.get_style_context().add_class("small-button")
        actions_box.pack_start(share_button, False, False, 0)
        
        # SMALL TOUCH TARGET - Only 20x20px
        bookmark_button = Gtk.Button("🔖")
        bookmark_button.set_size_request(20, 20)  # SMALL TOUCH TARGET
        bookmark_button.get_style_context().add_class("small-button")
        actions_box.pack_start(bookmark_button, False, False, 0)
        
        main_box.pack_start(actions_box, False, False, 0)
        
        # Likes count
        likes_label = Gtk.Label()
        likes_label.set_markup(f"<span weight='bold'>{post['likes']} likes</span>")
        likes_label.set_halign(Gtk.Align.START)
        main_box.pack_start(likes_label, False, False, 0)
        
        # Post content
        content_label = Gtk.Label()
        content_label.set_markup(f"<span weight='bold'>{post['username']}</span> {post['content']}")
        content_label.set_line_wrap(True)
        content_label.set_halign(Gtk.Align.START)
        main_box.pack_start(content_label, False, False, 0)
        
        # Comments link
        comments_label = Gtk.Label(f"View all {post['comments']} comments")
        comments_label.set_halign(Gtk.Align.START)
        main_box.pack_start(comments_label, False, False, 0)
        
        return frame

def main():
    # Add CSS for styling
    css_provider = Gtk.CssProvider()
    css = """
    .small-button {
        background-color: #e0e0e0;
        border-radius: 4px;
        padding: 2px;
    }
    .small-button:hover {
        background-color: #d0d0d0;
    }
    """
    css_provider.load_from_data(css.encode())
    
    win = SmallTouchTarget()
    win.connect("destroy", Gtk.main_quit)
    win.show_all()
    Gtk.main()

if __name__ == "__main__":
    main()

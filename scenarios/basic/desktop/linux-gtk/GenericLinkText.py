import gi
gi.require_version('Gtk', '3.0')
from gi.repository import Gtk, GObject, GLib

class GenericLinkText(Gtk.Window):
    def __init__(self):
        Gtk.Window.__init__(self, title="Tech Blog")
        self.set_default_size(1000, 700)
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
        
        # Featured article section
        featured_frame = Gtk.Frame()
        featured_frame.set_shadow_type(Gtk.ShadowType.ETCHED_IN)
        featured_frame.set_margin_top(20)
        featured_frame.set_margin_bottom=20
        
        featured_box = Gtk.VBox(spacing=15)
        featured_box.set_margin_left(20)
        featured_box.set_margin_right(20)
        featured_box.set_margin_top(20)
        featured_box.set_margin_bottom(20)
        
        # Featured article image
        featured_image = Gtk.Image()
        featured_image.set_from_icon_name("applications-graphics", Gtk.IconSize.DIALOG)
        featured_image.set_pixel_size(300)
        featured_image.set_halign(Gtk.Align.CENTER)
        featured_box.pack_start(featured_image, False, False, 0)
        
        # Featured article content
        featured_title = Gtk.Label()
        featured_title.set_markup("<span size='xx-large' weight='bold'>Building Scalable React Native Applications</span>")
        featured_title.set_line_wrap(True)
        featured_title.set_halign(Gtk.Align.CENTER)
        featured_box.pack_start(featured_title, False, False, 0)
        
        featured_content = Gtk.Label()
        featured_content.set_markup("<span size='large'>Discover the key principles and patterns for creating maintainable and scalable React Native applications that can grow with your business needs.</span>")
        featured_content.set_line_wrap(True)
        featured_content.set_halign(Gtk.Align.CENTER)
        featured_box.pack_start(featured_content, False, False, 0)
        
        # Author section
        author_box = Gtk.HBox(spacing=10)
        author_box.set_halign(Gtk.Align.CENTER)
        
        author_image = Gtk.Image()
        author_image.set_from_icon_name("avatar-default", Gtk.IconSize.BUTTON)
        author_image.set_pixel_size(40)
        author_box.pack_start(author_image, False, False, 0)
        
        author_info_box = Gtk.VBox(spacing=2)
        
        author_name = Gtk.Label("Alex Thompson")
        author_name.set_markup("<span weight='bold'>Alex Thompson</span>")
        author_name.set_halign(Gtk.Align.START)
        author_info_box.pack_start(author_name, False, False, 0)
        
        publish_date = Gtk.Label("January 20, 2024")
        publish_date.set_halign(Gtk.Align.START)
        author_info_box.pack_start(publish_date, False, False, 0)
        
        read_time = Gtk.Label("12 min read")
        read_time.set_halign(Gtk.Align.START)
        author_info_box.pack_start(read_time, False, False, 0)
        
        author_box.pack_start(author_info_box, False, False, 0)
        
        featured_box.pack_start(author_box, False, False, 0)
        
        # GENERIC LINK TEXT - "Read more" without context
        read_more_button = Gtk.Button("Read more")
        read_more_button.get_style_context().add_class("suggested-action")
        read_more_button.set_size_request(120, 40)
        read_more_button.connect("clicked", self.on_read_more_clicked)
        featured_box.pack_start(read_more_button, False, False, 0)
        
        featured_frame.add(featured_box)
        main_box.pack_start(featured_frame, False, False, 0)
        
        # Articles section
        articles_label = Gtk.Label()
        articles_label.set_markup("<span size='x-large' weight='bold'>Recent Articles</span>")
        articles_label.set_halign(Gtk.Align.START)
        articles_label.set_margin_left(20)
        articles_label.set_margin_top(20)
        articles_label.set_margin_bottom(10)
        main_box.pack_start(articles_label, False, False, 0)
        
        # Articles scrollable area
        scrolled_window = Gtk.ScrolledWindow()
        scrolled_window.set_policy(Gtk.PolicyType.AUTOMATIC, Gtk.PolicyType.AUTOMATIC)
        
        articles_box = Gtk.VBox(spacing=15)
        articles_box.set_margin_left(20)
        articles_box.set_margin_right(20)
        articles_box.set_margin_bottom=20
        
        # Load articles
        self.load_articles(articles_box)
        
        scrolled_window.add(articles_box)
        main_box.pack_start(scrolled_window, True, True, 0)
        
    def load_articles(self, container):
        articles = [
            {
                "category": "Technology",
                "title": "Understanding Flutter Performance Optimization",
                "content": "Learn how to optimize your Flutter applications for better performance and user experience.",
                "author": "John Smith",
                "date": "2024-01-15",
                "read_time": "15 min",
                "image": "applications-graphics"
            },
            {
                "category": "Design",
                "title": "Mobile UI/UX Design Best Practices",
                "content": "Essential design principles for creating intuitive and accessible mobile interfaces.",
                "author": "Sarah Johnson",
                "date": "2024-01-12",
                "read_time": "12 min",
                "image": "applications-graphics"
            },
            {
                "category": "Technology",
                "title": "Cross-Platform Development Strategies",
                "content": "Compare different approaches to building apps that work across multiple platforms.",
                "author": "Mike Chen",
                "date": "2024-01-10",
                "read_time": "18 min",
                "image": "applications-graphics"
            },
            {
                "category": "Business",
                "title": "Startup Funding Strategies",
                "content": "Navigate the complex world of startup funding and investment opportunities.",
                "author": "Emily Davis",
                "date": "2024-01-08",
                "read_time": "20 min",
                "image": "applications-graphics"
            },
            {
                "category": "Science",
                "title": "Artificial Intelligence in Healthcare",
                "content": "Exploring the latest advances in AI applications for medical diagnosis and treatment.",
                "author": "Dr. Robert Kim",
                "date": "2024-01-05",
                "read_time": "25 min",
                "image": "applications-graphics"
            }
        ]
        
        for article in articles:
            article_frame = self.create_article_card(article)
            container.pack_start(article_frame, False, False, 0)
    
    def create_article_card(self, article):
        # Article frame
        frame = Gtk.Frame()
        frame.set_shadow_type(Gtk.ShadowType.ETCHED_IN)
        
        main_box = Gtk.HBox(spacing=15)
        main_box.set_margin_left(15)
        main_box.set_margin_right(15)
        main_box.set_margin_top(15)
        main_box.set_margin_bottom(15)
        frame.add(main_box)
        
        # Article image
        article_image = Gtk.Image()
        article_image.set_from_icon_name(article["image"], Gtk.IconSize.DIALOG)
        article_image.set_pixel_size(80)
        article_image.set_size_request(120, 80)
        main_box.pack_start(article_image, False, False, 0)
        
        # Article content
        content_box = Gtk.VBox(spacing=8)
        
        # Category label
        category_label = Gtk.Label(article["category"])
        category_label.set_markup(f"<span weight='bold' color='white'>{article['category']}</span>")
        category_label.get_style_context().add_class("category-label")
        category_label.set_halign(Gtk.Align.START)
        content_box.pack_start(category_label, False, False, 0)
        
        # Article title
        title_label = Gtk.Label()
        title_label.set_markup(f"<span weight='bold' size='large'>{article['title']}</span>")
        title_label.set_line_wrap(True)
        title_label.set_halign(Gtk.Align.START)
        content_box.pack_start(title_label, False, False, 0)
        
        # Article content
        content_label = Gtk.Label(article["content"])
        content_label.set_line_wrap(True)
        content_label.set_halign(Gtk.Align.START)
        content_box.pack_start(content_label, False, False, 0)
        
        # Author and date
        author_date_label = Gtk.Label(f"By {article['author']} • {article['date']}")
        author_date_label.set_halign(Gtk.Align.START)
        content_box.pack_start(author_date_label, False, False, 0)
        
        main_box.pack_start(content_box, True, True, 0)
        
        # Actions
        actions_box = Gtk.VBox(spacing=10)
        
        # GENERIC LINK TEXT - "Read more" without context
        read_more_button = Gtk.Button("Read more")
        read_more_button.get_style_context().add_class("suggested-action")
        read_more_button.set_size_request(100, 30)
        read_more_button.connect("clicked", self.on_article_read_more_clicked, article)
        actions_box.pack_start(read_more_button, False, False, 0)
        
        share_button = Gtk.Button("↗️")
        share_button.set_size_request(30, 30)
        share_button.connect("clicked", self.on_share_clicked, article)
        actions_box.pack_start(share_button, False, False, 0)
        
        main_box.pack_start(actions_box, False, False, 0)
        
        return frame
    
    def on_read_more_clicked(self, button):
        dialog = Gtk.MessageDialog(
            transient_for=self,
            flags=0,
            message_type=Gtk.MessageType.INFO,
            buttons=Gtk.ButtonsType.OK,
            text="Read More"
        )
        dialog.format_secondary_text("This would open the full article content.")
        dialog.run()
        dialog.destroy()
    
    def on_article_read_more_clicked(self, button, article):
        dialog = Gtk.MessageDialog(
            transient_for=self,
            flags=0,
            message_type=Gtk.MessageType.INFO,
            buttons=Gtk.ButtonsType.OK,
            text=article["title"]
        )
        dialog.format_secondary_text(f"""
Category: {article['category']}
Author: {article['author']}
Date: {article['date']}
Read Time: {article['read_time']}

{article['content']}
        """)
        dialog.run()
        dialog.destroy()
    
    def on_share_clicked(self, button, article):
        dialog = Gtk.MessageDialog(
            transient_for=self,
            flags=0,
            message_type=Gtk.MessageType.INFO,
            buttons=Gtk.ButtonsType.OK,
            text="Share Article"
        )
        dialog.format_secondary_text(f"Share: {article['title']}")
        dialog.run()
        dialog.destroy()

def main():
    # Add CSS for styling
    css_provider = Gtk.CssProvider()
    css = """
    .category-label {
        background-color: #2196F3;
        border-radius: 4px;
        padding: 2px 6px;
    }
    """
    css_provider.load_from_data(css.encode())
    
    win = GenericLinkText()
    win.connect("destroy", Gtk.main_quit)
    win.show_all()
    Gtk.main()

if __name__ == "__main__":
    main()

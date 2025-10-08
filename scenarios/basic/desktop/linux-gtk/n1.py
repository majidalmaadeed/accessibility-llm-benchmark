import gi
gi.require_version('Gtk', '3.0')
from gi.repository import Gtk, GObject, GLib
import threading
import time

class AutoPlayingBackgroundVideo(Gtk.Window):
    def __init__(self):
        Gtk.Window.__init__(self, title="Video Platform")
        self.set_default_size(1000, 700)
        self.set_border_width(10)
        
        # Main container
        main_box = Gtk.VBox(spacing=0)
        self.add(main_box)
        
        # Hero section with auto-playing background video
        hero_frame = Gtk.Frame()
        hero_frame.set_size_request(-1, 300)
        hero_frame.get_style_context().add_class("hero-video")
        
        # Video overlay
        video_overlay = Gtk.Overlay()
        
        # Video placeholder
        video_box = Gtk.VBox()
        video_box.set_halign(Gtk.Align.CENTER)
        video_box.set_valign(Gtk.Align.CENTER)
        
        # AUTO-PLAYING BACKGROUND VIDEO - Hero section video autoplays without user control
        video_icon = Gtk.Label("🎬")
        video_icon.set_markup("<span size='xx-large'>🎬</span>")
        video_box.pack_start(video_icon, False, False, 0)
        
        video_title = Gtk.Label("Auto-playing Video")
        video_title.set_markup("<span size='xx-large' weight='bold' color='white'>Auto-playing Video</span>")
        video_title.set_halign(Gtk.Align.CENTER)
        video_box.pack_start(video_title, False, False, 0)
        
        video_subtitle = Gtk.Label("This video plays automatically")
        video_subtitle.set_markup("<span size='large' color='white'>This video plays automatically</span>")
        video_subtitle.set_halign(Gtk.Align.CENTER)
        video_box.pack_start(video_subtitle, False, False, 0)
        
        video_overlay.add(video_box)
        
        # Play/Pause button overlay
        self.play_pause_button = Gtk.Button("⏸️")
        self.play_pause_button.set_size_request(60, 60)
        self.play_pause_button.get_style_context().add_class("video-control")
        self.play_pause_button.connect("clicked", self.on_play_pause_clicked)
        
        video_overlay.add_overlay(self.play_pause_button)
        video_overlay.set_overlay_pass_through(self.play_pause_button, True)
        
        # Position the play button
        self.play_pause_button.set_halign(Gtk.Align.END)
        self.play_pause_button.set_valign(Gtk.Align.START)
        self.play_pause_button.set_margin_top(20)
        self.play_pause_button.set_margin_end(20)
        
        hero_frame.add(video_overlay)
        main_box.pack_start(hero_frame, False, False, 0)
        
        # Main content
        scrolled_window = Gtk.ScrolledWindow()
        scrolled_window.set_policy(Gtk.PolicyType.AUTOMATIC, Gtk.PolicyType.AUTOMATIC)
        
        content_box = Gtk.VBox(spacing=20)
        content_box.set_margin_left(20)
        content_box.set_margin_right(20)
        content_box.set_margin_top(20)
        content_box.set_margin_bottom(20)
        
        # Featured content
        featured_label = Gtk.Label()
        featured_label.set_markup("<span size='xx-large' weight='bold'>Featured Content</span>")
        featured_label.set_halign(Gtk.Align.CENTER)
        content_box.pack_start(featured_label, False, False, 0)
        
        featured_subtitle = Gtk.Label("Discover our latest videos and tutorials")
        featured_subtitle.set_markup("<span size='large'>Discover our latest videos and tutorials</span>")
        featured_subtitle.set_halign(Gtk.Align.CENTER)
        content_box.pack_start(featured_subtitle, False, False, 0)
        
        # Video categories
        categories_label = Gtk.Label()
        categories_label.set_markup("<span size='x-large' weight='bold'>Video Categories</span>")
        categories_label.set_halign(Gtk.Align.START)
        content_box.pack_start(categories_label, False, False, 0)
        
        categories_grid = Gtk.Grid()
        categories_grid.set_column_spacing(20)
        categories_grid.set_row_spacing(20)
        
        categories = [
            ("🎥", "Tutorials", "Learn new skills"),
            ("🎬", "Documentaries", "Explore the world"),
            ("🎭", "Entertainment", "Fun and games")
        ]
        
        for i, (icon, title, subtitle) in enumerate(categories):
            category_frame = self.create_category_card(icon, title, subtitle)
            categories_grid.attach(category_frame, i % 3, i // 3, 1, 1)
        
        content_box.pack_start(categories_grid, False, False, 0)
        
        # Recent videos
        recent_label = Gtk.Label()
        recent_label.set_markup("<span size='x-large' weight='bold'>Recent Videos</span>")
        recent_label.set_halign(Gtk.Align.START)
        content_box.pack_start(recent_label, False, False, 0)
        
        # Recent videos list
        recent_videos_box = Gtk.VBox(spacing=15)
        
        videos = [
            {
                "title": "Getting Started with SwiftUI",
                "content": "Learn the basics of SwiftUI development",
                "author": "John Smith",
                "duration": "15 min",
                "image": "applications-graphics"
            },
            {
                "title": "Advanced iOS Development",
                "content": "Master advanced iOS development techniques",
                "author": "Sarah Johnson",
                "duration": "25 min",
                "image": "applications-graphics"
            },
            {
                "title": "Flutter Performance Optimization",
                "content": "Optimize your Flutter apps for better performance",
                "author": "Mike Chen",
                "duration": "20 min",
                "image": "applications-graphics"
            },
            {
                "title": "React Native Best Practices",
                "content": "Best practices for React Native development",
                "author": "Emily Davis",
                "duration": "18 min",
                "image": "applications-graphics"
            }
        ]
        
        for video in videos:
            video_frame = self.create_video_card(video)
            recent_videos_box.pack_start(video_frame, False, False, 0)
        
        content_box.pack_start(recent_videos_box, False, False, 0)
        
        scrolled_window.add(content_box)
        main_box.pack_start(scrolled_window, True, True, 0)
        
        # State
        self.is_playing = True
        self.current_time = 0.0
        self.duration = 30.0
        
        # Start auto-play
        self.start_auto_play()
        
    def create_category_card(self, icon, title, subtitle):
        frame = Gtk.Frame()
        frame.set_shadow_type(Gtk.ShadowType.ETCHED_IN)
        frame.set_size_request(200, 120)
        
        box = Gtk.VBox(spacing=8)
        box.set_margin_left(15)
        box.set_margin_right(15)
        box.set_margin_top(15)
        box.set_margin_bottom(15)
        
        icon_label = Gtk.Label(icon)
        icon_label.set_markup(f"<span size='xx-large'>{icon}</span>")
        icon_label.set_halign(Gtk.Align.CENTER)
        box.pack_start(icon_label, False, False, 0)
        
        title_label = Gtk.Label()
        title_label.set_markup(f"<span weight='bold'>{title}</span>")
        title_label.set_halign(Gtk.Align.CENTER)
        box.pack_start(title_label, False, False, 0)
        
        subtitle_label = Gtk.Label(subtitle)
        subtitle_label.set_halign(Gtk.Align.CENTER)
        box.pack_start(subtitle_label, False, False, 0)
        
        frame.add(box)
        return frame
    
    def create_video_card(self, video):
        frame = Gtk.Frame()
        frame.set_shadow_type(Gtk.ShadowType.ETCHED_IN)
        
        main_box = Gtk.HBox(spacing=15)
        main_box.set_margin_left(15)
        main_box.set_margin_right(15)
        main_box.set_margin_top(15)
        main_box.set_margin_bottom(15)
        frame.add(main_box)
        
        # Video thumbnail
        thumbnail = Gtk.Image()
        thumbnail.set_from_icon_name(video["image"], Gtk.IconSize.DIALOG)
        thumbnail.set_pixel_size(80)
        thumbnail.set_size_request(120, 80)
        main_box.pack_start(thumbnail, False, False, 0)
        
        # Video content
        content_box = Gtk.VBox(spacing=8)
        
        title_label = Gtk.Label()
        title_label.set_markup(f"<span weight='bold' size='large'>{video['title']}</span>")
        title_label.set_line_wrap(True)
        title_label.set_halign(Gtk.Align.START)
        content_box.pack_start(title_label, False, False, 0)
        
        content_label = Gtk.Label(video["content"])
        content_label.set_line_wrap(True)
        content_label.set_halign(Gtk.Align.START)
        content_box.pack_start(content_label, False, False, 0)
        
        author_label = Gtk.Label(f"By {video['author']} • {video['duration']}")
        author_label.set_halign(Gtk.Align.START)
        content_box.pack_start(author_label, False, False, 0)
        
        main_box.pack_start(content_box, True, True, 0)
        
        # Actions
        actions_box = Gtk.VBox(spacing=10)
        
        play_button = Gtk.Button("▶️")
        play_button.set_size_request(40, 40)
        play_button.connect("clicked", self.on_video_play_clicked, video)
        actions_box.pack_start(play_button, False, False, 0)
        
        share_button = Gtk.Button("↗️")
        share_button.set_size_request(40, 40)
        share_button.connect("clicked", self.on_video_share_clicked, video)
        actions_box.pack_start(share_button, False, False, 0)
        
        main_box.pack_start(actions_box, False, False, 0)
        
        return frame
    
    def start_auto_play(self):
        def play_loop():
            while True:
                if self.is_playing:
                    self.current_time += 0.1
                    if self.current_time >= self.duration:
                        self.current_time = 0
                time.sleep(0.1)
        
        thread = threading.Thread(target=play_loop, daemon=True)
        thread.start()
    
    def on_play_pause_clicked(self, button):
        self.is_playing = not self.is_playing
        if self.is_playing:
            button.set_label("⏸️")
        else:
            button.set_label("▶️")
    
    def on_video_play_clicked(self, button, video):
        dialog = Gtk.MessageDialog(
            transient_for=self,
            flags=0,
            message_type=Gtk.MessageType.INFO,
            buttons=Gtk.ButtonsType.OK,
            text="Play Video"
        )
        dialog.format_secondary_text(f"Playing: {video['title']}")
        dialog.run()
        dialog.destroy()
    
    def on_video_share_clicked(self, button, video):
        dialog = Gtk.MessageDialog(
            transient_for=self,
            flags=0,
            message_type=Gtk.MessageType.INFO,
            buttons=Gtk.ButtonsType.OK,
            text="Share Video"
        )
        dialog.format_secondary_text(f"Share: {video['title']}")
        dialog.run()
        dialog.destroy()

def main():
    # Add CSS for styling
    css_provider = Gtk.CssProvider()
    css = """
    .hero-video {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    }
    .video-control {
        background-color: rgba(0, 0, 0, 0.5);
        border-radius: 30px;
        color: white;
    }
    .video-control:hover {
        background-color: rgba(0, 0, 0, 0.7);
    }
    """
    css_provider.load_from_data(css.encode())
    
    win = AutoPlayingBackgroundVideo()
    win.connect("destroy", Gtk.main_quit)
    win.show_all()
    Gtk.main()

if __name__ == "__main__":
    main()

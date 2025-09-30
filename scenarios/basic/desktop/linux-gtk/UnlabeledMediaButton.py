import gi
gi.require_version('Gtk', '3.0')
from gi.repository import Gtk, GObject, GLib
import threading
import time

class UnlabeledMediaButton(Gtk.Window):
    def __init__(self):
        Gtk.Window.__init__(self, title="Video Player")
        self.set_default_size(800, 600)
        self.set_border_width(10)
        
        # Main container
        main_box = Gtk.VBox(spacing=10)
        self.add(main_box)
        
        # Header
        header_label = Gtk.Label()
        header_label.set_markup("<span size='large' weight='bold'>Video Player</span>")
        header_label.set_halign(Gtk.Align.CENTER)
        main_box.pack_start(header_label, False, False, 0)
        
        # Video area
        video_frame = Gtk.Frame()
        video_frame.set_size_request(400, 300)
        video_frame.set_shadow_type(Gtk.ShadowType.IN)
        
        # Video placeholder
        video_box = Gtk.VBox()
        video_box.set_halign(Gtk.Align.CENTER)
        video_box.set_valign(Gtk.Align.CENTER)
        
        # Video image placeholder
        video_image = Gtk.Image()
        video_image.set_from_icon_name("video-x-generic", Gtk.IconSize.DIALOG)
        video_image.set_pixel_size(200)
        video_box.pack_start(video_image, True, True, 0)
        
        # Video title
        title_label = Gtk.Label("Flutter Development Tutorial")
        title_label.set_markup("<span size='large' weight='bold'>Flutter Development Tutorial</span>")
        video_box.pack_start(title_label, False, False, 5)
        
        video_frame.add(video_box)
        main_box.pack_start(video_frame, True, True, 0)
        
        # Progress bar
        progress_box = Gtk.HBox(spacing=10)
        progress_box.set_halign(Gtk.Align.CENTER)
        
        self.progress_bar = Gtk.ProgressBar()
        self.progress_bar.set_fraction(0.3)
        self.progress_bar.set_size_request(300, 20)
        progress_box.pack_start(self.progress_bar, False, False, 0)
        
        # Time labels
        time_box = Gtk.HBox(spacing=10)
        time_box.set_halign(Gtk.Align.CENTER)
        
        current_time_label = Gtk.Label("2:15")
        duration_label = Gtk.Label("7:30")
        
        time_box.pack_start(current_time_label, False, False, 0)
        time_box.pack_start(duration_label, False, False, 0)
        
        progress_box.pack_start(time_box, False, False, 0)
        main_box.pack_start(progress_box, False, False, 0)
        
        # Controls
        controls_box = Gtk.HBox(spacing=10)
        controls_box.set_halign(Gtk.Align.CENTER)
        
        # UNLABELED MEDIA BUTTON - Video play button using only emoji icon without accessible name
        self.play_button = Gtk.Button()
        self.play_button.set_label("▶️")
        self.play_button.set_size_request(60, 60)
        self.play_button.connect("clicked", self.on_play_clicked)
        controls_box.pack_start(self.play_button, False, False, 0)
        
        # Other control buttons
        prev_button = Gtk.Button("⏮️")
        prev_button.set_size_request(50, 50)
        controls_box.pack_start(prev_button, False, False, 0)
        
        next_button = Gtk.Button("⏭️")
        next_button.set_size_request(50, 50)
        controls_box.pack_start(next_button, False, False, 0)
        
        volume_button = Gtk.Button("🔊")
        volume_button.set_size_request(50, 50)
        controls_box.pack_start(volume_button, False, False, 0)
        
        fullscreen_button = Gtk.Button("⛶")
        fullscreen_button.set_size_request(50, 50)
        controls_box.pack_start(fullscreen_button, False, False, 0)
        
        main_box.pack_start(controls_box, False, False, 0)
        
        # State
        self.is_playing = False
        
    def on_play_clicked(self, button):
        self.is_playing = not self.is_playing
        if self.is_playing:
            button.set_label("⏸️")
        else:
            button.set_label("▶️")

def main():
    win = UnlabeledMediaButton()
    win.connect("destroy", Gtk.main_quit)
    win.show_all()
    Gtk.main()

if __name__ == "__main__":
    main()

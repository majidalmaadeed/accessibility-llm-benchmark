#!/usr/bin/env python3
"""
AccordionWithoutState - Linux GTK Implementation
"""
import gi
gi.require_version('Gtk', '3.0')
from gi.repository import Gtk, GObject, GLib
class AccordionWithoutState(Gtk.Window):
    def __init__(self):
        self.set_default_size(600, 700)
        self.set_resizable(True)
        # State
        self.expanded_items = set()
        self.faq_items = []
        self.setup_faq_items()
        self.setup_ui()
    def setup_faq_items(self):
        self.faq_items = [
            {
            },
            {
            },
            {
                "question": "What are the WCAG guidelines?",
            },
            {
            }
        ]
    def setup_ui(self):
        # Main container
        main_box = Gtk.Box(orientation=Gtk.Orientation.VERTICAL, spacing=20)
        main_box.set_margin_left(20)
        main_box.set_margin_right(20)
        main_box.set_margin_top(20)
        main_box.set_margin_bottom(20)
        self.add(main_box)
        # Main content card
        main_card = Gtk.Frame()
        main_card.set_shadow_type(Gtk.ShadowType.ETCHED_IN)
        main_card.set_margin_bottom(20)
        card_content = Gtk.Box(orientation=Gtk.Orientation.VERTICAL, spacing=20)
        card_content.set_margin_left(30)
        card_content.set_margin_right(30)
        card_content.set_margin_top(30)
        card_content.set_margin_bottom(30)
        main_card.add(card_content)
        # Title
        # Description
        # FAQ Accordion
        self.accordion_box = Gtk.Box(orientation=Gtk.Orientation.VERTICAL, spacing=10)
        card_content.pack_start(self.accordion_box, False, False, 0)
        # Create accordion items
        for index, item in enumerate(self.faq_items):
            self.create_accordion_item(item, index)
        main_box.pack_start(main_card, False, False, 0)
    def create_accordion_item(self, item, index):
        # Container for the accordion item
        item_container = Gtk.Frame()
        item_container.set_shadow_type(Gtk.ShadowType.ETCHED_IN)
        item_container.set_name(f"accordion-item-{index}")
        # Main stack view for question and answer
        main_stack = Gtk.Stack()
        main_stack.set_transition_type(Gtk.StackTransitionType.NONE)
        question_button = Gtk.Button()
        question_button.set_relief(Gtk.ReliefStyle.NONE)
        question_button.set_halign(Gtk.Align.FILL)
        question_button.set_name(f"question-button-{index}")
        question_content = Gtk.Box(orientation=Gtk.Orientation.HORIZONTAL, spacing=10)
        question_content.set_margin_left(20)
        question_content.set_margin_right(20)
        question_content.set_margin_top(15)
        question_content.set_margin_bottom(15)
        question_button.add(question_content)
        question_button.connect("clicked", self.on_question_clicked, index)
        answer_frame = Gtk.Frame()
        answer_frame.set_shadow_type(Gtk.ShadowType.NONE)
        answer_frame.set_name(f"answer-frame-{index}")
        answer_frame.set_visible(False)
        answer_content = Gtk.Box(orientation=Gtk.Orientation.VERTICAL, spacing=0)
        answer_content.set_margin_left(20)
        answer_content.set_margin_right(20)
        answer_content.set_margin_top(15)
        answer_content.set_margin_bottom(15)
        answer_frame.add(answer_content)
        # Add to main stack
        main_stack.add_named(question_button, "question")
        main_stack.add_named(answer_frame, "answer")
        # Add to container
        item_container.add(main_stack)
        # Store references for later use
        self.accordion_box.pack_start(item_container, False, False, 0)
        info_frame = Gtk.Frame()
        info_frame.set_shadow_type(Gtk.ShadowType.ETCHED_IN)
        info_content = Gtk.Box(orientation=Gtk.Orientation.VERTICAL, spacing=15)
        info_content.set_margin_left(20)
        info_content.set_margin_right(20)
        info_content.set_margin_top(20)
        info_content.set_margin_bottom(20)
        info_frame.add(info_content)
        issues_text.set_halign(Gtk.Align.START)
        issues_text.set_line_wrap(True)
        info_content.pack_start(issues_text, False, False, 0)
        # How to Fix
        fix_title.set_markup("<b>How to Fix:</b>")
        fix_title.set_halign(Gtk.Align.START)
        info_content.pack_start(fix_title, False, False, 0)
        fix_text.set_halign(Gtk.Align.START)
        fix_text.set_line_wrap(True)
        info_content.pack_start(fix_text, False, False, 0)
        parent_box.pack_start(info_frame, False, False, 0)
        # Basic setup only
        for index, item in enumerate(self.faq_items):
            question_button = self.accordion_box.get_children()[index].get_children()[0].get_children()[0]
            question_button.set_name(f"question-button-{index}")
    def on_question_clicked(self, button, index):
        self.toggle_question(index)
    def toggle_question(self, index):
        if index in self.expanded_items:
            self.expanded_items.remove(index)
        else:
            self.expanded_items.add(index)
        # Update UI
        self.update_accordion_item(index)
    def update_accordion_item(self, index):
        # Find the accordion item
        item_container = self.accordion_box.get_children()[index]
        main_stack = item_container.get_children()[0]
        is_expanded = index in self.expanded_items
        # Update answer frame visibility
        answer_frame = main_stack.get_child_by_name("answer")
        answer_frame.set_visible(is_expanded)
        # Update indicator
        question_button = main_stack.get_child_by_name("question")
        question_content = question_button.get_children()[0]
    def do_key_press_event(self, event):
        # Should handle Arrow keys to navigate between accordion items
        # Should handle Home/End keys to go to first/last item
        # Should handle Enter/Space to toggle items
        if event.keyval == Gtk.KEY_Return or event.keyval == Gtk.KEY_space:
            # Allow default button behavior
            return super().do_key_press_event(event)
        elif event.keyval == Gtk.KEY_Down:
            pass
        elif event.keyval == Gtk.KEY_Up:
            pass
        elif event.keyval == Gtk.KEY_Home:
            if self.accordion_box.get_children():
                first_item = self.accordion_box.get_children()[0]
                question_button = first_item.get_children()[0].get_child_by_name("question")
        elif event.keyval == Gtk.KEY_End:
            if self.accordion_box.get_children():
                last_item = self.accordion_box.get_children()[-1]
                question_button = last_item.get_children()[0].get_child_by_name("question")
        return super().do_key_press_event(event)
    # Should implement methods to:
    # 1. Get all accordion items
    # 4. Handle programmatic expansion/collapse
def main():
    app = Gtk.Application()
    app.connect('activate', lambda app: AccordionWithoutState().show_all())
    app.run()
if __name__ == '__main__':
    main()

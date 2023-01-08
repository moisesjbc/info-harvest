extends Node


signal previous_button_pressed
signal next_button_pressed
signal main_menu_button_pressed



func _on_previous_button_pressed():
	emit_signal("previous_button_pressed")


func _on_main_menu_button_pressed():
	emit_signal("main_menu_button_pressed")


func _on_next_button_pressed():
	emit_signal("next_button_pressed")


func init(panel_global_position, text, current_step_index, n_steps):
	$panel.set_global_position(panel_global_position)
	$panel/margin_container2/VBoxContainer/tutorial_text.text = text
	$panel/margin_container2/VBoxContainer/HBoxContainer/previous_button.visible = (current_step_index > 0)
	$panel/margin_container2/VBoxContainer/HBoxContainer/next_button.visible = (current_step_index < (n_steps - 1))

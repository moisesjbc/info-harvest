extends Control


var current_step_index = 0


func _ready():
	set_current_step(0)


func set_current_step(step_index):
	$steps.get_child(current_step_index).visible = false
	current_step_index = step_index
	$tutorial_panel.init($steps.get_child(current_step_index).get_node("position").global_position, $steps.get_child(current_step_index).tutorial_text, current_step_index, $steps.get_child_count())
	$steps.get_child(current_step_index).visible = true


func _on_tutorial_panel_main_menu_button_pressed():
	get_tree().change_scene("res://menus/main_menu/main_menu.tscn")


func _on_tutorial_panel_next_button_pressed():
	set_current_step(current_step_index + 1)


func _on_tutorial_panel_previous_button_pressed():
	set_current_step(current_step_index - 1)

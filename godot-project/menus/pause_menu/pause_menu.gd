extends Control


func set_paused(paused):
	get_tree().paused = paused
	visible = paused


func _on_resume_game_button_pressed():
	set_paused(false)


func _on_main_menu_button_pressed():
	get_tree().change_scene("res://menus/main_menu/main_menu.tscn")

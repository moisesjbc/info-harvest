extends Control

signal game_restart_requested


func start():
	set_paused(true)
	

func set_paused(paused):
	if get_tree():
		get_tree().paused = paused
	visible = paused


func _on_restart_game_button_pressed():
	set_paused(false)
	emit_signal("game_restart_requested")
	


func _on_life_player_dead():
	start()


func _on_main_menu_button_pressed():
	set_paused(false)
	get_tree().change_scene("res://menus/main_menu/main_menu.tscn")

extends Button


func _on_restart_game_button_pressed():
	get_node("/root/button_pressed").play()

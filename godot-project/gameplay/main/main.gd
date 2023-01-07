extends Node


func _on_game_over_game_restart_requested():
	get_tree().change_scene("res://gameplay/main/main.tscn")

extends Node


func _ready():
	randomize()


func _on_game_over_game_restart_requested():
	get_tree().change_scene("res://gameplay/main/main.tscn")


func _input(event):
	if event is InputEventKey and event.pressed and event.scancode == KEY_ESCAPE:
		$gui/pause_menu.set_paused(true)

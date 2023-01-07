extends Node2D


var data_scene = preload("res://gameplay/data/data.tscn")


func _on_spawn_timer_timeout():
	var new_data = data_scene.instance()
	$data_container.add_child(new_data)
	new_data.global_position.x = $top_position.global_position.x
	new_data.global_position.y = rand_range($top_position.global_position.y, $bottom_position.global_position.y)
	print("foo")

extends Node2D


var data_scene = preload("res://gameplay/data/data.tscn")


func _on_spawn_timer_timeout():
	var new_data = data_scene.instance()
	$data_container.add_child(new_data)
	new_data.global_position.x = $top_position.global_position.x
	new_data.global_position.y = rand_range($top_position.global_position.y, $bottom_position.global_position.y)
	new_data.set_fake_news(randf() < 0.3)
	new_data.connect("data_consumed", self, "_on_data_consumed")


func _on_data_consumed(data_score):
	if data_score >= 0:
		$real_info_consumed.play()
		get_parent().get_node("score").add_score(data_score)
	else:
		get_parent().get_node("life").add_damage(-data_score)

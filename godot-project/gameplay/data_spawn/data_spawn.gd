extends Node2D


var data_scene = preload("res://gameplay/data/data.tscn")
var min_data_speed = 150
var max_data_speed = 200
var fake_news_probability = 0.3

func _on_spawn_timer_timeout():
	var new_data = data_scene.instance()
	$data_container.add_child(new_data)
	new_data.global_position.x = $top_position.global_position.x
	new_data.global_position.y = rand_range($top_position.global_position.y, $bottom_position.global_position.y)
	new_data.set_fake_news(randf() < fake_news_probability)
	new_data.speed = int(rand_range(min_data_speed, max_data_speed))
	new_data.connect("data_consumed", self, "_on_data_consumed")


func _on_data_consumed(data_score):
	if data_score >= 0:
		$real_info_consumed.play()
		get_parent().get_node("score").add_score(data_score)
	else:
		get_parent().get_node("life").add_damage(-data_score)


func increase_speed(speed_increment):
	min_data_speed += speed_increment
	max_data_speed += speed_increment


func _on_difficulty_timer_timeout():
	$spawn_timer.wait_time -= 0.1
	min_data_speed += 10
	max_data_speed += 10
	fake_news_probability += 0.05

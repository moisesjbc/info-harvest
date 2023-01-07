extends Sprite

var data_in_area = []
var analysis_delta = 50.0
var target_data = null
var bullet_scene = preload("res://gameplay/bullet/bullet.tscn")
var active = true


func _on_influence_area_body_entered(body):
	if body.is_in_group("data"):
		data_in_area.push_back(body)


func _on_influence_area_body_exited(body):
	if body.is_in_group("data"):
		var data_index = data_in_area.find(body)
		if data_index != -1:
			data_in_area.remove(data_index)


func _process(delta):
	if active and len(data_in_area):
		target_data = data_in_area[0]
		if not target_data.is_analyzed():
			target_data.analyze(analysis_delta * delta)
		else:
			if target_data.is_fake_news():
				shoot(target_data)
			target_data = null
			data_in_area.pop_front()
	else:
		target_data = null
		
	update()


func _draw():
	if active:
		if target_data:
			draw_line(get_parent().position, to_local(target_data.global_position), Color.red, 3.0)


func shoot(shoot_target_data):
	var bullet = bullet_scene.instance()
	bullet.target_data = shoot_target_data
	add_child(bullet)
	bullet.global_position = global_position


func display_influence_area(display_influence_area):
	$influence_circle.visible = display_influence_area

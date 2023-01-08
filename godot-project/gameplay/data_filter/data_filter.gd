extends Node2D

var data_in_area = []
var scan_time = 1.0
var refutation_speed = 200
var target_data = null
var bullet_scene = preload("res://gameplay/bullet/bullet.tscn")
var active = true
var score_node = null


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
			target_data.analyze((100 / scan_time) * delta)
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
	bullet.speed = refutation_speed
	add_child(bullet)
	bullet.global_position = global_position


func display_influence_area(display_influence_area):
	$influence_area/influence_circle.visible = display_influence_area


func _on_clickable_area_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		$improvement_panel.open(score_node)


func _on_improvement_panel_scan_time_reduced(scan_time_reduction, scan_time_reduction_cost):
	scan_time -= scan_time_reduction
	score_node.decrement_score(scan_time_reduction_cost)


func _on_improvement_panel_refutation_speed_increased(refutation_speed_increment, refutation_speed_increment_cost):
	refutation_speed += refutation_speed_increment
	score_node.decrement_score(refutation_speed_increment_cost)


func _on_improvement_panel_scan_area_increased(scan_area_increment, scan_area_increment_cost):
	$influence_area.scale.x += scan_area_increment
	$influence_area.scale.y += scan_area_increment
	score_node.decrement_score(scan_area_increment_cost)

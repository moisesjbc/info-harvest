extends KinematicBody2D


signal data_consumed


var speed = 150
var velocity: Vector2 = Vector2(-1.0, 0.0)
var remaining_analysis = 100.0

var _is_fake_news: bool = false
var global_score = null
var data_score = 10


func set_fake_news(new_fake_news):
	_is_fake_news = new_fake_news
	if _is_fake_news:
		data_score = -data_score


func _process(delta):
	var _collision = move_and_collide(velocity * speed * delta)


func _on_visibility_notifier_screen_exited():
	queue_free()
	emit_signal("data_consumed", data_score)


func analyze(analysis_delta):
	remaining_analysis -= analysis_delta
	if remaining_analysis <= 0.0:
		remaining_analysis = 0.0
		reveal_data_type()


func is_analyzed():
	return remaining_analysis <= 0.0


func reveal_data_type():
	if not _is_fake_news:
		$sprite.modulate = Color.green
	else:
		$sprite.modulate = Color.red


func is_fake_news():
	return _is_fake_news

extends KinematicBody2D


signal data_consumed


var speed = 150
var velocity: Vector2 = Vector2(-1.0, 0.0)
var remaining_analysis = 100.0

var _is_fake_news: bool = false
var global_score = null
var data_score = 10

var analyzing = false


func set_fake_news(new_fake_news):
	_is_fake_news = new_fake_news
	if _is_fake_news:
		data_score = -data_score


func _process(delta):
	var _collision = move_and_collide(velocity * speed * delta)
	if global_position.x <= -20:
		emit_signal("data_consumed", data_score)
		queue_free()
		
	# By default hide magnifying glass, if in next frame data is
	# still being analysed, analyze() will make magnifying glass
	# visible again.
	$magnifying_glass.visible = false


func analyze(analysis_delta):
	$magnifying_glass.visible = true
	remaining_analysis -= analysis_delta
	if remaining_analysis <= 0.0:
		remaining_analysis = 0.0
		reveal_data_type()


func is_analyzed():
	return remaining_analysis <= 0.0


func reveal_data_type():
	$magnifying_glass.visible = false
	if not _is_fake_news:
		$verified_valid.visible = true
	else:
		$verified_fake.visible = true


func is_fake_news():
	return _is_fake_news

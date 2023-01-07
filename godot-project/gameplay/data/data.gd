extends KinematicBody2D

var speed = 150
var velocity: Vector2 = Vector2(-1.0, 0.0)
var data_type = DataType.VALID_INFO
var remaining_analysis = 100.0

enum DataType {
	VALID_INFO,
	FAKE_NEWS
}

func _ready():
	if randf() < 0.50:
		data_type = DataType.FAKE_NEWS


func _process(delta):
	var _collision = move_and_collide(velocity * speed * delta)


func _on_visibility_notifier_screen_exited():
	queue_free()


func analyze(analysis_delta):
	remaining_analysis -= analysis_delta
	if remaining_analysis <= 0.0:
		remaining_analysis = 0.0
		reveal_data_type()


func is_analyzed():
	return remaining_analysis <= 0.0


func reveal_data_type():
	if data_type == DataType.VALID_INFO:
		$sprite.modulate = Color.green
	else:
		$sprite.modulate = Color.red

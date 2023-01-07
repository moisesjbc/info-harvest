extends KinematicBody2D

var speed = 250
var velocity: Vector2 = Vector2(-1.0, 0.0)


func _process(delta):
	var _collision = move_and_collide(velocity * speed * delta)


func _on_visibility_notifier_screen_exited():
	queue_free()

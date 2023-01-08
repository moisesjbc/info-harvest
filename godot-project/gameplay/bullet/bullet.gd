extends Area2D


var target_data = null
var speed = 700
var velocity = Vector2.ZERO 


func _ready():
	target_data.connect("tree_exited", self, "on_target_data_destroyed")
	

func _process(delta):
	if target_data:
		velocity = (target_data.global_position - global_position).normalized()
	translate(velocity * speed * delta)


func _on_bullet_body_entered(body):
	if body == target_data:
		get_node("/root/explosion").play()
		target_data.queue_free()
		queue_free()


func on_target_data_destroyed():
	target_data = null


func _on_visibility_notifier_screen_exited():
	queue_free()

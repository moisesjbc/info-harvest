extends Timer

signal elapsed_seconds_changed

var elapsed_seconds = 0


func _ready():
	set_elapsed_seconds(0)
	

func set_elapsed_seconds(new_elapsed_seconds):
	elapsed_seconds = new_elapsed_seconds
	emit_signal("elapsed_seconds_changed", elapsed_seconds)


func _on_timer_timeout():
	set_elapsed_seconds(elapsed_seconds + 1)


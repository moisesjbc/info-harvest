extends Timer

signal elapsed_seconds_changed

var elapsed_seconds = 0

func _on_timer_timeout():
	elapsed_seconds += 1
	emit_signal("elapsed_seconds_changed", elapsed_seconds)


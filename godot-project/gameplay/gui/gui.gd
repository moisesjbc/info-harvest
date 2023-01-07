extends Control


func _on_timer_elapsed_seconds_changed(new_elapsed_seconds):
	var elapsed_minutes = new_elapsed_seconds / 60
	var elapsed_seconds = new_elapsed_seconds % 60
	var elapsed_seconds_str = str(new_elapsed_seconds)
	if new_elapsed_seconds < 10:
		elapsed_seconds_str = "0" + elapsed_seconds_str

	$margin_container/top_bar/timer_container/timer_panel/timer_label.text = str(elapsed_minutes) + ":" + elapsed_seconds_str


func _on_score_current_score_changed(current_score):
	$margin_container/top_bar/score_panel/score_label.text = str(current_score)
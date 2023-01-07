extends Node


var current_score = 0
signal current_score_changed


func _ready():
	set_score(0)


func set_score(new_score):
	current_score = new_score
	emit_signal("current_score_changed", current_score)
	
	
func add_score(added_score):
	set_score(current_score + added_score)

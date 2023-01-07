extends Node


var current_life = 0
signal current_life_changed
signal player_dead

func _ready():
	set_life(100)


func set_life(new_life):
	current_life = new_life
	if current_life < 0:
		current_life = 0

	emit_signal("current_life_changed", current_life)
	if current_life <= 0:
		emit_signal("player_dead")
	
	
func add_damage(fake_new_damage):
	set_life(current_life - fake_new_damage)

extends Node2D

var data_filter_scene = preload("res://gameplay/data_filter/data_filter.tscn")
var new_data_filter = null
var new_data_filter_valid_position = false
var new_data_filter_cost = 30

signal new_data_filter_built


func _ready():
	_update_button_label()
	

func _update_button_label():
	if not new_data_filter:
		$gui/creation_button.text = "CREATE [cost: -30]"
	else:
		$gui/creation_button.text = "CANCEL"


func _process(delta):
	if new_data_filter:
		display_influence_areas(true)
		new_data_filter.global_position = get_global_mouse_position()
		new_data_filter_valid_position = (new_data_filter.global_position.distance_to($gui/creation_button.rect_global_position) >= 100)
			
		if not new_data_filter_valid_position:
			new_data_filter.modulate = Color.red
		else:
			new_data_filter.modulate = Color.white


func _input(event):
	if new_data_filter and event is InputEventMouseButton and not event.pressed and event.button_index == BUTTON_LEFT:
		if new_data_filter_valid_position:
			new_data_filter.active = true
			new_data_filter = null
			emit_signal("new_data_filter_built", new_data_filter_cost)
		else:
			new_data_filter.queue_free()
		new_data_filter = null
		display_influence_areas(false)
		_update_button_label()


func _on_creation_button_button_down():
	new_data_filter = data_filter_scene.instance()
	$data_filters.add_child(new_data_filter)
	new_data_filter.global_position = get_global_mouse_position()
	new_data_filter.active = false
	_update_button_label()


func display_influence_areas(display):
	for data_filter in $data_filters.get_children():
		data_filter.display_influence_area(display)


func _on_score_current_score_changed(current_score):
	$gui/creation_button.disabled = current_score < new_data_filter_cost

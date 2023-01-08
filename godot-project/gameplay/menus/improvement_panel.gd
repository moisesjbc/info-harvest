extends Panel

var current_improvement_index = -1
signal scan_time_reduced
signal scan_area_increased
signal refutation_speed_increased

var scan_time_reduction = 0.1
var scan_time_reduction_cost = 30
var reduce_scan_time_str = "-" + str(scan_time_reduction) + "s scan time [cost: " + str(scan_time_reduction_cost) + "]"

var scan_area_increment = 0.1
var scan_area_increment_cost = 30
var increase_scan_area_str = "+" + str(scan_area_increment * 100) + "% scan area [cost: " + str(scan_area_increment_cost) + "]"

var refutation_speed_increment = 200
var refutation_speed_increment_cost = 30
var increase_refutation_time_str = "+" + str(refutation_speed_increment) + " refutation speed [cost: " + str(refutation_speed_increment_cost) + "]"
var score_node = null

func _on_close_button_pressed():
	visible = false


func open(score_node):
	visible = true
	$margin_container/vbox_container/view.visible = true
	$margin_container/vbox_container/select.visible = false

	self.score_node = score_node
	score_node.connect("current_score_changed", self, "update_buttons_status")
	update_buttons_status(score_node.current_score)

	$margin_container/vbox_container/select/reduce_scan_time.text = reduce_scan_time_str
	$margin_container/vbox_container/select/increase_scan_area.text = increase_scan_area_str
	$margin_container/vbox_container/select/increment_refutation_speed.text = increase_refutation_time_str


func update_buttons_status(current_score):
	$margin_container/vbox_container/select/reduce_scan_time.disabled = scan_time_reduction_cost > current_score
	$margin_container/vbox_container/select/increase_scan_area.disabled = scan_area_increment_cost > current_score
	$margin_container/vbox_container/select/increment_refutation_speed.disabled = refutation_speed_increment_cost > current_score
	

func close():
	visible = false
	score_node.disconnect("current_score_changed", self, "update_buttons_status")


func select_improvement_index(new_improvement_index):
	current_improvement_index = new_improvement_index
	$margin_container/vbox_container/view.visible = false
	$margin_container/vbox_container/select.visible = true


func _on_improvement_0_pressed():
	select_improvement_index(0)


func _on_improvement_1_pressed():
	select_improvement_index(1)


func _on_improvement_2_pressed():
	select_improvement_index(2)


func set_current_improvement_text(text):
	text.get_slice("[", 0)
	var current_improvement_button = $margin_container/vbox_container/view.get_child(1 + current_improvement_index) as Button
	current_improvement_button.text = text
	current_improvement_button.disabled = true


func _on_reduce_scan_time_pressed():
	set_current_improvement_text(reduce_scan_time_str)
	emit_signal("scan_time_reduced", scan_time_reduction, scan_time_reduction_cost)
	close()


func _on_increase_scan_area_pressed():
	set_current_improvement_text(increase_scan_area_str)
	emit_signal("scan_area_increased", scan_area_increment, scan_area_increment_cost)
	close()


func _on_increment_refutation_speed_pressed():
	set_current_improvement_text(increase_refutation_time_str)
	emit_signal("refutation_speed_increased", refutation_speed_increment, refutation_speed_increment_cost)
	close()

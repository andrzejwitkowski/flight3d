class_name SpaceUtils


static func formatted_vec3(v: Vector3) -> String:
	return "(%.1f,%.1f,%.1f)" % [
		v.x,v.y,v.z
	]

static func print_with_parent(node: Node, text: String) -> void:
	print(node.get_parent().name, " :: ", text)


static func toggle_area3d(area: Area3D, switch_on: bool) -> void:
	area.set_deferred("monitoring", switch_on)
	area.set_deferred("monitorable", switch_on)


static func get_percentage_string(num: float, total: float) -> String:
	var percent := 0.0
	if total != 0 and not is_nan(num) and not is_nan(total):
		percent = (num / total) * 100
	return "%.0f / %.0f (%.1f%%)" % [num, total, percent]

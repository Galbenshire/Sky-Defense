extends Node

signal target_acquired(target_position)

func _ready() -> void:
	call_deferred("_pick_structure_target")

func _pick_structure_target() -> void:
	var structure_list = _get_target_list()
	var chosen_target = structure_list[randi() % structure_list.size()]
	emit_signal("target_acquired", chosen_target.global_position)

func _get_target_list() -> Array:
	var full_list = get_tree().get_nodes_in_group("structure")
	var filtered_list = []
	
	for structure in full_list:
		if structure.can_target():
			filtered_list.append(structure)
	
	return filtered_list if !filtered_list.empty() else full_list
extends CharacterBody3D


class_name Player


const GROUP_PLAYER: String = "player"


func _enter_tree() -> void:
	add_to_group(GROUP_PLAYER)

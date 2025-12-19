extends Node3D


class_name Spawner


@export var x_range: Vector2 = Vector2(-20, 20)
@export var y_range: Vector2 = Vector2(-20, 20)
@export var enabled: bool = true

const IMPACT_FLASH = preload("uid://djbfi8fbov5j")

enum SceneNames { ImpactFlash }

const SCENES_DICT = {
	SceneNames.ImpactFlash: IMPACT_FLASH
}

@onready var tie_timer: Timer = $TieTimer
@onready var asteroid_timer: Timer = $AsteroidTimer


func _ready() -> void:
	SignalHub.on_crate_one_off.connect(on_crate_one_off)

func add_with_transform(ob: Node3D, p_tr: Transform3D) -> void:
	add_child(ob)
	ob.global_transform = p_tr


func add_with_position(ob: Node3D, p_pos: Vector3) -> void:
	add_child(ob)
	ob.global_position = p_pos


func on_create_packed_scene(p_tr: Transform3D, ps: PackedScene) -> void:
	var ns = ps.instantiate()
	call_deferred("add_with_transform", ns, p_tr)

func on_crate_one_off(p_pos: Vector3, scene_name: Spawner.SceneNames) -> void:
	if !SCENES_DICT.has(scene_name): return
	var ns = SCENES_DICT[scene_name].instantiate()
	call_deferred("add_with_position", ns, p_pos)

func _on_tie_timer_timeout() -> void:
	pass


func _on_asteroid_timer_timeout() -> void:
	pass

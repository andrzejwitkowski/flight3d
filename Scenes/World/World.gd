extends Node

@onready var world_environment: WorldEnvironment = $WorldEnvironment

@export var world_rotation_speed: float = -0.007
const IMPACT_FLASH = preload("uid://djbfi8fbov5j")

func _physics_process(delta: float) -> void:
	world_environment.environment.sky_rotation.y += delta * world_rotation_speed
	

func _on_test_timer_timeout() -> void:
	var ns = IMPACT_FLASH.instantiate()
	add_child(ns)
	ns.global_position = Vector3(0,0, -30)

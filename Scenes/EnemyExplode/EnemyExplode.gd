extends Node3D

class_name EnemyExplode

@export var base_velocity: Vector3 = Vector3(0, 0, 5)
@export var explosion_force_min: float = 20.0
@export var explosion_force_max: float = 40.0
@export var torque_applied: Vector3 = Vector3(1, 1, 1)
@export var cleanup_delay: float = 5.0

var _explosion_force: float

func _ready() -> void:
	_explosion_force = randf_range(explosion_force_min, explosion_force_max)
	explode()

func explode() -> void:
	for piece in get_children():
		if piece is RigidBody3D:
			var explosion_dir: Vector3 = Vector3(
				randf_range(-1.0, 1.0),
				randf_range(-1.0, 1.0),
				randf_range(0.2, 1.0)
			).normalized()

			var final_impulse: Vector3 = explosion_dir * _explosion_force + base_velocity

			piece.constant_force = final_impulse / 2
			piece.constant_torque = torque_applied

	await get_tree().create_timer(cleanup_delay).timeout
	queue_free()

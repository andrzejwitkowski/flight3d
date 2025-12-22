extends Node3D

class_name Asteroid

const EXPLODE_Z: float = -40.0
@onready var hit_box: HitBox = $HitBox

@export var speed: float = -15.0
@export var spin_speed: float = 5.0
@onready var icosphere: MeshInstance3D = $Icosphere

var _rotate_x = randf()
var _rotate_y = randf()

func _physics_process(delta: float) -> void:
	explode_if_to_close()
	move_and_spin(delta)

func explode_if_to_close():
	if global_position.z > EXPLODE_Z:
		hit_box.blow_up()
		queue_free()

func move_and_spin(delta: float):
	translate(Vector3.FORWARD * speed * delta)
	icosphere.rotate_y(spin_speed * delta * _rotate_y)
	icosphere.rotate_x(spin_speed * delta * _rotate_x)

func _on_hit_box_died() -> void:
	queue_free()

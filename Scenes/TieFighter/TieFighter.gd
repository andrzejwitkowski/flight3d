extends Node3D

class_name TieFighter

@export var stay_still: bool = false
@export var enemy_bahaviour: EnemyBehaviour

@onready var model_mesh: MeshInstance3D = $Pivot/TieFighter

@onready var engine_sound: AudioStreamPlayer3D = $EngineSound
@onready var player_ref: LinkPlayer = $PlayerRef
@onready var gun: Gun = $Pivot/Gun

func _ready() -> void:
	if enemy_bahaviour:
		enemy_bahaviour.setup(self)
	face_player()

func _physics_process(delta: float) -> void:
	if !stay_still and enemy_bahaviour:
			enemy_bahaviour.update(delta)

func face_player() -> void:
	if player_ref.player_z > global_position.z:
		rotation.y = PI
	else:
		rotation.y = 0

func shoot() -> void:
	gun.shoot()
	
func shoot_burst():
	for i in range(3):
		shoot()
		await get_tree().create_timer(0.2).timeout
		shoot()
		await get_tree().create_timer(0.5).timeout


func _on_hit_box_died() -> void:
	queue_free()

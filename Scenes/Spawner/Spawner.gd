extends Node3D


class_name Spawner


@export var x_range: Vector2 = Vector2(-20, 20)
@export var y_range: Vector2 = Vector2(-20, 20)
@export var enabled: bool = true

const IMPACT_FLASH = preload("uid://djbfi8fbov5j")
const PLAYER_LASER = preload("uid://4il378veeq2p")

enum SceneNames { ImpactFlash }
enum LaserType { PlayerLaser, TieLaser }

const SCENES_DICT = {
	SceneNames.ImpactFlash: IMPACT_FLASH
}

@onready var tie_timer: Timer = $TieTimer
@onready var asteroid_timer: Timer = $AsteroidTimer

var _playerLaserPool: LaserPool


func _ready() -> void:
	_playerLaserPool = LaserPool.new(
		10, PLAYER_LASER, self, "PlayerLaser"
	)
	SignalHub.on_crate_one_off.connect(on_crate_one_off)
	SignalHub.on_create_laser.connect(on_create_laser)

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
	
func on_create_laser(p_tr: Transform3D, laser_type: Spawner.LaserType) -> void:
	match laser_type:
		LaserType.PlayerLaser:
			_playerLaserPool.active_next_scene(p_tr)
		LaserType.TieLaser:
			pass

func _on_tie_timer_timeout() -> void:
	pass


func _on_asteroid_timer_timeout() -> void:
	pass

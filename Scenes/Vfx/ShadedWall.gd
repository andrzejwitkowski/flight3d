extends Node3D

class_name ShadedWall

@onready var wall_mesh: MeshInstance3D = $WallMesh
@onready var player_ref: LinkPlayer = $PlayerRef

@export var is_y: bool 

var _max_distance: float = 15.0
var _distance_to_player: float = 0.0

var _wall_material: ShaderMaterial

func _ready() -> void:
	_wall_material = wall_mesh.material_override as ShaderMaterial
	
func _physics_process(delta: float) -> void:
	if is_y:
		_distance_to_player = abs(player_ref.player_y - global_position.y)
	else:
		_distance_to_player = abs(player_ref.player_x - global_position.x)
	var strength: float = clampf(
		(_max_distance - _distance_to_player) / _max_distance,
		0.0,
		1.0
	)
	_wall_material.set_shader_parameter("Strength", strength)

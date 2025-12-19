extends Camera3D

@onready var player_ref: LinkPlayer = $PlayerRef

@export var camera_follow_speed: Vector2 = Vector2(18.0, 30.0)
@export var offset: Vector3 = Vector3(0, 6, 15)

func _physics_process(delta: float) -> void:
	#global_position = player_ref.player_pos + offset
	var target_position = player_ref.player_pos + offset
	var x_delta = abs(target_position.x - global_position.x)
	var y_delta = abs(target_position.y - global_position.y)
	
	var speed = camera_follow_speed.x if x_delta > y_delta else camera_follow_speed.y
	global_position = global_position.move_toward(target_position, speed * delta)

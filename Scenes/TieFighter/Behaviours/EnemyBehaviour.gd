extends Resource

class_name EnemyBehaviour

@export var speed: float = 40.0
@export var engine_sound_distance: float = 100.0

var _player_ref: LinkPlayer
var _near_player: bool = false

var owner: TieFighter:
	set(value): owner = value
	
func setup(p_owner: TieFighter):
	owner = p_owner
	_player_ref = owner.player_ref
	
func update(delta: float):
	owner.translate(Vector3.FORWARD * speed * delta)
	if !_near_player:
		var distance = _player_ref.player_pos.distance_to(owner.position)
		if distance < engine_sound_distance:
			print("Engine sound on")
			owner.engine_sound.play()
			_near_player = true

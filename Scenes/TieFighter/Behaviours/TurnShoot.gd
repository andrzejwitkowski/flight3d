extends EnemyBehaviour

class_name TurnShoot


@export var engage_distance: float = 100.0

var _engaged: bool = false


func update(delta: float):
	if !_engaged and _player_ref.player_less_than_distance(owner.global_position, engage_distance):
		_engaged = true
		owner.look_at(_player_ref.player_pos)
		owner.shoot_burst()
	super.update(delta)

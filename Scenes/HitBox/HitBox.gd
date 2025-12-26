@tool
extends Area3D

class_name HitBox

signal died

@export var shape_resource: Shape3D
@export var start_health: int = 100
@export var explosion_effect: PackedScene
@export var explosion_scene: PackedScene
@export var create_power_up: bool = false
@export var power_up_chance: float = 0.2
@export var points_scored: int = 20

@onready var collision_shape_3d: CollisionShape3D = $CollisionShape3D

var _current_health: int = 0
var _dead: bool = false

func _update_components() -> void:
	collision_shape_3d.shape = shape_resource
	
func _notification(what: int) -> void:
	if what == NOTIFICATION_EDITOR_POST_SAVE:
		_update_components()

func _ready() -> void:
	_current_health = start_health
	_update_components()

func disable() -> void:
	SpaceUtils.toggle_area3d(self, false)

func die():
	GameUi.score += points_scored
	_dead = true
	died.emit()
	disable()
		
func blow_up():
	if explosion_effect:
		SignalHub.emit_on_create_packed_scene(self.global_transform, explosion_effect)
	if explosion_scene:
		SignalHub.emit_on_create_packed_scene(self.global_transform, explosion_scene)
	if create_power_up and randf() < power_up_chance:
		SignalHub.emit_create_power_up(self.global_position)

func take_damage(v: int) -> void:
	if _dead: return
	_current_health -= v
	if _current_health <= 0:
		blow_up()
		die()

func _on_area_entered(area: Area3D) -> void:
	if area is Laser:
		take_damage(area.get_damage())

extends Node3D

class_name Gun

const GUN_FLASH = preload("uid://bxt38u1pb2mgi")

@export var debounce: float = 0.18
@export var muzzles: Array[Node3D]
@export var sound_effect: AudioStream
@export var laser_type: Spawner.LaserType

@onready var effect: AudioStreamPlayer3D = $Effect

var _gun_flashes: Array[GPUParticles3D]
var _timer: float = 0.0

func _process(delta: float) -> void:
	_timer += delta

func _ready() -> void:
	effect.stream = sound_effect
	for m in muzzles:
		var gf: GPUParticles3D = GUN_FLASH.instantiate()
		m.add_child(gf)
		_gun_flashes.append(gf)
		
func shoot() -> void:
	if _timer > debounce:
		effect.play()
		
		for m in muzzles:
			SignalHub.emit_create_laser(m.global_transform, laser_type)	
		for gf in _gun_flashes:
			gf.emitting = true
		_timer = 0.0

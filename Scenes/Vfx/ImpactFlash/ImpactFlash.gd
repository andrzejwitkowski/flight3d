extends GPUParticles3D

class_name ImpactFlash

@export var one_off: bool = true

@onready var impact_sound: AudioStreamPlayer3D = $ImpactSound

func _ready() -> void:
	if one_off: bang()

func bang() -> void:
	impact_sound.play()
	emitting = true
	if one_off:
		await impact_sound.finished
		queue_free()

extends Node3D

@onready var audio_stream_player_3d: AudioStreamPlayer3D = $AudioStreamPlayer3D
@onready var sparks: GPUParticles3D = $Sparks

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sparks.emitting = true
	await audio_stream_player_3d.finished
	queue_free()

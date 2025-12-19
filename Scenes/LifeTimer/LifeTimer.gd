extends Node

class_name  LifeTimer

signal time_out

@export var life_time: float = 5.0
@export var auto_remove: bool = true

@onready var timer: Timer = $Timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.wait_time = life_time
	if auto_remove: start_timer()

func start_timer() -> void:
	timer.start()
	
func stop_timer() -> void:
	timer.stop()

func _on_timer_timeout() -> void:
	time_out.emit()
	if auto_remove: get_parent().queue_free()

extends HBoxContainer

class_name PauseMenuStat


@export var title: String = "title here"
@export var initial_value: String = "value here"

@onready var label_title: Label = $Title
@onready var label_value: Label = $Value

func _ready() -> void:
	set_title_label(title)
	set_value_label(initial_value)

func set_title_label(v: String) -> void:
	label_title.text = v
	
func set_value_label(v: String) -> void:
	label_value.text = v
	

extends Control


class_name GameUi


@onready var game_over: ColorRect = $GameOver
@onready var label: Label = $GameOver/VB/Label
@onready var game_over_scored: Label = $GameOver/VB/GameOverScored
@onready var press_shoot: Label = $GameOver/VB/PressShoot
@onready var score_label: Label = $MarginContainer/ScoreLabel
@onready var pause_menu: PanelContainer = $PauseMenu

@onready var asteroid_stat: PauseMenuStat = $PauseMenu/VB/VBStats/AsteroidStat
@onready var ships_stat: PauseMenuStat = $PauseMenu/VB/VBStats/ShipsStat
@onready var game_time_stat: PauseMenuStat = $PauseMenu/VB/VBStats/GameTimeStat

var _is_paused: bool = false

func _enter_tree() -> void:
	SignalHub.on_game_over.connect(on_game_over)
	SignalHub.on_score_changed.connect(on_score_changed)
	
func on_score_changed() -> void:
	score_label.text = "%6d" % score
	
static var score: int = 0: 
	set(v):
		score = v
		score = max(v, 0)
		SignalHub.emit_score_changed()
	
func on_game_over() -> void:
	game_over_scored.text = "You scored %d points!" % score
	game_over.show()
	get_tree().paused = true
	await get_tree().create_timer(2.0).timeout
	press_shoot.show()	
	

func _ready() -> void:
	score = 0
	Asteroid.asteroids_killed = 0.0
	Asteroid.asteroids_spawned = 0.0
	TieFighter.ships_killed = 0.0
	TieFighter.ships_spawned = 0.0
	get_tree().paused = false
	
func update_stats() -> void:
	asteroid_stat.set_value_label(
		SpaceUtils.get_percentage_string(
			Asteroid.asteroids_killed,
			Asteroid.asteroids_spawned
		)
	)
	ships_stat.set_value_label(
		SpaceUtils.get_percentage_string(
			TieFighter.ships_killed,
			TieFighter.ships_spawned,
		)
	)
	game_time_stat.set_value_label(
		"%.2fs" % Player.game_time
	)
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause") and !game_over.visible:
		if !_is_paused:
			pause_menu.show()
			update_stats()
			get_tree().paused = true
		else:
			pause_menu.hide()
			get_tree().paused = false
		_is_paused = not _is_paused
	if press_shoot.visible and event.is_action_pressed("shoot"):
		get_tree().reload_current_scene()

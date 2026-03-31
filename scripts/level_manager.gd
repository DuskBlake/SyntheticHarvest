extends Node3D

@onready var world_environment: WorldEnvironment = $WorldEnvironment
@onready var animation_player: AnimationPlayer = $AnimationPlayer

@export var start_time:float = 7
@export var day_length: float = 10

static  var is_day: bool = false

var duration_multiplier = 1

func change_duration():
	duration_multiplier = day_length / 24
	animation_player.speed_scale = 1.0/ duration_multiplier

func set_sun():
	animation_player.play("day_night_cycle")
	animation_player.seek(start_time)

func _ready() -> void:
	change_duration()
	set_sun()

func  _process(delta: float) -> void:
	if animation_player.current_animation_position > 6 && animation_player.current_animation_position< 18:
		is_day = true
	else: is_day = false

extends Node3D

class_name LevelManager

@onready var world_environment: WorldEnvironment = $WorldEnvironment
@onready var animation_player: AnimationPlayer = $AnimationPlayer

@export var day_length: float = 10

static var is_day: bool = false
var extractor:Node3D

var duration_multiplier = 1

func change_duration() -> void:
	duration_multiplier = day_length / 24
	animation_player.speed_scale = 1.0/ duration_multiplier

func _ready() -> void:
	change_duration()

func  _process(delta: float) -> void:
	if animation_player.current_animation:
		if animation_player.current_animation_position > 15 && animation_player.current_animation_position < 21:
			is_day = false
		else: is_day = true
	if !extractor:
		extractor = get_tree().get_first_node_in_group("Extractor")
	elif extractor.placed:
		animation_player.play("day_night_cycle")

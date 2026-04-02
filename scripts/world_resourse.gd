extends Node3D

@export var stage_1: MeshInstance3D
@export var stage_2: MeshInstance3D
@export var progress_bar: ProgressBar
@export var label: Label
@export var interaction_ui: Sprite3D
@export var item: InvItem

var player_in_area: bool
var player: Node3D = null

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("Player"):
		player = body
		player_in_area = true

func _on_iteract_trigger_body_exited(body: Node3D) -> void:
	if body.is_in_group("Player"):
		player_in_area = false

extends Node3D

@onready var stage_1: MeshInstance3D = $Stage1
@onready var stage_2: MeshInstance3D = $Stage2


@export var item: InvItem

var player_in_area: bool
var player: Node3D = null

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.name == "Player" and !player_in_area:
		player = body
		player_in_area = true

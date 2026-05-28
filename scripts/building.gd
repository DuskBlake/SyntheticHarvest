extends StaticBody3D

@export var collision: CollisionShape3D 
@export var mesh: MeshInstance3D
@export var trigger: CollisionShape3D
@export var health: ProgressBar
@export var material_cost: Dictionary[InvItem,int]

var placed: bool = false
var player_in_area: bool
var player:CharacterBody3D

func _on_ui_area_body_entered(body: Node3D) -> void:
	if body.is_in_group("Player"):
		player = body
		player_in_area = true

func _on_ui_area_body_exited(body: Node3D) -> void:
	if body.is_in_group("Player"):
		player_in_area = false

extends Node3D

@onready var camera_pivot: Node3D

var main_camera: Camera3D

func _ready() -> void:
	main_camera = get_viewport().get_camera_3d()
	camera_pivot = main_camera.get_parent_node_3d()

func _process(delta: float) -> void:
	rotation.y = camera_pivot.rotation.y

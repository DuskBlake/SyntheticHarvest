extends Node
@export var point1:Vector2
@export var point2:Vector2
@export var mat_density:float = 10
@export var mats:Array[PackedScene]

var spawn_pos:Vector3
var new_mat:Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in mat_density*5:
		new_mat = mats[randi_range(0,mats.size()-1)].instantiate()
		add_child(new_mat)
		new_mat.position = Vector3(randf_range(point1.x, point2.x), 0.0, randf_range(point1.y, point2.y))
	

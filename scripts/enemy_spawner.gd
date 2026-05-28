extends Node
@export var point1:Vector2
@export var point2:Vector2
@export var enemy:PackedScene

var spawn_pos:Vector3
var new_mat:Node
var extractor:Node3D
var spawning:bool = false

func spawn_enemies() -> void:
	for i in LevelManager.day_count:
		new_mat = enemy.instantiate()
		add_child(new_mat)
		new_mat.position = Vector3(randf_range(point1.x, point2.x)+extractor.position.x, 0.0, randf_range(point1.y, point2.y)+extractor.position.y)

func _process(delta: float) -> void:
	extractor = get_tree().get_first_node_in_group("Extractor")
	if !LevelManager.is_day && !spawning:
		spawn_enemies()
		spawning = true
	elif LevelManager.is_day:
		spawning = false

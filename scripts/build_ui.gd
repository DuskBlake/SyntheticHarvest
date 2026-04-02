extends Control

@export var button1: Button
@export var button2: Button
@export var button3: Button
@export var cursor: Node3D
@export var player: CharacterBody3D
@export var wood: InvItem

var extractor: Node3D
var building: bool
var extractor_just_placed: bool = true
var wood_amount: int

var extractor_scene: PackedScene = preload("res://scenes/extractor.tscn")
var wall_scene: PackedScene = preload("res://scenes/wall.tscn")
var new_building: Node

func _process(delta: float) -> void:
	if player.inv.slots[0].item == wood:
		wood_amount = player.inv.slots[0].amount
	
	if Input.is_action_just_pressed("build_mode_toggle") && !building:
		visible = !visible
	
	if wood_amount >= 3 && !extractor:
		button1.disabled = false
	else: button1.disabled = true
	
	if wood_amount >= 5 && extractor:
		button2.disabled = false
	else: button2.disabled = true
	
	if wood_amount >= 8 && extractor:
		button3.disabled = false
	else: button3.disabled = true
	
	if !extractor:
		extractor = get_tree().get_first_node_in_group("Extractor")
	elif extractor.placed && extractor_just_placed:
		button1.disabled = true
		extractor_just_placed = false

func _on_extractor_button_down() -> void:
	building = true
	new_building = extractor_scene.instantiate()
	cursor.add_child(new_building)
	player.inv.slots[0].amount -= 3
	player.inv.update.emit()
	visible = false


func _on_wall_button_down() -> void:
	building = true
	new_building = wall_scene.instantiate()
	cursor.add_child(new_building)
	player.inv.slots[0].amount -= 5
	player.inv.update.emit()
	visible = false

extends Control

@export var button1: Button
@export var button2: Button
@export var button3: Button
@export var button4: Button

@export var cursor: Node3D
@export var player: CharacterBody3D
@export var wood: InvItem
@export var buildings: Array[PackedScene]

var extractor: Node3D
var building: bool
var extractor_just_placed: bool = true
var wood_amount: int

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
	
	if wood_amount >= 3 && extractor:
		button4.disabled = false
	else: button4.disabled = true
	
	if !extractor:
		extractor = get_tree().get_first_node_in_group("Extractor")
	elif extractor.placed && extractor_just_placed:
		button1.disabled = true
		extractor_just_placed = false

func place_building(id: int) -> void:
	building = true
	new_building = buildings[id].instantiate()
	cursor.add_child(new_building)
	player.inv.slots[0].amount -= new_building.material_cost.get(wood)
	player.inv.update.emit()
	visible = false

func _on_extractor_button_down() -> void:
	place_building(0)


func _on_wall_button_down() -> void:
	place_building(1)


func _on_turret_button_down() -> void:
	place_building(2)


func _on_spikes_button_down() -> void:
	place_building(3)

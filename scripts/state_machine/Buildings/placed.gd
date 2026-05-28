extends State

class_name Placed

@export var building: StaticBody3D
@export var placed: Material
@export var ui: Sprite3D

var repairing: bool

func enter() -> void:
	building.mesh.set_surface_override_material(0,placed)
	building.collision.disabled = false
	building.placed = true

func update(_delta: float) -> void:
	if building.player_in_area:
		ui.visible = true	
	else : ui.visible = false
	
	if Input.is_action_just_pressed("repair_building") && building.is_in_group("Extractor"):
		repairing= true
	
	if repairing && building.health.value < 100:
		building.player.inv.slots[0].amount -= building.material_cost.get(preload("res://resources/inventory/items/wood.tres"))/3
		building.health.value += 100 / 15 * _delta
	else: repairing = false
	
	if building.health.value <= 0 && building.player_in_area && !building.is_in_group("Extractor"):
		building.queue_free()
	
	if Input.is_action_just_pressed("remove_building") && building.player_in_area && !building.is_in_group("Extractor"):
		building.player.inv.slots[0].amount += building.material_cost.get(preload("res://resources/inventory/items/wood.tres"))/3
		building.player.inv.update.emit()
		building.queue_free()

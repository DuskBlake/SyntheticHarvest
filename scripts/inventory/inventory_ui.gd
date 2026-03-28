extends Control

@onready var inv: Inv = preload("res://resources/inventory/player_inventory.tres")
@onready var slots: Array = $NinePatchRect/GridContainer.get_children()

var is_open: bool = false

func _ready() -> void:
	inv.update.connect(update_slots)
	update_slots()
	close()

func update_slots():
	for slot_index in range(min(inv.slots.size(),slots.size())):
		slots[slot_index].update(inv.slots[slot_index])

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("inventory"):
		if is_open:
			close()
		else:
			open()

func open() -> void:
	visible = true
	is_open = true

func close() ->void:
	visible = false
	is_open = false

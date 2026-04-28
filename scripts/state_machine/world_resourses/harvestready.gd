extends State

class_name HarvestReady

@export var world_resource: Node3D
@export var harvest_time: float = 2

var item_amount: int

func randomize_items() -> void:
	item_amount = randi_range(3, 7)

func enter() -> void:
	randomize_items()
	world_resource.label.text = "Harvest (E)"
	world_resource.stage_1.visible = true
	world_resource.stage_2.visible = false
	world_resource.progress_bar.value = 0

func update(_delta: float) -> void:
	if Input.is_action_pressed("interact"):
		world_resource.progress_bar.value += 100 / harvest_time * _delta
		if world_resource.progress_bar.value >= 100:
			world_resource.player.collect(world_resource.item)
			item_amount -= 1
			world_resource.progress_bar.value = 0

	if item_amount <= 0 :
		transitioned.emit(self, "regrow")

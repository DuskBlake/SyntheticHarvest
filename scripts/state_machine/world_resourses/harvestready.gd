extends State

class_name HarvestReady

@export var world_resource: Node3D

var item_amount: int

func randomize_items():
	item_amount = randi_range(3, 7)

func enter():
	randomize_items()
	if world_resource.stage_1:
		world_resource.stage_1.visible = true
		world_resource.stage_2.visible = false

func update(_delta: float):
	if world_resource.player_in_area:
		print("en area" + str(item_amount))
		world_resource.player.collect(world_resource.item)
		item_amount -= 1
		world_resource.player_in_area = false
	if item_amount <= 0 :
		transitioned.emit(self, "regrow")

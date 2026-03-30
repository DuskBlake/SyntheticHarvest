extends State

class_name Regrow

@export var world_resource: Node3D

func enter():
	world_resource.stage_1.visible = false
	world_resource.stage_2.visible = true
	print ("regrowing")
	$Timer.start()

func _on_timer_timeout() -> void:
	transitioned.emit(self, "harvestready")

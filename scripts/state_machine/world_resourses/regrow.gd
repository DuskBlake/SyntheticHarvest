extends State

class_name Regrow

@export var world_resource: Node3D

func enter():
	world_resource.stage_1.visible = false
	world_resource.stage_2.visible = true
	world_resource.interaction_ui.visible = true
	world_resource.label.text = "Regrowing..."
	$Timer.start()

func update(_delta: float):
	world_resource.progress_bar.value += 100 / $Timer.wait_time * _delta

func _on_timer_timeout() -> void:
	transitioned.emit(self, "harvestready")

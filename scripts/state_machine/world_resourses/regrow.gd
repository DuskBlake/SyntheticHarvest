extends State

class_name Regrow

@export var world_resource: Node3D

func enter() -> void:
	world_resource.stage_1.visible = false
	world_resource.stage_2.visible = true
	world_resource.interaction_ui.visible = true
	$Timer.start()

func update(_delta: float) -> void:
	if LevelManager.is_day:
		$Timer.paused = false
		world_resource.label.text = "Regrowing..."
		world_resource.progress_bar.value += 100 / $Timer.wait_time * _delta
	elif !LevelManager.is_day:
		$Timer.paused = true
		world_resource.label.text = "Waiting for sun..."

func _on_timer_timeout() -> void:
	transitioned.emit(self, "harvestready")

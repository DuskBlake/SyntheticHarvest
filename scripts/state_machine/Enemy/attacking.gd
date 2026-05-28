extends State

class_name Attacking

func update(_delta: float) -> void:
	if LevelManager.is_day:
		transitioned.emit(self, "Decay")

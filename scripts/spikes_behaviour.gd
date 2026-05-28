extends Node
var enemies:Array[CharacterBody3D]

func _on_trigger_body_entered(body: Node3D) -> void:
	if body.is_in_group("Enemy") && $"..".placed:
		enemies.append(body)
		$cooldown.start()


func _on_cooldown_timeout() -> void:
	if enemies.size() > 0:
		for enemie in enemies:
			enemie.take_damage(10)
		$"..".health.value-=.2

func _process(delta: float) -> void:
	if enemies.size() <= 0:
		$cooldown.stop()


func _on_trigger_body_exited(body: Node3D) -> void:
	if body.is_in_group("Enemy") && $"..".placed:
		enemies.erase(body)

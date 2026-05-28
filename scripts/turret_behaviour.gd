extends Node

@export var bullet:PackedScene
@export var turret: StaticBody3D
@export var raycast:RayCast3D

var enemies_in_range:Array[CharacterBody3D]
var closest_enemie:CharacterBody3D
var lowest_distance:float
var current_distance:float
@export var timer: Timer


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("Enemy"):
		timer.start() 
		enemies_in_range.append(body)

func _process(delta: float) -> void:
	lowest_distance = 1000
	for enemie in enemies_in_range:
		current_distance = turret.position.distance_to(enemie.position)
		if current_distance < lowest_distance:
			lowest_distance = current_distance
			closest_enemie = enemie
	
	if turret.placed && closest_enemie:
		$"../MeshInstance3D3".look_at(closest_enemie.position)
		raycast.target_position = Vector3(0,0,-turret.position.distance_to(closest_enemie.position))
	
	if !closest_enemie:
		timer.stop()


func _on_area_3d_body_exited(body: Node3D) -> void:
	if body.is_in_group("Enemy"):
		closest_enemie = null
		raycast.target_position = Vector3.ZERO
		enemies_in_range.erase(body)


func _on_timer_timeout() -> void:
	if closest_enemie:
		closest_enemie.take_damage(25)

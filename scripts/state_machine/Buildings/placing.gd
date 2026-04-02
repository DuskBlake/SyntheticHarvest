extends State

class_name Placing

@export var building: StaticBody3D
@export var valid_material: Material
@export var invalid_material: Material

var tween: Tween
var from_angle: float
var to_angle: float
var can_rotate: bool

var can_place: bool
var just_created: bool
var nodes_inside: Array[Node3D]

func enter() -> void:
	building.collision.disabled = true
	can_rotate = true
	can_place = true
	just_created = true
	$Timer.start()

func update(_delta: float) -> void:
	if nodes_inside.size() > 0:
		can_place = false
		building.mesh.set_surface_override_material(0, invalid_material)
	else: 
		can_place = true
		building.mesh.set_surface_override_material(0,valid_material)
	
	if Input.is_action_just_pressed("place_building") && can_rotate && can_place && !just_created:
		building.reparent(get_tree().current_scene)
		can_rotate = false
		get_tree().get_first_node_in_group("Build_UI").building = false
		transitioned.emit(self,"placed")

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("rotate_building_right") and can_rotate:
		smoothRotate(1)
	if event.is_action_pressed("rotate_building_left") and can_rotate:
		smoothRotate(-1)

func smoothRotate(dir: float) -> void:
	can_rotate = false
	
	#angles set up
	from_angle = building.rotation.y
	to_angle = from_angle + deg_to_rad(90) * dir
	
	#animation
	tween = get_tree().create_tween()
	tween.finished.connect(func(): can_rotate = true)
	tween.tween_method(func (v):
		building.rotation.y = lerpf(from_angle, to_angle, v), 0.0, 1.0, 0.2).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
	#reset camera angle
	if building.rotation.y < 0.0001 and building.rotation.y > 0:
		building.rotation.y = 0

func _on_area_3d_body_entered(body: Node3D) -> void:
	nodes_inside.append(body)

func _on_area_3d_body_exited(body: Node3D) -> void:
	nodes_inside.erase(body)

func _on_timer_timeout() -> void:
	just_created = false

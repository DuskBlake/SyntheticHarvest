extends Camera3D

class_name CameraControl

@onready var camera_pivot: Node3D = $".."
@onready var animated_sprite_3d: AnimatedSprite3D = $"../../AnimatedSprite3D"
@onready var first_person_camera: Camera3D = $"../FirstPersonCamera"

var tween: Tween
var from_angle: float
var to_angle: float
var can_rotate: bool = true
static var first_person: bool = false

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("rotate_cam_right") and can_rotate and !first_person:
		smoothRotate(1)
	if event.is_action_pressed("rotate_cam_left") and can_rotate and !first_person:
		smoothRotate(-1)
	if event.is_action_pressed("change_view"):
		current = !current;
		animated_sprite_3d.visible = !animated_sprite_3d.visible;
		first_person = !first_person

func _process(delta: float) -> void:
	if first_person:
		Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	else: Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func smoothRotate(dir: float) -> void:
	can_rotate = false
	
	#angles set up
	from_angle = camera_pivot.rotation.y
	to_angle = from_angle + deg_to_rad(90) * dir
	
	#animation
	tween = get_tree().create_tween()
	tween.finished.connect(func(): can_rotate = true)
	tween.tween_method(func (v):
		camera_pivot.rotation.y = lerpf(from_angle, to_angle, v), 0.0, 1.0, 0.2).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
	#reset camera angle
	if camera_pivot.rotation.y < 0.0001 and camera_pivot.rotation.y > 0:
		camera_pivot.rotation.y = 0

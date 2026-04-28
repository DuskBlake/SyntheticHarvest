extends Control

@onready var option_button: OptionButton = $VBoxContainer/OptionButton

@export var hight: Array[int]
@export var width: Array[int]

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		visible = !visible

func _on_check_box_toggled(toggled_on: bool) -> void:
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
		print(DisplayServer.window_get_mode())
		option_button.disabled = true

	elif !toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		print(DisplayServer.window_get_mode())
		option_button.disabled = false
		DisplayServer.window_set_size(Vector2(hight[option_button.get_selected_id()], width[option_button.get_selected_id()]))
		


func _on_option_button_item_selected(index: int) -> void:
	DisplayServer.window_set_size(Vector2(hight[index], width[index]))
	


func _on_button_pressed() -> void:
	get_tree().quit()

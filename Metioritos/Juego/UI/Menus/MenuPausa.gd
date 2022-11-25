extends Control

func _ready():
	visible = false

func _input(event):
	if event.is_action_pressed("pausa"):
		visible = !visible
		if visible:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
		get_tree().paused = !get_tree().paused

func _on_BotonContinuar_pressed():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	get_tree().paused = false
	visible = false

func _on_BotonMenuPrincipal_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Juego/UI/MenuPrincipal.tscn")
	get_tree().paused = false

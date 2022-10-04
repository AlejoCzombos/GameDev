extends Control

func _ready():
	visible = false

func _input(event):
	if event.is_action_pressed("Pausa"):
		visible = !visible
		get_tree().paused = !get_tree().paused


func _on_BotonContinuar_pressed():
	get_tree().paused = false
	visible = false


func _on_BotonMenuPrincipal_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Juego/Menus/MenuPrincipal.tscn")
	get_tree().paused = false

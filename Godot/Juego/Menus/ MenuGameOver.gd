extends Control

export var nivelActual = ""


func _ready():
	nivelActual = DatosPlayer.nivelAcual
	DatosPlayer.reset()
	$AnimationPlayer.play("Herido")

func _on_BotonMenuPrincipal_pressed():
	get_tree().change_scene("res://Juego/Menus/MenuPrincipal.tscn")


func _on_BotonReintentar_pressed():
	get_tree().change_scene(nivelActual)

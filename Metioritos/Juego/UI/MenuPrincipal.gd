class_name menuPrincipal
extends Node

export(String, FILE,"*.tscn") var prox_nivel = ""

func _ready() -> void:
	MusicaJuego.playMusica(MusicaJuego.getListaMusica().menuPricipal)

func _on_Button_pressed() -> void:
	MusicaJuego.playBoton()
	get_tree().change_scene(prox_nivel)

func _on_BotonSalir_pressed():
	get_tree().quit()

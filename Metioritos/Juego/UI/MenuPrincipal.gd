class_name menuPrincipal
extends Node

func _ready() -> void:
	MusicaJuego.playMusica(MusicaJuego.getListaMusica().menuPricipal)


func _on_Button_pressed() -> void:
	MusicaJuego.playBoton()
	get_tree().change_scene("res://Juego/Niveles/LevelTest.tscn")

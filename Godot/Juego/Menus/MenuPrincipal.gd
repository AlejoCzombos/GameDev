extends Control

func _ready():
	DatosPlayer.reset()

export var Nivel1 = ""

func _on_BotonIniciarJuego_pressed():
	MusicaGlobal.replay()
	get_tree().change_scene(Nivel1)

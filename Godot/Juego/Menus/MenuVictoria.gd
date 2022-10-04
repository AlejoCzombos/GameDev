extends Control

func _ready():
	$"Panel puntaje/Puntaje".text = "Puntaje: {p}".format({"p": DatosPlayer.generarPuntaje()})


func _on_BotonMenuPrincipal_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Juego/Menus/MenuPrincipal.tscn")

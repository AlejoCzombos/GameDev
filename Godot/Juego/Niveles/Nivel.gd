extends Node
signal abrirPortal()

export var menuGameOver = "res://Juego/Menus/ MenuGameOver.tscn"
export var nivelActual = ""

var numeroLlave = 0
var contenedorLlaves 

func _ready():
	
# warning-ignore:return_value_discarded
	DatosPlayer.connect("gameOver", self, "gameOver")
	
	contenedorLlaves = get_node_or_null("Zanahorias")
	if contenedorLlaves != null:
		numeroLlavesNivel()

func numeroLlavesNivel():
	numeroLlave = contenedorLlaves.get_child_count()
	DatosPlayer.contabilizarLlaves(numeroLlave)
	for llave in contenedorLlaves.get_children():
		llave.connect("consumida", self, "llavesRestantes")

func llavesRestantes():
	numeroLlave -= 1
	print(numeroLlave)
	if numeroLlave == 0:
		emit_signal("abrirPortal")


func gameOver():
	DatosPlayer.nivelAcual = nivelActual
# warning-ignore:return_value_discarded
	get_tree().change_scene(menuGameOver)

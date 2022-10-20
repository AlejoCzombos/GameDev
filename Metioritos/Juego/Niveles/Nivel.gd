class_name Nivel
extends Node

onready var contenedorProyectiles:Node
onready var contenedorMeteoritos:Node

export var explosion:PackedScene = null
export var meteorito:PackedScene = null

func _ready() -> void:
	conectarSeniales()
	crearContenedores()

func conectarSeniales() -> void:
	Eventos.connect("disparo", self, "_on_disparo")
	Eventos.connect("naveDestruida", self, "_on_naveDestruida")
	Eventos.connect("crearMeteorito", self, "_on_crearMeteorito")

func crearContenedores() -> void:
	contenedorProyectiles = Node.new()
	contenedorProyectiles.name = "ContenedorProyectiles"
	add_child(contenedorProyectiles)
	contenedorMeteoritos = Node.new()
	contenedorMeteoritos.name = "ContenedorMeteoritos"
	add_child(contenedorMeteoritos)

func _on_disparo(proyectil:Proyectil) -> void:
	add_child(proyectil)

func _on_crearMeteorito(posicionSpawn:Vector2, direccionMeteorito: Vector2, tamanio: float) -> void:
	var new_meteorito:Node2D = meteorito.instance()
	new_meteorito.crear(posicionSpawn, direccionMeteorito, tamanio)
	contenedorMeteoritos.add_child(new_meteorito)

func _on_naveDestruida(posicion: Vector2, num_explosiones:int) -> void:
	for _i in range(num_explosiones):
		var new_explosion:Node2D = explosion.instance()
		new_explosion.global_position = posicion
		add_child(new_explosion)
		yield(get_tree().create_timer(0.6),"timeout")

class_name Nivel
extends Node

onready var contenedorProyectiles:Node
onready var contenedorMeteoritos:Node
onready var contenedorSectoresMeteorito:Node
onready var particulasMateorito:Node

export var explosion:PackedScene = null
export var meteorito:PackedScene = null
export var particulaMeteorito:PackedScene = null
export var destruccionMeteorito:PackedScene = null
export var SectorMeteoritos:PackedScene = null

func _ready() -> void:
	conectarSeniales()
	crearContenedores()

func conectarSeniales() -> void:
	Eventos.connect("disparo", self, "_on_disparo")
	Eventos.connect("naveDestruida", self, "_on_naveDestruida")
	Eventos.connect("naveEnSectorPeligro", self, "_on_naveEnSectorPeligro")
	Eventos.connect("crearMeteorito", self, "_on_crearMeteorito")
	Eventos.connect("particulasMeteorito", self, "_on_particulasMeteorito")
	Eventos.connect("destruccionMeteorito", self, "_on_destruccionMeteorito")

func crearContenedores() -> void:
	contenedorProyectiles = Node.new()
	contenedorProyectiles.name = "ContenedorProyectiles"
	add_child(contenedorProyectiles)
	contenedorMeteoritos = Node.new()
	contenedorMeteoritos.name = "ContenedorMeteoritos"
	add_child(contenedorMeteoritos)
	particulasMateorito = Node.new()
	particulasMateorito.name = "ContenedorMeteoritos"
	add_child(particulasMateorito)
	contenedorSectoresMeteorito = Node.new()
	contenedorSectoresMeteorito.name = "contenedorSectoresMeteorito"
	add_child(contenedorSectoresMeteorito)

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

func _on_particulasMeteorito(posicion: Vector2) -> void:
	var new_MeteoritoParticulas: Node2D = particulaMeteorito.instance()
	new_MeteoritoParticulas.global_position = posicion
	particulasMateorito.add_child(new_MeteoritoParticulas)

func _on_destruccionMeteorito(posicion: Vector2) -> void:
	var new_destruccionMeteorito: Node2D = destruccionMeteorito.instance()
	new_destruccionMeteorito.global_position = posicion
	particulasMateorito.add_child(new_destruccionMeteorito)

func _on_naveEnSectorPeligro(centroCam: Vector2, tipoPeligro: String, numeroPeligros: int) -> void:
	if tipoPeligro == "Meteorito":
		crearSectorMeteoritos(centroCam, numeroPeligros)
	elif tipoPeligro == "Enemigo":
		pass

func crearSectorMeteoritos(centroCamara: Vector2, numeroPeligros: int) -> void:
	var new_SectorMeteoritos:Node2D = SectorMeteoritos.instance()
	new_SectorMeteoritos.global_position = centroCamara
	contenedorSectoresMeteorito.add_child(new_SectorMeteoritos)

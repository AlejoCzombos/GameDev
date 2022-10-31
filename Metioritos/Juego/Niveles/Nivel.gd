class_name Nivel
extends Node

onready var contenedorProyectiles:Node
onready var contenedorMeteoritos:Node
onready var contenedorSectoresMeteorito:Node
onready var particulasMateorito:Node
onready var camaraNivel:Camera2D = $CameraNivel
onready var camaraPlayer:Camera2D = $Player/CamaraPlayer
onready var contenedorEnemigos:Node

export var tiempoTransicionCamara: float = 1.4
export var explosion:PackedScene = null
export var meteorito:PackedScene = null
export var particulaMeteorito:PackedScene = null
export var destruccionMeteorito:PackedScene = null
export var SectorMeteoritos:PackedScene = null
export var enemigoInterceptor:PackedScene = null

var numeroTotalMeteoritos:int = 0
var player:Player = null

func _ready() -> void:
	conectarSeniales()
	crearContenedores()
	player = DatosJuego.get_playerActual()

func conectarSeniales() -> void:
	Eventos.connect("disparo", self, "_on_disparo")
	Eventos.connect("naveDestruida", self, "_on_naveDestruida")
	Eventos.connect("naveEnSectorPeligro", self, "_on_naveEnSectorPeligro")
	Eventos.connect("crearMeteorito", self, "_on_crearMeteorito")
	Eventos.connect("particulasMeteorito", self, "_on_particulasMeteorito")
	Eventos.connect("destruccionMeteorito", self, "_on_destruccionMeteorito")
	Eventos.connect("baseDestruida", self, "_on_BaseDestruida")

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
	contenedorEnemigos = Node.new()
	contenedorEnemigos.name = "contenedorEnemigos"
	add_child(contenedorEnemigos)

func crearPosicionAleatorea(rangoHorizontal:float, rangoVertical: float) -> Vector2:
	randomize()
	var randX = rand_range(-rangoHorizontal, rangoHorizontal)
	var randY = rand_range(-rangoVertical, rangoVertical)
	return Vector2(randX, randY)

func _on_disparo(proyectil:Proyectil) -> void:
	add_child(proyectil)

func _on_crearMeteorito(posicionSpawn:Vector2, direccionMeteorito: Vector2, tamanio: float) -> void:
	var new_meteorito:Node2D = meteorito.instance()
	new_meteorito.crear(posicionSpawn, direccionMeteorito, tamanio)
	contenedorMeteoritos.add_child(new_meteorito)

func _on_naveDestruida(nave:Player, posicion: Vector2, num_explosiones:int) -> void:
	if nave is Player:
		transicionCamara(posicion, posicion + crearPosicionAleatorea(-200.0, 200.0), camaraNivel, tiempoTransicionCamara)
	crearExplosion(posicion, num_explosiones, 0.6, Vector2(-100.0,100.0))

func crearExplosion(posicion:Vector2, num_explosiones:int = 1, delay:float = 0.0, rangoAleatoreo:Vector2 = Vector2(0.0,0.0), escalaExplosion:float = 1) -> void:
	for _i in range(num_explosiones):
		var new_explosion:Node2D = explosion.instance()
		new_explosion.scale = Vector2(escalaExplosion,escalaExplosion)
		new_explosion.global_position = posicion + crearPosicionAleatorea(rangoAleatoreo.x, rangoAleatoreo.y)
		add_child(new_explosion)
		yield(get_tree().create_timer(delay),"timeout")

func _on_BaseDestruida(posiciones:Array) -> void:
	for posicion in posiciones:
		crearExplosion(posicion, 1, 0.4,Vector2(0.0,0.0), 1)
		yield(get_tree().create_timer(0.4),"timeout")
	yield(get_tree().create_timer(0.7),"timeout")
	crearExplosion(posiciones[0], 1, 0.0, Vector2(0.0,0.0), 2)

func _on_particulasMeteorito(posicion: Vector2) -> void:
	var new_MeteoritoParticulas: Node2D = particulaMeteorito.instance()
	new_MeteoritoParticulas.global_position = posicion
	particulasMateorito.add_child(new_MeteoritoParticulas)

func _on_destruccionMeteorito(posicion: Vector2) -> void:
	var new_destruccionMeteorito: Node2D = destruccionMeteorito.instance()
	new_destruccionMeteorito.global_position = posicion
	particulasMateorito.add_child(new_destruccionMeteorito)
	
	descontarMeteoritos()

func _on_naveEnSectorPeligro(centroCam: Vector2, tipoPeligro: String, numeroPeligros: int) -> void:
	if tipoPeligro == "Meteorito":
		crearSectorMeteoritos(centroCam, numeroPeligros)
	elif tipoPeligro == "Enemigo":
		crearSectorEnemigos(numeroPeligros)
		pass

func crearSectorEnemigos(numeroEnemigos:int) -> void:
	for _i in range(numeroEnemigos):
		var new_interceptor:EnemigoInterceptor = enemigoInterceptor.instance()
		var spawnPos:Vector2 = crearPosicionAleatorea(1000.0, 800.0)
		new_interceptor.global_position = player.global_position + spawnPos
		contenedorEnemigos.add_child(new_interceptor)

func crearSectorMeteoritos(centroCamara: Vector2, numeroPeligros: int) -> void:
	numeroTotalMeteoritos = numeroPeligros
	var new_SectorMeteoritos:Node2D = SectorMeteoritos.instance()
	new_SectorMeteoritos.crear(centroCamara, numeroPeligros)
	camaraNivel.global_position = centroCamara
	contenedorSectoresMeteorito.add_child(new_SectorMeteoritos)
	camaraNivel.zoom = camaraPlayer.zoom
	camaraNivel.devolverZoomOriginal()
	transicionCamara(camaraPlayer.global_position, camaraNivel.global_position, camaraNivel, tiempoTransicionCamara)

func transicionCamara(desde: Vector2, hasta: Vector2, camaraActual: Camera2D, tiempoTransicion: float) -> void:
	$TweenCamara.interpolate_property(camaraActual, "global_position", desde, hasta, tiempoTransicion , Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	camaraActual.current = true
	$TweenCamara.start()

func descontarMeteoritos() -> void:
	numeroTotalMeteoritos -= 1
	if numeroTotalMeteoritos <= 0:
		contenedorSectoresMeteorito.get_child(0).queue_free();
		camaraPlayer.set_puedeHacerseZoom(true)
		var zoomActual = camaraPlayer.zoom
		camaraPlayer.zoom = camaraNivel.zoom
		camaraPlayer.zoomSuavizado(zoomActual.x, zoomActual.y, 1.0)
		transicionCamara(camaraNivel.global_position, camaraPlayer.global_position, camaraPlayer, tiempoTransicionCamara * 0.10)

func _on_TweenCamara_tween_completed(object, _key) -> void:
	if object.name == "CamaraPlayer":
		 object.global_position = $Player.global_position

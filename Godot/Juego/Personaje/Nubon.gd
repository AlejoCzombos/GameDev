extends Node2D

onready var detectorJugador = $Sprite/RayCast2D
onready var posicionesDisparo = $Sprite/PosicionesDisparo
onready var cadenciaDisparo = $Timer
onready var rayoSonido = $RayoSonido

export var rayo: PackedScene

var puedeDisparar = true

func _process(_delta):
	if detectorJugador.is_colliding() && puedeDisparar:
		disparar()
		puedeDisparar = false
		cadenciaDisparo.start()

func disparar():
	rayoSonido.play()
	for posicion in posicionesDisparo.get_children():
		var nuevo_rayo = rayo.instance()
		nuevo_rayo.crear(posicion.global_position)
		add_child(nuevo_rayo)

func _on_Timer_timeout():
	puedeDisparar = true

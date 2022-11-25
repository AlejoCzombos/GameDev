class_name EnemigoOrbital
extends EnemigoBase

onready var detectorObstaculo:RayCast2D = $DetectorObstaculo

export var rangoMaxAtaque:float = 1400.0
export var velocidad:float = 400.0

var estacionDuenia:Node2D
var ruta:Path2D
var pathFollow:PathFollow2D

func _ready() -> void:
	Eventos.connect("baseDestruida", self, "_on_baseDestruida")
	canion.set_estaDisparando(true)

func _process(delta:float) -> void:
	pathFollow.offset += velocidad * delta
	position = pathFollow.global_position

func crear(pos:Vector2,duenia:Node2D, rutaDuenia:Path2D) -> void:
	global_position = pos
	estacionDuenia = duenia
	ruta = rutaDuenia
	pathFollow = PathFollow2D.new()
	ruta.add_child(pathFollow)

func rotarHaciaPlayer() -> void:
	.rotarHaciaPlayer()
	if dirPlayer.length() > rangoMaxAtaque || detectorObstaculo.is_colliding():
		canion.set_estaDisparando(false)
	else:
		canion.set_estaDisparando(true)

func _on_baseDestruida(base:Node2D,_pos) -> void:
	if base == estacionDuenia:
		destruir()

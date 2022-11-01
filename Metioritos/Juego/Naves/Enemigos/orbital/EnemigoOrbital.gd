class_name EnemigoOrbital
extends EnemigoBase

export var rangoMaxAtaque:float = 1400.0

var estacionDuenia:Node2D

func _ready() -> void:
	Eventos.connect("baseDestruida", self, "_on_baseDestruida")
	#temporal
	canion.set_estaDisparando(true)

func crear(pos:Vector2,duenia:Node2D) -> void:
	global_position = pos
	estacionDuenia = duenia

func rotarHaciaPlayer() -> void:
	.rotarHaciaPlayer()
	if dirPlayer.length() > rangoMaxAtaque:
		canion.set_estaDisparando(false)
	else:
		canion.set_estaDisparando(true)

func _on_baseDestruida(base:Node2D,_pos) -> void:
	if base == estacionDuenia:
		destruir()

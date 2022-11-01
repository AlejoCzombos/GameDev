class_name Canion
extends Node2D

export var proyectil:PackedScene = null
export var cadenciaDisparo: float = 0.8
export var velocidadProyectil: int = 100
export var danioProyectil: float = 1

onready var timerEnfriamiento: Timer = $TimerEnfriamiento
onready var disparoSFX: AudioStreamPlayer2D = $Disparo
onready var estaEnfriado:bool = true
onready var estaDisparando:bool = false setget set_estaDisparando
onready var puedeDisparar:bool = false setget set_puedeDisparar

var puntosDisparo:Array = []

func set_estaDisparando(disparando: bool) -> void:
	estaDisparando = disparando

func set_puedeDisparar(disparando: bool) -> void:
	puedeDisparar = disparando

func _ready() -> void:
	almacenarPuntosDisparo()
	timerEnfriamiento.wait_time = cadenciaDisparo

func _process(_delta: float) -> void :
	if estaDisparando && estaEnfriado && puedeDisparar:
		disparar()

func almacenarPuntosDisparo() -> void:
	for nodo in get_children():
		if nodo is Position2D:
			puntosDisparo.append(nodo)

func disparar() -> void:
	estaEnfriado = false
	disparoSFX.play()
	timerEnfriamiento.start()
	for punto_disparo in puntosDisparo:
		var new_proyectil:Proyectil = proyectil.instance()
		new_proyectil.crear(
			punto_disparo.global_position,
			get_owner().rotation,
			velocidadProyectil,
			danioProyectil
			)
		Eventos.emit_signal("disparo", new_proyectil)


func _on_TimerEnfriamiento_timeout():
	estaEnfriado = true

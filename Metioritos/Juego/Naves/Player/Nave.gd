class_name Nave
extends RigidBody2D

enum ESTADO {SPAWN, VIVO, INVENCIBLE, MUERTO}

export var hitpoints:float = 10.0
 
onready var canion: Canion = $Canion
onready var colisionador:CollisionShape2D = $CollisionShape2D
onready var ImpactoSFX: AudioStreamPlayer = $ImpactoSFX

var estadoActual:int = ESTADO.SPAWN

func _ready() -> void:
	controladorEstado(estadoActual)

func controladorEstado(nuevoEstado: int) -> void:
	match nuevoEstado:
		ESTADO.SPAWN:
			colisionador.set_deferred("disabled", true)
			canion.set_puedeDisparar(false)
		ESTADO.VIVO:
			colisionador.set_deferred("disabled", false)
			canion.set_puedeDisparar(true)
		ESTADO.INVENCIBLE:
			colisionador.set_deferred("disabled", true)
		ESTADO.MUERTO:
			colisionador.set_deferred("disabled", true)
			canion.set_puedeDisparar(false)
			Eventos.emit_signal("naveDestruida", self, global_position, 3)
			queue_free()
		_:
			printerr("Error estados")
	estadoActual = nuevoEstado


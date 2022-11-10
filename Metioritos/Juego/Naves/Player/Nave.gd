class_name Nave
extends RigidBody2D

enum ESTADO {SPAWN, VIVO, INVENCIBLE, MUERTO}

export var hitpoints:float = 10.0
 
onready var canion: Canion = $Canion
onready var colisionador:CollisionShape2D = $CollisionShape2D
onready var ImpactoSFX: AudioStreamPlayer = $ImpactoSFX
onready var barraSalud:BarraSalud = $ProgressBar

var estadoActual:int = ESTADO.SPAWN

func _ready() -> void:
	barraSalud.setValores(hitpoints)
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
			senialDestruccion()
			queue_free()
		_:
			printerr("Error estados")
	estadoActual = nuevoEstado

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "spawn":
		controladorEstado(ESTADO.VIVO)

func senialDestruccion() -> void:
	Eventos.emit_signal("naveDestruida", self, global_position, 3)

func recibirDanio(danio:float):
	hitpoints -= danio
	if hitpoints <= 0.0:
		controladorEstado(ESTADO.MUERTO)
	barraSalud.controlarBarra(hitpoints, true)
	ImpactoSFX.play()

func _on_body_entered(body):
	if body is Meteorito:
		body.destruir()
		destruir()

func destruir() -> void:
	controladorEstado(ESTADO.MUERTO)

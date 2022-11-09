class_name Escudo
extends Area2D

onready var animaciones:AnimationPlayer = $AnimationPlayer

export var energia:float = 8.0
export var radioDesgaste:float = -1.6

var estaActivado:bool = false setget, getEstaActivado
var energiaOriginal:float

func getEstaActivado()-> bool:
	return estaActivado

func _process(delta: float)-> void:
	controlarEnergia(radioDesgaste * delta)

func _ready()-> void:
	energiaOriginal = energia
	$CollisionShape2D.set_deferred("disabled", true)
	set_process(false)

func controlarEnergia(consumo: float) -> void:
	energia += consumo
	if energia > energiaOriginal:
		energia = energiaOriginal
	if energia <= 0.0:
		Eventos.emit_signal("ocultarEnergiaEscudo")
		desactivar()
		return
	
	Eventos.emit_signal("cambioEnergiaEscudo",energiaOriginal,energia)

func desactivar() -> void:
	set_process(false)
	estaActivado = false
	$CollisionShape2D.set_deferred("disabled", true)
	animaciones.play("CerrarEscudo ")

func activar() -> void:
	if energia <= 0.0:
		return
	estaActivado = true
	$CollisionShape2D.set_deferred("disabled", false)
	animaciones.play("AbrirEscudo")

func _on_AnimationPlayer_animation_finished(anim_name:String)->void:
	if anim_name == "AbrirEscudo" && estaActivado:
		animaciones.play("Activado")
		set_process(true)


func _on_body_entered(body):
	body.queue_free()

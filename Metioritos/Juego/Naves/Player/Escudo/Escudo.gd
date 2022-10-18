class_name Escudo
extends Area2D

onready var animaciones:AnimationPlayer = $AnimationPlayer

export var energia:float = 8.0
export var radioDesgaste:float = -1.6

var estaActivado:bool = false setget, getEstaActivado

func getEstaActivado()-> bool:
	return estaActivado

func _process(delta: float)-> void:
	energia += radioDesgaste * delta
	if energia <= 0.0:
		desactivar()

func _ready()-> void:
	$CollisionShape2D.set_deferred("disabled", true)
	set_process(false)

func desactivar() -> void:
	set_process(false)
	estaActivado = false
	$CollisionShape2D.set_deferred("disabled", true)
	animaciones.play_backwards("AbrirEscudo")

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

extends Node2D

onready var Canion = $Canion

var hitpoints:float = 10.0

func _process(delta: float)-> void :
	Canion.set_puedeDisparar(true)
	Canion.set_estaDisparando(true)
	

func _on_Area2D_body_entered(body):
	if body is Player:
		body.destruir()

func recibirDanio(danio:float):
	hitpoints -= danio
	if hitpoints <= 0.0:
		queue_free()

class_name EnemigoDummy
extends Node2D

onready var Canion = $Canion
onready var BarraVida:BarraSalud = $BarraSalud

var hitpoints:float = 30.0

func _ready():
	BarraVida.setValores(hitpoints)

func _process(_delta: float)-> void :
	Canion.set_puedeDisparar(true)
	Canion.set_estaDisparando(true)

func _on_Area2D_body_entered(body):
	if body is Player:
		body.destruir()

func recibirDanio(danio:float):
	hitpoints -= danio
	if hitpoints <= 0.0:
		Eventos.emit_signal("enemigoDestruido",self,position)
		queue_free()
	BarraVida.controlarBarra(hitpoints, true)

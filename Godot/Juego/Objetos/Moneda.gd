extends Area2D

onready var animacion = $AnimatedSprite
onready var animacionPlayer = $AnimationPlayer
onready var colisionPersonaje = $CollisionShape2D

export(String, "oro", "plata", "bronce") var tipoMoneda

onready var c = 0

func _ready():
	animacion.play()

func _on_body_entered(_body):
	DatosPlayer.sumarMonedas(tipoMoneda)
	colisionPersonaje.set_deferred("disable", true)
	animacionPlayer.play("Consumir")

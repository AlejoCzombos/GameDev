extends Area2D

onready var animacion = $AnimationPlayer
onready var sonidoSalto = $AudioStreamPlayer

func _ready():
	animacion.play("Idle")

func _on_DetectorImpulso_body_entered(body):
	animacion.play("Implusar")
	sonidoSalto.play()
	body.impulsar()

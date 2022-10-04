extends Area2D

export var dano = 50
onready var detectorJugador = $DetectorJugador
onready var detectorPisoton = $DetectorPisoton/Colisionador
onready var animacion  = $AnimationPlayer
onready var sonidoMuerte = $AudioStreamPlayer

func _on_DetectorPisoton_body_entered(body):
	desactivarColisiones([detectorJugador, detectorPisoton])
	animacion.stop()
	sonidoMuerte.play()
	animacion.play("Morir")
	body.impulsar()


func _on_body_entered(body):
	body.recargarEscena()

func desactivarColisiones(colisionadores):
	for colision in colisionadores:
		colision.set_deferred("disabled", true)
		colision.set_deferred("visible", false)

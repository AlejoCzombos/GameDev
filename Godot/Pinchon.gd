extends KinematicBody2D

export var velocidad = 100
export var dano = 50

var gravedad = 100.0
var movimiento = Vector2.ZERO

onready var animacion = $AnimatedSprite
onready var detectorVacio = $DetectorVacio
onready var detectorSolido = $DetectorSolido

func _physics_process(_delta):
	caer()
	caminar()
# warning-ignore:return_value_discarded
	move_and_slide(movimiento, Vector2.UP)

func caer():
	if not is_on_floor():
		movimiento.y = gravedad
func caminar():
	if not animacion.is_playing():
		animacion.play('Caminar')
	deteccionCollision()

	
	movimiento.x = velocidad

func animar(valor_actual):
	animacion.flip_h = !valor_actual

func deteccionCollision():
	if not detectorVacio.is_colliding() or detectorSolido.is_colliding():
		velocidad *= -1
		detectorVacio.position.x *= -1
		detectorSolido.position.x *= -1
		detectorSolido.scale *= -1
		animar(animacion.flip_h)

func _on_DetectorJugador_body_entered(body):
	body.recargarEscena()

extends Area2D

export var velocidad = 400
export var dano = 50

onready var animacion = $Animacion

var posicionRayo = Vector2.ZERO

func crear(posicion):
	posicionRayo = posicion

func _ready():
	global_position = posicionRayo
	animacion.play("Rayo")

func _process(delta):
	position.y += velocidad * delta

func _on_body_entered(body):
	if body.is_in_group("Jugador"):
		body.recargarEscena()
	destruirse()

func _on_VisibilityNotifier2D_screen_exited():
	destruirse()
	
func destruirse():
	queue_free()

extends KinematicBody2D

onready var Animacion = $AnimationPlayer
export var velocidad = 100
var movimiento = Vector2()

func input_jugador():
	movimiento = Vector2()
	if Input.is_action_pressed("Arriba"):
		movimiento.y -= 1
	if Input.is_action_pressed("Abajo"):
		movimiento.y += 1
	if Input.is_action_pressed("Derecha"):
		movimiento.x += 1
	if Input.is_action_pressed("Izquierda"):
		movimiento.x -= 1
	movimiento = movimiento.normalized() * velocidad

func animaciones():
	if movimiento.x == 0 && movimiento.y == 0 :
		Animacion.play("Idle")
	else:
		if not Animacion.is_playing():
			Animacion.play("Correr")
	
	if Input.is_action_just_pressed("Ataque"):
		Animacion.play("Atacar")

func _physics_process(_delta):
	input_jugador()
	animaciones()
	movimiento = move_and_slide(movimiento)

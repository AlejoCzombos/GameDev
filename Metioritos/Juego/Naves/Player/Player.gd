extends RigidBody2D

export var fuerzaMotor:int = 20
export var fuerzaRotacion:int = 280

var empuje:Vector2 = Vector2.ZERO
var direccionRotacion:int = 0

func _integrate_forces(state: Physics2DDirectBodyState) -> void:
	apply_central_impulse(empuje.rotated(rotation))
	apply_torque_impulse(direccionRotacion * fuerzaRotacion)

func _process(delta: float) -> void:
	player_input()

func player_input() -> void:
	#Empuje
	empuje = Vector2.ZERO
	if Input.is_action_pressed("MoverAdelante"):
		empuje = Vector2(fuerzaMotor, 0)
	elif Input.is_action_pressed("MoverAtras"):
		empuje = Vector2(-fuerzaMotor, 0)
	
	#rotacion
	direccionRotacion = 0
	if Input.is_action_pressed("RotarHorario"):
		direccionRotacion += 1
	elif Input.is_action_pressed("RotarAntihorario"):
		direccionRotacion -= 1

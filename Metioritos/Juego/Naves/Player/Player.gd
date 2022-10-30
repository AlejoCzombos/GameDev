class_name Player
extends Nave

export var fuerzaMotor:int = 20
export var fuerzaRotacion:int = 280
export var estelaMaxima:int = 150

onready var estela:Estela = $EstelaPuntoInicio/Trail2D
onready var motorSFX:Motor = $MotorSFX
onready var laser:RayoLaser = $LaserBeam2D setget, getLaser
onready var escudo: Escudo = $Escudo setget, getEscudo

var empuje:Vector2 = Vector2.ZERO
var direccionRotacion:int = 0

func getLaser() -> RayoLaser:
	return laser

func getEscudo() -> Escudo:
	return escudo

func _ready():
	DatosJuego.set_playerActual(self)

func _integrate_forces(_state: Physics2DDirectBodyState) -> void:
	apply_central_impulse(empuje.rotated(rotation))
	apply_torque_impulse(direccionRotacion * fuerzaRotacion)

func _process(_delta: float) -> void:
	player_input()

func _unhandled_input(event: InputEvent) -> void:
	if not esta_input_activo():
		return
	
	# Disparo Rayo
	if event.is_action_pressed("Disparo Secundario"):
		laser.set_is_casting(true)
	
	if event.is_action_released("Disparo Secundario"):
		laser.set_is_casting(false)
	
	if Input.is_action_pressed("MoverAdelante"):
		estela.set_max_points(estelaMaxima)
		motorSFX.sonido_on()
	elif Input.is_action_pressed("MoverAtras"):
		estela.set_max_points(0)
		motorSFX.sonido_on()
	
	if event.is_action_released("MoverAdelante") or event.is_action_released("MoverAtras"):
		motorSFX.sonido_off()
	
	#Escudo
	if Input.is_action_pressed("Escudo") && !escudo.getEstaActivado():
		escudo.activar()

func player_input() -> void:
	if not esta_input_activo():
		return
	
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
	
	#Disparo
	if Input.is_action_pressed("Disparo Principal"):
		canion.set_estaDisparando(true)
	if Input.is_action_just_released("Disparo Principal"):
		canion.set_estaDisparando(false)

func esta_input_activo() -> bool:
	if estadoActual in [ESTADO.MUERTO, ESTADO.SPAWN]:
		return false
	return true

func _on_AnimationPlayer_animation_finished(anim_name:String) -> void:
	if anim_name == "spawn":
		controladorEstado(ESTADO.VIVO)




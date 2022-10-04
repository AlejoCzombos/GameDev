extends KinematicBody2D

export var velocidad = Vector2(150.0,150.0);
export var aceleracion_caida = 400
export var fuerza_salto = 3000
export var fuerza_rebote = 350
export var impulso = -3800
var fuerza_salto_original
var aceleracion_caida_original
var puede_moverse = true
var vidas = 3

var movimiento = Vector2.ZERO

onready var animacion = $AnimatedSprite
onready var audioSalto = $AudioSalto
onready var camara = $Camera2D
onready var timerSalto = $EnfriaminetoSalto
onready var timerVuelo = $EnfriamientoVolar
onready var Animaciones = $AnimationPlayer

func _ready():
	Animaciones.play("Oscurecer")
	fuerza_salto_original = fuerza_salto
	aceleracion_caida_original = aceleracion_caida

func _physics_process(_delta):
	movimiento.x = velocidad.x * tomarDireccion()
# warning-ignore:return_value_discarded
	move_and_slide(movimiento, Vector2.UP)
	
	caer()
	saltar()
	colision_techo()
	CaidaAlVacio()
	
func tomarDireccion():
	var direccion = 0
	if puede_moverse:
		direccion = Input.get_action_strength("MovimientoDerecha") - Input.get_action_strength("MovimientoIzquierda")
		if direccion == 0 :
			animacion.play("Idle")
		else:
			if direccion < 0:
				animacion.flip_h = true
			else:
				animacion.flip_h = false
			animacion.play("Correr")
	return direccion

func caer():
	if not is_on_floor():
		animacion.play("Salto")
		movimiento.y += aceleracion_caida
		movimiento.y = clamp(movimiento.y, impulso, velocidad.y)

func saltar():
	if(Input.is_action_just_pressed("Salto") and is_on_floor() and puede_moverse) :
		animacion.play("Salto")
		audioSalto.play()
		saltar_movimiento()

func saltar_movimiento():
	movimiento.y = 0
	movimiento.y -= fuerza_salto

func impulsar():
	movimiento.y = impulso

func colision_techo():
	if is_on_ceiling():
		movimiento.y = fuerza_rebote

func cambiar_fuerza_salto():
	timerSalto.start()
	fuerza_salto = impulso * -1

func recargarEscena():
	DatosPlayer.restarVidas()
	Animaciones.play("OscurecerVerdad")
	if DatosPlayer.vidas >= 0:
# warning-ignore:return_value_discarded
		get_tree().reload_current_scene()

func CaidaAlVacio():
	if position.y > camara.limit_bottom:
		recargarEscena()

func _on_Enfriamineto_timeout():
	fuerza_salto = fuerza_salto_original

func volar():
	Animaciones.play("Vuelo")
	timerVuelo.start()
	aceleracion_caida = 60
	saltar_movimiento()

func _on_EnfriamientoVolar_timeout():
	Animaciones.play("Default")
	aceleracion_caida = aceleracion_caida_original

func playEntrarPortal(posicionPortal):
	Animaciones.play("entrarPortal")
	puede_moverse = false
	$Tween.interpolate_property(
		self,
		"global_position",
		global_position,
		posicionPortal,
		0.8, 
		Tween.TRANS_LINEAR, 
		Tween.EASE_IN
	)
	$Tween.start()


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "entrarPortal":
		Animaciones.play("OscurecerVerdad")

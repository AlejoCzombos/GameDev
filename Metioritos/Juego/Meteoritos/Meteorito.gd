class_name Meteorito
extends RigidBody2D

onready var ImpactoSFX:AudioStreamPlayer2D = $ImpactoSFX
onready var DestruccionSFX:AudioStreamPlayer2D = $DestruccionSFX
onready var Animacion:AnimationPlayer = $AnimationPlayer

export var velocidadLinealBase:Vector2 = Vector2(300.0, 300.0)
export var velocidadAngularBase:float = 3.0
export var hitpointsBase:float = 10.0

var hitpoints:float
var estaDentro:bool = true setget set_estaDentro
var velocidadSpawnOriginal:Vector2
var posicionOriginal:Vector2

func set_estaDentro(estado:bool) -> void:
	 estaDentro = estado

func _ready()-> void:
	angular_velocity = velocidadAngularBase
	posicionOriginal = global_position

func crear(posicion:Vector2, direccion:Vector2, tamanio:float) -> void:
	position = posicion
	posicionOriginal = position
	mass *= tamanio
	
	$Sprite.scale = Vector2.ONE * tamanio
	
	var radio:int = int($Sprite.texture.get_size().x / 2.3 * tamanio)
	var formaColiosionador:CircleShape2D = CircleShape2D.new()
	formaColiosionador.radius = radio
	$CollisionShape2D.shape = formaColiosionador
	
	linear_velocity = velocidadLinealBase * direccion / tamanio * randomizar() 
	velocidadSpawnOriginal = linear_velocity
	angular_velocity = velocidadAngularBase / tamanio * randomizar() 
	hitpoints = hitpointsBase * tamanio

func _integrate_forces(state: Physics2DDirectBodyState) -> void:
	if estaDentro:
		return
	
	var mi_transform := state.get_transform()
	mi_transform.origin = posicionOriginal
	linear_velocity = velocidadSpawnOriginal
	state.set_transform(mi_transform)
	estaDentro = true

func recibirDanio(danio:float) -> void:
	Eventos.emit_signal("particulasMeteorito", global_position)
	Animacion.play("Impacto")
	hitpoints -= danio
	if hitpoints <= 0.0:
		Animacion.play("destruccion")
		Eventos.emit_signal("destruccionMeteorito", global_position)
		$CollisionShape2D.set_deferred("disabled", true)
		return
	ImpactoSFX.play()

func destruir() -> void:
	Animacion.play("destruccion")
	Eventos.emit_signal("destruccionMeteorito", global_position)
	$CollisionShape2D.set_deferred("disabled", true)

func randomizar() -> float:
	randomize()
	return rand_range(1.1,1.4)

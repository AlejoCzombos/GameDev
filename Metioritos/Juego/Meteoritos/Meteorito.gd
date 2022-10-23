class_name Meteorito
extends RigidBody2D

onready var ImpactoSFX:AudioStreamPlayer2D = $ImpactoSFX
onready var Animacion:AnimationPlayer = $AnimationPlayer

export var velocidadLinealBase:Vector2 = Vector2(300.0, 300.0)
export var velocidadAngularBase:float = 3.0
export var hitpointsBase:float = 10.0

var hitpoints:float

func _ready()-> void:
	angular_velocity = velocidadAngularBase

func crear(posicion:Vector2, direccion:Vector2, tamanio:float):
	position = posicion
	mass *= tamanio
	
	$Sprite.scale = Vector2.ONE * tamanio
	
	var radio:int = int($Sprite.texture.get_size().x / 2.3 * tamanio)
	var formaColiosionador:CircleShape2D = CircleShape2D.new()
	formaColiosionador.radius = radio
	$CollisionShape2D.shape = formaColiosionador
	
	linear_velocity = velocidadLinealBase * direccion / tamanio
	angular_velocity = velocidadAngularBase / tamanio
	hitpoints = hitpointsBase * tamanio
	print("hitpoints", hitpoints)

func recibirDanio(danio:float):
	Eventos.emit_signal("particulasMeteorito", global_position)
	Animacion.play("Impacto")
	hitpoints -= danio
	if hitpoints <= 0.0:
		$CollisionShape2D.set_deferred("disabled", true)
		queue_free()
	ImpactoSFX.play()

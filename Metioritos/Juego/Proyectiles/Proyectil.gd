class_name Proyectil
extends Area2D

var velocidad:Vector2 = Vector2.ZERO
var danio:float = 2.0

func _physics_process(delta: float) -> void :
	position += velocidad * delta

func crear(pos: Vector2, dir: float, vel: float, _danio_p: int) -> void:
	position = pos
	rotation = dir
	velocidad = Vector2(vel, 0).rotated(dir)

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_area_entered(area:Area2D)->void:
	daniar(area)

func daniar(otro_cuerpo: CollisionObject2D) -> void:
	if otro_cuerpo.has_method("recibirDanio"):
		otro_cuerpo.recibirDanio(danio)
	queue_free()

func _on_body_entered(body: Node):
	daniar(body)

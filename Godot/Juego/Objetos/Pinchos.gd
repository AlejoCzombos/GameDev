extends Area2D

export var es_trampa = false

onready var detectorPersonaje = $RayCast2D
var color_trampa = Color.coral

func _ready():
	if es_trampa:
		$Sprite.modulate = color_trampa
		rotation_degrees = 180
		detectorPersonaje.enabled = true

func _process(_delta):
	if detectorPersonaje.is_colliding():
		detectorPersonaje.set_deferred("enabled", false)
		$AnimationPlayer.play("Caida")

func _on_body_entered(body):
	body.recargarEscena()

class_name Motor
extends AudioStreamPlayer2D

export var tiempoTransicion:float = 0.6
export var volumenApagado:float = -30.0

onready var tween_sonido:Tween = $Tween

var volumenOriginal:float

func _ready() -> void:
	volumenOriginal = volume_db
	volume_db = volumenApagado

func sonido_on() -> void:
	if not playing:
		play()
	efecto_transicion(volume_db, volumenOriginal)

func sonido_off() -> void:
	efecto_transicion(volume_db, volumenApagado)

func efecto_transicion(volumenInicial:float, volumenFinal:float) -> void:
	tween_sonido.interpolate_property(
		self,
		"volume_db",
		volumenInicial,
		volumenFinal,
		tiempoTransicion,
		Tween.TRANS_LINEAR,
		Tween.EASE_OUT_IN
	)
	tween_sonido.start()

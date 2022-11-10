class_name BarraSalud
extends ProgressBar

onready var tweenVisibilidad:Tween = $TweenVisibilidad
export var siempreVisible:bool = false

func _ready() -> void:
	modulate = Color(1,1,1,siempreVisible)

func setValores(hitpoints:float) -> void:
	max_value = hitpoints
	value = hitpoints

func controlarBarra(hitpointNave:float, mostrar:bool) -> void:
	value = hitpointNave
	
	if not tweenVisibilidad.is_active() and modulate.a != int(mostrar):
		tweenVisibilidad.interpolate_property(self,"modulate",Color(1,1,1,not mostrar), Color(1,1,1,mostrar),1.0,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
		tweenVisibilidad.start()


func _on_TweenVisibilidad_tween_all_completed():
	if modulate.a == 1.0:
		controlarBarra(value,false)

class_name ReleDeMasa
extends Node2D


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "spawn":
		$AnimationPlayer.play("activada")


func _on_Area2D_body_entered(body) -> void:
	$Area2D/CollisionShape2D.set_deferred("disabled", true)
	$AnimationPlayer.play("Superactivada")
	body.entradaRele()
	atraerPlayer(body)

func atraerPlayer(body: Node) -> void:
	$Tween.interpolate_property(
		body,
		"global_position",
		body.global_position,
		global_position,
		1.0,
		Tween.TRANS_EXPO,
		Tween.EASE_IN
	)
	$Tween.start()

func _on_Tween_tween_all_completed():
	print("qUE BUYEBO SOSSS")

extends Node

var playerActual:Player = null setget set_playerActual, get_playerActual

func set_playerActual(player:Player) -> void:
	playerActual = player

func get_playerActual() -> Player:
	return playerActual

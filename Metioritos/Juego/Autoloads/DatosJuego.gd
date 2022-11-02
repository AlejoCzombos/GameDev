extends Node

var playerActual:Player = null setget set_playerActual, get_playerActual

func set_playerActual(player:Player) -> void:
	playerActual = player

func get_playerActual() -> Player:
	return playerActual

func _ready():
	Eventos.connect("naveDestruida", self, "_on_naveDestruida")

func _on_naveDestruida(nave:Nave, _posicion, _explo) -> void:
	if nave is Player:
		playerActual = null

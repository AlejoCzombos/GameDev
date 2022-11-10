class_name musicaJuego
extends Node

onready var musicaNivel:AudioStreamPlayer = $MusicaNivel
onready var musicaCombate:AudioStreamPlayer = $MusicaCombate
onready var listaMusicas:Dictionary = {"menuPricipal": $MusicaMenuPricipal} setget, getListaMusica
onready var TweenOn:Tween = $TweenMusicaOn
onready var TweenOff:Tween = $TweenMusicaOff

export var tiempoTransicion:float = 4.0
export(float, -50.0, -20.0, 5.0) var volumenApagado= -40.0

var volOriginalMusicaOff:float = 0.0

func getListaMusica() -> Dictionary:
	return listaMusicas

func playBoton() -> void:
	$BotonMenu.play()

func setStreams(streamMusica:AudioStream, streamCombate:AudioStream) -> void:
	musicaNivel.stream = streamMusica
	musicaCombate.stream = streamCombate

func playMusica(musica:AudioStreamPlayer) -> void:
	stopTodo()
	musica.play()

func playMusicaNivel() -> void:
	stopTodo()
	musicaNivel.play()

func stopTodo() -> void:
	for nodo in get_children():
		if nodo is AudioStreamPlayer:
			nodo.stop()

func transicionMusica() -> void:
	if musicaNivel.playing:
		fade_in(musicaCombate)
		fade_out(musicaNivel)
	else:
		fade_in(musicaNivel)
		fade_out(musicaCombate)

func fade_in(musicaFadeIn:AudioStreamPlayer) -> void:
	var volumenOriginal = musicaFadeIn.volume_db
	musicaFadeIn.volume_db = volumenApagado
	musicaFadeIn.play()
	TweenOn.interpolate_property(musicaFadeIn,"volume_db",volumenApagado,volumenOriginal,tiempoTransicion,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
	TweenOn.start()


func fade_out(musicaFadeOut:AudioStreamPlayer) -> void:
	volOriginalMusicaOff = musicaFadeOut.volume_db
	TweenOff.interpolate_property(musicaFadeOut,"volume_db",musicaFadeOut.volume_db,volumenApagado,tiempoTransicion,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
	TweenOff.start()

func _on_TweenMusicaOff_tween_completed(object:Object, _key) ->void:
	object.stop()
	object.volume_db = volOriginalMusicaOff

class_name BaseState
extends Node

@export var animation_name: String

var player: Player

func enter() -> void:
	player.animations.play(animation_name)

func exit() -> void:
	pass
	
func didFinishAnimation():
	return not player.animations.is_playing()

func input(event: InputEvent) -> BaseState:
	return null

func process(delta: float) -> BaseState:
	return null

func physics_process(delta: float) -> BaseState:
	return null

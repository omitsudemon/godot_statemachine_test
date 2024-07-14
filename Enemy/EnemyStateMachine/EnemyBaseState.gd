class_name EnemyBaseState
extends Node

@export var animation_name: String

var enemy: Enemy

func enter() -> void:
	enemy.animations.play(animation_name)

func exit() -> void:
	pass

func didFinishAnimation():
	return not enemy.animations.is_playing()

func input(event: InputEvent) -> EnemyBaseState:
	return null

func process(delta: float) -> EnemyBaseState:
	return null

func physics_process(delta: float) -> EnemyBaseState:
	return null

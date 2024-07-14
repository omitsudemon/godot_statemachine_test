class_name Player
extends CharacterBody2D

@export var gravity: float = 10

@onready var animations : AnimatedSprite2D = $Animations
@onready var states = $StateMachine

## AIR ATTACK
var did_air_attack: bool = false

func airAttack():
	did_air_attack = true

func resetAirAttack():
	did_air_attack = false

func didAirAttack() -> bool:
	return did_air_attack
	
## DASH
var did_dash: bool = false

func didDash() -> bool:
	return did_dash

func doDash():
	did_dash = true

func resetDash():
	did_dash = false

## FALL ATTACK
var did_fall_attack: bool = false

func didFallAttack() -> bool:
	return did_fall_attack

func fallAttack():
	did_fall_attack = true

func resetFallAttack():
	did_fall_attack = false

## PROCESS
func _ready() -> void:
	states.init(self)

func _unhandled_input(event: InputEvent) -> void:
	states.input(event)

func _physics_process(delta: float) -> void:
	states.physics_process(delta)
	
func _process(delta: float) -> void:
	states.process(delta)

func _on_attack_collider_body_entered(body):
	print(body.damageEnemy())

class_name Enemy
extends CharacterBody2D

@export var gravity: float = 10

@onready var animations : AnimatedSprite2D = $EnemyAnimations
@onready var states = $EnemyStateMachine

var applyDamage:bool = false

## PROCESS
func _ready() -> void:
	states.init(self)

func _unhandled_input(event: InputEvent) -> void:
	states.input(event)

func _physics_process(delta: float) -> void:
	states.physics_process(delta)
	
func _process(delta: float) -> void:
	states.process(delta)

func damageEnemy():
	if not applyDamage:
		applyDamage = true
	return applyDamage

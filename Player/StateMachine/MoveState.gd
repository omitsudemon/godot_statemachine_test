class_name MoveState
extends BaseState

## Load
#Idle
@export var idle_node:NodePath
# Jump
@export var jump_node:NodePath
@export var fall_node:NodePath
# Move
@export var walk_node:NodePath
@export var run_node:NodePath
@export var dash_node:NodePath
@export var attack_node:NodePath

## Link
# Idle
@onready var idle_state: BaseState = get_node(idle_node)
# Jump
@onready var jump_state: BaseState = get_node(jump_node)
@onready var fall_state: BaseState = get_node(fall_node)
# Move
@onready var walk_state: BaseState = get_node(walk_node)
@onready var run_state: BaseState = get_node(fall_node)
@onready var dash_state: BaseState = get_node(dash_node)
@onready var attack_state: BaseState = get_node(attack_node)

@export var move_speed: float = 60

func enter() -> void:
	super.enter()
	player.velocity.x = 0

func input(event: InputEvent) -> BaseState:
	if Input.is_action_just_pressed("jump"):
		return jump_state

	if Input.is_action_just_pressed("dash") and not player.didDash():
		player.doDash()
		return dash_state
		
	if Input.is_action_just_pressed("move_right") or Input.is_action_just_pressed("move_left"):
		return walk_state
		
	if Input.is_action_just_pressed("attack"):
		return attack_state

	return null

func physics_process(delta: float) -> BaseState:
	if !player.is_on_floor():
		return fall_state

	var move = get_movement_input()
	
	if move < 0:
		player.animations.flip_h = true
	elif move > 0:
		player.animations.flip_h = false
	
	player.velocity.y += player.gravity
	player.velocity.x = move * move_speed
	player.move_and_slide()
	
	if player.didAirAttack() and player.is_on_floor():
		player.resetAirAttack()

	if move == 0:
		return idle_state
	else:
		return walk_state
	return null

func get_movement_input() -> int:
	if Input.is_action_pressed("move_left"):
		return -1
	elif Input.is_action_pressed("move_right"):
		return 1
	return 0

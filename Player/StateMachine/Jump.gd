extends BaseState

## Load
# Jump
@export var jump_node:NodePath
@export var fall_node:NodePath
# Move
@export var walk_node:NodePath
@export var run_node:NodePath
@export var dash_node:NodePath

@export var airattack_node:NodePath
@export var fallattack_node:NodePath

## Link
# Jump
@onready var jump_state: BaseState = get_node(jump_node)
@onready var fall_state: BaseState = get_node(fall_node)
# Move
@onready var walk_state: BaseState = get_node(walk_node)
@onready var run_state: BaseState = get_node(fall_node)
@onready var dash_state: BaseState = get_node(dash_node)
@onready var airattack_state: BaseState = get_node(airattack_node)
@onready var fallattack_state: BaseState = get_node(fallattack_node)

@export var jump_force: float = 200
@export var move_speed: float = 60

func enter() -> void:
	super.enter()
	#player.velocity.x = 0
	player.velocity.y = -jump_force

func input(event: InputEvent) -> BaseState:
	if Input.is_action_just_pressed("dash") and not player.didDash():
		player.doDash()
		return dash_state
	if Input.is_action_pressed("attack") and not Input.is_action_pressed("down") and not player.didAirAttack():
		player.velocity.x = 0
		player.airAttack()
		return airattack_state
	if Input.is_action_pressed("attack") and Input.is_action_pressed("down") and not player.didFallAttack():
		player.velocity.x = 0
		player.fallAttack()
		return fallattack_state
	return null

func physics_process(delta: float) -> BaseState:
	var move = get_movement_input()
	
	if move < 0:
		player.animations.flip_h = true
	elif move > 0:
		player.animations.flip_h = false
	
	player.velocity.y += player.gravity
	player.velocity.x = move * move_speed
	player.move_and_slide()
	
	if !player.is_on_floor() and player.velocity.y > 0:
		return fall_state
	return null

func get_movement_input() -> int:
	if Input.is_action_pressed("move_left"):
		return -1
	elif Input.is_action_pressed("move_right"):
		return 1
	return 0

extends BaseState

## Load
@export var idle_node:NodePath
@export var fall_node:NodePath
@export var walk_node:NodePath
@export var airattack_node:NodePath
@export var fallattack_node:NodePath
@export var dash_node:NodePath

## Link
@onready var idle_state: BaseState = get_node(idle_node)
@onready var fall_state: BaseState = get_node(fall_node)
@onready var walk_state: BaseState = get_node(walk_node)
@onready var airattack_state: BaseState = get_node(airattack_node)
@onready var fallattack_state: BaseState = get_node(fallattack_node)
@onready var dash_state: BaseState = get_node(dash_node)

@export var fall_force: float = 200
@export var move_speed: float = 60

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

func enter() -> void:
	super.enter()
	#player.velocity.x = 0

func physics_process(delta: float) -> BaseState:
	var move = get_movement_input()
	
	if move < 0:
		player.animations.flip_h = true
	elif move > 0:
		player.animations.flip_h = false
	
	player.velocity.y += player.gravity + sqrt(player.gravity)
	player.velocity.x = move * move_speed
	player.move_and_slide()

	if player.is_on_floor():
		player.resetAirAttack()
		player.resetFallAttack()
		player.resetDash()
		
		if move == 0:
			return idle_state
		elif move != 0:
			return walk_state # Improves transition from fall to walk
	return null

func get_movement_input() -> int:
	if Input.is_action_pressed("move_left"):
		return -1
	elif Input.is_action_pressed("move_right"):
		return 1
	return 0

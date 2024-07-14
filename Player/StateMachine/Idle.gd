extends BaseState

## Load
# Jump
@export var jump_node:NodePath
@export var fall_node:NodePath
# Move
@export var walk_node:NodePath
@export var run_node:NodePath

@export var dash_node:NodePath
@export var attack_node:NodePath


## Link
# Jump
@onready var jump_state: BaseState = get_node(jump_node)
@onready var fall_state: BaseState = get_node(fall_node)
# Move
@onready var walk_state: BaseState = get_node(walk_node)
@onready var run_state: BaseState = get_node(fall_node)
@onready var dash_state: BaseState = get_node(dash_node)
@onready var attack_state: BaseState = get_node(attack_node)

func enter() -> void:
	super.enter()
	player.velocity.x = 0

func input(event: InputEvent) -> BaseState:
	if Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right"):
		if Input.is_action_pressed("run"):
			return run_state
		return walk_state
	elif Input.is_action_pressed("attack"):
		return attack_state
	elif Input.is_action_pressed("jump"):
		return jump_state
	elif Input.is_action_just_pressed("dash") and not player.didDash():
		player.doDash()
		return dash_state
	return null

func physics_process(delta: float) -> BaseState:
	player.velocity.y += player.gravity
	player.move_and_slide()

	if !player.is_on_floor():
		return fall_state
	return null

extends BaseState

@export var jump_node:NodePath
@export var fall_node:NodePath

@onready var jump_state: BaseState = get_node(jump_node)
@onready var fall_state: BaseState = get_node(fall_node)

@export var fall_force: float = 200
@export var move_speed: float = 60

func enter() -> void:
	super.enter()

func input(event: InputEvent) -> BaseState:
	return null

func physics_process(delta: float) -> BaseState:
	var move = get_movement_input()

	if move < 0:
		player.animations.flip_h = true
	elif move > 0:
		player.animations.flip_h = false
	
	player.velocity.y += player.gravity * 5
	player.velocity.x = move * move_speed
	player.move_and_slide()
	
	if player.is_on_floor() and didFinishAnimation():
		return fall_state

	return null
	
func get_movement_input() -> int:
	if Input.is_action_pressed("move_left"):
		return -1
	elif Input.is_action_pressed("move_right"):
		return 1
	return 0

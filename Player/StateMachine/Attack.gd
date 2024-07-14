extends BaseState

@export var idle_node:NodePath
@export var walk_node:NodePath
@export var run_node:NodePath

@onready var idle_state: BaseState = get_node(idle_node)
@onready var walk_state: BaseState = get_node(walk_node)
@onready var run_state: BaseState = get_node(run_node)

func enter() -> void:
	super.enter()

func input(event: InputEvent) -> BaseState:
	if didFinishAnimation():
		if Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right"):
			return walk_state
	return null

func physics_process(delta: float) -> BaseState:
	if didFinishAnimation():
		if Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right"):
			return walk_state
		return idle_state
	return null

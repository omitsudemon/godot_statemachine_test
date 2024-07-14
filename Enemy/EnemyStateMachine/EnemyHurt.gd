extends EnemyBaseState

@export var idle_node:NodePath
@onready var idle_state: EnemyBaseState = get_node(idle_node)

func enter() -> void:
	super.enter()
	print("enter hurt state")

func physics_process(delta: float) -> EnemyBaseState:
	if didFinishAnimation():
		return idle_state
	return null

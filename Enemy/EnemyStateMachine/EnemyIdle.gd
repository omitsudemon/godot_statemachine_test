extends EnemyBaseState

@export var hurt_node:NodePath
@onready var hurt_state: EnemyBaseState = get_node(hurt_node)

func enter() -> void:
	super.enter()
	enemy.velocity.x = 0

func input(event: InputEvent) -> EnemyBaseState:
	return null

func physics_process(delta: float) -> EnemyBaseState:
	enemy.velocity.y += enemy.gravity
	enemy.move_and_slide()
	
	if enemy.applyDamage:
		print("exit idle state")
		enemy.applyDamage = false
		return hurt_state
	
	return null

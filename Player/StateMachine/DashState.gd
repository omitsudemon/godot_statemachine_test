extends MoveState

@export var dash_time:float = 0.1
@export var dash_power:float = 1000

var current_dash_time: float = 0
var dash_direction: int = 0

# Upon entering the state, set dash direction to either current input or the direction the player is facing if no input is pressed
func enter() -> void:
	super.enter()
	
	current_dash_time = dash_time
	
	if player.animations.flip_h:
		dash_direction = -1
	else:
		dash_direction = 1

# Override MoveState input() since we don't want to change states based on player input
func input(event: InputEvent) -> BaseState:
	return null

# Move in the dash_direction every frame
func get_movement_input() -> int:
	return dash_direction

# Track how long we've been dashing so we know when to exit
func physics_process(delta: float) -> BaseState:
	current_dash_time -= delta
	player.velocity.x = dash_direction * dash_power
	player.velocity.y = 0
	player.move_and_slide()

	if current_dash_time > 0.0:
		return null
		
	if player.is_on_floor():
		player.resetDash()
	
	if Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right"):
		if Input.is_action_pressed("move_right"):
			return run_state
		return walk_state
	return idle_state

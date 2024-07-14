extends AnimatedSprite2D

@onready var attack_collider:Area2D = $AttackCollider

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
var last_frame = -1
func _process(delta):
	if is_playing():
		if animation == "Attack":
			if last_frame != frame:
				attack_collider.process(frame)
				last_frame = frame
	pass

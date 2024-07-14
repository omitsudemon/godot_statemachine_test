extends Area2D

@onready var collision: CollisionShape2D = $CollisionShape2D

func process(frame):
	if frame == 1:
		collision.disabled = false
	else:
		collision.disabled = true

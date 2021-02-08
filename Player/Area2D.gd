extends Area2D

export (int) var health = 20

func _ready():
	add_to_group("allies")

func damage(amount: int):
	health -= amount
	if health <= 0:
		get_parent().queue_free()
		print("I am dead")

extends Area2D

export (int) var minSpeed = 10
export (int) var maxSpeed = 20
export (int) var minRotationRate = -20
export (int) var maxRotationRate = 20

export (int) var health = 20

var speed: int = 0 
var rotationRate: float = 0

func _ready():
	add_to_group('enemies')
	speed = rand_range(minSpeed, maxSpeed)
	rotationRate = rand_range(minRotationRate, maxRotationRate)

func _physics_process(delta):
	rotation_degrees += rotationRate * delta
	position.y += speed * delta

func damage(amount: int):
	health -= amount
	if health <= 0:
		queue_free()


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

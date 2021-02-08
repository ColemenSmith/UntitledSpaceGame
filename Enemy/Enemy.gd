extends Area2D

var plBullet := preload("res://EnemyBullet/EnemyBullet.tscn")

onready var enemyShotTimer = $EnemyShotTimer
onready var firingPositions = $FiringPositions

export (int) var minSpeed = 10
export (int) var maxSpeed = 20

export (int) var shotTimer = 5

export (int) var health = 20

var speed: float = 0

func _ready():
	add_to_group("enemies")
	speed = rand_range(minSpeed, maxSpeed)

func _physics_process(delta):
	position.y += speed * delta
	
	if enemyShotTimer.is_stopped():
		enemyShotTimer.start(shotTimer)
		
		for gun in firingPositions.get_children():
			var bullet := plBullet.instance()
			bullet.global_position = gun.global_position
			get_tree().current_scene.add_child(bullet)

func damage(amount: int):
	health -= amount
	if health <= 0:
		queue_free()


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_Enemy_area_entered(area):
	if area.is_in_group('allies'):
		area.damage(20)
		print("Enemy hit something")
		queue_free()

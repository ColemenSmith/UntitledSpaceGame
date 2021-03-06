extends KinematicBody2D
#USE CONTROL AND CLICK THE FUNCTION TO BRING UP HELP PAGE

var plBullet := preload("res://Bullet/Bullet.tscn") #pl is short for preload
#pl takes the resource and loads it before player

onready var animatedSprite := $AnimatedSprite
onready var firingPositions := $FiringPositions
onready var fireDelayTimer := $FireDelayTimer

export (int) var speed = 400
export (float) var fireDelay = .1

var velocity := Vector2.ZERO



func _ready():
	add_to_group('allies')

func get_input():
	velocity = Vector2.ZERO
	if Input.is_action_pressed('right'):
		velocity.x += 1
	if Input.is_action_pressed('left'):
		velocity.x -= 1
	if Input.is_action_pressed('down'):
		velocity.y += 1
	if Input.is_action_pressed('up'):
		velocity.y -= 1
	velocity = velocity.normalized() * speed

func _process(_delta):
	if velocity.x < 0:
		animatedSprite.play("Left")
	elif velocity.x > 0:
		animatedSprite.play("Right")
	else:
		animatedSprite.play("Straight")

	#check if we are shooting
	if Input.is_action_pressed("fire") and fireDelayTimer.is_stopped():
		fireDelayTimer.start(fireDelay)
		for gun in firingPositions.get_children():
			var bullet := plBullet.instance()
			bullet.global_position = gun.global_position
			get_tree().current_scene.add_child(bullet)

# warning-ignore:unused_argument
func _physics_process(delta):
	get_input()
	var collision_info = move_and_collide(velocity * delta)
	if collision_info:
		var collision_point = collision_info.position
	
	#velocity = move_and_slide(velocity)
	#make sure we are within the screen
	var viewRect := get_viewport_rect()
	position.x = clamp(position.x, 0, viewRect.size.x)
	position.y = clamp(position.y, 0, viewRect.size.y)

extends Area2D

export (int) var speed = 500

func _physics_process(delta):
	position.y += speed * delta

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_EnemyBullet_area_entered(area):
	if area.is_in_group('allies'):
		area.damage(10)
		queue_free()

extends Node

var plMeteor := preload("res://Meteor/Meteor.tscn")

export (float) var meteorSpawn = 5
export (int) var maxMeteor = 10

var meteorCount: int = 0

onready var meteorSpawnTimer = $MeteorSpawnTimer

func _process(delta): 
	if meteorCount < maxMeteor and meteorSpawnTimer.is_stopped():
		meteorSpawnTimer.start(meteorSpawn)
		meteorCount = meteorCount + 1
		
		var meteor := plMeteor.instance()
		var viewRect := get_viewport()		
		var random_x = randi() % int(900) + 1
		
		meteor.global_position = Vector2(random_x, -100)
		get_tree().current_scene.add_child(meteor)

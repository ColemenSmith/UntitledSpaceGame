extends Node

var plMeteor := preload("res://Meteor/Meteor.tscn")
var plEnemy := preload("res://Enemy/Enemy.tscn")

export (float) var meteorSpawn = 5
export (int) var maxMeteor = 10

export (float) var enemySpawn = 7
export (int) var maxEnemy = 10

var meteorCount: int = 0
var enemyCount: int = 0

onready var meteorSpawnTimer = $MeteorSpawnTimer
onready var enemySpawnTimer = $EnemySpawnTimer


func _process(delta): 
	if meteorCount < maxMeteor and meteorSpawnTimer.is_stopped():
		meteorSpawnTimer.start(meteorSpawn)
		meteorCount += 1
		
		var meteor := plMeteor.instance()
		var random_x = randi() % int(900) + 1
		
		meteor.global_position = Vector2(random_x + 50, -100)
		get_tree().current_scene.add_child(meteor)
	
	if enemyCount < maxEnemy and enemySpawnTimer.is_stopped():
		enemySpawnTimer.start(enemySpawn)
		enemyCount += 1
		
		var enemy := plEnemy.instance()
		var random_x = randi() % int(900) + 1
		
		enemy.global_position = Vector2(random_x, -100)
		get_tree().current_scene.add_child(enemy)

extends Node

signal wave_started(wave_number: int)
signal wave_completed(wave_number: int)
signal enemy_spawned(enemy: Node2D)

var current_wave: int = 0
var enemies_remaining: int = 0
var wave_in_progress: bool = false

# Wave configuration
var waves = [
	{
		"enemies": [
			{"type": "normal_slime", "count": 5, "delay": 1.0},
			{"type": "bat", "count": 3, "delay": 1.5}
		],
		"spawn_delay": 2.0
	},
	{
		"enemies": [
			{"type": "normal_slime", "count": 8, "delay": 0.8},
			{"type": "bat", "count": 5, "delay": 1.2},
			{"type": "goblin", "count": 2, "delay": 2.0}
		],
		"spawn_delay": 1.5
	}
]

# References to scenes
var enemy_scenes = {
	"normal_slime": preload("res://scenes/entities/units/normal_slime.tscn"),
	"bat": preload("res://scenes/entities/units/bat.tscn"),
	"goblin": preload("res://scenes/entities/units/goblin.tscn")
}

# Node references
@onready var spawn_points = $SpawnPoints

func _ready() -> void:
	# Initialize any needed setup
	pass

func start_wave() -> void:
	if wave_in_progress:
		return
		
	current_wave += 1
	if current_wave > waves.size():
		print("All waves completed!")
		return
		
	wave_in_progress = true
	var wave_data = waves[current_wave - 1]
	
	emit_signal("wave_started", current_wave)
	_spawn_wave(wave_data)

func _spawn_wave(wave_data: Dictionary) -> void:
	for enemy_data in wave_data["enemies"]:
		for i in range(enemy_data["count"]):
			await get_tree().create_timer(enemy_data["delay"]).timeout
			_spawn_enemy(enemy_data["type"])
	
	# Wait for all enemies to be defeated
	await get_tree().create_timer(wave_data["spawn_delay"]).timeout
	_check_wave_completion()

func _spawn_enemy(enemy_type: String) -> void:
	if not enemy_scenes.has(enemy_type):
		push_error("Enemy type not found: " + enemy_type)
		return
		
	var spawn_point = _get_random_spawn_point()
	if not spawn_point:
		push_error("No spawn points available")
		return
		
	var enemy = enemy_scenes[enemy_type].instantiate()
	enemy.position = spawn_point.position
	get_node("../UnitManager/Enemies").add_child(enemy)
	enemies_remaining += 1
	
	# Connect to enemy death signal
	if enemy.has_signal("defeated"):
		enemy.connect("defeated", _on_enemy_defeated)
	
	emit_signal("enemy_spawned", enemy)

func _on_enemy_defeated() -> void:
	enemies_remaining -= 1
	_check_wave_completion()

func _check_wave_completion() -> void:
	if enemies_remaining <= 0 and wave_in_progress:
		wave_in_progress = false
		emit_signal("wave_completed", current_wave)

func _get_random_spawn_point() -> Node2D:
	if not spawn_points or spawn_points.get_child_count() == 0:
		return null
	
	var points = spawn_points.get_children()
	return points[randi() % points.size()]

func get_current_wave() -> int:
	return current_wave

func is_wave_in_progress() -> bool:
	return wave_in_progress

class_name Health
extends Node

@export var _max_health : int
@onready var _health : int = _max_health: set = _set_health
var _min_health : int = 0

signal health_changed(previous_health, new_health)
signal health_depleted()
signal health_filled()

func increase_health(amount: int) -> void:
	_health += amount


func decrease_health(amount: int) -> void:
	_health -= amount


func deplete_health() -> void:
	_health = _min_health


func fill_health() -> void:
	_health = _max_health


func _set_health(value) -> void:
	var prevoius_health = _health
	_health = clamp(value, _min_health, _max_health)
	emit_signal("health_changed", prevoius_health, _health)
	
	match _health:
		_max_health:
			emit_signal("health_filled")
		_min_health:
			emit_signal("health_depleted")

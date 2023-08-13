class_name Hitbox
extends Area2D

@export var _damage : int

func _on_area_entered(hurtbox: Area2D) -> void:
	hurtbox.emit_signal("hit_registered", _damage)
	

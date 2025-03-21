extends Node2D

const bullet = preload("res://entities/bullet.tscn")
@onready var bullets: Node2D = $Bullets

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_player_shoot_bullet(source_id: String, pos: Vector2, dir: Vector2) -> void:
	var bullet_ins = bullet.instantiate()
	bullet_ins.direction = dir
	bullet_ins.source_id = source_id
	bullet_ins.position = pos
	bullets.add_child(bullet_ins)
	

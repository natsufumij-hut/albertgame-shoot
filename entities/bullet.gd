extends Node2D

@export var source_id: String = "player1"
@export var direction: Vector2 = Vector2.ZERO
@export var speed: float = 300.0
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@export var is_dead: bool = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not is_dead:
		position += direction * delta * speed
	#position = get_global_mouse_position()


func _on_area_2d_body_entered(body: Node2D) -> void:
	print("body enter: ",body.name)
	if body.is_in_group("player"):
		body.got_attacked()
	elif body.is_in_group("enemy"):
		body.got_attacked()
	animation_player.play("exposion")

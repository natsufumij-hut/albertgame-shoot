extends Line2D

@export var twirl_freq:float = 7.0


var twirl_time:float = 0.0
var preview_pos: Vector2 = Vector2.ZERO
var ball_radius: float =  0.0

func _ready() -> void:
	var texture = get_parent().texture
	ball_radius = texture.get_size().x * 0.5
	preview_pos = get_parent().global_position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var curr_pos = get_parent().global_position
	var dir = (curr_pos - preview_pos).normalized()
	
	twirl_time += delta * twirl_freq
	var twirl_offset = Vector2(cos(twirl_time)*ball_radius,sin(twirl_time)*ball_radius)
	
	add_point((curr_pos - ball_radius*dir) + twirl_offset)
	if get_point_count()>30:
		remove_point(0)

	preview_pos = curr_pos

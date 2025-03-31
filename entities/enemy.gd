extends Player

var is_target_in: bool =false
var target_in: Node2D
var escape_dir: Vector2 = Vector2.ZERO
var is_escape: bool = false

func get_direction_now() -> Vector2:
	if is_escape:
		return escape_dir
	else:
		return Vector2.ZERO

func _physics_process(delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var now_dir:Vector2 = get_direction_now()
	var direction_hor := now_dir.x
	var direction_ver := now_dir.y
	if direction_hor:
		velocity.x = direction_hor * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	if direction_ver:
		velocity.y = direction_ver * SPEED
	else:
		velocity.y = move_toward(velocity.y,0 ,SPEED)
	var dir = Vector2(-direction_hor,-direction_ver)
	if dir.length()!=0:
		var angle = dir.angle()+PI/2
		self.rotation = angle	
	move_and_slide()

func shoot():
	var angle = self.rotation+PI/2
	var dir = Vector2(cos(angle),sin(angle))
	var pos = marker_2d.global_position
	shoot_bullet.emit(player_id,pos,dir)	


func _on_sensor_range_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		is_target_in = true
		target_in = body
		print("player in...")


func _on_sensor_range_body_exited(body: Node2D) -> void:
	if body == target_in:
		target_in = null
		is_target_in = false
		print("player out...")

func has_target():
	return is_target_in

func get_target():
	return target_in

func set_escape_direct(dir: Vector2):
	if dir==Vector2.ZERO:
		is_escape=false
	else:
		print("set dir: ",dir)
		is_escape=true
	escape_dir=dir

extends Player

func get_direction_now() -> Vector2:
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

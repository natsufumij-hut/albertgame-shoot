extends CharacterBody2D


const SPEED = 300.0


func _physics_process(delta: float) -> void:

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction_hor := Input.get_axis("ui_left", "ui_right")
	var direction_ver := Input.get_axis("ui_up", "ui_down")	
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

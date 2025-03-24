class_name Player
extends CharacterBody2D

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var marker_2d: Marker2D = $Marker2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

const SPEED = 300.0

signal shoot_bullet(source_id: String, pos: Vector2, dir: Vector2)
signal died_one(player_id: String, score: int)

signal updat_hp(hp: int,hp_max: int)
signal update_coin(coin: int)
signal update_bullet(bullet:int, bullet_max: int)


@export var player_id = "player1"
@export var hp_max:int = 10:
	set(value):
		hp_max = value
		updat_hp.emit(hp,value)
@export var hp:int = 10:
	set(value):
		hp = value
		updat_hp.emit(value,hp_max)
		if value<=0:
			died()
		else:
			update_flag()
@export var score:int = 0:
	set(value):
		score = value
		update_coin.emit(score)

@export var player_drop_score:int = 3
@export var bullet_num:int = 10:
	set(value):
		bullet_num = value
		update_bullet.emit(bullet_num,bullet_max)
@export var bullet_max:int = 10:
	set(value):
		bullet_max = value
		update_bullet.emit(bullet_num,bullet_max)

func reset_hp():
	hp = hp_max
	score = 0
	bullet_num = bullet_max
	
func _physics_process(_delta: float) -> void:

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

	check_inputs()

func check_inputs():
	if Input.is_action_just_pressed("shoot"):
		shoot_one()

func shoot_one():
	if bullet_num>0:
		var angle = self.rotation+PI/2
		var dir = Vector2(cos(angle),sin(angle))
		var pos = marker_2d.global_position
		shoot_bullet.emit(player_id,pos,dir)
		bullet_num-=1
		update_bullet.emit(bullet_num,bullet_max)
		animation_player.play("shoot")


func died():
	died_one.emit(player_id,player_drop_score)
	animation_player.play("explosion")

func got_attacked():
	animation_player.play("attacked")
	hp -= 1

func update_flag():
	var per = hp * 1.0 / hp_max
	if sprite_2d:
		var now_frame = 1 - (sprite_2d.frame * 1.0 / sprite_2d.vframes)
		if per< now_frame and (sprite_2d.frame<sprite_2d.vframes-1):
			sprite_2d.frame += 1

func got_coin(coin: int):
	score += coin

extends Node2D

const bullet = preload("res://entities/bullet.tscn")
@onready var bullets: Node2D = $Bullets
@onready var life_hp: Label = $HUD/Status/Life/Label
@onready var score_label: Label = $HUD/Status/Score/Label
@onready var bullet_label: Label = $HUD/Status/Shoot/Label
@onready var planet: TileMapLayer = $Planet

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Player.reset_hp()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_player_shoot_bullet(source_id: String, pos: Vector2, dir: Vector2) -> void:
	var bullet_ins = bullet.instantiate()
	bullet_ins.direction = dir
	bullet_ins.source_id = source_id
	bullet_ins.position = pos
	bullets.add_child(bullet_ins)


func _on_player_updat_hp(hp: int, hp_max: int) -> void:
	life_hp.text = String.num_int64(hp) +" / "+String.num_int64(hp_max)


func _on_enemy_died_one(player_id: String, coin: int) -> void:
	$Player.got_coin(coin)

func _on_player_update_coin(coin: int) -> void:
	score_label.text = String.num_int64(coin)


func _on_player_update_bullet(bullet: int, bullet_max: int) -> void:
	bullet_label.text = "%d / %d" % [bullet,bullet_max]

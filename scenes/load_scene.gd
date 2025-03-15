extends Node2D

var loader
var progress: Array
@export var scene_path: String = ""  # 替换为你要加载的场景路径
@onready var target_node: Node2D = $TargetNode
@onready var animation_player: AnimationPlayer = $HUD/AnimationPlayer
@onready var progress_bar: ProgressBar = $HUD/ColorRect2/ProgressBar
@onready var loadper: Label = $HUD/ColorRect2/loadper
@onready var loadtext: Label = $HUD/ColorRect2/loadtext

func _ready():
	# 开始异步加载场景
	if scene_path:
		loader = ResourceLoader.load_threaded_request(scene_path)
		if loader == null:
			print("Failed to start loading scene.")
			return

func _process(delta: float) -> void:
	if loader == null:
		return

	# 检查加载状态
	var load_status = ResourceLoader.load_threaded_get_status(scene_path, progress)
	match load_status:
		ResourceLoader.THREAD_LOAD_IN_PROGRESS:
			update_progress()
		ResourceLoader.THREAD_LOAD_LOADED:
			loadtext.text = "load complete"
			update_progress()
			# 加载完成，切换到新场景
			var loaded_scene: PackedScene = ResourceLoader.load_threaded_get(scene_path)
			if loaded_scene:
				var target_node_ins = loaded_scene.instantiate()
				target_node.add_child(target_node_ins)
				animation_player.play("close_loader")
			else:
				print("Failed to load scene.")
			loader = null
		ResourceLoader.THREAD_LOAD_FAILED:
			# 加载失败
			print("Failed to load scene.")
			loader = null

func update_progress() -> void:
	# 更新进度显示
	var prg = progress[0]
	progress_bar.value = prg*100.0
	loadper.text = String.num(progress_bar.value)+"%"
	

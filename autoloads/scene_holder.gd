extends Node

# 目标场景
var scene_target_path: String
# 场景切换的参数，给新场景获取使用
var scene_args: Array

# 加载场景
func load_scene(scene_target: String,args: Array=[]):
	scene_target_path = scene_target
	scene_args = args
	get_tree().change_scene_to_file("res://scenes/load_scene.tscn")

# 直接跳转到指定场景，不加载
func go_to_scene(scene_target: String,args: Array=[]):
	scene_target_path = ""
	scene_args = args
	get_tree().change_scene_to_file(scene_target)

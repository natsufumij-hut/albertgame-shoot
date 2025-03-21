extends Node2D

@export var tile_set: TileSet
@onready var layers: Node2D = $MapLayers

const player_tscn: PackedScene = preload("res://entities/player.tscn")

# 噪声配置
@export var noise: FastNoiseLite
# 地图大小
var map_width = 300
var map_height = 100

func _ready() -> void:
	generate_tile_map2()

func generate_tile_map2() -> void:
	var lays:Array[float] = [-1.0,0.15,1.0]
	var terrians:Array[int] = [0,2]
	var lay_map: Dictionary = generate_map_layers(lays,terrians)
	var play_pos:Vector2i = lay_map['player']
	lay_map.erase('player')
	for lay in terrians:
		var layer = TileMapLayer.new()
		layer.tile_set = tile_set
		layer.set_cells_terrain_connect(lay_map[lay],0,lay)
		layers.add_child(layer)
	var player = player_tscn.instantiate()
	player.position = Vector2(play_pos.x * 64,play_pos.y * 64)
	var camera = Camera2D.new()
	layers.add_child(player)
	player.add_child(camera)
	
#func generate_tile_map() -> void:
	## 配置噪声
	#noise.seed = randi()  # 随机种子
	#var tilemap = TileMapLayer.new()
	#tilemap.tile_set = self.tile_set
	#const SEA = 0
	#const LANDEDGE = 1
	#const LAND = 2
	#var land_array: Array = [] # 陆地array
	#var sea_array: Array = generate_sea()
	#var seatilemap = TileMapLayer.new()
	#seatilemap.tile_set = self.tile_set
	#seatilemap.set_cells_terrain_connect(sea_array,0,SEA)
	#layers.add_child(seatilemap)
#
	#for x in range(map_width):
		#for y in range(map_height):
			## 获取噪声值（范围是 -1 到 1）
			#var noise_value = noise.get_noise_2d(x, y)
			##表示陆地
			#if noise_value>0:
				#land_array.append(Vector2i(x,y))
	#tilemap.set_cells_terrain_connect(land_array,0,LAND)
	#layers.add_child(tilemap)

func generate_sea() -> Array:
	var arr:Array = []
	for x in range(map_width):
		for y in range(map_height):
			arr.append(Vector2i(x,y))
	return arr

## -1,0,1  -> 0,2
func generate_map_layers(lays: Array[float], terrians: Array[int]) -> Dictionary:
	var arr: Array[int] = []
		# 配置噪声
	noise.seed = randi()  # 随机种子
	for y in range(map_height):
		for x in range(map_width):
			# 获取噪声值（范围是 -1 到 1）
			var noise_value = noise.get_noise_2d(x, y)
			var ter = get_terrian(noise_value, lays)
			if ter!=-1:
				arr.append(terrians[ter])
			else:
				arr.append(terrians[0])

	var dict: Dictionary =  flip_layers(arr,terrians)
	dict['player'] = calc_player_pos(arr,0)
	return dict

func get_terrian(value: float, lays:Array[float]) -> int:
	var result:int= -1
	var len = lays.size()
	for v in range(len):
		var ter = lays[v]
		if ter>=value:
			result = v
			break
	return result-1

func flip_layers(arr: Array,terrians: Array[int]) -> Dictionary:
	# <terrian, array[Vector2i]>
	var map: Dictionary = {}
	for y in range(map_height):
		for x in range(map_width):
			var ind = y*map_width+x
			var data = arr[ind]
			handle_ter(map,data,x,y,terrians)

	return map

func calc_player_pos(terrians: Array[int], tile: int) -> Vector2i:
	var poss: Array[Vector2i] = []
	for y in range(map_height):
		for x in range(map_width):
			var ind = y*map_width+x
			var ti = terrians[ind]
			if ti==tile:
				poss.append(Vector2i(x,y))
	return poss[randi() % poss.size()]

## dict:  <terrian, array[Vector2i]
func handle_ter(dict: Dictionary, data:int,x:int, y:int, terrians: Array[int])->void:
	var terrian_rev = terrians.duplicate()
	terrian_rev.reverse()
	var temp: = data
	var ter_len = terrians.size()
	for i in range(ter_len):
		var ter = terrian_rev[i]
		if ter==data:
			var arr = []
			if dict.has(ter):
				arr = dict[ter] as Array[Vector2i]
				arr.append(Vector2i(x,y))
				if i<(ter_len-1):
					data = terrian_rev[i+1]
			dict[ter]=arr
	

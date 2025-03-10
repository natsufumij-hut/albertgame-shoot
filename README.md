# albertgame-shoot
致命射击

# 该游戏的目标

1. 完成一个完整的休闲类游戏，包括
	- 单人模式（智能的敌人，有难度分区：简单、中等、难）
	- 多人模式（最多4个玩家局域网内游玩）
	- 自动地图生成

2. 支持多平台（通过github构建）
	- Windows 平台(支持手柄输入)
	- Android 平台(虚拟摇杆)
	- Linux 平台

3. 完整的风格和开放资源
	- 开放的图片
	- 开放的音频


# 项目架构
${project.dir}
- assets 外部资源文件  
	- audios  
	- fonts  
	- ...
- resources godot内部定义的资源文件
	- themes
	- configs
	- datas
	- map
	- ...
- autoloads 自动加载节点
- controls ui相关控件
- entities 游戏相关节点场景
- licenses 使用协议
- scenes 游戏主要的界面
- scripts 游戏代码


# 主要界面分为如下:
- Start 游戏开始界面
- Solo Game 单人游戏界面
- Multi Game 多人游戏界面
- Setting 设置界面

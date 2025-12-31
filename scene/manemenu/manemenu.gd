extends Control

@onready var arrow: Sprite2D = $"../arrow"
@onready var arrow_2: Sprite2D = $"../arrow2"
@onready var arrow_3: Sprite2D = $"../arrow3"
@onready var animation_player: AnimationPlayer = $"../AnimationPlayer"
@onready var hover: AudioStreamPlayer2D = $"../hover"
@onready var bg: Sprite2D = $"../bg"


func _on_start_mouse_entered() -> void:
	arrow.visible = true
	animation_player.play("movingpointer")
	hover.play()


func _on_start_mouse_exited() -> void:
	animation_player.stop()
	arrow.visible = false



##startgame
func _on_start_pressed() -> void:
	AudioTransition.fade_out()
	
	var saved_scene = SaveManager.get_saved_scene_path()
	
	if saved_scene != "":
		# سیو داریم → به صحنه ذخیره‌شده برو با ترنزیشن
		SceneTransition.load_scene(saved_scene)
	else:
		# سیو نداریم → شروع جدید
		SceneTransition.load_scene("res://scene/coridorlevel1s/corridorlevel1now/corridorlevel1now.tscn")
##---------------------

func _on_setting_mouse_entered() -> void:
	arrow_2.visible = true
	animation_player.play("movingpointer")
	hover.play()


func _on_setting_mouse_exited() -> void:
	arrow_2.visible = false
	animation_player.stop()




func _on_exit_mouse_entered() -> void:
	arrow_3.visible = true
	animation_player.play("movingpointer")
	hover.play()


func _on_exit_mouse_exited() -> void:
	arrow_3.visible = false
	animation_player.stop()

extends Node

const SAVE_FILE = "user://savegame.json"

const NO_SAVE_SCENES = [
	"res://scene/manemenu/manemenu.tscn",
	"res://scene/cursceneintrogame/introcutscene.tscn"
]

var save_data = {
	"current_scene": "",
	"lobbyman_dialog_done": false
}


var auto_save_timer: Timer

func _ready():
	auto_save_timer = Timer.new()
	add_child(auto_save_timer)
	auto_save_timer.wait_time = 1
	auto_save_timer.one_shot = false
	auto_save_timer.autostart = true
	auto_save_timer.timeout.connect(_on_auto_save)
	auto_save_timer.start()

func has_save() -> bool:
	return FileAccess.file_exists(SAVE_FILE)

func is_current_scene_save_allowed() -> bool:
	var current_path = get_tree().current_scene.scene_file_path
	return not NO_SAVE_SCENES.has(current_path)

func save_game():
	if not is_current_scene_save_allowed():
		return
	
	save_data["current_scene"] = get_tree().current_scene.scene_file_path
	
	var file = FileAccess.open(SAVE_FILE, FileAccess.WRITE)
	if file:
		file.store_string(JSON.stringify(save_data))
		file.close()

func _on_auto_save():
	save_game()

# جدید: فقط مسیر صحنه ذخیره‌شده رو برمی‌گردونه، عوض نمی‌کنه!
func get_saved_scene_path() -> String:
	if not has_save():
		return ""
	
	var file = FileAccess.open(SAVE_FILE, FileAccess.READ)
	if not file:
		return ""
	
	var json_text = file.get_as_text()
	file.close()
	
	var json = JSON.new()
	if json.parse(json_text) != OK:
		return ""
	
	var data = json.data
	if data is Dictionary and data.has("current_scene"):
		return data["current_scene"]
	
	return ""

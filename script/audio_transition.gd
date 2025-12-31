extends Node

const FADE_TIME := 1
const MUTE_DB := -80  # کمتر کن تا واقعاً بی‌صدا بشه

func fade_out() -> void:
	var tween = create_tween()
	var bus_count := AudioServer.get_bus_count()
	for i in range(bus_count):
		var idx := i                       # *بایند کردن* مقدار برای هر تکرار
		var start_db := AudioServer.get_bus_volume_db(idx)
		tween.tween_method(func(v): AudioServer.set_bus_volume_db(idx, v), start_db, MUTE_DB, FADE_TIME)
	await tween.finished
	# تضمین نهایی
	for i in range(bus_count):
		AudioServer.set_bus_volume_db(i, MUTE_DB)

func fade_in() -> void:
	var tween = create_tween()
	var bus_count := AudioServer.get_bus_count()
	for i in range(bus_count):
		var idx := i
		tween.tween_method(func(v): AudioServer.set_bus_volume_db(idx, v), MUTE_DB, 0.0, FADE_TIME)
	await tween.finished
	# تضمین نهایی
	for i in range(bus_count):
		AudioServer.set_bus_volume_db(i, 0.0)

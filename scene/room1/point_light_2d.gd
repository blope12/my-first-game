extends Light2D

const FREQ = 0.4
const AMPLITUDE = 0.25
const BASE = 1

const SCALE_AMPLITUDE = 0.08   # مقدار بزرگ و کوچیک شدن

var time_passed := 0.0

func _process(delta):
	time_passed += delta
	var t = 0.5 + 0.5 * sin(time_passed * TAU * FREQ)

	energy = BASE + AMPLITUDE * t
	scale = Vector2.ONE * (1.0 + SCALE_AMPLITUDE * t)

extends ColorRect

var return_string: String

func set_time(_hours: int, _minutes: int):
	var hours = (_hours + 8) % 12 + 1
	var minutes = _minutes % 60
	if minutes < 10:
		minutes = "0" + str(minutes)
	$Label.text = str(hours) + ":" + str(minutes)

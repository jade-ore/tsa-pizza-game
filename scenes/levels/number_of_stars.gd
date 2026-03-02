extends ColorRect
class_name MenuStarNumber

func set_stars(_stars: float):
	$Label.text = "Average " + str(_stars) + " stars"
	$TextureProgressBar.value = _stars

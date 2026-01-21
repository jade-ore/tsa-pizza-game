extends Control

func set_rating(rating: float):
	$TextureProgressBar.value = rating
	$Label.text = "Current rating: " + str(rating)

extends Control

func set_rating(rating: float):
	$TextureProgressBar.value = rating
	$Label.text = "Average rating: " + str(rating)

extends Resource
class_name Topping

static func get_selected_from_file(file_name: String):
	var img = load(file_name)
	var atlas_texture = AtlasTexture.new()
	atlas_texture.atlas = img
	atlas_texture.region = Rect2i(60, 0, 60, 60)
	return atlas_texture

static func get_normal_from_file(file_name: String):
	var img = load(file_name)
	var atlas_texture = AtlasTexture.new()
	atlas_texture.atlas = img
	atlas_texture.region = Rect2i(0, 0, 60, 60)
	return atlas_texture
  

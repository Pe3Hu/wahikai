class_name BodyResource extends Resource


var skald: SkaldResource
var words: Array[WordResource]
var functional_words: Array[WordResource]
var disabled_words: Array[WordResource]


func _init(skald_: SkaldResource) -> void:
	skald = skald_
	
	init_words()
	
func init_words() -> void:
	var titles = ["head", "chest", "arm", "hand", "leg", "foot"]
	var level = 1
	
	for title in titles:
		var _word = WordResource.new(self, title, level)
		functional_words.append(_word)
	
func get_damage(value_: int) -> bool:
	var damaged_word = functional_words.pick_random()
	var damaged_letter = damaged_word.get_nonzero_level_letters().pick_random()
	damaged_word.change_letter_level(damaged_letter.title, value_)
	return damaged_word.level == 0

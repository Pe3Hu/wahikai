class_name VocabularyResource extends Resource


var skald: SkaldResource
var words: Array[WordResource]


func _init(skald_: SkaldResource) -> void:
	skald = skald_
	
	init_words()
	
func init_words() -> void:
	var types = ["weapon", "aspect", "element"]
	var level = 1
	
	for type in types:
		var title = Global.dict.word.type[type].pick_random()
		var _word = WordResource.new(self, title, level)
	

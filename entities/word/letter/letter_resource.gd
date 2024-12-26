class_name LetterResource extends Resource


var word: WordResource
var title: String
var level: int


func _init(word_: WordResource, title_: String, level_: int) -> void:
	word = word_
	word.letters.append(self)
	title = title_
	level = level_

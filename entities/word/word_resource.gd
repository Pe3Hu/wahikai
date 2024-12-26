class_name WordResource extends Resource


var holder: Resource
var title: String
var level: int
var letters: Array[LetterResource]


func _init(holder_: Resource, title_: String, level_: int) -> void:
	holder = holder_
	holder.words.append(self)
	title = title_
	level = level_
	
	for letter in title_:
		var _letter = LetterResource.new(self, letter, level)
	
func get_nonzero_level_letters() -> Array:
	if level == 0:
		return []
		
	var _letters = []
	
	for letter in letters:
		if letter.level > 0:
			_letters.append(letter)
	
	return _letters
	
func change_letter_level(title_: String, value_: int) -> void:
	for letter in letters:
		if letter.title == title_:
			letter.level += value_
			break
	
	update_level()
	
func update_level() -> void:
	level = letters.front().level
	
	for letter in letters:
		level = min(level, letter.level)

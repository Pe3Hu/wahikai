class_name SongResource extends Resource


var skald: SkaldResource
var words: Array[WordResource]
var letters: Array[LetterResource]
var pedestals: Dictionary
var available_letters: Dictionary

var letter_limit = 4


func _init(skald_: SkaldResource) -> void:
	skald = skald_
	
	reset()
	
func reset() -> void:
	init_words()
	init_pedestals()
	
func init_words() -> void:
	words.clear()
	letters.clear()
	available_letters = {}
	
	for word in skald.vocabulary.words:
		words.append(word)
		
		for letter in word.letters:
			letters.append(letter)
			
			if !available_letters.has(letter.title):
				available_letters[letter.title] = []
			
			available_letters[letter.title].append(letter)
	
func init_pedestals() -> void:
	letters.shuffle()
	
	for letter in available_letters:
		available_letters[letter].shuffle()
	
	var options = available_letters.keys()
	options.shuffle()
	
	for _i in letter_limit:
		var pedestal = {}
		var letter_title = options.pop_front()
		var letter_resource = available_letters[letter_title].pop_front()
		pedestal.weight = letter_resource.level
		pedestals[letter_title] = pedestal
		letters.erase(letter_resource)
	
func shout() -> int:
	if letters.is_empty():
		return 0
	
	var letter = letters.pop_front()
	
	if !pedestals.has(letter.title):
		remove_shaky_pedestal()
		pedestals[letter.title] = {}
		pedestals[letter.title].weight = 0
	
	pedestals[letter.title].weight += letter.level
	return pedestals[letter.title].weight
	
func remove_shaky_pedestal() -> void:
	var instabilities = pedestals.keys()
	instabilities.sort_custom(func (a, b): return available_letters[a].size() < available_letters[b].size())
	
	var options = []
	
	for letter in instabilities:
		if available_letters[instabilities.front()].size() == available_letters[letter].size():
			options.append(letter)
		else:
			break
	
	var shaky = options.pick_random()
	pedestals.erase(shaky)

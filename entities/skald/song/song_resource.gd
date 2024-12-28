class_name SongResource extends Resource


var skald: SkaldResource
var words: Array[WordResource]
var letters: Array[LetterResource]
var pedestals: Dictionary
var available_letters: Dictionary

var letter_limit = 4


func _init(skald_: SkaldResource) -> void:
	skald = skald_
	
	init_words()
	analyze()
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
	
func analyze() -> void:
	var synergies = {}
	
	var keys = available_letters.keys()#.filter(func (a): available_letters[a].size() > 1)
	keys.sort_custom(func(a, b): return available_letters[a].size() > available_letters[b].size())
	#print(keys)
	var _words = []
	
	for word in words:
		_words.append(word.title)
	
	var sorted_lettes = {}
	for letter in keys:
		sorted_lettes[letter] = available_letters[letter].size()
	print(_words)
	print(sorted_lettes)
	
	var middle_pascal_triangle = []
	
	for _i in range(0, 10, 1):
		#var a = middle_pascal_triangle[_i]
		#var b = middle_pascal_triangle[_i + 1]
		#var c = a + b
		var sum = 0
		
		for _j in range(1, _i + 1, 1):
			sum += _j
		middle_pascal_triangle.append(sum)
	
	var best_words = Global.dict.word.title.keys().filter(func (a): return !_words.has(a))
	var words_score = {}
	
	for word in best_words:
		words_score[word] = 0
		var score = {}
		
		for letter in word:
			if sorted_lettes.has(letter) and !score.has(letter):
				score[letter] = sorted_lettes[letter] + word.count(letter)
		
		for letter in score:
			
			words_score[word] += score[letter] * word.count(letter) + middle_pascal_triangle[word.count(letter)]
	
	best_words = best_words.filter(func (a): return words_score[a] > 0)
	best_words.sort_custom(func(a, b): return words_score[a] > words_score[b])
	for _i in 5:
		print([best_words[_i], words_score[best_words[_i]]])
	
	var _score = {}
	
	for letter in best_words.front():
		if sorted_lettes.has(letter) and !_score.has(letter):
			_score[letter] = sorted_lettes[letter] + best_words.front().count(letter)
			
	#for letter in _score:
	#	print([letter, _score[letter] * best_words.front().count(letter), middle_pascal_triangle[best_words.front().count(letter)]])
		#words_score[word] += _score[letter] * word.count(letter) + middle_pascal_triangle[word.count(letter)]
	

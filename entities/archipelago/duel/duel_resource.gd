class_name DuelResource extends Resource


var archipelago: ArchipelagoResource
var skalds: Array[SkaldResource]
var winner: SkaldResource
var loser: SkaldResource


func _init(archipelago_: ArchipelagoResource, skalds_: Array[SkaldResource]) -> void:
	archipelago = archipelago_
	archipelago.duels.append(self)
	
	for skald in skalds_:
		skald.duel = self
		skald.song.reset()
		skalds.append(skald)
	
	#skalds.shuffle()
	starts_performances()
	print(skalds.find(winner))
	
func starts_performances() -> void:
	while winner == null:
		normal_performance()
	
func normal_performance() -> void:
	var is_draw = true
	var weights = {}
	
	for skald in skalds:
		weights[skald] = skald.song.shout()
		is_draw = is_draw and !skald.song.letters.is_empty()
	
	var _skalds = weights.keys()
	_skalds.sort_custom(func (a, b): return weights[a] > weights[b])
	
	if _skalds.front() != _skalds.back():
		var damage = weights[_skalds.back()] - weights[_skalds.front()]
		var is_defeated = _skalds.back().body.get_damage(damage)
		
		if is_defeated:
			loser = _skalds.back()
			winner = _skalds.front()
	
	if is_draw:
		for skald in skalds:
			skald.song.reset()

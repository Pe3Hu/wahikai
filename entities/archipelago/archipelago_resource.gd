class_name ArchipelagoResource extends Resource


var skalds: Array[SkaldResource]
var duels: Array[DuelResource]


func _init() -> void:
	Global._ready()
	init_skalds()
	init_duels()
	
func init_skalds() -> void:
	for _i in 2:
		var _skald = SkaldResource.new(self)
	
func init_duels() -> void:
	var _skalds: Array[SkaldResource]
	_skalds.append_array(skalds)
	var _duel = DuelResource.new(self, _skalds)

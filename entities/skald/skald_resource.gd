class_name SkaldResource extends Resource


var archipelago: ArchipelagoResource
var vocabulary: VocabularyResource
var body: BodyResource
var song: SongResource
var duel: DuelResource


func _init(archipelago_: ArchipelagoResource) -> void:
	archipelago = archipelago_
	archipelago.skalds.append(self)
	
	body = BodyResource.new(self)
	vocabulary = VocabularyResource.new(self)
	song = SongResource.new(self)

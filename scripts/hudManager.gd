extends Control

@onready var manatxt: Label = $container/manaCon/manatxt
@onready var voltastxt: Label = $container/voltas/voltastxt
@onready var kmtxt: Label = $container/Km/Kmtxt
@onready var listatxt: Label = $container/lista/listatxt
@onready var player: CharacterBody3D = $"../../Player"

func _process(delta: float) -> void:

	manatxt.text = str(player.mana)
	voltastxt.text = str(player.volta_atual)
	kmtxt.text = str(int(player.vlc * 3))

	if player.combo.is_empty():
		listatxt.text = "INVOQUE SUA MAGIA"
	else:
		var texto_combo = ""

		for selo in player.combo:
			match selo:
				"A":
					texto_combo += "selo1\n"
				"B":
					texto_combo += "selo2\n"
				"C":
					texto_combo += "selo3\n"
				"D":
					texto_combo += "selo4\n"

		listatxt.text = texto_combo

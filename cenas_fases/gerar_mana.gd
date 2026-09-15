extends GridMap

var celulas
var time = 3.0

func _ready():
	celulas = get_used_cells()

func _process(delta):
	time -= delta

	if time <= 0:
		
		for cell in celulas:
			var tile = get_cell_item(cell)

			if tile == 4:
				var tem_mana = false
				if !tem_mana:
					
					var manaObj = load("res://cenas_obj/mana_obj.tscn").instantiate()
					get_parent().add_child(manaObj)
					var posicao = map_to_local(cell)
					manaObj.global_position = to_global(posicao)
					time = 3.0
					tem_mana = true
					

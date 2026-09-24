extends GridMap

var celulas

func _ready():
	celulas = get_used_cells()

	for cell in celulas:
		var tile = get_cell_item(cell)

		if tile == 4:
			var geradorobj = load("res://cenas_obj/gerador.tscn").instantiate()

			get_tree().current_scene.add_child.call_deferred(geradorobj)

			var posicao = to_global(map_to_local(cell))

			posicao.y -= 0.8

			geradorobj.global_position = posicao

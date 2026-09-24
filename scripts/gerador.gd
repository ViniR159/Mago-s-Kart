extends MeshInstance3D

var tempo = randf_range(4.0, 6.0)
var tem_mana = false

func _process(delta):	
	
	if !tem_mana:
		tempo -= delta
		
		
		if tempo <= 0:
			var mana = load("res://cenas_obj/mana_obj.tscn").instantiate()
			
			get_parent().add_child(mana)
			
			mana.global_position = global_position + Vector3.UP * 0.3
			tem_mana = true


func _on_area_3d_area_entered(area: Area3D) -> void:
	if area.is_in_group("Player"):
		if tem_mana:
			tem_mana = false
			tempo = randf_range(4.0, 6.0)

extends Control

@onready var manatxt: Label = $container/manaCon/manatxt as Label
@onready var player: CharacterBody3D = $"../../Player"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	manatxt.text = str(player.mana)

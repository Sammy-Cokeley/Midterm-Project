extends Node2D

func _ready():
	GameEvents.connect("item_gathered", self, "manage_inventory")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func manage_inventory():
	pass

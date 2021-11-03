extends Node2D

var exit_scene = load("res://1x/Brick Wall With Open Exit.png")

func _on_Area2D_area_entered(area):
	if area.get_parent() is Item:
		if area.get_parent()._name == "Pick Axe":
			self.get_parent().get_child(0).texture = exit_scene
			area.get_parent().queue_free()
			GameEvents.emit_signal("end_game")

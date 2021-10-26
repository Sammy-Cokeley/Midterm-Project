extends Node

class_name Item

export(bool) var _mergeable = false;

var _mouse_over = false;

func _input(event):
	if _mouse_over and event.is_pressed() and event.button_index == BUTTON_LEFT:
		GameEvents.emit_signal("item_gathered", _mergeable, _mouse_over);
		self.queue_free(); 

func _on_Area2D_mouse_entered():
	_mouse_over = true;

func _on_Area2D_mouse_exited():
	_mouse_over = false;

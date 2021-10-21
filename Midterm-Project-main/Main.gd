extends Node2D

var left_arrow = load("res://1x/Left Pointer.png");
var right_arrow = load("res://1x/Right Pointer.png");

var _wall_pointer = 0
var _left_mouse_entered = false;
var _right_mouse_entered = false;

func _ready():
	GameEvents.connect("item_gathered", self, "manage_inventory")
	$CaveRoom/NorthWall.visible = true;

func manage_inventory():
	pass

func _on_LeftArea_mouse_entered():
	print("left area entered")
	Input.set_custom_mouse_cursor(left_arrow)
	_left_mouse_entered = true;

func _on_RightArea_mouse_entered():
	print("right area entered")
	Input.set_custom_mouse_cursor(right_arrow)
	_right_mouse_entered = true;

func _on_LeftArea_mouse_exited():
	print("left area exited")
	Input.set_custom_mouse_cursor(null)
	_left_mouse_entered = false;

func _on_RightArea_mouse_exited():
	print("right area exited")
	Input.set_custom_mouse_cursor(null)
	_right_mouse_entered = false;

func _input(event):
	if _left_mouse_entered and event.is_pressed() and event.button_index == BUTTON_LEFT:
		print(_wall_pointer)
		_wall_pointer = _wall_pointer - 1
		if(_wall_pointer == -1):
			_wall_pointer = 3
		GameEvents.emit_signal("update_view", _wall_pointer)
	elif _right_mouse_entered and event.is_pressed() and event.button_index == BUTTON_LEFT:
		print(_wall_pointer)
		_wall_pointer = _wall_pointer + 1
		if(_wall_pointer == 4):
			_wall_pointer = 0
		GameEvents.emit_signal("update_view",_wall_pointer)

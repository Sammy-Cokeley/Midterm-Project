extends Node2D

export var _item_scene: PackedScene

var pick_head_texture = load("res://1x/Pickaxe Head.png")
var handle_texture = load("res://1x/Wooden Handle.png")
var pick_axe_texture = load("res://1x/pick_axe.png")

var left_arrow = load("res://1x/Left Pointer.png");
var right_arrow = load("res://1x/Right Pointer.png");

var _item_count = 0;
var _current_room = 1;
var _wall_pointer = 0;
var _left_mouse_entered = false;
var _right_mouse_entered = false;

func _ready():
	GameEvents.connect("item_gathered", self, "manage_inventory")
	GameEvents.connect("change_rooms", self, "move_player")
	GameEvents.connect("reduce_count", self, "change_count")
	GameEvents.connect("end_game",self,"disable_travel")
	$CaveRoomStart/NorthWall.visible = true;
	$CanvasLayer/RoomLabel.text = "Room: " + str(_current_room)

func manage_inventory(item_name):
	if item_name == "Pick Head":
		spawn_pick_head()
	elif item_name == "Wood Handle":
		spawn_wood_handle()
	elif item_name == "Pick Axe":
		spawn_pick_axe()

func inventory_place(count):
	if count == 0:
		return Vector2(40,30)
	elif count == 1:
		return Vector2(105,30)
	elif count == 2:
		return Vector2(120,30)
	elif count == 3:
		return Vector2(160,30)

func change_count(count):
	_item_count = _item_count - count

func _on_LeftArea_mouse_entered():
	Input.set_custom_mouse_cursor(left_arrow)
	_left_mouse_entered = true;

func _on_RightArea_mouse_entered():
	Input.set_custom_mouse_cursor(right_arrow)
	_right_mouse_entered = true;

func _on_LeftArea_mouse_exited():
	Input.set_custom_mouse_cursor(null)
	_left_mouse_entered = false;

func _on_RightArea_mouse_exited():
	Input.set_custom_mouse_cursor(null)
	_right_mouse_entered = false;

func _input(event):
	if _left_mouse_entered and event.is_pressed() and event.button_index == BUTTON_LEFT:
		_wall_pointer = _wall_pointer - 1
		if(_wall_pointer == -1):
			_wall_pointer = 3
		GameEvents.emit_signal("update_view", _wall_pointer)
	elif _right_mouse_entered and event.is_pressed() and event.button_index == BUTTON_LEFT:
		_wall_pointer = _wall_pointer + 1
		if(_wall_pointer == 4):
			_wall_pointer = 0
		GameEvents.emit_signal("update_view",_wall_pointer)

func update_room_name():
	$CanvasLayer/RoomLabel.text = "Room: " + str(_current_room)

func move_player(wall_number):
	if _current_room == 1 and wall_number == 4:
		_current_room = 2
		$CaveRoomStart.visible = false
		$CaveRoomTwo.visible = true
		update_room_name()
		GameEvents.emit_signal("update_view",_wall_pointer)
	elif _current_room == 2 and wall_number == 2:
		_current_room = 1
		$CaveRoomTwo.visible = false
		$CaveRoomStart.visible = true
		update_room_name()
	elif _current_room == 2 and wall_number == 1:
		_current_room = 3
		$CaveRoomTwo.visible = false
		$CaveRoomThree.visible = true
		update_room_name()
	elif _current_room == 3 and wall_number == 3:
		_current_room = 2
		$CaveRoomThree.visible = false
		$CaveRoomTwo.visible = true
		update_room_name()

func spawn_pick_axe():
	var pick_axe = _item_scene.instance() as Node2D
	pick_axe._mergeable = true
	pick_axe._name = "Pick Axe"
	pick_axe.get_child(0).texture = pick_axe_texture
	pick_axe.position = inventory_place(_item_count)
	pick_axe._initial_position = pick_axe.position
	self.get_child(3).add_child(pick_axe)
	_item_count += 1

func spawn_pick_head():
	var pick_head = _item_scene.instance() as Node2D
	pick_head._mergeable = true
	pick_head._name = "Pick Head"
	pick_head.get_child(0).texture = pick_head_texture
	pick_head.position = inventory_place(_item_count)
	pick_head._initial_position = pick_head.position
	self.get_child(3).add_child(pick_head)
	_item_count += 1

func spawn_wood_handle():
	var handle = _item_scene.instance() as Node2D
	handle._mergeable = true
	handle._name = "Wood Handle"
	handle.get_child(0).texture = handle_texture
	handle.position = inventory_place(_item_count)
	handle._initial_position = handle.position
	self.get_child(3).add_child(handle)
	_item_count += 1

func disable_travel():
	$LeftArea/LeftCollisionShape.disabled = true
	$RightArea/RightCollisionShape.disabled = true

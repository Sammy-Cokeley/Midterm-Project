extends CanvasLayer

func _ready():
	GameEvents.connect("end_game", self, "show_end_card")

func show_end_card():
	$EndLabel.visible = true
	$EndRect.visible = true

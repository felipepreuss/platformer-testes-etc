extends CanvasLayer

func _ready():
	visible = false

func _process(_delta):
	if Input.is_action_just_pressed("Pausar") && !visible:
		visible = true
		get_tree().paused = true
	elif Input.is_action_just_pressed("Pausar")	&& visible:
		visible = false
		get_tree().paused = false
	
func _on_resume_pressed():
	get_tree().paused = false
	visible = false
	 # Replace with function body.


func _on_options_pressed():
	pass # Replace with function body.

func _on_quit_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://menu.tscn") # Replace with function body.
	

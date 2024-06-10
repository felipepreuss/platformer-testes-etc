extends CharacterBody2D

var jumping = false
# Coyote Time
var coyote_time = false
# Jump Buffering
var jump_buffer = false



var velocidade = 300
var gravidade = 10
var pulo_forca = -300

func _physics_process(delta):
	
	velocity.x = Input.get_axis("Esquerda","Direita") * velocidade
	if velocity.x != 0:
		$AnimatedSprite2D.flip_h = velocity.x < 0
		
		$AnimatedSprite2D.play("walk")
	else:
			$AnimatedSprite2D.play("default")
		
	if Input.is_action_just_pressed("Pular") && is_on_floor():
		velocity.y = pulo_forca
	elif !is_on_floor():
		$AnimatedSprite2D.play("falling")
	velocity.y += gravidade
	move_and_slide()
	
func _jump_state(delta):
	if is_on_floor():
		jumping = false
	else:
		jumping = true

extends CharacterBody2D

var jumping = false
var coyote_time = false
var jump_buffer = false
var last_floor = false  

var velocidade = 300
var gravidade = 10
var pulo_forca = -300

enum  {
	IDLE,
	WALK,
	JUMP,
	FALL
}
var defaultState = IDLE

func _physics_process(delta):
	print(coyote_time)
	velocity.x = Input.get_axis("Esquerda","Direita") * velocidade
	if velocity.x != 0:
		$AnimatedSprite2D.flip_h = velocity.x < 0
		
		$AnimatedSprite2D.play("walk")
	else:
			$AnimatedSprite2D.play("default")
		
	if Input.is_action_just_pressed("Pular") && (is_on_floor() or coyote_time):
		velocity.y = pulo_forca
		jumping = true
		coyote_time = false
		$Coyote.stop()
	
	move_and_slide()
	last_floor = is_on_floor()
	if is_on_floor():
			coyote_time = false
			jumping = false
			$Coyote.stop()
	velocity.y += gravidade
	if !is_on_floor()  && !jumping:	
		coyote_time = true
		$Coyote.start()
		$AnimatedSprite2D.play("falling")
	elif not is_on_floor() and jumping:
		coyote_time = false
		
		$Coyote.stop()	
		$AnimatedSprite2D.play("falling")
	elif !is_on_floor():
		$AnimatedSprite2D.play("falling")
	
#func _jump_state(delta):
#	if is_on_floor():
	#	jumping = false
	#	defaultState = FALL
#	else:
	#	jumping = true
		#defaultState = JUMP
		
func _on_coyote_timeout():
	coyote_time = false # Replace with function body.

extends CharacterBody2D

var jumping = false
var coyote_time = false
var jump_buffer = false
 

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
		
	if Input.is_action_just_pressed("Pular") && is_on_floor() or coyote_time:
		velocity.y = pulo_forca
		jumping = true
		defaultState = PULANDO()
		 # Reset coyote time when jumping
		
		
	if is_on_floor() and !coyote_time:
			coyote_time = false
			jumping = false
	
	if $Coyote.is_stopped():
		coyote_time = false
		jumping = false
	if coyote_time:
		$Coyote.start()
		
	elif Input.is_action_just_pressed("Pular") && !is_on_floor():	
		coyote_time = true
		
	elif !is_on_floor():
		$AnimatedSprite2D.play("falling")
		$Coyote.stop()  
	velocity.y += gravidade
	move_and_slide()
	match defaultState:
		IDLE:
			PARADO()
		WALK:
			ANDANDO()
		JUMP:
			PULANDO()
		FALL:
			CAINDO()
			
func PARADO():
	pass

func ANDANDO():
	pass

func PULANDO():
	pass
	
func CAINDO():
	pass

func _jump_state(delta):
	if is_on_floor():
		jumping = false
		defaultState = FALL
	else:
		jumping = true
		defaultState = JUMP

#func _on_coyote_timeout():
	#coyote_time = false # Replace with function body.
	

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
	
	if Input.is_action_just_pressed("Pular") && !jump_buffer:
		jump_buffer = true
		$Buffer.start()
	
	if is_on_floor():
		jumping = false

	if is_on_floor() && jump_buffer:
			coyote_time = false
			jumping = true
			jump_buffer = true
			velocity.y = pulo_forca
			
			$Coyote.stop()
			
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
		
	velocity.y += gravidade
	move_and_slide()

func _on_coyote_timeout():
	coyote_time = false # Replace with function body.
	
func _on_buffer_timeout():
	jump_buffer = false # Replace with function body.


 

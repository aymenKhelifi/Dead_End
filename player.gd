extends KinematicBody2D

const UP = Vector2(0,-1)
const GRAVITY = 20
const MAX_SPEED = 200
const JUMP_HEIGHT = -500
const ACCELERATION = 50
var motion = Vector2()
var double_jump = true 

func _physics_process(delta):
	motion.y += GRAVITY
	var friction = false
	
	if Input.is_action_pressed("ui_right"):
		motion.x = min(MAX_SPEED, motion.x+ACCELERATION)
		$Sprite.flip_h = false
		$Sprite.play("Run")
		
	elif Input.is_action_pressed("ui_left"):
		motion.x = max(-MAX_SPEED, motion.x-ACCELERATION)
		$Sprite.flip_h = true
		$Sprite.play("Run")
	
	else:
		$Sprite.play("Idle")
		friction=true 
		
	if is_on_floor() :
		motion.x = lerp(motion.x, 0, 0.2)		
		if Input.is_action_just_pressed("ui_up"):
			motion.y = JUMP_HEIGHT
			double_jump=true
	else : 
		motion.x = lerp(motion.x, 0, 0.05)		
		if motion.y < 0:
			$Sprite.play("Jump") 
			if double_jump:
				if Input.is_action_just_pressed("ui_up"):
					motion.y += JUMP_HEIGHT/2
					double_jump=false
					$Sprite.play("Jump")
		else : 
			$Sprite.play("Fall") 
			
	motion = self.move_and_slide(motion, UP)
	
	pass

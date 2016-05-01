SuperStrict
Import "..\objects\Sprite.bmx"
Import "..\objects\weremEngine.bmx"

Type Turtle Extends Sprite

	Field angle:Double = 0.0
	Field amplitude:Int = 10
	Field rgba:Int


	Field lastPositionX:Int = 0
	Field lastPositionY:Int = 0

	
	
	Global STATE_IDLE:Int = 0
	Global STATE_RUNNING:Int = 1
	
	Function createTurtle:Turtle()
		Local returnValue:Turtle = New Turtle
		returnValue.init()
		MapInsert(returnValue.animations, "idle", Animation.createAnimation(0, 0, 1))
		MapInsert(returnValue.animations, "ninja", Animation.createAnimation(1, 1, 1))
		returnValue.setAnimation("idle")
		Return returnValue		
	EndFunction
	
	Method init()
		Super.init()
		AutoMidHandle(True)
		debug = False
		SpriteSheet = LoadAnimImage("Media/Logo-sheet.png", 15, 15, 0, 2)
		w = 15
		h = 15
		imageOffsetX = 0
		imageOffsetY = 0
	EndMethod
	
	
	Method draw()
		Super.draw()
		SetRotation(angle)
		performAnimation()
		SetRotation(0)
	EndMethod
	
EndType


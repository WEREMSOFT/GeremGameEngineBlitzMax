
SuperStrict
Import "..\objects\Sprite.bmx"
Import "..\objects\weremEngine.bmx"

Type Hero Extends Sprite

	Field angle:Double = 0.0
	Field amplitude:Int = 10
	Field rgba:Int



	Field lastPositionX:Int = 0
	Field lastPositionY:Int = 0

	
	
	Global STATE_IDLE:Int = 0
	Global STATE_RUNNING:Int = 1
	
	Function createHero:Hero()
		Local returnValue:Hero = New Hero
		returnValue.init()
		MapInsert(returnValue.animations, "walk", Animation.createAnimation(5, 15, 1000/10))
		MapInsert(returnValue.animations, "idle", Animation.createAnimation(0, 2, 2000))
		MapInsert(returnValue.animations, "run", Animation.createAnimation(17, 31, 1000/15))
		Return returnValue		
	EndFunction
	
	Method init()
		Super.init()
		AutoMidHandle(True)
		debug = False
		SpriteSheet = LoadAnimImage("Media/PapersPlease.png",64,64,0,36)
		state = Hero.STATE_RUNNING
		w = 14
		h = 33
	EndMethod
	
	Method preDraw()
		Super.preDraw()
		processCommon()
	EndMethod
		
	Method draw()
		Select state
			Case Hero.STATE_IDLE
				processStateIdle
			Case Hero.STATE_RUNNING
				processStateRunning()
		EndSelect
		Super.draw()
	EndMethod
	
	Method passToStateIdle()
		state = Hero.STATE_IDLE
		setAnimation("idle")
	EndMethod
	
	Method passToStateRunning()
		If(state <> Hero.STATE_RUNNING) Then 
			state = Hero.STATE_RUNNING
			setAnimation("run")
		EndIf
	EndMethod
	
	Method processCommon()
		Local pressed:Int = 0
		lastPositionX = x
		lastPositionY = y
		If KeyDown(KEY_LEFT) Then
			x:- 2;
			flipped = -1 
			pressed = 1
		ElseIf KeyDown(KEY_RIGHT) Then
			x:+ 2
			flipped = 1
			pressed = 1
		EndIf
		
		If KeyDown(KEY_UP) Then
			y:- 2
			pressed = 1
		ElseIf KeyDown(KEY_DOWN) Then
			y:+ 2
			pressed = 1
		EndIf
		
	EndMethod
	
	
	
	Method processStateRunning()
		If lastPositionX = x And lastPositionY = y Then
			passToStateIdle
		EndIf
		performAnimation()
	EndMethod
	
	Method processStateIdle()
		If lastPositionX <> x Or lastPositionY <> y Then
			passToStateRunning
		EndIf
		performAnimation()
	EndMethod
	
EndType



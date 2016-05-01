
SuperStrict
Import "..\objects\Sprite.bmx"
Import "..\objects\weremEngine.bmx"

Type Hero Extends Sprite

	Field angle:Double = 0.0
	Field amplitude:Int = 10
	Field rgba:Int
	Field speed:Int = 2



	Field lastPositionX:Int = 0
	Field lastPositionY:Int = 0

	
	
	Global STATE_IDLE:Int = 0
	Global STATE_RUNNING:Int = 1
	Global STATE_WALKING:Int = 2
	
	Function createHero:Hero()
		Local returnValue:Hero = New Hero
		returnValue.init()
		
		Return returnValue		
	EndFunction
	
	Method init()
		Super.init()
		AutoMidHandle(True)
		debug = False
		SpriteSheet = LoadAnimImage("Media/PapersPleasecolor.png",64,64,0,36)
		MapInsert(animations, "walk", Animation.createAnimation(5, 15, 1000/10))
		MapInsert(animations, "idle", Animation.createAnimation(0, 2, 2000))
		MapInsert(animations, "run", Animation.createAnimation(17, 31, 1000/15))
		passToStateIdle()
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
				processStateIdle()
			Case Hero.STATE_RUNNING
				processStateRunning()
			Case Hero.STATE_WALKING
				processStateWalking()
		EndSelect
		Super.draw()
	EndMethod
	
	Method passToStateIdle()
		Print "pasando a idle"
		state = Hero.STATE_IDLE
		setAnimation("idle")
	EndMethod
	
	Method passToStateWalking()
		'Print "pasando a walking"
		If(state <> Hero.STATE_WALKING) Then 
			state = Hero.STATE_WALKING
			setAnimation("walk")
		EndIf
	EndMethod
	
	Method passToStateRunning()
		'Print "pasando a running"
		If(state <> Hero.STATE_RUNNING) Then 
			state = Hero.STATE_RUNNING
			setAnimation("run")
		EndIf
	EndMethod
	
	Method processCommon()
		Local pressed:Int = 0
		lastPositionX = x
		lastPositionY = y
		
		If KeyDown(KEY_LSHIFT) Or KeyDown(KEY_RSHIFT) Then
			speed = 5
		Else
			speed = 2
		EndIf
		
		If KeyDown(KEY_LEFT) Then
			x:- speed;
			flipped = -1 
			pressed = 1
		ElseIf KeyDown(KEY_RIGHT) Then
			x:+ speed
			flipped = 1
			pressed = 1
		EndIf
		
		If KeyDown(KEY_UP) Then
			y:- speed
			pressed = 1
		ElseIf KeyDown(KEY_DOWN) Then
			y:+ speed
			pressed = 1
		EndIf
	EndMethod
	
	Method processStateWalking()
		checkPositions()
		performAnimation()
	EndMethod
	
	Method processStateRunning()
		checkPositions()
		performAnimation()
	EndMethod
	
	Method checkPositions()
		If lastPositionX = x And lastPositionY = y Then
			passToStateIdle
		Else
			checkSpeed()
		EndIf
	EndMethod
	
	Method processStateIdle()
		If lastPositionX <> x Or lastPositionY <> y Then
			Print "###"
			Print lastPositionX
			Print x
			Print "###"
			checkSpeed()
		EndIf
		performAnimation()
	EndMethod
	
	Method checkSpeed()
		If speed = 5 Then
			passToStateRunning
		Else
			passToStateWalking
		EndIf
	EndMethod
	
EndType



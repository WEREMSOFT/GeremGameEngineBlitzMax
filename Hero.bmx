
SuperStrict
Import "objects\Sprite.bmx"
Import "objects\weremEngine.bmx"

Type Hero Extends Sprite
	Field My_Animation:TImage 
	Field angle:Double = 0.0
	Field amplitude:Int = 10
	Field rgba:Int
	Field Frame:Int = 0
	Field elapsedTime:Int = 0
	Field flipped:Int = 1
	Field lastPositionX:Int = 0
	Field lastPositionY:Int = 0
	Field imageOffsetX:Int = 8
	Field imageOffsetY:Int = 18
	
	
	Global STATE_IDLE:Int = 0
	Global STATE_RUNNING:Int = 1
	
	Function createHero:Hero()
		Local returnValue:Hero = New Hero
		returnValue.init()
		Print "creating animations"
		MapInsert(returnValue.animations, "walk", Animation.createAnimation(5, 15, 1000/10))
		MapInsert(returnValue.animations, "idle", Animation.createAnimation(1, 5, 1000/10))
		Print String(Animation(MapValueForKey(returnValue.animations,"idle")).endFrame)

		Return returnValue		
	EndFunction
	
	Method init()
		Super.init()
		AutoMidHandle(True)
		debug = False
		My_Animation = LoadAnimImage("Media/PapersPlease.png",64,64,0,36)
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
		Print("setting idle")
		setAnimation("idle")
		frame = 0
	EndMethod
	
	Method passToStateRunning()
		If(state <> Hero.STATE_RUNNING) Then 
			state = Hero.STATE_RUNNING
			setAnimation("walk")
			If Not currentAnimation Then
				Print "Es null"
			EndIf
			Print currentAnimation.startFrame
			frame = currentAnimation.startFrame
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
		If lastPositionX <> x Or lastPositionY <> y Then
			passToStateRunning
		Else
			passToStateIdle
		EndIf
	EndMethod
	
	Method processStateRunning()
		If(MilliSecs() - elapsedTime > currentAnimation.framerate)
			Frame:+1
			If Frame > currentAnimation.endFrame Then 
				Frame = currentAnimation.startFrame
			EndIf
			elapsedTime = MilliSecs()
		EndIf
		SetTransform 0, flipped, 1
		Local imageOffset:Int = 0
		DrawImage(My_Animation,x + imageOffsetX,y + imageOffsetY,Frame)
		SetTransform 0, 1, 1
	EndMethod
	
	Method processStateIdle()
		SetTransform 0, flipped, 1
		Local imageOffset:Int = 0
		If flipped < 0 Then
			'imageOffset = 64
		EndIf
		
		DrawImage(My_Animation,x + imageOffsetX,y + imageOffsetY,Frame)
		SetTransform 0, 1, 1
	EndMethod
	
EndType



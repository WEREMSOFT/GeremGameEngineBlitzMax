
SuperStrict
Import "objects\Sprite.bmx"
Import "objects\weremEngine.bmx"

Global My_Animation:TImage = LoadAnimImage("Media/PapersPlease.png",64,64,0,17)

Type Hero Extends Sprite
	Field frameRate:Int = 1000/15
	Field angle:Double = 0.0
	Field amplitude:Int = 10
	Field rgba:Int
	Field Frame:Int = 0
	Field elapsedTime:Int = 0
	Field flipped:Int = 1
	Field lastPositionX:Int = 0
	Field lastPositionY:Int = 0
	
	
	Global STATE_IDLE:Int = 0
	Global STATE_RUNNING:Int = 1
	
	Function createHero:Hero()
		Local returnValue:Hero = New Hero
		returnValue.init()
		Return returnValue		
	EndFunction
	
	Method init()
		Super.init()
		state = Hero.STATE_RUNNING
		w = 64
		h = 64
		'SetImageHandle(my_animation, 32, 64)
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
		frame = 0
	EndMethod
	
	Method passToStateRunning()
		If(state <> Hero.STATE_RUNNING) Then 
			state = Hero.STATE_RUNNING
			frame = 1
		EndIf
	EndMethod
	
	Method processCommon()
		Local pressed:Int = 0
		lastPositionX = x
		lastPositionY = y
		If KeyDown(KEY_LEFT) Then
			x:- 5;
			flipped = -1 
			pressed = 1
		ElseIf KeyDown(KEY_RIGHT) Then
			x:+ 5
			flipped = 1
			pressed = 1
		EndIf
		
		If KeyDown(KEY_UP) Then
			y:- 5;
			pressed = 1
		ElseIf KeyDown(KEY_DOWN) Then
			y:+ 5
			pressed = 1
		EndIf
		If lastPositionX <> x Or lastPositionY <> y Then
			passToStateRunning
		Else
			passToStateIdle
		EndIf
	EndMethod
	
	Method processStateRunning()
		If(MilliSecs() - elapsedTime > framerate)
			Frame:+1
			If Frame > 16 Then 
				Frame=1 
			EndIf
			elapsedTime = MilliSecs()
		EndIf
		SetTransform 0, flipped, 1
		Local imageOffset:Int = 0
		If flipped < 0 Then
			imageOffset = 64
		EndIf
		DrawImage(My_Animation,x + imageOffset,y,Frame)
		SetTransform 0, 1, 1
	EndMethod
	
	Method processStateIdle()
		SetTransform 0, flipped, 1
		Local imageOffset:Int = 0
		If flipped < 0 Then
			imageOffset = 64
		EndIf
		
		DrawImage(My_Animation,x + imageOffset,y,0)
		SetTransform 0, 1, 1
	EndMethod
	
EndType



SuperStrict



Import "gameobject.bmx"
Import "Sprite.bmx"
Include "commandConsole.bmx"

Rem
This Class is the main engine. This do everything 
EndRem

Global WE:WeremEngine = New WeremEngine
WE.init()

Type WeremEngine Extends GameObject
	Field FPS:Int = 30
	Field ticks:Int = 1000/FPS
	Field lastUpdate:Int = MilliSecs()
	Field lastDraw:Int = MilliSecs()
	Field elapsedTime:Float = 0;
	Field console:CommandConsole
	
	Method init()
		console = CommandConsole.createConsole()
		addChild(console)
	EndMethod
	
	Method update()
		PollEvent() 
		elapsedTime = MilliSecs() - lastUpdate
		Super.update()
		lastUpdate = MilliSecs()
	EndMethod

	Method draw()
		If(ticks <= (MilliSecs() - lastDraw)) Then
			Cls
			Super.preDraw()
			Super.draw()
			Super.postDraw()
			Flip
			lastDraw = MilliSecs()
		EndIf		
	EndMethod
	
	Method setFPS(pFPS:Int)
		FPS = pFPS
		ticks = 1000 / FPS
	EndMethod
EndType


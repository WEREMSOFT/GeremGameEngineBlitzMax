SuperStrict

Import "gameobject.bmx"

Rem
This Class is the main engine. This do everything 
EndRem
Global WE:WeremEngine = New WeremEngine

Type WeremEngine Extends GameObject
	Field FPS:Int = 30
	Field ticks:Int = 1000/FPS
	Field lastUpdate:Int = MilliSecs()
	Field lastDraw:Int = MilliSecs()
	Field elapsedTime:Float = 0;
	Method update()
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


SuperStrict
Import "gameobject.bmx"
Import "WeremEngine.bmx"

Type DebugText Extends GameObject

	Field textToDebug:String = "--------"
	Field textPosition:Int =  TextHeight(textToDebug)
	Global lastUpdate:Int = MilliSecs() 
	Method draw()
		Local elapsedTime:Int = (MilliSecs() - lastUpdate)
		Local FPS:Int = 1000
		If elapsedTime <> 0 Then
			FPS = 1000 / elapsedTime
		EndIf
		SetColor(255, 255, 255) 
		DrawText("FPS: " + String.fromInt(FPS), 0, 0)
		DrawText("MEM: " +  GCMemAlloced(), 0, textPosition)
		DrawText("Update: " +  WE.elapsedTime, 0, textPosition * 2)
		Super.draw()
		lastUpdate = MilliSecs()
	EndMethod
	
	Method update()
		Super.update
	EndMethod
EndType

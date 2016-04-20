SuperStrict
Import "gameobject.bmx"
Import "WeremEngine.bmx"

Type DebugText Extends GameObject

	Field textToDebug:String = "--------"
	Field textPosition:Int =  TextHeight(textToDebug)
	Global lastUpdate:Int = MilliSecs() 
	Method postdraw()
		Super.postDraw()
		Local elapsedTime:Int = (MilliSecs() - lastUpdate)
		Local FPS:Int = 1000
		If elapsedTime <> 0 Then
			FPS = 1000 / elapsedTime
		EndIf
		SetColor(255, 255, 255) 
		DrawText("FPS: " + String.fromInt(FPS), 0, 0)
		DrawText("Elapsed Time: " +  String.fromInt(elapsedTime), 0, textPosition)
		DrawText("MEM: " +  GCMemAlloced(), 0, textPosition * 2)
		DrawText("Update: " +  WE.elapsedTime, 0, textPosition * 3)
		lastUpdate = MilliSecs()
	EndMethod

EndType

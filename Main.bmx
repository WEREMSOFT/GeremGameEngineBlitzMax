SuperStrict

Import "objects\WeremEngine.bmx"

Import "Level1.bmx"
Import "LevelHandler.bmx"


SetGraphicsDriver GLMax2DDriver()



Graphics 640, 480

WE.setFPS(30);


SetClsColor(0, 0, 0)

Local lh:levelHandler = New LevelHandler

lh.init()

While Not KeyHit(KEY_ESCAPE)
 	WE.update
	WE.draw

	If EventID() = EVENT_WINDOWCLOSE Then
		End
	EndIf
EndWhile


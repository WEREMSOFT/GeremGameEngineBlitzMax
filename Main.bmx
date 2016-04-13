SuperStrict
Import "objects\WeremEngine.bmx"
Import "Intro.bmx"
Import "objects\DebugText.bmx"

SetGraphicsDriver GLMax2DDriver()



Graphics 640, 480

WE.setFPS(30);


SetClsColor(0, 100, 100)
Local myIntro:Intro = New Intro
myIntro.init()

WE.addChild(myIntro)

Local myDebugText:DebugText = New DebugText
WE.addChild(myDebugText)

While Not KeyHit( KEY_ESCAPE )

	WE.update
	WE.preDraw
	WE.draw
	WE.postDraw
EndWhile


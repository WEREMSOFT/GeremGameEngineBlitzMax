SuperStrict 

Import "objects\Level.bmx"
Import "objects\Sprite.bmx"
Import "Hero.bmx"

Type LevelEditor Extends Level
	Field backImage:TImage = LoadImage("media/tile.png")
	Field imgX:Int = 0
	Field h:Hero
	Field sprite1:Sprite
	Field platforms:TList = CreateList();
	Field currentDraw:Sprite;

	
	Const STATE_IDLE:Int = 10;
	Const STATE_DRAWING:Int = 20;
 	
	Method init()
		Super.init()
		passToStateIdle()

	EndMethod 

	Method preDraw()
		TileImage backImage, 0, 0
		Super.predraw()
	EndMethod
	
	Method draw()
		Select state
			Case STATE_IDLE
				processStateIdle()
			Case STATE_DRAWING
				processStateDrawing()
		EndSelect 
		Super.draw()
	EndMethod
	
	Method passToStateIdle()
		state = STATE_IDLE
	EndMethod
	
	Method processStateIdle()
		If MouseHit(1) Then
			Local tempX:Float = Floor(MouseX()/16) * 16
			Local tempY:Float = Floor(MouseY()/16) * 16
			currentDraw = Sprite.createSprite(tempX, tempY)
			currentDraw.alpha = 0.5
			addChild(currentDraw)
			ListAddLast(platforms, currentDraw)
			passToStateDrawing()
		EndIf
	EndMethod
	
	Method passToStateDrawing()
		state = STATE_DRAWING
	EndMethod
	
	Method processStateDrawing()
		Local tempX:Float = Floor(MouseX()/16) * 16 - currentDraw.x
		Local tempY:Float = Floor(MouseY()/16) * 16 - currentDraw.y
		currentDraw.w = tempX
		currentDraw.h = tempY
		If MouseHit(1)
			passToStateIdle()
		EndIf
	EndMethod
EndType



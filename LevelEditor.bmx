SuperStrict 

Import "objects\Level.bmx"
Import "objects\Sprite.bmx"
Import "Hero.bmx"

Type LevelEditor Extends Level
	Field backImage:TImage = LoadImage("media/tile.png")
	Field imgX:Int = 0
	Field h:Hero
	Field sprite1:Sprite
	Field platforms:TList = CreateList()
	Field currentDraw:Sprite
	Global instance:LevelEditor
	
	Const STATE_IDLE:Int = 10;
	Const STATE_DRAWING:Int = 20;
 	
	Method init()
		Super.init()
		passToStateIdle()
		WE.console.commandEnteredCallback = Self.processCommands
		instance = Self
		
		h = Hero.createHero()
		h.init()
		h.x = 100
		h.y = 100
		
		addChild(h)	
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
		
		For Local rect:Sprite = EachIn Self.platforms
			If(h.Overlap(rect))
				rect.collidesAB(h)
				SetColor(255, 0, 0)
				Local text:String = "Collided!!"
				DrawRect(200, 0, TextWidth(text), TextHeight(text))
				SetColor(255, 255, 255)
				DrawText(text, 200, 0)	
			EndIf
		Next
		
		 
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
			currentDraw.alpha = 0.75
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
	
	Function processCommands:Int(pCommand:String)
		Local mainCommands:String[] = pCommand.split(" ")
		If(mainCommands) Then
			we.console.printf(mainCommands[0])
		Else
			WE.console.printf("no hay comandos")
		EndIf 
		
		
		Select mainCommands[0]
			Case "SAVE"
				If maincommands.length = 1 Then
					WE.console.printf("parameter missing") 
				Else
					Local parameter:String = maincommands[1]
					Local file:TStream = WriteFile(parameter + ".lvl")
					
					For Local rect:Sprite = EachIn instance.platforms
						Local line:String = "" + rect.x + "," + rect.y + "," + rect.w + "," + rect.h
						WE.console.printf("saving " + line + "...")
						WriteLine file, line
					Next
	
					CloseFile file
					WE.console.printf("" + instance.platforms.count() + " OBJECTS SAVED!!!")
				EndIf
			Case "LOAD"
				If maincommands.length = 1 Then
					WE.console.printf("parameter missing") 
				Else
					Local parameter:String = maincommands[1]
					Local file:TStream = ReadFile(parameter + ".lvl")					
					
					Local line:String
					line = ReadLine$(file)
					While line
						Local rec:String[] = line.split(",")
						Local loadedObject:Sprite = Sprite.createSprite(Int(rec[0]), Int(rec[1]), Int(rec[2]), Int(rec[3]))
						loadedObject.alpha = 0.75
						instance.addChild(loadedObject)
						ListAddLast(instance.platforms, loadedObject)
						line = ReadLine$(file)
					EndWhile
	
					CloseFile file
					WE.console.printf("" + instance.platforms.count() + " OBJECTS LOADED!!!")
					Return True
				EndIf
			Case "LOADBG"
				If maincommands.length = 1 Then
					WE.console.printf("parameter missing") 
				Else
					Local parameter:String = maincommands[1]
					instance.backImage = LoadImage(parameter)
				EndIf
				Return True
			Case "SCREENSHOT"
				If maincommands.length = 1 Then
					WE.console.printf("parameter missing") 
				Else
					Local parameter:String = maincommands[1]
					Local gfxGrab:TPixmap
					gfxGrab = GrabPixmap(0,0, 640, 480)
					SavePixmapPNG(gfxGrab, parameter + ".png", 9)
				EndIf
				Return True

			Case "RESET"
				ClearList(instance.childs)
				ClearList(instance.platforms)
				instance.addchild(instance.h)
			Default
				Return False
		EndSelect
		
		Return True
	EndFunction 
EndType



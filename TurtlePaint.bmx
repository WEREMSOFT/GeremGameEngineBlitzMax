SuperStrict 

Import "objects\Level.bmx"
Import "objects\Sprite.bmx"
Import "sprites\turtle.bmx"
Import "sprites\hero.bmx"

Type TurtlePaint Extends Level
	Field backImage:TImage = LoadImage("media/tile.png")
	Field imgX:Int = 0
	Field t:Turtle
	Global instance:TurtlePaint
	Field points:TList =  CreateList()
	
	Method init()
		passToStateRun()
		WE.console.commandEnteredCallback = Self.processCommands
		instance = Self
		Print "test"
		t = Turtle.createTurtle()
		t.x = 320
		t.y = 240
		
		addPoint()
		addChild(t)
		
	EndMethod 
	
	Method addPoint()
	
		Local point:GameObject = New GameObject
		point.x = t.x
		point.y = t.y
		
		ListAddLast(points, point)
	EndMethod
	
	Function processCommands:Int(pCommand:String)
		Local mainCommands:String[] = pCommand.split(" ")
		If(mainCommands) Then
			'do nothing
		Else
			WE.console.printf("no hay comandos")
		EndIf 
		
		
		Select mainCommands[0]
			Case "FW", "FORWARD", "AD", "ADELANTE"
				If maincommands.length = 1 Then
					WE.console.printf("parameter missing") 
				Else
					Local parameter:Int = maincommands[1].ToInt()
					instance.t.y:- parameter * Cos(instance.t.angle)
					instance.t.x:+ parameter * Sin(instance.t.angle)
					instance.addPoint()
					Return True
				EndIf
			Case "BK", "BACK", "AT", "ATRAS"
				If maincommands.length = 1 Then
					WE.console.printf("parameter missing") 
				Else
					Local parameter:Int = maincommands[1].ToInt()
					instance.t.y:+ parameter * Cos(instance.t.angle)
					instance.t.x:- parameter * Sin(instance.t.angle)
					instance.addPoint()
					Return True
				EndIf
			Case "RT", "RIGHT", "DE", "DERECHA"
				If maincommands.length = 1 Then
					WE.console.printf("parameter missing") 
				Else
					Local parameter:Int = maincommands[1].ToInt()
					instance.t.angle:+parameter
					Return True
				EndIf
			Case "REPITE", "RE", "REPEAT"
				If maincommands.length = 1 Then
					WE.console.printf("parameter missing") 
				Else
					Local parameter:Int = maincommands[1].ToInt()
					Local secondaryCommands:String[] = pCommand.split(",")
					For Local J:Int = 1 To parameter
						For Local I:Int = 1 To secondaryCommands.length - 1
							processCommands(secondaryCommands[I].Trim())
						Next
					Next
					Return True
				EndIf
			
			Case "NINJA"
				instance.t.setAnimation("ninja")
				Return True
			Case "NORMAL"
				instance.t.setAnimation("idle")
				Return True
			Case "CLEARSCREEN"
				instance.points = CreateList()
				instance.t.x = 320
				instance.t.y = 240
				instance.t.angle = 0
				instance.addPoint()
				Return True
			Case "HELP", "?"
				WE.console.printf("LEFT [N]: turn left [N] angles, RIGHT [N]: turn right [N] angles, FORWARD [N]: move forward N pixels")
				Return true
		EndSelect
	EndFunction
	

	Method onAddedToparent(pParent:GameObject)
		WE.console.showSystemDebugInfo = False
		WE.console.y = 300
		WE.console.passToStateActive()
	EndMethod
	
	Method preDraw()
		TileImage backImage, 0, 0
		Local lastPoint:GameObject
		For Local point:GameObject = EachIn Points
			If lastPoint Then
				DrawLine(lastPoint.x, lastPoint.y, point.x, point.y)
			EndIf
			lastPoint = point
		Next 
		
		Super.predraw()
	EndMethod
	
	
EndType
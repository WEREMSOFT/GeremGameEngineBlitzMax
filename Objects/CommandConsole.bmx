




Type CommandConsole Extends Sprite
	Field commands:TList = CreateList()
	Const STATE_IDLE:Int = 10
	Const STATE_ACTIVE:Int = 20
	Field commandEnteredCallback:Int()
	Field visible:Int = False
	Field currentCommand:String = ""
	Field textX:Int = 0
	Field lastupdate:Int = 0
	
	Function createConsole:CommandConsole()
		Local returnValue:CommandConsole = New CommandConsole
		returnValue.w = 640
		returnValue.h = 480
		returnValue.alpha = 0.9
		returnValue.passToStateIdle()
		ReturnValue.debug = False
		Return returnValue
	EndFunction
	
	Method update()
		Super.update()
		Select state
			Case STATE_IDLE
				processStateIdle()
			Case STATE_ACTIVE
				processStateActive()
		EndSelect
	End Method
	
	Method passtoStateActive()
		state = STATE_ACTIVE
		visible = True
		FlushKeys()
	EndMethod
	
	Method passToStateIdle()
		state = STATE_IDLE
		visible = False
	EndMethod
	
	Method processStateIdle()
		If(KeyHit(KEY_TILDE))
			passToStateActive()
		EndIf
	EndMethod
	
	Method processStateActive()
		If(KeyHit(KEY_TILDE))
			passToStateIdle()
		EndIf
		
		Local c:Int = GetChar()

		If c Then
			If c = KEY_ENTER Then
				ListAddLast(commands, ">" + currentCommand)
				processCommand(currentCommand)
				currentCommand = ""
			Else
				currentCommand:+ Upper(Chr(c))	
			EndIf
		EndIf
	EndMethod
	
	Method printf(strString:String)
		ListAddLast(commands, strString)
	EndMethod
		
	Method processCommand(pCommand:String)
		Select pCommand
			Case "CLEAR"
				ClearList(commands)
				printf("Ok")
			Case "QUIT"
				Local evt:TEvent = CreateEvent(EVENT_WINDOWCLOSE)
				EmitEvent(evt)
			Case "MEM"
				printf("Allocated memory: " + GCMemAlloced())
			Case "FPS"
				printf("Frames per seccond is set to " + WE.FPS)
			Default
				printf("Command not found") 
		EndSelect
	EndMethod
	
	Method postdraw()
		Super.postdraw()
		If visible Then
			debugDraw()
			SetColor(150, 150, 150)
			textX = 0
			
			showSystemInfo()
			
			For Local cmd:String = EachIn commands
				DrawText(cmd, 0, textX)
				newLine()
			Next
			DrawText(">" + currentCommand, 0, textX)
		EndIf
	EndMethod
	
	Method newLine()
		textX:+TextHeight("test")
	EndMethod
	
	Method showSystemInfo()
		Local elapsedTime:Int = (MilliSecs() - lastUpdate)
		Local FPS:Int = 1000
		If elapsedTime <> 0 Then
			FPS = 1000 / elapsedTime
		EndIf
		DrawText("FPS: " + String.fromInt(FPS), 0, textX)
		newLine()
		DrawText("Elapsed Time: " +  String.fromInt(elapsedTime), 0, textX)
		newLine()
		DrawText("MEM: " +  GCMemAlloced(), 0, textX)
		newLine()
		lastUpdate = MilliSecs()
	EndMethod
EndType

SuperStrict
Import "gameobject.bmx"

Type Level Extends GameObject 
	Field alpha:Float = 1
	Const STATE_FADE_FROM_BLACK:Int = 0
	Const STATE_FADE_TO_BLACK:Int = 1
	Const STATE_RUN:Int = 2
	
	
	
	
	
	Method init()
		passToStateFadeFromBlack()
	EndMethod
	
	Method draw()
		Select State
			Case STATE_FADE_FROM_BLACK
				processStateFadeFromBlack()
			Case STATE_RUN
				processStateRun()
			Case STATE_FADE_TO_BLACK
				processStateFadeToBlack()
		EndSelect
		Super.draw()
	EndMethod
	
	Method update()
		Super.update
	EndMethod
	
	Method passToStateFadeFromBlack()
		state = STATE_FADE_FROM_BLACK;
		alpha = 0
	EndMethod
	
	Method passToStateFadeToBlack()
		state = STATE_FADE_FROM_BLACK;
		alpha = 0
	EndMethod
	
	Method processStateRun()
	EndMethod
	
	Method passToStateRun()
		state = STATE_RUN
	EndMethod 
	
	Method processStateFadeToBlack()
		alpha:-0.1
		SetBlend ALPHABLEND
		SetAlpha alpha
		If alpha <= 0 Then
			passToStateRun()
		EndIf
	EndMethod
	
	Method processStateFadeFromBlack()
		DrawText(String.fromFloat(alpha), 100, 100)
		alpha:+0.01
		SetBlend ALPHABLEND
		SetAlpha alpha
		If alpha >= 1 Then
			passToStateRun()
		EndIf
	EndMethod
EndType

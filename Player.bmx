SuperStrict
Import "objects\gameobject.bmx"
Import "objects\weremEngine.bmx"

Type Player Extends GameObject
	Field angle:Double = 0.0
	Field amplitude:Int = 10
	Field rgba:Int
	Method postDraw()
		Super.postDraw
		Local temp:TPixmap
		temp = GrabPixmap(MouseX(), MouseY(), 1, 1)
		rgba = temp.ReadPixel(0, 0)
		
	EndMethod
	
	Method draw()
		
	
		
	
		angle:+10
		'x = MouseX() + Sin(angle) * amplitude
		'y = MouseY() + Cos(angle) * amplitude

		If KeyDown(KEY_LEFT) Then
			x:- 10;
		ElseIf KeyDown(KEY_RIGHT) Then
			x:+ 10
		EndIf
		
		If KeyDown(KEY_UP) Then
			y:- 10;
		ElseIf KeyDown(KEY_DOWN) Then
			y:+ 10
		EndIf
		
		
		 
		SetColor(RGBA_GetRed(rgba), RGBA_GetGreen(rgba), RGBA_GetBlue(rgba))
		DrawRect(x, y, 50, 100)
		Super.draw()
	EndMethod
	
	Method update()
		Super.update
	EndMethod
EndType

Function RGBA_GetRed:Int(rgba:Int)
	
	Return((rgba Shr 16) & $FF)
	
End Function
              
Function RGBA_GetGreen:Int(rgba:Int)
	
	Return((rgba Shr 8) & $FF)
	
End Function
	
Function RGBA_GetBlue:Int(rgba:Int)
	
	Return(rgba & $FF)
	
End Function
	
Function RGBA_GetAlpha:Int(rgba:Int)
	
	Return((rgba:Int Shr 24) & $FF)
	
End Function
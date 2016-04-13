SuperStrict
Import "objects\gameobject.bmx"
Import "objects\weremEngine.bmx"

Type DancingText Extends GameObject

	Field introText:String = "WeremSoft Software"
	Field tWidth:Int = 320 - TextWidth(introText)/2;
	Field tHeight:Int = TextHeight(introText);
	Field tAngle:Float = 0;
	Field tPhase:Float = 0.1;


	
	Method Draw()
		Super.draw()
		tPhase:+3

		
		Local i:Int = 0;

		For i = 0 To 12
			tAngle = Sin(tPhase - 3 * (12 - i)) * 150;
			SetColor 0 + (i * 20), 0, 10 + (i * 20)
			DrawRect x, y + 200 + tAngle, 640,tHeight
		Next
		
		tAngle = Sin(tPhase) * 150;
 

		SetColor 0,0,255
		DrawRect x, y + 200 + tAngle, 640,tHeight
		SetColor 255,255,255
		DrawText introText, tWidth, y + 200 + tAngle
		
		SetOrigin 0,0
		SetHandle 0,0	

		
		showHitSpaceKeyText()
	EndMethod
	
	Method setIntroText(pIntroText:String)
		introText = pIntroText;
		tWidth = TextWidth(introText);
		tHeight = TextHeight(introText);
	EndMethod
	
	Method showHitSpaceKeyText()
		Local strHitSpaceToContinue:String = "Press [Space]"
		SetColor 200,200,200
		DrawText strHitSpaceToContinue,tWidth, y + 400
		
	EndMethod
EndType


SuperStrict 

Import "objects\Level.bmx"
Import "Player.bmx"
Import "BackgroundTile.bmx"
Import "DancingText.bmx"

Type Intro Extends Level
	Method init()
		Super.init()
		Local dt:DancingText = New DancingText
		Local myBG:BackgroundTile = New BackgroundTile

		addChild(myBG)
		addChild(dt)
	EndMethod
	
	Method update()
		Super.update()
		If KeyHit(key_space) Then
			passToStateFadeToBlack()
		EndIf
	EndMethod
	
	
EndType

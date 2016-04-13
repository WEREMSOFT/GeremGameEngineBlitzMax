SuperStrict 

Import "objects\Level.bmx"
Import "Player.bmx"
Import "BackgroundTile.bmx"
Import "DancingText.bmx"

Type Intro Extends Level
	Field myPlayer:Player
	Method init()
		Super.init()
		myPlayer = New Player
		myPlayer.x = 100
		myPlayer.y = 100
		
		Local dt:DancingText = New DancingText
		
		
		
		
		Local myBG:BackgroundTile = New BackgroundTile
		
		
		addChild(myBG)
		addChild(myPlayer)
		addChild(dt)
	EndMethod
	
	Method update()
		Super.update()
		If KeyHit(key_space) Then
			removeChild(myPlayer)
		EndIf
	EndMethod
	
	
EndType

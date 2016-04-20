SuperStrict
Import "objects\gameobject.bmx"
Import "objects\weremEngine.bmx"
Import "Intro.bmx"
Import "Level1.bmx"
Import "objects\DebugText.bmx"

Type LevelHandler Extends GameObject 
	Field myIntro:Intro
	Field myLevel1:Level1 
	
	
	Method init()
	
		myIntro = New Intro
		myLevel1 = New Level1
		myIntro.init()
		myLevel1.init()
		
		myIntro.targetLevelOnFinish = myLevel1
		
		WE.addChild(myIntro)
		
		Local myDebugText:DebugText = New DebugText
		WE.addChild(myDebugText)

	EndMethod
	
	
EndType
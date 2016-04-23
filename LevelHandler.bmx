SuperStrict
Import "objects\gameobject.bmx"
Import "objects\weremEngine.bmx"
Import "Intro.bmx"
Import "Level1.bmx"
Import "LevelEditor.bmx"
Import "objects\DebugText.bmx"

Type LevelHandler Extends GameObject 
	Field myIntro:Intro
	Field myLevel1:Level1 
	Field myLevelEditor:LevelEditor 
	
	Method init()
	
		myIntro = New Intro
		myLevel1 = New Level1
		myLevelEditor = New LevelEditor
		myIntro.init()
		myLevel1.init()
		myLevelEditor.init()
		
		myIntro.targetLevelOnFinish = myLevelEditor
		
		WE.addChild(myLevelEditor)
		
		'Local myDebugText:DebugText = New DebugText
		'WE.addChild(myDebugText)

	EndMethod
	
	
EndType
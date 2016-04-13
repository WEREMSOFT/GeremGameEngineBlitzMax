SuperStrict
Import "objects\gameobject.bmx"
Import "objects\weremEngine.bmx"



Type BackgroundTile Extends GameObject
	Field backImage:TImage = LoadImage("media/fl.png")
	Field backX:Int = 0
	Field backY:Int = 0
	Field tim:Float = 0.0

	Method draw()
		tim:+5
		backX:+15*Sin(tim)
  		backY:+5
		SetScale 1,1
  		TileImage backImage,backx,backy
	EndMethod
	
EndType

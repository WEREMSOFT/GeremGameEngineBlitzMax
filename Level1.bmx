SuperStrict 

Import "objects\Level.bmx"
Import "objects\Sprite.bmx"
Import "Hero.bmx"




Type Level1 Extends Level
	Field backImage:TImage = LoadImage("media/tile.png")
	Field imgX:Int = 0
	Field h:Hero
	Field sprite1:Sprite

	Method init()
		Super.init()
		h = Hero.createHero()
		h.init()
		h.x = 100
		h.y = 100		
		
		sprite1:Sprite = Sprite.CreateSprite()
		sprite1.x = 100
		sprite1.y = 200

		sprite1.w = 10
		sprite1.h = 10
		addChild(h)
		addChild(sprite1)
	
	EndMethod
	
	Method update()
		Super.update()	
	EndMethod
	
	Method preDraw()
		TileImage backImage, x, 0
		Super.predraw()
	EndMethod
	
	Method draw()
		x:+1
		
		If(h.Overlap(sprite1))
			sprite1.collidesBA(h)
			SetColor(255, 0, 0)
			Local text:String = "Collided!!"
			DrawRect(200, 0, TextWidth(text), TextHeight(text))
			SetColor(255, 255, 255)
			DrawText(text, 200, 0)	
		EndIf
		Super.draw()
	EndMethod
EndType


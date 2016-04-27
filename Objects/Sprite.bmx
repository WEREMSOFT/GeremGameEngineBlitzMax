SuperStrict
Import "gameobject.bmx"
Import "animation.bmx"

Type Sprite Extends GameObject
	Field w:Int
	Field h:Int
	Field colorR:Int
	Field colorG:Int
	Field colorB:Int
	Field objectToFollow:GameObject
	Field followOffsetX:Int = 0
	Field followOffsetY:Int = 0
	Field alpha:Float = 1.0
	Field debug:Int = True
	Field animations:TMap
	Field currentAnimation:Animation
	Field elapsedTime:Int = 0
	Field Frame:Int = 0
	Field flipped:Int = 1
	Field SpriteSheet:TImage
	Field imageOffsetX:Int = 8
	Field imageOffsetY:Int = 18 
	
	Function CreateSprite:Sprite(pX:Int = 0, pY:Int = 0, pW:Int = 0, pH:Int = 0)
		Local ReturnValue:Sprite = New Sprite
		returnValue.init()
		returnValue.x = pX
		returnValue.w = pW
		returnValue.y = pY
		returnValue.h = pH
		
		Return returnValue
	EndFunction
	
	Function RectsOverlap:Int(r1:Sprite, r2:Sprite)
		Return ((r1.x + r1.w > r2.x) And (r1.y + r1.h > r2.y) And (r1.x < r2.x + r2.w) And (r1.y < r2.y + r2.h))
	End Function
	
	Method setAnimation(animationName:String)
		currentAnimation = Animation(MapValueForKey(animations,animationName))
		frame = currentAnimation.startFrame
	EndMethod
	
	
	Method Overlap:Int(otherRect:Sprite)
		Return RectsOverlap(Self, otherRect)
	End Method
	
	Method init()
		w = 100
		h = 100
		colorR = Rand(0, 255)
		colorG = Rand(0, 255)
		colorB = Rand(0, 255)
		animations = CreateMap()
	EndMethod
	
	Method update()
		Super.update()
		If(objectToFollow)
			x = objectToFollow.x + followOffsetX
			y = objectToFollow.y + followOffsetY
		EndIf
	EndMethod
	
	Method debugDraw()
		Local blendMode:Int = GetBlend()
		SetBlend ALPHABLEND
		Local r:Int, g:Int, b:Int
		GetColor(r, g, b)
		SetColor(colorR, colorG, colorB)
		SetAlpha(alpha) 
		DrawRect(x, y, w, h)
		SetAlpha(1)
		SetColor(r, g, b)
		SetBlend(blendMode)
	EndMethod
	
	Method predraw()
		Super.predraw()
		If debug Then
			debugDraw()
		EndIf
	EndMethod
	
	Method follow(obj:GameObject, offsetX:Int = 0, offsetY:Int = 0)
		objectToFollow = obj
		followOffsetX = offsetX
		followOffsetY = offsetY
	EndMethod
	
	Method collidesAB(sp:Sprite)
		collisionReaction(Self, sp)
	EndMethod

	Method collidesBA(sp:Sprite)
		collisionReaction(sp, Self)
	EndMethod
	
	Method performAnimation()
		If(MilliSecs() - elapsedTime > currentAnimation.framerate)
			Frame:+1
			If Frame > currentAnimation.endFrame Then 
				Frame = currentAnimation.startFrame
			EndIf	
			elapsedTime = MilliSecs()
		EndIf	
		SetTransform 0, flipped, 1
		Local imageOffset:Int = 0
		DrawImage(SpriteSheet,x + imageOffsetX,y + imageOffsetY,Frame)
		SetTransform 0, 1, 1
	EndMethod
	
	Function collisionReaction(rect1:Sprite, rect2:Sprite)
		'process X axis
		Local containsX:Int = False
		Local containsY:Int = False
		Local xPenetration:Int = 0;
		Local yPenetration:Int = 0;
		Local A:Int = rect1.x
		Local B:Int = rect1.x + rect1.w
		Local C:Int = rect2.x
		Local D:Int = rect2.x + rect2.w
		
		If A > C And B < C Then
			containsX = True
		EndIf
		
		If (B - C >= 0 And D - A >=0 ) Then
			xPenetration = Max(A, C) - Min(B, D)
			If A < C Then
				xPenetration:*(-1)
			EndIf
		EndIf
		
		A = rect1.y
		B = rect1.y + rect1.h
		C = rect2.y
		D = rect2.y + rect2.h
		
		If A > C And B < C Then
			containsY = True
		EndIf
		
		If B - C >= 0 And D - A >=0  Then
			yPenetration = Max(A, C) - Min(B, D)
			If A < C Then
				yPenetration:*(-1)
			EndIf
		EndIf
		
		If containsX Then
			rect2.y:+yPenetration
		ElseIf containsY Then
			rect2.x:+xPenetration
		ElseIf  Abs(yPenetration) < Abs(xPenetration) Then
			rect2.y:+yPenetration
		Else
			rect2.x:+xPenetration	
		EndIf
		
	EndFunction

	
EndType






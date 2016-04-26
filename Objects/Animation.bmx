SuperStrict

Type Animation
	Field startFrame:Int = 0
	Field endFrame:Int = 0
	Field frameRate:Float = 1000/10
	Function createAnimation:Animation(pSF:Int, pEF:Int, pFR:Float)
		Local returnValue:Animation = New Animation
		returnValue.StartFrame = pSF
		returnValue.EndFrame = pEF
		returnValue.frameRate = pFR
		Return returnValue
	EndFunction
EndType

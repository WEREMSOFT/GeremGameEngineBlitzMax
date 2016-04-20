SuperStrict

Type EventDispatcher
	Field eventHandlers:TMap = CreateMap() 
	Method addEventListener(eventName:String, eventHandler())
		If Not MapContains(eventHandlers, eventName) Then
			MapInsert(eventHandlers, eventName, New TList)
		EndIf
		
		Local cadorna:Array
		
		Local handlersList:TList = TList(MapValueForKey(eventHandlers, eventName))
		
		ListAddLast(handlersList, {})
		
	EndMethod
EndType

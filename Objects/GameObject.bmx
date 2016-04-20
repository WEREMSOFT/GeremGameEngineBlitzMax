SuperStrict


Type GameObject
	Field childs:TList = CreateList()
	Field x:Int = 0
	Field y:Int = 0
	Field state:Int = 0
	
	Method init()
	EndMethod
	
	Method addChild(pChild:GameObject)
		ListAddLast(childs, pChild)
	EndMethod
	
	Method removeChild(pChild:GAmeObject)
		ListRemove(childs, pChild)
	EndMethod
	
	Method update()
		For Local child:GameObject = EachIn childs
			child.update
		Next
	EndMethod
	
	Method preDraw()
		For Local child:GameObject = EachIn childs
			child.preDraw
		Next
	EndMethod
	
	Method draw()
		For Local child:GameObject = EachIn childs
			child.draw
		Next
	EndMethod
	
	Method postDraw()
		For Local child:GameObject = EachIn childs
			child.postDraw
		Next
	EndMethod

EndType


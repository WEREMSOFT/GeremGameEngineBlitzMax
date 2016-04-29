SuperStrict


Type GameObject
	Field childs:TList = CreateList()
	Field x:Int = 0
	Field y:Int = 0
	Field z:Int = 0
	Field state:Int = 0
	Field parent:GameObject
	
	
	Method init()
	EndMethod
	
	Method addChild(pChild:GameObject)
		ListAddLast(childs, pChild)
		childs.sort(False, compareChilds)
		pChild.parent = Self
		onChildAdded(pChild)
		pChild.onAddedToParent(Self)
	EndMethod
	
	Method removeChild(pChild:GAmeObject)
		ListRemove(childs, pChild)
		pChild.parent = Null 
	EndMethod
	
	Method update()
		For Local child:GameObject = EachIn childs
			child.update
		Next
	EndMethod
	
	Method onChildAdded(pChild:GameObject)
		Print "child added!"
	EndMethod
	
	Method onAddedToParent(pParent:GameObject)
		Print "addedToParent!!"
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

	Function compareChilds:Int(o1:Object, o2:Object)
		If GameObject(o1).z > GameObject(o2).z Then
			Return False
		Else
			Return True
		EndIf
	EndFunction

EndType




-- Game contents --
module GameContents(takeSecond, changeMoveState, flatten, removeItem, removeContent, checkRoom, roomItem, itemDesc, roomObject, objectDesc, eventDesc, getMovesText, getMoves, changeBool, checkEvent, newTextList, contentList, descriptionList, textList, eventDescriptionList, moveList)
where

import Texts

---- Functions ----

takeSecond [(a,b,c,d)] = b

changeMoveState loc moveState = flatten(changeBool loc moveState):filteredList where
  filteredList = filterList (reverseChangeBool(flatten(changeBool loc moveState))) moveState
  filterList state moveState = filter (/=state) moveState
  reverseChangeBool (a,b,c,d) = (a,b,c, not d)

flatten [a] = a

removeItem input items = filter (/=input) items
removeContent input content = filter (\(_,b,c,_) -> b == 2 && c == input) content

checkRoom loc input list = filter (\(a,_,c,_) -> a == loc && c == input) list

roomItem loc = [c | (a, b, c, d) <- contentList, loc == a && b == 1 && d == True]

roomObject loc = [c | (a, b, c, d) <- contentList, loc == a && b == 2 && d == True]

itemDesc loc item = [last c | (a,b,c) <- descriptionList, loc == a && b == 1 && item == (head c)]

objectDesc loc object = [last c | (a,b,c) <- descriptionList, loc == a && b == 2 && object == (head c)]

eventDesc loc action actionOn = [last c | (a,b,c) <- eventDescriptionList, loc == a && action == (head c) && actionOn == last(take 2 c)]


getMovesText loc list = [c | (a,b,c,d) <- list, loc == a && d == True]

getMoves loc list = [(a,b,c,d) | (a,b,c,d) <- list, loc == a && d == True]

changeBool loc list = [(a,b,c,True) | (a,b,c,d) <- list, a == loc && d == False]

newTextList loc list = (take loc list) ++ changeTextBool [(list!!(loc))] ++ (drop (loc+1) list) where
  changeTextBool list = [(True,b) | (a,b) <- list, a == False] ++ [(True,b) | (a,b) <- list, a == True]

checkEvent loc action actionOn = if elem action (getEvent loc action) == True && elem actionOn (getEvent loc action) == True then True else False where
  getEvent loc action = flatten [c | (a,b,c) <- eventDescriptionList, loc == a && action == (head c)]
  
  
---- Item- and Object-lists ----

contentList = [(1, 2, "Door", True), (1, 2, "Stone wall", True), (2, 1, "Torch", True), (3, 2, "Painting", True), (4, 2, "Fireplace",True), (5, 1, "Yellow gem", True), (5, 2, "Chest", True), (7, 2, "Bridge", True), (7, 2, "Pedestal", True), (10, 1, "Shimmering coat", True), (10, 1, "White gem", True)]

descriptionList = [(1, 2, ["Door", "An old wooden door without a handle."]), (1, 2, ["Stone wall", "There seem to be a 'loose' stone on the wall"]), (2, 1, ["Torch", "It gives of a weird light"]), (3, 1, ["Key","It is a brass key."]), (3, 2, ["Painting", "Gloomy painting of an eldery man."]), (3, 2, ["Door", "It is a wooden door with a keyhole"]), (5, 1, ["Yellow gem", "A small gem of yellow color in the shape of a hexagon."]), {-(5, 2, ["Chest", "A wooden chest. It is locked"]),-} (7, 2, ["Bridge", "The bridge is put in a vertical position, but there seems to be a mechanism attached to it. Maybe there is a way to lower it for me to gain passage?"]), (7, 2, ["Pedestal", "It has a small socket in it with six edges"]), (10, 1, ["Shimmering coat", "A coat that shimmers in a magic"]), (10, 1, ["White gem", "A beautiful white gem, must be worth a fortune"])]

eventDescriptionList = [(1, 2, ["Stone wall", "", "You push the stone and the door opens."]), (3, 1, ["Door", "Key", "You unlock the door."]), (3, 2, ["Painting", "", "While looking closer at the painting you notice that one of the eyes on the man seems to be a button. When you press it the door opens."]), (4, 1, ["Fireplace", "Torch", "A secret door opens as soon as you light up the fireplace"]), (7, 1, ["Pedestal", "Yellow gem", "The bridge is lowered! Maybe the gem holds some sort energy?"])]

moveList = [(1,2,"Inside",False), (2,1,"Back",False), (2,3,"Right",True), (2,7,"Forward",True), (3,2,"Back",True), (3,4,"Forward",False), (4,5,"Through hidden door",False), (4,6,"Forward",True), (7,13,"Up",False), (7,2,"Back",True)]


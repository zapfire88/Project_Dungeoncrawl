

-- Game contents --
module GameContents(takeSecond, changeMoveState, flatten, removeItem, removeContent, checkRoom, roomItem, itemDesc, roomObject, objectDesc, eventDesc, getMovesText, getMoves, changeBool, contentList, itemList, itemDescriptionList, textList, objectList, objectDescriptionList, eventDescriptionList, moveList)
where

import Texts

type Game = (RoomNumber, PossibleDirections, PointOfInterests, PointOfInterests, Bag, Contents, MoveStates)
type RoomNumber = Integer
type PossibleDirections = [(RoomNumber, RoomNumber, Description, Bool)]
type PointOfInterests = [String]
type Bag = [String]
type Contents = [(RoomNumber, [String])]
type Description = String
type Item = String
type AdjacentRooms = [(Integer, Integer, Bool)]
type Object = String -- First String for name, Second string is for description
type MoveStates = [(RoomNumber, RoomNumber, Description, Bool)]

---- Functions ----
takeFirst [(a,b,c,d)] = a
takeSecond [(a,b,c,d)] = b
takeThird [(a,b,c,d)] = c
takeFourth [(a,b,c,d)] = d

changeMoveState loc moveState = flatten(changeBool loc moveState):filteredList where
  filteredList = filterList (reverseChangeBool(flatten(changeBool loc moveState))) moveState
  reverseChangeBool (a,b,c,d) = (a,b,c, not d)
  filterList state moveState = filter (/=state) moveState

flatten [a] = a


removeItem input items = filter (/=input) items


removeContent2 input content = filter ((/= [input]).snd) content
removeContent input content = filter (\(_,b,c,_) -> b == 2 && c == input) content


checkRoom loc input list = filter (\(a,_,c,_) -> a == loc && c == input) list

roomItem loc = [concat c | (a, b, c, d) <- contentList, loc == a && b == 1 && d == True]

itemDesc loc item = [last b | (a,b) <- itemDescriptionList, loc == a && item == (head b)]

roomObject loc = [concat c | (a, b, c, d) <- contentList, loc == a && b == 2 && d == True]

objectDesc loc object = [last b | (a,b) <- objectDescriptionList, loc == a && object == (head b)]

eventDesc loc action = [last b | (a,b) <- eventDescriptionList, loc == a && action == (head b)]

getMovesText loc = [c | (a,b,c,d) <- moveList, loc == a]

getMoves loc list = [(a,b,c,d) | (a,b,c,d) <- list, loc == a && d == True]

changeBool loc list = [(a,b,c,True) | (a,b,c,d) <- list, a == loc && d == False] ++ [(a,b,c,True) | (a,b,c,d) <- list, a == loc && d == True]




---- Item- and Object-lists ----



-- contentList :: [(RoomNumber, Integer, [String], Bool)]  ex: (1, 1, ["Key"]). First element is RoomNumber. Second is 1 for item and 2 for object. Third is name of item/object. Fourth is whether it is visible. 
contentList = [(1, 2, ["Door"], True), (1, 2, ["Stone wall"], True), (2, 1, ["Torch"], True), (3, 1, ["Key"], False), (3, 2, ["Painting"], True), (5, 1, ["Yellow gem"], True), (5, 2, ["Chest"], False), (7, 2, ["Bridge"], True), (7, 2, ["Pedestal"], False), (10, 1, ["Shimmering coat"], True), (10, 1, ["White gem"], True)]

--itemList :: [(RoomNumber,[Item])]
itemList = [(1, []), (2, ["Torch"]),(3, ["Key"]),(4,[]),(5,["Yellow gem"]),(6,[]),(7,[]),(8,[]),(9,[]),(10,["Shimmering coat"]),(10,["White gem"]),(11,[]),(12,[]),(13,[]),(14,[]),(15,[]),(16,[]),(17,[]),(18,[])]

--itemDescriptionList :: [(RoomNumber, [String])]
itemDescriptionList = [(1, []), (2, ["Torch", "It gives of a weird light"]),(3,["Key","It is a brass key."]),(4,[]),(5,["Yellow gem", "A small gem of yellow color in the shape of a hexagon."]),(6,[]),(7,[]),(8,[]),(9,[]),(10,["Shimmering coat", "A coat that shimmers in a magic"]), (10,["White gem", "A beautiful white gem, must be worth a fortune"]),(11,[]),(12,[]),(13,[]),(14,[]),(15,[]),(16,[]),(17,[]),(18,[])]

--objectList :: [(RoomNumber, [Object])]
objectList = [(1, ["Door"]), (1, ["Stone wall"]), (2,[]), (3,["Painting"]), (4,[]), (5,["Chest"]), (6,[]), (7,["Bridge"]), (7,["Pedestal"]), (8,[]), (9,[]), (10,[]), (11,[]), (12,[]), (13,[]), (14,[]), (15,[]), (16,[]), (17,[]), (18,[])]

--objectDescriptionList :: [(RoomNumber, [Object])]
objectDescriptionList = [(1, ["Door", "An old wooden door without a handle."]), (1, ["Stone wall", "There seem to be a 'loose' stone on the wall"]), (3,["Painting", "Gloomy painting of an eldery man"]), (3,["Door", "It is a wooden door with a keyhole"]), (4,[]), (5,["Chest", "A wooden chest. It is locked"]), (6,[]), (7,["Bridge", "The bridge is put in a vertical position, but there seems to be a mechanism attached to it. Maybe there is a way to lower it for me to gain passage?"]),(7, ["Pedestal", "It has a small socket in it with six edges"])]--, (8,[]), (9,[]), (10,[]), (11,[]), (12,[]), (13,[]), (14,[]), (15,[]), (16,[]), (17,[]), (18,[])]

--eventList :: [(RoomNumber, [Description], Bool)]
eventDescriptionList = [(1, ["Stone wall", "You push the stone and the door opens"]), (3, ["Door", "The door is unlocked!"]), (3,["Painting", "You move the painting and find a key behind it"]), (4, ["Fireplace", "A secret door opens as soon as you light up the fireplace"])]

--adjacentRoomsList :: AdjacentRooms
--adjacentRoomsList = [(1, 2, False),(2, 3, True),(2, 7, True), (3, 4, False)]--,(4, 5, False),(4, 6),(6, 13),(7, 8),(8, 9),(8, 11),(9, 10),(11, 12),(13, 14),(13, 15),(15, 16),(16, 17),(17, 18)]

moveList = [(1,2,"Inside",False), (2,1,"Back",False), (2,3,"Right",True), (2,7,"Forward",True), (3,2,"Back",True), (3,4,"Forward",False), (4,5,"Through hidden door",False), (4,6,"Forward",True), (7,13,"Up",False), (7,2,"Back",True)]


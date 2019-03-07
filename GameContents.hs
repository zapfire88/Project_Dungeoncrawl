

-- Game contents --
module GameContents(checkMove, changeMoveState, flatten, removeItem, removeContent, roomItem, itemDesc, roomObject, objectDesc, eventDesc, getMovesText, getMoves, getNewRoom, checkEvent, newTextList, contentList, descriptionList, eventDescriptionList, moveList)
where

--import Texts

---- Functions ----



changeMoveState loc moveState = flatten(changeBool loc moveState):filteredList where
  filteredList = filterList (reverseChangeBool(flatten(changeBool loc moveState))) moveState
  filterList state moveState = filter (/=state) moveState
  reverseChangeBool (a,b,c,d) = (a,b,c, not d)
  changeBool loc list = [(a,b,c,True) | (a,b,c,d) <- list, a == loc && d == False]

flatten [a] = a

removeItem input items = filter (/=input) items

removeContent input content = filter (\(_,b,c,_) -> b /= 1 && c /= input) content



roomItem loc list = [c | (a, b, c, d) <- list, loc == a && b == 1 && d == True]

roomObject loc list = "Self":[c | (a, b, c, d) <- list, loc == a && b == 2 && d == True]

itemDesc loc item = [last c | (a,b,c) <- descriptionList, loc == a && b == 1 && item == (head c)]

objectDesc loc object = [last c | (a,b,c) <- descriptionList, loc == a && b == 2 && object == (head c)]

eventDesc loc action actionOn = [last c | (a,b,c) <- eventDescriptionList, loc == a && action == (head c) && actionOn == last(take 2 c)]


getMovesText loc list = [c | (a,b,c,d) <- list, loc == a && d == True]

getMoves loc list = [(a,b,c,d) | (a,b,c,d) <- list, loc == a && d == True]

checkMove loc input list = flatten [(a,b,c,d) | (a,b,c,d) <- list, loc == a && input == c && d == True]


getNewRoom loc input moveStates = takeSecond (checkRoom loc input moveStates) where
  takeSecond (a,b,c,d) = b
  checkRoom loc input list = flatten (filter (\(a,_,c,_) -> a == loc && c == input) list)

newTextList loc list = (take loc list) ++ changeTextBool [(list!!(loc))] ++ (drop (loc+1) list) where
  changeTextBool list = [(True,b) | (a,b) <- list, a == False] ++ [(True,b) | (a,b) <- list, a == True]

checkEvent loc action actionOn = if elem action (getEvent loc action) == True && elem actionOn (getEvent loc action) == True then True else False where
  getEvent loc action = if [c | (a,b,c) <- eventDescriptionList, loc == a && action == (head c)] == [] then [""]
  else flatten [c | (a,b,c) <- eventDescriptionList, loc == a && action == (head c)]
  
  
---- Item- and Object-lists ----
 
contentList = [(1, 2, "Door", True), (1, 2, "Stone wall", True), (2, 1, "Torch", True), (3, 2, "Painting", True), (3, 2, "Door", True), (4, 2, "Fireplace",True), (5, 1, "Yellow gem", True), (6, 2, "Balcony", True), (7, 2, "Bridge", True), (7, 2, "Pedestal", True), (9, 1, "Shimmering coat", True), (9, 1, "White gem", True), (10, 2, "Sphinx", True), (11, 2, "Shimmering wall", True), (12, 1, "Scroll", True), (13, 2, "Bed", True), (13, 2, "Mirror", True)]

descriptionList = [(1, 2, ["Door", "An old wooden door without a handle."]), (1, 2, ["Stone wall", "There seem to be a 'loose' stone on the wall"]), (2, 1, ["Torch", "It gives of a weird light"]), (3, 2, ["Painting", "It is a gloomy painting of an eldery man."]), (3, 2, ["Door", "It is a wooden door with a keyhole"]), (5, 1, ["Yellow gem", "A glowing small gem of yellow color in the shape of a hexagon."]), (6,2,["Balcony","The balcony has nice features to it and is very high up."]), (7, 2, ["Bridge", "It seems to be a quite old take on a modern bridge."]), (7, 2, ["Pedestal", "There is a small hexagonal socket in it."]), (9, 1, ["Shimmering coat", "It shimmers in rapidly changing colours. Maybe it has some magic properties?"]), (9, 1, ["White gem", "A beautiful white gem. It might be worth a fortune."]), (10, 2, ["Sphinx", "It is a sphinx. It seems to wait for you to interact with it."]), (11, 2, ["Shimmering wall","It is a transparent, shimmering wall. When touching it a force pushes you away."]), (12, 1, ["Scroll", "It is a rolled up parchment. Something is written but you can't seem to understand it."]), (13, 2, ["Bed", "A skeleton is laying in the bed. It might be the old man from the painting"]), (13, 2, ["Mirror", "It seems the mirror does not reflect, but rather shows the entrence."])]

eventDescriptionList = [(1, 2, ["Stone wall", "", "You push the stone and the door opens."]), (3, 2, ["Painting", "", "While looking closer at the painting you notice that one of the eyes on the man seems to be a button. As you press it the door opens."]), (4, 1, ["Fireplace", "Torch", "A secret door opens as soon as you light up the fireplace"]), (6, 1, ["Self", "Scroll", "You open up the scroll and realize that you can now read it. It reads \"When heavens is out of reach, call upon Levion to help\". You shout \"Levion\" out loud and all of a sudden you feel lighter."]), (7, 1, ["Pedestal", "Yellow gem", "The bridge is lowered! Maybe the gem holds some sort energy?"]), (10, 2, ["Self", "Shimmering coat", "You test the coat against the shimmering wall. It passes through. You put it on and continue to the next room."])]

moveList = [(1,2,"Inside",False), (2,3,"Right",True), (2,7,"Forward",True), (3,2,"Back",True), (3,4,"Forward",False), (4,3,"Back",True), (4,5,"Through hidden door",False), (4,6,"Forward",True), (5,4,"Back",True), (6,5,"Back",True), (6,13,"Up",False), (7,2,"Back",True), (7,8,"Over the bridge",False), (8,7,"Back",True), (8,9,"Right",True), (8,10,"Left",True), (9,8,"Back",True), (10,8,"Back",True), (11,10,"Back",True), (13,6,"Back down",True)]


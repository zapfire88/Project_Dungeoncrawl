
module Functions(takeFirst, takeSecond, takeThird, removeItem, removeContent, roomItem, itemDesc, roomObject, objectDesc, eventDesc, adjacentRoom, adjacentRoomsList, changeBool, getMoves, getMovesText) 
where

import GameContents


takeFirst (a,b,c) = a
takeSecond (a,b,c) = b
takeThird (a,b,c) = c
  
--testfunc

--removeItem :: Item -> [Item] -> [Item]
removeItem _ [] = []
removeItem item (x:xs)
  | item == x = removeItem item xs
  | otherwise = x:removeItem item xs



--removeContent _ [] = []
removeContent input content = filter (\content -> (snd content) /= input)
 -- item == x = removeItem item xs
 -- | otherwise = x:removeItem item xs

--roomItem :: RoomNumber -> [Item]
roomItem loc = [concat b | (a,b) <- itemList, loc == a]


--itemDesc :: RoomNumber -> Item -> Description
itemDesc loc item = [concat (tail b) | (a,b) <- itemDescriptionList, loc == a && item == (head b)]

--roomObject :: RoomNumber -> [Item]
roomObject loc = [concat b | (a,b) <- objectList, loc == a]

--objectDesc :: RoomNumber -> Object -> Description
objectDesc loc object = [concat (tail b) | (a,b) <- objectDescriptionList, loc == a && object == (head b)]


eventDesc loc action = [concat ([last b]) | (a,b) <- eventDescriptionList, loc == a && action == (head b)]
--adjacentRoom :: RoomNumber -> PossibleDirections
--adjacentRoom loc = [a | (a,b,c) <- adjacentRoomsList, loc == b] ++ [b | (a,b,c) <- adjacentRoomsList, loc == a]

--eventChange loc action = 

getMovesText loc = [concat c | (a,b,c) <- moveList, loc == a]
getMoves loc = [b | (a,b,c) <- moveList, loc == a]

adjacentRoom loc = [(a,c) | (a,b,c) <- adjacentRoomsList, loc == b] ++ [(b,c) | (a,b,c) <- adjacentRoomsList, loc == a]

changeBool loc = [(a,True) | (a,b) <- (adjacentRoom loc), b == False] ++ [(a,True) | (a,b) <- (adjacentRoom loc), b == True]


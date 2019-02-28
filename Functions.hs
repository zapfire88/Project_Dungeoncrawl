
module Functions(takeThird, removeItem, roomItem, itemDesc, roomObject, objectDesc, adjacentRoom, adjacentRoomsList) 
where

import GameContents

takeThird loc = [c | (a,b,c) <- adjacentRoomsList, loc == b] ++ [c | (a,b,c) <- adjacentRoomsList, loc == a]
  

--removeItem :: Item -> [Item] -> [Item]
removeItem _ [] = []
removeItem item (x:xs)
  | item == x = removeItem item xs
  | otherwise = x:removeItem item xs


--roomItem :: RoomNumber -> [Item]
roomItem loc = [concat b | (a,b) <- itemList, loc == a]


--itemDesc :: RoomNumber -> Item -> Description
itemDesc loc item = [concat (tail b) | (a,b) <- itemDescriptionList, loc == a && item == (head b)]

--roomObject :: RoomNumber -> [Item]
roomObject loc = [concat b | (a,b) <- objectList, loc == a]

--objectDesc :: RoomNumber -> Object -> Description
objectDesc loc object = [concat (tail b) | (a,b) <- objectDescriptionList, loc == a && object == (head b)]

--adjacentRoom :: RoomNumber -> PossibleDirections
adjacentRoom loc = [a | (a,b,c) <- adjacentRoomsList, loc == b] ++ [b | (a,b,c) <- adjacentRoomsList, loc == a]


  

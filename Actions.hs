
module Actions(inspectItem, inspectObject, take, useItem, move)
where
-- Actions --

type Room = (RoomNumber, PossibleDirections, Description, [Object], [Item])
type RoomNumber = Int
type Description = (String, Bool)
type Item = (String, String) -- Item is a Touple of two strings, first string for the items name and second string for the items description. 
-- type PointOfInterest = undefined  
type PossibleDirections = [RoomNumber]
type Door = [(Int, Bool)] -- Int is the index (of doors in room). First Bool is for whether it is open, second if it is locked.
type Object = (String, Item, String) -- First String for name, Second string is for description
type AdjacentRooms = [(RoomNumber, RoomNumber)]
type Inventory = [Item]


adjacentRoom :: RoomNumber -> PossibleDirections
adjacentRoom position = [a | (a,b) <- adjacentRoomsList, position == b] ++ [b | (a,b) <- adjacentRoomsList, position == a]



adjacentRoomsList :: AdjacentRooms
adjacentRoomsList = [(1, 2),(2, 3),(2, 7),(3, 4),(4, 5),(4, 6),(6, 13),(7, 8),(8, 9),(8, 11),(9, 10),(11, 12),(13, 14),(13, 15),(15, 16),(16, 17),(17, 18)]


dEIL ::(Eq a) => a -> [a] -> Bool
dEIL x [] = False
dEIL grunka (x:xs) = if grunka == x then True
                     else dEIL grunka xs

useitem :: Item -> Object -> String
useitem sak (a,b,c) = if sak == b then "Utför event"
                    else "Does not work"

inspectItem :: Item -> String
inspectItem (a,b) = show b

inspectObject :: Object -> String
inspectObject (a,b,c) = show c

move :: RoomNumber -> RoomNumber -> String
move dittrum villtill = if (dEIL (dittrum,villtill) adjacentRoomsList) == True then "runGame villtill"
                        else "Cannot go there" 

take :: Item -> Inventory
take sak = sak : []


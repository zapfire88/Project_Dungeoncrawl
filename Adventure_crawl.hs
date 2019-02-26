import Texts
-- Rooms --


type Room = (RoomNumber, PossibleDirections, Description, PointOfInterest)
type RoomNumber = Int
type Description = (String, Bool)
type Item = (String, String) -- Item is a Touple of two strings, first string for the items name and second string for the items description. 
type PointOfInterest = [(Item, Item)]
type PossibleDirections = [RoomNumber]
type Door = [(Int, Bool)] -- Int is the index (of doors in room). First Bool is for whether it is open, second if it is locked.
type Chest = [Bool]
type AdjacentRooms = [(RoomNumber, RoomNumber)]



adjacentRoom :: RoomNumber -> PossibleDirections
adjacentRoom position = [a | (a,b) <- adjacentRoomsList, position == b] ++ [b | (a,b) <- adjacentRoomsList, position == a]




-- Edge list av alla rum --
adjacentRoomsList :: AdjacentRooms
adjacentRoomsList = [(1, 2),(2, 3),(2, 7),(3, 4),(4, 5),(4, 6),(6, 13),(7, 8),(8, 9),(8, 11),(9, 10),(11, 12),(13, 14),(13, 15),(15, 16),(16, 17),(17, 18)]

--start Room
action <- getLine
if action == 1 then putStrLn "Hey"

--runIntro = putStr ( unlines list) where list = ["Finally, after many years of searching, you are now standing in front of it.", "To think that there was something, either some sort of a force field, or even stranger, a magic field that could hide it.","I will definitely discover something amazing here!"] 

runGame ::

startGame :: IO ()
startGame = do
  runIntro
  --runGame start



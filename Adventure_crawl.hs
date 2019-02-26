import Texts
import Items
-- Rooms --


type Room = (RoomNumber, PossibleDirections, PointOfInterests)
type RoomNumber = Int
type Description = String
type Item = String
type PointOfInterests = [String]
type PossibleDirections = [RoomNumber]
type AdjacentRooms = [(Int, Int)]


adjacentRoom :: RoomNumber -> PossibleDirections
adjacentRoom position = [a | (a,b) <- adjacentRoomsList, position == b] ++ [b | (a,b) <- adjacentRoomsList, position == a]

-- Edge list av alla rum --
adjacentRoomsList :: AdjacentRooms
adjacentRoomsList = [(1, 2),(2, 3),(2, 7),(3, 4),(4, 5),(4, 6),(6, 13),(7, 8),(8, 9),(8, 11),(9, 10),(11, 12),(13, 14),(13, 15),(15, 16),(16, 17),(17, 18)]


actions :: [String]
actions = ["- inspect", "- take", "- use", "- move", "- hit"]


start :: Room
start = (position, possibleDirection, takeInterest 1) where
  position = 1
  possibleDirection = adjacentRoom position
  --let description = textList!!position
  --pointOfInterest = takeInterest position
  --description
  --putStr (unlines (takeInterest position))

takeInterest position = [concat b | (a,b) <- itemList, position == a]


runGame :: Room -> IO ()
runGame state = do
  textList!!1
  putStrLn (unlines [" ", "What would you like to do?"])
  putStrLn (unlines actions)
  action <- getLine
  if action == "inspect" then do putStrLn "1" 
  else if action == "take" then do putStrLn "2"
  else if action == "use" then do putStrLn "3"
  else if action == "move" then do putStrLn "4"
  else if action == "hit" then do putStrLn "5"
  else if action == "quit" then do return ()
  else do putStrLn ("wrong input: '" ++ action ++ "' is not valid.")
  

startGame :: IO ()
startGame = do
  putStrLn (unlines [" ","To quit: write 'quit'"," "])
  textList!!0
  putStrLn " "
  runGame start
  return ()


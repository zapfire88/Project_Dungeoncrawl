import GameContents
import Functions
import Data.List
import Data.Char
-- Rooms --


type Game = (RoomNumber, PossibleDirections, PointOfInterests, PointOfInterests, Bag)
type RoomNumber = Integer
type PossibleDirections = [RoomNumber]
type PointOfInterests = [String]
type Bag = [String]
type Description = [String]
type Item = String
type AdjacentRooms = [(Integer, Integer, Bool)]
type Object = String -- First String for name, Second string is for description



--itemList = [(1,["1"]), (1,["2"]), (2,["Torch"]),(3,["Key"]),(4,[]),(5,["Yellow gem"]),(6,[]),(7,[]),(8,[]),(9,[]),(10,["Shimmering coat"]),(10,["White gem"]),(11,[]),(12,[]),(13,[]),(14,[]),(15,[]),(16,[]),(17,[]),(18,[])]


start :: Game
start = (loc, adjacentRoom loc, roomItem loc,roomObject loc, yourBag) where
  --loc :: RoomNumber
  loc = 1
  --yourBag :: Bag
  yourBag = []

contents = [itemList, itemDescriptionList, objectList, objectDescriptionList]


actions :: [String]
actions = ["- Inspect", "- Take", "- Use", "- Move", "- Quit"]




--eventList :: [(RoomNumber, [Description], Bool)]
--eventList = [(1, ["Stone wall", "You push the stone and the door opens"], False)]

--dispEvent :: RoomNumber -> Item -> [Object]
--dispEvent loc item objects
--checkOpen loc dir = if takeThird 

{-takeThird loc = [c | (a,b,c) <- adjacentRoomsList, loc == b] ++ [c | (a,b,c) <- adjacentRoomsList, loc == a]
  

removeItem :: Item -> [Item] -> [Item]
removeItem _ [] = []
removeItem item (x:xs)
  | item == x = removeItem item xs
  | otherwise = x:removeItem item xs


roomItem :: RoomNumber -> [Item]
roomItem loc = [concat b | (a,b) <- itemList, loc == a]


itemDesc :: RoomNumber -> Item -> Description
itemDesc loc item = [concat (tail b) | (a,b) <- itemDescriptionList, loc == a && item == (head b)]

roomObject :: RoomNumber -> [Item]
roomObject loc = [concat b | (a,b) <- objectList, loc == a]

objectDesc :: RoomNumber -> Object -> Description
objectDesc loc object = [concat (tail b) | (a,b) <- objectDescriptionList, loc == a && object == (head b)]

adjacentRoom :: RoomNumber -> PossibleDirections
adjacentRoom loc = [a | (a,b,c) <- adjacentRoomsList, loc == b] ++ [b | (a,b,c) <- adjacentRoomsList, loc == a]

adjacentRoomsList :: AdjacentRooms
adjacentRoomsList = [(1, 2, False),(2, 3, True)]--,(2, 7),(3, 4),(4, 5),(4, 6),(6, 13),(7, 8),(8, 9),(8, 11),(9, 10),(11, 12),(13, 14),(13, 15),(15, 16),(16, 17),(17, 18)]
  
-}

runGame :: Game -> IO () -- Game loop
runGame (loc, dir, items, objects, bag) = do
  ---- Intro part ----
  putStrLn (unlines ["--------------------------"])
  textList!!fromInteger loc
  putStrLn " "
  putStrLn "You see: "
  if items == [""] && objects == [""] then putStrLn (unlines ["Nothing in perticular"])
  else putStrLn ((unlines items) ++ (unlines objects))
  putStrLn "In your bag is: "
  putStrLn (unlines bag)
  putStrLn "What would you like to do?"
  putStrLn (unlines actions)
  action <- getLine
  
  ---- Actions ----
  
  -- Inspect --
  if action == "inspect" || action == "Inspect" then do 
  putStrLn "What would you like to inspect?"
  putStrLn ((unlines items) ++ (unlines objects))
  actionInspect <- getLine
  if elem actionInspect items == True then do
  putStrLn (unlines (itemDesc loc actionInspect))
  runGame (loc, dir, items, objects, bag)
  else if elem actionInspect objects == True then do
  putStrLn (unlines (objectDesc loc actionInspect))
  runGame (loc, dir, items, objects, bag)
  else do
  putStrLn "Cannot inspect that!"
  runGame (loc, dir, items, objects, bag)
  
  -- Take --
  
  else if action == "take" || action == "Take" then do 
  putStrLn "What would you like to take?"
  actionTake <- getLine
  if elem actionTake items == True
  then do 
  runGame (loc, dir, removeItem actionTake items, objects, actionTake:bag)
  else do 
  putStrLn "Cannot take that!"
  runGame (loc, dir, items, objects, bag)
  
  -- Use --
  
  else if action == "use" || action == "Use" then do 
  putStrLn "What would you like to use?"
  actionUse <- getLine
  --if elem actionUse bag == True then do
  --putStrLn ("What would you like to use " ++ actionUse ++ " on?")
  --useOn <- getLine
  ----if elem useOn objects == True then do
  
  ----else putStrLn ("Cannot use " ++ actionUse ++ " on " ++ useOn ++ " ."
  
  --else if elem actionUse objects == True then do
  --putStrLn ("What would you like to use " ++ actionUse ++ " on?")
  --else do putStrLn ("Wrong input.")
  
 
  runGame (loc, dir, items, objects, bag)

  -- Move --

  else if action == "move" || action == "Move" then do 
  putStrLn (unlines ["Where would you like to go?"])
  putStrLn (show dir)
  input <- getLine
  let newLoc = read input :: RoomNumber
  if elem newLoc dir == True && head (takeThird loc) == True then do
  runGame (newLoc, adjacentRoom newLoc, roomItem newLoc, objects, bag)
  else if elem newLoc dir == True && head (takeThird loc) == False then do
  putStrLn "That is not possible right now."
  runGame (loc, dir, items, objects, bag)
  else do 
  putStrLn "wrong input"
  runGame (loc, dir, items, objects, bag)
  
  -- Quit --
  
  else if action == "quit" || action == "Quit" then do 
  return ()
  else do
  
  putStrLn ("wrong input: '" ++ action ++ "' is not valid.")
  runGame (loc, dir, items, objects, bag)


startGame :: IO ()
startGame = do
  putStrLn " "
  textList!!0
  putStrLn " "
  runGame start -- Calls the game with starting values
  return ()


import GameContents
import Functions
import Data.List
import Data.Char
-- Rooms --


type Game = (RoomNumber, PossibleDirections, PointOfInterests, PointOfInterests, Bag, Contents)
type RoomNumber = Integer
type PossibleDirections = [(RoomNumber, Bool)]
type PointOfInterests = [String]
type Bag = [String]
type Contents = [(RoomNumber, [String])]
type Description = [String]
type Item = String
type AdjacentRooms = [(Integer, Integer, Bool)]
type Object = String -- First String for name, Second string is for description



--itemList = [(1,["1"]), (1,["2"]), (2,["Torch"]),(3,["Key"]),(4,[]),(5,["Yellow gem"]),(6,[]),(7,[]),(8,[]),(9,[]),(10,["Shimmering coat"]),(10,["White gem"]),(11,[]),(12,[]),(13,[]),(14,[]),(15,[]),(16,[]),(17,[]),(18,[])]
list = [b | (a,b) <- itemList]



testfunc newLoc loc = if newLoc == (fst (head(adjacentRoom loc))) && (snd (head(adjacentRoom loc))) == False then do 
[((fst (head(adjacentRoom loc))), True)]
--else if newLoc == (fst (head(adjacentRoom loc))) && (snd (head(adjacentRoom loc))) == False then do [((fst (head(adjacentRoom loc))), True)]
else do error "wujat"


start :: Game
start = (loc, adjacentRoom loc, roomItem loc,roomObject loc, yourBag, gameContents) where
  loc = 1
  yourBag = [""]
  gameContents = concat [itemList ++ objectList]


actions :: [String]
actions = ["- Inspect", "- Take", "- Use", "- Move", "- Quit"]






------ Game loop ------



runGame :: Game -> IO () 
runGame (loc, dir, items, objects, bag, gameContents) = do
  ---- Intro part ----
  putStrLn (unlines ["--------------------------"])
  textList!!fromInteger loc
  putStrLn " "
  putStrLn "You see: "
  if items == [""] && objects == [""] then putStrLn (unlines ["Nothing in perticular"])
  else putStrLn ((unlines items) ++ (unlines objects))
  if bag == [""] then putStrLn (unlines ["Your inventory is empty."])
  else putStrLn (unlines ["You have " ++ (concat bag) ++ " in your inventory."])
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
  runGame (loc, dir, items, objects, bag, gameContents)
  else if elem actionInspect objects == True then do
  putStrLn (unlines (objectDesc loc actionInspect))
  runGame (loc, dir, items, objects, bag, gameContents)
  else do
  putStrLn "Cannot inspect that!"
  runGame (loc, dir, items, objects, bag, gameContents)
  
  
  
  -- Take --
  
  
  
  else if action == "take" || action == "Take" then do 
  putStrLn "What would you like to take?"
  actionTake <- getLine
  
  if elem actionTake items == True
  then do 
  runGame (loc, dir, removeItem actionTake items, objects, actionTake:bag, gameContents)
  
  else do 
  putStrLn "Cannot take that!"
  runGame (loc, dir, items, objects, bag, gameContents)
  
  
  
  -- Use --
  
  
  
  else if action == "use" || action == "Use" then do 
  if bag == [""] && objects == [""] then putStrLn "There is nothing to use."
  else if bag == [""] && objects /= [""] then putStrLn ("In your bag is: " ++ (unlines ["Nothing in perticular"]) ++ "You see: " ++ (unlines objects))
  else if bag /= [""] && objects == [""] then putStrLn "You cannot use anyting at the moment."
  else do putStrLn "What would you like to use?"
  putStrLn ((unlines bag) ++ (unlines objects))
  actionUse <- getLine
  --if elem actionUse bag == True then do
  --putStrLn ("What would you like to use " ++ actionUse ++ " on?")
  --useOn <- getLine
  ----if elem useOn objects == True then do
  ----
  ----runGame (loc, changeBool loc, items, objects, bag)
  ----else putStrLn ("Cannot use " ++ actionUse ++ " on " ++ useOn ++ " ."
  
  if elem actionUse objects == True then do
  putStrLn (unlines (eventDesc loc actionUse))
  runGame (loc, changeBool loc, items, objects, bag, gameContents)
  
  else do putStrLn ("Wrong input.")
  runGame (loc, dir, items, objects, bag, gameContents)



  -- Move --



  else if action == "move" || action == "Move" then do 
  putStrLn (unlines ["Where would you like to go?"])
  putStrLn (unlines (getMovesText loc))
  input <- getLine
  
  let newLoc = ((read input :: RoomNumber),True)
  
  --if elem input (getMovesText loc) == True then do
  ----if snd dir == True then do
  ----runGame ((getMoves (head loc)), adjacentRoom (getMoves (head loc)), roomItem (getMoves (head loc)), roomObject (getMoves (head loc)), bag)
  --if (fst newLoc) /= (fst (head dir)) then do
  --putStrLn "wrong input"
  --runGame (loc, dir, items, objects, bag)
  if elem newLoc dir == True then do-- && head (takeThird loc) == True then do
  runGame ((fst newLoc), adjacentRoom (fst newLoc), roomItem (fst newLoc), roomObject (fst newLoc), bag, gameContents)
  
  else do-- && head (takeThird loc) == False then do
  putStrLn "That is not possible right now."
  runGame (loc, dir, items, objects, bag, gameContents)
  
  --else do 
  --putStrLn "wrong input"
  --runGame (loc, dir, items, objects, bag)
  
  
  
  -- Quit --
  
  
  
  else if action == "quit" || action == "Quit" then do 
  return ()
  else do
  
  putStrLn ("wrong input: '" ++ action ++ "' is not valid.")
  runGame (loc, dir, items, objects, bag, gameContents)





---- Starts the game ----





startGame :: IO ()
startGame = do
  putStrLn " "
  textList!!0
  putStrLn " "
  runGame start -- Calls the game with starting values
  return ()



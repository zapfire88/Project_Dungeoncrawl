import GameContents
import Data.List
import Data.Char
-- Rooms --


type Game = (RoomNumber, PossibleDirections, PointOfInterests, PointOfInterests, Bag, Contents, MoveStates)
type RoomNumber = Integer
type PossibleDirections = [(RoomNumber, RoomNumber, Description, Bool)]
type PointOfInterests = [String]
type Bag = [String]
type Contents = [(RoomNumber, Integer, [String], Bool)]
type Description = String
type Item = String
type AdjacentRooms = [(Integer, Integer, Bool)]
type Object = String -- First String for name, Second string is for description
type MoveStates = [(RoomNumber, RoomNumber, Description, Bool)]


---- Change Contents to contentList ----



start :: Game
start = (startLoc, getMoves startLoc startMoveStates, roomItem startLoc,roomObject startLoc, yourBag, startContents, startMoveStates) where
  startLoc = 1
  yourBag = [""]
  startContents = contentList--itemList ++ objectList
  startMoveStates = moveList

actions :: [String]
actions = ["- Inspect", "- Take", "- Use", "- Move", "- Quit"]






------ Game loop ------

runGame :: Game -> IO () 
runGame (loc, dir, items, objects, bag, gameContents, moveStates) = do
  print (loc, dir, items, objects, bag, gameContents, moveStates)
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
  
  
  -- Quit --
  
  if action == "Quit" then do 
  return()
  
  
  -- Inspect --
    
  else if action == "Inspect" then do 
  putStrLn "What would you like to inspect?"
  putStrLn ((unlines items) ++ (unlines objects))
  actionInspect <- getLine
  if elem actionInspect items == True then do
  putStrLn (unlines (itemDesc loc actionInspect))
  runGame (loc, dir, items, objects, bag, gameContents, moveStates)
  else if elem actionInspect objects == True then do
  putStrLn (unlines (objectDesc loc actionInspect))
  runGame (loc, dir, items, objects, bag, gameContents, moveStates)
  else do
  putStrLn "Cannot inspect that!"
  runGame (loc, dir, items, objects, bag, gameContents, moveStates)
  
  
  
  -- Take --
    
  else if action == "Take" then do 
  putStrLn "What would you like to take?"
  actionTake <- getLine
  
  if elem actionTake items == True
  then do 
  runGame (loc, dir, removeItem actionTake items, objects, actionTake:bag, removeContent [actionTake] gameContents, moveStates)
  
  else do 
  putStrLn "Cannot take that!"
  runGame (loc, dir, items, objects, bag, gameContents, moveStates)
  
  
  
  -- Use --
    
  else if action == "Use" then do 
  if bag == [""] && objects == [""] then putStrLn "There is nothing to use."
  else if bag == [""] && objects /= [""] then putStrLn (unlines (["In your bag is: "] ++ ["Nothing in perticular"] ++ ["You see: "] ++ objects))
  else if bag /= [""] && objects == [""] then putStrLn "You cannot use anyting at the moment."
  else do putStrLn "What would you like to use?"
  putStrLn ((unlines bag) ++ (unlines objects))
  actionUse <- getLine
  --if elem actionUse bag == True then do
  --putStrLn ("What would you like to use " ++ actionUse ++ " on?")
  --putStrLn (unlines objects)
  --useOn <- getLine
  ----if elem useOn objects == True then do
  ----
  ----runGame (loc, changeBool loc, items, objects, bag)
  ----else putStrLn ("Cannot use " ++ actionUse ++ " on " ++ useOn ++ " ."
  
  if elem actionUse objects == True then do
  putStrLn (unlines (eventDesc loc actionUse))
  runGame (loc, getMoves loc (changeBool loc moveStates), items, objects, bag, gameContents, changeMoveState loc moveStates)
  
  else do putStrLn ("Wrong input.")
  runGame (loc, dir, items, objects, bag, gameContents, moveStates)



  -- Move --
--getPossibleMoves loc = [b | (a,b,c) <- moveList, loc == a]

  else if action == "Move" then do 
  if dir == [] then do
  putStrLn "You have nowhere to go right now."
  runGame (loc, dir, items, objects, bag, gameContents, moveStates)
  else do
  putStrLn (unlines ["Where would you like to go?"])
  putStrLn (unlines (getMovesText loc))
  input <- getLine
  let newLoc = ((read input :: RoomNumber),True)
  
  if input == "" then do 
  putStrLn ("wrong input: '" ++ input ++ "' is not valid.")
  runGame (loc, dir, items, objects, bag, gameContents, moveStates)
   
  
  
  --if elem input (getMovesText loc) == True then do
  ----if snd dir == True then do
  ----runGame ((getMoves (head loc)), adjacentRoom (getMoves (head loc)), roomItem (getMoves (head loc)), roomObject (getMoves (head loc)), bag)
  --if (fst newLoc) /= (fst d dir)) then do
  --putStrLn "wrong input"
  --runGame (loc, dir, items, objects, bag)
  
  
  else if elem (flatten (checkRoom loc input moveStates)) dir then do
  runGame (takeSecond (checkRoom loc input moveStates), getMoves (takeSecond (checkRoom loc input moveStates)) moveStates, roomItem (takeSecond (checkRoom loc input moveStates)), roomObject (takeSecond (checkRoom loc input moveStates)), bag, gameContents, moveStates)

  
  else do
  putStrLn "That is not possible right now."
  runGame (loc, dir, items, objects, bag, gameContents, moveStates)
  

  
  -- Error message if wrong input --
  
  else do
  
  putStrLn ("wrong input: '" ++ action ++ "' is not valid.")
  runGame (loc, dir, items, objects, bag, gameContents, moveStates)





---- Starts the game ----





startGame :: IO ()
startGame = do
  putStrLn " "
  textList!!0
  putStrLn " "
  runGame start -- Calls the game with starting values
  return ()



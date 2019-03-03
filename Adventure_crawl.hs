import GameContents
import Data.List
import Data.Char
-- Rooms --


type Game = (RoomNumber, PossibleDirections, Items, Objects, Bag, Contents, MoveStates, IntroTexts)
type RoomNumber = Integer
type PossibleDirections = [(RoomNumber, RoomNumber, Description, Bool)]
type Description = String
type Items = [String]
type Objects = [String]
type Bag = [String]
type Contents = [(RoomNumber, Integer, String, Bool)]
type MoveStates = [(RoomNumber, RoomNumber, Description, Bool)]
type IntroTexts = [(Bool, [Description])]


getRoom loc input list = [(a,b,c,d) | (a, b, c, d) <- list, loc == a && c == input]

start :: Game
start = (startLoc, getMoves startLoc startMoveStates, roomItem startLoc,roomObject startLoc, yourBag, startContents, startMoveStates, introTexts) where
  startLoc = 1
  yourBag = [""]
  startContents = contentList
  startMoveStates = moveList
  introTexts = textList

actions :: [String]
actions = ["- Inspect", "- Take", "- Use", "- Move", "- Quit"]






------ Game loop ------

runGame :: Game -> IO () 
runGame (loc, dir, items, objects, bag, gameContents, moveStates, introTexts) = do
  --print (loc, dir, items, objects, bag, gameContents, moveStates, introTexts)
  putStrLn (unlines ["----------------------------------------------------"])
  if fst (introTexts!! fromInteger loc) == False then do
  putStrLn (unlines (snd (introTexts!!fromInteger loc)))
  runGame (loc, dir, items, objects, bag, gameContents, moveStates, newTextList (fromInteger loc) introTexts)
  else do
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
      runGame (loc, dir, items, objects, bag, gameContents, moveStates, introTexts)
    else if elem actionInspect objects == True then do
      putStrLn (unlines (objectDesc loc actionInspect))
      runGame (loc, dir, items, objects, bag, gameContents, moveStates, introTexts)
    else do
      putStrLn "Cannot inspect that!"
      runGame (loc, dir, items, objects, bag, gameContents, moveStates, introTexts)
  
  
  
  -- Take --
  else if action == "Take" then do 
    putStrLn "What would you like to take?"
    actionTake <- getLine
  
    if elem actionTake items == True
    then do 
      runGame (loc, dir, removeItem actionTake items, objects, actionTake:bag, removeContent actionTake gameContents, moveStates, introTexts)
  
    else do 
      putStrLn "Cannot take that!"
      runGame (loc, dir, items, objects, bag, gameContents, moveStates, introTexts)
  
  
  
  -- Use --
  else if action == "Use" then do 
    if bag == [""] && objects == [""] then do 
      putStrLn "There is nothing to use."
    else if bag == [""] && objects /= [""] then do 
      putStrLn (unlines (["","In your bag is: ", "Nothing in perticular","", "You see: "] ++ objects))
    else if bag /= [""] && objects == [""] then do 
      putStrLn "You cannot use anyting at the moment."
    else do 
      putStrLn "What would you like to use?"
      putStrLn ((unlines bag) ++ (unlines objects))
    
    actionUse <- getLine

    if elem actionUse objects == True then do
    putStrLn (unlines (eventDesc loc actionUse))

    runGame (loc, getMoves loc (changeBool loc moveStates), items, objects, bag, gameContents, changeMoveState loc moveStates, introTexts)

  --else if elem actionUse bag == True then do
  --  putStrLn ("What would you like to use " ++ actionUse ++ " on?")
  --  putStrLn (unlines objects)
  --  useOn <- getLine
  ----if elem useOn objects == True then do
  ----
  ----runGame (loc, changeBool loc, items, objects, bag)
  ----else putStrLn ("Cannot use " ++ actionUse ++ " on " ++ useOn ++ ".")
  
    else do putStrLn ("Wrong input.")
    runGame (loc, dir, items, objects, bag, gameContents, moveStates, introTexts)



  -- Move --
  else if action == "Move" then do 
    if dir == [] then do
    putStrLn "You have nowhere to go right now."
    runGame (loc, dir, items, objects, bag, gameContents, moveStates, introTexts)
    else do
    putStrLn (unlines ["Where would you like to go?"])
    putStrLn (unlines (getMovesText loc moveStates))
    input <- getLine
  
    if input == "" then do 
    putStrLn ("wrong input: '" ++ input ++ "' is not valid.")
    runGame (loc, dir, items, objects, bag, gameContents, moveStates, introTexts)
    
    else if elem (flatten (checkRoom loc input moveStates)) dir then do
    runGame (takeSecond (checkRoom loc input moveStates), getMoves (takeSecond (checkRoom loc input moveStates)) moveStates, roomItem (takeSecond (checkRoom loc input moveStates)), roomObject (takeSecond (checkRoom loc input moveStates)), bag, gameContents, moveStates, introTexts)
  
    else do
    putStrLn "That is not possible right now."
    runGame (loc, dir, items, objects, bag, gameContents, moveStates, introTexts)
  

  
  -- Error message if wrong input --
  
  else do
    putStrLn ("wrong input: '" ++ action ++ "' is not valid.")
    runGame (loc, dir, items, objects, bag, gameContents, moveStates, introTexts)





---- Starts the game ----





startGame :: IO ()
startGame = do
  putStrLn (unlines ["----------------------------------------------------"])
  putStrLn " "
  putStrLn (unlines (snd (textList!!0)))
  putStrLn " "
  runGame start -- Calls the game with starting values
  return ()



import GameContents
import Texts
import Data.List
import Data.Char
import System.Exit
import System.Random

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


    





start :: Game
start = (startLoc, getMoves startLoc startMoveStates, roomItem startLoc,roomObject startLoc, startBag, startContents, startMoveStates, startTexts) 
startLoc = 1
startBag= [""]
startContents = contentList
startMoveStates = moveList
startTexts = textList

actions :: [String]
actions = ["- Inspect", "- Take", "- Use", "- Move", "- Quit"]






------ Game loop ------

runSphinx :: Game -> IO ()
runSphinx (loc, dir, items, objects, bag, gameContents, moveStates, introTexts) = do
 putStrLn ("I will give you two guesses. If you cannot guess correctly, I will have you for dinner.")
 gen <- newStdGen
 let num = fst (randomR (0,9) gen)
 let riddle = sphinxList!!num
 putStrLn (unlines (tail riddle))
 answer <- getLine
 if elem answer [(head riddle)] == False then do
 putStrLn ("You have one more guess.")
 answer2 <- getLine
 if elem answer2 [(head riddle)] == True then do
 putStrLn ("Good guess. You may pass.")
 runGame (12, getMoves 12 moveStates, roomItem 12, roomObject 12, bag, gameContents, moveStates, introTexts)
 else do runSphinxDeath
 else do
 putStrLn ("Good guess. You may pass.")
 runGame (12, getMoves 12 moveStates, roomItem 12, roomObject 12, bag, gameContents, moveStates, introTexts)


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
    exitSuccess
  
  
  -- Inspect --
    
  else if action == "Inspect" then do 
    putStrLn "What would you like to inspect?"
    putStrLn ((unlines items) ++ (unlines objects))
    actionInspect <- getLine
    if elem actionInspect items == True then do
      putStrLn (unlines (itemDesc loc actionInspect))
      runGame (loc, dir, items, objects, bag, gameContents, moveStates, introTexts)
    else if elem actionInspect objects == True then do
    if actionInspect == "Self" then do
      putStrLn (unlines(selfText))
      runGame (loc, dir, items, objects, bag, gameContents, moveStates, introTexts)
    else do
      putStrLn (unlines (objectDesc loc actionInspect))
      runGame (loc, dir, items, objects, bag, gameContents, moveStates, introTexts)
    else do
      putStrLn "Cannot inspect that!"
      runGame (loc, dir, items, objects, bag, gameContents, moveStates, introTexts)
  
  
  
  -- Take --
  else if action == "Take" then do 
    putStrLn "What would you like to take?"
    putStrLn (unlines items)
    actionTake <- getLine
    if actionTake == "White gem" then do
    runRedDeath
    else if elem actionTake items == True
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
    if actionUse == "Sphinx" then do
      runSphinx (loc, dir, items, objects, bag, gameContents, moveStates, introTexts)
    else if actionUse == "Sphinx" then do
      runFinish
    else do
    let useOn = ""
    if checkEvent loc actionUse useOn == True then do
    putStrLn (unlines (eventDesc loc actionUse useOn))
    runGame (loc, getMoves loc (changeMoveState loc moveStates), items, objects, bag, gameContents, changeMoveState loc moveStates, introTexts)
    else do putStrLn ("Cannot use " ++ actionUse ++".")
    runGame (loc, dir, items, objects, bag, gameContents, moveStates, introTexts)
    --runGame (loc, getMoves loc (changeMoveState loc moveStates), items, objects, bag, gameContents, changeMoveState loc moveStates, introTexts)

    else if elem actionUse bag == True then do
    putStrLn ("What would you like to use " ++ actionUse ++ " on?")
    putStrLn (unlines objects)
    useOn <- getLine
    --if elem useOn objects == True then do
    if checkEvent loc useOn actionUse == True then do
    putStrLn (unlines (eventDesc loc useOn actionUse))
    runGame (loc, getMoves loc (changeMoveState loc moveStates), items, objects, removeItem actionUse bag, gameContents, changeMoveState loc moveStates, introTexts)
  
    else do putStrLn ("Cannot use " ++ actionUse ++ " on " ++ useOn ++ ".")
    runGame (loc, dir, items, objects, bag, gameContents, moveStates, introTexts)
    
    --else do putStrLn ("Cannot use " ++ actionUse ++ " on " ++ useOn ++ ".")

    else do putStrLn ("Wrong input.")
    runGame (loc, dir, items, objects, bag, gameContents, moveStates, introTexts)



  -- Move --
  else if action == "Move" then do 
    if dir == [] then do
    putStrLn "You have nowhere to go right now."
    runGame (loc, dir, items, objects, bag, gameContents, moveStates, introTexts)
    else do
    putStrLn (unlines ["Where would you like to go? (Hit Enter if nowhere)"])
    putStrLn (unlines (getMovesText loc moveStates))
    input <- getLine
  
    if input == "" then do 
    putStrLn ("wrong input: '" ++ input ++ "' is not valid.")
    runGame (loc, dir, items, objects, bag, gameContents, moveStates, introTexts)
    
    else if elem (checkMove loc input moveStates) dir then do
    runGame ((getNewRoom loc input moveStates), getMoves (getNewRoom loc input moveStates) moveStates, roomItem (getNewRoom loc input moveStates), roomObject (getNewRoom loc input moveStates), bag, gameContents, moveStates, introTexts)
  
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


---- Completes the game ----

runFinish :: IO ()
runFinish = do
  putStrLn (unlines(["You step through the mirror and end up infront of the castle.", "You turn around but can't see the passage you came from.", "Right before your eyes the castle starts to vanish."]))
  putStrLn (unlines(["Congratulations! You have completed the game.", "Want to play again? (Y,N)"]))
  action <- getLine
  if action == "Y" then do
  runGame start
  else if action == "N" then do
  exitSuccess
  else do putStrLn ("Not a valid input. Answer with Y or N.")

---- Death scenes ----

runRedDeath :: IO ()
runRedDeath = do
  putStrLn (unlines(["\"The door closed!? This is bad! REALLY BAD!\" you shout out.", " ", "A red, thin wall-like structure is coming towards you very slowly. You try touching it but it immediately burns away the tip of your finger.", "You realize immediately what's happening and that there is no escape.", " ", "You are Dead. Want to try again? (Y,N)"]))
  action <- getLine
  if action == "Y" then do
  runGame start
  else if action == "N" then do
  exitSuccess
  else do putStrLn ("Not a valid input. Answer with Y or N.")
  
  
  
runSphinxDeath :: IO ()
runSphinxDeath = do
  putStrLn (unlines(["The Sphinx throws itself onto you. As you feel it's jaw crushing your neck, everything gets dark.", "You are Dead. Want to try again? (Y,N)"]))
  action <- getLine
  if action == "Y" then do
  runGame start
  else if action == "N" then do
  exitSuccess
  else do putStrLn ("Not a valid input. Answer with Y or N.")
  

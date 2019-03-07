import GameContents
import Texts
import Data.List
import Data.Char
import System.Exit
import System.Random

-- Rooms --

{- The Game datatype represents your game state, in other words: It represent where you are in the game.
Your gamestate is determined by which room you are in, the current availible PossibleDirections , what different Objects and Items that exists in your current room, what items you currently have on you and Introtexts. 
INVARIANT: All RoomNumber, PossibleDirections, Items, Objects, Bag, Contents, MoveStates and IntroTexts that currently exists in the game-}

type Game = (RoomNumber, PossibleDirections, Items, Objects, Bag, Contents, MoveStates, IntroTexts)

{- The datatype Roomnumber represents the numbering of the rooms. 
It represents each rooms number with an integer. 
Invariant: Integers 1-18 -}

type RoomNumber = Integer


{-The datatype PossibleDirections represents every direction you could possibly move in from the room you are currently located in. 
PossibleDirections is represented by a list of quadruples containing 2 different RoomNumbers, a Description type and a Bool value
Invariant: RoomNumber, RoomNumber, Description, Bool -}

type PossibleDirections = [(RoomNumber, RoomNumber, Description, Bool)]

{- The datatype Description represents a description for a specific PointOfInterests or a room. 
Description is represented by a string. 
INVARIANT: A list of all PointOfInterests and rooms that exists in the game. 
-}

type Description = String

{- The datatype Items represents items in the game. 
Items is represented by a list of strings that corresponds to the items names. 
INVARIANT: A list of all the items that exists in the game. -}

type Items = [String]

{- The datatype Objects represents objects in the game
Objects is represented by a list of strings that corresponds to the objects names. 
INVARIANT: A list of the possible objects in the game. -}

type Objects = [String]

{- The datatype Bag represents the items that you are currently holding.
Bag is represented by a list of strings that corresponds to the names of items.
INVARIANT: A list of the names of all the items that exists in the game. 
-}
type Bag = [String]

{-The datatype Contents represents relevant details of all the rooms
Contents is represented with a list of quadruples containing -}

type Contents = [(RoomNumber, Integer, String, Bool)]

{- The datatype MoveStates represents which rooms that are possible to move to from the room your are currently in. 
MoveStates is represented by a list of quadruples that contains your current roomnumber, a roomnumber of a room adjacent to your current room, a description of the adjacant room and a boolean value that determines if you have been in the adjacent room before or not. 
INVARIANT: All roomnumbers that exists in the game and their corresponding Description. -}

type MoveStates = [(RoomNumber, RoomNumber, Description, Bool)]

{- The datatype IntroTexts represents which rooms you have entered before and the descriptions of the rooms. 
IntroTexts is represented by a a list of touples containing a boolean value which states whether you have been in the room before or not and a Description corresponding to that specific room. 
INVARIANT: A list of all descriptions that currently exists in the game. -}

type IntroTexts = [(Bool, [Description])]


    

{- start
Sets the gamestate to its initial values, in other words, starts the game from the beginning. 
PRE: true
RETURNS: Returns the datatype Game with a pretedermined set of values.
EXAMPLES: start = (startLoc, getMoves startLoc startMoveStates, roomItem startLoc,roomObject startLoc, startBag, startContents, startMoveStates, startTexts)
-}

start :: Game
start = (startLoc, getMoves startLoc startMoveStates, roomItem startLoc startContents, roomObject startLoc startContents, startBag, startContents, startMoveStates, startTexts) 
startLoc = 1
startBag= [""]
startContents = contentList
startMoveStates = moveList
startTexts = textList

{- actions 
Lists up the different actions that the player will be able to make. 
PRE: True
RETURNS: Returns a list of five strings. 
EXAMPLES: actions = ["- Inspect", "- Take", "- Use", "- Move", "- Quit"]
-}

actions :: [String]
actions = ["- Inspect", "- Take", "- Use", "- Move", "- Quit"]






------ Game loop ------

{- runGame 
Updates the gamestate with new values.
PRE: true
-}

runGame :: Game -> IO () 
runGame (loc, dir, items, objects, bag, gameContents, moveStates, introTexts) = do
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
    else if bag /= [""] && objects == [""] then do 
      putStrLn "You cannot use anyting at the moment."
    else do 
      putStrLn "What would you like to use?"
      putStrLn ((unlines bag) ++ (unlines objects))
    
    actionUse <- getLine

    if elem actionUse objects == True then do
    if actionUse == "Self" then do
    putStrLn "You cannot use yourself. But maybe you can use an item on you?"
    else if actionUse == "Sphinx" && loc == 10 then do
      runSphinx (loc, dir, items, objects, bag, gameContents, moveStates, introTexts)

    else if actionUse == "Mirror" && loc == 13 then do
      runFinish
    else do
    let useOn = ""
    if checkEvent loc actionUse useOn == True then do
    putStrLn (unlines (eventDesc loc actionUse useOn))
    runGame (loc, getMoves loc (changeMoveState loc moveStates), items, objects, bag, gameContents, changeMoveState loc moveStates, introTexts)
    else do putStrLn ("Cannot use " ++ actionUse ++".")
    runGame (loc, dir, items, objects, bag, gameContents, moveStates, introTexts)
    

    else if elem actionUse bag == True then do
    putStrLn ("What would you like to use " ++ actionUse ++ " on?")
    putStrLn (unlines objects)
    useOn <- getLine
    
    if checkEvent loc useOn actionUse == True then do
    putStrLn (unlines (eventDesc loc useOn actionUse))
    runGame (loc, getMoves loc (changeMoveState loc moveStates), items, objects, removeItem actionUse bag, gameContents, changeMoveState loc moveStates, introTexts)
    else do putStrLn ("Cannot use " ++ actionUse ++ " on " ++ useOn ++ ".")
    runGame (loc, dir, items, objects, bag, gameContents, moveStates, introTexts)
    
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
  
    --if input == "" then do 
    if elem (checkMove loc input moveStates) dir == False then do
    putStrLn ("wrong input: '" ++ input ++ "' is not valid.")
    runGame (loc, dir, items, objects, bag, gameContents, moveStates, introTexts)
    
    else if elem (checkMove loc input moveStates) dir == True then do
    runGame ((getNewRoom loc input moveStates), getMoves (getNewRoom loc input moveStates) moveStates, roomItem (getNewRoom loc input moveStates) gameContents, roomObject (getNewRoom loc input moveStates) gameContents, bag, gameContents, moveStates, introTexts)
  
    else do
    putStrLn "That is not possible right now."
    runGame (loc, dir, items, objects, bag, gameContents, moveStates, introTexts)
  

  
  -- Error message if wrong input --
  
  else do
    putStrLn ("wrong input: '" ++ action ++ "' is not valid.")
    runGame (loc, dir, items, objects, bag, gameContents, moveStates, introTexts)





---- Starts the game ----

{- startGame
PRE: true
RETURNS: Returns a string line, the function "start" and the function runGame. 
EXAMPLES: startGame = do
  putStrLn (unlines ["----------------------------------------------------"])
  putStrLn (unlines (snd (textList!!0)))
  runGame start 
  return ()
-}

startGame :: IO ()
startGame = do
  putStrLn (unlines ["----------------------------------------------------"])
  putStrLn (unlines (snd (textList!!0)))
  runGame start -- Calls the game with starting values
  return ()



---- Sphinx scene ----

{- runSphinx 
runSphinx starts an event in the game involving a mythical creature known as the Sphinx. 
PRE: true
RETURNS: Returns a string line and Game with new values, both depending on the choices the player makes. 
EXAMPLES: runSphinx = "I will give you two guesses. If you cannot guess correctly, I will have you for dinner."
-}

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
 runGame (12, getMoves 12 moveStates, roomItem 12 gameContents, roomObject 12 gameContents, bag, gameContents, moveStates, introTexts)
 else do runSphinxDeath
 else do
 putStrLn ("Good guess. You may pass.")
 runGame (12, getMoves 12 moveStates, roomItem 12 gameContents, roomObject 12 gameContents, bag, gameContents, moveStates, introTexts)




---- Completes the game ----

{- runFinish
runFinish starts the final event of the game and lets the player choose if they want to play again or not. 
PRE: true 
RETURNS: Returns either "runGame start", "exitSuccess" or putStrLn ("Not a valid input. Answer with Y or N."). 
EXAMPLES: runFinish = "You step through the mirror and end up infront of the castle.", "You turn around but can't see the passage you came from.", "Right before your eyes the castle starts to vanish."
-}

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

{- runRedDeath
runRedDeath runs the gamestate through one of the death endings and lets the player choose if they want to play again or not. 
PRE: true
RETURNS: Returns a text and a new game state. 
EXAMPLES: runRedDeath = "Not a valid input. Answer with Y or N."
-}

runRedDeath :: IO ()
runRedDeath = do
  putStrLn (unlines(["\"The door closed!? This is bad! REALLY BAD!\" you shout out.", " ", "A red, thin, wall-like structure is coming towards you very slowly. You try touching it but it immediately burns away the tip of your finger.", "You realize immediately what's happening and that there is no escape.", " ", "You are Dead. Want to try again? (Y,N)"]))
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
  

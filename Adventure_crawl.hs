-- Bara några exempel --

data Action = Inspect | Take | Use | Move | Hit | Open

type Bag = [Item]

type Map = [Room]
type Room = [RoomNumber, PossibleDirections, Description, PointOfInterest]
type RoomNumber = Int
type Description = String
type Item = String
type PointOfInterest = [(Item, Bool)]
type PossibleDirections = [Door]
type Door = [Int, Bool, Bool] -- Int is the index (of doors in room). First Bool is for whether it is open, second if it is locked.
type Chest = [Bool, Bool]



-- Edge list av alla rum --
[(1, 2),
(2, 1),(2, 3),(2, 7),
(3, 2),(3, 4),
(4, 3),(4, 5),(4, 6),
(5, 4),
(6, 4),(6, 13),
(7, 2),(7, 8),
(8, 7),(8, 9),(8, 11),
(9, 8),(9, 10),
(10, 9),
(11, 8),(11, 12),
(12, 11),
(13, 6),(13, 14),(13, 15),
(14, 13),
(15, 13),(15, 16),
(16, 15),(16, 17),
(17, 16),(17, 18),
(18, 17)]

start (

runIntro = putStr ( unlines list)
  where list = ["Finally, after many years of searching, you are now standing in front of it.", "To think that there was something, either some sort of a force field, or even stranger, a magic field that could hide it.","I will definitely discover something amazing here!"] 

startGame :: IO ()
startGame = do
  runIntro
  runGame start





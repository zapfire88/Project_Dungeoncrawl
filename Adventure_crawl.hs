-- Bara några exempel --

data Action = Inspect | Take | Use | Move | Hit | Speak | Open

type Map = [Room]
type Room = [Number, PossibleDirections, Description, Item, PointOfInterest]
type Number = Int
type Description = String
type Item = String
type PointOfInterest = String
type PossibleDirections = [(Number, Number)]

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


-- Bara några exempel --

data Action = Inspect | Take | Use | Move | Hit | Speak | Open

type Map = [Room]
type Room = [Name, Description, Item, PointOfInterest, PossibleDirections]
type Name = String
type Description = String
type Item = String
type PointOfInterest = String
type PossibleDirections = [String]



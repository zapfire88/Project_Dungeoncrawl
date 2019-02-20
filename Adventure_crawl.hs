

data Action = Inspect | Take | Use | Move | Hit | Speak | Open

type Map = [Room]
type Room = [Description, Item, PointOfInterest]
type Description = String
type Item = String
type PointOfInterest = String




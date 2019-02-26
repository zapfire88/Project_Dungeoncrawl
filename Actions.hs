
module Actions(inspect, take, use, move, hit)
where
-- Actions --

inspect :: PointOfInterest -> IO String -> PointOfInterest -> String


take :: PointOfInterest -> IO String -> PointOfInterest -> Bag


use :: Item -> PointOfInterest -> String


move :: Room -> IO String -> Room


hit :: PointOfInterest -> IO String -> PointOfInterest -> String



 




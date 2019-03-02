
module Texts(textList)
where
-- Introduction --

textList = [runIntro, runRoom1, runRoom2, runRoom3, runRoom4, runRoom5, runRoom6, runRoom7, runRoom8, runRoom9, runRoom10, runRoom11, runRoom12, runRoom13, runRoom14, runRoom15, runRoom16, runRoom17, runRoom18]

runIntro = putStr (unlines list)
  where list = ["The stories tell about a secret castle, hidden to the naked eye.", "Finally, after many years of searching, you are now standing in front of it.","To think that there was something, either some sort of a force field, or even stranger, a magic field that could hide it.", "You will definitely discover something amazing here!"] 
 


-- Room 1 --

runRoom1 = putStr (unlines list)
  where list = ["The castle is protected by a big stone wall surrounding it.", "You get a strange feeling standing in front of it. There might be traps in here, so you need to be careful.", "There is a large door in front of you, but it has no handle."]



-- Room 2 --

runRoom2 = putStr (unlines list)
   where list = ["As soon as you have entered the door slams shut.","This has to be the biggest hallway you have ever seen.", "There are several torches stuck to the wall lighting up the room, and there are ornaments everywhere.", "There is one torch next to you that is giving of a weird light.", "Although hot, it seems as if it is not fire. It does not seem to be stuck so you should probably take it with you.", "There are two closed doors. One straight ahead, and one to the right."]

-- Room 3 --
runRoom3 = putStr (unlines list)
  where list = ["A short corridor. There is a painting on the left side and a big banner to the right.", "At the end of the corridor is a closed door."]

-- Room 4 --
runRoom4 = putStr (unlines list)
  where list = ["Another big room, looks like a lounge.", "There are some chairs around a table and a big unlit fireplace.", "There is a a closed door on the other side of the room."]

-- if player use torch on fireplace, a secret door opens --
runHappeningRoom4 = putStr (unlines list)
  where list = ["A secret door? Maybe there are more of these!"]

-- Room 5 --
runRoom5 = putStr (unlines list)
  where list = ["There is a chest in here. Maybe it contains something useful?"]

-- Room 6 --
runRoom6 = putStr (unlines list)
  where list = ["This room's ceiling is very high up. Nothing special in here except the big opening that's very high up.", "I could climb up there if I had some help."]

-- Room 7 --
runRoom7 = putStr (unlines list)
  where list = ["A big cave in a castle? This is getting stranger by the second.", "Next to me is a piedestal with a small socket. The bridge is opened, so I can't cross.", "Maybe I can lower it by inserting something into the socket?"]

-- if player inserts yellow gem into socket --
runHappeningRoom7 = putStr (unlines list)
  where list = ["The bridge is lowered! Maybe the gem holds some sort energy?"]

-- Room 8 --
runRoom8 = putStr (unlines list)
  where list = ["Insert texts"]

-- Room 9 --
runRoom9 = putStr (unlines list)
  where list = ["Insert texts"]

-- Room 10 --
runRoom10 = putStr (unlines list)
  where list = ["Hmm. There are two pedestals in this room. One with something shimmering on it, the other with a white gem.", "I get a weird feeling from this, maybe there is a trap?"]

-- taking the shimmering coat --
runOption1Room10 = putStr (unlines list)
  where list = ["Phue! Nothing seems to have happened!", "Seems like a coat of some sort! I wonder what is making it shimmer and why?"]

-- taking the white gem --
runOption2Room10 = putStr (unlines list)
  where list = ["\"The door closed!? This is bad! REALLY BAD!\" you shout out.", " ", "A red, thin wall-like structure is coming towards you very slowly. You try touching it but it immediately burns away the tip of your finger.", "You realize immediately what's happening and that there is no escape.", " ", "You are Dead. Try again"]

-- Room 11 --
runRoom11 = putStr (unlines list)
  where list = ["A big room with a door on the other side. Something shimmering is blocking the way."]

-- Room 12 --
runRoom12 = putStr (unlines list)
  where list = ["A very small room. There is a pedestal with a scroll laying on top of it."]

-- Room 13 --
runRoom13 = putStr (unlines list)
  where list = ["Insert texts"]

-- Room 14 --
runRoom14 = putStr (unlines list)
  where list = ["Insert texts"]

-- Room 15 --
runRoom15 = putStr (unlines list)
  where list = ["Insert texts"]

-- Room 16 --
runRoom16 = putStr (unlines list)
  where list = ["Insert texts"]

-- Room 17 --
runRoom17 = putStr (unlines list)
  where list = ["Insert texts"]

-- Room 18 --
runRoom18 = putStr (unlines list)
  where list = ["Insert texts"]

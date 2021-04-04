module ErrorHandling exposing (..)


type MaybeAge
    = Age Int
    | InvalidInput


toAge : String -> MaybeAge
toAge userInput =
    if String.all Char.isDigit userInput then
        Age (Maybe.withDefault 0 (String.toInt userInput))

    else
        InvalidInput

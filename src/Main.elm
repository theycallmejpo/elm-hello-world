module Main exposing (..)

import Browser
import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)



-- MAIN


main =
    Browser.sandbox { init = state, update = update, view = view }


type alias Model =
    Int


state : Model
state =
    0



-- UPDATE


type Msg
    = Increment
    | Decrement
    | Reset
    | IncrementByTen


update : Msg -> Model -> Model
update msg model =
    case msg of
        Increment ->
            model + 1

        Decrement ->
            model - 1

        Reset ->
            0

        IncrementByTen ->
            model + 10



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ button [ onClick Decrement ] [ text "-" ]
        , div [] [ text (String.fromInt model) ]
        , button [ onClick Increment ] [ text "+" ]
        , button [ onClick Reset ] [ text "Reset" ]
        , button [ onClick IncrementByTen ] [ text "+10" ]
        ]

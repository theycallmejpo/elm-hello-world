module CelsiusToFarenheit exposing (..)

import Browser
import Html exposing (Attribute, Html, div, input, span, text)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)



-- MAIN


main =
    Browser.sandbox { init = init, update = update, view = view }



-- MODEL


type alias Model =
    { input : String
    , farenheitInput : String
    , inchesInput : String
    }


init : Model
init =
    { input = ""
    , farenheitInput = ""
    , inchesInput = ""
    }



-- UPDATE


type Msg
    = Change String
    | ChangeFarenheit String


update : Msg -> Model -> Model
update msg model =
    case msg of
        Change newInput ->
            { model | input = newInput }

        ChangeFarenheit newInput ->
            { model | farenheitInput = newInput }



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ celsiusToFarenheit model.input
        , farenheitToCelsius model.farenheitInput
        ]


celsiusToFarenheit : String -> Html Msg
celsiusToFarenheit userInput =
    case String.toFloat userInput of
        Just celsius ->
            viewConverter userInput Change "blue" "black" (String.fromFloat (celsius * 1.8 + 32))

        Nothing ->
            viewConverter userInput Change "red" "red" "???"


farenheitToCelsius : String -> Html Msg
farenheitToCelsius userInput =
    case String.toFloat userInput of
        Just farenheit ->
            viewConverter userInput ChangeFarenheit "blue" "black" (String.fromFloat ((farenheit - 32) / 9 * 5))

        Nothing ->
            viewConverter userInput ChangeFarenheit "red" "red" "???"


viewConverter : String -> (String -> msg) -> String -> String -> String -> Html Msg
viewConverter userInput change color inputBorderColor equivalentTemp =
    div []
        [ input
            [ value userInput
            , onInput change
            , style "width" "40px"
            , style "borderColor" inputBorderColor
            ]
            []
        , text "°C = "
        , span [ style "color" color ] [ text equivalentTemp ]
        , text "°F"
        ]


inputBox : String -> Html Msg
inputBox userInput = 
    div []
        [ input
            [ value userInput
            , onInput 

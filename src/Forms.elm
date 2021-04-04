module Forms exposing (..)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)



-- MAIN


main =
    Browser.sandbox { init = init, update = update, view = view }



-- MODEL


type alias Model =
    { name : String
    , password : String
    , passwordAgain : String
    }


init : Model
init =
    Model "" "" ""



-- UPDATE


type Msg
    = Name String
    | Password String
    | PasswordAgain String


update : Msg -> Model -> Model
update msg model =
    case msg of
        Name name ->
            { model | name = name }

        Password password ->
            { model | password = password }

        PasswordAgain password ->
            { model | passwordAgain = password }



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ viewInput "text" "Name" model.name Name
        , viewInput "password" "Password" model.password Password
        , viewInput "password" "Re-enter Password" model.passwordAgain PasswordAgain
        , viewValidation model
        ]


viewInput : String -> String -> String -> (String -> msg) -> Html msg
viewInput t p v toMsg =
    input [ type_ t, placeholder p, value v, onInput toMsg ] []


viewValidation : Model -> Html msg
viewValidation model =
    if model.password == "" || model.passwordAgain == "" then
        div [] []

    else if not (model.password == model.passwordAgain) then
        div [ style "color" "red" ] [ text "Passwords don't match" ]

    else if String.length model.password < 8 then
        div [ style "color" "red" ] [ text "Password needs to be 8 or more characters" ]

    else if not (String.any Char.isDigit model.password) then
        div [ style "color" "red" ] [ text "Password needs to have a digit" ]

    else if not (String.any Char.isUpper model.password) then
        div [ style "color" "red" ] [ text "Password needs an upper case" ]

    else if not (String.any Char.isLower model.password) then
        div [ style "color" "red" ] [ text "Password needs an lower case" ]

    else
        div [ style "color" "green" ] [ text "OK" ]

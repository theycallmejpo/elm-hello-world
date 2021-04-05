module RandomTest exposing (..)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Random



-- MAIN


main =
    Browser.element
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }



-- MODEL


type alias Model =
    Spin


init : () -> ( Model, Cmd Msg )
init _ =
    ( Spin 0 0
    , Random.generate NewFace spin
    )



-- UPDATE


type Msg
    = Roll
    | NewFace Spin


type alias Spin =
    { one : Int
    , two : Int
    }


roll : Random.Generator Int
roll =
    Random.int 1 6


spin : Random.Generator Spin
spin =
    Random.map2 Spin roll roll


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Roll ->
            ( model
            , Random.generate NewFace spin
            )

        NewFace newFace ->
            ( newFace
            , Cmd.none
            )



-- Subscriptions


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ img [ src (diceURL model.one) ] []
        , img [ src (diceURL model.two) ] []
        , button [ onClick Roll ] [ text "Roll" ]
        ]


diceURL : Int -> String
diceURL dieFace =
    "http://roll.diceapi.com/images/poorly-drawn/d6/"
        ++ String.fromInt dieFace
        ++ ".png"

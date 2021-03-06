module Main exposing (..)

import Dict exposing (get)
import Html exposing (Html, a, div, figure, figcaption, img, strong, span, text)
import Html.Attributes exposing (alt, href, id, src)
import Navigation
import String.Extra exposing (rightOf)


main =
    Navigation.program UrlChange
        { init = init
        , view = view
        , update = update
        , subscriptions = (\_ -> Sub.none)
        }



-- LANGUAGE


type alias Language =
    { lead : String
    , full : String
    }


addLanguage : String -> String -> Language
addLanguage lead full =
    Language lead full


accessLanguage : Maybe Language -> Language
accessLanguage l =
    case l of
        Just language ->
            language

        Nothing ->
            Dict.get "se" languages
                |> accessLanguage


languages =
    Dict.fromList
        [ ( "se"
          , addLanguage
                "Det blev ingen cd."
                "Några 15-åringar från Domarhagsskolan tänkte kolla in cd-skivor under lunchrasten. Men affären de gick till hade stängt. Från vänster står Alfredo Pettersson, Richard Knöös, Tommy Carlberg, Mattias Persson och Max Malmström."
          )
        , ( "dk"
          , addLanguage
                "Der blev ingen cd."
                "Nogle 15-årige drenge fra Domarhagsskolen tænkte at se på nogle cd'er i frokostpausen. Men butikken de gik til var lukket. Fra venstre står Alfredo Pettersson, Richard Knöos, Tommy Carlberg, Mattias Persson og Max Malmström."
          )
        , ( "us"
          , addLanguage
                "They didn't get any cd."
                "A few 15 year old boys from Domarhagsskolan were going to check out CD's during the lunch break. But the store they went to was closed. Standing from the left; Alfredo Pettersson, Richard Knöös, Tommy Carlberg, Mattias Persson and Max Malmström."
          )
        , ( "de"
          , addLanguage
                "Sie erhielten kein cd."
                "Einige 15 jahre alte jungen von Domarhagsskolan waren im begriff, aus CD's während der mittagspause zu überprüfen. Aber der speicher gingen sie zu waren geschlossen. Stehen vom links; Alfredo Pettersson, Richard Knöös, Tommy Carlberg, Mattias Persson und Max Malmström."
          )
        , ( "fr"
          , addLanguage
                "Ils n'ont obtenu aucun cd."
                "Quelques 15 années de garçons de Domarhagsskolan allaient vérifier CD's pendant la pause de midi. Mais le magasin elles sont allées à étaient fermées. Se tenir de la gauche ; Alfredo Pettersson, Richard Knöös, Tommy Carlberg, Mattias Persson, Max Malmström."
          )
        , ( "es"
          , addLanguage
                "No consiguieron ningún cd."
                "Algunos 15 años de viejos muchachos de Domarhagsskolan iban a comprobar fuera de CD's durante la hora de la almuerzo. Pero el almacén fueron a eran cerrados. El estar parado de la izquierda; Alfredo Pettersson, Richard Knöös, Tommy Carlberg, Mattias Persson y Max Malmström."
          )
        ]



-- MODEL


type alias Model =
    { lang : String }


model : Model
model =
    { lang = "" }


init : Navigation.Location -> ( Model, Cmd Msg )
init location =
    ( Model (rightOf "#" location.hash), Cmd.none )



-- UPDATE


type Msg
    = UrlChange Navigation.Location


update : Msg -> Model -> ( Model, Cmd msg )
update msg model =
    case msg of
        UrlChange location ->
            ( { model | lang = rightOf "#" location.hash }, Cmd.none )



-- VIEW


view : Model -> Html Msg
view model =
    let
        currentLang =
            Dict.get model.lang languages
                |> accessLanguage
    in
        div [ id "wrapper" ]
            [ a [ href "https://github.com/bombsimon/det-blev-ingen-cd.com" ]
                [ img
                    [ id "github-ribbon"
                    , src "https://s3.amazonaws.com/github/ribbons/forkme_right_darkblue_121621.png"
                    , alt "Fork me on GitHub!"
                    ]
                    []
                ]
            , figure []
                [ splashImage "splash.jpg"
                , div [ id "flags" ]
                    [ flagLink "se"
                    , flagLink "dk"
                    , flagLink "us"
                    , flagLink "de"
                    , flagLink "fr"
                    , flagLink "es"
                    ]
                , figcaption [ id "text " ]
                    [ strong [ id "lead" ] [ text currentLang.lead ]
                    , span [ id "separator" ] [ text " " ]
                    , span [ id "full" ] [ text currentLang.full ]
                    ]
                ]
            ]


splashImage : String -> Html Msg
splashImage source =
    img [ src source, id "splash", alt "" ] []


flagLink : String -> Html Msg
flagLink lang =
    a [ id lang, href ("#" ++ lang) ]
        [ img [ src ("flags/" ++ lang ++ ".png") ] []
        ]

module Main exposing (Model, Msg(..), init, update, view)

import Browser
import Browser.Navigation as Nav
import Html exposing (..)
import Html.Attributes exposing (..)
import Url
import NavBar as NavBar


-- MAIN
main : Program () Model Msg
main =
  Browser.application
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    , onUrlChange = UrlChanged
    , onUrlRequest = LinkClicked
    }



-- MODEL


type alias Model =
  { key : Nav.Key
  , url : Url.Url
  }


init : () -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init flags url key =
  ( Model key url, Cmd.none )



-- UPDATE


type Msg
  = LinkClicked Browser.UrlRequest
  | UrlChanged Url.Url


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
    LinkClicked urlRequest ->
      case urlRequest of
        Browser.Internal url ->
          ( model, Nav.pushUrl model.key (Url.toString url) )

        Browser.External href ->
          ( model, Nav.load href )

    UrlChanged url ->
      ( { model | url = url }
      , Cmd.none
      )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions _ =
  Sub.none



-- VIEW


view : Model -> Browser.Document Msg
view model =
  { title = "Charity Code - Helping Nonprofits find the development help they need!"
  , body =
      [ navBar
      ,text "The current URL is: "
      , b [] [ text (Url.toString model.url) ]
      , ul []
          [ viewLink "/home"
          , viewLink "/profile"
          , viewLink "/reviews/the-century-of-the-self"
          , viewLink "/reviews/public-opinion"
          , viewLink "/reviews/shah-of-shahs"
          ]
      ]
  }


navBar = 
    nav [ attribute "aria-label" "main navigation", class "navbar", attribute "role" "navigation" ]
    [ div [ class "navbar-brand" ]
        [ a [ class "navbar-item", href "#" ]
            [ img [ attribute "height" "28", src "https://bulma.io/images/bulma-logo.png", attribute "width" "112" ]
                []
            ]
        , a [ attribute "aria-expanded" "false", attribute "aria-label" "menu", class "navbar-burger burger", attribute "data-target" "navbarBasicExample", attribute "role" "button" ]
            [ span [ attribute "aria-hidden" "true" ]
                []
            , span [ attribute "aria-hidden" "true" ]
                []
            , span [ attribute "aria-hidden" "true" ]
                []
            ]
        ]
    , div [ class "navbar-menu", id "navbarBasicExample" ]
        [ div [ class "navbar-start" ]
            [ a [ class "navbar-item" ]
                [ text "Home      " ]
            , a [ class "navbar-item" ]
                [ text "Why      " ]
            , div [ class "navbar-item has-dropdown is-hoverable" ]
                [ a [ class "navbar-link" ]
                    [ text "More        " ]
                , div [ class "navbar-dropdown" ]
                    [ a [ class "navbar-item" ]
                        [ text "About          " ]
                    , a [ class "navbar-item" ]
                        [ text "Jobs          " ]
                    , a [ class "navbar-item" ]
                        [ text "Contact          " ]
                    , hr [ class "navbar-divider" ]
                        []
                    , a [ class "navbar-item" ]
                        [ text "Report an issue          " ]
                    ]
                ]
            ]
        , div [ class "navbar-end" ]
            [ div [ class "navbar-item" ]
                [ div [ class "buttons" ]
                    [ a [ class "button is-primary" ]
                        [ strong []
                            [ text "Sign up" ]
                        ]
                    , a [ class "button is-light" ]
                        [ text "Log in          " ]
                    ]
                ]
            ]
        ]
    ]

viewLink : String -> Html msg
viewLink path =
  li [] [ a [ href path ] [ text path ] ]
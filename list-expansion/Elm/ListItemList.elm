module ListItemList where

import ListItem
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

-- Model

type alias Model =
                 { listItems : List (ID, ListItem.Model)
                 , nextID : ID
                 }

type alias ID = Int

init : Model
init =
  { listItems = []
  , nextID = 0
  }

-- Update

type Action
  = Insert
  | Remove
  | Modify ID ListItem.Action

update : Action -> Model -> Model
update action model =
  case action of
    Insert ->
      let newListItem = ( model.nextID, ListItem.init 0 )
          newListItems = model.listItems ++ [ newListItem ]
      in
        { model |
            listItems = newListItems,
            nextID = model.nextID + 1
        }

    Remove ->
      { model | listItems = List.drop 1 model.listItems }

    Modify id listItemAction ->
      let updateListItem (listItemID, listItemModel) =
            if listItemID == id then
              (listItemID, ListItem.update listItemAction listItemModel)
            else
              (listItemID, listItemModel)
      in
        { model | listItems = List.map updateListItem model.listItems }

-- View

view : Signal.Address Action -> Model -> Html
view address model =
  let listItems = List.map (viewListItem address) model.listItems
      remove = button [ onClick address Remove ] [ text "Remove" ]
      insert = button [ onClick address Insert ] [ text "Add" ]
  in
    div [] ([remove, insert] ++ listItems)

viewListItem : Signal.Address Action -> (ID, ListItem.Model) -> Html
viewListItem address (id, model) =
  ListItem.view (Signal.forwardTo address (Modify id)) model

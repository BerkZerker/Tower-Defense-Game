# Human To-Do List

This file contains a detailed list of setup instructions for the scenes in the project. Anything that isn't code in a .gd script file should be done manually in the Godot editor.

## General Editor Steps

*   **Reload Scripts:** If you encounter "Could not find base class" errors after creating or renaming scripts, try manually reloading the scripts in the Godot editor. You can usually do this by going to "Project" -> "Reload Scripts" in the Godot editor menu.

## Verifications

### Scene Structure Verification in `game.tscn`
1.  **Open `game.tscn`**: Open the `scenes/game.tscn` scene in the Godot editor.
2.  **Verify UI Overlay Instantiation**: Ensure that `scenes/ui_overlay.tscn` is instantiated as a child of the `Game` node.
3.  **Verify GridManager Structure**: 
    *   Check for a `GridManager` node under `Game`.
    *   Under `GridManager`, verify that `TileMap` and `PlacementIndicator` nodes exist as children.

### Card Hand Path Verification
1.  **Open `game.gd`**: In the Godot editor, open `scripts/game.gd`.
2.  **Check `_ready()` Function**: Locate the `_ready()` function and verify the line: `card_hand = $UIOverlay/CardHand`.
3.  **Verify Path**: Ensure that `$UIOverlay/CardHand` correctly points to the `CardHand` node in your scene structure. Adjust the path in the script if it does not match your scene setup.

### Card Script Methods Verification
1. **Check `BaseCard.gd`**: Open `scripts/ui/cards/BaseCard.gd`.
2. **Verify `is_card()` Method**: Ensure the `is_card()` method exists and returns `true`.
3. **Verify `get_card_rect()` Method**: Ensure the `get_card_rect()` method exists and returns `Rect2(Vector2(0,0), size)`.

## Testing Card Dragging

1.  **Ensure `ui_overlay.tscn` is instantiated in `game.tscn`**: Verify that you have instantiated the `scenes/ui_overlay.tscn` scene as a child of the `Game` node in `game.tscn` as instructed previously and in the "Scene Structure Verification" section above.
2.  **Verify `CardHand` Path**: In `scripts/game.gd`, in the `_ready()` function, check if the path `$UIOverlay/CardHand` correctly references the `CardHand` node in your scene setup. Adjust the path if necessary and as verified in the "Card Hand Path Verification" section above.
3.  **Instantiate Cards in CardHand**:
    *   Open `scenes/ui/card_hand.tscn`.
    *   In the `CardContainer` (HBoxContainer) node, instantiate a few instances of `scenes/ui/cards/unit_card.tscn` or `scenes/ui/cards/spell_card.tscn` as children. You can do this by dragging and dropping the card scene from the FileSystem dock into the `CardContainer`.
4.  **Run `game.tscn`**: Run the `game.tscn` scene in the Godot editor.
5.  **Test Card Dragging**:
    *   Touch or click on a card in the card hand. The card should visually lift up (appear on top).
    *   Drag the input (mouse or touch). The selected card should follow your input within the card hand area.
    *   Release the input. The card should be "dropped" and return to its normal Z-index.
    *   Check the console output for "Card selected: [Card Name]" and "Card dropped" messages when you interact with the cards.

## Implementing Unit Placement Logic (Next Steps after Card Dragging Verification)

1. **Detect Card Drop Outside CardHand**: Implement logic in `game.gd` to detect when a dragged card is released (input release). Check if the release position is outside the bounds of the `CardHand` area.
2. **Get Grid Position**: If the card is dropped outside the `CardHand`, convert the screen/mouse position to grid coordinates using the `GridManager`.
3. **Validate Placement**: Use the `GridManager` to validate if the calculated grid position is a valid placement location. This will likely involve checking the `valid_placement` custom data layer in the TileSet.
4. **Instantiate Unit Scene**: If the placement is valid, instantiate the unit scene corresponding to the dragged card at the validated grid position on the TileMap.

## Scenes

### 1. game.tscn

*   **Instantiate UI Overlay:**
    *   Instantiate the `scenes/ui_overlay.tscn` scene as a child of the `Game` node in `game.tscn`. This will add the UI elements, including the `CardHand`, to the game scene.
*   **TileMapLayer:**
    *   Create a TileSet resource.
    *   Add a TileMapLayer node as a child of GridManager.
    *   Assign the TileSet resource to the TileMapLayer's `tile_set` property.
    *   **TileSet Setup:**
        *   Open the TileSet resource in the TileSet editor.
        *   Add a new custom data layer named `valid_placement` of type `bool`.
        *   For each tile that should be a valid unit placement cell, set the `valid_placement` custom data to `true`. Leave it `false` or unset for invalid placement tiles.
    *   Create a tileset in the tileset editor.
*   **MainTower:**
    *   Add a Sprite2D node as a child of MainTower.
    *   Assign a texture to the Sprite2D node.
    *   Add a CollisionShape2D node as a child of MainTower.
    *   Assign a RectangleShape2D resource to the CollisionShape2D node's `shape` property.
    *   Adjust the size of the RectangleShape2D to match the tower's sprite.
*   **SpawnPoints:**
    *   Add Marker2D nodes as children of the SpawnPoints node.
    *   Position the Marker2D nodes to define the enemy spawn locations.

### 2. base_unit.tscn

*   **Unit (CharacterBody2D):**
    *   Add a Sprite2D node as a child.
    *   Assign a texture to the Sprite2D node.
    *   Add a CollisionShape2D node as a child.
    *   Assign a CircleShape2D resource to the CollisionShape2D node's `shape` property.
    *   Adjust the radius of the CircleShape2D to match the unit's sprite.
*   **AnimationPlayer:**
    *   Create animations for the unit (e.g., idle, attack, move).
    *   Add the animations to the AnimationPlayer node.

### 3. Individual Unit Scenes (static_defender.tscn, mobile_unit.tscn, support_unit.tscn, basic_enemy.tscn, elite_enemy.tscn, boss_enemy.tscn)

*   **Inherit from base_unit.tscn:** Ensure each unit scene inherits from `base_unit.tscn`.
*   **Sprite2D:** Assign a unique texture to the Sprite2D node for each unit type.
*   **CollisionShape2D:** Adjust the shape and size of the CollisionShape2D to accurately match the unit's sprite.
*   **Unique Components:** Add any additional components specific to the unit type (e.g., a ranged attack component for a static defender).
*   **Animations:** Create and add animations specific to the unit type (e.g., a special attack animation for a boss enemy).

### 4. ui_overlay.tscn

*   **HUD:**
    *   Add child nodes for displaying tower health, wave information, and resources. These could be Labels, TextureProgress, or other UI elements.
    *   Configure the layout and appearance of these UI elements.
*   **PauseMenu:**
    *   Add buttons and other UI elements for the pause menu (e.g., resume, options, quit).
    *   Configure the layout and appearance of these UI elements.
    *   Implement the functionality for the buttons (e.g., connect signals to functions).
*   **GameOver:**
    *   Add UI elements for the game over screen (e.g., score, restart button, quit button).
    *   Configure the layout and appearance of these UI elements.
    *   Implement the functionality for the buttons (e.g., connect signals to functions).

### 5. card_hand.tscn

*   **HandArea:**
    *   Instantiate card scenes (unit\_card.tscn, spell\_card.tscn) and add them as children to the CardContainer (HBoxContainer).
    *   Implement logic to dynamically add and remove cards from the hand.
*   **DeckArea:**
    *   Add a visual representation of the deck (e.g., a TextureRect with a card stack texture).
*   **ResourceDisplay:**
    *   Add UI elements (e.g., Labels, icons) to display the player's resources (e.g., mana, gold).
    *   Implement logic to update resource display when resources change.

### 6. main_menu.tscn

*   **Background:**
    *   Assign a texture to the TextureRect node to serve as the background image.
*   **Title:**
    *   Set the font and font size for the Label node.
    *   Customize the text of the Label node.
*   **ButtonContainer:**
    *   Connect the button signals (pressed) to the appropriate functions in a script to handle button clicks (e.g., start game, options, quit).

### 7. base_card.tscn

*   **Background:**
    *   Assign a texture to the TextureRect node to serve as the card's background.
*   **Content:**
    *   **Image:** Assign a texture to the TextureRect node to display an image on the card.
    *   **Title:** Set the font and font size for the Label node. Customize the text of the Label node to display the card's title.
    *   **Description:** Set the font and font size for the Label node. Customize the text of the Label node to display the card's description.
*   **Cost:**
    *   Set the font and font size for the Label node. Customize the text of the Label node to display the card's cost.
*   **EffectContainer:**
    *   Add UI elements or visual representations of the card's effects.

### 8. spell_card.tscn

*   **Content:**
    *   **SpellStats:**
        *   Set the font and font size for the Label nodes (DurationStat/Label, CooldownStat/Label). Customize the text of the Label nodes.
        *   Set the font and font size for the Value Label nodes (DurationStat/Value, CooldownStat/Value).
    *   **EffectContainer:**
        *   **AreaDisplay:** Assign a texture to the TextureRect node to display the spell's area of effect.
    *   **SpellEffects:**
        *   Add visual effects (e.g., particles, animations) to represent the spell's effects.

### 9. unit_card.tscn

*   **Content:**
    *   **UnitStats:**
        *   Set the font and font size for the Label nodes (HealthStat/Label, DamageStat/Label). Customize the text of the Label nodes.
        *   Set the font and font size for the Value Label nodes (HealthStat/Value, DamageStat/Value). Customize the text of the Value Label nodes.
    *   **EffectContainer:**
        *   **PlacementInfo:** Set the font and font size for the Label node. Customize the text of the Label node.
    *   **PreviewArea:**
        *   Create a scene for the unit preview.
        *   Add the unit preview scene as a child of the SubViewport.
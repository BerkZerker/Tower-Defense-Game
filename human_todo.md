# Human To-Do List

This file contains a detailed list of setup instructions for the scenes in the project. Anything that isn't code in a .gd script file should be done manually in the Godot editor.

## Scenes

### 1. game.tscn

*   **TileMapLayer:**
    *   Create a TileSet resource.
    *   Add a TileMapLayer node as a child of GridManager.
    *   Assign the TileSet resource to the TileMapLayer's `tile_set` property.
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

### 3. ui_overlay.tscn

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

### 4. card_hand.tscn

*   **HandArea:**
    *   Instantiate card scenes (unit\_card.tscn, spell\_card.tscn) and add them as children to the CardContainer (HBoxContainer).
    *   Implement logic to dynamically add and remove cards from the hand.
*   **DeckArea:**
    *   Add a visual representation of the deck (e.g., a TextureRect with a card stack texture).
*   **ResourceDisplay:**
    *   Add UI elements (e.g., Labels, icons) to display the player's resources (e.g., mana, gold).
    *   Implement logic to update the resource display when resources change.

### 5. main_menu.tscn

*   **Background:**
    *   Assign a texture to the TextureRect node to serve as the background image.
*   **Title:**
    *   Set the font and font size for the Label node.
    *   Customize the text of the Label node.
*   **ButtonContainer:**
    *   Connect the button signals (pressed) to the appropriate functions in a script to handle button clicks (e.g., start game, options, quit).

### 6. base_card.tscn

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

### 7. spell_card.tscn

*   **Content:**
    *   **SpellStats:**
        *   Set the font and font size for the Label nodes (DurationStat/Label, CooldownStat/Label). Customize the text of the Label nodes.
        *   Set the font and font size for the Value Label nodes (DurationStat/Value, CooldownStat/Value).
*   **EffectContainer:**
    *   **AreaDisplay:** Assign a texture to the TextureRect node to display the spell's area of effect.
*   **SpellEffects:**
    *   Add visual effects (e.g., particles, animations) to represent the spell's effects.

### 8. unit_card.tscn

*   **Content:**
    *   **UnitStats:**
        *   Set the font and font size for the Label nodes (HealthStat/Label, DamageStat/Label). Customize the text of the Label nodes.
        *   Set the font and font size for the Value Label nodes (HealthStat/Value, DamageStat/Value). Customize the text of the Value Label nodes.
*   **EffectContainer:**
    *   **PlacementInfo:** Set the font and font size for the Label node. Customize the text of the Label node.
*   **PreviewArea:**
    *   Create a scene for the unit preview.
    *   Add the unit preview scene as a child of the SubViewport.
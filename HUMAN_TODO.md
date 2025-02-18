# Scene Creation Guide

## Setup Steps

1. Launch Godot 4.x
2. Open the project via project.godot
3. Switch to "2D" scene view for proper workspace setup

## Scene Creation Order

### 1. Base Game Scene (scenes/game.tscn) [DONE]

1. Create New Scene:
   - Right-click in FileSystem
   - New Scene > Node2D (name it "Game")
    
2. Add Grid System:
   - Add Node2D (name "GridManager")
   - Add TileMap under GridManager
   - Add Sprite2D under GridManager (name "PlacementIndicator")
    
3. Add Unit Management:
   - Add Node2D (name "UnitManager")
   - Add these Node2D children:
     * Characters
     * Enemies
     * Projectiles
    
4. Add Main Tower:
   - Add StaticBody2D (name "MainTower")
   - Add children:
     * Sprite2D
     * CollisionShape2D (set shape to Rectangle)
     * Node (name "HealthComponent")
    
5. Add Wave System:
   - Add Node (name "WaveManager")
   - Add Node2D under it (name "SpawnPoints")

6. Save scene as "game.tscn" in scenes folder

### 2. Base Unit Template (scenes/entities/base_unit.tscn) [DONE]

1. Create New Scene:
   - Add CharacterBody2D (name "Unit")
    
2. Add Components:
   - Sprite2D
   - CollisionShape2D
   - Node (name "HealthComponent")
   - Node (name "CombatComponent")
   - AnimationPlayer
   - Node2D (name "Effects")

3. Create entities folder:
   - Right-click scenes folder
   - Create Folder "entities"
    
4. Save scene as "base_unit.tscn"

### 3. UI Overlay (scenes/ui_overlay.tscn) [DONE]

1. Create New Scene:
   - Add CanvasLayer (name "UIOverlay")
    
2. Add HUD:
   - Add Control (name "HUD")
   - Add children Controls:
     * TowerHealth
     * WaveInfo
     * Resources
    
3. Add Menu Systems:
   - Add Control (name "PauseMenu")
   - Add Control (name "GameOver")
    
4. Save scene as "ui_overlay.tscn"

### 4. Card System (scenes/ui/card_hand.tscn)

1. Create ui folder:
   - Right-click scenes folder
   - Create Folder "ui"

2. Create New Scene:
   - Add CanvasLayer (name "CardHand")
    
3. Add Card Areas:
   - Add Control (name "HandArea")
     * Add HBoxContainer (name "CardContainer")
   - Add Control (name "DeckArea")
   - Add Control (name "ResourceDisplay")
    
4. Save scene as "card_hand.tscn"

### 5. Main Menu (scenes/ui/main_menu.tscn)

1. Create New Scene:
   - Add Control (name "MainMenu")
    
2. Add UI Elements:
   - Add TextureRect (name "Background")
   - Add Label (name "Title")
   - Add VBoxContainer (name "ButtonContainer")
     * Add Button (name "StartButton")
     * Add Button (name "OptionsButton")
     * Add Button (name "QuitButton")
   - Add Label (name "VersionLabel")
    
3. Configure for Portrait Mode:
   - Set Layout -> Full Rect
   - Set anchor points for proper mobile scaling
    
4. Save scene as "main_menu.tscn"

### 6. Unit Type Scenes (scenes/entities/units/)

1. Create units folder:
   - Right-click scenes/entities folder
   - Create Folder "units"

2. Create Static Defender:
   - Inherit from base_unit.tscn
   - Save as "static_defender.tscn"

3. Create Mobile Unit:
   - Inherit from base_unit.tscn
   - Save as "mobile_unit.tscn"

4. Create Support Unit:
   - Inherit from base_unit.tscn
   - Save as "support_unit.tscn"

5. Create Enemy Units:
   - Inherit from base_unit.tscn
   - Save as:
     * "basic_enemy.tscn"
     * "elite_enemy.tscn"
     * "boss_enemy.tscn"

### 7. Card Type Scenes (scenes/ui/cards/)

1. Create cards folder:
   - Right-click scenes/ui folder
   - Create Folder "cards"

2. Create Base Card:
   - Add Control (name "BaseCard")
   - Add standard card elements
   - Save as "base_card.tscn"

3. Create Unit Card:
   - Inherit from base_card.tscn
   - Add unit-specific elements
   - Save as "unit_card.tscn"

4. Create Spell Card:
   - Inherit from base_card.tscn
   - Add spell-specific elements
   - Save as "spell_card.tscn"

## Important Notes:

1. Node Naming:
   - Use PascalCase for node names
   - Be consistent with naming in project_plan.md
   - Follow existing naming patterns in completed scenes

2. Scene Organization:
   - Keep scenes in appropriate folders as specified
   - Match structure in scene_structure.md
   - Use inheritance where specified

3. Mobile Considerations:
   - Set anchors for UI elements
   - Test in portrait orientation
   - Consider touch input areas (minimum 44x44 pixels)
   - Respect safe areas on mobile devices

4. Next Steps After Creation:
   - Attach scripts to nodes
   - Set up signal connections
   - Configure node properties
   - Follow patterns in systemPatterns.md

5. Testing:
   - Test each scene individually
   - Verify portrait mode layout
   - Check touch input areas
   - Test inheritance relationships

## Implementation Order

Follow this order based on Phase 1 priorities:

1. Base Game Scene - [DONE]
2. Base Unit Template - [DONE]
3. UI Overlay - [DONE]
4. Unit Type Scenes - Create in this order:
   - Static Defender
   - Basic Enemy
   - Mobile Unit
   - Elite Enemy
   - Support Unit
   - Boss Enemy
5. Card System:
   - Base Card
   - Unit Card
   - Spell Card
   - Card Hand UI
6. Main Menu - implement once core gameplay is working

This order aligns with the Phase 1 goals in TODO.md and provides a solid foundation for further development.
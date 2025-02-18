# Scene Structure Documentation

## Required Scene Files

### 1. Main Game Scene
- Path: `scenes/game.tscn`
- Status: Partially Complete
- Purpose: Core gameplay scene containing grid, units, and wave management

### 2. Base Unit Template
- Path: `scenes/entities/base_unit.tscn`
- Status: Complete
- Purpose: Template for all game units with core components

### 3. UI Overlay
- Path: `scenes/ui_overlay.tscn`
- Status: Complete
- Purpose: HUD and menu systems

### 4. Card System
- Path: `scenes/ui/card_hand.tscn`
- Status: Needs Implementation
- Purpose: Card management and display

### 5. Main Menu
- Path: `scenes/ui/main_menu.tscn`
- Status: Needs Implementation
- Purpose: Game entry point and navigation

### 6. Unit Scenes (To Be Created)
- Path: `scenes/entities/units/`
- Required Scenes:
  * `static_defender.tscn`
  * `mobile_unit.tscn`
  * `support_unit.tscn`
  * `basic_enemy.tscn`
  * `elite_enemy.tscn`
  * `boss_enemy.tscn`

### 7. Card Scenes (To Be Created)
- Path: `scenes/ui/cards/`
- Required Scenes:
  * `base_card.tscn`
  * `unit_card.tscn`
  * `spell_card.tscn`

## Complete Node Trees

### 1. Game Scene (game.tscn)
```
Game (Node2D)
├── GridManager (Node2D)
│   ├── TileMap (TileMap)
│   └── PlacementIndicator (Sprite2D)
├── UnitManager (Node2D)
│   ├── Characters (Node2D)
│   ├── Enemies (Node2D)
│   └── Projectiles (Node2D)
├── MainTower (StaticBody2D)
│   ├── Sprite2D
│   ├── CollisionShape2D
│   └── HealthComponent (Node)
└── WaveManager (Node)
    └── SpawnPoints (Node2D)
```

### 2. Base Unit Template (base_unit.tscn)
```
Unit (CharacterBody2D)
├── Sprite2D
├── CollisionShape2D
├── HealthComponent (Node)
├── CombatComponent (Node)
├── AnimationPlayer
└── Effects (Node2D)
```

### 3. UI Overlay (ui_overlay.tscn)
```
UIOverlay (CanvasLayer)
├── HUD (Control)
│   ├── TowerHealth (Control)
│   ├── WaveInfo (Control)
│   └── Resources (Control)
├── PauseMenu (Control)
└── GameOver (Control)
```

### 4. Card Hand (card_hand.tscn)
```
CardHand (CanvasLayer)
├── HandArea (Control)
│   └── CardContainer (HBoxContainer)
├── DeckArea (Control)
└── ResourceDisplay (Control)
```

### 5. Main Menu (main_menu.tscn)
```
MainMenu (Control)
├── Background (TextureRect)
├── Title (Label)
├── ButtonContainer (VBoxContainer)
│   ├── StartButton (Button)
│   ├── OptionsButton (Button)
│   └── QuitButton (Button)
└── VersionLabel (Label)
```

### 6. Unit Scene Template (for all unit types)
```
[UnitName] (CharacterBody2D) extends base_unit.tscn
├── [Unique Components based on unit type]
└── [Unit-specific nodes]
```

### 7. Card Scene Template (for all card types)
```
[CardType] (Control)
├── Background (TextureRect)
├── Content (Control)
│   ├── Image (TextureRect)
│   ├── Title (Label)
│   └── Description (Label)
├── Cost (Label)
└── EffectContainer (Control)
```

## Implementation Notes

1. Scene Placement
   - All scenes should be saved in their respective folders under `scenes/`
   - Entity scenes go in `scenes/entities/`
   - UI scenes go in `scenes/ui/`
   - Card scenes go in `scenes/ui/cards/`

2. Inheritance Structure
   - All units should inherit from `base_unit.tscn`
   - All cards should inherit from `base_card.tscn`
   - Maintain the component structure defined in systemPatterns.md

3. Signal Connections
   - Each scene should implement the Observer pattern as defined
   - Connect to appropriate autoload singletons
   - Follow the signal naming conventions in systemPatterns.md

4. Mobile Considerations
   - All UI scenes must use anchors for proper scaling
   - Touch areas should be at least 44x44 pixels
   - UI elements should respect safe areas
   - Test in portrait mode

5. Performance
   - Use object pooling for projectiles
   - Implement culling for off-screen units
   - Preload resources where appropriate
   - Follow the optimization guidelines in systemPatterns.md
# Tower Defense Roguelike Project Plan

## Game Overview
A mobile-focused tower defense game combining roguelike elements and deck-building mechanics. Players defend a central tower using a deck of characters and spells, placing them strategically on a grid-based map while facing waves of enemies. The game is designed specifically for touch-based interaction and portrait orientation on mobile devices.

## Core Systems

### 1. Grid System
- Implementation of a tile-based grid for unit placement
- Grid coordinates system for position tracking
- Visual indicators for valid/invalid placement
- Grid-based pathfinding for enemies
- Grid size configuration for different maps

### 2. Card System
- Deck building mechanics
- Card types:
  - Character cards (placeable units)
  - Spell cards (one-time effects)
- Card drawing and hand management
- Card unlocking progression system
- Resource/mana system for card playing

### 3. Unit System
#### Characters (Player Units)
- Base character class with common properties
- Different character types:
  - Static defenders
  - Mobile units
  - Support units
- Unit attributes:
  - Health
  - Attack damage
  - Attack speed
  - Movement speed (for mobile units)
  - Range
  - Special abilities

#### Enemies
- Enemy spawning system
- Different enemy types with varying:
  - Health pools
  - Movement patterns
  - Attack behaviors
  - Special abilities
- Wave system with increasing difficulty
- Spawn point management around map edges

### 4. Combat System
- Attack mechanics
- Damage calculation
- Projectile system
- Area of effect abilities
- Status effects
- Unit targeting priorities

### 5. Main Tower
- Central tower health system
- Tower upgrades/repair mechanics
- Defense bonuses near tower
- Victory/defeat conditions

### 6. Roguelike Elements
- Run-based gameplay
- Procedural elements:
  - Enemy wave composition
  - Card rewards
  - Power-ups
- Meta-progression between runs
- Permadeath mechanics

## Technical Architecture

### 1. Scene Structure
- Main menu scene
- Game scene
- UI overlay scene
- Card selection/deck building scene

### 2. Core Classes
- GridManager: Handles grid logic and unit placement
- CardManager: Manages deck, hand, and card actions
- UnitManager: Oversees all units on the field
- WaveManager: Controls enemy spawning and wave progression
- CombatManager: Handles combat interactions
- GameStateManager: Manages overall game state and progression

### 3. Data Management
- Card database
- Unit stats configuration
- Wave configuration
- Progression data
- Save system

### 4. Scene Compositions
#### Main Game Scene (Node2D)
- GridManager (Node2D)
  - TileMap (for grid visualization)
  - PlacementIndicator (Sprite2D)
- UnitManager (Node2D)
  - Characters (Node2D - parent for all player units)
  - Enemies (Node2D - parent for enemy units)
  - Projectiles (Node2D - parent for projectiles)
- MainTower (StaticBody2D)
  - Sprite
  - CollisionShape2D
  - HealthComponent
- WaveManager (Node)
  - SpawnPoints (Node2D - parent for spawn markers)

#### Unit Scene Template (CharacterBody2D)
- Sprite2D
- CollisionShape2D
- HealthComponent (Node)
- CombatComponent (Node)
- AnimationPlayer
- Effects (Node2D - for status effects/particles)

#### Card System Scene (CanvasLayer)
- HandArea (Control)
  - CardContainer (HBoxContainer)
- DeckArea (Control)
- ResourceDisplay (Control)

#### UI Scene (CanvasLayer)
- HUD (Control)
  - TowerHealth
  - WaveInfo
  - Resources
- PauseMenu (Control)
- GameOver (Control)

## Implementation Phases

### Phase 1: Core Mechanics
1. Grid system implementation
2. Basic unit placement
3. Simple enemy spawning
4. Basic combat system

### Phase 2: Card System
1. Card UI implementation
2. Deck management
3. Basic character and spell cards
4. Resource system

### Phase 3: Unit Development
1. Multiple character types
2. Enemy variety
3. Advanced combat mechanics
4. Pathfinding

### Phase 4: Roguelike Elements
1. Run structure
2. Meta-progression
3. Card unlocking system
4. Difficulty scaling

### Phase 5: Polish
1. UI/UX improvements
2. Visual effects
3. Sound design
4. Balance adjustments

## Asset Requirements

### Visual Assets
- Character sprites
- Enemy sprites
- Tower sprites
- Card artwork
- UI elements
- Effect animations
- Grid/tile textures

### Audio Assets
- Background music
- Sound effects:
  - Combat sounds
  - Card playing sounds
  - Unit placement sounds
  - Enemy sounds
  - Victory/defeat jingles

## Testing Strategy
1. Unit testing for core systems
2. Playtesting phases:
   - Core mechanics
   - Balance testing
   - Difficulty curve
   - Fun factor
3. Performance testing
4. Bug tracking and resolution

## Technical Considerations
- Godot version: 4.x
- Mobile platform targets:
  - Android (minimum API level TBD)
  - iOS (minimum version TBD)
- Portrait orientation optimization
- Touch input optimization:
  - Drag and drop mechanics for cards
  - Touch-friendly UI elements
  - Gesture support for camera control
- Variable screen resolution handling:
  - Dynamic UI scaling
  - Responsive layout design
  - Safe area considerations for notches/cutouts
- Mobile performance optimization:
  - Battery usage consideration
  - Memory management
  - Unit count optimization
- Mobile-specific features:
  - Offline play capability
  - Auto-save system
  - Push notifications for energy/lives

## Initial Development Focus
1. Set up basic grid system
2. Implement simple unit placement
3. Create basic enemy spawning
4. Establish core combat mechanics
5. Develop basic card system

This plan provides a framework for development while allowing for iteration and adjustment based on testing and feedback.
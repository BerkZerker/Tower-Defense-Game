# Tower Defense Game

A mobile-focused tower defense roguelike game built with Godot Engine, combining deck-building mechanics with strategic tower defense gameplay. Players defend a central tower using a deck of characters and spells, placing them strategically on a grid-based map while facing waves of enemies.

## Project Structure

```
tower-defense-game/
├── scenes/       # Game scenes and levels
│   ├── main_menu.tscn    # Main menu
│   ├── game.tscn         # Main game scene
│   └── ui_overlay.tscn   # UI overlay
├── scripts/      # GDScript source files
│   ├── managers/   # Game system managers
│   └── entities/   # Unit and enemy scripts
├── components/   # Reusable scene components
│   ├── health/     # Health-related components
│   └── combat/     # Combat-related components
├── autoload/     # Autoloaded singletons
│   ├── game_state.gd
│   └── card_manager.gd
├── resources/    # Game data and configurations
│   ├── cards/      # Card definitions
│   ├── units/      # Unit stats and configs
│   └── waves/      # Wave configurations
├── ui/          # UI scenes and themes
│   ├── card_hand/  # Card UI elements
│   └── hud/        # Game HUD elements
└── assets/      # Game assets
    ├── sprites/  # Images and sprite files
    └── audio/    # Sound effects and music
```

## Core Features

- Grid-based tower defense gameplay
- Deck building mechanics with character and spell cards
- Various unit types: defenders, mobile units, and support units
- Enemy wave system with different enemy types
- Roguelike elements with run-based gameplay
- Meta-progression between runs

## Development Requirements

- Godot Engine 4.x
- Target Platforms:
  - Android (Mobile)
  - iOS (Mobile)
- Portrait orientation optimization
- Touch input support

## Getting Started

1. Install Godot Engine 4.x from [https://godotengine.org/](https://godotengine.org/)
2. Clone this repository
3. Open Godot Engine
4. Click "Import" and select the `project.godot` file from this repository
5. Click "Import & Edit"

## Development Status

Currently in early development. Following the implementation phases:

1. Core Mechanics (In Progress)
   - Grid system
   - Basic unit placement
   - Simple enemy spawning
   - Basic combat system

See `project_plan.md` for detailed development roadmap.

## Technical Details

- Portrait orientation for mobile devices
- Touch-based interaction
- Dynamic UI scaling for different screen sizes
- Mobile performance optimizations
- Offline play capability
- Auto-save system

## License

This project is under development. License terms to be determined.

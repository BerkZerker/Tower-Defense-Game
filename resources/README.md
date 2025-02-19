RESOURCES DIRECTORY

This directory contains game data and configuration files.

Structure:
- cards/: Card definitions and deck configurations
  - card_data.tres: Card stats and properties
  - deck_presets.tres: Predefined deck configurations
  
- units/: Unit stats and configurations
  - player_units.tres: Player unit stats
  - enemy_units.tres: Enemy unit stats
  
- waves/: Wave configurations
  - wave_patterns.tres: Enemy wave definitions
  - difficulty_scaling.tres: Wave difficulty progression
  
- game_config/: General game configurations
  - balance.tres: Game balance variables
  - progression.tres: Meta-progression settings

File Format:
- Use Godot resource files (.tres) for game data
- JSON for external configurations
- Each resource should be self-documented

Note: When adding new resources, update TODO.md and relevant documentation.

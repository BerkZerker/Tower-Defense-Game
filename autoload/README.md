AUTOLOAD DIRECTORY

This directory contains singleton scripts that are automatically loaded with the game.

Current Singletons:
- game_state.gd: Global game state management
  - Tracks game progress
  - Handles save/load
  - Manages meta-progression
  
- card_manager.gd: Global card system management
  - Manages deck building
  - Handles card collection
  - Controls card unlocks
  
- event_bus.gd: Global event management
  - Handles game-wide signals
  - Manages system communication
  
- settings_manager.gd: Game settings management
  - Handles user preferences
  - Controls audio settings
  - Manages input configurations

Guidelines:
1. Keep singletons lightweight
2. Document all public methods
3. Use signals for state changes
4. Clear separation of concerns

Note: All scripts here must be added to Project Settings > AutoLoad to function.
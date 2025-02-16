UI DIRECTORY

This directory contains UI-specific scenes and themes.

Structure:
- themes/: UI theme resources
  - default_theme.tres: Base game theme
  - components/: Theme components (buttons, panels, etc.)
  
- card_hand/: Card UI elements
  - card_display.tscn: Individual card display
  - hand_container.tscn: Card hand container
  - deck_view.tscn: Deck management UI
  
- hud/: In-game HUD elements
  - resource_display.tscn: Resource counters
  - wave_info.tscn: Wave status display
  - tower_health.tscn: Main tower health display
  
- menus/: Menu screens
  - pause_menu.tscn: Pause screen
  - main_menu.tscn: Title screen
  - options_menu.tscn: Settings screen

Mobile Considerations:
1. Design for portrait orientation
2. Use appropriate touch target sizes
3. Account for notch/cutout areas
4. Implement responsive layouts

Note: All UI should follow the style guide in CONTRIBUTING.md
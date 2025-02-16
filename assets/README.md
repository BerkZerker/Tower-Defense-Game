ASSETS DIRECTORY

This directory contains all game assets.

Structure:
- sprites/: Image assets
  - units/: Unit sprites
    - towers/: Defensive unit sprites
    - enemies/: Enemy unit sprites
  - effects/: Visual effect sprites
  - ui/: UI graphics
  - backgrounds/: Background images
  
- audio/: Audio assets
  - music/: Background music tracks
  - sfx/: Sound effects
    - combat/: Combat sounds
    - ui/: UI interaction sounds
    - ambient/: Ambient effects
  
Asset Guidelines:
1. Image formats:
   - PNG for sprites and UI
   - JPG for backgrounds
   - SVG for scalable graphics
   
2. Audio formats:
   - OGG for music
   - WAV for sound effects
   
3. Naming convention:
   - Use snake_case
   - Include type prefix (e.g., unit_tower_basic.png)
   - Include size for sprites (e.g., unit_tower_basic_64x64.png)

4. Mobile optimization:
   - Keep texture sizes reasonable
   - Compress assets appropriately
   - Consider memory usage

Note: Update TODO.md when adding new assets or identifying needed assets.
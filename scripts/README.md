SCRIPTS DIRECTORY

This directory contains all GDScript (.gd) source files.

Structure:
- managers/: System management scripts
  - grid_manager.gd: Grid system and placement logic
  - card_manager.gd: Card and deck management
  - wave_manager.gd: Enemy wave spawning and control
  - combat_manager.gd: Combat system logic
  
- entities/: Unit and enemy scripts
  - units/: Player unit scripts
  - enemies/: Enemy unit scripts
  - projectiles/: Projectile behavior scripts

- components/: Reusable behavior scripts
  - health_component.gd: Health system logic
  - combat_component.gd: Combat behavior logic
  - movement_component.gd: Movement behavior logic

Guidelines:
1. Use snake_case for file names
2. Group related scripts in subdirectories
3. Document script dependencies in comments
4. Follow GDScript style guide

Note: See TODO.md for scripts that need implementation.
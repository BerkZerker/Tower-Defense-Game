COMPONENTS DIRECTORY

This directory contains reusable scene components.

Structure:
- health/: Health-related components
  - health_bar.tscn: Visual health bar
  - health_component.tscn: Health management node
  
- combat/: Combat-related components
  - attack_range.tscn: Range indicator
  - projectile_spawner.tscn: Projectile management
  
- effects/: Visual and gameplay effects
  - status_effect.tscn: Status effect indicator
  - damage_number.tscn: Floating damage numbers
  
- ui/: Reusable UI components
  - resource_counter.tscn: Resource display
  - tooltip.tscn: Hover tooltip

Usage:
1. Components should be self-contained
2. Use signals for communication
3. Document required nodes and dependencies
4. Include example usage in comments

Note: Check CONTRIBUTING.md for component development guidelines.
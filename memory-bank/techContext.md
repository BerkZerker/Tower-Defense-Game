# Technical Context

## Development Environment

### Engine
- Godot Engine 4.x
- GDScript as primary scripting language
- Built-in physics and collision system
- Scene-based architecture
- Optimized local Godot API documentation in `godot-docs-html-stable/`
  * Focused 2D game development documentation
  * Mobile-specific functionality
  * Essential class references
  * Performance optimization guides
  * Touch input handling
  * Relevant tutorials only

### Running the Game
- Steam installation path: `C:\Program Files (x86)\Steam\steamapps\common\Godot Engine`
- Executable: `godot.windows.opt.tools.64.exe`
- Two ways to run the game:
  1. Open in editor (for development):
     ```
     "C:\Program Files (x86)\Steam\steamapps\common\Godot Engine\godot.windows.opt.tools.64.exe" --path . --verbose
     ```
  2. Run game directly (for playing):
     ```
     "C:\Program Files (x86)\Steam\steamapps\common\Godot Engine\godot.windows.opt.tools.64.exe" scenes/game.tscn
     ```
- Note: When running the game directly, it will open in play mode. The window may close if there are errors in the scene setup.

### Project Structure
```
tower-defense-game/
├── .git/               # Git repository data
├── .godot/            # Godot engine cache and settings
├── .repomix/          # Repository mixins
├── assets/            # Game assets
│   ├── audio/         # Sound effects and music
│   └── textures/      # Visual assets
│       ├── enemies/   # Enemy unit textures
│       ├── environment/
│       └── towers/    # Tower assets
├── autoload/          # Singleton managers
├── components/        # Reusable components
├── memory-bank/       # Project documentation
├── resources/         # Game data
├── scenes/           # Game scenes and levels
├── scripts/          # GDScript source files
├── ui/               # UI elements
└── godot-docs-html-stable/  # Optimized local API documentation
    ├── classes/      # Essential 2D and mobile-related classes
    ├── tutorials/    # Relevant 2D and mobile tutorials
    └── getting_started/ # Core concepts and setup guides
```

### Version Control
- Git for source control
- .gitattributes and .gitignore configured
- Branch strategy: TBD

## Technical Requirements

### Platform Targets
1. Primary: Mobile
   - Android (API level TBD)
   - iOS (minimum version TBD)
2. Orientation
   - Landscape mode only (16:9)
   - Base resolution: 1280x720
   - Safe area handling

### Performance Targets
1. Frame Rate
   - Target: 60 FPS
   - Minimum: 30 FPS
2. Memory
   - Maximum: TBD based on device testing
   - Optimization through object pooling
3. Battery
   - Efficient update cycles
   - Optimized physics processing
   - Smart resource management

### Device Compatibility
1. Screen Sizes
   - Minimum: 1280x720
   - Maximum: 2560x1440
   - Dynamic UI scaling
   - Landscape-optimized layouts
2. Input
   - Touch primary
   - Gesture support
   - Drag-and-drop optimization
   - Landscape-oriented controls

## Dependencies

### Core Systems
1. Godot Built-in
   - Node2D for game objects
   - CanvasLayer for UI
   - TileMap for grid (16x9 cells)
   - CharacterBody2D for units
   - AnimationPlayer for animations

2. Custom Components
   - HealthComponent
   - CombatComponent
   - MovementComponent
   - AbilityComponent

### Data Management
1. Resource System
   - Card definitions
   - Unit configurations
   - Wave data
   - Progression data

2. Save System
   - Local storage
   - JSON serialization
   - Auto-save functionality

## Technical Constraints

### Mobile Optimization
1. Memory Management
   - Object pooling for frequent objects
   - Resource preloading
   - Scene instantiation optimization

2. Battery Efficiency
   - Optimized update cycles
   - Efficient pathfinding
   - Smart state management

3. Touch Input
   - Input buffering
   - Multi-touch support
   - Gesture recognition
   - Landscape-optimized controls

### Performance Optimization
1. Rendering
   - Culling system
   - Batch processing
   - Particle limits
   - Shader optimization

2. Physics
   - Layer-based collisions
   - Physics body optimization
   - Area2D for triggers

3. Memory
   - Scene cleanup
   - Resource unloading
   - Cache management

## Development Tools

### Required Software
- Godot Engine 4.x
- Git
- Text editor with GDScript support
- Mobile device testing setup
- Optimized local API documentation (focused on 2D and mobile)

### Development Workflow
1. Local Development
   - Scene composition
   - Script implementation
   - Component development
   - Local testing
   - API reference consultation

2. Testing Process
   - Unit testing (where applicable)
   - Scene testing
   - Integration testing
   - Mobile device testing
   - Landscape orientation verification

3. Build Process
   - Export templates
   - Platform-specific builds
   - Testing builds
   - Release builds

## Configuration Management

### Build Configuration
- Debug builds
- Release builds
- Platform-specific settings
- Landscape orientation settings

### Resource Management
- Asset loading strategies
- Memory management policies
- Cache configurations

### Save Data
- Save file structure
- Auto-save frequency
- Data migration strategy
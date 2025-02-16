# Contributing Guidelines

## Working with Roo

When working with Roo on this project, follow these guidelines to ensure consistent collaboration:

### Directory Structure Overview

Each directory has a specific purpose and contains a README.txt file explaining its role:

- `scenes/`: Game scenes (levels, menus, etc)
- `scripts/`: GDScript source files
- `components/`: Reusable scene components
- `autoload/`: Singleton managers
- `resources/`: Game data and configurations
- `ui/`: UI scenes and themes
- `assets/`: Game assets (sprites, audio)

### Development Tracking

1. Check `TODO.md` before starting work to see current tasks and progress
2. After making changes, update `TODO.md` with completed items
3. Each major feature should be documented in its directory's README.txt

### Code Organization Rules

1. All new scenes go in the `scenes/` directory
2. All GDScript files go in the `scripts/` directory
3. Reusable components belong in `components/`
4. Global singletons go in `autoload/`
5. Game data files belong in `resources/`
6. UI scenes and themes go in `ui/`
7. Asset files belong in `assets/` with appropriate subdirectories

### Naming Conventions

- Scene files: `snake_case.tscn`
- Script files: `snake_case.gd`
- Node names: `PascalCase`
- Function names: `snake_case`
- Signal names: `snake_case`
- Constants: `SCREAMING_SNAKE_CASE`

### When Using Roo

1. Always check relevant README.txt files in directories you're working with
2. Update TODO.md when completing tasks
3. Follow existing code patterns and structure
4. Document new features in appropriate README.txt files
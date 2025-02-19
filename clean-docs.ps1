# Clean up Godot documentation
$docsPath = "godot-docs-html-stable"

# Remove unnecessary top-level directories
$dirsToRemove = @(
    "community",
    "contributing",
    "_downloads",
    "about",
    "assets_pipeline",
    "editor",
    "export",
    "i18n",
    "migrating",
    "networking",
    "plugins",
    "shaders",
    "xr"
)

foreach ($dir in $dirsToRemove) {
    $path = Join-Path $docsPath $dir
    if (Test-Path $path) {
        Write-Host "Removing $dir..."
        Remove-Item -Path $path -Recurse -Force
    }
}

# Clean up tutorials directory
$tutorialsPath = Join-Path $docsPath "tutorials"
$tutorialsToKeep = @(
    "2d",
    "animation",
    "audio",
    "best_practices",
    "inputs",
    "navigation",
    "physics",
    "platform",
    "scripting",
    "ui",
    "performance",
    "troubleshooting.html"
)

Get-ChildItem $tutorialsPath | Where-Object {
    $_.Name -notin $tutorialsToKeep
} | ForEach-Object {
    Write-Host "Removing tutorial: $($_.Name)..."
    Remove-Item -Path $_.FullName -Recurse -Force
}

# Create list of essential class files
$essentialClasses = @(
    "class_@gdscript",
    "class_@globalscope",
    "class_node",
    "class_node2d",
    "class_resource",
    "class_canvasitem",
    "class_canvaslayer",
    "class_control",
    "class_button",
    "class_container",
    "class_characterbody2d",
    "class_area2d",
    "class_sprite2d",
    "class_tilemap",
    "class_tileset",
    "class_collisionobject2d",
    "class_collisionshape2d",
    "class_physics2d",
    "class_animation",
    "class_animationplayer",
    "class_animatedsprite2d",
    "class_audiostreamplayer2d",
    "class_audiostream",
    "class_dictionary",
    "class_array",
    "class_file",
    "class_json"
)

# Clean up classes directory
$classesPath = Join-Path $docsPath "classes"
Get-ChildItem $classesPath -Filter "class_*.html" | Where-Object {
    $baseName = $_.BaseName
    -not ($essentialClasses | Where-Object { $baseName.StartsWith($_) })
} | ForEach-Object {
    Write-Host "Removing class: $($_.Name)..."
    Remove-Item -Path $_.FullName -Force
}

Write-Host "Documentation cleanup complete!"
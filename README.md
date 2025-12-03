# AppDrop — Dynamic Widget Rendering Engine (Flutter)

This project implements a mini widget rendering engine that converts a JSON schema into a Flutter UI at runtime.

## Project structure
- `lib/core/models/` — JSON models (page, component)
- `lib/core/widget_factory/` — maps component `type` -> widget
- `lib/components/` — implementations for banner, carousel, grid, video, text
- `lib/screens/` — main screen
- `lib/main.dart` — bootstrap + sample JSON

## Supported component types
- `banner` — image banner (height, padding, radius)
- `carousel` — image carousel (images, height, autoPlay, spacing)
- `grid` — image grid (images, columns, spacing, padding)
- `video` — video player (url, autoPlay, loop, height, padding)
- `text` — text block (value, size, weight, align, padding)

## How JSON maps to UI
The JSON structure:
```json
{
  "page": {
    "components": [
      { "type": "banner", "image": "...", ... },
      { "type": "carousel", "images": [...], ... }
    ]
  }
}

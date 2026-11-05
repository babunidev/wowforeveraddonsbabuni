# Changelog

Notable changes to Forever Journey, focused on features and improvements available to players.

## 0.6.0-rc.1

### Added
- Custom entries display their titles in Chronicle Timeline and Recent Journey.
- Click a diary entry to open its full content in a dedicated reading window.
- Added scrolling support for longer diary entries.
- Added quick access to editing directly from the reading window.

## 0.5.0-rc.3

### Fixed

- Removed the grey dimming layer behind manual-memory, delete-confirmation, and personal-note dialogs. Dialogs continue to prevent unintended clicks on the Chronicle underneath.

## 0.5.0-rc.2

### Fixed

- Improved the visibility of the insertion cursor and selected text in manual-memory title and note fields.
- Made cursor visibility consistent between manual memories and personal notes, including empty fields when first focused.

## 0.5.0-rc.1

### Added

- **Chronicle search:** find memories by title, description, and location. Search is case-insensitive and supports Russian text, including `е`/`ё` equivalence.
- **Search with filters:** combine text search with event-type selection and the Favorites-only filter.
- **Personal notes for recorded events:** add, edit, or clear your own note on an automatically recorded Chronicle memory without changing the event's original details.
- **Note previews:** view a saved personal note by hovering over its Chronicle action.

### Improved

- Improved the personal-note editor's text contrast, insertion cursor visibility, selection highlight, and scrolling.
- Search and notes follow the journal's existing presentation and retain the current character's saved memories.

### Storage

- Personal notes are saved alongside their memories in the existing SavedVariables format. No migration is needed from 0.4.0.
- Full-character text backups include personal notes. Existing memories with matching IDs are not overwritten by backup import.

## 0.4.0-rc.1

### Added

- **Journey Statistics:** a dedicated Overview page showing lifetime deaths, completed quests, enemies defeated, honorable kills, flights, hearthstone uses, falling deaths, and deaths caused by other players when available from game statistics.
- **Backup and Restore:** export a character's journey as text, validate a saved backup, preview new and duplicate memories, and restore missing memories for the same character.

### Improved

- Overview uses the game's lifetime-death statistic when available, with a local fallback.
- Completed quest counts and future quest milestones use the game's completed-quest statistic where available for more consistent totals.
- Statistics and backup management appear as journal pages instead of separate overlay windows.

### Important

- Save the exported text outside your World of Warcraft installation. Deleting the game's `WTF` directory without an external backup can erase locally recorded journey events.

## 0.3.0-rc.2

### Fixed

- Improved compatibility of reputation milestone descriptions with the game's text rendering.

## 0.3.0-rc.1

### Added

- Reputation standing-rank milestones for recorded faction promotions.
- A dedicated reputation filter and visual marker in Chronicle.

### Improved

- Ordinary reputation gains do not create new journal memories; only standing-rank increases do.
- Reputation milestones work with favorites and Memorable Moments.

## 0.2.0-beta.1

### Added

- Boss victory memories for successful encounters, with available instance and encounter details.
- A dedicated boss-victories filter in Chronicle.

### Improved

- Reduced duplicate memories from repeated notifications of the same boss victory.

## 0.1.0-beta.3

### Added

- Manual memories with a title, optional note, time, and location.
- Editing and deleting manual memories.
- Favorite stars and a Memorable Moments section in History.
- Multi-select Chronicle filtering and a Favorites-only filter.

### Improved

- Refined Chronicle controls, filter visuals, and journal styling.

## 0.1.0-beta.2

### Improved

- Improved death-memory details and capture of NPC names when available.
- Updated persistent memories to schema v3 with stable per-character memory IDs.
- Existing journey data is migrated while preserving historical records.

## 0.1.0-beta.1

### Added

- The first public Forever Journey journal, with Overview, Chronicle, and History.
- Character progression, travel, quest, profession, and death memories.
- Recovered History snapshots for existing characters.
- Quest and profession milestones.
- A movable minimap launcher, English and Russian language support, and custom journal artwork.

--[[ Stryk's Emote Wheel (c) 2026 stryker2k2. All rights reserved. ]]
local t,e=...
e.CHANGELOG_TEXT=[[
# Change Log

All notable changes to Stryk's Emote Wheel will be documented here.

### [2.0.1] - 2026-11-04

#### New Features and Changes

- **The addon's icon in the AddOns list is now the fiery Stryk emblem.**
- **Settings > Wheel now lists the wheel's 12 slots instead of showing a mini-wheel.** Each row shows the slot number, its emoticon and its emote. Hovering a row still lights that slice on the open wheel, clicking selects it for editing (right-click also opens the emoticon picker), and scrolling over the list switches wheels.
- **No more diamonds.** Removed the diamond in the Settings title flourish (now a plain fading line), the diamond gems on section headers and name tags, and the diamond studs on the wheel's rim and in the hub's outer ring.
- **Plainer title font.** Window titles use the game's standard UI font instead of the decorative quest-title font.
- **Calmer look.** Dropped the ornamental corners, the second gold border line, the gems on section headers and name tags, the title glow and flourish, the turning-on glow on buttons, the breathing glow and rune ring on the wheel, and the pop-in grow on the settings window. The tiled background texture now defaults to None (your saved choice is kept).

### [2.0.0] - 2026-11-03

#### New Features and Changes

- **A whole new look.** The wheel, trigger button and settings panel were redesigned from the ground up: a gilded rim set with gems, a center icon set in a ring of runes, soft glows and shading, all in your Color Theme's colors.
- **Hovering a slice lights it up**, with a glow that trails off as you sweep around the wheel. The wheel blooms open, and switching wheels fades the new emotes in.
- **Edit your emotes on the wheel itself.** The Wheel tab now shows a live copy of your wheel: click a slice to pick it (right-click to go straight to its emoticons), then change its emote and emoticon beside it. Scroll over it to switch wheels.
- **Search the emote list** - start typing to filter it; Enter picks the first match. Each emote shows its emoticon beside its name.
- **Bigger emoticon picker**, sorted alphabetically, that names each icon on a themed plaque as you hover it.
- **The Color Theme list shows each theme's colors**, and the Texture list shows each texture.
- **New switches, sliders and key-shaped keybind buttons** (they pulse while waiting for your key).
- **The Controls tab previews your trigger button** at its current opacity.
- **Custom tab:** names show how many letters you have left, Tab jumps to the next box, and changes confirm with "Saved."
- **Emoticon names show on a small plaque beside the wheel** instead of the game tooltip.
- **Escape closes the settings panel.**

#### Bug Fixes

- **Leaving the Controls tab while it's waiting for a key now cancels it**, instead of binding whatever you press next.
- **A controller bind using RB (or another emulated modifier) no longer causes Lua errors** and no longer stops your other settings from loading.
- **The emote list now marks the right emote for aliases** that share a command (Yes and Nod).

### [1.1.12] - 2026-11-02

#### New Features and Changes

- **Hover over a Color Theme to preview it** - the wheel and settings panel take on that theme while your mouse is over it. Click to keep it; move away or close the list and your theme comes back.
- **Background textures for the wheel and settings panel** - pick Rock, Marble, Dark Dialog, Black Market, Wood, Parchment or None from the new Texture dropdown under Color Theme (hover to preview), and set how strongly it shows with Texture Strength. Your theme color still shows through. Wood and Parchment are Retail and WoW: Forever only.
- **The Color Theme, Texture and Icon lists open upward**, so they stay inside the settings panel instead of hanging off the bottom.
- **WoW Forever support:** Stryk's Emote Wheel now installs and runs on WoW Forever (1.60.1) alongside Retail and the Classic flavors.

### [1.1.11] - 2026-10-30

#### New Features and Changes

- **Emoticons:** most emotes now show a matching icon on the wheel instead of their name, colored to match your theme. Each slot has a new icon button next to its name to pick any of 190 icons, or choose Default or None (text).
- **37 new emoticons** (salute, gift, shrug, lightbulb, bow and arrow, dog and more), and Idea, Shrug, Shush, Silence, Talk, Whine, Smirk, Squeal, Revenge, Slap, Surrend and Signal now use one by default.
- **Click `/sew help` in the settings panel footer to list the commands in chat.**
- **Click `@stryker2k2` in the settings panel footer** to get a link to my Reddit profile you can copy.
- **Hovering an emoticon on the wheel now shows a tooltip with the emote's name.**
- **The page chevrons now show which wheel they lead to** (like "Wheel 3" beside the up chevron), and sit a little farther from the wheel to make room. Click the label or the chevron to switch wheels.
- **The Class Color theme now tints the wheel's text to match your class** (a pale shade of your class color) instead of the same grey for every class.
- **Debug tab: Stick Test and Preview Expansion Colors swapped places** in the button grid.
- **New "Force Text-Only in Wheel" option** (Wheel tab) - shows every slice as text instead of emoticons, without touching your emoticon choices.

#### Bug Fixes

- **The Custom tab's boxes no longer turn gold-bordered after you edit them** - they keep your theme's color.
- **Your active wheel is now remembered across relogs and /reload** instead of resetting to Wheel 1.
- **The page chevrons now follow the wheel when you change its size** - they used to stay where they were.

### [1.1.10] - 2026-10-28

#### New Features and Changes

- **Debug tab's four action buttons (Test All Emotes, Preview Class Colors, Preview Expansion Colors, Stick Test) are now a 2x2 grid** instead of a single stacked column, and the Debug Log box below grows to fill the vertical space that freed up.
- **Test All Emotes now runs a sanity check first** - a made-up emote token that's expected to come back SILENT, confirming the test itself can actually detect a real failure before trusting the rest of the run's results.

#### Bug Fixes

- **Test All Emotes (Debug tab) no longer calls a missing confirmation "FAIL"** - on clients where the confirming chat message arrives late (observed on WoW: Forever), the result could get credited to the wrong emote in the log. That emote almost certainly isn't actually broken, so it's now labeled SILENT instead of FAIL, and counted separately in the end-of-test summary.

### [1.1.9] - 2026-10-10

#### New Features and Changes

- **Added every remaining WoW emote to the emote picker** - previously only emotes with an animation and/or voice line were listed; now text-only emotes (Agree, Backpack, Comfort, Facepalm, Happy, Praise, and many more) are available too.
- **The wheel now stays visible with the small Map & Quest Log view** - it still hides when the map is fullscreen.

#### Bug Fixes

- **Custom emotes now save correctly** - editing a slot without editing the ones above it could revert to its default after a reload or relog. Previously lost edits come back too.
- **Keybind no longer fires over the Collections Journal** - mounts, pets, toys, heirlooms, and transmog now block it like other panels.

### [1.1.8] - 2026-09-25

#### New Features and Changes

- **Keybind no longer activates over Blizzard UI panels** - pressing your emote wheel hotkey while hovering a panel (Character Info, Professions, bags, etc.) now does nothing, so you can't accidentally open the wheel while clicking through UI. Action bar slots with a spell assigned also block; empty slots do not.
- **Stryk's Emote Wheel now appears under ESC -> Options -> Addons** - the entry has three buttons: Open Settings, Show/Hide Trigger, and Reset to Default (with confirmation).
- **Removed WoW:Forever warning** - WoW:F Build v1.60.1 70009 fixed this issue.

### [1.1.7] - 2026-09-20

#### Bug Fixes

- **WoW: Forever now shows a warning on every login and /reload** - the WoW: Forever beta client has a bug where SavedVariables fail to load, silently resetting all addon settings to defaults. The addon now detects this and prints a chat warning so you know why your settings look wrong (this is a Blizzard-side bug with no addon-side fix).

### [1.1.6] - 2026-09-19

#### New Features and Changes

- **Added support for WoW: Forever (beta)** - the addon now loads on the Forever beta client alongside Retail, Classic Era, TBC Anniversary, and MoP Classic.
- **The wheel now has 3 pages of 12 slots each (36 emotes total), up from just 1** - use the up/down arrows above and below the hub, or scroll your mouse wheel over it, to switch pages. The Wheel Slots editor (Settings > Wheel) is page-aware too, so you can assign emotes to all 36 slots.
- **New "Forever" theme** - antique chart-teal ocean with bronze compass-ring gold filigree, inspired by the WoW: Forever logo.
- **Emotes are now blocked during Mythic+ Dungeons** - same treatment as the existing dead/boss-encounter/Battleground blocks: the wheel refuses to open (with a warning) and the trigger icon dims for the whole run.
- **Debug tab now has a Debug Log viewer** - a scrollable, selectable box, capturing what the addon's doing in the background at all times (not just while `/sew debug` is on), so you can look back at what happened even if you forgot to enable debug mode beforehand. Survives `/reload`, with a Select All button (for copying elsewhere) and a Clear Log button.
- **Added Bonk and Moo to the emote picker.**
- **New Custom tab lets you create your own emotes** - 12 slots, each with a name and whatever text you want said (like typing `/em says hello`). These don't have animations, but you can name and word them however you like, and assign them to any wheel slot right alongside the built-in emotes (they show up in the picker below a divider line). Names must be 8 characters or fewer and can't match an existing emote name.
- **Wheel 3 now defaults to your 12 custom emotes instead of the built-in Attitude/Flavor set** - the old defaults (Angry, Taunt, Charge, etc.) are still available in the picker, just no longer pre-assigned there.
- **Added a Plug Custom Emote** in the default custom emotes - Plug is a lighthearted CurseForge shout-out, fully editable/erasable like any other custom slot.
- **The Debug Log now records a PASS/FAIL for every emote you fire** (not just during Test All Emotes), and names the emote when Blizzard's security block catches it mid-attempt.
- **New Quick Actions section on the Debug tab, always visible even with debug mode off** - an Enable/Disable Debug Mode button and a Reset All button (mimics `/sew reset`, with a confirmation prompt since it wipes everything), so you don't have to type slash commands to reach either (typing them still works too).
- **New Preview Expansion Colors button on the Debug tab** - runs one round through every named color theme (Classic, Burning Crusade, Lich King, ... Forever), same behavior as Preview Class Colors: restores your previous theme when it finishes a round, or the moment you click it again mid-round.
- **Every "Reset" button now asks for confirmation first** (Position and Size, Reset to Default on the Wheel Slots grid, Reset to Default on the Custom tab, and Reset All) - a misclick can no longer wipe something with no way back.
- **New Reset to Default button on the Custom tab** - restores all 12 custom emotes' names and text back to their shipped defaults in one click, without touching anything else.
- **The up/down page arrows on the wheel are thicker and easier to spot at a glance**, and hovering either now shows a tooltip ("Scroll Wheel Up"/"Scroll Wheel Down") reminding you that your mouse's scroll wheel does the same thing as clicking them.
- **Hovering the trigger (or the open wheel's hub) while holding Shift now shows the move cursor immediately** - no need to start dragging first to see it. Same idea as before, just showing the hint earlier.

### [1.1.5] - 2026-08-30

#### New Features and Changes

- **Emotes are now blocked in Battlegrounds and Arenas** - same treatment as the existing dead/boss-encounter blocks: the wheel refuses to open (with a warning) and the trigger icon dims while inside either.
- **Hovering the trigger while blocked** (dead, boss encounter, or Battleground/Arena) now shows the reason in the tooltip instead of the usual keybind tips.
- **Denied-emote warnings now play a sound** alongside the chat message.

#### Bug Fixes

- **Emotes could silently fail (e.g. in Battlegrounds) with no error or warning** - the wheel now always tells you when Blizzard blocks an emote, regardless of how you triggered it (mouse, keybind, or gamepad).

### [1.1.4] - 2026-08-06

#### New Features and Changes
- **New icon options: Fire and Frost** - two hand-drawn icons added to the icon picker; Fire is now the default.
- **Shift + Drag repositioning** - replaces the old hold-to-drag gesture. Holding Shift while dragging the trigger or the open wheel now repositions it instantly; a plain click still opens/closes the wheel.
- Bare Shift can no longer be bound to hold-to-open the wheel, since it conflicts with Shift + Drag repositioning - Shift combos (e.g. Shift + F) are unaffected. You'll get a warning instead of a saved bind.
- Known tradeoff: binding bare LT or LB to hold-to-open the wheel also opens it when pressing the keyboard key it emulates (Shift for LT, Ctrl for LB). Bind LT/LB as part of a combo to avoid this if it's a problem for you.

#### Bug Fixes

- **Boss-encounter block never fired on left-click** - left-clicking the trigger during a boss encounter didn't show the warning or refuse to open the wheel (though the icon still dimmed and the wheel still force-closed). Fixed.

### [1.1.3] - 2026-08-01

#### New Features and Changes
- **Default loadout change** - slot 10 is now **Thanks** instead of **Sleep** (Sleep is still available in the picker, just no longer pre-assigned). Removed the redundant **TY** alias from the emote picker since **Thanks** already existed as a name for the same `THANK` command.
- Updated TOC to support Classic Era 1.15.9 and TBC Anniversary 2.5.6

### [1.1.2] - 2026-06-16

#### New Features and Changes
- Updated TOC to support Retail 12.0.7 and Mists of Pandaria Classic 5.5.4

### [1.1.1] - 2026-05-08

#### New Features and Changes

- **Hide Trigger** - new checkbox in the Controls tab; when enabled, the trigger button is hidden while all keybind and controller functionality remains fully active; persists across reloads and resets cleanly via `/sew reset`
- **Trigger Opacity** - slider to the right of Hide Trigger sets the trigger's resting opacity (0-100%); hovering the trigger always restores full opacity; slider hides when Hide Trigger is checked; resets to 100% via both `/sew reset` and Position and Size Reset
- **Keyboard/Controller row labels** - removed active-device color highlight; both labels now stay at the standard text color at all times
- **Theme system fix** - `kbBindLabel` and `padBindLabel` (bind display text inside the bind buttons) were missing from the theme registry and not updated on theme change; fixed; hint text rows (`kbHint`, `padHint`) moved to a new `panelDimTexts` themed list so their 0.25 alpha is preserved correctly across theme changes
- **`/sew show`** - now toggles the trigger button visible/hidden (syncs with the Hide Trigger checkbox); replaces the old settings-panel toggle
- **`/sew settings`** - new command to open or close the Settings panel (replaces the old `/sew show` behavior)
- **`/sew info` expanded** - now includes WoW client version and build, WoW project (Retail/Classic Era), trigger hidden state, snap-to-cursor state, key bind, pad bind, controller stick, and GamePad enabled status; useful for bug reports

#### Bug Fixes

- **Trigger click while ghost prints nil** - `MSG_DEAD` and `MSG_BOSS` were declared after the trigger `OnClick` handler; moved declarations above the handler so the correct warning prints when clicking the trigger while dead or in ghost form
- **GAMEPAD_DISCONNECTED error on unsupported clients** - wrapped `RegisterEvent("GAMEPAD_DISCONNECTED")` in `pcall` so clients that don't support the event (e.g. private servers) load without error; controller disconnect detection is unaffected on supported clients

### [1.1.0] - 2026-05-03

#### New Features and Changes

- **Class Color theme** - new "Class Color" option in the theme dropdown; automatically detects the player's class at login and applies the official class color to borders, spokes, and accents against a dark neutral background; appears at the top of the theme list
- **Class Icon** - new "Class Icon" option in the icon dropdown; uses the player's class icon texture; appears at the top of the icon list
- **3-tab Settings panel** - Settings panel widened to 380px with three tabs: Wheel, Controls, and Debug
- **Debug tab** - dedicated Debug tab housing the "Test All Emotes" and "Preview Class Colors" buttons; entire tab content is gated behind `/sew debug` and replaced with a prompt when debug mode is off
- **Test All Emotes improvements** - button now acts as a stop button mid-run; prints "[SEW] Test started." on begin and "[SEW] Test stopped." on cancel; Dance and Lean added to the skip list
- **Move cursor on title bar hover** - hovering over the Settings panel title bar shows a four-directional move cursor (`ui-cursor-move`)
- **Move cursor on Shift+hover** - hovering over the trigger or the expanded wheel hub while holding Shift shows the move cursor, indicating the wheel can be repositioned
- **Wheel stays open after drag** - dragging the expanded wheel to a new position no longer collapses it; the first click after repositioning correctly fires the emote
- **Hide on fullscreen map** - the trigger, wheel, and Settings panel all hide automatically when the fullscreen world map opens and reappear when it closes
- **Slice preview on slot hover** - hovering an emote slot button in the Settings panel highlights the corresponding wheel slice with a color change, outline, and slight font size increase
- **Hold-to-drag repositioning** - holding left mouse for 0.3s on the trigger or open wheel enters drag mode with a move cursor; replaces Shift+drag
- **Key hold to open wheel** - assign any key or modifier+key combo in the Controls tab; holding the key opens the wheel; releasing the key or clicking the hub fires the highlighted emote; works in both Snap to Cursor and standard mode; supports bare modifier keys (Shift, Ctrl, Alt) as well as combos
- **Controller binding** - dedicated controller bind row in the Controls tab; supports LT, LB, LS, RS, RT, face buttons, and modifier+button combos (e.g. LT+PAD1); holding opens the wheel, releasing or clicking fires the selected emote
- **Controller stick selection** - Controls tab dropdown selects which analog stick (Left or Right) drives slice highlighting while the wheel is open; defaults to Right Stick
- **Snap to Cursor** - optional mode (Controls tab, on by default); when enabled, holding the key or button snaps the wheel and trigger to the cursor position; mouse direction or analog stick angle selects a slice; releasing fires the emote and snaps back; clicking the hub also fires the emote
- **Camera lock during radial** - stick input is routed to the wheel frame while open, preventing the camera from moving during controller-driven emote selection
- **Keybind hold respects blocked state** - holding a key or controller button while dead, in ghost form, or during a boss encounter no longer opens the wheel; warning message shown in chat (throttled to once per 2 seconds)
- **Settings panel position** - the Settings panel saves its position when dragged and restores it on login; `/sew reset` returns it to screen center

#### Settings and Controls Tab Layout

- **Wheel Size** moved above **Position and Size [Reset]** in the General section
- **Emote slot grid** now fills the full available panel width
- **Preview Class Colors** button relocated to the Debug tab
- **Snap to Cursor** appears as a labelled row in the Controls tab (label in column 1, checkbox in column 2), consistent with the Keyboard and Controller rows
- **Hint text** split by input type: keyboard modifiers shown below the Keyboard row, controller modifiers below the Controller row; both aligned to the bind button column

#### Code Quality

- **Named color constants** - all hardcoded RGBA values in `Settings.lua` replaced with named constants (`BTN_BG`, `BTN_BORDER`, `BTN_TEXT`, `PANEL_BG`, `PANEL_BORDER`, `DROP_BG`, `ACCENT`, `TITLE_TINT`, `PREVIEW_*`) and an `rgb()` helper
- **`EW.refreshDebugTab()`** - exposed function to sync Debug tab visibility; called on tab open and on `/sew debug` toggle
- **TOC version sync** - install script now syncs all flavour TOC files to match `_Mainline` on every run

### [1.0.4] - 2026-04-27

#### New Features and Changes

- **Blocked-state indicator** - trigger icon desaturates (grayscale) when emotes are unavailable; restores to full color when available again
- **Boss encounter blocking** - emotes are blocked during raid boss encounters (`ENCOUNTER_START`/`ENCOUNTER_END`) to prevent taint errors; trash pulls are unaffected
- **Death and ghost blocking** - emotes are blocked while the player is dead (corpse) or in ghost form; wheel closes automatically
- **Reload persistence** - dead/ghost state is saved to SavedVariables so the blocked indicator survives a `/reload`
- **Wheel stays open** - clicking a slice performs the emote but leaves the wheel open; it only closes on a second click of the trigger or when blocked
- **Unified print function** - `EW.sewPrint(msg, type)` with `"debug"`, `"warn"`, and `"info"` levels; debug output toggled via `/sew debug`
- **Emote list cleanup** - removed duplicate and overly-long entries; renamed several emotes to fit the wheel's display width; removed redundant aliases where a shorter name already existed; added /boop
- **Emote tester** - Settings panel gains a "Test All Emotes" button (visible only while `/sew debug` is enabled) that iterates through every available emote, monitors `CHAT_MSG_TEXT_EMOTE` for confirmation, and prints a pass/fail/skipped summary to chat; position-only emotes (Sit, Stand, Sleep, Kneel, etc.) are pre-skipped
- **Emote token audit** - cross-referenced all `DoEmote` tokens against the official API reference (`API_DoEmote`)

### [1.0.3] - 2026-04-21

#### New Features and Changes

- **Classic support** - single codebase now runs on Classic Era, TBC Anniversary, and MoP Classic via flavor-specific TOC files (`_Mainline`, `_Classic`, `_TBC`, `_Mists`); Classic clients automatically receive a vanilla-safe icon and emote list
- **Theme overhaul** - all existing themes reworked from expansion art; 6 new themes added: Burning Crusade, Cataclysm, Warlords of Draenor, Battle for Azeroth, Shadowlands, and Dragonflight; all 12 themes ordered by expansion release date
- **Scrollable theme dropdown** - theme list capped at 5 visible rows with mousewheel scroll and scrollbar indicator
- **Scrollbar theming** - scrollbar track and thumb now update with the active color theme
- **Icon dropdown height cap** - icon picker now shows a maximum of 5 rows with mousewheel scroll and a scrollbar indicator, preventing it from falling off screen
- **Scrollbar indicator** - emote picker and icon dropdown both show a scrollbar thumb that tracks current scroll position
- **Click-away to close** - clicking anywhere outside an open dropdown now collapses it
- **Code refactor** - code refactor to streamline development

### [1.0.2] - 2026-04-21

#### New Features and Changes
- Updated TOC to support Patch 12.0.5

### [1.0.1] - 2026-04-18

#### New Features and Changes

- Slash commands expanded: `/sew help` & `/sew info` &`/sew reset`
- Shift+drag repositioning now works while the pie wheel is open
- Hub icon zoomed in 1.25x for a sharper look
- Left-click hub toggles pie only; right-click toggles Settings only - clean separation, both work regardless of pie state
- Settings "Reset Position" button renamed to **Position and Size** - resets both position and wheel size
- Code review pass to eliminate global namespace pollution and remove deprecated API calls

### [1.0.0] - 2026-04-17

#### Initial Launch

- 12-slice radial emote wheel with hover-to-highlight and click-to-emote
- Draggable trigger button with Shift+drag repositioning and saved position
- Right-click trigger to open the Settings panel
- Customisable emote slots - assign any of 135+ WoW emotes via a scrollable picker
- Reset to Default button restoring the original 12-slot loadout
- 6 colour themes: Classic, War Within, Pandaria, Midnight, Legion, Lich King
- 12 hub icon options
- Wheel Size slider (60-140, default 95)
- Reset Position button snapping the trigger to screen centre
- All settings persisted across sessions
]]

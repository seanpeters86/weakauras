## Contact Publik
- [**Twitter**](https://twitter.com/publikpriest)
- [**Twitch**](https://twitch.tv/publikpriest)
- Discord: **publik**
- [**Youtube**](https://www.youtube.com/c/Publikwow/featured)
- [**Patreon**](https://www.patreon.com/publik)
- [**Other class aura sets by Publik**](https://wago.io/H13J9PG4Q)

## Recommended Weak Auras
- [Cast Bar](https://wago.io/r1rYnOwTG)
- [Trinkets, Racials, and Potion](https://wago.io/OgwO-cI45)

## Configuration Notes
This aura pack uses a few Dynamic Groups to help organize auras. This is broken up into a few sections:
- Buff Alerts: Top of the screen display for important buffs, typically precombat ones
- Buffs: Real-time tracking of important buffs/debuffs at the top of the pack
- Grid: Holds the bulk of the auras and cooldowns to track.
- Defensives: Always shows your 2 most important defensive abilities on the left side of the grid
- Movement: Always shows your 2 most important movement abilities on the right side of the grid.

All of this is highly configurable, and you can move around any of the groups if you would prefer them be in different spots. The grid itself is the most customizable as you can automatically move the position of spells by simply changing the position they show in the `/wa` menu. The auras higher up on the list will be higher priority in the grid, and it will automatically adjust. This also makes it easy to add anything in the future.

You can adjust the custom grid settings if you would prefer a different configuration.

Several auras inside of the `Buffs` group might be disabled by default (`Load` tab -> `Never`). Feel free to tweak these based on the buffs that are most important for you to track. I have made some baseline assumptions but am by no means an expert in every spec.

## Adding the Fourth Row
By default only the first 17 icons to load will be shown in the Grid. If you would like to expand this to include more icons you can follow the steps below.

If you would like to add an additional row of icons you can edit the `CustomGrow` code inside the `Grid` group.

1. Select the `Grid - Spec` group
2. Navigate to the `Group` tab
3. Expand the `Custom Grow` Lua code
4. change `local rows = 3` to `local rows = 4`
5. change `local total = 17` to `local rows = 22`
6. Click `Done` in the bottom right

This will add a fourth row of icons with up to 5 additional slots.
# Pokémon Red and Blue and Green GBC [![Build Status][ci-badge]][ci]
This is a disassembly of Pokémon Red and Blue and Green.

It builds the following ROMs:

- Pokemon Red (UE) [S][!]
- Pokemon Blue (UE) [S][!]
- Pokemon Green (UE) [S][!]
- BLUEMONS.GB (debug build) 
- dmgapae0.e69.patch
- dmgapee0.e68.patch

Some FEATURES:
- 2 BRANCHES: ONE WITH RBY AUDIO AND 60 BAG SPACE, AND ONE WITH RBY/GSC AUDIO AND 20 BAG SPACE AND PORT PC
- Master Branch has Pokeyellow's Audio Options in Options menu.

- PLAY IN FULL COLOR
- Play with Gen 1 or Gen 2 Sprites
- Play with Gen 1 or Gen 2 Audio
- Play on regular overworld map or Snowy map... Change in Includes.asm from 0 to 1
- All Party Menu Icons now color as well... Change in Includes.asm for ALT Color
- GREEN: Features restored, SGB Border, Flowers, Overworld and more!
- Now you can Play Gen1 as a girl!
- All 151 Pokémons can be caught or evolved without trading
- Mew Under the Truck event restored
- NPC Tradeback Guy in CELADON MART 1F (evolve trade evolutions/ or evolve them level up)
- Now you can take both fossils in MT. MOON!
- Teams have mixed Pokémon (no more 5 pidgey teams)
- Aerodactyl / Omanyte / Kabuto level when revived now is 44, GIFT Lapras in Saffron now is level 34 / Eevee from Celadon Roof is 30.
- Gust is now a Flying Type instead of NORMAL
- IN-GAME MOVES LEARNSET POKEDEX
-  MOVEDEX IN POKEDEX
- Base Stats displayed in POKEDEX
- Can Now Surrender In Battle
- PC in DayCare
- GYM LEADER AND ELITE 4 REMATCHES POST GAME
- Can Obtain All Starters From NPCs Now (Like Yellow Version)
- Added Pokémon like Magmar / Electabuzz / Staryu and others to earlier routes (consult documentation) - Infinite TM's (they are reusable like newer gens)
- Gym Leaders, Rival, Rockets and other trainers had a buff in level, moves and parties (some parties to match Anime/Lets go Pikachu/References)
- Move Relearner added in Fuchsia - Move Deleter added in Vermilion (undeletable HMs)
- All overworld Pokémon icons have been updated (no more generic ones)
- Party Mini sprites have been updated - Caught Pokémon icon added in HUD Battle 
- Learnsets updated to match Pokemon Yellow updated one (eg. nidoran learns double kick at lower level) 
- Several POKÉMON had learnsets buffs (eg: Charizard Fly)
- Pikachu and Raichu can learn SURF through HM, just like in Yellow version
-  PROF. OAK gives you 5 POKÉBALLS when you receive the POKÉDEX.
- TM names in BAG and MART (TM24 it says TM24 THNDRBLT)
- 60 item bag space/ CrysAudio has 20 item bag space but (Port PC)
- Auto HM use (eg: surf, just touch the water and say YES)
- Deletable HM's - Sort Items in BAG 
- OAK Battle When Pokedex Is Complete
- Message when PC is full
- Check IV/DV - hold start/select and press STATS - EXP BAR - Caught Icon in battle 
- Moon Stone can be bought in Celadon Mart- Moon Stone can be bought in Celadon Mart
- Rockets Received a buff in levels and parties
- Reusable Repel B/W - KARATE CHOP is now a FIGHTING TYPE instead of NORMAL
- Gust is now a Flying Type instead of NORMAL
- Attack after waking up from Sleep 
- Sleep engine fixed (it works now like gen 2 - max 6 turns)
- Removed 25% chance for enemy stat down moves to miss 
- Swift will not hit throught Fly or Dig - Ghost now deals SUPER EFFECTIVE on Psychic Pokémon
- Can Push Up and Down on Stat Screen to switch Pokemon
- Can teleport inside buildings and caves
- Select Button to use Bicycle (If Obtained)
- Move Decription when learning moves
- SS Ticket, Lift Key, Card Key, Secret Key all disappear after use
- Buy more coins at once from shady clerk
- Trainers have unique movesets
- Mew Glitch/Missingo Glitch Restored
- Lapras Sprites swims now in Fuchsia City
- EXP All can now be turned on or off when obtained


CREDITS: IF ANYONE IS MISSED PLEASE LET ME KNOW. IT’S HARD TO KEEP TRACK OF ALL CREDITS SINCE THIS HACK WAS STARTED BY ONE PERSON AND THEN FINISHED/TAKEN OVER BY ANOTHER…. BUT WE WILL GLADLY ADD YOU IN 😊.

- Pret and Pret Discord. Tons of nice people, advice and are the reason I started this project.
- Dannye- For his amazing work on Pret with the disassembly. Used his EXP Bar, and a lot of other features he created. Also gave a lot of insight and explained things at a slow pace. He created so many features I can’t keep track. But I will gladly add in any and all for you!!! Thank You for the help!
- Vortiene- For sprites, updates/code from PURERGB, Bag Space increase, Shorter elevator time, and explanation on confusing parts of code. Thank You for feeling like your available 24/7.
- JoJoBear13- for his using his Trainer AI code along with Vortienes, Pokeyellows backport of the audio and a lot of QOL features from Shin-PokeRed. The female sprite is based on his original girl character. We kept it.
- RainbowMetalPigeon- For the Port PC code, and again for the help and patience with building this game. TRY HIS EXTREME YELLOW.
-CRZ-Shadows- and Yellow Legacy Team: A lot of QOL changes came from ideas or code used in there game. See their Github for all there amazing changes.
- JustRegularLuna/Mateo: A lot of sprites for Pokemon and Pokeball sprites used from her amazing game RED++. Move Description code and others
- THOTH33- Helping give Old Man his own palette color in the catching tutorial
- DarthBR
- Dreams897
- Engezertorung
- Mauvesea
- JA2398
- Alion
- ELRT
- SCORP MILLER
- TUXMAN
- BEEFSTEW
- HYD
- BlueZangoose
- Engezerstorung- Some color work
- Rangi42- PRET/ N64 Tileset
- Drenn- PRET- Color changes
- Wdpx_Phoenix
- MegaMan-Omega- overworld sprites
- ZetaPhoenix
- EVERYONE WHO PLAYED THIS GAME AND AGAIN DISCORD!!


To set up the repository, see [**INSTALL.md**](INSTALL.md).
USE RGBDS 7.0 or 8.0

## See also

- [**Wiki**][wiki] (includes [tutorials][tutorials])
- [**Symbols**][symbols]

You can find Pret [Discord (pret, #pokered)](https://discord.gg/d5dubZ3).

CREAMELDUDJAFAR'S DISCORD: https://discord.gg/3YQrCFzCNv

For other pret projects, see [pret.github.io](https://pret.github.io/).

[wiki]: https://github.com/pret/pokered/wiki
[tutorials]: https://github.com/pret/pokered/wiki/Tutorials
[symbols]: https://github.com/pret/pokered/tree/symbols
[ci]: https://github.com/pret/pokered/actions
[ci-badge]: https://github.com/pret/pokered/actions/workflows/main.yml/badge.sv

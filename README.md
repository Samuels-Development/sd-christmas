# sd-christmaspack

![Christsmas Script](https://cdn.discordapp.com/attachments/860120883296993290/1050705633453821992/Christmas_Script.png "Christsmas Script")

Please Consider checking out my other work here on GitHub or on my Store & Discord @
https://samuels-development.tebex.io & https://discord.gg/samueldev

If you encounter any issues/bugs etc. you'd like adressed, make sure to join my discord and ask for support in the appropriate chat(s) or make an issue here on GitHub!

# Common Issue
- Restarting the resource whilst in-game will break the prop spawns!

# Showcase
https://www.youtube.com/watch?v=9AASphfXmXk
-- Blips for the candy cane spawns are purely for testing purposes and aren't in the actual resource!

# Requirments
- qb-core
- qb-menu
- qb-target

# Installation

Step 1: Add sd-christmas into your resources folder (and ensure it if needed in your server.cfg)

Step 2: Add the following items into your qb-core/shared/items.lua:

	['candycane'] 				 	 = {['name'] = 'candycane', 			  	    ['label'] = 'Candy Cane', 			    ['weight'] = 500, 		['type'] = 'item', 		['image'] = 'candycane.png', 			['unique'] = false, 	['useable'] = false, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'A Candy Cane'},
	['giftbox_small'] 				     = {['name'] = 'giftbox_small', 			  	  	['label'] = 'Small Present', 			    ['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'giftbox_small.png', 			    ['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'A Small Present packed with gifts..'},
	['giftbox_medium'] 				 	 = {['name'] = 'giftbox_medium', 			  	  	['label'] = 'Medium Present', 			    ['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'giftbox_medium.png', 			    ['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'A Small Present packed with gifts..'},
	['giftbox_large'] 				 	 = {['name'] = 'giftbox_large', 			  	  	['label'] = 'Large Present', 			    ['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'giftbox_large.png', 			    ['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'A Small Present packed with gifts..'},

Now you're done and ready to start collecting!


# Credits

BzZz 🐝#9999 - https://bzzz.tebex.io/ (For allowing me to give out one of there props, that was also edited for me..)
marcinhu#0001 - https://marcinhu.tebex.io/ (For giving me the idea and helping out by sending some of the coordinates for his script..) 

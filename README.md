# sd-christmas

Collect candy canes and exchange them for Gifts with randomized loot in them!

Please Consider checking out my other work here on GitHub or on my Store & Discord @ 
https://fivem.samueldev.shop & https://discord.gg/samueldev

# Showcase
https://www.youtube.com/watch?v=9AASphfXmXk 
-- Blips for the candy cane spawns are purely for testing purposes and aren't in the actual resource!

# Installation
Step 1: Add sd-christmas into your resources folder (and ensure it if needed in your server.cfg)

Step 2: Add the following items into your qb-core/shared/items.lua:

	['candycane'] 				 	 = {['name'] = 'candycane', 			  	    ['label'] = 'Candy Cane', 			    ['weight'] = 500, 		['type'] = 'item', 		['image'] = 'candycane.png', 			['unique'] = false, 	['useable'] = false, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'A Candy Cane'},
	['giftbox_small'] 				     = {['name'] = 'giftbox_small', 			  	  	['label'] = 'Small Present', 			    ['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'giftbox_small.png', 			    ['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'A Small Present packed with gifts..'},
	['giftbox_medium'] 				 	 = {['name'] = 'giftbox_medium', 			  	  	['label'] = 'Medium Present', 			    ['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'giftbox_medium.png', 			    ['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'A Small Present packed with gifts..'},
	['giftbox_large'] 				 	 = {['name'] = 'giftbox_large', 			  	  	['label'] = 'Large Present', 			    ['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'giftbox_large.png', 			    ['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'A Small Present packed with gifts..'},


Or if you're using ESX, add them to your database...

Step: 3 You're good to go!

# Credits
BzZz 🐝#9999 - https://bzzz.tebex.io/ (For allowing me to give out one of there props, that was also edited for me..) marcinhu#0001 - https://marcinhu.tebex.io/ (For giving me the idea and helping out by sending some of the coordinates for his script..)

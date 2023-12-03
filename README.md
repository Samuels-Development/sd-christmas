# sd-christmas

![image_2023-12-03_191405375](https://github.com/Samuels-Development/sd-christmas/assets/99494967/f09ec324-6de7-4dec-aa35-d23e6971250e)
---

Fairly basic script that I initially released a year ago but have since, almost fully rewritten. TL;DR, go around and collect candy canes and exchange them at the Gift Shop for different tiers of presents. These presents will give you random item(s).

Please Consider checking out my other work here on GitHub or on my Store & Discord @ 
https://fivem.samueldev.shop & https://discord.gg/samueldev

# Disclaimer
Restarting the resource, without relogging, will break the candy cane spawns.

# Showcase
[**Video Preview**](https://www.youtube.com/watch?v=9AASphfXmXk) 
-- The preview is from last year, but even now, the script is essentially the same.

![FiveM_b2944_GTAProcess_OLEwowbHXu](https://github.com/Samuels-Development/sd-christmas/assets/99494967/48db88fe-c3e0-47ba-88bd-b1ec6ba483f5)



# Requirements
- qb-core or es_extended
- ox_lib

# Installation
Step 1: Add sd-christmas into your resources folder (and ensure it if needed in your server.cfg)

Step 2: Add the following items into your qb-core/shared/items.lua:

	['candycane'] 				 	 = {['name'] = 'candycane', 			  	    ['label'] = 'Candy Cane', 			    ['weight'] = 500, 		['type'] = 'item', 		['image'] = 'candycane.png', 			['unique'] = false, 	['useable'] = false, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'A Candy Cane'},
	['giftbox_small'] 				     = {['name'] = 'giftbox_small', 			  	  	['label'] = 'Small Present', 			    ['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'giftbox_small.png', 			    ['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'A Small Present packed with gifts..'},
	['giftbox_medium'] 				 	 = {['name'] = 'giftbox_medium', 			  	  	['label'] = 'Medium Present', 			    ['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'giftbox_medium.png', 			    ['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'A Medium Present packed with gifts..'},
	['giftbox_large'] 				 	 = {['name'] = 'giftbox_large', 			  	  	['label'] = 'Large Present', 			    ['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'giftbox_large.png', 			    ['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'A Large Present packed with gifts..'},


Or if you're using ESX, run the SQL found in the SQL/ESX directory.

# Credits
BzZz 🐝#9999 - https://bzzz.tebex.io/ (For allowing me to give out one of there props, that was also edited for me..) 
marcinhu#0001 - https://marcinhu.tebex.io/ (For giving me the idea and helping out by sending some of the coordinates for his script..)

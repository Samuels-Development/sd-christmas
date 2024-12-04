# sd-christmas

`sd-christmas` is a unique and intuitive script where players can collect candy canes from over 150 pre-configured locations (you can easily add more). These candy canes will respawn after a set time (refer to the config). Furthermore, you can talk to Santa to exchange your candy canes for gift boxes that have random rewards and work towards milestones that reward you with rare items, more gift boxes, and/or money!

## Preview
![FiveM_b3095_GTAProcess_WiexfAstQc](https://github.com/user-attachments/assets/e42de29c-3931-4cb0-86d1-cb5c8ae3f054)
![FiveM_b3095_GTAProcess_Q9ZjtlHbMC](https://github.com/user-attachments/assets/45a60acd-5898-444e-b764-e78c3cb2cc69)
![FiveM_b3095_GTAProcess_yWbJxEFzD3](https://github.com/user-attachments/assets/ecf33002-9494-474a-8cdd-e7e69ea33b34)
![FiveM_b3095_GTAProcess_cty1wyXF9E](https://github.com/user-attachments/assets/091d9159-9689-4ee1-af4a-45ba2f45058a)

## 🔔 Contact

Author: Samuel#0008  
Discord: [Join the Discord](https://discord.gg/FzPehMQaBQ)  
Store: [Click Here](https://fivem.samueldev.shop)

## 💾 Installation

1. Download the latest release from the [GitHub repository](https://github.com/Samuels-Development/sd-christmas/releases).
2. Extract the downloaded file and rename the folder to `sd-christmas`.
3. Place the `sd-christmas` folder into your server's `resources` directory.
4. Add `ensure sd-christmas` to your `server.cfg` to ensure the resource starts with your server.
5. Add the necessary items to your `qb-core/shared/items.lua` or if you're on ESX, you can run the provided `[SQL]/[ESX]/items.sql`
```lua
['candycane'] 				 	 = {['name'] = 'candycane', 			  	    ['label'] = 'Candy Cane', 			    ['weight'] = 500, 		['type'] = 'item', 		['image'] = 'candycane.png', 			['unique'] = false, 	['useable'] = false, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'A Candy Cane'},
['giftbox_small'] 				     = {['name'] = 'giftbox_small', 			  	  	['label'] = 'Small Present', 			    ['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'giftbox_small.png', 			    ['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'A Small Present packed with gifts..'},
['giftbox_medium'] 				 	 = {['name'] = 'giftbox_medium', 			  	  	['label'] = 'Medium Present', 			    ['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'giftbox_medium.png', 			    ['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'A Medium Present packed with gifts..'},
['giftbox_large'] 				 	 = {['name'] = 'giftbox_large', 			  	  	['label'] = 'Large Present', 			    ['weight'] = 1000, 		['type'] = 'item', 		['image'] = 'giftbox_large.png', 			    ['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'A Large Present packed with gifts..'},
```
If you're using ox_inventory, then you have to add these to your `data/items.lua`
```lua
["candy_cane"] = {
    label = "Candy Cane",
    weight = 100,
    stack = true,
    close = true,
    consume = 0,
    description = "A festive candy cane. Collect them or trade them for gifts!",
    client = {
        image = "candy_cane.png",
    }
},

["giftbox_small"] = {
    label = "Small Present",
    weight = 1000,
    stack = false,
    close = true,
    consume = 0,
    description = "A Small Present packed with gifts.",
    client = {
        image = "giftbox_small.png",
    },
    server = {
        export = 'sd-christmas.useGiftbox_small'
    }
},

["giftbox_medium"] = {
    label = "Medium Present",
    weight = 1000,
    stack = false,
    close = true,
    consume = 0,
    description = "A Medium Present packed with gifts.",
    client = {
        image = "giftbox_medium.png",
    },
    server = {
        export = 'sd-christmas.useGiftbox_medium'
    }
},

["giftbox_large"] = {
    label = "Large Present",
    weight = 1000,
    stack = false,
    close = true,
    consume = 0,
    description = "A Large Present packed with gifts.",
    client = {
        image = "giftbox_large.png",
    },
    server = {
        export = 'sd-christmas.useGiftbox_large'
    }
},
```

## 📖 Dependencies

- qb-core or es_extended
- ox_lib & [sd_lib](https://github.com/Samuels-Development/sd_lib/releases)

# Credits
BzZz 🐝#9999 - https://bzzz.tebex.io/ (For allowing me to give out one of there props, that was also edited for me..) 

Config = {}

SD.Locale.LoadLocale('en') -- Load the locale language, if available. You can change 'en' to any other available language in the locales folder.

-- General Settings
Config.RewardItem = "candy_cane"
Config.RespawnTime = 600 -- Seconds

-- Candy Cane Ped Settings
Config.Ped = {
    Enable = true, -- If enabled, the candy cane shop ped will spawn at the location below.
    Location = {
        {x = -769.74, y = -24.77, z = 41.08, w = 209.31},
        -- Add more locations as needed (Will Randomize from available locations each script start)
    },
    Model = "a_m_m_prolhost_01",
    Interaction = {
        Icon = "fas fa-circle",
        Distance = 3.0,
    },
    Scenario = "WORLD_HUMAN_STAND_IMPATIENT" -- Full list of scenarios @ https://pastebin.com/6mrYTdQv
}

-- Blip Creation for Candy Cane Ped if he's enabled
Config.PedBlip = {
    Enable = true,  -- Set to false to disable blip creation
    Sprite = 89,    -- Sprite/Icon for the blip
    Display = 4,     -- Display type
    Scale = 0.6,     -- Scale of the blip
    Colour = 6,      -- Colour of the blip
    Name = "Candy Cane Shop"  -- Name of the blip
}

Config.NumRewards = 1 -- Set the desired number of rewards for all gift boxes (eg. if set to two, it will give out two random rewards from the list below)

Config.GiftBoxes = {
    [1] = {
        name_key = "small_giftbox",
        item = "giftbox_small",
        cost = 5,
        rewards = {
            {
                item = "lockpick",
                amount = 1
            },
            {
                item = "drill",
                amount = 1
            },
            {
                item = "oxy",
                amount = 4
            },
        }
    },
    [2] = {
        name_key = "medium_giftbox",
        item = "giftbox_medium",
        cost = 10,
        rewards = {
            {
                item = "advancedlockpick",
                amount = 2
            },
            {
                item = "thermite",
                amount = 1
            },
            {
                item = "nitrous",
                amount = 2
            },
        }
    },
    [3] = {
        name_key = "large_giftbox",
        item = "giftbox_large",
        cost = 20,
        rewards = {
            {
                item = "tunerlaptop",
                amount = 1
            },
            {
                item = "cryptostick",
                amount = 1
            },
        }
    }
}

Config.Milestones = {
    [1] = {
        title_key = "milestone_10_canes",
        required_count = 10,
        reward = {
            type = "money",
            money_type = "cash",
            amount = 5000
        }
    },
    [2] = {
        title_key = "milestone_25_canes",
        required_count = 25,
        reward = {
            type = "money",
            money_type = "cash",
            amount = 5000
        }
    },
    [3] = {
        title_key = "milestone_50_canes",
        required_count = 50,
        reward = {
            type = "item",
            item = "giftbox_large",
            amount = 1
        }
    },
    -- Add more milestones as needed
}

Config.CandyCanes = {
    [1] = {
        location = vector3(170.93, -984.38, 29.09),
        heading = 334.49,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [2] = {
        location = vector3(-532.97, 464.34, 102.19),
        heading = 329.56,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [3] = {
        location = vector3(-595.24, 529.8, 106.76),
        heading = 25.16,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [4] = {
        location = vector3(-679.02, 511.95, 112.53),
        heading = 21.52,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [5] = {
        location = vector3(-762.24, 430.86, 99.2),
        heading = 202.97,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [6] = {
        location = vector3(-873.48, 562.65, 95.62),
        heading = 312.66,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [7] = {
        location = vector3(-952.16, 600.8, 108.3),
        heading = 36.34,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [8] = {
        location = vector3(-1095.53, 601.0, 102.06),
        heading = 28.36,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [9] = {
        location = vector3(-1307.76, 477.36, 96.65),
        heading = 105.37,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [10] = {
        location = vector3(-1455.21, 534.46, 118.37),
        heading = 75.92,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [11] = {
        location = vector3(-1500.42, 523.05, 117.27),
        heading = 44.19,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [12] = {
        location = vector3(308.73, -903.01, 28.29),
        heading = 353.77,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [13] = {
        location = vector3(455.97, -967.81, 29.71),
        heading = 83.02,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [14] = {
        location = vector3(452.99, -889.32, 27.22),
        heading = 359.94,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [15] = {
        location = vector3(428.97, -799.06, 28.85),
        heading = 311.39,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [16] = {
        location = vector3(437.61, -623.04, 27.71),
        heading = 270.51,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [17] = {
        location = vector3(142.55, -1044.5, 28.37),
        heading = 342.46,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [18] = {
        location = vector3(-175.52, -1288.56, 30.3),
        heading = 277.43,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [19] = {
        location = vector3(-314.19, -1340.8, 30.34),
        heading = 278.55,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [20] = {
        location = vector3(-302.32, -1461.67, 30.0),
        heading = 32.01,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [21] = {
        location = vector3(-318.0, -1542.91, 26.69),
        heading = 162.72,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [22] = {
        location = vector3(1697.98, 3584.13, 34.55),
        heading = 34.77,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [23] = {
        location = vector3(1613.63, 3570.05, 34.43),
        heading = 123.9,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [24] = {
        location = vector3(1408.3, 3619.55, 33.89),
        heading = 103.2,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [25] = {
        location = vector3(1413.1, 3645.07, 33.42),
        heading = 125.65,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [26] = {
        location = vector3(1279.35, 3624.8, 32.04),
        heading = 183.05,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [27] = {
        location = vector3(1529.94, 3778.29, 33.51),
        heading = 44.49,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [28] = {
        location = vector3(1708.6, 3845.01, 33.92),
        heading = 229.03,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [29] = {
        location = vector3(1809.38, 3907.14, 32.76),
        heading = 22.88,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [30] = {
        location = vector3(1841.58, 3926.71, 32.02),
        heading = 285.29,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [31] = {
        location = vector3(1879.82, 3921.76, 32.21),
        heading = 93.99,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [32] = {
        location = vector3(1987.91, 3791.03, 32.18),
        heading = 301.4,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [33] = {
        location = vector3(200.71, 6626.63, 30.56),
        heading = 138.96,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [34] = {
        location = vector3(99.28, 6619.08, 31.48),
        heading = 49.51,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [35] = {
        location = vector3(31.1, 6608.61, 31.45),
        heading = 79.11,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [36] = {
        location = vector3(-9.03, 6652.78, 30.11),
        heading = 228.65,
        model = "bzzz_xmas_script_lollipop_a"
    },
    -- Help!
    [37] = {
        location = vector3(-74.79, 6559.56, 30.49),
        heading = 138.65,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [38] = {
        location = vector3(-102.58, 6532.6, 28.81),
        heading = 228.89,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [39] = {
        location = vector3(-170.42, 6450.26, 30.5),
        heading = 139.99,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [40] = {
        location = vector3(-214.71, 6396.09, 32.09),
        heading = 226.05,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [41] = {
        location = vector3(-267.08, 6354.26, 31.49),
        heading = 234.71,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [42] = {
        location = vector3(-335.44, 6306.27, 31.48),
        heading = 131.64,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [43] = {
        location = vector3(-403.06, 6163.31, 30.5),
        heading = 150.62,
        model = "bzzz_xmas_script_lollipop_a"
    },
    -- New Additions:
    [44] = {
        location = vector3(-68.09, -1112.0, 25.75),
        heading = 278.55,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [45] = {
        location = vector3(-85.33, -1321.67, 28.27),
        heading = 32.01,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [46] = {
        location = vector3(212.23, -811.41, 29.77),
        heading = 162.72,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [47] = {
        location = vector3(282.74, -933.35, 29.29),
        heading = 34.77,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [48] = {
        location = vector3(209.77, -935.84, 30.69),
        heading = 123.9,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [49] = {
        location = vector3(1408.3, 3619.55, 33.89),
        heading = 103.2,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [50] = {
        location = vector3(56.44, -1737.76, 28.59),
        heading = 125.65,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [51] = {
        location = vector3(27.93, -1771.64, 28.61),
        heading = 183.05,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [52] = {
        location = vector3(115.73, -1954.23, 19.75),
        heading = 44.49,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [53] = {
        location = vector3(87.24, -1956.96, 19.75),
        heading = 229.03,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [54] = {
        location = vector3(-59.96, -1750.66, 28.31),
        heading = 22.88,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [55] = {
        location = vector3(-121.95, -1485.92, 32.82),
        heading = 285.29,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [56] = {
        location = vector3(-205.65, -1382.25, 31.26),
        heading = 93.99,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [57] = {
        location = vector3(-263.28, -976.12, 30.22),
        heading = 301.4,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [58] = {
        location = vector3(-285.96, -923.74, 30.08),
        heading = 138.96,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [59] = {
        location = vector3(-349.1, -825.5, 30.51),
        heading = 49.51,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [60] = {
        location = vector3(300.43, -579.93, 42.26),
        heading = 79.11,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [61] = {
        location = vector3(-46.78, -908.95, 28.53),
        heading = 228.65,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [62] = {
        location = vector3(-62.71, -913.54, 28.41),
        heading = 138.65,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [63] = {
        location = vector3(-690.04, -887.34, 23.5),
        heading = 228.89,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [64] = {
        location = vector3(-599.08, -933.28, 22.86),
        heading = 139.99,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [65] = {
        location = vector3(-1080.17, -1650.89, 3.44),
        heading = 226.05,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [66] = {
        location = vector3(-1111.27, -1600.5, 4.62),
        heading = 234.71,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [67] = {
        location = vector3(1122.14, -657.61, 55.76),
        heading = 131.64,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [68] = {
        location = vector3(945.01, -649.61, 58.03),
        heading = 150.62,
        model = "bzzz_xmas_script_lollipop_a"
    },
    -- New Additions:
    [69] = {
        location = vector3(70.6, -1567.93, 28.6),
        heading = 278.55,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [70] = {
        location = vector3(-48.99, -1453.85, 31.99),
        heading = 32.01,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [71] = {
        location = vector3(-277.05, -1918.89, 28.95),
        heading = 162.72,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [72] = {
        location = vector3(277.83, -1821.02, 25.93),
        heading = 34.77,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [73] = {
        location = vector3(343.77, -1693.91, 31.53),
        heading = 123.9,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [74] = {
        location = vector3(551.03, -1895.23, 25.4),
        heading = 103.2,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [75] = {
        location = vector3(945.92, -1745.9, 30.18),
        heading = 125.65,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [76] = {
        location = vector3(964.02, -1454.61, 30.29),
        heading = 183.05,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [77] = {
        location = vector3(1229.32, -1282.65, 34.24),
        heading = 44.49,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [78] = {
        location = vector3(1199.52, -503.25, 64.08),
        heading = 229.03,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [79] = {
        location = vector3(1346.42, -546.83, 72.91),
        heading = 22.88,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [80] = {
        location = vector3(1365.34, -605.97, 73.38),
        heading = 285.29,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [81] = {
        location = vector3(1231.74, -366.36, 68.09),
        heading = 93.99,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [82] = {
        location = vector3(1115.71, -349.69, 66.0),
        heading = 301.4,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [83] = {
        location = vector3(1051.09, -504.73, 62.29),
        heading = 138.96,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [84] = {
        location = vector3(854.72, -557.53, 56.62),
        heading = 49.51,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [85] = {
        location = vector3(125.78, -206.43, 53.6),
        heading = 79.11,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [86] = {
        location = vector3(311.03, -230.86, 53.01),
        heading = 228.65,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [87] = {
        location = vector3(329.25, -190.59, 53.23),
        heading = 138.65,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [88] = {
        location = vector3(-1.63, -77.53, 60.32),
        heading = 228.89,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [89] = {
        location = vector3(-91.83, -66.37, 56.02),
        heading = 139.99,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [90] = {
        location = vector3(-364.21, -149.33, 37.24),
        heading = 226.05,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [91] = {
        location = vector3(-969.93, -1093.88, 1.15),
        heading = 234.71,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [92] = {
        location = vector3(-882.71, -1070.59, 1.16),
        heading = 131.64,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [93] = {
        location = vector3(-1082.91, -1140.15, 1.16),
        heading = 150.62,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [94] = {
        location = vector3(-1085.25, -1037.05, 1.15),
        heading = 138.65,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [95] = {
        location = vector3(-964.4, -937.52, 1.15),
        heading = 228.89,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [96] = {
        location = vector3(-1113.22, -971.46, 1.15),
        heading = 139.99,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [97] = {
        location = vector3(-1174.18, -1109.06, 1.62),
        heading = 226.05,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [98] = {
        location = vector3(-1804.44, -1178.31, 12.02),
        heading = 234.71,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [99] = {
        location = vector3(-1791.91, -1200.09, 12.02),
        heading = 131.64,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [100] = {
        location = vector3(-1832.51, -1213.32, 12.02),
        heading = 150.62,
        model = "bzzz_xmas_script_lollipop_a"
    },
    -- New New Additions:
    [101] = {
        location = vector3(-1656.89, -545.19, 33.37),
        heading = 285.29,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [102] = {
        location = vector3(-1618.91, -439.75, 38.35),
        heading = 93.99,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [103] = {
        location = vector3(-1492.47, -233.87, 49.44),
        heading = 301.4,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [104] = {
        location = vector3(-1373.42, -157.58, 45.61),
        heading = 138.96,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [105] = {
        location = vector3(-1380.77, -251.26, 42.13),
        heading = 49.51,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [106] = {
        location = vector3(-1462.0, -358.62, 42.89),
        heading = 79.11,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [107] = {
        location = vector3(-1460.29, -377.86, 37.93),
        heading = 228.65,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [108] = {
        location = vector3(-1403.34, -463.5, 33.48),
        heading = 138.65,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [109] = {
        location = vector3(-1292.81, -411.4, 34.45),
        heading = 228.89,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [110] = {
        location = vector3(-1085.35, -262.37, 36.77),
        heading = 139.99,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [111] = {
        location = vector3(-1370.78, 67.23, 52.92),
        heading = 226.05,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [112] = {
        location = vector3(-1199.72, 187.31, 64.0),
        heading = 234.71,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [113] = {
        location = vector3(-1068.32, 56.22, 50.05),
        heading = 131.64,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [114] = {
        location = vector3(-1076.1, -138.38, 39.79),
        heading = 150.62,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [115] = {
        location = vector3(-1107.18, -194.21, 37.23),
        heading = 138.65,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [116] = {
        location = vector3(-723.91, -69.39, 40.75),
        heading = 228.89,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [117] = {
        location = vector3(-946.25, -184.97, 40.88),
        heading = 139.99,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [118] = {
        location = vector3(-788.94, -248.88, 36.05),
        heading = 226.05,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [119] = {
        location = vector3(-719.45, -298.17, 35.95),
        heading = 234.71,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [120] = {
        location = vector3(-664.39, -234.28, 36.04),
        heading = 131.64,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [121] = {
        location = vector3(-75.43, -819.22, 325.18),
        heading = 150.62,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [122] = {
        location = vector3(54.23, -1325.78, 28.31),
        heading = 79.11,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [123] = {
        location = vector3(-23.69, -1637.21, 28.3),
        heading = 228.65,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [124] = {
        location = vector3(-122.03, -1770.59, 28.82),
        heading = 138.65,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [125] = {
        location = vector3(319.13, -1290.1, 30.22),
        heading = 228.89,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [126] = {
        location = vector3(-599.08, -933.28, 22.86),
        heading = 139.99,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [127] = {
        location = vector3(198.12, -1279.84, 28.32),
        heading = 226.05,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [128] = {
        location = vector3(-1111.27, -1600.5, 4.62),
        heading = 234.71,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [129] = {
        location = vector3(189.52, -1109.98, 28.29),
        heading = 131.64,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [130] = {
        location = vector3(414.4, -934.83, 28.42),
        heading = 150.62,
        model = "bzzz_xmas_script_lollipop_a"
    },
    -- New Additions:
    [131] = {
        location = vector3(357.52, -834.13, 28.29),
        heading = 278.55,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [132] = {
        location = vector3(216.36, -813.32, 29.66),
        heading = 32.01,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [133] = {
        location = vector3(47.37, -796.51, 30.59),
        heading = 162.72,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [134] = {
        location = vector3(-84.96, -1035.09, 27.1),
        heading = 34.77,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [135] = {
        location = vector3(-62.44, -1122.85, 24.87),
        heading = 123.9,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [136] = {
        location = vector3(130.6, -1297.99, 28.23),
        heading = 103.2,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [137] = {
        location = vector3(25.76, -1349.93, 28.33),
        heading = 125.65,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [138] = {
        location = vector3(-98.55, -1385.04, 28.33),
        heading = 183.05,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [139] = {
        location = vector3(158.65, -1431.23, 28.24),
        heading = 44.49,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [140] = {
        location = vector3(154.28, -1567.21, 28.3),
        heading = 229.03,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [141] = {
        location = vector3(175.94, -1542.92, 28.26),
        heading = 22.88,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [142] = {
        location = vector3(336.59, -1745.78, 28.48),
        heading = 285.29,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [143] = {
        location = vector3(166.99, -1795.8, 28.21),
        heading = 93.99,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [144] = {
        location = vector3(99.07, -1714.52, 29.11),
        heading = 301.4,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [145] = {
        location = vector3(100.24, -1916.8, 19.97),
        heading = 138.96,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [146] = {
        location = vector3(46.04, -1910.26, 20.8),
        heading = 49.51,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [147] = {
        location = vector3(-57.04, -1771.66, 28.01),
        heading = 79.11,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [148] = {
        location = vector3(-62.02, -1777.45, 27.96),
        heading = 228.65,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [149] = {
        location = vector3(-93.62, -1658.11, 28.31),
        heading = 138.65,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [150] = {
        location = vector3(-0.76, -1449.9, 29.54),
        heading = 228.89,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [151] = {
        location = vector3(-115.21, -1500.39, 32.92),
        heading = 139.99,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [152] = {
        location = vector3(-242.34, -1410.43, 30.15),
        heading = 226.05,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [153] = {
        location = vector3(-296.36, -1253.39, 27.86),
        heading = 234.71,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [154] = {
        location = vector3(-324.61, -960.97, 30.08),
        heading = 131.64,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [155] = {
        location = vector3(-349.91, -901.33, 30.07),
        heading = 150.62,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [156] = {
        location = vector3(-355.84, -706.18, 31.41),
        heading = 138.65,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [157] = {
        location = vector3(-297.8, -639.42, 32.28),
        heading = 228.89,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [158] = {
        location = vector3(-225.29, -259.54, 48.76),
        heading = 139.99,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [159] = {
        location = vector3(-239.35, -250.51, 48.7),
        heading = 226.05,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [160] = {
        location = vector3(-237.18, -230.12, 48.87),
        heading = 234.71,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [161] = {
        location = vector3(19.96, -124.22, 55.05),
        heading = 131.64,
        model = "bzzz_xmas_script_lollipop_a"
    },
    [162] = {
        location = vector3(307.07, -272.22, 52.95),
        heading = 150.62,
        model = "bzzz_xmas_script_lollipop_a"
    },
}

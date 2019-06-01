Config = {}
Config.Locale = 'es'
Config.NumberOfCopsRequired = 0

Banks = {
	["fleeca"] = {
		position = { ['x'] = 148.91908752441, ['y'] = -1050.7448242188, ['z'] = 29.36802482605 }, -- position of robbery, when you have tu use the item "blowtorch"
		hackposition = { ['x'] = 147.04908752441, ['y'] = -1044.9448242188, ['z'] = 29.36802482605 }, -- position where you have to do hack with the minigame to open a door
		--hackteleport = { ['x'] = 148.79908752441, ['y'] = -1045.5748242188, ['z'] = 29.36802482605 }, -- ignore this
		reward = math.random(15000,25000), -- the random range of amount of money you will get for robbery this site
		nameofbank = "Fleeca Bank", --Visual Name that will be the site
		lastrobbed = 0, -- DONT TOUCH THIS variable used to make a delay to robb other time
		doortype = 'V_ILEV_GB_VAULDR' -- Name or ID of the gameobject that will be rotate to make the open efect, you can check what id or name you need here: https://objects.gt-mp.net/ if you dont find it, contact with you developer, he will know how to get it in game
	},
	["fleeca2"] = {
		position = { ['x'] = -2954.2874804688, ['y'] = 486.14476367188, ['z'] = 15.697026252747 }, --2957.6674804688
		hackposition = { ['x'] = -2957.6674804688, ['y'] = 481.45776367188, ['z'] = 15.697026252747 },
		
		reward = math.random(15000,25000),
		nameofbank = "Fleeca Bank (Highway)",
		lastrobbed = 0,
		doortype = 'hei_prop_heist_sec_door'
	},
	--[[["blainecounty"] = {
		position = { ['x'] = -107.06505584717, ['y'] = 6474.8012695313, ['z'] = 31.62670135498 },
		hackposition = { ['x'] = -107.06505584717, ['y'] = 6474.8012695313, ['z'] = 31.62670135498 },
		reward = math.random(15000,25000),
		nameofbank = "Blaine County Savings",
		lastrobbed = 0
	},--]]
	
	["PrincipalBank"] = {
		position = { ['x'] = 264.99899291992, ['y'] = 213.50576782227, ['z'] = 101.68346405029 },
		hackposition = { ['x'] = 261.49499291992, ['y'] = 223.06776782227, ['z'] = 106.28346405029 },
        bombposition = { ['x'] = 254.12199291992, ['y'] = 225.50576782227, ['z'] = 101.87346405029 }, -- if this var is set will appear a site to plant a bomb which will open the door defined at var "bombdoortype"
		reward = math.random(3000000,50000000),
		nameofbank = "Principal bank",
		lastrobbed = 0,
        bombdoortype = 'v_ilev_bk_vaultdoor', -- If this var is set you will need set the var "bombposition" to work properly , you can find the name or id here: https://objects.gt-mp.net/  if you dont find it, contact with your devs
        doortype = 'hei_v_ilev_bk_gate2_pris'
    },

}


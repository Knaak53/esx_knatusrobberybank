# esx_knatusrobberybank


- Please, consider to support me if you like [my work here](https://paypal.me/knatus)


### Description

This is a complete rework of robbery system to ESX framework at FiveM writed in Lua under GNU V3 license, is important to know you can modify, use and do want you want with this EXCEPT distribute it under a private version, do not matter if you modify it or not, if you do modify it, publish it or create a new branch here.

## Dependencies

This resource need the following resources to work properly:

 - EssentialMode
 - es_extended
 - esx_doorlock
 - esx_knatusblowtorch (A personal modification from esx_borrmaskin)
 - mhacking 
 
 esx_knatusblowtorch link https://github.com/Knaak53/esx_knatusblowtorch
 
## Lang
 This resource include a lang config to translate it, dont touch the code for that (If find cant translate it, create a issue, pls)
 
## Installation

use git clone or download it to your esx folder.

write this in your server.cfg

 - start esx_doorlock ## if you dont have it
 - start esx_knatusblowtorch
 - start mhacking ## if you dont have it
 - start esx_knatusrobberybank

 - import the sql at your table items at your database (to add the 3 items needed, 2 for fleeca banks)

# Common FAQ

## The central bank door is opened by default

You have to add this configuration to your esx_doorlock config file:

```	
{
	objName = 'hei_v_ilev_bk_gate2_pris',
	objCoords  = {x = 261.99899291992, y = 221.50576782227, z = 106.68346405029},
	textCoords = {x = 261.99899291992, y = 221.50576782227, z = 107.68346405029},
	authorizedJobs = { 'police' },
	locked = true,
	distance = 12,
	size = 2
},
 ```


